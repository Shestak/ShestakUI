local T, C, L, _ = unpack(select(2, ...))
if C.misc.already_known ~= true then return end

----------------------------------------------------------------------------------------
--	Colorizes recipes/mounts/pets/toys that is already known(AlreadyKnown by Villiv)
----------------------------------------------------------------------------------------
local color = {r = 0.1, g = 1, b = 0.1}
local knowns, lines = {}, {}
local recipe = LE_ITEM_CLASS_RECIPE
local pet = LE_ITEM_MISCELLANEOUS_COMPANION_PET
local mount = LE_ITEM_MISCELLANEOUS_MOUNT
local knowables = {[recipe] = true, [pet] = true, [mount] = true}

local pattern = ITEM_PET_KNOWN:gsub("%(", "%%(")
pattern = pattern:gsub("%)", "%%)")

local tooltip = CreateFrame("GameTooltip")
tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

for i = 1, 40 do
	lines[i] = tooltip:CreateFontString()
	tooltip:AddFontStrings(lines[i], tooltip:CreateFontString())
end

local function Scan(line, numLines)
	if line > numLines then return end

	local text = lines[line]:GetText()
	if not text or text == "" or text ~= ITEM_SPELL_KNOWN and not text:match(pattern) then return Scan(line + 1, numLines) end

	return true
end

local function IsKnown(itemLink)
	if not itemLink then return end

	local speciesID = itemLink:match("battlepet:(%d+):")
	if speciesID then return C_PetJournal.GetNumCollectedInfo(speciesID) > 0 and true end

	local itemID = itemLink:match("item:(%d+):")
	if not itemID then return end
	if knowns[itemID] then return true end

	if PlayerHasToy(itemID) then
		knowns[itemID] = true
		return true
	end

	if C_Heirloom.PlayerHasHeirloom(itemID) then
		knowns[itemID] = true
		return true
	end

	local _, _, _, _, _, _, _, _, _, _, _, class, subClass = GetItemInfo(itemID)
	if not (knowables[class] or knowables[subClass]) then return end

	tooltip:ClearLines()
	tooltip:SetHyperlink(itemLink)
	if not Scan(2, tooltip:NumLines()) then return end

	if subClass ~= pet then knowns[itemID] = true end
	return true
end

-- Mail frame
local function OpenMailFrame_UpdateButtonPositions()
	for i = 1, ATTACHMENTS_MAX_RECEIVE do
		local button = _G["OpenMailAttachmentButton"..i]
		if button then
			local name, _, _, _, canUse = GetInboxItem(InboxFrame.openMailID, i)
			if name and canUse and IsKnown(GetInboxItemLink(InboxFrame.openMailID, i)) then
				SetItemButtonTextureVertexColor(button, color.r, color.g, color.b)
			end
		end
	end
end
hooksecurefunc("OpenMailFrame_UpdateButtonPositions", OpenMailFrame_UpdateButtonPositions)

-- Loot frame
local function LootFrame_UpdateButton(index)
	local numLootItems = LootFrame.numLootItems
	local numLootToShow = LOOTFRAME_NUMBUTTONS
	if numLootItems > LOOTFRAME_NUMBUTTONS then
		numLootToShow = numLootToShow - 1
	end

	local button = _G["LootButton"..index]
	if button and button:IsShown() then
		local slot = (numLootToShow * (LootFrame.page - 1)) + index
		if slot <= numLootItems and LootSlotHasItem(slot) and index <= numLootToShow then
			local texture, _, _, _, _, locked = GetLootSlotInfo(slot)
			if texture and not locked and IsKnown(GetLootSlotLink(slot)) then
				SetItemButtonTextureVertexColor(button, color.r, color.g, color.b)
			end
		end
	end
end
hooksecurefunc("LootFrame_UpdateButton", LootFrame_UpdateButton)

