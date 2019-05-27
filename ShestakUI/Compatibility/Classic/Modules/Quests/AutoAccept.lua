local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.automation.accept_quest ~= true then return end

----------------------------------------------------------------------------------------
--	Quest automation(QuickQuest by p3lim)
----------------------------------------------------------------------------------------
local QuickQuest = CreateFrame("Frame")
QuickQuest:SetScript("OnEvent", function(self, event, ...) self[event](...) end)

local QuickQuestDB = {
	toggle = true,
	items = true,
	faireport = true,
	gossip = true,
	gossipraid = 1,
	modifier = "SHIFT",
	reverse = false,
	share = false,
	withered = true,
	nomi = true,
}

local QuickQuestBlacklistDB = {
	items = {}
}

local metatable = {
	__call = function(methods, ...)
		for _, method in next, methods do
			method(...)
		end
	end
}

local modifier = false
function QuickQuest:Register(event, method, override)
	local newmethod
	if not override then
		newmethod = function(...)
			if QuickQuestDB.reverse == modifier then
				method(...)
			end
		end
	end

	local methods = self[event]
	if methods then
		self[event] = setmetatable({methods, newmethod or method}, metatable)
	else
		self[event] = newmethod or method
		self:RegisterEvent(event)
	end
end

local function GetNPCID()
	return tonumber(string.match(UnitGUID('npc') or '', '%w+%-.-%-.-%-.-%-.-%-(.-)%-'))
end

local ignoreQuestNPC = {}

local function GetQuestLogQuests(onlyComplete)
	local quests = {}
	for index = 1, GetNumQuestLogEntries() do
		local title, _, _, isHeader, _, isComplete, _, questID = GetQuestLogTitle(index)
		if(not isHeader) then
			if(onlyComplete and isComplete or not onlyComplete) then
				quests[title] = questID
			end
		end
	end

	return quests
end

QuickQuest:Register("QUEST_GREETING", function()
	local npcID = GetNPCID()
	if(ignoreQuestNPC[npcID]) then
		return
	end

	local active = GetNumActiveQuests()
	if(active > 0) then
		local logQuests = GetQuestLogQuests(true)
		for index = 1, active do
			local name, complete = GetActiveTitle(index)
			if(complete) then
				local questID = logQuests[name]
				if(not questID) then
					SelectActiveQuest(index)
				else
					local _, _, worldQuest = GetQuestTagInfo(questID)
					if(not worldQuest) then
						SelectActiveQuest(index)
					end
				end
			end
		end
	end

	local available = GetNumAvailableQuests()
	if(available > 0) then
		for index = 1, available do
			local isTrivial, _, _, _, isIgnored = GetAvailableQuestInfo(index)
			if(not isTrivial and not isIgnored) then
				SelectAvailableQuest(index)
			end
		end
	end
end)

local ignoreGossipNPC = {}

local function GetAvailableGossipQuestInfo(index)
	local name, level, isTrivial, frequency, isRepeatable, isLegendary, isIgnored = select(((index * 7) - 7) + 1, GetGossipAvailableQuests())
	return name, level, isTrivial, isIgnored, isRepeatable, frequency == 2, frequency == 3, isLegendary
end

local function GetActiveGossipQuestInfo(index)
	local name, level, isTrivial, isComplete, isLegendary, isIgnored = select(((index * 6) - 6) + 1, GetGossipActiveQuests())
	return name, level, isTrivial, isIgnored, isComplete, isLegendary
end

