local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Announce Feasts/Cauldrons/Souls/Repair Bots/Portals/Ritual of Summoning
----------------------------------------------------------------------------------------
local function CanRaidWarning()
	if GetNumGroupMembers() == 0 or not GetNumGroupMembers() then return false end
	return (UnitIsGroupLeader("player") or UnitIsRaidOfficer("player")) and true or false
end

local function GetChat()
	if GetNumGroupMembers() > 0 then
		return CanRaidWarning() and "RAID_WARNING" or "RAID"
	elseif GetNumSubgroupMembers() > 0 then
		return "PARTY"
	end
	return "SAY"
end

local function InGroup()
	return (GetNumSubgroupMembers() > 0 or GetNumGroupMembers() > 0) and true or false
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, event, _, subEvent, _, _, srcName, _, _, _, _, _, _, spellID, ...)
	if not InGroup() or InCombatLockdown() or not subEvent or not spellID or not srcName then return end
	if not UnitInRaid(srcName) and not UnitInParty(srcName) then return end

	if subEvent == "SPELL_CAST_START" then
		-- Feasts/Cauldrons
		if C.announcements.feasts and (T.AnnounceFeasts[spellID] or T.AnnounceCauldrons[spellID]) then
			SendChatMessage(string.format("%s has prepared a %s.", srcName, GetSpellLink(spellID)), GetChat())
		-- Refreshment Table
		elseif C.announcements.feasts and spellID == 43987 then
			SendChatMessage(string.format("%s has prepared a %s.", srcName, GetSpellLink(spellID)), GetChat())
		end
	elseif subEvent == "SPELL_SUMMON" then
		-- Repair Bots
		if C.announcements.feasts and T.AnnounceBots[spellID] then
			SendChatMessage(string.format("%s has put down a %s.", srcName, GetSpellLink(spellID)), GetChat())
		end
	elseif subEvent == "SPELL_CREATE" then
		-- Ritual of Souls
		if C.announcements.feasts and spellID == 29893 then
			SendChatMessage(string.format("%s has put down a %s.", srcName, GetSpellLink(spellID)), GetChat())
		-- Toys
		elseif C.announcements.toy_train and T.AnnounceToys[spellID] then
			SendChatMessage(string.format("%s has put down a %s.", srcName, GetSpellLink(spellID)), GetChat())
		-- Portals
		elseif C.announcements.portals and T.AnnouncePortals[spellID] then
			SendChatMessage(string.format("%s is casting %s.", srcName, GetSpellLink(spellID)), GetChat())
		end
	elseif subEvent == "SPELL_CAST_SUCCESS" then
		-- Ritual of Summoning
		if C.announcements.portals and spellID == 698 then
			SendChatMessage(string.format("%s is casting %s. Click!", srcName, GetSpellLink(spellID)), GetChat())
		end
	end
end)