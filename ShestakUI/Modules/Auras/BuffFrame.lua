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

local function UpdateDuration(aura, timeLeft)
	local duration = T.newPatch and aura.Duration or aura.duration
	if timeLeft and C.aura.show_timer == true then
		duration:SetVertexColor(1, 1, 1)
		duration:SetFormattedText(GetFormattedTime(timeLeft))
	else
		duration:Hide()
	end
end

if not T.newPatch then
	hooksecurefunc(BuffButtonMixin, "UpdateDuration", function(aura, timeLeft)
		UpdateDuration(aura, timeLeft)
	end)

	hooksecurefunc(TempEnchantButtonMixin, "UpdateDuration", function(aura, timeLeft)
		UpdateDuration(aura, timeLeft)
	end)
end

hooksecurefunc(BuffFrame.AuraContainer, "UpdateGridLayout", function(self, auras)
	local previousBuff, aboveBuff
	for index, aura in ipairs(auras) do
		aura:SetSize(C.aura.player_buff_size, C.aura.player_buff_size)
		aura:SetTemplate("Default")

		if T.newPatch then
			aura.TempEnchantBorder:SetAlpha(0)
			hooksecurefunc(aura.TempEnchantBorder, "Show", function(self)
				aura:SetBackdropBorderColor(0.6, 0.1, 0.6)
			end)

			hooksecurefunc(aura.TempEnchantBorder, "Hide", function(self)
				if C.aura.classcolor_border == true then
					aura:SetBackdropBorderColor(unpack(C.media.classborder_color))
				else
					aura:SetBackdropBorderColor(unpack(C.media.border_color))
				end
			end)
		else
			if aura.Border then
				aura.Border:SetAlpha(0)
				aura:SetBackdropBorderColor(0.6, 0.1, 0.6)
			else
				if C.aura.classcolor_border == true then
					aura:SetBackdropBorderColor(unpack(C.media.classborder_color))
				else
					aura:SetBackdropBorderColor(unpack(C.media.border_color))
				end
			end
		end

		aura:ClearAllPoints()
		if (index > 1) and (mod(index, rowbuffs) == 1) then
			aura:SetPoint("TOP", aboveBuff, "BOTTOM", 0, -3)
			aboveBuff = aura
		elseif index == 1 then
			aura:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
			aboveBuff = aura
		else
			aura:SetPoint("RIGHT", previousBuff, "LEFT", -3, 0)
		end

		previousBuff = aura

		aura.Icon:CropIcon()
		aura.Icon:SetDrawLayer("BORDER")

		local duration = T.newPatch and aura.Duration or aura.duration
		duration:ClearAllPoints()
		duration:SetPoint("CENTER", 2, 1)
		duration:SetDrawLayer("ARTWORK")
		duration:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		duration:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

		if T.newPatch and not aura.hook then
			hooksecurefunc(aura, "UpdateDuration", function(aura, timeLeft)
				UpdateDuration(aura, timeLeft)
			end)
			aura.hook = true
		end

		if aura.count then -- fix error in EditMode
			aura.count:ClearAllPoints()
			aura.count:SetPoint("BOTTOMRIGHT", 2, 0)
			aura.count:SetDrawLayer("ARTWORK")
			aura.count:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
			aura.count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
		end
	end
end)

-- Hide collapse button
BuffFrame.CollapseAndExpandButton:Kill()

-- Hide debuffs
DebuffFrame.AuraContainer:Hide()