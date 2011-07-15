local T, C, L = unpack(select(2, ...))
if C.announcements.spells ~= true then return end

----------------------------------------------------------------------------------------
--	Announce same spells
----------------------------------------------------------------------------------------
local misdir_announce = CreateFrame("Frame")
misdir_announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
misdir_announce:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, spellID = ...
	if not (event == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and destName) then return end

	if spellID == 34477 or spellID == 19801 or spellID == 57934 or spellID == 355 then
		if GetRealNumRaidMembers() > 0 then
			SendChatMessage(GetSpellLink(spellID).." -> "..destName, "RAID")
		elseif GetRealNumPartyMembers() > 0 and not UnitInRaid("player") then
			SendChatMessage(GetSpellLink(spellID).." -> "..destName, "PARTY")
		else
			SendChatMessage(GetSpellLink(spellID).." -> "..destName, "SAY")
		end
	end
end)