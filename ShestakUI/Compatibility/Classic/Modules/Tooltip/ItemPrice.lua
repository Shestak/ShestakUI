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

local function SetPrice(tooltip)
	if MerchantFrame:IsShown() then return end

	item = item or select(2, tooltip:GetItem())
	if not item then return end

	local price = select(11, GetItemInfo(item))

	if price and price > 0 then
		tooltip:AddDoubleLine(SELL_PRICE..": ", FormatCurrency(count and price * count or price), nil, nil, nil, 1, 1, 1)
	end

	if tooltip:IsShown() then tooltip:Show() end
end

GameTooltip:HookScript("OnTooltipSetItem", SetPrice)
ItemRefTooltip:HookScript("OnTooltipSetItem", SetPrice)