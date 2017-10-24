local T, C, L, _ = unpack(select(2, ...))

------------------------------------------------------------------------------------------
--	Set custom position for TalkingHeadFrame
------------------------------------------------------------------------------------------
local Load = CreateFrame("Frame")
Load:RegisterEvent("ADDON_LOADED")
Load:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TalkingHeadUI" then
		TalkingHeadFrame.ignoreFramePositionManager = true
		TalkingHeadFrame:ClearAllPoints()
		TalkingHeadFrame:SetPoint(unpack(C.position.talking_head))
	end
end)