local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

----------------------------------------------------------------------------------------
--	Quest level
----------------------------------------------------------------------------------------
hooksecurefunc("QuestLogQuests_Update", function()
	for button in QuestScrollFrame.titleFramePool:EnumerateActive() do
		if button and button:IsShown() then
			local link = GetQuestLink(button.questID)
			if link then
				local level = strmatch(link, "quest:%d+:(%d+)")
				local title = button.Text:GetText()
				if level and title then
					local height = button.Text:GetHeight()
					button.Text:SetFormattedText("[%d] %s", level, title)
					button.Check:SetPoint("LEFT", button.Text, button.Text:GetWrappedWidth() + 2, 0)
					button:SetHeight(button:GetHeight() - height + button.Text:GetHeight())
				end
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Ctrl+Click to abandon a quest or Alt+Click to share a quest(by Suicidal Katt)
----------------------------------------------------------------------------------------
hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self)
	local questLogIndex = GetQuestLogIndexByID(self.questID)
	if IsControlKeyDown() then
		QuestMapQuestOptions_AbandonQuest(self.questID)
	elseif IsAltKeyDown() and GetQuestLogPushable(questLogIndex) then
		QuestMapQuestOptions_ShareQuest(self.questID)
	end
end)

hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderClick", function(self, block)
	local questLogIndex = block.id
	SetAbandonQuest()
	if IsControlKeyDown() then
		local items = GetAbandonQuestItems()
		if items then
			StaticPopup_Hide("ABANDON_QUEST")
			StaticPopup_Show("ABANDON_QUEST_WITH_ITEMS", GetAbandonQuestName(), items)
		else
			StaticPopup_Hide("ABANDON_QUEST_WITH_ITEMS")
			StaticPopup_Show("ABANDON_QUEST", GetAbandonQuestName())
		end
	elseif IsAltKeyDown() and GetQuestLogPushable(questLogIndex) then
		QuestLogPushQuest(questLogIndex)
	end
end)