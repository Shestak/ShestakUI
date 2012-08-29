local T, C, L = unpack(select(2, ...))
if C.aura.player_auras ~= true then return end

----------------------------------------------------------------------------------------
--	Buffs duration in consolidated buff window (ShowConsolidatedBuffDuration by Hoochie)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	local curframe
	local title = "ConsolidatedBuffsTooltipBuff"
	for i = 1, NUM_LE_RAID_BUFF_TYPES do
		curframe = CreateFrame("Cooldown", title..i.."Duration", _G[title..i])

		curframe:SetAllPoints(_G[title..i].icon)
		curframe:SetReverse(true)

		_G[title..i]:HookScript("OnShow", function()
			local _, _, _, WholeDur, EndTime = GetRaidBuffTrayAuraInfo(i)

			if EndTime then
				_G[title..i.."Duration"]:SetCooldown(EndTime - WholeDur, WholeDur)
			end
		end)
	end
	frame:UnregisterAllEvents()
end)