local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Shift+Click to cancel/bid/buyout items in auction(OneClickBuyOut by Egingell)
----------------------------------------------------------------------------------------
local LoadOCBO = CreateFrame("Frame")
LoadOCBO:RegisterEvent("ADDON_LOADED")
LoadOCBO:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Blizzard_AuctionUI" or addon == "OneClickBuyOut" then return end
	local f, buyoutPrice, index, minBid, minIncrement, bidAmount, bid, name
	local gt, buttonNames = GameTooltip, {"BrowseButton"}

	local function DoBid(index, minBid, minIncrement, buyoutPrice, bidAmount)
		if buyoutPrice > 0 then
			bid = buyoutPrice
		else
			bid = math.max(minBid, bidAmount + minIncrement)
			if bid == 0 then
				bid = buyoutPrice
			end
		end
		PlaceAuctionBid("list", index, bid)
	end

	for _, buttonName in pairs(buttonNames) do
		for i = 1, 20 do
			f = _G[buttonName..i]
			if f then
				f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
				f:HookScript("OnClick", function(self, button)
					if button == "RightButton" and IsShiftKeyDown() then
						index = self:GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame)
						name, _, _, _, _, _, _, minBid, minIncrement, buyoutPrice, bidAmount = GetAuctionItemInfo("list", index)
						if name then
							DoBid(index, minBid, minIncrement, buyoutPrice, bidAmount)
						end
					end
				end)
			end
		end
	end

	for i = 1, 20 do
		f = _G["AuctionsButton"..i]
		if f then
			f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			f:HookScript("OnClick", function(self, button)
				index = self:GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame)
				if button == "RightButton" and IsShiftKeyDown() then
					name = GetAuctionItemInfo("owner", index)
					if name then
						CancelAuction(index)
					end
				end
			end)
		end
	end

	BrowseBuyoutButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	BrowseBuyoutButton:SetScript("OnClick", function(self, button)
		if button and IsShiftKeyDown() then
			PlaceAuctionBid(AuctionFrame.type, GetSelectedAuctionItem(AuctionFrame.type), AuctionFrame.buyoutPrice)
		else
			StaticPopup_Show("BUYOUT_AUCTION")
		end
		self:Disable()
	end)

	BrowseBuyoutButton:HookScript("OnEnter", function(self)
		gt:SetOwner(self)
		gt:AddLine(L_MISC_ONECLICK_BUYOUT, nil, nil, nil, 1)
		gt:Show()
	end)

	BrowseBuyoutButton:HookScript("OnLeave", function(self)
		gt:Hide()
	end)

	BrowseBidButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	BrowseBidButton:SetScript("OnClick", function(self, button)
		if button and IsShiftKeyDown() then
			PlaceAuctionBid("list", GetSelectedAuctionItem("list"), MoneyInputFrame_GetCopper(BrowseBidPrice))
		else
			StaticPopup_Show("BID_AUCTION")
		end
		self:Disable()
	end)

	BrowseBidButton:HookScript("OnEnter", function(self)
		gt:SetOwner(self)
		gt:AddLine(L_MISC_ONECLICK_BID, nil, nil, nil, 1)
		gt:Show()
	end)

	BrowseBidButton:HookScript("OnLeave", function(self)
		gt:Hide()
	end)

	AuctionsCancelAuctionButton:HookScript("OnEnter", function(self)
		gt:SetOwner(self)
		gt:AddLine(L_MISC_ONECLICK_CANCEL, nil, nil, nil, 1)
		gt:Show()
	end)

	AuctionsCancelAuctionButton:HookScript("OnLeave", function(self)
		gt:Hide()
	end)
end)