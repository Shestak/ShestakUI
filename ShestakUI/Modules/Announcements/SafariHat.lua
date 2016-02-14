local T, C, L, _ = unpack(select(2, ...))
if C.announcements.safari_hat ~= true then return end

----------------------------------------------------------------------------------------
--	Check Safari Hat
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PET_BATTLE_OPENING_DONE")
frame:SetScript("OnEvent", function()
	local name = GetSpellInfo(158486)
	if PlayerHasToy(92738) and not UnitAura("player", name) then
		PlaySound("RaidWarning", "master")
		RaidNotice_AddMessage(RaidWarningFrame, RESISTANCE_NONE.." "..GetSpellLink(158486).."!", ChatTypeInfo["RAID_WARNING"])
		print("|cffff3300"..RESISTANCE_NONE.." "..GetSpellLink(158486).."|cffff3300!|r")
	end
end)