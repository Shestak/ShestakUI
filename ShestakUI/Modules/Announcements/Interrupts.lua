local T, C, L = unpack(select(2, ...))
if C.announcements.interrupts ~= true then return end

----------------------------------------------------------------------------------------
--	Announce your interrupts(by Elv22)
----------------------------------------------------------------------------------------
local interrupt_announce = CreateFrame("Frame")
interrupt_announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
interrupt_announce:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID = ...
	if not (event == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player")) then return end

	if GetNumGroupMembers() > 0 then
		SendChatMessage(INTERRUPTED.." "..destName..": "..GetSpellLink(spellID), "RAID")
	elseif GetNumSubgroupMembers() > 0 and not UnitInRaid("player") then
		SendChatMessage(INTERRUPTED.." "..destName..": "..GetSpellLink(spellID), "PARTY")
	else
		SendChatMessage(INTERRUPTED.." "..destName..": "..GetSpellLink(spellID), "SAY")
	end
end)