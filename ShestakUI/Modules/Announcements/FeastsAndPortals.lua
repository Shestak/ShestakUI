local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Announce Feasts/Souls/Repair Bots/Portals/Ritual of Summoning
----------------------------------------------------------------------------------------
local function GetChat()
	if IsInRaid() then
		if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
			return "RAID_WARNING"
		else
			return "RAID"
		end
	elseif IsInGroup() then
		return "PARTY"
	end
	return "SAY"
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, event, _, subEvent, _, _, srcName, _, _, _, _, _, _, spellID, ...)
	if not (IsInRaid() or IsInGroup()) or InCombatLockdown() or not subEvent or not spellID or not srcName then return end
	if not UnitInRaid(srcName) and not UnitInParty(srcName) then return end

	if subEvent == "SPELL_CAST_START" then
		-- Feasts
		if C.announcements.feasts and T.AnnounceFeasts[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), GetChat())
		-- Refreshment Table
		elseif C.announcements.feasts and spellID == 43987 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), GetChat())
		end
	elseif subEvent == "SPELL_SUMMON" then
		-- Repair Bots
		if C.announcements.feasts and T.AnnounceBots[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), GetChat())
		end
	elseif subEvent == "SPELL_CREATE" then
		-- Ritual of Souls and MOLL-E
		if C.announcements.feasts and (spellID == 29893 or spellID == 54710) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), GetChat())
		-- Toys
		elseif C.announcements.toys and T.AnnounceToys[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), GetChat())
		-- Portals
		elseif C.announcements.portals and T.AnnouncePortals[spellID] then
			SendChatMessage(string.format(L_ANNOUNCE_FP_CAST, srcName, GetSpellLink(spellID)), GetChat())
		end
	elseif subEvent == "SPELL_CAST_SUCCESS" then
		-- Ritual of Summoning
		if C.announcements.portals and spellID == 698 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_CLICK, srcName, GetSpellLink(spellID)), GetChat())
		end
		-- Piccolo of the Flaming Fire
		if C.announcements.toys and spellID == 18400 then
			SendChatMessage(string.format(L_ANNOUNCE_FP_USE, srcName, GetSpellLink(spellID)), GetChat())
		end
	elseif subEvent == "SPELL_AURA_APPLIED" then
		-- Turkey Feathers and Party G.R.E.N.A.D.E.
		if C.announcements.toys and (spellID == 61781 or (spellID == 51508 or spellID == 51510)) then
			SendChatMessage(string.format(L_ANNOUNCE_FP_USE, srcName, GetSpellLink(spellID)), GetChat())
		end
	end
end)