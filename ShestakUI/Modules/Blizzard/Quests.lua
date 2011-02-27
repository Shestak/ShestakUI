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
--	Quest automation(idQuestAutomation by Industrial)
----------------------------------------------------------------------------------------
if SettingsCF.misc.auto_quest == true then
	local addon = CreateFrame('Frame')
	addon.completed_quests = {}
	addon.incomplete_quests = {}

	function addon:canAutomate ()
		if IsShiftKeyDown() then
			return false
		else
			return true
		end
	end

	function addon:strip_text (text)
		if not text then return end
		text = text:gsub('|c%x%x%x%x%x%x%x%x(.-)|r','%1')
		text = text:gsub('%[.*%]%s*','')
		text = text:gsub('(.+) %(.+%)', '%1')
		text = text:trim()
		return text
	end

	function addon:QUEST_PROGRESS ()
		if not self:canAutomate() then return end
		if IsQuestCompletable() then
			CompleteQuest()
		end
	end

	function addon:QUEST_LOG_UPDATE ()
		if not self:canAutomate() then return end
		local start_entry = GetQuestLogSelection()
		local num_entries = GetNumQuestLogEntries()
		local title
		local is_complete
		local no_objectives

		self.completed_quests = {}
		self.incomplete_quests = {}

		if num_entries > 0 then
			for i = 1, num_entries do
				SelectQuestLogEntry(i)
				title, _, _, _, _, _, is_complete = GetQuestLogTitle(i)
				no_objectives = GetNumQuestLeaderBoards(i) == 0
				if title then
					if is_complete or no_objectives then
						self.completed_quests[title] = true
					else
						self.incomplete_quests[title] = true
					end
				end
			end
		end
		SelectQuestLogEntry(start_entry)
	end

	function addon:GOSSIP_SHOW ()
		if not self:canAutomate() then return end

		local button
		local text

		for i = 1, 32 do
			button = _G['GossipTitleButton' .. i]
			if button:IsVisible() then
				text = self:strip_text(button:GetText())
				ABCDE={button:GetText(), text}
				if button.type == 'Available' then
					button:Click()
				elseif button.type == 'Active' then
					if self.completed_quests[text] then
						button:Click()
					end
				end
			end
		end
	end

	function addon:QUEST_GREETING (...)
		if not self:canAutomate() then return end

		local button
		local text

		for i = 1, 32 do
			button = _G['QuestTitleButton' .. i]
			if button:IsVisible() then
				text = self:strip_text(button:GetText())
				if self.completed_quests[text] then
					button:Click()
				elseif not self.incomplete_quests[text] then
					button:Click()
				end
			end
		end
	end

	function addon:QUEST_DETAIL ()
		if not self:canAutomate() then return end
		AcceptQuest()
	end

	function addon:QUEST_COMPLETE (event)
		if not self:canAutomate() then return end
		if GetNumQuestChoices() <= 1 then
			GetQuestReward(QuestFrameRewardPanel.itemChoice)
		end
	end

	function addon.onevent (self, event, ...)
		if self[event] then
			self[event](self, ...)
		end
	end

	addon:SetScript('OnEvent', addon.onevent)
	addon:RegisterEvent('GOSSIP_SHOW')
	addon:RegisterEvent('QUEST_COMPLETE')
	addon:RegisterEvent('QUEST_DETAIL')
	addon:RegisterEvent('QUEST_FINISHED')
	addon:RegisterEvent('QUEST_GREETING')
	addon:RegisterEvent('QUEST_LOG_UPDATE')
	addon:RegisterEvent('QUEST_PROGRESS')

	_G.idQuestAutomation = addon
end