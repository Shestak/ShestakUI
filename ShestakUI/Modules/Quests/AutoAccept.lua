local T, C, L, _ = unpack(select(2, ...))
if C.automation.accept_quest ~= true then return end

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
	items = {
		-- Inscription weapons
		[31690] = 79343,	-- Inscribed Tiger Staff
		[31691] = 79340,	-- Inscribed Crane Staff
		[31692] = 79341,	-- Inscribed Serpent Staff

		-- Darkmoon Faire artifacts
		[29443] = 71635,	-- Imbued Crystal
		[29444] = 71636,	-- Monstrous Egg
		[29445] = 71637,	-- Mysterious Grimoire
		[29446] = 71638,	-- Ornate Weapon
		[29451] = 71715,	-- A Treatise on Strategy
		[29456] = 71951,	-- Banner of the Fallen
		[29457] = 71952,	-- Captured Insignia
		[29458] = 71953,	-- Fallen Adventurer's Journal
		[29464] = 71716,	-- Soothsayer's Runes

		-- Tiller Gifts
		["progress_79264"] = 79264,	-- Ruby Shard
		["progress_79265"] = 79265,	-- Blue Feather
		["progress_79266"] = 79266,	-- Jade Cat
		["progress_79267"] = 79267,	-- Lovely Apple
		["progress_79268"] = 79268,	-- Marsh Lily

		-- Garrison scouting missives
		[38180] = 122424,	-- Scouting Missive: Broken Precipice
		[38193] = 122423,	-- Scouting Missive: Broken Precipice
		[38182] = 122418,	-- Scouting Missive: Darktide Roost
		[38196] = 122417,	-- Scouting Missive: Darktide Roost
		[38179] = 122400,	-- Scouting Missive: Everbloom Wilds
		[38192] = 122404,	-- Scouting Missive: Everbloom Wilds
		[38194] = 122420,	-- Scouting Missive: Gorian Proving Grounds
		[38202] = 122419,	-- Scouting Missive: Gorian Proving Grounds
		[38178] = 122402,	-- Scouting Missive: Iron Siegeworks
		[38191] = 122406,	-- Scouting Missive: Iron Siegeworks
		[38184] = 122413,	-- Scouting Missive: Lost Veil Anzu
		[38198] = 122414,	-- Scouting Missive: Lost Veil Anzu
		[38177] = 122403,	-- Scouting Missive: Magnarok
		[38190] = 122399,	-- Scouting Missive: Magnarok
		[38181] = 122421,	-- Scouting Missive: Mok'gol Watchpost
		[38195] = 122422,	-- Scouting Missive: Mok'gol Watchpost
		[38185] = 122411,	-- Scouting Missive: Pillars of Fate
		[38199] = 122409,	-- Scouting Missive: Pillars of Fate
		[38187] = 122412,	-- Scouting Missive: Shattrath Harbor
		[38201] = 122410,	-- Scouting Missive: Shattrath Harbor
		[38186] = 122408,	-- Scouting Missive: Skettis
		[38200] = 122407,	-- Scouting Missive: Skettis
		[38183] = 122416,	-- Scouting Missive: Socrethar's Rise
		[38197] = 122415,	-- Scouting Missive: Socrethar's Rise
		[38176] = 122405,	-- Scouting Missive: Stonefury Cliffs
		[38189] = 122401,	-- Scouting Missive: Stonefury Cliffs

		-- Misc
		[31664] = 88604,	-- Nat's Fishing Journal
	}
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

local function IsTrackingHidden()
	for index = 1, GetNumTrackingTypes() do
		local name, _, active = GetTrackingInfo(index)
		if name == (MINIMAP_TRACKING_TRIVIAL_QUESTS or MINIMAP_TRACKING_HIDDEN_QUESTS) then
			return active
		end
	end
end

local ignoreQuestNPC = {
	[88570] = true,		-- Fate-Twister Tiklal
	[87391] = true,		-- Fate-Twister Seress
	[111243] = true,	-- Archmage Lan'dalock
	[108868] = true,	-- Talua (Hunter's order hall)
	[101462] = true,	-- Reaves (Engineering)
	[103792] = true,	-- Griftah (one of his quests is a scam)
	[119388] = true, 	-- Chieftain Hatuun (repeatable resource quest)
	[124312] = true,	-- High Exarch Turalyon (repeatable resource quest)
	[126954] = true,	-- High Exarch Turalyon (repeatable resource quest)
	[127037] = true,	-- Nabiru (repeatable resource quest)
	[141584] = true,	-- Zurvan (Seal of Wartorn Fate, Horde)
	[142063] = true,	-- Tezran (Seal of Wartorn Fate, Alliance)
}

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
			if((not isTrivial and not isIgnored) or IsTrackingHidden()) then
				SelectAvailableQuest(index)
			end
		end
	end
end)

