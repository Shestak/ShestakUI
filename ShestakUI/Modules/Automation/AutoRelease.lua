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
	local inBattlefield = false
	for i = 1, GetMaxBattlefieldID() do
		local status = GetBattlefieldStatus(i)
		if status == "active" then inBattlefield = true end
	end
	if (T.class ~= "SHAMAN") and not (HasSoulstone() and CanUseSoulstone()) then
		if (tostring(GetZoneText()) == WINTERGRASP) or (tostring(GetZoneText()) == BARAD) or inBattlefield == true then
			RepopMe()
		end
	end
end)