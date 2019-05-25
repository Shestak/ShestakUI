local T, C, L, _ = unpack(select(2, ...))
-- if C.tooltip.enable ~= true or C.tooltip.item_price ~= true then return end
if not T.classic or C.tooltip.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Item Price
----------------------------------------------------------------------------------------

local function FormatCurrency(amount)
	local gold = floor(math.abs(amount) / 10000)
	local silver = mod(floor(math.abs(amount) / 100), 100)
	local copper = mod(floor(math.abs(amount)), 100)
	if gold ~= 0 then
		return format("%s".."|cffffd700"..GOLD_AMOUNT_SYMBOL.."|r".." %s".."|cffc7c7cfs|r".." %s".."|cffeda55fc|r", gold, silver, copper)
	elseif silver ~= 0 then
		return format("%s".."|cffc7c7cf"..SILVER_AMOUNT_SYMBOL.."|r".." %s".."|cffeda55fc|r", silver, copper)
	else
		return format("%s".."|cffeda55f"..COPPER_AMOUNT_SYMBOL.."|r", copper)
	end
end

local function SetPrice(tt, count, item)
	if MerchantFrame:IsShown() then return end

	item = item or select(2, tt:GetItem())
	if not item then return end

	local price = select(11, GetItemInfo(item))

	if price and price > 0 then
		tt:AddDoubleLine(SELL_PRICE..": ", FormatCurrency(count and price * count or price), nil, nil, nil, 1, 1, 1)
	end

	if tt:IsShown() then tt:Show() end
end

local tooltips = {
	"GameTooltip",
	"ItemRefTooltip"
}

local function SetAction(tt, id)
	local _, item = tt:GetItem()
	if not item then return end

	local count = 1
	if IsConsumableAction(id) or IsStackableAction(id) then
		local actionCount = GetActionCount(id)
		if actionCount and actionCount == GetItemCount(item) then
			count = actionCount
		end
	end

	SetPrice(tt, count, item)
end

local function SetAuctionItem(tt, type, index)
	local _, _, count = GetAuctionItemInfo(type, index)
	SetPrice(tt, count)
end

local function SetAuctionSellItem(tt)
	local _, _, count = GetAuctionSellItemInfo()
 	SetPrice(tt, count)
end

local function SetBagItem(tt, bag, slot)
	local _, count = GetContainerItemInfo(bag, slot)
	SetPrice(tt, count)
end

local function SetCraftItem(tt, skill, slot)
	local count = 1
	if slot then
		_, _, count = GetCraftReagentInfo(skill, slot)
	end

	SetPrice(tt, count)
end

local function SetHyperlink(tt, link, count)
	count = tonumber(count)
	if not count or count < 1 then
		local owner = tt:GetOwner()
		count = owner and tonumber(owner.count)
		if not count or count < 1 then
			count = 1
		end
	end

	SetPrice(tt, count)
end

local function SetInboxItem(tt, index, attachmentIndex)
	local _, _, count = GetInboxItem(index, attachmentIndex)
	SetPrice(tt, count)
end

local function SetInventoryItem(tt, unit, slot)
	if type(slot) ~= "number" or slot < 0 then return end

	local count = 1
	if slot < 20 or slot > 39 and slot < 68 then
		count = GetInventoryItemCount(unit, slot)
	end

	SetPrice(tt, count)
end

local function SetLootItem(tt, slot)
	local _, _, count = GetLootSlotInfo(slot)
	SetPrice(tt, count)
end

local function SetLootRollItem(tt, rollID)
	local _, _, count = GetLootRollItemInfo(rollID)
	SetPrice(tt, count)
end

local function SetMerchantCostItem(tt, index, item)
	local _, count = GetMerchantItemCostItem(index, item)
	SetPrice(tt, count)
end

local function SetMerchantItem(tt, slot)
	local _, _, _, count = GetMerchantItemInfo(slot)
	SetPrice(tt, count)
end

local function SetQuestItem(tt, type, slot)
	local _, _, count = GetQuestItemInfo(type, slot)
	SetPrice(tt, count)
end

local function SetQuestLogItem(tt, type, index)
	local _, _, count = GetQuestLogRewardInfo(index)
	SetPrice(tt, count)
end

local function SetSendMailItem(tt, index)
	local _, _, count = GetSendMailItem(index)
	SetPrice(tt, count)
end

local function SetTradePlayerItem(tt, index)
	local _, _, count = GetTradePlayerItemInfo(index)
	SetPrice(tt, count)
end

local function SetTradeSkillItem(tt, skill, slot)
	local count = 1
	if slot then
		_, _, count = GetTradeSkillReagentInfo(skill, slot)
	end

	SetPrice(tt, count)
end

local function SetTradeTargetItem(tt, index)
	local _, _, count = GetTradeTargetItemInfo(index)
	SetPrice(tt, count)
end

local function ApplyHooks(tooltip)
	hooksecurefunc(tooltip, "SetAction", SetAction)
	hooksecurefunc(tooltip, "SetAuctionItem", SetAuctionItem)
	hooksecurefunc(tooltip, "SetAuctionSellItem", SetAuctionSellItem)
	hooksecurefunc(tooltip, "SetBagItem", SetBagItem)
	hooksecurefunc(tooltip, "SetCraftItem", SetCraftItem)
	hooksecurefunc(tooltip, "SetHyperlink", SetHyperlink)
	-- hooksecurefunc(tooltip, "SetInboxItem", SetInboxItem) -- Temporary: Disable inbox for now
	hooksecurefunc(tooltip, "SetInventoryItem", SetInventoryItem)
	hooksecurefunc(tooltip, "SetLootItem", SetLootItem)
	hooksecurefunc(tooltip, "SetLootRollItem", SetLootRollItem)
	hooksecurefunc(tooltip, "SetMerchantCostItem", SetMerchantCostItem)
	hooksecurefunc(tooltip, "SetMerchantItem", SetMerchantItem)
	hooksecurefunc(tooltip, "SetQuestItem", SetQuestItem)
	hooksecurefunc(tooltip, "SetQuestLogItem", SetQuestLogItem)
	hooksecurefunc(tooltip, "SetSendMailItem", SetSendMailItem)
	hooksecurefunc(tooltip, "SetTradePlayerItem", SetTradePlayerItem)
	hooksecurefunc(tooltip, "SetTradeSkillItem", SetTradeSkillItem)
	hooksecurefunc(tooltip, "SetTradeTargetItem", SetTradeTargetItem)
end

for _, tooltip in pairs(tooltips) do
	ApplyHooks(_G[tooltip])
end