local T, C, L = unpack(ShestakUI)
if C.extra_skins.roll_tracker ~= true then return end

----------------------------------------------------------------------------------------
--	RollTracker skin
----------------------------------------------------------------------------------------
local RTSkin = CreateFrame("Frame")
RTSkin:RegisterEvent("PLAYER_LOGIN")
RTSkin:SetScript("OnEvent", function(self, event, addon)
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