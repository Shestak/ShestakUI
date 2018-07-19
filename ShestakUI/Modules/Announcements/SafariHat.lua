local T, C, L, _ = unpack(select(2, ...))
if C.announcements.safari_hat ~= true then return end

----------------------------------------------------------------------------------------
--	Check Safari Hat
----------------------------------------------------------------------------------------
local function CheckUnitBuff(IsSpellId)
	for i = 1, 40, 1 do
		local name, icon, _, _, _, _, _, _, _, spellID = UnitBuff("player", i)
		if not name then break end
		if IsSpellId == spellID then
			return i
		end
	end
	return nil
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PET_BATTLE_OPENING_DONE")
frame:SetScript("OnEvent", function()
	if PlayerHasToy(92738) and not CheckUnitBuff(158486) then
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