local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Quest level
----------------------------------------------------------------------------------------
-- It breaks space between quests
--FIXME local function Showlevel()
	-- for button in pairs(QuestScrollFrame.titleFramePool.activeObjects) do
		-- local title = button.info.title
		-- local isHeader = button.info.isHeader
		-- local level = button.info.level
		-- if title and not isHeader then
			-- local title = level ~= T.level and "["..level.."] "..title or title
			-- local height = button.Text:GetHeight()
			-- button.Text:SetText(title)
			-- button.Text:SetWidth(190)
			-- button.Check:SetPoint("LEFT", button.Text, button.Text:GetWrappedWidth() + 2, 0)
			-- button:SetHeight(button:GetHeight() - height + button.Text:GetHeight())
		-- end
	-- end
-- end
-- hooksecurefunc("QuestLogQuests_Update", Showlevel)

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