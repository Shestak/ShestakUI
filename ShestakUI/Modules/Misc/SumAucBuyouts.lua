local T, C, L, _ = unpack(select(2, ...))
if C.misc.sum_buyouts ~= true then return end

----------------------------------------------------------------------------------------
--	Sum up all current auctions(Sigma by Ailae)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AuctionUI" then
		local f = CreateFrame("Frame", nil, AuctionFrameAuctions)
		f:SetSize(200, 20)
		f:SetPoint("LEFT", AuctionFrameMoneyFrame, "RIGHT", 38, -1)

		local text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
		text:SetPoint("LEFT")

		f:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
		f:SetScript("OnEvent", function(self, event, ...)
			local totalBuyout = 0
			local totalBid = 0

			for i = 1, GetNumAuctionItems("owner") do
				totalBuyout = totalBuyout + select(10, GetAuctionItemInfo("owner", i))
				totalBid = totalBid + select(8, GetAuctionItemInfo("owner", i))
			end

			if totalBuyout > 0 then
				text:SetText(BIDS..": "..GetCoinTextureString(totalBid).."     "..BUYOUT..": "..GetCoinTextureString(totalBuyout))
			elseif totalBid > 0 and totalBuyout == 0 then
				text:SetText(BIDS..": "..GetCoinTextureString(totalBid))
			else
				text:SetText("")
			end
		end)
	end
end)