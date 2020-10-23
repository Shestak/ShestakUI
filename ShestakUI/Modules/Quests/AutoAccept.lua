local T, C, L, _ = unpack(select(2, ...))
if C.automation.accept_quest ~= true then return end

----------------------------------------------------------------------------------------
--	Quest automation(QuickQuest by p3lim)
----------------------------------------------------------------------------------------
local _, ns = ...
local QuickQuestDB = {
	general = {
		share = false,
		skipgossip = true,
		skipgossipwhen = 1,
		paydarkmoonfaire = true,
		pausekey = 'SHIFT',
		pausekeyreverse = false,
	},
	blocklist = {
		items = {
			-- Inscription weapons
			[31690] = 79343, -- Inscribed Tiger Staff
			[31691] = 79340, -- Inscribed Crane Staff
			[31692] = 79341, -- Inscribed Serpent Staff

			-- Darkmoon Faire artifacts
			[29443] = 71635, -- Imbued Crystal
			[29444] = 71636, -- Monstrous Egg
			[29445] = 71637, -- Mysterious Grimoire
			[29446] = 71638, -- Ornate Weapon
			[29451] = 71715, -- A Treatise on Strategy
			[29456] = 71951, -- Banner of the Fallen
			[29457] = 71952, -- Captured Insignia
			[29458] = 71953, -- Fallen Adventurer's Journal
			[29464] = 71716, -- Soothsayer's Runes

			-- Tiller Gifts
			['progress_79264'] = 79264, -- Ruby Shard
			['progress_79265'] = 79265, -- Blue Feather
			['progress_79266'] = 79266, -- Jade Cat
			['progress_79267'] = 79267, -- Lovely Apple
			['progress_79268'] = 79268, -- Marsh Lily

			-- Garrison scouting missives
			[38180] = 122424, -- Scouting Missive: Broken Precipice
			[38193] = 122423, -- Scouting Missive: Broken Precipice
			[38182] = 122418, -- Scouting Missive: Darktide Roost
			[38196] = 122417, -- Scouting Missive: Darktide Roost
			[38179] = 122400, -- Scouting Missive: Everbloom Wilds
			[38192] = 122404, -- Scouting Missive: Everbloom Wilds
			[38194] = 122420, -- Scouting Missive: Gorian Proving Grounds
			[38202] = 122419, -- Scouting Missive: Gorian Proving Grounds
			[38178] = 122402, -- Scouting Missive: Iron Siegeworks
			[38191] = 122406, -- Scouting Missive: Iron Siegeworks
			[38184] = 122413, -- Scouting Missive: Lost Veil Anzu
			[38198] = 122414, -- Scouting Missive: Lost Veil Anzu
			[38177] = 122403, -- Scouting Missive: Magnarok
			[38190] = 122399, -- Scouting Missive: Magnarok
			[38181] = 122421, -- Scouting Missive: Mok'gol Watchpost
			[38195] = 122422, -- Scouting Missive: Mok'gol Watchpost
			[38185] = 122411, -- Scouting Missive: Pillars of Fate
			[38199] = 122409, -- Scouting Missive: Pillars of Fate
			[38187] = 122412, -- Scouting Missive: Shattrath Harbor
			[38201] = 122410, -- Scouting Missive: Shattrath Harbor
			[38186] = 122408, -- Scouting Missive: Skettis
			[38200] = 122407, -- Scouting Missive: Skettis
			[38183] = 122416, -- Scouting Missive: Socrethar's Rise
			[38197] = 122415, -- Scouting Missive: Socrethar's Rise
			[38176] = 122405, -- Scouting Missive: Stonefury Cliffs
			[38189] = 122401, -- Scouting Missive: Stonefury Cliffs

			-- Misc
			[31664] = 88604, -- Nat's Fishing Journal
		},
		npcs = {
			-- seals/coins
			[88570] = true, -- Fate-Twister Tiklal (6.0 coins, horde)
			[87391] = true, -- Fate-Twister Seress (6.0 coins, alliance)
			[111243] = true, -- Archmage Lan'dalock (7.0 coins)
			[141584] = true, -- Zurvan (8.0 coins, horde)
			[142063] = true, -- Tezran (8.0 coins, alliance)

			-- valuable resources
			[119388] = true, -- Chieftain Hatuun (Argus resources)
			[124312] = true, -- High Exarch Turalyon (Argus resources)
			[126954] = true, -- High Exarch Turalyon (Argus resources)
			[127037] = true, -- Nabiru (Argus resources)

			-- misc
			[103792] = true, -- Griftah (his quests are scams)

			-- Bodyguards
			[86945] = true, -- Aeda Brightdawn (Horde)
			[86933] = true, -- Vivianne (Horde)
			[86927] = true, -- Delvar Ironfist (Alliance)
			[86934] = true, -- Defender Illona (Alliance)
			[86682] = true, -- Tormmok
			[86964] = true, -- Leorajh
			[86946] = true, -- Talonpriest Ishaal

			-- Sassy Imps
			[95139] = true,
			[95141] = true,
			[95142] = true,
			[95143] = true,
			[95144] = true,
			[95145] = true,
			[95146] = true,
			[95200] = true,
			[95201] = true,

			-- misc
			[143925] = true, -- Dark Iron Mole Machine (Dark Iron Dwarf racial)
		},
	},
}

