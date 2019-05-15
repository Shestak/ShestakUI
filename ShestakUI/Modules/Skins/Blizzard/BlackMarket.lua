local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BlackMarket skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	BlackMarketFrame:StripTextures()
	BlackMarketFrame:SetTemplate("Transparent")

	T.SkinScrollBar(BlackMarketScrollFrameScrollBar)
	BlackMarketFrame.MoneyFrameBorder:StripTextures()
	T.SkinEditBox(BlackMarketBidPriceGold, nil, 18)

	BlackMarketFrame.BidButton:SkinButton()
	BlackMarketFrame.BidButton:SetHeight(20)
	BlackMarketFrame.BidButton:SetPoint("BOTTOMRIGHT", -255, 4)
	BlackMarketBidPrice:SetPoint("BOTTOMRIGHT", BlackMarketFrame.BidButton, "BOTTOMLEFT", 0, -2)

	BlackMarketFrame.HotDeal:StripTextures()
	BlackMarketFrame.HotDeal.Item.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	BlackMarketFrame.HotDeal.Item.IconBorder:SetAlpha(0)
	BlackMarketFrame.HotDeal.Item:CreateBackdrop("Default")
	BlackMarketFrame.HotDeal.Item:StyleButton()
	BlackMarketFrame.HotDeal.Item.hover:SetAllPoints()
	BlackMarketFrame.HotDeal.Item.pushed:SetAllPoints()

	T.SkinCloseButton(BlackMarketFrame.CloseButton)

	local tabs = {"ColumnName", "ColumnLevel", "ColumnType", "ColumnDuration", "ColumnHighBidder", "ColumnCurrentBid"}
	for _, tab in pairs(tabs) do
		local tab = BlackMarketFrame[tab]

		tab:StripTextures()
	end

	local function ColorItemName()
		local buttons = BlackMarketScrollFrame.buttons
		local offset = HybridScrollFrame_GetOffset(BlackMarketScrollFrame)
		local numItems = C_BlackMarket.GetNumItems()

		for i = 1, #buttons do
			local button = buttons[i]
			local index = offset + i

			if not button.skinned then
				button:StripTextures()

				button.Item:StripTextures()
				button.Item:StyleButton()
				button.Item:SetTemplate("Default")

				button.Item.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button.Item.IconTexture:ClearAllPoints()
				button.Item.IconTexture:SetPoint("TOPLEFT", 2, -2)
				button.Item.IconTexture:SetPoint("BOTTOMRIGHT", -2, 2)

				button.Item.IconBorder:SetAlpha(0)

				button:SetHighlightTexture(C.media.texture)
				button:GetHighlightTexture():SetVertexColor(0.243, 0.570, 1, 0.2)

				button.skinned = true
			end

			if button:IsShown() and button.itemLink then
				local _, _, quality = GetItemInfo(button.itemLink)
				button.Name:SetTextColor(GetItemQualityColor(quality))
			end

			if type(numItems) == "number" and index <= numItems then
				local name, texture = C_BlackMarket.GetItemInfoByIndex(index)
				if name then
					button.Item.IconTexture:SetTexture(texture)
				end
			end
		end
	end
	hooksecurefunc("BlackMarketScrollFrame_Update", ColorItemName)
	BlackMarketScrollFrame:HookScript("OnVerticalScroll", ColorItemName)
	BlackMarketScrollFrame:HookScript("OnMouseWheel", ColorItemName)

	hooksecurefunc("BlackMarketFrame_UpdateHotItem", function(self)
		local hotDeal = self.HotDeal
		if hotDeal:IsShown() and hotDeal.itemLink then
			local _, _, quality = GetItemInfo(hotDeal.itemLink)
			hotDeal.Name:SetTextColor(GetItemQualityColor(quality))
		end
	end)
end

T.SkinFuncs["Blizzard_BlackMarketUI"] = LoadSkin