-- Merchant frame
local function MerchantFrame_UpdateMerchantInfo()
	local numItems = GetMerchantNumItems()

	for i = 1, MERCHANT_ITEMS_PER_PAGE do
		local index = (MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE + i
		if index > numItems then return end

		local button = _G["MerchantItem"..i.."ItemButton"]
		if button and button:IsShown() then
			local _, _, _, _, _, isUsable = GetMerchantItemInfo(index)
			if isUsable and IsKnown(GetMerchantItemLink(index)) then
				SetItemButtonTextureVertexColor(button, color.r, color.g, color.b)
			end
		end
	end
end
hooksecurefunc("MerchantFrame_UpdateMerchantInfo", MerchantFrame_UpdateMerchantInfo)

local function MerchantFrame_UpdateBuybackInfo()
	local numItems = GetNumBuybackItems()

	for i = 1, BUYBACK_ITEMS_PER_PAGE do
		if i > numItems then return end

		local button = _G["MerchantItem"..i.."ItemButton"]
		if button and button:IsShown() then
			local _, _, _, _, _, isUsable = GetBuybackItemInfo(i)
			if isUsable and IsKnown(GetBuybackItemLink(i)) then
				SetItemButtonTextureVertexColor(button, color.r, color.g, color.b)
			end
		end
	end
end
hooksecurefunc("MerchantFrame_UpdateBuybackInfo", MerchantFrame_UpdateBuybackInfo)

-- Quest frame
local function QuestInfo_ShowRewards()
	local numQuestRewards, numQuestChoices
	if QuestInfoFrame.questLog then
		numQuestRewards, numQuestChoices = GetNumQuestLogRewards(), GetNumQuestLogChoices()
	else
		numQuestRewards, numQuestChoices = GetNumQuestRewards(), GetNumQuestChoices()
	end

	local totalRewards = numQuestRewards + numQuestChoices
	if totalRewards == 0 then return end

	local rewardsCount = 0

	if numQuestChoices > 0 then
		local baseIndex = rewardsCount
		for i = 1, numQuestChoices do
			local button = _G["QuestInfoItem"..i + baseIndex]
			if button and button:IsShown() then
				local isUsable
				if QuestInfoFrame.questLog then
					_, _, _, _, isUsable = GetQuestLogChoiceInfo(i)
				else
					_, _, _, _, isUsable = GetQuestItemInfo("choice", i)
				end
				if isUsable and IsKnown(QuestInfoFrame.questLog and GetQuestLogItemLink("choice", i) or GetQuestItemLink("choice", i)) then
					SetItemButtonTextureVertexColor(button, color.r, color.g, color.b)
				end
			end
			rewardsCount = rewardsCount + 1
		end
	end

	if numQuestRewards > 0 then
		local baseIndex = rewardsCount
		for i = 1, numQuestRewards do
			local button = _G["QuestInfoItem"..i + baseIndex]
			if button and button:IsShown() then
				local isUsable
				if QuestInfoFrame.questLog then
					_, _, _, _, isUsable = GetQuestLogRewardInfo(i)
				else
					_, _, _, _, isUsable = GetQuestItemInfo("reward", i)
				end
				if isUsable and IsKnown(QuestInfoFrame.questLog and GetQuestLogItemLink("reward", i) or GetQuestItemLink("reward", i)) then
					SetItemButtonTextureVertexColor(button, color.r, color.g, color.b)
				end
				rewardsCount = rewardsCount + 1
			end
		end
	end
end

if IsAddOnLoaded("Pawn") then
	hooksecurefunc("PawnUI_OnQuestInfo_ShowRewards", QuestInfo_ShowRewards)
else
	hooksecurefunc("QuestInfo_ShowRewards", QuestInfo_ShowRewards)
end

-- Guild rewards frame
local function GuildRewards_Update()
	local offset = HybridScrollFrame_GetOffset(GuildRewardsContainer)
	local buttons = GuildRewardsContainer.buttons
	local _, _, standingID = GetGuildFactionInfo()

	for i = 1, #buttons do
		local button = buttons[i]
		if button and button:IsShown() then
			local achievementID, itemID, itemName, _, repLevel = GetGuildRewardInfo(offset + i)
			if itemName and not (achievementID and achievementID > 0) and repLevel <= standingID then
				local _, itemLink = GetItemInfo(itemID)
				if IsKnown(itemLink) then
					button.icon:SetVertexColor(color.r, color.g, color.b)
				end
			end
		end
	end
end

local isBlizzard_GuildUILoaded
if IsAddOnLoaded("Blizzard_GuildUI") then
	isBlizzard_GuildUILoaded = true
	hooksecurefunc("GuildRewards_Update", GuildRewards_Update)
	hooksecurefunc(GuildRewardsContainer, "update", GuildRewards_Update)
end

-- GuildBank frame
local function GuildBankFrame_Update()
	if GuildBankFrame.mode ~= "bank" then return end

	local tab = GetCurrentGuildBankTab()

	for i = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
		local index = math.fmod(i, NUM_SLOTS_PER_GUILDBANK_GROUP)
		if index == 0 then index = 14 end
		local column = math.ceil((i - 0.5) / NUM_SLOTS_PER_GUILDBANK_GROUP)
		local button = _G["GuildBankColumn"..column.."Button"..index]

		if button and button:IsShown() then
			local texture, _, locked = GetGuildBankItemInfo(tab, i)
			if texture and not locked then
				if IsKnown(GetGuildBankItemLink(tab, i)) then
					SetItemButtonTextureVertexColor(button, color.r, color.g, color.b)
				else
					SetItemButtonTextureVertexColor(button, 1, 1, 1)
				end
			end
		end
	end
end

local isBlizzard_GuildBankUILoaded
if IsAddOnLoaded("Blizzard_GuildBankUI") then
	isBlizzard_GuildBankUILoaded = true
	hooksecurefunc("GuildBankFrame_Update", GuildBankFrame_Update)
end

-- Auction frame
local function AuctionHouseFrame_RefreshScrollFrame(self)
	local numResults = self.getNumEntries()
	local buttons = HybridScrollFrame_GetButtons(self.ScrollFrame)
	local buttonCount = buttons and #buttons or 0
	local offset = self:GetScrollOffset()
	local populateCount = math.min(buttonCount, numResults)
	for i = 1, buttonCount do
		local visible = i + offset <= numResults
		local button = buttons[i]
		if visible then
			if button.rowData.itemKey.itemID then
				local itemLink
				if button.rowData.itemKey.itemID == 82800 then -- BattlePet
					itemLink = format("|Hbattlepet:%d::::::|h[Dummy]|h", button.rowData.itemKey.battlePetSpeciesID)
				else -- Normal item
					itemLink = format("item:%d:", button.rowData.itemKey.itemID)
				end

				if itemLink and IsKnown(itemLink) then
					-- Highlight
					button.SelectedHighlight:Show()
					button.SelectedHighlight:SetVertexColor(color.r, color.g, color.b)
					button.SelectedHighlight:SetAlpha(.2)
					-- Icon
					button.cells[2].Icon:SetVertexColor(color.r, color.g, color.b)
					button.cells[2].IconBorder:SetVertexColor(color.r, color.g, color.b)
				else
					-- Highlight
					button.SelectedHighlight:SetVertexColor(1, 1, 1)
					-- Icon
					button.cells[2].Icon:SetVertexColor(1, 1, 1)
					button.cells[2].IconBorder:SetVertexColor(1, 1, 1)
				end
			end
		end
	end
end

-- Black market frame
local function BlackMarketFrame_UpdateHotItem(self)
	local texture = self.HotDeal.Item.IconTexture
	if not (texture and texture:IsShown()) then return end

	local name, _, _, _, usable, _, _, _, _, _, _, _, _, _, link = C_BlackMarket.GetHotItem()
	if name and usable and IsKnown(link) then
		texture:SetVertexColor(color.r, color.g, color.b)
	end
end

local function BlackMarketScrollFrame_Update()
	local numItems = C_BlackMarket.GetNumItems()
	local offset = HybridScrollFrame_GetOffset(BlackMarketScrollFrame)
	local buttons = BlackMarketScrollFrame.buttons

	for i = 1, #buttons do
		local index = offset + i
		if type(numItems) == "number" and index <= numItems then
			local texture = buttons[i].Item.IconTexture
			if texture and texture:IsShown() then
				local name, _, _, _, usable, _, _, _, _, _, _, _, _, _, link = C_BlackMarket.GetItemInfoByIndex(index)
				if name and usable and IsKnown(link) then
					texture:SetVertexColor(color.r, color.g, color.b)
				end
			end
		end
	end
end

local isBlizzard_BlackMarketUILoaded
if IsAddOnLoaded("Blizzard_BlackMarketUI") then
	isBlizzard_BlackMarketUILoaded = true
	hooksecurefunc("BlackMarketFrame_UpdateHotItem", BlackMarketFrame_UpdateHotItem)
	hooksecurefunc("BlackMarketScrollFrame_Update", BlackMarketScrollFrame_Update)
	hooksecurefunc(BlackMarketScrollFrame, "update", BlackMarketScrollFrame_Update)
end

-- LoD addons
if not (isBlizzard_GuildUILoaded and isBlizzard_GuildBankUILoaded and isBlizzard_AuctionUILoaded and isBlizzard_BlackMarketUILoaded) then
	local function OnEvent(self, event, addon)
		if addon == "Blizzard_GuildUI" then
			isBlizzard_GuildUILoaded = true
			hooksecurefunc("GuildRewards_Update", GuildRewards_Update)
			hooksecurefunc(GuildRewardsContainer, "update", GuildRewards_Update)
		elseif addon == "Blizzard_GuildBankUI" then
			isBlizzard_GuildBankUILoaded = true
			hooksecurefunc("GuildBankFrame_Update", GuildBankFrame_Update)
		elseif addon == "Blizzard_AuctionHouseUI" then
			isBlizzard_AuctionUILoaded = true
			hooksecurefunc(AuctionHouseFrame.BrowseResultsFrame.ItemList, "RefreshScrollFrame", AuctionHouseFrame_RefreshScrollFrame)
		elseif addon == "Blizzard_BlackMarketUI" then
			isBlizzard_BlackMarketUILoaded = true
			hooksecurefunc("BlackMarketFrame_UpdateHotItem", BlackMarketFrame_UpdateHotItem)
			hooksecurefunc("BlackMarketScrollFrame_Update", BlackMarketScrollFrame_Update)
			hooksecurefunc(BlackMarketScrollFrame, "update", BlackMarketScrollFrame_Update)
		end

		if isBlizzard_GuildUILoaded and isBlizzard_GuildBankUILoaded and isBlizzard_AuctionUILoaded and isBlizzard_BlackMarketUILoaded then
			self:UnregisterEvent(event)
			self:SetScript("OnEvent", nil)
			OnEvent = nil
		end
	end

	tooltip:SetScript("OnEvent", OnEvent)
	tooltip:RegisterEvent("ADDON_LOADED")
end