local EventHandler = CreateFrame('Frame')
EventHandler.events = {}
EventHandler:SetScript('OnEvent', function(self, event, ...)
	self:Trigger(event, ...)
end)

function EventHandler:Register(event, func)
	local registered = not not self.events[event]
	if not registered then
		self.events[event] = {}
	end

	for _, f in next, self.events[event] do
		if f == func then
			-- avoid the same function being registered multiple times for the same event
			return
		end
	end

	table.insert(self.events[event], func)

	if not registered then
		self:RegisterEvent(event)
	end
end

function EventHandler:Unregister(event, func)
	local funcs = self.events[event]
	if funcs then
		for i, f in next, funcs do
			if f == func then
				funcs[i] = nil
				break
			end
		end
	end

	if funcs and #funcs == 0 then
		self:UnregisterEvent(event)
	end
end

function EventHandler:Trigger(event, ...)
	local funcs = self.events[event]
	if funcs then
		for _, func in next, funcs do
			if type(func) == 'string' then
				self:Trigger(func, ...)
			else
				if func(...) then
					self:Unregister(event, func)
				end
			end
		end
	end
end

ns.EventHandler = EventHandler

local NPC_ID_PATTERN = '%w+%-.-%-.-%-.-%-.-%-(.-)%-'
function ns.GetNPCID(unit)
	local npcGUID = UnitGUID(unit or 'npc')
	if npcGUID then
		return tonumber(npcGUID:match(NPC_ID_PATTERN))
	end
end

function ns.ShouldAcceptTrivialQuests()
	for index = 1, GetNumTrackingTypes() do
		local name, _, isActive = GetTrackingInfo(index)
		if name == MINIMAP_TRACKING_TRIVIAL_QUESTS then
			return isActive
		end
	end
end

function ns.tLength(t)
	local count = 0
	for _ in next, t do
		count = count + 1
	end
	return count
end

local EventHandler = ns.EventHandler
local paused

local DARKMOON_ISLE_MAP_ID = 407
local DARKMOON_FAIRE_TELEPORT_NPC_ID = 57850 -- Teleportologist Fozlebub

local ignoredQuests = {}
local cashRewards = {
	[45724] = 1e5, -- Champion's Purse, 10 gold
	[64491] = 2e6, -- Royal Reward, 200 gold

	-- items from the Sixtrigger brothers quest chain in Stormheim
	[138127] = 15, -- Mysterious Coin, 15 copper
	[138129] = 11, -- Swatch of Priceless Silk, 11 copper
	[138131] = 24, -- Magical Sprouting Beans, 24 copper
	[138123] = 15, -- Shiny Gold Nugget, 15 copper
	[138125] = 16, -- Crystal Clear Gemstone, 16 copper
	[138133] = 27, -- Elixir of Endless Wonder, 27 copper
}
local darkmoonNPCs = {
	-- Darkmoon Faire teleporation NPCs
	[57850] = true, -- Teleportologist Fozlebub
	[55382] = true, -- Darkmoon Faire Mystic Mage (Horde)
	[54334] = true, -- Darkmoon Faire Mystic Mage (Alliance)
}
local rogueNPCs = {
	-- Rogue class hall doors
	[97004] = true, -- "Red" Jack Findle
	[96782] = true, -- Lucian Trias
	[93188] = true, -- Mongar
}

EventHandler:Register('GOSSIP_CONFIRM', function(index)
	-- triggered when a gossip confirm prompt is displayed
	if paused then
		return
	end

	if QuickQuestDB.general.paydarkmoonfaire and darkmoonNPCs[ns.GetNPCID()] then
		C_GossipInfo.SelectOption(index, '', true)

		-- this is considered an intrusive action, as we're modifying the UI
		StaticPopup_Hide('GOSSIP_CONFIRM')
	end
end)

