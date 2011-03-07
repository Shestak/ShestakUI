local T, C, L = unpack(select(2, ...))
if not C.misc.auto_resurrection == true then return end

----------------------------------------------------------------------------------------
--	Auto resurection
----------------------------------------------------------------------------------------
local WINTERGRASP = L_ZONE_WINTERGRASP

local autoreleasepvp = CreateFrame("Frame")
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