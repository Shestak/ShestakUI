local T, C, L, _ = unpack(select(2, ...))
if C.aura.player_auras ~= true then return end

----------------------------------------------------------------------------------------
--	Buffs duration in consolidated buff window(ShowConsolidatedBuffDuration by Hoochie)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	local curframe
	local title = "ConsolidatedBuffsTooltipBuff"
	for i = 1, NUM_LE_RAID_BUFF_TYPES do
		curframe = CreateFrame("Cooldown", title..i.."Duration", _G[title..i], "CooldownFrameTemplate")

		curframe:SetAllPoints(_G[title..i].icon)
		curframe:SetReverse(true)
		curframe:SetDrawEdge(false)

		_G[title..i]:HookScript("OnShow", function()
			local _, _, _, WholeDur, EndTime = GetRaidBuffTrayAuraInfo(i)

			if EndTime then
				_G[title..i.."Duration"]:SetCooldown(EndTime - WholeDur, WholeDur)
			end
		end)
	end
	frame:UnregisterAllEvents()
end)

----------------------------------------------------------------------------------------
--	Skin consolidated buffs icon and tooltip
----------------------------------------------------------------------------------------
ConsolidatedBuffsTooltip:SetScale(1)

for i = 1, NUM_LE_RAID_BUFF_TYPES do
	local buff = ConsolidatedBuffsTooltip["Buff"..i]

	buff.label:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
	buff.label:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

	buff.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	local bg = CreateFrame("Frame", nil, buff)
	bg:SetPoint("TOPLEFT", buff.icon, -2, 2)
	bg:SetPoint("BOTTOMRIGHT", buff.icon, 2, -2)
	bg:SetFrameLevel(buff:GetFrameLevel() - 1)
	bg:SetTemplate("Default")
end