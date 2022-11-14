local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BlackMarket skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	BlackMarketFrame:StripTextures()
	BlackMarketFrame:SetTemplate("Transparent")

	BlackMarketFrame.Inset:CreateBackdrop("Overlay")
	BlackMarketFrame.Inset.backdrop:SetPoint("TOPLEFT", 0, 0)
	BlackMarketFrame.Inset.backdrop:SetPoint("BOTTOMRIGHT", 1, 4)

	T.SkinScrollBar(BlackMarketFrame.ScrollBar)
	BlackMarketFrame.MoneyFrameBorder:StripTextures()
	T.SkinEditBox(BlackMarketBidPriceGold, nil, 18)

	BlackMarketFrame.BidButton:SkinButton()
	BlackMarketFrame.BidButton:SetHeight(20)
	BlackMarketFrame.BidButton:SetPoint("BOTTOMRIGHT", -255, 4)
	BlackMarketBidPrice:SetPoint("BOTTOMRIGHT", BlackMarketFrame.BidButton, "BOTTOMLEFT", 0, -2)

	BlackMarketFrame.HotDeal:StripTextures()
	BlackMarketFrame.HotDeal:CreateBackdrop("Overlay")
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

	hooksecurefunc(BlackMarketItemMixin, "Init", function (button, elementData)
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

		local name, texture = C_BlackMarket.GetItemInfoByIndex(elementData.index)
		if name then
			button.Item.IconTexture:SetTexture(texture)
		end
	end)
end

T.SkinFuncs["Blizzard_BlackMarketUI"] = LoadSkin