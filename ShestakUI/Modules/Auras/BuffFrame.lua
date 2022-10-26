local T, C, L, _ = unpack(select(2, ...))
if C.aura.player_auras ~= true then return end

----------------------------------------------------------------------------------------
--	Style player buff(by Tukz)
----------------------------------------------------------------------------------------
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
BuffsAnchor:SetSize((15 * C.aura.player_buff_size) + 42, (C.aura.player_buff_size * 2) + 3)

--BETA TemporaryEnchantFrame:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)

-- _G["TempEnchant2"]:ClearAllPoints()
-- _G["TempEnchant2"]:SetPoint("RIGHT", _G["TempEnchant1"], "LEFT", -3, 0)

-- for i = 1, NUM_TEMP_ENCHANT_FRAMES do
	-- local buff = _G["TempEnchant"..i]
	-- local icon = _G["TempEnchant"..i.."Icon"]
	-- local border = _G["TempEnchant"..i.."Border"]
	-- local duration = _G["TempEnchant"..i.."Duration"]

	-- if border then border:Hide() end

	-- if i ~= 3 then
		-- buff:SetTemplate("Default")
		-- if C.aura.classcolor_border == true then
			-- buff:SetBackdropBorderColor(unpack(C.media.classborder_color))
		-- end
	-- end

	-- buff:SetSize(C.aura.player_buff_size, C.aura.player_buff_size)

	-- icon:CropIcon()
	-- icon:SetDrawLayer("BORDER")

	-- duration:ClearAllPoints()
	-- duration:SetPoint("CENTER", 2, 1)
	-- duration:SetDrawLayer("ARTWORK")
	-- duration:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
	-- duration:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
-- end

local function StyleBuffs(buttonName, index)
	local buff = _G[buttonName..index]
	local icon = _G[buttonName..index.."Icon"]
	local border = _G[buttonName..index.."Border"]
	local duration = _G[buttonName..index.."Duration"]
	local count = _G[buttonName..index.."Count"]

	if border then border:Hide() end

	if icon and not buff.isSkinned then
		buff:SetTemplate("Default")
		if C.aura.classcolor_border == true then
			buff:SetBackdropBorderColor(unpack(C.media.classborder_color))
		end

		buff:SetSize(C.aura.player_buff_size, C.aura.player_buff_size)

		icon:CropIcon()
		icon:SetDrawLayer("BORDER")

		duration:ClearAllPoints()
		duration:SetPoint("CENTER", 2, 1)
		duration:SetDrawLayer("ARTWORK")
		duration:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		duration:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

		if not buff.timer then
			buff.timer = buff:CreateAnimationGroup()
			buff.timerAnim = buff.timer:CreateAnimation()
			buff.timerAnim:SetDuration(0.1)

			buff.timer:SetScript("OnFinished", function(self, requested)
				if not requested then
					if buff.timeLeft and C.aura.show_timer == true then
						buff.duration:SetFormattedText(GetFormattedTime(buff.timeLeft))
						buff.duration:SetVertexColor(1, 1, 1)
					else
						self:Stop()
					end
					self:Play()
				end
			end)
			buff.timer:Play()
		end

		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 2, 0)
		count:SetDrawLayer("ARTWORK")
		count:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

		buff.isSkinned = true
	end
end

local function UpdateBuffAnchors()
	local buttonName = "BuffButton"
	local previousBuff, aboveBuff
	local numBuffs = 0
	local slack = BuffFrame.numEnchants
	local mainhand, _, _, _, offhand = GetWeaponEnchantInfo()

	for index = 1, BUFF_ACTUAL_DISPLAY do
		StyleBuffs(buttonName, index)
		local buff = _G[buttonName..index]
		numBuffs = numBuffs + 1
		index = numBuffs + slack
		buff:ClearAllPoints()
		if (index > 1) and (mod(index, rowbuffs) == 1) then
			buff:SetPoint("TOP", aboveBuff, "BOTTOM", 0, -3)
			aboveBuff = buff
		elseif index == 1 then
			buff:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
			aboveBuff = buff
		else
			if numBuffs == 1 then
				if mainhand and offhand and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant2, "LEFT", -3, 0)
					aboveBuff = TempEnchant1
				elseif ((mainhand and not offhand) or (offhand and not mainhand)) and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant1, "LEFT", -3, 0)
					aboveBuff = TempEnchant1
				else
					buff:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
				end
			else
				buff:SetPoint("RIGHT", previousBuff, "LEFT", -3, 0)
			end
		end
		previousBuff = buff
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	_G[buttonName..index]:Hide()
end

-- hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
-- hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)

function AuraButton_UpdateDuration(buff, timeLeft)
	local name = buff:GetName()
	if not strmatch(name, "TempEnchant") then return end

	buff.timeLeft = timeLeft
	if not buff.timerEnchant then
		buff.timerEnchant = buff:CreateAnimationGroup()
		buff.timerAnim = buff.timerEnchant:CreateAnimation()
		buff.timerAnim:SetDuration(0.1)

		buff.timerEnchant:SetScript("OnFinished", function(self, requested)
			if not requested then
				if buff.timeLeft and C.aura.show_timer == true then
					buff.duration:SetFormattedText(GetFormattedTime(buff.timeLeft))
					buff.duration:SetVertexColor(1, 1, 1)
					buff.duration:Show()
				else
					self:Stop()
				end
				self:Play()
			end
		end)
		buff.timerEnchant:Play()
	end
end

BuffFrame:SetScript("OnUpdate", nil) -- Disable BuffFrame_OnUpdate that change alpha