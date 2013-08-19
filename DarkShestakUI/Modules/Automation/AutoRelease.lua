local T, C, L, _ = unpack(select(2, ...))
if C.automation.resurrection ~= true then return end

----------------------------------------------------------------------------------------
--	Auto resurrection
----------------------------------------------------------------------------------------
local WINTERGRASP = L_ZONE_WINTERGRASP
local BARAD = L_ZONE_TOLBARAD

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_DEAD")
frame:SetScript("OnEvent", function(self, event)
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