local ignoreGossipNPC = {
	-- Bodyguards
	[86945] = true,	-- Aeda Brightdawn (Horde)
	[86933] = true,	-- Vivianne (Horde)
	[86927] = true,	-- Delvar Ironfist (Alliance)
	[86934] = true,	-- Defender Illona (Alliance)
	[86682] = true,	-- Tormmok
	[86964] = true,	-- Leorajh
	[86946] = true,	-- Talonpriest Ishaal

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

	-- Misc NPCs
	[117871] = true, -- War Councilor Victoria (Class Challenges @ Broken Shore)
	[143925] = true, -- Dark Iron Mole Machine (Dark Iron Dwarf racial)
}

local rogueClassHallInsignia = {
	[97004] = true, -- "Red" Jack Findle
	[96782] = true, -- Lucian Trias
	[93188] = true, -- Mongar
}

local darkmoonDailyNPCs = {
	[54601] = true, -- Mola
	[15303] = true, -- Maxima Blastenheimer
	[14841] = true, -- Rinling
	[54605] = true, -- Finlay Coolshot
	[85546] = true, -- Ziggie Sparks
	[54485] = true, -- Jessica Rogers
	[85519] = true, -- Christoph VonFeasel
	[67370] = true, -- Jeremy Feasel
}

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
			if((not trivial and not ignored) or IsTrackingHidden()) then
				SelectGossipAvailableQuest(index)
			elseif(trivial and npcID == 64337 and QuickQuestDB.nomi) then
				SelectGossipAvailableQuest(index)
			end
		end
	end

	if(rogueClassHallInsignia[npcID]) then
		return SelectGossipOption(1)
	end

	if(darkmoonDailyNPCs[npcID] and active == 1 and not select(5, GetActiveGossipQuestInfo(1))) then
		-- auto-start the daily interaction
		for index = 1, GetNumGossipOptions() do
			if(string.find((select((index * 2) - 1, GetGossipOptions())), 'FF0008E8')) then
				-- matching by the blue text color is sufficient
				return SelectGossipOption(index)
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

local darkmoonNPC = {
	[57850] = true,	-- Teleportologist Fozlebub
	[55382] = true,	-- Darkmoon Faire Mystic Mage (Horde)
	[54334] = true,	-- Darkmoon Faire Mystic Mage (Alliance)
}

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
	if(not QuestGetAutoAccept() and not QuestIsFromAreaTrigger() and not QuickQuestBlacklistDB[GetQuestID()]) then
		QuestFrame_OnEvent(QuestFrame, "QUEST_DETAIL", ...)
	end
end, true)

QuickQuest:Register("QUEST_DETAIL", function(questStartItemID)
	if(QuestGetAutoAccept() or (questStartItemID ~= nil and questStartItemID ~= 0)) then
		AcknowledgeAutoAcceptQuest()
	else
		-- XXX: no way to tell if the quest is trivial
		AcceptQuest()
	end
end)

local function AttemptAutoComplete(event)
	if(GetNumAutoQuestPopUps() > 0) then
		if(UnitIsDeadOrGhost("player")) then
			QuickQuest:Register("PLAYER_REGEN_ENABLED", AttemptAutoComplete)
			return
		end

		local questID, popUpType = GetAutoQuestPopUp(1)
		if(popUpType == "OFFER") then
			ShowQuestOffer(GetQuestLogIndexByID(questID))
		else
			ShowQuestComplete(GetQuestLogIndexByID(questID))
		end
	else
		C_Timer.After(1, AttemptAutoComplete)
	end

	if(event == "PLAYER_REGEN_ENABLED") then
		QuickQuest:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end

QuickQuest:Register("PLAYER_LOGIN", AttemptAutoComplete)
QuickQuest:Register("QUEST_AUTOCOMPLETE", AttemptAutoComplete)
QuickQuest:Register("QUEST_ACCEPT_CONFIRM", AcceptQuest)

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

local cashRewards = {
	[45724] = 1e5,	-- Champion's Purse, 10 gold
	[64491] = 2e6,	-- Royal Reward, 200 gold

	-- Items from the Sixtrigger brothers quest chain in Stormheim
	[138127] = 15,	-- Mysterious Coin, 15 copper
	[138129] = 11,	-- Swatch of Priceless Silk, 11 copper
	[138131] = 24,	-- Magical Sprouting Beans, 24 copper
	[138123] = 15,	-- Shiny Gold Nugget, 15 copper
	[138125] = 16,	-- Crystal Clear Gemstone, 16 copper
	[138133] = 27,	-- Elixir of Endless Wonder, 27 copper
}

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