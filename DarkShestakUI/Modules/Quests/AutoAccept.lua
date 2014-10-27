local T, C, L, _ = unpack(select(2, ...))
if C.automation.accept_quest ~= true then return end

----------------------------------------------------------------------------------------
--	Quest automation(Monomyth by p3lim)
----------------------------------------------------------------------------------------
local Monomyth = CreateFrame("Frame")
Monomyth:SetScript("OnEvent", function(self, event, ...) self[event](...) end)

local atBank, atMail, atMerchant

function Monomyth:Register(event, func)
	self:RegisterEvent(event)
	self[event] = function(...)
		if not (IsShiftKeyDown() or IsAltKeyDown()) then
			func(...)
		end
	end
end

local function IsTrackingTrivial()
	for index = 1, GetNumTrackingTypes() do
		local name, _, active = GetTrackingInfo(index)
		if name == MINIMAP_TRACKING_TRIVIAL_QUESTS then
			return active
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
			if not IsAvailableQuestTrivial(index) or IsTrackingTrivial() then
				SelectAvailableQuest(index)
			end
		end
	end
end)

local function IsGossipQuestCompleted(index)
	return not not select(((index * 5) - 5) + 4, GetGossipActiveQuests())
end

local function IsGossipQuestTrivial(index)
	return not not select(((index * 6) - 6) + 3, GetGossipAvailableQuests())
end

local function GetCreatureID()
	local type, _, _, _, _, id = string.split(":", UnitGUID("npc") or "")
	if type == "Creature" and id and tonumber(id) then
		return tonumber(id)
	end
end

Monomyth:Register("GOSSIP_SHOW", function()
	local active = GetNumGossipActiveQuests()
	if active > 0 then
		for index = 1, active do
			if IsGossipQuestCompleted(index) then
				SelectGossipActiveQuest(index)
			end
		end
	end

	local available = GetNumGossipAvailableQuests()
	if available > 0 then
		for index = 1, available do
			if not IsGossipQuestTrivial(index) or IsTrackingTrivial() then
				SelectGossipAvailableQuest(index)
			end
		end
	end

	local _, instance = GetInstanceInfo()
	if available == 0 and active == 0 and GetNumGossipOptions() == 1 and instance ~= "raid" then
		local _, type = GetGossipOptions()
		if type == "gossip" then
			SelectGossipOption(1)
			return
		end
	end

	local creatureID = GetCreatureID()
	if creatureID and creatureID == 57850 then
		SelectGossipOption(1)
	end
end)

local darkmoonNPC = {
	[57850] = true,	-- Teleportologist Fozlebub
	[55382] = true,	-- Darkmoon Faire Mystic Mage (Horde)
	[54334] = true,	-- Darkmoon Faire Mystic Mage (Alliance)
}

Monomyth:Register("GOSSIP_CONFIRM", function(index)
	local creatureID = GetCreatureID()
	if creatureID and darkmoonNPC[creatureID] then
		SelectGossipOption(index, "", true)
		StaticPopup_Hide("GOSSIP_CONFIRM")
	end
end)

Monomyth:Register("QUEST_DETAIL", function()
	if not QuestGetAutoAccept() then
		AcceptQuest()
	end
end)

Monomyth:Register("QUEST_ACCEPT_CONFIRM", AcceptQuest)

Monomyth:Register("QUEST_ACCEPTED", function(id)
	if QuestFrame:IsShown() and QuestGetAutoAccept() then
		CloseQuest()
	end
end)

Monomyth:Register("QUEST_PROGRESS", function()
	if IsQuestCompletable() then
		CompleteQuest()
	end
end)

local choiceQueue, choiceFinished
Monomyth:Register("QUEST_ITEM_UPDATE", function(...)
	if choiceQueue then
		Monomyth.QUEST_COMPLETE()
	end
end)

Monomyth:Register("QUEST_COMPLETE", function()
	local choices = GetNumQuestChoices()
	if choices < 1 then
		GetQuestReward(QuestFrameRewardPanel.itemChoice)
	elseif choices == 1 then
		GetQuestReward(1)
	elseif choices > 1 then
		local bestValue, bestIndex = 0

		for index = 1, choices do
			local link = GetQuestItemLink("choice", index)
			if link then
				local _, _, _, _, _, _, _, _, _, _, value = GetItemInfo(link)

				if string.match(link, "item:45724:") then
					-- Champion's Purse, contains 10 gold
					value = 1e5
				end

				if value > bestValue then
					bestValue, bestIndex = value, index
				end
			else
				choiceQueue = true
				return GetQuestItemInfo("choice", index)
			end
		end

		if bestIndex then
			QuestInfoRewardsFrame.RewardButtons[bestIndex]:Click()
		end
	end
end)

Monomyth:Register("QUEST_FINISHED", function()
	choiceQueue = nil
	autoCompleteIndex = nil
end)

Monomyth:Register("QUEST_AUTOCOMPLETE", function(id)
	local index = GetQuestLogIndexByID(id)
	if GetQuestLogIsAutoComplete(index) then
		-- The quest might not be considered complete, investigate later
		ShowQuestComplete(index)
		autoCompleteIndex = index
	end
end)

Monomyth:Register("BAG_UPDATE_DELAYED", function()
	if autoCompleteIndex then
		ShowQuestComplete(autoCompleteIndex)
		autoCompleteIndex = nil
	end
end)

Monomyth:Register("BANKFRAME_OPENED", function()
	atBank = true
end)

Monomyth:Register("BANKFRAME_CLOSED", function()
	atBank = false
end)

Monomyth:Register("GUILDBANKFRAME_OPENED", function()
	atBank = true
end)

Monomyth:Register("GUILDBANKFRAME_CLOSED", function()
	atBank = false
end)

Monomyth:Register("MAIL_SHOW", function()
	atMail = true
end)

Monomyth:Register("MAIL_CLOSED", function()
	atMail = false
end)

Monomyth:Register("MERCHANT_SHOW", function()
	atMerchant = true
end)

Monomyth:Register("MERCHANT_CLOSED", function()
	atMerchant = false
end)

local ignoredItems = {
	-- Inscription weapons
	[31690] = true,	-- Inscribed Tiger Staff
	[31691] = true,	-- Inscribed Crane Staff
	[31692] = true,	-- Inscribed Serpent Staff

	-- Darkmoon Faire artifacts
	[29443] = true,	-- Imbued Crystal
	[29444] = true,	-- Monstrous Egg
	[29445] = true,	-- Mysterious Grimoire
	[29446] = true,	-- Ornate Weapon
	[29451] = true,	-- A Treatise on Strategy
	[29456] = true,	-- Banner of the Fallen
	[29457] = true,	-- Captured Insignia
	[29458] = true,	-- Fallen Adventurer's Journal
	[29464] = true,	-- Soothsayer's Runes
}

Monomyth:Register("BAG_UPDATE", function(bag)
	if atBank or atMail or atMerchant then return end

	for slot = 1, GetContainerNumSlots(bag) do
		local _, id, active = GetContainerItemQuestInfo(bag, slot)
		if id and not active and not IsQuestFlaggedCompleted(id) and not ignoredItems[id] then
			UseContainerItem(bag, slot)
		end
	end
end)

local errors = {
	[ERR_QUEST_ALREADY_DONE] = true,
	[ERR_QUEST_FAILED_LOW_LEVEL] = true,
	[ERR_QUEST_ALREADY_DONE_DAILY] = true,
	[ERR_QUEST_NEED_PREREQS] = true,
}

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function(self, event, message)
	return errors[message]
end)

QuestInfoDescriptionText.SetAlphaGradient = function() end