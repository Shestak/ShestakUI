----------------------------------------------------------------------------------------
--	Auto resurection
----------------------------------------------------------------------------------------
if SettingsCF.misc.auto_resurrection ~= true then return end

local WINTERGRASP
WINTERGRASP = L_ZONE_WINTERGRASP

local autoreleasepvp = CreateFrame("frame")
autoreleasepvp:RegisterEvent("PLAYER_DEAD")
autoreleasepvp:SetScript("OnEvent", function(self, event)
	local soulstone = GetSpellInfo(20707)
	if (SettingsDB.class ~= "SHAMAN") or not (soulstone and UnitBuff("player", soulstone)) then
		if (tostring(GetZoneText()) == WINTERGRASP) then
			RepopMe()
		end
		if MiniMapBattlefieldFrame.status == "active" then
			RepopMe()
		end
	end
end)