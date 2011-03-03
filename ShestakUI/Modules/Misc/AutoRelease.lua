local T, C, L = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	Auto resurection
----------------------------------------------------------------------------------------
if C.misc.auto_resurrection ~= true then return end

local WINTERGRASP
WINTERGRASP = L_ZONE_WINTERGRASP

local autoreleasepvp = CreateFrame("frame")
autoreleasepvp:RegisterEvent("PLAYER_DEAD")
autoreleasepvp:SetScript("OnEvent", function(self, event)
	local soulstone = GetSpellInfo(20707)
	if (T.class ~= "SHAMAN") and not (soulstone and UnitBuff("player", soulstone)) then
		if (tostring(GetZoneText()) == WINTERGRASP) then
			RepopMe()
		end
		if MiniMapBattlefieldFrame.status == "active" then
			RepopMe()
		end
	end
end)