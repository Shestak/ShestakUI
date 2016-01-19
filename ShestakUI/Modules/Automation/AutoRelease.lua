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
	if not (HasSoulstone() and CanUseSoulstone()) then
		SetMapToCurrentZone()
		local areaID = GetCurrentMapAreaID() or 0
		if areaID == 501 or areaID == 708 or areaID == 978 or areaID == 1009 or areaID == 1011 or inBattlefield == true then
			RepopMe()
		end
	end
end)