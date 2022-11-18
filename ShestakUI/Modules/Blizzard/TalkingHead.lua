local T, C, L, _ = unpack(select(2, ...))

------------------------------------------------------------------------------------------
--	Set custom position for TalkingHeadFrame
------------------------------------------------------------------------------------------
local Load = CreateFrame("Frame")
Load:RegisterEvent("PLAYER_ENTERING_WORLD")
Load:SetScript("OnEvent", function()
	TalkingHeadFrame.ignoreFramePositionManager = true
	TalkingHeadFrame:ClearAllPoints()
	TalkingHeadFrame:SetPoint(unpack(C.position.talking_head))
	Load:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

hooksecurefunc(TalkingHeadFrame, "SetPoint", function(self, _, _, _, x)
	if x ~= C.position.talking_head[4] then
		self:ClearAllPoints()
		self:SetPoint(unpack(C.position.talking_head))
	end
end)

----------------------------------------------------------------------------------------
--	Hide TalkingHeadFrame
----------------------------------------------------------------------------------------
if C.general.hide_talking_head == true then
	hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function()
		TalkingHeadFrame:Hide()
	end)
end