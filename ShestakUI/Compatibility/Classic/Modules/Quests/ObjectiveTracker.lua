local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	Move QuestWatchFrame
----------------------------------------------------------------------------------------
local ObjectiveTracker = CreateFrame("Frame", "ObjectiveTrackerAnchor", UIParent)
ObjectiveTracker:SetPoint(unpack(C.position.quest))
ObjectiveTracker:SetHeight(150)
ObjectiveTracker:SetWidth(224)

ObjectiveTracker:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
ObjectiveTracker:RegisterEvent("QUEST_WATCH_UPDATE")

ObjectiveTracker:SetScript("OnEvent", function(self, event, ...)
	QuestWatchFrame:SetParent(ObjectiveTrackerAnchor)
	QuestWatchFrame:ClearAllPoints()
	QuestWatchFrame:SetPoint("TOPLEFT", self, 0, 0)

	local QuestWatchFrameHeader = CreateFrame("Frame", "QuestWatchFrameHeader", ObjectiveTracker)
	QuestWatchFrameHeader:CreatePanel("ClassColor", 1, 1, "TOPLEFT", QuestWatchFrame, "TOPRIGHT", 0, 0)
	QuestWatchFrameHeader:SetPoint("TOPLEFT", QuestWatchFrame, "TOPLEFT", 0, 0)
	QuestWatchFrameHeader:SetPoint("TOPRIGHT", QuestWatchFrame, "TOPLEFT", QuestWatchFrame:GetWidth(), 0)

	QuestWatchFrameHeader.Text = QuestWatchFrameHeader:CreateFontString(nil, "OVERLAY")
	QuestWatchFrameHeader.Text:SetFont(C.media.normal_font, 14, "OUTLINE")
	QuestWatchFrameHeader.Text:SetPoint("LEFT", QuestWatchFrameHeader, "LEFT", -2, 14)
	QuestWatchFrameHeader.Text:SetText(CURRENT_QUESTS)

	-- Change font of watched quests
	for i = 1, 30 do
		local line = _G["QuestWatchLine"..i]
		line:SetFont(C.media.normal_font, 14)
		-- line:SetShadowColor(0, 0, 0, 0)
	end

	if GetNumQuestWatches() > 0 then
		self:Show()
	else
		self:Hide()
	end
end)

----------------------------------------------------------------------------------------
--	Move QuestTimerFrame (issues with the mover)
----------------------------------------------------------------------------------------
local ObjectiveTimer = CreateFrame("Frame", "ObjectiveTimerAnchor", UIParent)
ObjectiveTimer:SetPoint("BOTTOM", Minimap, "TOP", 0, 64)
ObjectiveTimer:SetHeight(80)
ObjectiveTimer:SetWidth(120)

QuestTimerFrame:StripTextures()
QuestTimerFrame:SetParent(ObjectiveTimer)
QuestTimerFrame:ClearAllPoints()
QuestTimerFrame:SetAllPoints(ObjectiveTimer)