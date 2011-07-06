local T, C, L = unpack(select(2, ...))
if C.announcements.drinking ~= true then return end

----------------------------------------------------------------------------------------
--	Announce enemy drinking in arena(by Duffed)
----------------------------------------------------------------------------------------
local drinking_announce = CreateFrame("Frame")
drinking_announce:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
drinking_announce:SetScript("OnEvent", function(self, event, ...)
	if not (event == "UNIT_SPELLCAST_SUCCEEDED" and GetZonePVPInfo() == "arena") then return end

	local unit, _, _, _, spellID = ...
	if UnitIsEnemy("player", unit) and (spellID == 80167 or spellID == 94468 or spellID == 43183 or spellID == 57073) then
		SendChatMessage(UnitName(unit)..L_MISC_DRINKING, "PARTY")
	end
end)