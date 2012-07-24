local T, C, L = unpack(select(2, ...))
if C.aura.player_auras ~= true then return end

----------------------------------------------------------------------------------------
--	Style player buff(by Tukz)
----------------------------------------------------------------------------------------
local mainhand, _, _, offhand = GetWeaponEnchantInfo()
local rowbuffs = 16

local GetFormattedTime = function(s)
	if s >= 86400 then
		return format("%dd", floor(s / 86400 + 0.5))
	elseif s >= 3600 then
		return format("%dh", floor(s / 3600 + 0.5))
	elseif s >= 60 then
		return format("%dm", floor(s / 60 + 0.5))
	end
	return floor(s + 0.5)
end

local BuffsAnchor = CreateFrame("Frame", "BuffsAnchor", UIParent)
BuffsAnchor:SetPoint(unpack(C.position.player_buffs))
BuffsAnchor:Size((15 * C.aura.player_buff_size) + 42, (C.aura.player_buff_size * 2) + 3)

ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:Point("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
ConsolidatedBuffs:Size(C.aura.player_buff_size)
ConsolidatedBuffs.SetPoint = T.dummy
ConsolidatedBuffs:CreateBackdrop("Default")
ConsolidatedBuffs.backdrop:SetAllPoints()
if C.aura.classcolor_border == true then
	ConsolidatedBuffs.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
end

ConsolidatedBuffsIcon:SetTexture("Interface\\Icons\\Spell_ChargePositive")
ConsolidatedBuffsIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
ConsolidatedBuffsIcon:Size(C.aura.player_buff_size - 4)

ConsolidatedBuffsCount:Point("BOTTOMRIGHT", 0, 1)
ConsolidatedBuffsCount:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
ConsolidatedBuffsCount:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

for i = 1, 2 do
	local buff = _G["TempEnchant"..i]
	local icon = _G["TempEnchant"..i.."Icon"]
	local border = _G["TempEnchant"..i.."Border"]
	local duration = _G["TempEnchant"..i.."Duration"]

	if border then border:Hide() end

	buff:Size(C.aura.player_buff_size)
	buff:CreateBackdrop("Default")
	buff.backdrop:SetAllPoints()
	if C.aura.classcolor_border == true then
		buff.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	end

	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:Point("TOPLEFT", buff, 2, -2)
	icon:Point("BOTTOMRIGHT", buff, -2, 2)

	duration:ClearAllPoints()
	duration:Point("CENTER", 2, 1)
	duration:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
	duration:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

	_G["TempEnchant2"]:ClearAllPoints()
	_G["TempEnchant2"]:Point("RIGHT", _G["TempEnchant1"], "LEFT", -3, 0)
end

local function StyleBuffs(buttonName, index, debuff)
	local buff = _G[buttonName..index]
	local icon = _G[buttonName..index.."Icon"]
	local border = _G[buttonName..index.."Border"]
	local duration = _G[buttonName..index.."Duration"]
	local count = _G[buttonName..index.."Count"]

	if border then border:Hide() end

	if icon and not buff.isSkinned then
		buff:Size(C.aura.player_buff_size)
		buff:CreateBackdrop("Default")
		buff.backdrop:SetAllPoints()
		if C.aura.classcolor_border == true then
			buff.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
		end

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:Point("TOPLEFT", buff, 2, -2)
		icon:Point("BOTTOMRIGHT", buff, -2, 2)

		duration:ClearAllPoints()
		duration:Point("CENTER", 2, 1)
		duration:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		duration:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

		count:ClearAllPoints()
		count:Point("BOTTOMRIGHT", 0, 1)
		count:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

		buff.isSkinned = true
	end
end

local function UpdateFlash(self, elapsed)
	local index = self:GetID()
	self:SetAlpha(1)
end

local function UpdateDuration(auraButton, timeLeft)
	local duration = auraButton.duration
	if timeLeft and C.aura.show_timer == true then
		duration:SetFormattedText(GetFormattedTime(timeLeft))
		duration:SetVertexColor(1, 1, 1)
		duration:Show()
	else
		duration:Hide()
	end
end

local function UpdateBuffAnchors()
	local buttonName = "BuffButton"
	local buff, previousBuff, aboveBuff
	local numBuffs = 0
	local numAuraRows = 0
	local slack = BuffFrame.numEnchants
	local mainhand, _, _, offhand = GetWeaponEnchantInfo()

	if ShouldShowConsolidatedBuffFrame() then
		slack = slack + 1
	end

	for index = 1, BUFF_ACTUAL_DISPLAY do
		StyleBuffs(buttonName, index, false)
		local buff = _G[buttonName..index]
		if not buff.consolidated then
			numBuffs = numBuffs + 1
			index = numBuffs + slack
			buff:ClearAllPoints()
			if (index > 1) and (mod(index, rowbuffs) == 1) then
				numAuraRows = numAuraRows + 1
				if index == rowbuffs + 1 then
					buff:Point("TOP", ConsolidatedBuffs, "BOTTOM", 0, -3)
				else
					buff:Point("TOP", aboveBuff, "BOTTOM", 0, -3)
				end
				aboveBuff = buff
			elseif index == 1 then
				numAuraRows = 1
				buff:Point("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
			else
				if numBuffs == 1 then
					if mainhand and offhand and not UnitHasVehicleUI("player") then
						buff:Point("RIGHT", TempEnchant2, "LEFT", -3, 0)
					elseif ((mainhand and not offhand) or (offhand and not mainhand)) and not UnitHasVehicleUI("player") then
						buff:Point("RIGHT", TempEnchant1, "LEFT", -3, 0)
					else
						buff:Point("TOPRIGHT", ConsolidatedBuffs, "TOPLEFT", -3, 0)
					end
				else
					buff:Point("RIGHT", previousBuff, "LEFT", -3, 0)
				end
			end
			previousBuff = buff
		end
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	_G[buttonName..index]:Hide()
end

local function UpdateEnchantAnchors()
	_G["TempEnchant1"]:ClearAllPoints()
	_G["TempEnchant1"]:Point("RIGHT", ConsolidatedBuffs, "LEFT", -5, 0)
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)
hooksecurefunc("AuraButton_UpdateDuration", UpdateDuration)
hooksecurefunc("AuraButton_OnUpdate", UpdateFlash)