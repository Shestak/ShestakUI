local T, C, L = unpack(ShestakUI)
if C.extra_general.sum_buyouts ~= true then return end

----------------------------------------------------------------------------------------
--	Sum upp all current auctions(Sigma by Ailae)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AuctionUI" then
		local f = CreateFrame("Frame", nil, AuctionFrameAuctions)
		f:SetSize(200, 20)
		f:SetPoint("LEFT", AuctionFrameMoneyFrame, "RIGHT", 38, 0)

		local text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
		text:SetPoint("LEFT")

		f:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
		f:SetScript("OnEvent", function(self, event, ...)
			local total = 0

			for i = 1, GetNumAuctionItems("owner") do
				total = total + select(10, GetAuctionItemInfo("owner", i))
			end

			if total > 0 then
				text:SetText(FROM_ALL_SOURCES.." "..GetCoinTextureString(total))
			else
				text:SetText("")
			end
		end)
	end
end)