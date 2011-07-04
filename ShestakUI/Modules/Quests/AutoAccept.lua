local T, C, L = unpack(select(2, ...))
if not C.misc.auto_quest == true then return end

----------------------------------------------------------------------------------------
--	Quest automation(Monomyth by p3lim)
----------------------------------------------------------------------------------------
local Monomyth = CreateFrame("Frame")
Monomyth:SetScript("OnEvent", function(self, event, ...) self[event](...) end)

function Monomyth:Register(event, func)
	self:RegisterEvent(event)
	self[event] = function(...)
		if IsShiftKeyDown() then
			if event == "QUEST_DETAIL" then
				QuestFrame_OnEvent(nil, event)
			end
		else
			func(...)
		end
	end
end

Monomyth:Register("QUEST_GREETING", function()
	local active = GetNumActiveQuests()
	if active > 0 then
		for index = 1, active do
			local _, complete = GetActiveTitle(index)
			if complete then
				SelectActiveQuest(index)
			end
		end
	end

	local available = GetNumAvailableQuests()
	if available > 0 then
		for index = 1, available do
			SelectAvailableQuest(index)
		end
	end
end)

local function IsQuestCompleted(index)
	return not not select(index * 4, GetGossipActiveQuests())
end

Monomyth:Register("GOSSIP_SHOW", function()
	local active = GetNumGossipActiveQuests()
	if active > 0 then
		for index = 1, active do
			if IsQuestCompleted(index) then
				SelectGossipActiveQuest(index)
			end
		end
	end

	local available = GetNumGossipAvailableQuests()
	if available > 0 then
		for index = 1, available do
			SelectGossipAvailableQuest(index)
		end
	end

	if available == 0 and active == 0 and GetNumGossipOptions() == 1 then
		local _, type = GetGossipOptions()
		if type == "gossip" then
			SelectGossipOption(1)
		end
	end
end)

QuestFrame:UnregisterEvent("QUEST_DETAIL")
Monomyth:Register("QUEST_DETAIL", function()
	if QuestGetAutoAccept() then
		CloseQuest()
	else
		QuestFrame_OnEvent(nil, "QUEST_DETAIL")
		AcceptQuest()
	end
end)

Monomyth:Register("QUEST_ACCEPT_CONFIRM", AcceptQuest)

Monomyth:Register("QUEST_PROGRESS", function()
	if IsQuestCompletable() then
		CompleteQuest()
	end
end)

Monomyth:Register("QUEST_COMPLETE", function()
	if GetNumQuestChoices() <= 1 then
		GetQuestReward(QuestFrameRewardPanel.itemChoice)
	elseif GetNumQuestChoices() > 1 then
		local bestValue, bestIndex = 0

		for index = 1, GetNumQuestChoices() do
			local link = GetQuestItemLink("choice", index)
			if not link then return	end

			local _, _, _, _, _, _, _, _, _, _, value = GetItemInfo(link)
			if value > bestValue then
				bestValue, bestIndex = value, index
			end
		end

		if bestIndex then
			_G["QuestInfoItem" .. bestIndex]:Click()
		end
	end
end)

Monomyth:Register("QUEST_AUTOCOMPLETE", function()
	for index = 1, GetNumAutoQuestPopUps() do
		local quest, type = GetAutoQuestPopUp(index)

		if type == "COMPLETE" then
			-- The quest may not be considered complete by the server
			-- We should check then queue and try again when it is
			ShowQuestComplete(GetQuestLogIndexByID(quest))
		end
	end
end)

Monomyth:Register("BAG_UPDATE", function(bag)
	if bag < 0 then return end

	for slot = 1, GetContainerNumSlots(bag) do
		local _, id, active = GetContainerItemQuestInfo(bag, slot)
		if id and not active then
			-- We should check if the item is cached yet
			-- The negative result of this is a disconnect
			UseContainerItem(bag, slot)
		end
	end
end)