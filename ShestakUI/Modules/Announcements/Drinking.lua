local T, C, L, _ = unpack(select(2, ...))
if C.announcements.drinking ~= true then return end

----------------------------------------------------------------------------------------
--	Announce enemy drinking in arena(by Duffed)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:SetScript("OnEvent", function(self, event, ...)
	if not (event == "UNIT_SPELLCAST_SUCCEEDED" and GetZonePVPInfo() == "arena") then return end

	local unit, _, _, _, spellID = ...
	if UnitIsEnemy("player", unit) and (GetSpellInfo(spellID) == GetSpellInfo(118358) or GetSpellInfo(spellID) == GetSpellInfo(167152) or GetSpellInfo(spellID) == GetSpellInfo(167268)) then
		SendChatMessage(UnitClass(unit).." "..UnitName(unit)..L_MISC_DRINKING, T.CheckChat(true))
	end
end)