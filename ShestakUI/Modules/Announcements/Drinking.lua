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
	if UnitIsEnemy("player", unit) and (spellID == 118358 or spellID == 104270) then
		SendChatMessage(UnitName(unit)..L_MISC_DRINKING, "PARTY")
	end
end)