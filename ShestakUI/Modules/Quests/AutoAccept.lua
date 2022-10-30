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
			[79343] = true, -- Inscribed Tiger Staff
			[79340] = true, -- Inscribed Crane Staff
			[79341] = true, -- Inscribed Serpent Staff

			-- Darkmoon Faire artifacts
			[71635] = true, -- Imbued Crystal
			[71636] = true, -- Monstrous Egg
			[71637] = true, -- Mysterious Grimoire
			[71638] = true, -- Ornate Weapon
			[71715] = true, -- A Treatise on Strategy
			[71951] = true, -- Banner of the Fallen
			[71952] = true, -- Captured Insignia
			[71953] = true, -- Fallen Adventurer's Journal
			[71716] = true, -- Soothsayer's Runes

			-- Tiller Gifts
			[79264] = true, -- Ruby Shard
			[79265] = true, -- Blue Feather
			[79266] = true, -- Jade Cat
			[79267] = true, -- Lovely Apple
			[79268] = true, -- Marsh Lily

			-- Garrison scouting missives
			[122424] = true, -- Scouting Missive: Broken Precipice
			[122423] = true, -- Scouting Missive: Broken Precipice
			[122418] = true, -- Scouting Missive: Darktide Roost
			[122417] = true, -- Scouting Missive: Darktide Roost
			[122400] = true, -- Scouting Missive: Everbloom Wilds
			[122404] = true, -- Scouting Missive: Everbloom Wilds
			[122420] = true, -- Scouting Missive: Gorian Proving Grounds
			[122419] = true, -- Scouting Missive: Gorian Proving Grounds
			[122402] = true, -- Scouting Missive: Iron Siegeworks
			[122406] = true, -- Scouting Missive: Iron Siegeworks
			[122413] = true, -- Scouting Missive: Lost Veil Anzu
			[122414] = true, -- Scouting Missive: Lost Veil Anzu
			[122403] = true, -- Scouting Missive: Magnarok
			[122399] = true, -- Scouting Missive: Magnarok
			[122421] = true, -- Scouting Missive: Mok'gol Watchpost
			[122422] = true, -- Scouting Missive: Mok'gol Watchpost
			[122411] = true, -- Scouting Missive: Pillars of Fate
			[122409] = true, -- Scouting Missive: Pillars of Fate
			[122412] = true, -- Scouting Missive: Shattrath Harbor
			[122410] = true, -- Scouting Missive: Shattrath Harbor
			[122408] = true, -- Scouting Missive: Skettis
			[122407] = true, -- Scouting Missive: Skettis
			[122416] = true, -- Scouting Missive: Socrethar's Rise
			[122415] = true, -- Scouting Missive: Socrethar's Rise
			[122405] = true, -- Scouting Missive: Stonefury Cliffs
			[122401] = true, -- Scouting Missive: Stonefury Cliffs

			-- Misc
			[88604] = true, -- Nat's Fishing Journal
		},
		npcs = {
			-- misc
			[103792] = true, -- Griftah (his quests are scams)
			[143925] = true, -- Dark Iron Mole Machine (Dark Iron Dwarf racial)

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

		},
		quests = {
			-- 6.0 coins
			[36054] = true, -- Sealing Fate: Gold
			[37454] = true, -- Sealing Fate: Piles of Gold
			[37455] = true, -- Sealing Fate: Immense Fortune of Gold
			[36055] = true, -- Sealing Fate: Apexis Crystals
			[37452] = true, -- Sealing Fate: Heap of Apexis Crystals
			[37453] = true, -- Sealing Fate: Mountain of Apexis Crystals
			[36056] = true, -- Sealing Fate: Garrison Resources
			[37456] = true, -- Sealing Fate: Stockpiled Garrison Resources
			[37457] = true, -- Sealing Fate: Tremendous Garrison Resources
			[36057] = true, -- Sealing Fate: Honor

			-- 7.0 coins
			[43892] = true, -- Sealing Fate: Order Resources
			[43893] = true, -- Sealing Fate: Stashed Order Resources
			[43894] = true, -- Sealing Fate: Extraneous Order Resources
			[43895] = true, -- Sealing Fate: Gold
			[43896] = true, -- Sealing Fate: Piles of Gold
			[43897] = true, -- Sealing Fate: Immense Fortune of Gold
			[47851] = true, -- Sealing Fate: Marks of Honor
			[47864] = true, -- Sealing Fate: Additional Marks of Honor
			[47865] = true, -- Sealing Fate: Piles of Marks of Honor

			-- 8.0 coins
			[52834] = true, -- Seal of Wartorn Fate: Gold
			[52838] = true, -- Seal of Wartorn Fate: Piles of Gold
			[52835] = true, -- Seal of Wartorn Fate: Marks of Honor
			[52839] = true, -- Seal of Wartorn Fate: Additional Marks of Honor
			[52837] = true, -- Seal of Wartorn Fate: War Resources
			[52840] = true, -- Seal of Wartorn Fate: Stashed War Resources

			-- 7.0 valuable resources
			[48910] = true, -- Supplying Krokuun
			[48634] = true, -- Further Supplying Krokuun
			[48911] = true, -- Void Inoculation
			[48635] = true, -- More Void Inoculation
			[48799] = true, -- Fuel for a Doomed World

			-- 8.0 emissaries
			[54451] = true, -- Baubles from the Seekers
			[53982] = true, -- Supplies From The Unshackled
			[54453] = true, -- Supplies from Magni
			[54454] = true, -- Supplies from 7th Legion
			[54455] = true, -- Supplies from Honorbound
			[54456] = true, -- Supplies from Order of Embers
			[54457] = true, -- Supplies from Storm Wake
			[54458] = true, -- Supplies from Proudmoore Admiralty
			[54460] = true, -- Supplies from Talanji's Expedition
			[54461] = true, -- Supplies from Voldunai Supplies
			[54462] = true, -- Supplies from Zandalari Empire
			[55348] = true, -- Supplies from the Rustbolt Resistance
			[55976] = true, -- Supplies From the Waveblade Ankoan

			-- 9.0 valuable resources
			[64541] = true, -- The Cost of Death (Ve'nari)
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

local function IsQuestIgnored(questID)
	if ignoredQuests[questID] then
		return true
	end

	local questTitle = tonumber(questID) and C_QuestLog.GetTitleForQuestID(questID) or ''
	for key in next, QuickQuestDB.blocklist.quests do
		if key == questID or questTitle:lower():find(tostring(key):lower()) then
			return true
		end
	end

	return false
end

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
				-- See if there is something else than the color we can easily match with
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

	if #C_GossipInfo.GetOptions() == 1 and QuickQuestDB.general.skipgossip then
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
		if not IsQuestIgnored(info.questID) then
			if info.isComplete and not C_QuestLog.IsWorldQuest(info.questID) then
				C_GossipInfo.SelectActiveQuest(index)
			end
		end
	end

	-- accept all available quests
	for index, info in next, C_GossipInfo.GetAvailableQuests() do
		if not IsQuestIgnored(info.questID) then
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
		if not IsQuestIgnored(GetActiveQuestID(index)) then
			local _, isComplete = GetActiveTitle(index)
			if isComplete and not C_QuestLog.IsWorldQuest(GetActiveQuestID(index)) then
				SelectActiveQuest(index)
			end
		end
	end

	-- accept all available quests
	for index = 1, GetNumAvailableQuests() do
		local isTrivial, _, _, _, questID = GetAvailableQuestInfo(index)
		if not IsQuestIgnored(questID) then
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
		if IsQuestIgnored(GetQuestID()) then
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
			for itemID in next, QuickQuestDB.blocklist.items do
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

EventHandler:Register('QUEST_WATCH_LIST_CHANGED', function()
	-- triggered when the player's quest log has been altered
	if paused then
		return
	end

	-- check for quest popups whenever the quest log is updated, which also happens on login, and
	-- when the player loots an item that starts a quest
	if GetNumAutoQuestPopUps() > 0 then
		if UnitIsDeadOrGhost('player') then
			-- can't accept quests while we're dead
			EventHandler:Register('PLAYER_REGEN_ENABLED', 'QUEST_WATCH_LIST_CHANGED')
			return
		end

		EventHandler:Unregister('PLAYER_REGEN_ENABLED', 'QUEST_WATCH_LIST_CHANGED')

		-- this is considered an intrusive action, as we're modifying the UI
		local questID, questType = GetAutoQuestPopUp(1)
		if questType == 'OFFER' then
			ShowQuestOffer(questID)
		else
			ShowQuestComplete(questID)
		end

		-- remove the popup once accepted/completed, the game logic doesn't handle this,
		-- but this calls FrameXML API which might cause taints, we'll see
		AutoQuestPopupTracker_RemovePopUp(questID)
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