local T, C, L, _ = unpack(select(2, ...))

------------------------------------------------------------------------------------------
--	Set custom position for TalkingHeadFrame
------------------------------------------------------------------------------------------
local Load = CreateFrame("Frame")
Load:RegisterEvent("ADDON_LOADED")
Load:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_TalkingHeadUI" or (addon == "ShestakUI" and TalkingHeadFrame) then
		TalkingHeadFrame.ignoreFramePositionManager = true
		TalkingHeadFrame:ClearAllPoints()
		TalkingHeadFrame:SetPoint(unpack(C.position.talking_head))
		Load:UnregisterEvent("ADDON_LOADED")
	end
end)

----------------------------------------------------------------------------------------
--	Hide TalkingHeadFrame
----------------------------------------------------------------------------------------
if C.general.hide_talking_head == true then
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(self, event, addon)
		if addon == "Blizzard_TalkingHeadUI" or (addon == "ShestakUI" and TalkingHeadFrame) then
			hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
				TalkingHeadFrame:Hide()
			end)
			self:UnregisterEvent(event)
		end
	end)
end