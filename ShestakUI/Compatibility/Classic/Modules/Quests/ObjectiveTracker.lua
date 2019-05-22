local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	Move ObjectiveTrackerFrame
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "ObjectiveTrackerAnchor", UIParent)
frame:SetPoint(unpack(C.position.quest))
frame:SetHeight(150)
frame:SetWidth(224)

QuestWatchFrame:SetParent(ObjectiveFrameHolder)
QuestWatchFrame:ClearAllPoints()
QuestWatchFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
QuestWatchFrame:SetHeight(T.screenHeight / 1.6)