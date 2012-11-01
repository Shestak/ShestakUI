local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
if T.coauthor ~= true then return end

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

local frame = CreateFrame("FRAME")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(_, event, _, subEvent, _, _, player, _, _, _, target, _, _, spell, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then 
		if player == T.name and spell == 108968 then
			SendChatMessage(string.format("Внимание! Обмен здоровьем с %s! %s", target, GetSpellLink(spell)), GetChat())
		end
		if subEvent == "SPELL_CREATE" then
			if spell == 126499 then 
			SendChatMessage(string.format("%s готовит %s, кушайте, товарищи хилеры!", player, GetSpellLink(spell)), GetChat())
			elseif spell == 105193 then
			SendChatMessage(string.format("%s готовит %s, кушайте, товарищи рейдеры!", player, GetSpellLink(spell)), GetChat())
			end
		end
	end
end)
