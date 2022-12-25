local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AuctionUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	AuctionHouseFrame:StripTextures()
	AuctionHouseFrame:SetTemplate("Transparent")
	AuctionHouseFramePortrait:SetAlpha(0)

	AuctionHouseFrame.MoneyFrameBorder:StripTextures()
	AuctionHouseFrame.MoneyFrameInset:StripTextures()

	T.SkinCloseButton(AuctionHouseFrameCloseButton)

	AuctionHouseFrame.SearchBar.FavoritesSearchButton:SetSize(22, 22)
	T.SkinEditBox(AuctionHouseFrame.SearchBar.SearchBox, nil, 18)
	T.SkinCloseButton(AuctionHouseFrame.SearchBar.FilterButton.ClearFiltersButton)
	AuctionHouseFrame.SearchBar.FilterButton.ClearFiltersButton:SetPoint("TOPRIGHT", 3, 6)

	local function SkinEditBoxes(Frame)
		T.SkinEditBox(Frame.MinLevel)
		T.SkinEditBox(Frame.MaxLevel)
		Frame.MinLevel.backdrop:SetPoint("BOTTOMRIGHT", -3, 0)
		Frame.MaxLevel.backdrop:SetPoint("BOTTOMRIGHT", -3, 0)
	end

	SkinEditBoxes(AuctionHouseFrame.SearchBar.FilterButton.LevelRangeFrame)

	local buttons = {
		AuctionHouseFrame.SearchBar.SearchButton,
		AuctionHouseFrame.SearchBar.FilterButton,
		AuctionHouseFrame.SearchBar.FavoritesSearchButton,
		AuctionHouseFrame.ItemSellFrame.QuantityInput.MaxButton,
		AuctionHouseFrame.ItemSellFrame.PostButton,
		AuctionHouseFrame.CommoditiesSellFrame.PostButton,
		AuctionHouseFrame.CommoditiesSellFrame.QuantityInput.MaxButton,
		AuctionHouseFrameAuctionsFrame.CancelAuctionButton,
		AuctionHouseFrameAuctionsFrame.BidFrame.BidButton,
		AuctionHouseFrameAuctionsFrame.BuyoutFrame.BuyoutButton,
		AuctionHouseFrame.ItemBuyFrame.BackButton,
		AuctionHouseFrame.ItemBuyFrame.BidFrame.BidButton,
		AuctionHouseFrame.ItemBuyFrame.BuyoutFrame.BuyoutButton,
		AuctionHouseFrame.BuyDialog.BuyNowButton,
		AuctionHouseFrame.BuyDialog.CancelButton,
		AuctionHouseFrame.WoWTokenResults.Buyout,
		AuctionHouseFrame.WoWTokenResults.GameTimeTutorial.RightDisplay.StoreButton
	}

	for i = 1, #buttons do
		buttons[i]:SkinButton()
	end

	local scrollbars = {
		AuctionHouseFrame.CategoriesList.ScrollBar,
		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar,
		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar,
		AuctionHouseFrame.WoWTokenResults.DummyScrollBar
	}

	for i = 1, #scrollbars do
		T.SkinScrollBar(scrollbars[i])
	end

	local tabs = {
		AuctionHouseFrameBuyTab,
		AuctionHouseFrameSellTab,
		AuctionHouseFrameAuctionsTab
	}

	for _, tab in pairs(tabs) do
		if tab then
			T.SkinTab(tab)
		end
	end

	AuctionHouseFrame:HookScript("OnShow", function()
		if AuctionFrameTab4 and not AuctionFrameTab4.styled then
			T.SkinTab(AuctionFrameTab4)
			AuctionFrameTab4.styled = true
		end
	end)

	T.SkinTab(AuctionHouseFrameAuctionsFrameAuctionsTab, true)
	T.SkinTab(AuctionHouseFrameAuctionsFrameBidsTab, true)

	AuctionHouseFrameBuyTab:ClearAllPoints()
	AuctionHouseFrameBuyTab:SetPoint("BOTTOMLEFT", AuctionHouseFrame, "BOTTOMLEFT", 0, -32)

	AuctionHouseFrame.CategoriesList:StripTextures()

	hooksecurefunc('AuctionHouseFilterButton_SetUp', function(button, info)
		button:CreateBackdrop("Overlay")
		button.backdrop:SetPoint("TOPLEFT", button.SelectedTexture, "TOPLEFT", 1, -1)
		button.backdrop:SetPoint("BOTTOMRIGHT", button.SelectedTexture, "BOTTOMRIGHT", -1, 1)

		button.NormalTexture:SetAlpha(0)
		button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.2)
		button.HighlightTexture:SetColorTexture(1, 1, 1, 0.2)
	end)

	local function SkinListIcon(frame)
		if not frame.tableBuilder then return end

		for i = 1, 22 do
			local row = frame.tableBuilder.rows[i]
			if row then
				for j = 1, 4 do
					local cell = row.cells and row.cells[j]
					if cell and cell.Icon then
						if not cell.IsSkinned then
							cell.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							if cell.IconBorder then cell.IconBorder:SetAlpha(0) end

							cell.IsSkinned = true
						end
					end
				end
			end
		end
	end

	local function SkinHeaders(frame)
		local maxHeaders = frame.HeaderContainer:GetNumChildren()
		for i = 1, maxHeaders do
			local header = select(i, frame.HeaderContainer:GetChildren())
			if header and not header.IsSkinned then
				header:DisableDrawLayer("BACKGROUND")
				header:GetHighlightTexture():Hide()
				header:CreateBackdrop("Overlay")
				header.backdrop:SetPoint("TOPLEFT", 2, 0)
				header.backdrop:SetPoint("BOTTOMRIGHT", -2, 0)

				header.IsSkinned = true
			end
		end

		SkinListIcon(frame)
	end

	hooksecurefunc(AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBox, "Update", function(frame)
		for _, button in next, {frame.ScrollTarget:GetChildren()} do
			if not button.styled then
				if button.Icon then
					button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					 if button.IconBorder then
						button.IconBorder:SetAlpha(0)
					end
				end
				button.styled = true
			end
		end
	end)

	local function SkinAuctionFrame(frame, scroll)
		frame:StripTextures()
		frame.RefreshFrame.RefreshButton:SkinButton()
		frame.RefreshFrame.RefreshButton:SetSize(24, 24)
		T.SkinScrollBar(frame.ScrollBar)
		if scroll then
			frame.ScrollBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 15)
		end
		hooksecurefunc(frame, "RefreshScrollFrame", SkinHeaders)
	end

	SkinAuctionFrame(AuctionHouseFrame.BrowseResultsFrame.ItemList)
	SkinAuctionFrame(AuctionHouseFrame.ItemBuyFrame.ItemList, true)
	SkinAuctionFrame(AuctionHouseFrame.ItemSellList)
	SkinAuctionFrame(AuctionHouseFrame.CommoditiesSellList)
	SkinAuctionFrame(AuctionHouseFrameAuctionsFrame.ItemList)
	SkinAuctionFrame(AuctionHouseFrameAuctionsFrame.AllAuctionsList, true)
	SkinAuctionFrame(AuctionHouseFrameAuctionsFrame.BidsList, true)
	SkinAuctionFrame(AuctionHouseFrameAuctionsFrame.CommoditiesList, true)

	local function SkinItemIcon(frame, nostrip)
		if not nostrip then frame:StripTextures() end
		if frame.IconMask then frame.IconMask:Hide() end
		if frame.CircleMask then frame.CircleMask:Hide() end
		if frame.IconBorder then frame.IconBorder:SetAlpha(0) end
		frame.Icon:SkinIcon()
	end

	AuctionHouseFrame.ItemBuyFrame.ItemDisplay:StripTextures()
	SkinItemIcon(AuctionHouseFrame.ItemBuyFrame.ItemDisplay.ItemButton)
	T.SkinEditBox(AuctionHouseFrameGold)
	T.SkinEditBox(AuctionHouseFrameSilver)

	local buyFrame = AuctionHouseFrame.CommoditiesBuyFrame
	buyFrame.BackButton:SkinButton()
	buyFrame.BuyDisplay.BuyButton:SkinButton()
	buyFrame.ItemList.RefreshFrame.RefreshButton:SkinButton()
	buyFrame.ItemList.RefreshFrame.RefreshButton:SetSize(24, 24)

	buyFrame.BuyDisplay:StripTextures()
	buyFrame.ItemList:StripTextures()

	buyFrame.BuyDisplay.QuantityInput.InputBox:DisableDrawLayer("BACKGROUND")
	buyFrame.BuyDisplay.QuantityInput.InputBox:CreateBackdrop("Overlay")
	buyFrame.BuyDisplay.QuantityInput.InputBox.backdrop:SetPoint("TOPLEFT", 2, -2)
	buyFrame.BuyDisplay.QuantityInput.InputBox.backdrop:SetPoint("BOTTOMRIGHT", -20, 6)

	local itemDisplay = buyFrame.BuyDisplay.ItemDisplay
	itemDisplay:StripTextures()
	itemDisplay.ItemButton.Icon:SkinIcon()
	itemDisplay.ItemButton.CircleMask:Hide()
	itemDisplay.ItemButton.IconBorder:SetAlpha(0)

	local function SkinMoneyBox(frame)
		frame:DisableDrawLayer("BACKGROUND")
		frame:CreateBackdrop("Overlay")
		frame.backdrop:SetPoint("TOPLEFT", 6, -2)
		frame.backdrop:SetPoint("BOTTOMRIGHT", -22, 6)
	end

	for _, frame in pairs({AuctionHouseFrame.ItemSellFrame, AuctionHouseFrame.CommoditiesSellFrame}) do
		frame:StripTextures()
		frame.ItemDisplay:StripTextures()

		SkinItemIcon(frame.ItemDisplay.ItemButton)

		SkinMoneyBox(frame.PriceInput.MoneyInputFrame.GoldBox)
		SkinMoneyBox(frame.PriceInput.MoneyInputFrame.SilverBox)
		SkinMoneyBox(frame.QuantityInput.InputBox)
		if frame.SecondaryPriceInput then
			SkinMoneyBox(frame.SecondaryPriceInput.MoneyInputFrame.GoldBox)
			SkinMoneyBox(frame.SecondaryPriceInput.MoneyInputFrame.SilverBox)
		end

		T.SkinDropDownBox(frame.DurationDropDown.DropDown)
		frame.DurationDropDown.DropDown.backdrop:SetPoint("TOPLEFT", 20, -1)
	end

	T.SkinCheckBox(AuctionHouseFrame.ItemSellFrame.BuyoutModeCheckButton, 25)

	AuctionHouseFrameAuctionsFrame.SummaryList:StripTextures()
	AuctionHouseFrameAuctionsFrame.ItemDisplay:StripTextures()

	SkinItemIcon(AuctionHouseFrameAuctionsFrame.ItemDisplay.ItemButton)

	T.SkinEditBox(AuctionHouseFrameAuctionsFrameGold)
	T.SkinEditBox(AuctionHouseFrameAuctionsFrameSilver)

	AuctionHouseFrame.BuyDialog:StripTextures()
	AuctionHouseFrame.BuyDialog:SetTemplate("Transparent")

	-- WoW Token
	AuctionHouseFrame.WoWTokenResults:StripTextures()
	AuctionHouseFrame.WoWTokenResults.TokenDisplay:StripTextures()
	SkinItemIcon(AuctionHouseFrame.WoWTokenResults.TokenDisplay.ItemButton, true)

	local TokenTutorial = AuctionHouseFrame.WoWTokenResults.GameTimeTutorial
	TokenTutorial.NineSlice:Hide()
	TokenTutorial:CreateBackdrop("Transparent")
	T.SkinCloseButton(TokenTutorial.CloseButton)
	TokenTutorial.Bg:SetAlpha(0)

	-- Auctionator skin (from AddOnSkins)
	if IsAddOnLoaded("Auctionator") then
		C_Timer.After(0.05, function()
			local list = _G.AuctionatorShoppingFrame
			if not list then return end

			local config = _G.AuctionatorConfigFrame
			local selling = _G.AuctionatorSellingFrame
			local cancelling = _G.AuctionatorCancellingFrame

			T.SkinTab(AuctionatorTabs_Shopping)
			T.SkinTab(AuctionatorTabs_Selling)
			T.SkinTab(AuctionatorTabs_Cancelling)
			T.SkinTab(AuctionatorTabs_Auctionator)

			local frames = {
				list.ScrollListRecents,
				list.ScrollListShoppingList,
				list.ShoppingResultsInset,
				selling.CurrentItemInset,
				selling.HistoricalPriceInset,
				selling.BagInset,
				selling.BagListing.ScrollFrame,
				cancelling.HistoricalPriceInset,
				AuctionatorConfigFrame
			}

			for i = 1, #frames do
				if frames[i] then
					frames[i]:StripTextures()
				end
			end

			local buttons = {
				list.AddItem,
				list.ManualSearch,
				list.SortItems,
				list.Export,
				list.Import,
				list.ExportCSV,
				list.OneItemSearch.SearchButton,
				list.OneItemSearch.ExtendedButton,
				selling.SaleItemFrame.MaxButton,
				selling.SaleItemFrame.PostButton,
				config.OptionsButton,
				config.ScanButton
			}

			for i = 1, #buttons do
				if buttons[i] then
					buttons[i]:SkinButton()
				end
			end

			list.ManualSearch:SetPoint("TOPRIGHT", list.ScrollListShoppingList, "BOTTOMRIGHT", -7, -4)

			local scrollbars = {
				list.ScrollListShoppingList.ScrollBar,
				list.ScrollListRecents.ScrollBar,
				list.ResultsListing.ScrollArea.ScrollBar,
				selling.CurrentPricesListing.ScrollArea.ScrollBar,
				selling.HistoricalPriceListing.ScrollArea.ScrollBar,
				selling.BagListing.ScrollBar,
				selling.ResultsListing.ScrollArea.ScrollBar,
				cancelling.ResultsListing.ScrollArea.ScrollBar
			}

			for i = 1, #scrollbars do
				T.SkinScrollBar(scrollbars[i])
			end

			local editboxes = {
				selling.SaleItemFrame.Price.MoneyInput.GoldBox,
				selling.SaleItemFrame.Price.MoneyInput.SilverBox,
				selling.SaleItemFrame.Price.MoneyInput.CopperBox
			}

			for i = 1, #editboxes do
				editboxes[i]:DisableDrawLayer("BACKGROUND")
				editboxes[i]:CreateBackdrop("Overlay")
				editboxes[i].backdrop:SetPoint("TOPLEFT", 6, -2)
				editboxes[i].backdrop:SetPoint("BOTTOMRIGHT", -22, 6)
			end

			local editboxes = {
				list.OneItemSearch.SearchBox,
				selling.SaleItemFrame.Quantity.InputBox,
				config.DiscordLink.InputBox,
				config.BugReportLink.InputBox,
				cancelling.SearchFilter
			}

			for i = 1, #editboxes do
				T.SkinEditBox(editboxes[i])
			end
			selling.SaleItemFrame.Quantity.InputBox.backdrop:SetPoint("TOPLEFT", 2, 4)
			selling.SaleItemFrame.Quantity.InputBox.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)

			local function SkinHeaders(frame)
				local maxHeaders = frame:GetNumChildren()
				for i = 1, maxHeaders do
					local header = select(i, frame:GetChildren())
					if header and not header.IsSkinned then
						header:DisableDrawLayer("BACKGROUND")
						header:GetHighlightTexture():Hide()
						header:CreateBackdrop("Overlay")
						header.backdrop:SetPoint("TOPLEFT", 2, 0)
						header.backdrop:SetPoint("BOTTOMRIGHT", -2, 0)

						header.IsSkinned = true
					end
				end
			end

			local headers = {
				list.ResultsListing.HeaderContainer,
				cancelling.ResultsListing.HeaderContainer,
				selling.CurrentPricesListing.HeaderContainer,
				selling.HistoricalPriceListing.HeaderContainer,
				selling.ResultsListing.HeaderContainer
			}

			for i = 1, #headers do
				SkinHeaders(headers[i])
			end

			T.SkinDropDownBox(list.ListDropdown, 230)
			list.OneItemSearch.SearchButton:SetPoint("TOPLEFT", list.OneItemSearch.SearchBox, "TOPRIGHT", 5, 1)

			local tabs = {
				list.RecentsTabsContainer.ListTab,
				list.RecentsTabsContainer.RecentsTab,
				selling.PricesTabsContainer.CurrentPricesTab,
				selling.PricesTabsContainer.PriceHistoryTab,
				selling.PricesTabsContainer.YourHistoryTab,
			}

			for i = 1, #tabs do
				local tab = tabs[i]
				tab:DisableDrawLayer("BACKGROUND")
				tab:StripTextures()
				tab.backdrop = CreateFrame("Frame", nil, tab)
				tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
				tab.backdrop:SetTemplate("Overlay")
				if i > 2 then
					tab.backdrop:SetPoint("TOPLEFT", 8, -3)
					tab.backdrop:SetPoint("BOTTOMRIGHT", -8, 3)
				else
					tab.backdrop:SetPoint("TOPLEFT", 5, -7)
					tab.backdrop:SetPoint("BOTTOMRIGHT", -5, -3)
				end
			end

			AuctionatorSellingFrame.AuctionatorSaleItem.Icon.Icon:SkinIcon(true)
			AuctionatorSellingFrame.AuctionatorSaleItem.Icon.EmptySlot:Hide()

			for _, duration in ipairs(selling.AuctionatorSaleItem.Duration.radioButtons) do
				if duration.RadioButton then
					T.SkinCheckBox(duration.RadioButton)
				end
			end

			for _, child in ipairs({cancelling:GetChildren()}) do
				if child.StartScanButton then
					child.StartScanButton:SkinButton()
					child.CancelNextButton:SkinButton()
					child.StartScanButton:SetPoint("TOPRIGHT", child.CancelNextButton, "TOPLEFT", -2, 0)
				end
			end
		end)
		local frame = CreateFrame("Frame")
		frame:RegisterEvent("TRADE_SKILL_SHOW")
		frame:SetScript("OnEvent", function(_, event)
			AuctionatorCraftingInfoProfessionsFrame.SearchButton:SkinButton()
		end)
	end
end

T.SkinFuncs["Blizzard_AuctionHouseUI"] = LoadSkin