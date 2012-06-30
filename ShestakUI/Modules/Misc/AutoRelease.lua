local T, C, L = unpack(select(2, ...))
if C.misc.auto_resurrection ~= true then return end

----------------------------------------------------------------------------------------
--	Auto resurection
----------------------------------------------------------------------------------------
local WINTERGRASP = L_ZONE_WINTERGRASP
local BARAD = L_ZONE_TOLBARAD

local autoreleasepvp = CreateFrame("Frame")
autoreleasepvp:RegisterEvent("PLAYER_DEAD")
autoreleasepvp:SetScript("OnEvent", function(self, event)
	local soulstone = GetSpellInfo(20707)
	if (T.class ~= "SHAMAN") and not (soulstone and UnitBuff("player", soulstone)) then
		if (tostring(GetZoneText()) == WINTERGRASP) or (tostring(GetZoneText()) == BARAD) or QueueStatusMinimapButton.status == "active" then
			RepopMe()
		end
	end
end)