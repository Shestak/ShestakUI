local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Announce Feasts/Souls/Repair Bots/Portals/Ritual of Summoning
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self)
	local _, subEvent, _, _, srcName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
	if not IsInGroup() or InCombatLockdown() or not subEvent or not spellID or not srcName then return end
	if not UnitInRaid(srcName) and not UnitInParty(srcName) then return end

	local srcName = srcName:gsub("%-[^|]+", "")
	if subEvent == "SPELL_CAST_SUCCESS" then
		-- Feasts
		if C.announcements.feasts and (spellID == 126492 or spellID == 126494) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_STAT, srcName, GetSpellLink(spellID), SPELL_STAT1_NAME), T.CheckChat(true))
		elseif C.announcements.feasts and (spellID == 126495 or spellID == 126496) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_STAT, srcName, GetSpellLink(spellID), SPELL_STAT2_NAME), T.CheckChat(true))
		elseif C.announcements.feasts and (spellID == 126501 or spellID == 126502) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_STAT, srcName, GetSpellLink(spellID), SPELL_STAT3_NAME), T.CheckChat(true))
		elseif C.announcements.feasts and (spellID == 126497 or spellID == 126498) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_STAT, srcName, GetSpellLink(spellID), SPELL_STAT4_NAME), T.CheckChat(true))
		elseif C.announcements.feasts and (spellID == 126499 or spellID == 126500) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_STAT, srcName, GetSpellLink(spellID), SPELL_STAT5_NAME), T.CheckChat(true))
		elseif C.announcements.feasts and (spellID == 104958 or spellID == 105193 or spellID == 126503 or spellID == 126504 or spellID == 145166 or spellID == 145169 or spellID == 145196) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Spirit Cauldron
		elseif C.announcements.feasts and spellID == 188036 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Lavish Suramar Feast
		elseif C.announcements.feasts and spellID == 201352 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Refreshment Table
		elseif C.announcements.feasts and spellID == 43987 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Ritual of Summoning
		elseif C.announcements.portals and spellID == 698 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_CLICK, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Piccolo of the Flaming Fire
		elseif C.announcements.toys and spellID == 18400 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_USE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		end
	elseif subEvent == "SPELL_SUMMON" then
		-- Repair Bots
		if C.announcements.feasts and T.AnnounceBots[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		end
	elseif subEvent == "SPELL_CREATE" then
		-- Ritual of Souls and MOLL-E
		if C.announcements.feasts and (spellID == 29893 or spellID == 54710) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Toys
		elseif C.announcements.toys and T.AnnounceToys[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Portals
		elseif C.announcements.portals and T.AnnouncePortals[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_CAST, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		end
	elseif subEvent == "SPELL_AURA_APPLIED" then
		-- Turkey Feathers and Party G.R.E.N.A.D.E.
		if C.announcements.toys and (spellID == 61781 or ((spellID == 51508 or spellID == 51510) and destName == T.name)) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_USE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		end
	end
end)