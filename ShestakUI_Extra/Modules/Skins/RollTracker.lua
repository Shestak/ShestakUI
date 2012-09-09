local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.roll_tracker ~= true then return end

----------------------------------------------------------------------------------------
--	RollTracker skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("RollTracker") then return end

	tinsert(UISpecialFrames, "RollTrackerFrame")
	RollTrackerFrame:SetTemplate("Transparent")
	RollTrackerFrameRollButton:SkinButton()
	RollTrackerFrameClearButton:SkinButton()

	RollTrackerFrameStatusText:SetPoint("BOTTOMLEFT", RollTrackerFrame, "BOTTOMLEFT", 5, 2)
	RollTrackerFrameClearButton:SetPoint("BOTTOMLEFT", RollTrackerFrame, "BOTTOMLEFT", 5, 15)
	RollTrackerFrameRollButton:SetPoint("BOTTOMRIGHT", RollTrackerFrame, "BOTTOMRIGHT", -5, 15)
	RollTrackerFrameCloseButton:SetPoint("TOPRIGHT", RollTrackerFrame, "TOPRIGHT", 1, 0)
end)