local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Move ObjectiveTrackerFrame
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "WatchFrameAnchor", UIParent)
frame:SetPoint(unpack(C.position.quest))
frame:SetHeight(150)
frame:SetWidth(224)

ObjectiveTrackerFrame:ClearAllPoints()
ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
ObjectiveTrackerFrame:SetHeight(T.getscreenheight / 1.6)

hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", function(_, _, parent)
	if parent ~= frame then
		ObjectiveTrackerFrame:ClearAllPoints()
		ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
	end
end)
ObjectiveTrackerFrame.HeaderMenu.Title:SetAlpha(0)

for _, headerName in pairs({"QuestHeader", "AchievementHeader", "ScenarioHeader"}) do
	ObjectiveTrackerFrame.BlocksFrame[headerName].Background:Hide()
end

BONUS_OBJECTIVE_TRACKER_MODULE.Header.Background:Hide()
ScenarioObjectiveTracker_AnimateReward = T.dummy
OBJECTIVE_TRACKER_DOUBLE_LINE_HEIGHT = 30

----------------------------------------------------------------------------------------
--	Skin ObjectiveTrackerFrame item buttons
----------------------------------------------------------------------------------------
hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", function(_, block)
	local item = block.itemButton

	if item and not item.skinned then
		item:SetSize(C.actionbar.button_size, C.actionbar.button_size)
		item:SetTemplate("Default")
		item:StyleButton()

		item:SetNormalTexture(nil)

		item.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		item.icon:SetPoint("TOPLEFT", item, 2, -2)
		item.icon:SetPoint("BOTTOMRIGHT", item, -2, 2)

		item.Cooldown:SetAllPoints(item.icon)

		item.HotKey:ClearAllPoints()
		item.HotKey:SetPoint("BOTTOMRIGHT", 0, 2)
		item.HotKey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		item.HotKey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)

		item.Count:ClearAllPoints()
		item.Count:SetPoint("TOPLEFT", 1, -1)
		item.Count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		item.Count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)

		item.skinned = true
	end
end)

----------------------------------------------------------------------------------------
--	Difficulty color for ObjectiveTrackerFrame lines
----------------------------------------------------------------------------------------
--WoD hooksecurefunc("ObjectiveTracker_Update", function()
	-- local numQuestWatches = GetNumQuestWatches()

	-- for i = 1, numQuestWatches do
		-- local questIndex = GetQuestIndexForWatch(i)
		-- if questIndex then
			-- local title, level = GetQuestLogTitle(questIndex)
			-- local col = GetQuestDifficultyColor(level)

			-- for j = 1, #WATCHFRAME_QUESTLINES do
				-- if WATCHFRAME_QUESTLINES[j].text:GetText() == title then
					-- WATCHFRAME_QUESTLINES[j].text:SetTextColor(col.r, col.g, col.b)
					-- WATCHFRAME_QUESTLINES[j].col = col
				-- end
			-- end
			-- for k = 1, #WATCHFRAME_ACHIEVEMENTLINES do
				-- WATCHFRAME_ACHIEVEMENTLINES[k].col = nil
			-- end
		-- end
	-- end
-- end)

--WoD hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(self, onEnter)
	-- i = self.startLine
	-- if not (self.lines[i] and self.lines[i].col) then return end
	-- if onEnter then
		-- self.lines[i].text:SetTextColor(1, 0.8, 0)
	-- else
		-- self.lines[i].text:SetTextColor(self.lines[i].col.r, self.lines[i].col.g, self.lines[i].col.b)
	-- end
-- end)

----------------------------------------------------------------------------------------
--	Skin ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
----------------------------------------------------------------------------------------
if C.skins.blizzard_frames == true then
	local button = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
	button:SetSize(17, 17)
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
	hooksecurefunc("ObjectiveTracker_Collapse", function()
		button.plus:Show()
	end)

	hooksecurefunc("ObjectiveTracker_Expand", function()
		button.plus:Hide()
	end)
end

-- local frame1 = CreateFrame("Frame")
-- frame1:RegisterEvent("PLAYER_ENTERING_WORLD")
-- frame1:SetScript("OnEvent", function(self, event)
	-- ObjectiveTracker_Collapse()
-- end)

----------------------------------------------------------------------------------------
--	Skin bonus objective progress bar
----------------------------------------------------------------------------------------
hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", function(self, block, line)
	local progressBar = line.ProgressBar
	local bar = progressBar.Bar
	local icon = bar.Icon

	if not progressBar.styled then
		local label = bar.Label

		bar.BarFrame:Hide()
		bar.BarGlow:Kill()
		bar.IconBG:Kill()
		bar:SetSize(203, 23)
		bar:SetStatusBarTexture(C.media.texture)

		label:ClearAllPoints()
		label:SetPoint("CENTER", 0, -1)
		label:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)

		icon:SetPoint("RIGHT", 23, 0)
		icon:SetSize(17, 17)

		local bg = icon:GetParent():CreateTexture(nil, "BACKGROUND", nil, -2)
		bg:SetPoint("TOPLEFT", icon, -3, 3)
		bg:SetPoint("BOTTOMRIGHT", icon, 3, -3)
		bg:SetTexture(C.media.blank)
		bg:SetVertexColor(unpack(C.media.backdrop_color))

		local bg = icon:GetParent():CreateTexture(nil, "BACKGROUND", nil, -2)
		bg:SetPoint("TOPLEFT", icon, -2, 2)
		bg:SetPoint("BOTTOMRIGHT", icon, 2, -2)
		bg:SetTexture(C.media.blank)
		bg:SetVertexColor(unpack(C.media.border_color))

		local bg = icon:GetParent():CreateTexture(nil, "BACKGROUND", nil, -2)
		bg:SetPoint("TOPLEFT", icon, -1, 1)
		bg:SetPoint("BOTTOMRIGHT", icon, 1, -1)
		bg:SetTexture(C.media.blank)
		bg:SetVertexColor(unpack(C.media.backdrop_color))

		BonusObjectiveTrackerProgressBar_PlayFlareAnim = T.dummy
		progressBar.styled = true
	end
end)