EventHandler:Register('GOSSIP_SHOW', function()
	-- triggered when the player interacts with an NPC that presents dialogue
	if paused then
		return
	end

	local npcID = ns.GetNPCID()
	if QuickQuestDB.blocklist.npcs[npcID] then
		return
	end

	if C_Map.GetBestMapForUnit('player') == DARKMOON_ISLE_MAP_ID then
		-- we want to auto-accept the dialogues from Darkmoon Faire NPCs
		for index, info in next, C_GossipInfo.GetOptions() do
			if info.name:find('FF008E8') then
				-- TODO: see if there is something else than the color we can easily match with
				C_GossipInfo.SelectOption(index)
				return
			end
		end
	end

	if C_GossipInfo.GetNumActiveQuests() > 0 or C_GossipInfo.GetNumAvailableQuests() > 0 then
		-- bail if there is more than just dialogue
		return
	end

	if rogueNPCs[npcID] then
		-- automatically open doors to the rogue class hall in Dalaran
		C_GossipInfo.SelectOption(1)
		return
	end

	if QuickQuestDB.general.paydarkmoonfaire and npcID == DARKMOON_FAIRE_TELEPORT_NPC_ID then
		C_GossipInfo.SelectOption(1)
		return
	end

	if C_GossipInfo.GetNumOptions() == 1 and QuickQuestDB.general.skipgossip then
		-- automatically skip single dialogue under certain conditions
		local _, instanceType = GetInstanceInfo()
		if instanceType == 'raid' and QuickQuestDB.general.skipgossipwhen > 0 then
			if GetNumGroupMembers() == 0 or QuickQuestDB.general.skipgossipwhen == 2 then
				-- select dialogue if alone or when configured to "Always" while in a raid
				C_GossipInfo.SelectOption(1)
				return
			end
		elseif instanceType ~= 'raid' then
			-- always select single dialogue while outside a raid
			C_GossipInfo.SelectOption(1)
			return
		end
	end
end)

EventHandler:Register('GOSSIP_SHOW', function()
	-- triggered when the player interacts with an NPC that presents dialogue
	if paused then
		return
	end

	if QuickQuestDB.blocklist.npcs[ns.GetNPCID()] then
		return
	end

	-- turn in all completed quests
	for index, info in next, C_GossipInfo.GetActiveQuests() do
		if not ignoredQuests[info.questID] then
			if info.isComplete and not C_QuestLog.IsWorldQuest(info.questID) then
				C_GossipInfo.SelectActiveQuest(index)
			end
		end
	end

	-- accept all available quests
	for index, info in next, C_GossipInfo.GetAvailableQuests() do
		if not ignoredQuests[info.questID] then
			if not info.isTrivial or ns.ShouldAcceptTrivialQuests() then
				C_GossipInfo.SelectAvailableQuest(index)
			end
		end
	end
end)

EventHandler:Register('QUEST_GREETING', function()
	-- triggered when the player interacts with an NPC that hands in/out quests
	if paused then
		return
	end

	if QuickQuestDB.blocklist.npcs[ns.GetNPCID()] then
		return
	end

	-- turn in all completed quests
	for index = 1, GetNumActiveQuests() do
		if not ignoredQuests[GetActiveQuestID(index)] then
			local _, isComplete = GetActiveTitle(index)
			if isComplete and not C_QuestLog.IsWorldQuest(GetActiveQuestID(index)) then
				SelectActiveQuest(index)
			end
		end
	end

	-- accept all available quests
	for index = 1, GetNumAvailableQuests() do
		local isTrivial, _, _, _, questID = GetAvailableQuestInfo(index)
		if not ignoredQuests[questID] then
			if not isTrivial or ns.ShouldAcceptTrivialQuests() then
				SelectAvailableQuest(index)
			end
		end
	end
end)

EventHandler:Register('QUEST_DETAIL', function(questItemID)
	-- triggered when the information about an available quest is available
	if paused then
		return
	end

	if QuestIsFromAreaTrigger() then
		-- this type of quest is automatically accepted, but the dialogue is presented in a way that
		-- the player seems to have a choice to decline it, which they don't, so just accept it
		AcceptQuest()
	elseif QuestGetAutoAccept() then
		-- this type of quest is automatically accepted, but the dialogue persists
		AcknowledgeAutoAcceptQuest()
	elseif not C_QuestLog.IsQuestTrivial(GetQuestID()) or ns.ShouldAcceptTrivialQuests() then
		if ignoredQuests[GetQuestID()] then
			CloseQuest()
		else
			AcceptQuest()
		end
	end
end)

