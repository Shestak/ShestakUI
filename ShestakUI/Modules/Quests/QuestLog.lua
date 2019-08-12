local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Quest level
----------------------------------------------------------------------------------------
local function Showlevel(_, _, _, title, level, _, isHeader, _, _, _, questID)
	for button in pairs(QuestScrollFrame.titleFramePool.activeObjects) do
		if title and not isHeader and button.questID == questID then
			local title = level ~= T.level and "["..level.."] "..title or title
			button.Text:SetText(title)
			button.Text:SetPoint("TOPLEFT", 24, -5)
			button.Text:SetWidth(205)
			button.Text:SetWordWrap(false)
			button.Check:SetPoint("LEFT", button.Text, button.Text:GetWrappedWidth(), 0)
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