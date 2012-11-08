local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BlackMarket skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	BlackMarketFrame:StripTextures()
	BlackMarketFrame.Inset:StripTextures()
	BlackMarketFrame:SetTemplate("Transparent", "Shadow")

	T.SkinScrollBar(BlackMarketScrollFrameScrollBar)
	BlackMarketFrame.MoneyFrameBorder:StripTextures()
	T.SkinEditBox(BlackMarketBidPriceGold)
	T.SkinEditBox(BlackMarketHotItemBidPriceGold)
	BlackMarketBidPriceGold:SetHeight(18)

	BlackMarketFrame.BidButton:SkinButton()
	BlackMarketFrame.BidButton:SetHeight(20)

	BlackMarketFrame.HotDeal:StripTextures()
	BlackMarketFrame.HotDeal.Item.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	BlackMarketFrame.HotDeal.Item:CreateBackdrop()
	BlackMarketFrame.HotDeal.Item:StyleButton()
	BlackMarketFrame.HotDeal.Item.hover:SetAllPoints()
	BlackMarketFrame.HotDeal.Item.pushed:SetAllPoints()
	BlackMarketFrame.HotDeal.BidButton:SkinButton()

	T.SkinCloseButton(BlackMarketFrame.CloseButton)

	local tabs = {"ColumnName", "ColumnLevel", "ColumnType", "ColumnDuration", "ColumnHighBidder", "ColumnCurrentBid"}
	for _, tab in pairs(tabs) do
		local tab = BlackMarketFrame[tab]

		tab:StripTextures()
	end

	hooksecurefunc("BlackMarketScrollFrame_Update", function()
		local buttons = BlackMarketScrollFrame.buttons
		local offset = HybridScrollFrame_GetOffset(BlackMarketScrollFrame)
		local numItems = C_BlackMarket.GetNumItems()

		for i = 1, #buttons do
			local button = buttons[i]
			local index = offset + i

			if not button.skinned then
				button:StripTextures()

				button.Item:StripTextures()
				button.Item:SetTemplate("Default")
				button.Item.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button.Item.IconTexture:ClearAllPoints()
				button.Item.IconTexture:SetPoint("TOPLEFT", 2, -2)
				button.Item.IconTexture:SetPoint("BOTTOMRIGHT", -2, 2)
				button.Item:StyleButton()

				button.skinned = true
			end

			if button:IsShown() and button.itemLink then
				local _, _, quality = GetItemInfo(button.itemLink)
				button.Name:SetTextColor(GetItemQualityColor(quality))
			end

			if index <= numItems then
				local name, texture = C_BlackMarket.GetItemInfoByIndex(index)
				if name then
					button.Item.IconTexture:SetTexture(texture)
				end
			end
		end
	end)

	hooksecurefunc("BlackMarketFrame_UpdateHotItem", function(self)
		local hotDeal = self.HotDeal
		if hotDeal:IsShown() and hotDeal.itemLink then
			local _, _, quality = GetItemInfo(hotDeal.itemLink)
			hotDeal.Name:SetTextColor(GetItemQualityColor(quality))
		end
	end)
end

T.SkinFuncs["Blizzard_BlackMarketUI"] = LoadSkin