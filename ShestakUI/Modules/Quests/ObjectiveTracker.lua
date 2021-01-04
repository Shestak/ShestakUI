local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Move ObjectiveTrackerFrame and hide background
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "ObjectiveTrackerAnchor", UIParent)
frame:SetPoint(unpack(C.position.quest))
frame:SetSize(224, 150)

ObjectiveTrackerFrame:ClearAllPoints()
ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
ObjectiveTrackerFrame:SetHeight(T.screenHeight / 1.6)

ObjectiveTrackerFrame.IsUserPlaced = function() return true end

local headers = {
	ObjectiveTrackerBlocksFrame.ScenarioHeader,
	ObjectiveTrackerBlocksFrame.CampaignQuestHeader,
	ObjectiveTrackerBlocksFrame.QuestHeader,
	ObjectiveTrackerBlocksFrame.AchievementHeader,
	BONUS_OBJECTIVE_TRACKER_MODULE.Header,
	WORLD_QUEST_TRACKER_MODULE.Header,
	ObjectiveTrackerFrame.BlocksFrame.UIWidgetsHeader
}

for i = 1, #headers do
	local header = headers[i]
	if header then
		header.Background:Hide()
	end
end

ObjectiveTrackerFrame.HeaderMenu.Title:SetAlpha(0)

----------------------------------------------------------------------------------------
--	Skin ObjectiveTrackerFrame item buttons
----------------------------------------------------------------------------------------
hooksecurefunc("QuestObjectiveSetupBlockButton_Item", function(block)
	local item = block and block.itemButton

	if item and not item.skinned then
		item:SetSize(25, 25)
		item:SetTemplate("Default")
		item:StyleButton()

		item:SetNormalTexture(nil)

		item.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		item.icon:SetPoint("TOPLEFT", item, 2, -2)
		item.icon:SetPoint("BOTTOMRIGHT", item, -2, 2)

		item.Cooldown:SetAllPoints(item.icon)

		item.Count:ClearAllPoints()
		item.Count:SetPoint("TOPLEFT", 1, -1)
		item.Count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		item.Count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)

		item.HotKey:SetFontObject(NumberFont_OutlineThick_Mono_Small)
		item.skinned = true
	end
end)

hooksecurefunc("QuestObjectiveSetupBlockButton_FindGroup", function(block)
	if block.groupFinderButton and not block.groupFinderButton.styled then
		local icon = block.groupFinderButton
		icon:SetSize(26, 26)
		icon:SetNormalTexture("")
		icon:SetHighlightTexture("")
		icon:SetPushedTexture("")
		icon.b = CreateFrame("Frame", nil, icon)
		icon.b:SetTemplate("Overlay")
		icon.b:SetPoint("TOPLEFT", icon, "TOPLEFT", 2, -3)
		icon.b:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -4, 3)
		icon.b:SetFrameLevel(1)

		icon:HookScript("OnEnter", function(self)
			if self:IsEnabled() then
				self.b:SetBackdropBorderColor(unpack(C.media.classborder_color))
				if self.b.overlay then
					self.b.overlay:SetVertexColor(C.media.classborder_color[1] * 0.3, C.media.classborder_color[2] * 0.3, C.media.classborder_color[3] * 0.3, 1)
				end
			end
		end)

		icon:HookScript("OnLeave", function(self)
			self.b:SetBackdropBorderColor(unpack(C.media.border_color))
			if self.b.overlay then
				self.b.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
			end
		end)

		hooksecurefunc(icon, "Show", function(self)
			self.b:SetFrameLevel(1)
		end)

		icon.styled = true
	end
end)

----------------------------------------------------------------------------------------
--	Difficulty color for ObjectiveTrackerFrame lines
----------------------------------------------------------------------------------------
hooksecurefunc(QUEST_TRACKER_MODULE, "Update", function()
	for i = 1, C_QuestLog.GetNumQuestWatches() do
		local questID = C_QuestLog.GetQuestIDForQuestWatchIndex(i)
		if not questID then
			break
		end
		local col = GetDifficultyColor(C_PlayerInfo.GetContentDifficultyQuestForPlayer(questID))
		local block = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
		if block then
			block.HeaderText:SetTextColor(col.r, col.g, col.b)
			block.HeaderText.col = col
		end
	end
end)

hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(_, block)
	if block.module == ACHIEVEMENT_TRACKER_MODULE then
		block.HeaderText:SetTextColor(0.75, 0.61, 0)
		block.HeaderText.col = nil
	end
end)

hooksecurefunc("ObjectiveTrackerBlockHeader_OnLeave", function(self)
	local block = self:GetParent()
	if block.HeaderText.col then
		block.HeaderText:SetTextColor(block.HeaderText.col.r, block.HeaderText.col.g, block.HeaderText.col.b)
	end
end)

----------------------------------------------------------------------------------------
--	Skin ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
----------------------------------------------------------------------------------------
if C.skins.blizzard_frames == true then
	local button = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
	button:SetSize(17, 17)
	button:StripTextures()
	button:SetTemplate("Overlay")

	button.minus = button:CreateTexture(nil, "OVERLAY")
	button.minus:SetSize(7, 1)
	button.minus:SetPoint("CENTER")
	button.minus:SetTexture(C.media.blank)

	button.plus = button:CreateTexture(nil, "OVERLAY")
	button.plus:SetSize(1, 7)
	button.plus:SetPoint("CENTER")
	button.plus:SetTexture(C.media.blank)

	button:HookScript("OnEnter", T.SetModifiedBackdrop)
	button:HookScript("OnLeave", T.SetOriginalBackdrop)

	button.plus:Hide()
	hooksecurefunc("ObjectiveTracker_Collapse", function()
		button.plus:Show()
		button:SetNormalTexture("")
		button:SetPushedTexture("")
		if C.general.minimize_mouseover then
			button:SetAlpha(0)
			button:HookScript("OnEnter", function() button:SetAlpha(1) end)
			button:HookScript("OnLeave", function() button:SetAlpha(0) end)
		end
	end)

	hooksecurefunc("ObjectiveTracker_Expand", function()
		button.plus:Hide()
		button:SetNormalTexture("")
		button:SetPushedTexture("")
		if C.general.minimize_mouseover then
			button:SetAlpha(1)
			button:HookScript("OnEnter", function() button:SetAlpha(1) end)
			button:HookScript("OnLeave", function() button:SetAlpha(1) end)
		end
	end)

	local function SkinSmallMinimizeButton(button)
		button:SetSize(15, 15)
		button:StripTextures()
		button:SetTemplate("Overlay")

		button.minus = button:CreateTexture(nil, "OVERLAY")
		button.minus:SetSize(5, 1)
		button.minus:SetPoint("CENTER")
		button.minus:SetTexture(C.media.blank)

		button.plus = button:CreateTexture(nil, "OVERLAY")
		button.plus:SetSize(1, 5)
		button.plus:SetPoint("CENTER")
		button.plus:SetTexture(C.media.blank)

		button:HookScript("OnEnter", T.SetModifiedBackdrop)
		button:HookScript("OnLeave", T.SetOriginalBackdrop)

		button.plus:Hide()

		hooksecurefunc(button, "SetCollapsed", function(self, collapsed)
			if collapsed then
				button.plus:Show()
			else
				button.plus:Hide()
			end
			button:SetNormalTexture("")
			button:SetPushedTexture("")
		end)
	end

	for i = 1, #headers do
		local button = headers[i].MinimizeButton
		if button then
			SkinSmallMinimizeButton(button)
		end
	end
end

----------------------------------------------------------------------------------------
--	Auto collapse Objective Tracker
----------------------------------------------------------------------------------------
if C.automation.auto_collapse ~= "NONE" then
	local collapse = CreateFrame("Frame")
	collapse:RegisterEvent("PLAYER_ENTERING_WORLD")
	collapse:SetScript("OnEvent", function()
		if C.automation.auto_collapse == "RAID" then
			if IsInInstance() then
				ObjectiveTracker_Collapse()
			elseif ObjectiveTrackerFrame.collapsed and not InCombatLockdown() then
				ObjectiveTracker_Expand()
			end
		elseif C.automation.auto_collapse == "RELOAD" then
			ObjectiveTracker_Collapse()
		end
	end)
end

