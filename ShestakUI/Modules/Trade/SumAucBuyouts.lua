local T, C, L, _ = unpack(select(2, ...))
if C.trade.sum_buyouts ~= true then return end

----------------------------------------------------------------------------------------
--	Sum up all current auctions(Sigma by Ailae)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_AuctionHouseUI" then
		local f = CreateFrame("Frame", nil, AuctionHouseFrame)
		f:SetSize(200, 20)
		f:SetPoint("LEFT", AuctionHouseFrame.MoneyFrameBorder, "RIGHT", 38, -1)

		local text = f:CreateFontString(nil, "OVERLAY", "PriceFont")
		text:SetPoint("LEFT")

		f:RegisterEvent("OWNED_AUCTIONS_UPDATED")
		f:SetScript("OnEvent", function()
			local totalBuyout = 0
			local totalBid = 0

			for i = 1, C_AuctionHouse.GetNumOwnedAuctions() do
				local info = C_AuctionHouse.GetOwnedAuctionInfo(i)
				if info.buyoutAmount then
					totalBuyout = totalBuyout + (info.buyoutAmount * info.quantity)
				end
				if info.bidAmount then
					totalBid = totalBid + info.bidAmount
				end
			end

			if totalBid > 0 and totalBuyout > 0 then
				text:SetText(BIDS..": "..GetCoinTextureString(totalBid).."     "..BUYOUT..": "..GetCoinTextureString(totalBuyout))
			elseif totalBid > 0 and totalBuyout == 0 then
				text:SetText(BIDS..": "..GetCoinTextureString(totalBid))
			elseif totalBid == 0 and totalBuyout > 0 then
				text:SetText(BUYOUT..": "..GetCoinTextureString(totalBuyout))
			else
				text:SetText("")
			end
		end)
	end
end)