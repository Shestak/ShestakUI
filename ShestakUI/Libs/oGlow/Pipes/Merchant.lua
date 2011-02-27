-- TODO:
--  - Clean up the dupe code.
--  - Write a description.

local hook
local update = function()
	if(MerchantFrame:IsShown() and oGlow:IsPipeEnabled'merchant') then
		if(MerchantFrame.selectedTab == 1) then
			for i=1, MERCHANT_ITEMS_PER_PAGE do
				local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
				local itemLink = GetMerchantItemLink(index)
				local slotFrame = _G['MerchantItem' .. i .. 'ItemButton']

				oGlow:CallFilters('merchant', slotFrame, itemLink)
			end

			local buyBackLink = GetBuybackItemLink(GetNumBuybackItems())
			oGlow:CallFilters('merchant', MerchantBuyBackItemItemButton, buyBackLink)
		else
			for i=1, BUYBACK_ITEMS_PER_PAGE do
				local itemLink = GetBuybackItemLink(i)
				local slotFrame = _G['MerchantItem' .. i .. 'ItemButton']

				oGlow:CallFilters('merchant', slotFrame, itemLink)
			end
		end
	end
end

local enable = function(self)
	if(not hook) then
		hooksecurefunc('MerchantFrame_Update', update)
		hook = true
	end
end

local disable = function(self)
	for i=1, MERCHANT_ITEMS_PER_PAGE do
		oGlow:CallFilters('merchant', _G['MerchantItem' .. i .. 'ItemButton'])
	end

	oGlow:CallFilters('merchant', MerchantBuyBackItemItemButton)
end

oGlow:RegisterPipe('merchant', enable, disable, update, 'Vendor frame', nil)
