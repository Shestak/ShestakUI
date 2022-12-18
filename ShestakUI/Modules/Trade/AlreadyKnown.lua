local T, C, L, _ = unpack(select(2, ...))
if C.trade.already_known ~= true then return end

----------------------------------------------------------------------------------------
--	Colorizes recipes/mounts/pets/toys that is already known(AlreadyKnown by Villiv)
----------------------------------------------------------------------------------------
local color = {r = 0.1, g = 1, b = 0.1}
local knowns, lines = {}, {}
local recipe = Enum.ItemClass.Recipe
local pet = Enum.ItemMiscellaneousSubclass.CompanionPet
local mount = Enum.ItemMiscellaneousSubclass.Mount
local knowables = {[recipe] = true, [pet] = true, [mount] = true}

local pattern = ITEM_PET_KNOWN:gsub("%(", "%%(")
pattern = pattern:gsub("%)", "%%)")

local tooltip = CreateFrame("GameTooltip", "AKScanningTooltip", nil, "GameTooltipTemplate")
tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

local function Scan(line, numLines)
	if line > numLines then return end

	local text = _G["AKScanningTooltipTextLeft"..line]:GetText()
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
local function LootFrame_UpdateButton(self)
	local slotIndex = self:GetSlotIndex()
	local texture, _, _, _, _, locked = GetLootSlotInfo(slotIndex)
	if texture and not locked and IsKnown(GetLootSlotLink(slotIndex)) then
		SetItemButtonTextureVertexColor(self.Item, color.r, color.g, color.b)
	end
end
hooksecurefunc(LootFrameElementMixin, "Init", LootFrame_UpdateButton)

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
		numQuestRewards, numQuestChoices = GetNumQuestLogRewards(), GetNumQuestLogChoices(C_QuestLog.GetSelectedQuest(), true)
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

	for i = 1, 98 do
		local index = math.fmod(i, 14)
		if index == 0 then index = 14 end
		local column = math.ceil((i - 0.5) / 14)
		local button = GuildBankFrame.Columns[column].Buttons[index]

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
	hooksecurefunc(GuildBankFrame, "Update", GuildBankFrame_Update)
end

-- Auction frame
local function AuctionHouseFrame_RefreshScrollFrame(self)
	-- Derived from https://www.townlong-yak.com/framexml/10.0.0/Blizzard_AuctionHouseUI/Blizzard_AuctionHouseItemList.lua#322
	self.ScrollBox:ForEachFrame(function(button)
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
	end)
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

local function BlackMarketScrollFrame_Update(self, elementData)
	local name, _, _, _, usable, _, _, _, _, _, _, _, _, _, link = C_BlackMarket.GetItemInfoByIndex(elementData.index)
	if name and usable and IsKnown(link) then
		self.Item.IconTexture:SetVertexColor(color.r, color.g, color.b)
	end
end

local isBlizzard_BlackMarketUILoaded
if IsAddOnLoaded("Blizzard_BlackMarketUI") then
	isBlizzard_BlackMarketUILoaded = true
	hooksecurefunc("BlackMarketFrame_UpdateHotItem", BlackMarketFrame_UpdateHotItem)
	hooksecurefunc(BlackMarketItemMixin, "Init", BlackMarketScrollFrame_Update)
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
			hooksecurefunc(GuildBankFrame, "Update", GuildBankFrame_Update)
		elseif addon == "Blizzard_AuctionHouseUI" then
			isBlizzard_AuctionUILoaded = true
			hooksecurefunc(AuctionHouseFrame.BrowseResultsFrame.ItemList, "RefreshScrollFrame", AuctionHouseFrame_RefreshScrollFrame)
		elseif addon == "Blizzard_BlackMarketUI" then
			isBlizzard_BlackMarketUILoaded = true
			hooksecurefunc("BlackMarketFrame_UpdateHotItem", BlackMarketFrame_UpdateHotItem)
			hooksecurefunc(BlackMarketItemMixin, "Init", BlackMarketScrollFrame_Update)
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