QuickQuest:Register("GOSSIP_SHOW", function()
	local npcID = GetNPCID()
	if(ignoreQuestNPC[npcID]) then
		return
	end

	local active = GetNumGossipActiveQuests()
	if(active > 0) then
		local logQuests = GetQuestLogQuests(true)
		for index = 1, active do
			local name, _, _, _, completed = GetActiveGossipQuestInfo(index)
			if(completed) then
				local questID = logQuests[name]
				if(not questID) then
					SelectGossipActiveQuest(index)
				else
					local _, _, worldQuest = GetQuestTagInfo(questID)
					if(not worldQuest) then
						SelectGossipActiveQuest(index)
					end
				end
			end
		end
	end

	local available = GetNumGossipAvailableQuests()
	if(available > 0) then
		for index = 1, available do
			local _, _, trivial, ignored = GetAvailableGossipQuestInfo(index)
			if(not trivial and not ignored) then
				SelectGossipAvailableQuest(index)
			elseif(trivial and npcID == 64337 and QuickQuestDB.nomi) then
				SelectGossipAvailableQuest(index)
			end
		end
	end

	if(available == 0 and active == 0 and GetNumGossipOptions() == 1) then
		if(string.match((GetGossipOptions()), TRACKER_HEADER_PROVINGGROUNDS)) then
			-- ignore proving grounds queue
			return
		end

		if(QuickQuestDB.faireport) then
			if(npcID == 57850) then
				return SelectGossipOption(1)
			end
		end

		if(QuickQuestDB.gossip) then
			local _, instance, _, _, _, _, _, mapID = GetInstanceInfo()
			if(QuickQuestDB.withered and instance == "scenario" and mapID == 1626) then return end

			if(instance == "raid" and QuickQuestDB.gossipraid > 0) then
				if(GetNumGroupMembers() > 1 and QuickQuestDB.gossipraid < 2) then
					return
				end

				SelectGossipOption(1)
			elseif(instance ~= "raid" and not ignoreGossipNPC[npcID]) then
				SelectGossipOption(1)
			end
		end
	end
end)

local darkmoonNPC = {}

QuickQuest:Register("GOSSIP_CONFIRM", function(index)
	if(not QuickQuestDB.faireport) then return end

	local npcID = GetNPCID()
	if(npcID and darkmoonNPC[npcID]) then
		SelectGossipOption(index, "", true)
		StaticPopup_Hide("GOSSIP_CONFIRM")
	end
end)

QuestFrame:UnregisterEvent("QUEST_DETAIL")
QuickQuest:Register("QUEST_DETAIL", function(...)
	if(not QuickQuestBlacklistDB[GetQuestID()]) then
		QuestFrame_OnEvent(QuestFrame, "QUEST_DETAIL", ...)
	end
end, true)

QuickQuest:Register("QUEST_DETAIL", function(questStartItemID)
	--[[
	if(questStartItemID ~= nil and questStartItemID ~= 0) then
		AcknowledgeAutoAcceptQuest()
	else
		-- XXX: no way to tell if the quest is trivial
		AcceptQuest()
	end
	--]]
	AcceptQuest()
end)

QuickQuest:Register("QUEST_ACCEPTED", function(id)
	if(QuickQuestDB.share) then
		QuestLogPushQuest(id)
	end
end)

local choiceQueue
QuickQuest:Register("QUEST_ITEM_UPDATE", function()
	if(choiceQueue and QuickQuest[choiceQueue]) then
		QuickQuest[choiceQueue]()
	end
end, true)

QuickQuest:Register("QUEST_PROGRESS", function()
	if(IsQuestCompletable()) then
		local requiredItems = GetNumQuestItems()
		if(requiredItems > 0) then
			for index = 1, requiredItems do
				local link = GetQuestItemLink("required", index)
				if(link) then
					local id = tonumber(string.match(link, "item:(%d+)"))
					for _, itemID in next, QuickQuestBlacklistDB.items do
						if(itemID == id) then
							return
						end
					end
				else
					choiceQueue = "QUEST_PROGRESS"
					return
				end
			end
		end

		CompleteQuest()
	end
end)

QuickQuest:Register("QUEST_COMPLETE", function()
	local choices = GetNumQuestChoices()
	if(choices <= 1) then
		GetQuestReward(1)
	end
end)

local cashRewards = {}

QuickQuest:Register("QUEST_COMPLETE", function()
	local choices = GetNumQuestChoices()
	if(choices > 1) then
		local bestValue, bestIndex = 0

		for index = 1, choices do
			local link = GetQuestItemLink("choice", index)
			if(link) then
				local _, _, _, _, _, _, _, _, _, _, value = GetItemInfo(link)
				value = cashRewards[tonumber(string.match(link, "item:(%d+):"))] or value

				if(value > bestValue) then
					bestValue, bestIndex = value, index
				end
			else
				choiceQueue = "QUEST_COMPLETE"
				return GetQuestItemInfo("choice", index)
			end
		end

		if(bestIndex) then
			QuestInfoItem_OnClick(QuestInfoRewardsFrame.RewardButtons[bestIndex])
		end
	end
end, true)

local sub = string.sub
QuickQuest:Register("MODIFIER_STATE_CHANGED", function(key, state)
	if(sub(key, 2) == QuickQuestDB.modifier) then
		modifier = state == 1
	end
end, true)