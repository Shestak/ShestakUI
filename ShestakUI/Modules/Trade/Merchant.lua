local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Alt+Click to buy a stack
----------------------------------------------------------------------------------------
hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self)
	if IsAltKeyDown() then
		local id = self:GetID()
		local itemLink = GetMerchantItemLink(id)
		if not itemLink then return end

		local maxStack = select(8, GetItemInfo(itemLink))
		if maxStack and maxStack > 1 then
			local numAvailable = select(5, GetMerchantItemInfo(id))
			if numAvailable > -1 then
				BuyMerchantItem(id, numAvailable)
			else
				BuyMerchantItem(id, GetMerchantItemMaxStack(id))
			end
		end
	end
end)

ITEM_VENDOR_STACK_BUY = _G.ITEM_VENDOR_STACK_BUY.."\n|cff00ff00<"..L_MISC_BUY_STACK..">|r"

----------------------------------------------------------------------------------------
--	Show item level for weapons and armor in merchant
----------------------------------------------------------------------------------------
if C.trade.merchant_itemlevel ~= true then return end
local function MerchantItemlevel()
	local numItems = GetMerchantNumItems()

	for i = 1, MERCHANT_ITEMS_PER_PAGE do
		local index = (MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE + i
		if index > numItems then return end

		local button = _G["MerchantItem"..i.."ItemButton"]
		if button and button:IsShown() then
			if not button.text then
				button.text = button:CreateFontString(nil, "OVERLAY", "SystemFont_Outline_Small")
				button.text:SetPoint("TOPLEFT", 1, -1)
				button.text:SetTextColor(1, 1, 0)
			else
				button.text:SetText("")
			end

			local itemLink = GetMerchantItemLink(index)
			if itemLink then
				local _, _, quality, itemlevel, _, _, _, _, _, _, _, itemClassID = GetItemInfo(itemLink)
				if (itemlevel and itemlevel > 1) and (quality and quality > 1) and (itemClassID == LE_ITEM_CLASS_WEAPON or itemClassID == LE_ITEM_CLASS_ARMOR) then
					button.text:SetText(itemlevel)
				end
			end
		end
	end
end
hooksecurefunc("MerchantFrame_UpdateMerchantInfo", MerchantItemlevel)