----------------------------------------------------------------------------------------
--	Skin simple quest objective progress bar
----------------------------------------------------------------------------------------
local function SkinBar(_, _, line)
	local progressBar = line.ProgressBar
	local bar = progressBar.Bar
	local label = bar.Label

	if not progressBar.styled then
		bar:SetSize(200, 20)
		bar:SetStatusBarTexture(C.media.texture)
		bar:SetTemplate("Transparent")
		bar:SetBackdropColor(0, 0, 0, 0)
		bar:DisableDrawLayer("ARTWORK")

		label:ClearAllPoints()
		label:SetPoint("CENTER", 0, -1)
		label:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		label:SetDrawLayer("OVERLAY")

		progressBar.styled = true
	end
end

hooksecurefunc(QUEST_TRACKER_MODULE, "AddProgressBar", SkinBar)
hooksecurefunc(CAMPAIGN_QUEST_TRACKER_MODULE, "AddProgressBar", SkinBar)
hooksecurefunc(SCENARIO_TRACKER_MODULE, "AddProgressBar", SkinBar)

----------------------------------------------------------------------------------------
--	Skin quest objective progress bar with icon
----------------------------------------------------------------------------------------
local function SkinBarIcon(_, _, line)
	local progressBar = line.ProgressBar
	local bar = progressBar.Bar
	local label = bar.Label
	local icon = bar.Icon

	if not progressBar.styled then
		bar.BarFrame:Hide()
		bar.BarGlow:Kill()
		bar.Sheen:Hide()
		bar.IconBG:Kill()
		bar:SetSize(200, 20)
		bar:SetStatusBarTexture(C.media.texture)
		bar:SetTemplate("Transparent")
		bar:SetBackdropColor(0, 0, 0, 0)

		label:ClearAllPoints()
		label:SetPoint("CENTER", 0, -1)
		label:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)

		icon:SetPoint("RIGHT", 24, 0)
		icon:SetSize(20, 20)
		icon:SetMask(nil)

		local border = CreateFrame("Frame", "$parentBorder", bar)
		border:SetAllPoints(icon)
		border:SetTemplate("Transparent")
		border:SetBackdropColor(0, 0, 0, 0)
		bar.newIconBg = border

		hooksecurefunc(bar.AnimIn, "Play", function()
			bar.AnimIn:Stop()
		end)

		BonusObjectiveTrackerProgressBar_PlayFlareAnim = T.dummy
		progressBar.styled = true
	end

	bar.newIconBg:SetShown(icon:IsShown())
end

hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", SkinBarIcon)
hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddProgressBar", SkinBarIcon)

----------------------------------------------------------------------------------------
--	Skin Timer bar
----------------------------------------------------------------------------------------
local function SkinTimer(_, _, line)
	local timerBar = line.TimerBar
	local bar = timerBar.Bar

	if not timerBar.styled then
		bar:SetStatusBarTexture(C.media.texture)
		bar:SetTemplate("Transparent")
		bar:SetBackdropColor(0, 0, 0, 0)
		bar:DisableDrawLayer("ARTWORK")
		timerBar.styled = true
	end
end

hooksecurefunc(QUEST_TRACKER_MODULE, "AddTimerBar", SkinTimer)
hooksecurefunc(SCENARIO_TRACKER_MODULE, "AddTimerBar", SkinTimer)
hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddTimerBar", SkinTimer)
hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "AddTimerBar", SkinTimer)

----------------------------------------------------------------------------------------
--	Set tooltip depending on position
----------------------------------------------------------------------------------------
local function IsFramePositionedLeft(frame)
	local x = frame:GetCenter()
	local screenWidth = GetScreenWidth()
	local positionedLeft = false

	if x and x < (screenWidth / 2) then
		positionedLeft = true
	end

	return positionedLeft
end

hooksecurefunc("BonusObjectiveTracker_ShowRewardsTooltip", function(block)
	if IsFramePositionedLeft(ObjectiveTrackerFrame) then
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOPLEFT", block, "TOPRIGHT", 0, 0)
	end
end)

ScenarioStageBlock:HookScript("OnEnter", function(self)
	if IsFramePositionedLeft(ObjectiveTrackerFrame) then
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 50, -3)
	end
end)

do
	if IsFramePositionedLeft(ObjectiveTrackerFrame) then
		local list = ScenarioBlocksFrame.MawBuffsBlock.Container.List
		if list then
			list:ClearAllPoints()
			list:SetPoint("TOPLEFT", ScenarioBlocksFrame.MawBuffsBlock.Container, "TOPRIGHT", 15, 0)
		end
	end
end

