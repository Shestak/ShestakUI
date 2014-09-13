local T, C, L, _ = unpack(select(2, ...))
if C.automation.auto_collapse ~= true then return end

----------------------------------------------------------------------------------------
--	Auto collapse ObjectiveTrackerFrame in instance
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if IsInInstance() then
		ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:Click()
	elseif ObjectiveTrackerFrame.collapsed and not InCombatLockdown() then
		ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:Click()
	end
end)