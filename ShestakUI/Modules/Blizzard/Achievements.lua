local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Unregister some events
----------------------------------------------------------------------------------------
AlertFrame:UnregisterEvent("LOOT_ITEM_ROLL_WON")
AlertFrame:UnregisterEvent("SHOW_LOOT_TOAST")
AlertFrame:UnregisterEvent("CRITERIA_EARNED")

----------------------------------------------------------------------------------------
--	Based on AchievementMover
----------------------------------------------------------------------------------------
local AchievementAnchor = CreateFrame("Frame", "AchievementAnchor", UIParent)
AchievementAnchor:Width(DungeonCompletionAlertFrame1:GetWidth() - 36)
AchievementAnchor:Height(DungeonCompletionAlertFrame1:GetHeight() - 4)
AchievementAnchor:SetPoint(unpack(C.position.achievement))

local pos = "TOP"

function T.AchievementMove(self, event, ...)
	local previousFrame
	for i = 1, MAX_ACHIEVEMENT_ALERTS do
		local aFrame = _G["AchievementAlertFrame"..i]
		if aFrame then
			aFrame:ClearAllPoints()
			if pos == "TOP" then
				if previousFrame and previousFrame:IsShown() then
					aFrame:SetPoint("TOP", previousFrame, "BOTTOM", 0, 9)
				else
					aFrame:SetPoint("TOP", AchievementAnchor, "TOP", 2, 6)
				end
			else
				if previousFrame and previousFrame:IsShown() then
					aFrame:SetPoint("BOTTOM", previousFrame, "TOP", 0, -9)
				else
					aFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM", 2 -6)
				end
			end
			previousFrame = aFrame
		end
	end
end
hooksecurefunc("AlertFrame_SetAchievementAnchors", T.AchievementMove)

hooksecurefunc("AlertFrame_SetDungeonCompletionAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		local dFrame = _G["DungeonCompletionAlertFrame1"]

		dFrame:ClearAllPoints()
		if aFrame and aFrame:IsShown() then
			dFrame:ClearAllPoints()
			if pos == "TOP" then
				dFrame:SetPoint("TOP", aFrame, "BOTTOM", 0, 9)
			else
				dFrame:SetPoint("BOTTOM", aFrame, "TOP", 0, -9)
			end
			return
		else
			if pos == "TOP" then
				dFrame:SetPoint("TOP", AchievementAnchor, "TOP", 2, 6)
			else
				dFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM", 2 -6)
			end
		end
	end
end)

hooksecurefunc("AlertFrame_SetChallengeModeAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		local dFrame = _G["ChallengeModeAlertFrame1"]

		dFrame:ClearAllPoints()
		if aFrame and aFrame:IsShown() then
			dFrame:ClearAllPoints()
			if pos == "TOP" then
				dFrame:SetPoint("TOP", aFrame, "BOTTOM", 0, 9)
			else
				dFrame:SetPoint("BOTTOM", aFrame, "TOP", 0, -9)
			end
			return
		else
			if pos == "TOP" then
				dFrame:SetPoint("TOP", AchievementAnchor, "TOP", 2, 6)
			else
				dFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM", 2 -6)
			end
		end
	end
end)

hooksecurefunc("AlertFrame_SetScenarioAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		local dFrame = _G["DungeonCompletionAlertFrame1"]
		local sFrame = _G["ScenarioAlertFrame1"]

		if _G["DungeonCompletionAlertFrame1"] and _G["DungeonCompletionAlertFrame1"]:IsShown() then
			dFrame = _G["DungeonCompletionAlertFrame1"]
		elseif _G["ChallengeModeAlertFrame1"] and _G["ChallengeModeAlertFrame1"]:IsShown() then
			dFrame = _G["ChallengeModeAlertFrame1"]
		end

		sFrame:ClearAllPoints()
		if dFrame and dFrame:IsShown() then
			if pos == "TOP" then
				sFrame:SetPoint("TOP", dFrame, "BOTTOM", 0, 9)
			else
				sFrame:SetPoint("BOTTOM", dFrame, "TOP", 0, -9)
			end
			return
		elseif aFrame and aFrame:IsShown() then
			if pos == "TOP" then
				sFrame:SetPoint("TOP", aFrame, "BOTTOM", 0, 9)
			else
				sFrame:SetPoint("BOTTOM", aFrame, "TOP", 0, -9)
			end
			return
		else
			if pos == "TOP" then
				sFrame:SetPoint("TOP", AchievementAnchor, "TOP", 2, 6)
			else
				sFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM", 2 -6)
			end
		end
	end
end)

hooksecurefunc("AlertFrame_SetGuildChallengeAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		local dFrame = _G["DungeonCompletionAlertFrame1"]
		local sFrame = _G["ScenarioAlertFrame1"]
		local cFrame = _G["GuildChallengeAlertFrame"]

		if _G["DungeonCompletionAlertFrame1"] and _G["DungeonCompletionAlertFrame1"]:IsShown() then
			dFrame = _G["DungeonCompletionAlertFrame1"]
		elseif _G["ChallengeModeAlertFrame1"] and _G["ChallengeModeAlertFrame1"]:IsShown() then
			dFrame = _G["ChallengeModeAlertFrame1"]
		end

		cFrame:ClearAllPoints()
		if sFrame and sFrame:IsShown() then
			if pos == "TOP" then
				cFrame:SetPoint("TOP", sFrame, "BOTTOM", 0, 9)
			else
				cFrame:SetPoint("BOTTOM", sFrame, "TOP", 0, -9)
			end
			return
		elseif dFrame and dFrame:IsShown() then
			if pos == "TOP" then
				cFrame:SetPoint("TOP", dFrame, "BOTTOM", 0, 9)
			else
				cFrame:SetPoint("BOTTOM", dFrame, "TOP", 0, -9)
			end
			return
		elseif aFrame and aFrame:IsShown() then
			if pos == "TOP" then
				cFrame:SetPoint("TOP", aFrame, "BOTTOM", 0, 9)
			else
				cFrame:SetPoint("BOTTOM", aFrame, "TOP", 0, -9)
			end
			return
		else
			if pos == "TOP" then
				cFrame:SetPoint("TOP", AchievementAnchor, "TOP", 2, 6)
			else
				cFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM", 2 -6)
			end
		end
	end
end)

function T.PostAchievementMove(frame)
	local point = select(1, frame:GetPoint())

	if string.find(point, "TOP") or point == "CENTER" or point == "LEFT" or point == "RIGHT" then
		pos = "TOP"
	else
		pos = "BOTTOM"
	end

	T.AchievementMove()
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ACHIEVEMENT_EARNED")
frame:SetScript("OnEvent", function(self, event, ...) T.AchievementMove(self, event, ...) end)