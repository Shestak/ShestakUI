local T, C, L, _ = unpack(select(2, ...))
if C.automation.accept_quest ~= true then return end

----------------------------------------------------------------------------------------
--	Quest automation(QuickQuest by p3lim)
----------------------------------------------------------------------------------------
local QuickQuest = CreateFrame("Frame")
QuickQuest:SetScript("OnEvent", function(self, event, ...) self[event](...) end)

local atBank, atMail, atMerchant
local choiceQueue, autoCompleteIndex, autoCompleteTicker

local metatable = {
	__call = function(methods, ...)
		for _, method in next, methods do
			method(...)
		end
	end
}
local QuickQuestDB = {
	toggle = true,
	items = true,
	faireport = true,
	gossip = true,
	gossipraid = 1,
	modifier = "SHIFT",
	reverse = false,
	itemBlacklist = {
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
	return tonumber(string.match(UnitGUID("npc") or "", "Creature%-.-%-.-%-.-%-.-%-(.-)%-"))
end

local function IsTrackingTrivial()
	for index = 1, GetNumTrackingTypes() do
		local name, _, active = GetTrackingInfo(index)
		if name == MINIMAP_TRACKING_TRIVIAL_QUESTS then
			return active
		end
	end
end

local ignoreQuestNPC = {
	[88570] = true,	-- Fate-Twister Tiklal
	[87391] = true,	-- Fate-Twister Seress
	[111243] = true, -- Archmage Lan'dalock
	[108868] = true, -- Hunter's order hall
	[101462] = true, -- Engineering
}

QuickQuest:Register("QUEST_GREETING", function()
	local npcID = GetNPCID()
	if ignoreQuestNPC[npcID] then
		return
	end

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

-- This should be part of the API, really
local function IsGossipQuestCompleted(index)
	return not not select(((index * 5) - 5) + 4, GetGossipActiveQuests())
end

local function IsGossipQuestTrivial(index)
	return not not select(((index * 6) - 6) + 3, GetGossipAvailableQuests())
end

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
	[79740] = true, -- Warmaster Zog (Horde)
	[79953] = true, -- Lieutenant Thorn (Alliance)
	[84268] = true, -- Lieutenant Thorn (Alliance)
	[84511] = true, -- Lieutenant Thorn (Alliance)
	[84684] = true, -- Lieutenant Thorn (Alliance)
}

local rogueClassHallInsignia = {
	[97004] = true, -- "Red" Jack Findle
	[96782] = true, -- Lucian Trias
	[93188] = true, -- Mongar
}

QuickQuest:Register("GOSSIP_SHOW", function()
	local npcID = GetNPCID()
	if ignoreQuestNPC[npcID] then return end

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

	if(rogueClassHallInsignia[npcID]) then
		return SelectGossipOption(1)
	end

	if available == 0 and active == 0 and GetNumGossipOptions() == 1 then
		local npcID = GetNPCID()
		if QuickQuestDB.faireport then
			if npcID == 57850 then
				return SelectGossipOption(1)
			end
		end

		if QuickQuestDB.gossip then
			local _, instance = GetInstanceInfo()
			if instance == "raid" and QuickQuestDB.gossipraid > 0 then
				if GetNumGroupMembers() > 1 and QuickQuestDB.gossipraid < 2 then return end

				SelectGossipOption(1)
			elseif instance ~= "raid" and not ignoreGossipNPC[npcID] then
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
	if not QuickQuestDB.faireport then return end

	local npcID = GetNPCID()
	if npcID and darkmoonNPC[npcID] then
		SelectGossipOption(index, "", true)
		StaticPopup_Hide("GOSSIP_CONFIRM")
	end
end)

QuestFrame:UnregisterEvent("QUEST_DETAIL")
QuickQuest:Register("QUEST_DETAIL", function()
	if not QuestGetAutoAccept() or not QuestIsFromAreaTrigger() then
		QuestFrame_OnEvent(QuestFrame, "QUEST_DETAIL")
	end
end, true)

QuickQuest:Register("QUEST_DETAIL", function()
	if not QuestGetAutoAccept() then
		AcceptQuest()
	end
end)

QuickQuest:Register("QUEST_ACCEPT_CONFIRM", AcceptQuest)

QuickQuest:Register("QUEST_ACCEPTED", function(id)
	if QuestFrame:IsShown() and QuestGetAutoAccept() then
		CloseQuest()
	end
end)

QuickQuest:Register("QUEST_ITEM_UPDATE", function()
	if choiceQueue and QuickQuest[choiceQueue] then
		QuickQuest[choiceQueue]()
	end
end, true)

QuickQuest:Register("QUEST_PROGRESS", function()
	if IsQuestCompletable() then
		local requiredItems = GetNumQuestItems()
		if requiredItems > 0 then
			for index = 1, requiredItems do
				local link = GetQuestItemLink("required", index)
				if link then
					local id = tonumber(string.match(link, "item:(%d+)"))
					for _, itemID in next, QuickQuestDB.itemBlacklist do
						if itemID == id then
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
	if choices <= 1 then
		GetQuestReward(1)
	end
end)

local cashRewards = {
	[45724] = 1e5,	-- Champion's Purse
	[64491] = 2e6,	-- Royal Reward
	-- Items from the Sixtrigger brothers quest chain in Stormheim
	[138127] = 15, -- Mysterious Coin, 15 copper
	[138129] = 11, -- Swatch of Priceless Silk, 11 copper
	[138131] = 24, -- Magical Sprouting Beans, 24 copper
	[138123] = 15, -- Shiny Gold Nugget, 15 copper
	[138125] = 16, -- Crystal Clear Gemstone, 16 copper
	[138133] = 27, -- Elixir of Endless Wonder, 27 copper
}

QuickQuest:Register("QUEST_COMPLETE", function()
	local choices = GetNumQuestChoices()
	if choices > 1 then
		local bestValue, bestIndex = 0

		for index = 1, choices do
			local link = GetQuestItemLink("choice", index)
			if link then
				local _, _, _, _, _, _, _, _, _, _, value = GetItemInfo(link)
				value = cashRewards[tonumber(string.match(link, "item:(%d+):"))] or value
				if not value then value = 0 end

				if value > bestValue then
					bestValue, bestIndex = value, index
				end
			else
				choiceQueue = "QUEST_COMPLETE"
				return GetQuestItemInfo("choice", index)
			end
		end
		if bestIndex then
			QuestInfoItem_OnClick(QuestInfoRewardsFrame.RewardButtons[bestIndex])
		else
			choiceQueue = "QUEST_COMPLETE"
			GetQuestItemInfo("choice", 1)
		end
	end
end, true)

QuickQuest:Register("QUEST_FINISHED", function()
	choiceQueue = nil
	autoCompleteIndex = nil

	if autoCompleteTicker then
		autoCompleteTicker:Cancel()
		autoCompleteTicker = nil
	end

	if GetNumAutoQuestPopUps() > 0 then
		QuickQuest:QUEST_AUTOCOMPLETE()
	end
end)

local function CompleteAutoComplete(self)
	if not autoCompleteIndex and GetNumAutoQuestPopUps() > 0 then
		local id, type = GetAutoQuestPopUp(1)
		if type == "COMPLETE" then
			local index = GetQuestLogIndexByID(id)
			ShowQuestComplete(index)
			autoCompleteIndex = index
		end

		self:Cancel()
	end
end

QuickQuest:Register("QUEST_AUTOCOMPLETE", function(questID)
	autoCompleteTicker = C_Timer.NewTicker(1 / 4, CompleteAutoComplete, 20)
end)

QuickQuest:Register("BAG_UPDATE_DELAYED", function()
	if autoCompleteIndex then
		ShowQuestComplete(autoCompleteIndex)
		autoCompleteIndex = nil
	end
end)

QuickQuest:Register("BANKFRAME_OPENED", function()
	atBank = true
end, true)

QuickQuest:Register("BANKFRAME_CLOSED", function()
	atBank = false
end, true)

QuickQuest:Register("GUILDBANKFRAME_OPENED", function()
	atBank = true
end, true)

QuickQuest:Register("GUILDBANKFRAME_CLOSED", function()
	atBank = false
end, true)

QuickQuest:Register("MAIL_SHOW", function()
	atMail = true
end, true)

QuickQuest:Register("MAIL_CLOSED", function()
	atMail = false
end, true)

QuickQuest:Register("MERCHANT_SHOW", function()
	atMerchant = true
end, true)

QuickQuest:Register("MERCHANT_CLOSED", function()
	atMerchant = false
end, true)

local sub = string.sub
QuickQuest:Register("MODIFIER_STATE_CHANGED", function(key, state)
	if sub(key, 2) == QuickQuestDB.modifier then
		modifier = state == 1
	end
end, true)

local questTip = CreateFrame("GameTooltip", "QuickQuestTip", UIParent, "GameTooltipTemplate")
local questString = string.gsub(ITEM_MIN_LEVEL, "%%d", "(%%d+)")

local function GetContainerItemQuestLevel(bag, slot)
	questTip:SetOwner(UIParent, "ANCHOR_NONE")
	questTip:SetBagItem(bag, slot)

	for index = 1, questTip:NumLines() do
		local level = tonumber(string.match(_G["QuickQuestTipTextLeft" .. index]:GetText(), questString))
		if level then
			return level
		end
	end

	return 1
end

local function BagUpdate(bag)
	if not QuickQuestDB.items then return end
	if atBank or atMail or atMerchant then return end

	for slot = 1, GetContainerNumSlots(bag) do
		local _, id, active = GetContainerItemQuestInfo(bag, slot)
		if id and not active and not IsQuestFlaggedCompleted(id) and not QuickQuestDB.itemBlacklist[id] then
			local level = GetContainerItemQuestLevel(bag, slot)
			if level <= T.level then
				UseContainerItem(bag, slot)
			end
		end
	end
end

QuickQuest:Register("PLAYER_LOGIN", function()
	QuickQuest:Register("BAG_UPDATE", BagUpdate)

	if GetNumAutoQuestPopUps() > 0 then
		QuickQuest:QUEST_AUTOCOMPLETE()
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
