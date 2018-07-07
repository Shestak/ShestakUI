local T, C, L, _ = unpack(select(2, ...))
if C.automation.release ~= true then return end

----------------------------------------------------------------------------------------
--	Auto release the spirit in battlegrounds
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_DEAD")
frame:SetScript("OnEvent", function(self, event)
	local inBattlefield = false
	for i = 1, GetMaxBattlefieldID() do
		local status = GetBattlefieldStatus(i)
		if status == "active" then inBattlefield = true end
	end
	if C_DeathInfo.GetSelfResurrectOptions() and #C_DeathInfo.GetSelfResurrectOptions() > 0 then return end
	local areaID = C_Map.GetBestMapForUnit("player") or 0
	if areaID == 123 or areaID == 244 or areaID == 588 or areaID == 622 or areaID == 624 or inBattlefield == true then
		RepopMe()
	end
end)