EventHandler:Register('QUEST_PROGRESS', function()
	-- triggered when an active quest is selected during turn-in
	if paused then
		return
	end

	if QuickQuestDB.blocklist.npcs[ns.GetNPCID()] then
		return
	end

	if not IsQuestCompletable() then
		return
	end

	-- iterate through the items part of the quest
	for index = 1, GetNumQuestItems() do
		local itemLink = GetQuestItemLink('required', index)
		if itemLink then
			-- check to see if the item is blocked
			local questItemID = GetItemInfoFromHyperlink(itemLink)
			for _, itemID in next, QuickQuestDB.blocklist.items do
				if itemID == questItemID then
					-- item is blocked, prevent this quest from opening again and close it
					ignoredQuests[GetQuestID()] = true
					CloseQuest()
					return
				end
			end
		else
			-- item is not cached yet, trigger the item and wait for the cache to populate
			EventHandler:Register('QUEST_ITEM_UPDATE', 'QUEST_PROGRESS')
			GetQuestItemInfo('required', index)
			return
		end
	end

	CompleteQuest()
	EventHandler:Unregister('QUEST_ITEM_UPDATE', 'QUEST_PROGRESS')
end)

EventHandler:Register('QUEST_COMPLETE', function()
	-- triggered when an active quest is ready to be completed
	if paused then
		return
	end

	if GetNumQuestChoices() <= 1 then
		-- complete the quest by accepting the first item
		GetQuestReward(1)
	end
end)

EventHandler:Register('QUEST_COMPLETE', function()
	-- triggered when an active quest is ready to be completed
	local numItemRewards = GetNumQuestChoices()
	if numItemRewards <= 1 then
		-- no point iterating over a single item or none at all
		return
	end

	local highestItemValue, highestItemValueIndex = 0

	-- iterate through the item rewards and automatically select the one worth the most
	for index = 1, numItemRewards do
		local itemLink = GetQuestItemLink('choice', index)
		if itemLink then
			-- check the value on the item and compare it to the others
			local _, _, _, _, _, _, _, _, _, _, itemValue = GetItemInfo(itemLink)
			local itemID = GetItemInfoFromHyperlink(itemLink)

			-- some items are containers that contains currencies of worth
			itemValue = cashRewards[itemID] or itemValue

			-- compare the values
			if itemValue > highestItemValue then
				highestItemValue = itemValue
				highestItemValueIndex = index
			end
		else
			-- item is not cached yet, trigger the item and wait for the cache to populate
			EventHandler:Register('QUEST_ITEM_UPDATE', 'QUEST_COMPLETE')
			GetQuestItemInfo('choice', index)
			return
		end
	end

	if highestItemValueIndex then
		-- this is considered an intrusive action, as we're modifying the UI
		QuestInfoItem_OnClick(QuestInfoRewardsFrame.RewardButtons[highestItemValueIndex])
	end

	EventHandler:Unregister('QUEST_ITEM_UPDATE', 'QUEST_COMPLETE')
end)

EventHandler:Register('QUEST_LOG_UPDATE', function()
	-- triggered when the player's quest log has been altered
	if paused then
		return
	end

	-- check for quest popups whenever the quest log is updated, which also happens on login, and
	-- when the player loots an item that starts a quest
	if GetNumAutoQuestPopUps() > 0 then
		if UnitIsDeadOrGhost('player') then
			-- can't accept quests while we're dead
			EventHandler:Register('PLAYER_REGEN_ENABLED', 'QUEST_LOG_UPDATE')
			return
		end

		EventHandler:Unregister('PLAYER_REGEN_ENABLED', 'QUEST_LOG_UPDATE')

		-- this is considered an intrusive action, as we're modifying the UI
		local questID, questType = GetAutoQuestPopUp(1)
		if questType == 'OFFER' then
			ShowQuestOffer(questID)
		else
			ShowQuestComplete(questID)
		end
	end
end)

EventHandler:Register('QUEST_ACCEPT_CONFIRM', function()
	-- triggered when a quest is shared in the party, but requires confirmation (like escorts)
	if paused then
		return
	end

	AcceptQuest()
end)

EventHandler:Register('QUEST_ACCEPTED', function(questID)
	-- triggered when a quest has been accepted by the player
	if QuickQuestDB.general.share then
		local questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID)
		if questLogIndex then
			QuestLogPushQuest(questLogIndex)
		end
	end
end)

EventHandler:Register('MODIFIER_STATE_CHANGED', function(key, state)
	-- triggered when the player clicks any modifier keys on the keyboard
	if string.sub(key, 2) == QuickQuestDB.general.pausekey then
		-- change the paused state
		if QuickQuestDB.general.pausekeyreverse then
			paused = state ~= 1
		else
			paused = state == 1
		end
	end
end)

EventHandler:Register('PLAYER_LOGIN', function()
	-- triggered when the game has completed the login process
	if QuickQuestDB.general.pausekeyreverse then
		-- default to a paused state
		paused = true
	end
end)