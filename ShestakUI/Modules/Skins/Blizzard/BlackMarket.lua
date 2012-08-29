local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BlackMarket skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	BlackMarketFrame:StripTextures()
	BlackMarketFrame.Inset:StripTextures()
	BlackMarketFrame:SetTemplate("Transparent")

	T.SkinScrollBar(BlackMarketScrollFrameScrollBar)
	BlackMarketFrame.MoneyFrameBorder:StripTextures()
	T.SkinEditBox(BlackMarketBidPriceGold)
	BlackMarketBidPriceGold:Height(18)
	BlackMarketFrame.HotDeal.Item.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	BlackMarketFrame.BidButton:SkinButton()
	BlackMarketFrame.BidButton:Height(20)
	BlackMarketFrame.HotDeal.BidButton:SkinButton()
	T.SkinCloseButton(BlackMarketFrame.CloseButton)

	local tabs = {"ColumnName", "ColumnLevel", "ColumnType", "ColumnDuration", "ColumnHighBidder", "ColumnCurrentBid"}
	for _, tab in pairs(tabs) do
		local tab = BlackMarketFrame[tab]

		tab:StripTextures()
	end
end

T.SkinFuncs["Blizzard_BlackMarketUI"] = LoadSkin