----------------------------------------------------------------------------------------
--	Kill reward animation when finished dungeon or bonus objectives
----------------------------------------------------------------------------------------
ObjectiveTrackerScenarioRewardsFrame.Show = T.dummy

hooksecurefunc("BonusObjectiveTracker_AnimateReward", function()
	ObjectiveTrackerBonusRewardsFrame:ClearAllPoints()
	ObjectiveTrackerBonusRewardsFrame:SetPoint("BOTTOM", UIParent, "TOP", 0, 90)
end)

----------------------------------------------------------------------------------------
--	Skin ScenarioStageBlock
----------------------------------------------------------------------------------------
local StageBlock = _G["ScenarioStageBlock"]
StageBlock:CreateBackdrop("Overlay")
StageBlock.backdrop:SetPoint("TOPLEFT", ScenarioStageBlock.NormalBG, 3, -3)
StageBlock.backdrop:SetPoint("BOTTOMRIGHT", ScenarioStageBlock.NormalBG, -6, 5)

StageBlock.NormalBG:SetAlpha(0)
StageBlock.FinalBG:SetAlpha(0)
StageBlock.GlowTexture:SetTexture("")

----------------------------------------------------------------------------------------
--	Skin ScenarioStageBlock
----------------------------------------------------------------------------------------
local ChallengeBlock = _G["ScenarioChallengeModeBlock"]
ChallengeBlock:CreateBackdrop("Overlay")
ChallengeBlock.backdrop:SetPoint("TOPLEFT", ChallengeBlock, 3, -3)
ChallengeBlock.backdrop:SetPoint("BOTTOMRIGHT", ChallengeBlock, -6, 3)
ChallengeBlock.backdrop.overlay:SetVertexColor(0.12, 0.12, 0.12, 1)

local bg = select(3, ChallengeBlock:GetRegions())
bg:Hide()

ChallengeBlock.TimerBGBack:Hide()
ChallengeBlock.TimerBG:Hide()

ChallengeBlock.StatusBar:SetStatusBarTexture(C.media.texture)
ChallengeBlock.StatusBar:CreateBackdrop("Overlay")
ChallengeBlock.StatusBar.backdrop:SetFrameLevel(ChallengeBlock.backdrop:GetFrameLevel() + 1)
ChallengeBlock.StatusBar:SetStatusBarColor(0, 0.6, 1)
ChallengeBlock.StatusBar:SetFrameLevel(ChallengeBlock.StatusBar:GetFrameLevel() + 3)

----------------------------------------------------------------------------------------
--	Skin MawBuffsBlock
----------------------------------------------------------------------------------------
local Maw = ScenarioBlocksFrame.MawBuffsBlock.Container
Maw:SkinButton()
Maw:ClearAllPoints()
Maw:SetPoint("TOPLEFT", ScenarioStageBlock.backdrop, "BOTTOMLEFT", 0, -20)
Maw.List.button:SetSize(234, 30)
Maw.List:StripTextures()
Maw.List:SetTemplate("Overlay")

Maw.List:HookScript("OnShow", function(self)
	self.button:SetPushedTexture("")
	self.button:SetHighlightTexture("")
	self.button:SetWidth(234)
	self.button:SetButtonState("NORMAL")
	self.button:SetPushedTextOffset(0, 0)
	self.button:SetButtonState("PUSHED", true)
end)

Maw.List:HookScript("OnHide", function(self)
	self.button:SetPushedTexture("")
	self.button:SetHighlightTexture("")
	self.button:SetWidth(234)
end)

----------------------------------------------------------------------------------------
--	Ctrl+Click to abandon a quest or Alt+Click to share a quest(by Suicidal Katt)
----------------------------------------------------------------------------------------
hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self)
	if IsControlKeyDown() then
		CloseDropDownMenus()
		QuestMapQuestOptions_AbandonQuest(self.questID)
	elseif IsAltKeyDown() and C_QuestLog.IsPushableQuest(self.questID) then
		CloseDropDownMenus()
		QuestMapQuestOptions_ShareQuest(self.questID)
	end
end)

hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderClick", function(_, block)
	if IsControlKeyDown() then
		CloseDropDownMenus()
		QuestMapQuestOptions_AbandonQuest(block.id)
	elseif IsAltKeyDown() and C_QuestLog.IsPushableQuest(block.id) then
		CloseDropDownMenus()
		QuestMapQuestOptions_ShareQuest(block.id)
	end
end)