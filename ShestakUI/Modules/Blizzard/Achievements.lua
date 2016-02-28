local T, C, L, _ = unpack(select(2, ...))
if IsAddOnLoaded("MoveAnything") then return end

----------------------------------------------------------------------------------------
--	Based on AchievementMover
----------------------------------------------------------------------------------------
local AchievementAnchor = CreateFrame("Frame", "AchievementAnchor", UIParent)
AchievementAnchor:SetWidth(DungeonCompletionAlertFrame1:GetWidth() - 36)
AchievementAnchor:SetHeight(DungeonCompletionAlertFrame1:GetHeight() - 4)
AchievementAnchor:SetPoint(unpack(C.position.achievement))

local POSITION, ANCHOR_POINT, YOFFSET = "BOTTOM", "TOP", -9

local function fixAnchors()
	local point = AchievementAnchor:GetPoint()

	if string.find(point, "TOP") or point == "CENTER" or point == "LEFT" or point == "RIGHT" then
		POSITION = "TOP"
		ANCHOR_POINT = "BOTTOM"
		YOFFSET = 9
	else
		POSITION = "BOTTOM"
		ANCHOR_POINT = "TOP"
		YOFFSET = -9
	end

	AlertFrame:ClearAllPoints()
	AlertFrame:SetPoint(POSITION, AchievementAnchor, POSITION, 2, YOFFSET)

	GroupLootContainer:ClearAllPoints()
	GroupLootContainer:SetPoint(POSITION, AlertFrame, ANCHOR_POINT, 0, YOFFSET)
end
hooksecurefunc("AlertFrame_FixAnchors", fixAnchors)

local function AlertFrame_SetLootAnchors(alertAnchor)
	if MissingLootFrame:IsShown() then
		MissingLootFrame:ClearAllPoints()
		MissingLootFrame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
		if GroupLootContainer:IsShown() then
			GroupLootContainer:ClearAllPoints()
			GroupLootContainer:SetPoint(POSITION, MissingLootFrame, ANCHOR_POINT, 0, YOFFSET)
		end
	elseif GroupLootContainer:IsShown() then
		GroupLootContainer:ClearAllPoints()
		GroupLootContainer:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetLootAnchors", AlertFrame_SetLootAnchors)

local function AlertFrame_SetStorePurchaseAnchors(alertAnchor)
	local frame = StorePurchaseAlertFrame
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetStorePurchaseAnchors", AlertFrame_SetStorePurchaseAnchors)

local function AlertFrame_SetLootWonAnchors(alertAnchor)
	for i = 1, #LOOT_WON_ALERT_FRAMES do
		local frame = LOOT_WON_ALERT_FRAMES[i]
		if frame:IsShown() then
			frame:ClearAllPoints()
			frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
			alertAnchor = frame
		end
	end
end
hooksecurefunc("AlertFrame_SetLootWonAnchors", AlertFrame_SetLootWonAnchors)

local function AlertFrame_SetLootUpgradeFrameAnchors(alertAnchor)
	for i = 1, #LOOT_UPGRADE_ALERT_FRAMES do
		local frame = LOOT_UPGRADE_ALERT_FRAMES[i]
		if frame:IsShown() then
			frame:ClearAllPoints()
			frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
			alertAnchor = frame
		end
	end
end
hooksecurefunc("AlertFrame_SetLootUpgradeFrameAnchors", AlertFrame_SetLootUpgradeFrameAnchors)

local function AlertFrame_SetMoneyWonAnchors(alertAnchor)
	for i = 1, #MONEY_WON_ALERT_FRAMES do
		local frame = MONEY_WON_ALERT_FRAMES[i]
		if frame:IsShown() then
			frame:ClearAllPoints()
			frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
			alertAnchor = frame
		end
	end
end
hooksecurefunc("AlertFrame_SetMoneyWonAnchors", AlertFrame_SetMoneyWonAnchors)

