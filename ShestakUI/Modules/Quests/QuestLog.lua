local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Quest level(yQuestLevel by Yleaf)
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
				questLogTitle:SetText("["..level.."] "..title)
				QuestLogTitleButton_Resize(questLogTitle)
			end
		end
	end
end
hooksecurefunc("QuestLog_Update", questlevel)
QuestLogScrollFrameScrollBar:HookScript("OnValueChanged", questlevel)

----------------------------------------------------------------------------------------
--	CTRL+Click to abandon a quest or ALT+Click to share a quest(by Suicidal Katt)
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

----------------------------------------------------------------------------------------
--	Count of daily quests(DailyQuestCounter by Karl_w_w)
----------------------------------------------------------------------------------------
hooksecurefunc("QuestLog_UpdateQuestCount", function()
	local dailyQuestsComplete = GetDailyQuestsCompleted()
	local parent = QuestLogCount:GetParent()
	local width = QuestLogQuestCount:GetWidth()

	if not QuestLogDailyQuestCount then
		QuestLogDailyQuestCount = QuestLogCount:CreateFontString("QuestLogDailyQuestCount", "ARTWORK", "GameFontNormalSmall")
		QuestLogDailyQuestCount:SetPoint("TOPRIGHT", QuestLogQuestCount, "BOTTOMRIGHT", 0, -2)
	end

	if not QuestLogDailyQuestCountMouseOverFrame then
		QuestLogDailyQuestCountMouseOverFrame = CreateFrame("Frame", "QuestLogDailyQuestCountMouseOverFrame", QuestLogCount)
		QuestLogDailyQuestCountMouseOverFrame:SetAllPoints(QuestLogCount)
		QuestLogDailyQuestCountMouseOverFrame:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(format(QUEST_LOG_DAILY_TOOLTIP, GetDailyQuestsCompleted(), SecondsToTime(GetQuestResetTime(), nil, 1)))
			end)
		QuestLogDailyQuestCountMouseOverFrame:SetScript("OnLeave", GameTooltip_Hide)
	end

	if dailyQuestsComplete > 0 then
		QuestLogDailyQuestCount:SetFormattedText(QUEST_LOG_DAILY_COUNT_TEMPLATE, dailyQuestsComplete)
		QuestLogDailyQuestCount:Show()
		if QuestLogDailyQuestCount:GetWidth() > width then
			width = QuestLogDailyQuestCount:GetWidth()
		end
		QuestLogCount:SetHeight(32)
		QuestLogCount:SetPoint("TOPLEFT", parent, "TOPLEFT", 70, -26)
	else
		QuestLogDailyQuestCount:Hide()
		QuestLogCount:SetHeight(20)
		QuestLogCount:SetPoint("TOPLEFT", parent, "TOPLEFT", 70, -33)
	end
	QuestLogCount:SetWidth(width + 15)
end)