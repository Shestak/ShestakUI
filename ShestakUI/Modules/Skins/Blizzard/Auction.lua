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
		AuctionHouseFrameScrollBar,
		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollFrame.scrollBar,
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
		if AuctionFrameTab4 then
			T.SkinTab(AuctionFrameTab4)
		end
	end)

	T.SkinTab(AuctionHouseFrameAuctionsFrameAuctionsTab, true)
	T.SkinTab(AuctionHouseFrameAuctionsFrameBidsTab, true)

	AuctionHouseFrameBuyTab:ClearAllPoints()
	AuctionHouseFrameBuyTab:SetPoint("BOTTOMLEFT", AuctionHouseFrame, "BOTTOMLEFT", 0, -32)

	AuctionHouseFrame.CategoriesList:StripTextures()
	AuctionHouseFrame.CategoriesList.ScrollFrame:StripTextures()

	for i = 1, NUM_FILTERS_TO_DISPLAY do
		local button = AuctionHouseFrame.CategoriesList.FilterButtons[i]
		button:StripTextures(true)
		button:CreateBackdrop("Overlay")
		button.backdrop:SetPoint("TOPLEFT", button.SelectedTexture, "TOPLEFT", 1, -1)
		button.backdrop:SetPoint("BOTTOMRIGHT", button.SelectedTexture, "BOTTOMRIGHT", -1, 1)
	end

	hooksecurefunc("AuctionFrameFilters_UpdateCategories", function(categoriesList)
		for _, button in ipairs(categoriesList.FilterButtons) do
			button.SelectedTexture:SetAtlas(nil)
			if button.SelectedTexture:IsShown() then
				button.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				button.backdrop.overlay:SetVertexColor(1, 0.82, 0, 0.3)
			else
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
			end
			if button.type == "subSubCategory" then
				button.SelectedTexture:SetHeight(21)
				button.SelectedTexture:SetPoint("TOPRIGHT", 0, 0)
			end
		end
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

	local function SkinSummaryIcons(frame)
		for i = 1, 23 do
			local child = select(i, frame.ScrollFrame.scrollChild:GetChildren())

			if child and child.Icon then
				if not child.IsSkinned then
					child.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

					if child.IconBorder then
						child.IconBorder:SetAlpha(0)
					end

					child.IsSkinned = true
				end
			end
		end
	end

	hooksecurefunc(AuctionHouseFrameAuctionsFrame.SummaryList, "RefreshScrollFrame", SkinSummaryIcons)

	local function SkinAuctionFrame(frame, scroll)
		frame:StripTextures()
		frame.RefreshFrame.RefreshButton:SkinButton()
		frame.RefreshFrame.RefreshButton:SetSize(24, 24)
		T.SkinScrollBar(frame.ScrollFrame.scrollBar)
		if scroll then
			frame.ScrollFrame.scrollBar:SetPoint("BOTTOMLEFT", frame.ScrollFrame, "BOTTOMRIGHT", 4, 15)
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

	T.SkinScrollBar(buyFrame.ItemList.ScrollFrame.scrollBar)

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
	TokenTutorial.TitleBg:Hide()
	TokenTutorial:CreateBackdrop("Transparent")
	T.SkinCloseButton(TokenTutorial.CloseButton)
	TokenTutorial.Bg:SetAlpha(0)

	-- Auctionator
	--FIXME if not IsAddOnLoaded("Auctionator") then return end

	-- local buttons = {
		-- "Atr_Search_Button",
		-- "Atr_Back_Button",
		-- "Atr_Buy1_Button",
		-- "Atr_FullScanButton",
		-- "Auctionator1Button",
		-- "Atr_ListTabsTab1",
		-- "Atr_ListTabsTab2",
		-- "Atr_ListTabsTab3",
		-- "Atr_CreateAuctionButton",
		-- "Atr_RemFromSListButton",
		-- "Atr_AddToSListButton",
		-- "Atr_SrchSListButton",
		-- "Atr_DelSListButton",
		-- "Atr_NewSListButton",
		-- "Atr_CheckActiveButton",
		-- "AuctionatorCloseButton",
		-- "Atr_CancelSelectionButton",
		-- "Atr_FullScanStartButton",
		-- "Atr_FullScanDone",
		-- "Atr_CheckActives_Yes_Button",
		-- "Atr_CheckActives_No_Button",
		-- "Atr_Adv_Search_ResetBut",
		-- "Atr_Adv_Search_OKBut",
		-- "Atr_Adv_Search_CancelBut",
		-- "Atr_Buy_Confirm_OKBut",
		-- "Atr_Buy_Confirm_CancelBut",
		-- "Atr_MngSListsButton",
		-- "Atr_SaveThisList_Button",
	-- }

	-- for i = 1, getn(buttons) do
		-- local frame = _G[buttons[i]]
		-- if frame then
			-- _G[buttons[i]]:SkinButton(true)
		-- end
	-- end

	-- local dropdown = {
		-- "Atr_DropDown1",
		-- "Atr_Duration",
		-- "Atr_DropDownSL",
		-- "Atr_ASDD_Class",
		-- "Atr_ASDD_Subclass"
	-- }

	-- for i = 1, getn(dropdown) do
		-- local frame = _G[dropdown[i]]
		-- if frame then
			-- T.SkinDropDownBox(_G[dropdown[i]])
		-- end
	-- end

	-- local editbox = {
		-- "Atr_StackPriceGold",
		-- "Atr_StackPriceSilver",
		-- "Atr_StackPriceCopper",
		-- "Atr_ItemPriceGold",
		-- "Atr_ItemPriceSilver",
		-- "Atr_ItemPriceCopper",
		-- "Atr_Batch_NumAuctions",
		-- "Atr_Batch_Stacksize",
		-- "Atr_Search_Box",
		-- "Atr_AS_Searchtext",
		-- "Atr_AS_Minlevel",
		-- "Atr_AS_Maxlevel",
		-- "Atr_AS_MinItemlevel",
		-- "Atr_AS_MaxItemlevel",
		-- "Atr_StartingPriceGold",
		-- "Atr_StartingPriceSilver",
		-- "Atr_StartingPriceCopper"
	-- }

	-- for i = 1, getn(editbox) do
		-- local frame = _G[editbox[i]]
		-- if frame then
			-- T.SkinEditBox(_G[editbox[i]])
		-- end
	-- end

	-- local frames = {
		-- "Atr_FullScanResults",
		-- "Atr_Adv_Search_Dialog",
		-- "Atr_FullScanFrame",
		-- "Atr_HeadingsBar",
		-- "Atr_Error_Frame",
		-- "Atr_Hlist",
		-- "Atr_Buy_Confirm_Frame",
		-- "Atr_CheckActives_Frame",
		-- "Atr_Hilite1",
		-- "Atr_BasicOptionsFrame",
		-- "Atr_TooltipsOptionsFrame",
		-- "Atr_UCConfigFrame",
		-- "Atr_StackingOptionsFrame",
		-- "Atr_ShpList_Options_Frame",
		-- "AuctionatorResetsFrame",
		-- "Atr_ScanningOptionsFrame",
		-- "AuctionatorDescriptionFrame"
	-- }

	-- for i = 1, getn(frames) do
		-- local frame = _G[frames[i]]
		-- if frame then
			-- _G[frames[i]]:StripTextures()
		-- end
	-- end

	-- T.SkinCheckBox(Atr_Exact_Search_Button)
	-- T.SkinCheckBox(Atr_Adv_Search_Button)

	-- Atr_Mask:ClearAllPoints()
	-- Atr_Mask:SetPoint("TOPLEFT", AuctionFrame, "TOPLEFT", 0, 0)
	-- Atr_Mask:SetPoint("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT", 0, 0)

	-- Atr_Adv_Search_Dialog:SetTemplate("Transparent")
	-- Atr_FullScanFrame:SetTemplate("Overlay")

	-- Atr_FullScanResults:CreateBorder(true, true)
	-- local border = CreateFrame("Frame", "Atr_FullScanResultsBorder", Atr_FullScanResults)
	-- border:SetPoint("TOPLEFT")
	-- border:SetPoint("BOTTOMRIGHT")
	-- border:SetBackdrop({
		-- edgeFile = C.media.blank, edgeSize = T.mult,
		-- insets = {left = T.mult, right = T.mult, top = T.mult, bottom = T.mult}
	-- })
	-- border:SetBackdropBorderColor(unpack(C.media.border_color))

	-- Atr_Buy_Confirm_Frame:SetTemplate("Default")
	-- Atr_CheckActives_Frame:SetTemplate("Transparent")
	-- Atr_Error_Frame:SetTemplate("Transparent")

	-- Atr_HeadingsBar:CreateBackdrop("Overlay")
	-- Atr_HeadingsBar.backdrop:SetPoint("TOPLEFT", 0, -25)
	-- Atr_HeadingsBar.backdrop:SetPoint("BOTTOMRIGHT", 3, -183)

	-- Atr_SellControls:CreateBackdrop("Overlay")
	-- Atr_SellControls.backdrop:SetPoint("TOPLEFT", -2, 0)
	-- Atr_SellControls.backdrop:SetPoint("BOTTOMRIGHT", 25, 0)

	-- Atr_DropDownSL:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -190, -41)

	-- Atr_Hlist:CreateBackdrop("Overlay")
	-- Atr_Hlist.backdrop:SetPoint("TOPLEFT", -2, 0)
	-- Atr_Hlist.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)
	-- Atr_Hlist:SetWidth(195)

	-- Atr_Hlist_ScrollFrameScrollBar:ClearAllPoints()
	-- Atr_Hlist_ScrollFrameScrollBar:SetPoint("TOPRIGHT", Atr_Hlist, "TOPRIGHT", -5, -20)
	-- Atr_Hlist_ScrollFrameScrollBar:SetPoint("BOTTOMRIGHT", Atr_Hlist, "BOTTOMRIGHT", -5, 22)
	-- T.SkinScrollBar(Atr_Hlist_ScrollFrameScrollBar)

	-- T.SkinScrollBar(AuctionatorScrollFrameScrollBar)

	-- hooksecurefunc("AuctionFrameTab_OnClick", function(self)
		-- local index = self:GetID()
		-- if index == 4 then
			-- Atr_Hlist:SetPoint("TOPLEFT", -193, -67)
		-- else
			-- Atr_Hlist:SetHeight(337)
			-- Atr_Hlist_ScrollFrame:SetHeight(337)
			-- Atr_Hlist:SetPoint("TOPLEFT", -193, -75)
		-- end
	-- end)

	-- Atr_AddToSListButton:SetWidth(97)
	-- Atr_RemFromSListButton:SetWidth(97)
	-- Atr_SrchSListButton:SetWidth(197)
	-- Atr_MngSListsButton:SetWidth(197)
	-- Atr_NewSListButton:SetWidth(197)

	-- Atr_AddToSListButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -195, -321)
	-- Atr_RemFromSListButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -95, -321)
	-- Atr_SrchSListButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -195, -344)
	-- Atr_MngSListsButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -195, -367)
	-- Atr_NewSListButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -195, -390)

	-- Atr_Hilite1:CreateBackdrop("Overlay")
	-- Atr_Hilite1.backdrop:SetPoint("TOPLEFT", 1, -3)
	-- Atr_Hilite1.backdrop:SetPoint("BOTTOMRIGHT", 3, -1)

	-- Atr_Search_Box:SetHeight(Atr_Search_Box:GetHeight() - 2)
	-- Auctionator1Button:SetSize(66, 18)
	-- Auctionator1Button:ClearAllPoints()
	-- Auctionator1Button:SetPoint("TOPRIGHT", Atr_Main_Panel, "TOPRIGHT", -35, -4)
	-- Atr_Search_Button:SetHeight(22)
	-- Atr_Back_Button:SetHeight(22)
	-- Atr_FullScanButton:SetSize(100, 25)
	-- Atr_FullScanButton:ClearAllPoints()
	-- Atr_FullScanButton:SetPoint("TOPRIGHT", Auctionator1Button, "BOTTOMRIGHT", 0, -20)

	-- Atr_CreateAuctionButton:SetWidth(165)
	-- Atr_CreateAuctionButton:ClearAllPoints()
	-- Atr_CreateAuctionButton:SetPoint("CENTER", 14, -20)

	-- AuctionatorCloseButton:ClearAllPoints()
	-- AuctionatorCloseButton:SetPoint("BOTTOMRIGHT", Atr_Main_Panel, "BOTTOMRIGHT", -8, 10)
	-- Atr_Buy1_Button:SetPoint("RIGHT", AuctionatorCloseButton, "LEFT", -4, 0)
	-- Atr_CancelSelectionButton:SetPoint("RIGHT", Atr_Buy1_Button, "LEFT", -4, 0)

	-- Atr_RecommendItem_Tex:SetTemplate("Default")
	-- Atr_RecommendItem_Tex:StyleButton()
	-- Atr_RecommendItem_Tex:SetScript("OnUpdate", function()
		-- if Atr_RecommendItem_Tex:GetNormalTexture() then
			-- Atr_RecommendItem_Tex:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			-- Atr_RecommendItem_Tex:GetNormalTexture():ClearAllPoints()
			-- Atr_RecommendItem_Tex:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			-- Atr_RecommendItem_Tex:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		-- end
	-- end)

	-- Atr_SellControls_Tex:SetTemplate("Default")
	-- Atr_SellControls_Tex:StyleButton()

	-- Atr_SellControls_Tex:SetScript("OnUpdate", function()
		-- if Atr_SellControls_Tex:GetNormalTexture() then
			-- Atr_SellControls_Tex:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			-- Atr_SellControls_Tex:GetNormalTexture():ClearAllPoints()
			-- Atr_SellControls_Tex:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			-- Atr_SellControls_Tex:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		-- end
	-- end)
end


T.SkinFuncs["Blizzard_AuctionHouseUI"] = LoadSkin