local function AlertFrame_SetAchievementAnchors(alertAnchor)
	if AchievementAlertFrame1 then
		for i = 1, MAX_ACHIEVEMENT_ALERTS do
			local frame = _G["AchievementAlertFrame"..i]
			if frame and frame:IsShown() then
				frame:ClearAllPoints()
				frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
				alertAnchor = frame
			end
		end
	end
end
hooksecurefunc("AlertFrame_SetAchievementAnchors", AlertFrame_SetAchievementAnchors)

local function AlertFrame_SetCriteriaAnchors(alertAnchor)
	if CriteriaAlertFrame1 then
		for i = 1, MAX_ACHIEVEMENT_ALERTS do
			local frame = _G["CriteriaAlertFrame"..i]
			if frame and frame:IsShown() then
				frame:ClearAllPoints()
				frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
				alertAnchor = frame
			end
		end
	end
end
hooksecurefunc("AlertFrame_SetCriteriaAnchors", AlertFrame_SetCriteriaAnchors)

local function AlertFrame_SetChallengeModeAnchors(alertAnchor)
	local frame = ChallengeModeAlertFrame1
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetChallengeModeAnchors", AlertFrame_SetChallengeModeAnchors)

local function AlertFrame_SetDungeonCompletionAnchors(alertAnchor)
	local frame = DungeonCompletionAlertFrame1
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetDungeonCompletionAnchors", AlertFrame_SetDungeonCompletionAnchors)

local function AlertFrame_SetScenarioAnchors(alertAnchor)
	local frame = ScenarioAlertFrame1
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetScenarioAnchors", AlertFrame_SetScenarioAnchors)

local function AlertFrame_SetGuildChallengeAnchors(alertAnchor)
	local frame = GuildChallengeAlertFrame
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetGuildChallengeAnchors", AlertFrame_SetGuildChallengeAnchors)

local function AlertFrame_SetDigsiteCompleteToastFrameAnchors(alertAnchor)
	local frame = DigsiteCompleteToastFrame
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetDigsiteCompleteToastFrameAnchors", AlertFrame_SetDigsiteCompleteToastFrameAnchors)

local function AlertFrame_SetGarrisonBuildingAlertFrameAnchors(alertAnchor)
	local frame = GarrisonBuildingAlertFrame
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetGarrisonBuildingAlertFrameAnchors", AlertFrame_SetGarrisonBuildingAlertFrameAnchors)

local function AlertFrame_SetGarrisonMissionAlertFrameAnchors(alertAnchor)
	local frame = GarrisonMissionAlertFrame
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetGarrisonMissionAlertFrameAnchors", AlertFrame_SetGarrisonMissionAlertFrameAnchors)

local function AlertFrame_SetGarrisonShipMissionAlertFrameAnchors(alertAnchor)
	local frame = GarrisonShipMissionAlertFrame
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetGarrisonShipMissionAlertFrameAnchors", AlertFrame_SetGarrisonShipMissionAlertFrameAnchors)

local function AlertFrame_SetGarrisonFollowerAlertFrameAnchors(alertAnchor)
	local frame = GarrisonFollowerAlertFrame
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetGarrisonFollowerAlertFrameAnchors", AlertFrame_SetGarrisonFollowerAlertFrameAnchors)

local function AlertFrame_SetGarrisonShipFollowerAlertFrameAnchors(alertAnchor)
	local frame = GarrisonShipFollowerAlertFrame
	if frame:IsShown() then
		frame:ClearAllPoints()
		frame:SetPoint(POSITION, alertAnchor, ANCHOR_POINT, 0, YOFFSET)
	end
end
hooksecurefunc("AlertFrame_SetGarrisonShipFollowerAlertFrameAnchors", AlertFrame_SetGarrisonShipFollowerAlertFrameAnchors)

hooksecurefunc(GroupLootContainer, "SetPoint", function(self, point, anchorTo, attachPoint, xOffset, yOffset)
	if _G[anchorTo] == UIParent or _G[anchorTo] == AchievementAnchor then
		fixAnchors()
	end
end)