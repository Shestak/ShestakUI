local T, C, L = unpack(select(2, ...))
if not C.aura.player_auras == true then return end

----------------------------------------------------------------------------------------
--	Style player buff(by Tukz)
----------------------------------------------------------------------------------------
local mainhand, _, _, offhand, _, _, hand3 = GetWeaponEnchantInfo()
local rowbuffs = 16

local GetFormattedTime = function(s)
	if s >= 86400 then
		return format("%dd", floor(s/86400 + 0.5))
	elseif s >= 3600 then
		return format("%dh", floor(s/3600 + 0.5))
	elseif s >= 60 then
		return format("%dm", floor(s/60 + 0.5))
	end
	return floor(s + 0.5)
end

local BuffsAnchor = CreateFrame("Frame", "BuffsAnchor", UIParent)
BuffsAnchor:SetPoint(unpack(C.position.player_buffs))
BuffsAnchor:Size((15 * C.aura.player_buff_size) + 42, (C.aura.player_buff_size * 2) + 3)
BuffsAnchor:SetClampedToScreen(true)
BuffsAnchor:SetMovable(true)
BuffsAnchor:SetTemplate("Transparent")
BuffsAnchor:SetBackdropColor(0, 0, 0, 0)
BuffsAnchor:SetBackdropBorderColor(0, 0, 0, 0)
BuffsAnchor.iborder:SetBackdropBorderColor(0, 0, 0, 0)
BuffsAnchor.oborder:SetBackdropBorderColor(0, 0, 0, 0)
BuffsAnchor.text = BuffsAnchor:CreateFontString("BuffsAnchorText", "OVERLAY", nil)
BuffsAnchor.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
BuffsAnchor.text:SetPoint("CENTER")
	
ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:Point("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
ConsolidatedBuffs:Size(C.aura.player_buff_size, C.aura.player_buff_size)
ConsolidatedBuffs.SetPoint = T.dummy

ConsolidatedBuffsIcon:SetTexture("Interface\\Icons\\Spell_ChargePositive")
ConsolidatedBuffsIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
ConsolidatedBuffsIcon:Size(C.aura.player_buff_size - 4, C.aura.player_buff_size - 4)

local h = CreateFrame("Frame")
h:SetParent(ConsolidatedBuffs)
h:SetAllPoints(ConsolidatedBuffs)
h:SetFrameLevel(30)

ConsolidatedBuffsCount:SetParent(h)
ConsolidatedBuffsCount:Point("BOTTOMRIGHT", 0, 1)
ConsolidatedBuffsCount:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
ConsolidatedBuffsCount:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

local CBbg = CreateFrame("Frame", nil, ConsolidatedBuffs)
CBbg:SetTemplate("Default")
if C.aura.classcolor_border == true then
	CBbg:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
end
CBbg:Point("TOPLEFT", ConsolidatedBuffs, 0, 0)
CBbg:Point("BOTTOMRIGHT", ConsolidatedBuffs, 0, 0)
CBbg:SetFrameStrata("BACKGROUND")

for i = 1, 3 do
	local f = CreateFrame("Frame", nil, _G["TempEnchant"..i])
	f:CreatePanel("Default", C.aura.player_buff_size, C.aura.player_buff_size, "CENTER", _G["TempEnchant"..i], "CENTER", 0, 0)
	if C.aura.classcolor_border == true then
		f:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	end
	_G["TempEnchant"..i.."Border"]:Hide()
	_G["TempEnchant"..i.."Icon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	_G["TempEnchant"..i.."Icon"]:Point("TOPLEFT", _G["TempEnchant"..i], 2, -2)
	_G["TempEnchant"..i.."Icon"]:Point("BOTTOMRIGHT", _G["TempEnchant"..i], -2, 2)
	_G["TempEnchant"..i]:Height(C.aura.player_buff_size)
	_G["TempEnchant"..i]:Width(C.aura.player_buff_size)	
	_G["TempEnchant"..i.."Duration"]:ClearAllPoints()
	_G["TempEnchant"..i.."Duration"]:Point("CENTER", 2, 1)
	_G["TempEnchant"..i.."Duration"]:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
	_G["TempEnchant"..i.."Duration"]:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
end

local function StyleBuffs(buttonName, index, debuff)
	local buff = _G[buttonName..index]
	local icon = _G[buttonName..index.."Icon"]
	local border = _G[buttonName..index.."Border"]
	local duration = _G[buttonName..index.."Duration"]
	local count = _G[buttonName..index.."Count"]
	if icon and not _G[buttonName..index.."Panel"] then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:Point("TOPLEFT", buff, 2, -2)
		icon:Point("BOTTOMRIGHT", buff, -2, 2)
		
		buff:Height(C.aura.player_buff_size)
		buff:Width(C.aura.player_buff_size)
		
		duration:ClearAllPoints()
		duration:Point("CENTER", 2, 1)
		duration:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		duration:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
		
		count:ClearAllPoints()
		count:Point("BOTTOMRIGHT", 0, 1)
		count:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
		
		local panel = CreateFrame("Frame", buttonName..index.."Panel", buff)
		panel:CreatePanel("Default", C.aura.player_buff_size, C.aura.player_buff_size, "CENTER", buff, "CENTER", 0, 0)
		if C.aura.classcolor_border == true then
			panel:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
		end
		panel:SetFrameLevel(buff:GetFrameLevel() - 1)
		panel:SetFrameStrata(buff:GetFrameStrata())
	end
	if border then border:Hide() end
end

function UpdateFlash(self, elapsed)
	local index = self:GetID()
	self:SetAlpha(1)
end

local UpdateDuration = function(auraButton, timeLeft)
	local duration = auraButton.duration
	if SHOW_BUFF_DURATIONS == "1" and timeLeft and C.aura.show_timer == true then
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
	local slack = BuffFrame.numEnchants
	local mainhand, _, _, offhand, _, _, hand3 = GetWeaponEnchantInfo()
	if BuffFrame.numConsolidated > 0 then
		slack = slack + 1
	end
	for index = 1, BUFF_ACTUAL_DISPLAY do
		StyleBuffs(buttonName, index, false)
		local buff = _G[buttonName..index]
		
		if not buff.consolidated then	
			numBuffs = numBuffs + 1
			index = numBuffs + slack
			buff:ClearAllPoints()
			if ( (index > 1) and (mod(index, rowbuffs) == 1) ) then
 				if ( index == rowbuffs + 1 ) then
					buff:Point("TOP", ConsolidatedBuffs, "BOTTOM", 0, -3)
				else
					buff:Point("TOP", aboveBuff, "BOTTOM", 0, -3)
				end
				aboveBuff = buff
			elseif index == 1 then
				buff:Point("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
			else
				if numBuffs == 1 then
					if (mainhand and offhand and hand3) and not UnitHasVehicleUI("player") then
						buff:Point("RIGHT", TempEnchant3, "LEFT", -3, 0)
					elseif ((mainhand and offhand) or (mainhand and hand3) or (offhand and hand3)) and not UnitHasVehicleUI("player") then
						buff:Point("RIGHT", TempEnchant2, "LEFT", -3, 0)
					elseif ((mainhand and not offhand and not hand3) or (offhand and not mainhand and not hand3) or (hand3 and not mainhand and not offhand)) and not UnitHasVehicleUI("player") then
						buff:Point("RIGHT", TempEnchant1, "LEFT", -3, 0)
					else
						buff:Point("RIGHT", ConsolidatedBuffs, "LEFT", -3, 0)
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

-- Fixing the consolidated buff container size
local z = 0.79
local function UpdateConsolidatedBuffsAnchors()
	ConsolidatedBuffsTooltip:Width(min(BuffFrame.numConsolidated * C.aura.player_buff_size * z + 18, 4 * C.aura.player_buff_size * z + 18))
    ConsolidatedBuffsTooltip:Height(floor((BuffFrame.numConsolidated + 3) / 4 ) * C.aura.player_buff_size * z + CONSOLIDATED_BUFF_ROW_HEIGHT * z)
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)
hooksecurefunc("AuraButton_UpdateDuration", UpdateDuration)
hooksecurefunc("AuraButton_OnUpdate", UpdateFlash)
hooksecurefunc("ConsolidatedBuffs_UpdateAllAnchors", UpdateConsolidatedBuffsAnchors)