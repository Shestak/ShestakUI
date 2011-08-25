local T, C, L = unpack(select(2, ...))
if C.announcements.spells ~= true then return end

----------------------------------------------------------------------------------------
--	Announce same spells
----------------------------------------------------------------------------------------
local misdir_announce = CreateFrame("Frame")
misdir_announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
misdir_announce:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID = ...
	local inInstance, instanceType = IsInInstance()
	if not (event == "SPELL_CAST_SUCCESS" and (inInstance and (instanceType == "raid" or instanceType == "party"))) then return end

	if C.announcements.spells_from_all == true then
		if not (destName and sourceName) then return end

		if spellID == 34477 or spellID == 19801 or spellID == 57934 or spellID == 355 or spellID == 20484 or spellID == 633 then
			if GetRealNumRaidMembers() > 0 then
				SendChatMessage(GetSpellLink(spellID)..": "..sourceName.." -> "..destName, "RAID")
			elseif GetRealNumPartyMembers() > 0 and not UnitInRaid("player") then
				SendChatMessage(GetSpellLink(spellID)..": "..sourceName.." -> "..destName, "PARTY")
			else
				SendChatMessage(GetSpellLink(spellID)..": "..sourceName.." -> "..destName, "SAY")
			end
		end
	else
		if not (sourceGUID == UnitGUID("player") and destName) then return end

		if spellID == 34477 or spellID == 19801 or spellID == 57934 or spellID == 355 or spellID == 20484 or spellID == 633 then
			if GetRealNumRaidMembers() > 0 then
				SendChatMessage(GetSpellLink(spellID).." -> "..destName, "RAID")
			elseif GetRealNumPartyMembers() > 0 and not UnitInRaid("player") then
				SendChatMessage(GetSpellLink(spellID).." -> "..destName, "PARTY")
			else
				SendChatMessage(GetSpellLink(spellID).." -> "..destName, "SAY")
			end
		end
	end
end)