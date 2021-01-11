local T, C, L, _ = unpack(select(2, ...))
if C.announcements.feasts ~= true and C.announcements.portals ~= true and C.announcements.toys ~= true then return end

----------------------------------------------------------------------------------------
--	Announce Feasts/Souls/Repair Bots/Portals/Ritual of Summoning
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function()
	if not IsInGroup() or InCombatLockdown() then return end
	local _, subEvent, _, _, srcName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
	if not subEvent or not spellID or not srcName then return end
	if not UnitInRaid(srcName) and not UnitInParty(srcName) then return end

	local srcName = srcName:gsub("%-[^|]+", "")
	if subEvent == "SPELL_CAST_SUCCESS" then
		-- Feasts and Cauldron
		if C.announcements.feasts and T.AnnounceFeast[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Refreshment Table
		elseif C.announcements.feasts and spellID == 43987 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Ritual of Summoning
		elseif C.announcements.portals and spellID == 698 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_CLICK, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		-- Piccolo of the Flaming Fire
		elseif C.announcements.toys and spellID == 182346 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_USE, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		end
	elseif subEvent == "SPELL_SUMMON" then
		-- Repair Bots and Codex
		if C.announcements.feasts and T.AnnounceBots[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), T.CheckChat(true))
		end
	elseif subEvent == "SPELL_CREATE" then
		-- Healthstone and MOLL-E
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