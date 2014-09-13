local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Move ObjectiveTrackerFrame
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "WatchFrameAnchor", UIParent)
frame:SetPoint(unpack(C.position.quest))
frame:SetHeight(150)
if GetCVar("watchFrameWidth") == "1" then
	frame:SetWidth(326)
else
	frame:SetWidth(224)
end

ObjectiveTrackerFrame:ClearAllPoints()
ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
ObjectiveTrackerFrame:SetHeight(T.getscreenheight / 1.6)

hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", function(_, _, parent)
	if parent ~= frame then
		ObjectiveTrackerFrame:ClearAllPoints()
		ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
	end
end)

----------------------------------------------------------------------------------------
--	Skin ObjectiveTrackerFrame item buttons
----------------------------------------------------------------------------------------
--WoD hooksecurefunc("WatchFrameItem_UpdateCooldown", function(self)
	-- if not self.skinned and not InCombatLockdown() then
		-- local icon = _G[self:GetName().."IconTexture"]
		-- local border = _G[self:GetName().."NormalTexture"]
		-- local count = _G[self:GetName().."Count"]

		-- self:SetSize(C.actionbar.button_size, C.actionbar.button_size)
		-- self:SetTemplate("Default")

		-- icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		-- icon:SetPoint("TOPLEFT", self, 2, -2)
		-- icon:SetPoint("BOTTOMRIGHT", self, -2, 2)

		-- count:ClearAllPoints()
		-- count:SetPoint("BOTTOMRIGHT", 0, 2)
		-- count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		-- count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)

		-- border:SetTexture(nil)

		-- self:StyleButton()

		-- self.skinned = true
	-- end
-- end)

----------------------------------------------------------------------------------------
--	Difficulty color for ObjectiveTrackerFrame lines
----------------------------------------------------------------------------------------
--WoD hooksecurefunc("WatchFrame_Update", function()
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

for _, headerName in pairs({"QuestHeader", "AchievementHeader", "ScenarioHeader"}) do
	local header = ObjectiveTrackerFrame.BlocksFrame[headerName].Background:Hide()
end

----------------------------------------------------------------------------------------
--	Skin WatchFrameCollapseExpandButton
----------------------------------------------------------------------------------------
if C.skins.blizzard_frames == true then
	T.SkinCloseButton(ObjectiveTrackerFrame.HeaderMenu.MinimizeButton, nil, "-", true)
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:HookScript("OnClick", function(self)
		if ObjectiveTrackerFrame.collapsed then
			self.text:SetText("+")
		else
			self.text:SetText("-")
		end
	end)
end