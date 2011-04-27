local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Quest level(yQuestLevel by yleaf)
----------------------------------------------------------------------------------------
local function questlevel()
	local buttons = QuestLogScrollFrame.buttons
	local numButtons = #buttons
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)
	local numEntries, numQuests = GetNumQuestLogEntries()
	
	for i = 1, numButtons do
		local questIndex = i + scrollOffset
		local questLogTitle = buttons[i]
		if questIndex <= numEntries then
			local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questIndex)
			if not isHeader then
				questLogTitle:SetText("[" .. level .. "] " .. title)
				QuestLogTitleButton_Resize(questLogTitle)
			end
		end
	end
end
hooksecurefunc("QuestLog_Update", questlevel)
QuestLogScrollFrameScrollBar:HookScript("OnValueChanged", questlevel)

----------------------------------------------------------------------------------------
--	CTRL+Click to abandon a quest or ALT+Click to share a quest(by Suicidalkatt)
----------------------------------------------------------------------------------------
hooksecurefunc("QuestLogTitleButton_OnClick", function(self, button)
	local questIndex = self:GetID()
	local questName = self:GetText()
	if IsModifiedClick() then
		if self.isHeader then return end
		if IsControlKeyDown() then
			QuestLog_SetSelection(questIndex)
			AbandonQuest()
			QuestLog_Update()
			QuestLog_SetSelection(questIndex)
		elseif IsAltKeyDown() then
			QuestLog_SetSelection(questIndex)
			if GetQuestLogPushable() then
				QuestLogPushQuest()
			end
		end
	end
end)