local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Based on AchievementMover(modified by Tukz)
----------------------------------------------------------------------------------------
local AchievementAnchor = CreateFrame("Frame", "AchievementAnchor", UIParent)
AchievementAnchor:Width(DungeonCompletionAlertFrame1:GetWidth())
AchievementAnchor:Height(DungeonCompletionAlertFrame1:GetHeight())
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
					aFrame:SetPoint("TOP", previousFrame, "BOTTOM", 0, 3)
				else
					aFrame:SetPoint("TOP", AchievementAnchor, "TOP")
				end
			else
				if previousFrame and previousFrame:IsShown() then
					aFrame:SetPoint("BOTTOM", previousFrame, "TOP", 0, -3)
				else
					aFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM")
				end
			end
			previousFrame = aFrame
		end
	end
end
hooksecurefunc("AchievementAlertFrame_FixAnchors", T.AchievementMove)

hooksecurefunc("DungeonCompletionAlertFrame_FixAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		if aFrame and aFrame:IsShown() then
			DungeonCompletionAlertFrame1:ClearAllPoints()
			if pos == "TOP" then
				DungeonCompletionAlertFrame1:SetPoint("TOP", aFrame, "BOTTOM", 0, 3)
			else
				DungeonCompletionAlertFrame1:SetPoint("BOTTOM", aFrame, "TOP", 0, -3)
			end
			return
		end

		DungeonCompletionAlertFrame1:ClearAllPoints()
		if pos == "TOP" then
			DungeonCompletionAlertFrame1:SetPoint("TOP", AchievementAnchor, "TOP")
		else
			DungeonCompletionAlertFrame1:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM")
		end
	end
end)

hooksecurefunc("GuildChallengeAlertFrame_FixAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		local dFrame = _G["DungeonCompletionAlertFrame1"]
		if (aFrame and aFrame:IsShown()) and not (dFrame and dFrame:IsShown()) then
			GuildChallengeAlertFrame:ClearAllPoints()
			if pos == "TOP" then
				GuildChallengeAlertFrame:SetPoint("TOP", aFrame, "BOTTOM", 0, 3)
			else
				GuildChallengeAlertFrame:SetPoint("BOTTOM", aFrame, "TOP", 0, -3)
			end
			return
		elseif dFrame and dFrame:IsShown() then
			GuildChallengeAlertFrame:ClearAllPoints()
			if pos == "TOP" then
				GuildChallengeAlertFrame:SetPoint("TOP", dFrame, "BOTTOM", 0, 3)
			else
				GuildChallengeAlertFrame:SetPoint("BOTTOM", dFrame, "TOP", 0, -3)
			end
			return
		end

		GuildChallengeAlertFrame:ClearAllPoints()
		if pos == "TOP" then
			GuildChallengeAlertFrame:SetPoint("TOP", AchievementAnchor, "TOP")
		else
			GuildChallengeAlertFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM")
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