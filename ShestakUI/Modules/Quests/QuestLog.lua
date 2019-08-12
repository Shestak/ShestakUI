local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Quest level
----------------------------------------------------------------------------------------
local function Showlevel(_, _, _, title, level, _, isHeader, _, _, _, questID)
	for button in pairs(QuestScrollFrame.titleFramePool.activeObjects) do
		if title and not isHeader and button.questID == questID then
			local title = level ~= T.level and "["..level.."] "..title or title
			local height = button.Text:GetHeight()
			button.Text:SetText(title)
			button.Text:SetWidth(190)
			button.Check:SetPoint("LEFT", button.Text, button.Text:GetWrappedWidth() + 2, 0)
			button:SetHeight(button:GetHeight() - height + button.Text:GetHeight())
		end
	end
end
hooksecurefunc("QuestLogQuests_AddQuestButton", Showlevel)

----------------------------------------------------------------------------------------
--	Ctrl+Click to abandon a quest or Alt+Click to share a quest(by Suicidal Katt)
----------------------------------------------------------------------------------------
hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self)
	local questLogIndex = GetQuestLogIndexByID(self.questID)
	if IsControlKeyDown() then
		CloseDropDownMenus()
		QuestMapQuestOptions_AbandonQuest(self.questID)
	elseif IsAltKeyDown() and GetQuestLogPushable(questLogIndex) then
		CloseDropDownMenus()
		QuestMapQuestOptions_ShareQuest(self.questID)
	end
end)

hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderClick", function(_, block)
	local questLogIndex = block.id
	if IsControlKeyDown() then
		CloseDropDownMenus()
		QuestMapQuestOptions_AbandonQuest(questLogIndex)
	elseif IsAltKeyDown() and GetQuestLogPushable(questLogIndex) then
		CloseDropDownMenus()
		QuestLogPushQuest(questLogIndex)
	end
end)