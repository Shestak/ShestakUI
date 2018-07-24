local T, C, L, _ = unpack(select(2, ...))
if C.announcements.safari_hat ~= true then return end

----------------------------------------------------------------------------------------
--	Check Safari Hat
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PET_BATTLE_OPENING_DONE")
frame:SetScript("OnEvent", function()
	local name = GetSpellInfo(158486)
	if PlayerHasToy(92738) and not T.CheckPlayerBuff(name) then
		local maxlevel = true
		for i = 1, 3 do
			local level = C_PetBattles.GetLevel(1, i)
			if level and level < 25 then
				maxlevel = false
			end
		end
		if maxlevel then return end
		PlaySound(SOUNDKIT.RAID_WARNING, "master")
		RaidNotice_AddMessage(RaidWarningFrame, RESISTANCE_NONE.." "..GetSpellLink(158486).."!", ChatTypeInfo["RAID_WARNING"])
		print("|cffff3300"..RESISTANCE_NONE.." "..GetSpellLink(158486).."|cffff3300!|r")
	end
end)