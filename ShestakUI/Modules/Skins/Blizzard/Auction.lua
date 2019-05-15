local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AuctionUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinCloseButton(AuctionFrameCloseButton)
	AuctionFrame:StripTextures(true)
	AuctionFrame:SetTemplate("Transparent")

	BrowseFilterScrollFrame:StripTextures()
	BrowseScrollFrame:StripTextures()
	AuctionsScrollFrame:StripTextures()
	BidScrollFrame:StripTextures()

	T.SkinScrollBar(BrowseFilterScrollFrameScrollBar)
	T.SkinScrollBar(BrowseScrollFrameScrollBar)
	T.SkinScrollBar(AuctionsScrollFrameScrollBar)
	T.SkinScrollBar(BidScrollFrameScrollBar)

	T.SkinDropDownBox(BrowseDropDown)
	T.SkinDropDownBox(PriceDropDown)
	T.SkinDropDownBox(DurationDropDown, 80)

	T.SkinCheckBox(IsUsableCheckButton)
	T.SkinCheckBox(ShowOnPlayerCheckButton)
	T.SkinCheckBox(ExactMatchCheckButton)

	-- Dress Up Frame
	AuctionFrame:HookScript("OnShow", function()
		SideDressUpFrame:ClearAllPoints()
		SideDressUpFrame:SetPoint("TOPLEFT", AuctionFrame, "TOPRIGHT", 3, 0)
	end)

	-- WoW Token
	WowTokenGameTimeTutorial.NineSlice:Hide()
	WowTokenGameTimeTutorial.TitleBg:Hide()
	WowTokenGameTimeTutorial:CreateBackdrop("Transparent")
	WowTokenGameTimeTutorialInset.NineSlice:Hide()
	WowTokenGameTimeTutorialBg:Hide()
	StoreButton:SkinButton()
	T.SkinCloseButton(WowTokenGameTimeTutorial.CloseButton)

	BrowseWowTokenResults.Buyout:SkinButton(true)
	local Token = BrowseWowTokenResultsToken
	Token.ItemBorder:Hide()
	Token.IconBorder:Hide()
	Token.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Token:CreateBackdrop("Default")
	Token.backdrop:SetPoint("TOPLEFT", Token.IconBorder, -2, 2)
	Token.backdrop:SetPoint("BOTTOMRIGHT", Token.IconBorder, 2, -2)

	-- Progress Frame
	AuctionProgressFrame:StripTextures()
	AuctionProgressFrame:SetTemplate("Transparent")
	AuctionProgressFrameCancelButton:StyleButton()
	AuctionProgressFrameCancelButton:SetTemplate("Default")
	AuctionProgressFrameCancelButton:SetHitRectInsets(0, 0, 0, 0)
	AuctionProgressFrameCancelButton:GetNormalTexture():ClearAllPoints()
	AuctionProgressFrameCancelButton:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	AuctionProgressFrameCancelButton:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
	AuctionProgressFrameCancelButton:GetNormalTexture():SetTexCoord(0.67, 0.37, 0.61, 0.26)
	AuctionProgressFrameCancelButton:SetSize(28, 28)
	AuctionProgressFrameCancelButton:SetPoint("LEFT", AuctionProgressBar, "RIGHT", 8, 0)

	AuctionProgressBar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	local backdrop = CreateFrame("Frame", nil, AuctionProgressBar.Icon:GetParent())
	backdrop:SetPoint("TOPLEFT", AuctionProgressBar.Icon, "TOPLEFT", -2, 2)
	backdrop:SetPoint("BOTTOMRIGHT", AuctionProgressBar.Icon, "BOTTOMRIGHT", 2, -2)
	backdrop:SetTemplate("Default")
	AuctionProgressBar.Icon:SetParent(backdrop)

	AuctionProgressBar.Text:ClearAllPoints()
	AuctionProgressBar.Text:SetPoint("CENTER")

	AuctionProgressBar:StripTextures()
	AuctionProgressBar:CreateBackdrop("Default")
	AuctionProgressBar:SetStatusBarTexture(C.media.texture)
	AuctionProgressBar:SetStatusBarColor(1, 1, 0)

	T.SkinNextPrevButton(BrowseNextPageButton)
	T.SkinNextPrevButton(BrowsePrevPageButton)

	local buttons = {
		"BrowseBidButton",
		"BidBidButton",
		"BrowseBuyoutButton",
		"BidBuyoutButton",
		"BrowseCloseButton",
		"BidCloseButton",
		"BrowseSearchButton",
		"AuctionsCreateAuctionButton",
		"AuctionsCancelAuctionButton",
		"AuctionsCloseButton",
		"BrowseResetButton",
		"AuctionsStackSizeMaxButton",
		"AuctionsNumStacksMaxButton"
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton(true)
	end

	-- Fix Button Positions
	AuctionsCloseButton:SetPoint("BOTTOMRIGHT", AuctionFrameAuctions, "BOTTOMRIGHT", 66, 10)
	AuctionsCancelAuctionButton:SetPoint("RIGHT", AuctionsCloseButton, "LEFT", -4, 0)
	BidCloseButton:SetPoint("BOTTOMRIGHT", AuctionFrameBid, "BOTTOMRIGHT", 66, 10)
	BidBuyoutButton:SetPoint("RIGHT", BidCloseButton, "LEFT", -4, 0)
	BidBidButton:SetPoint("RIGHT", BidBuyoutButton, "LEFT", -4, 0)
	BrowseCloseButton:SetPoint("BOTTOMRIGHT", AuctionFrameBrowse, "BOTTOMRIGHT", 66, 10)
	BrowseBuyoutButton:SetPoint("RIGHT", BrowseCloseButton, "LEFT", -4, 0)
	BrowseBidButton:SetPoint("RIGHT", BrowseBuyoutButton, "LEFT", -4, 0)
	BrowseSearchButton:SetPoint("TOPRIGHT", AuctionFrameBrowse, "TOPRIGHT", 25, -34)
	BrowseResetButton:ClearAllPoints()
	BrowseResetButton:SetPoint("BOTTOMLEFT", BrowseSearchButton, "TOPLEFT", 0, 3)
	BrowseResetButton:SetWidth(80)

	AuctionsItemButton:StripTextures()
	AuctionsItemButton:StyleButton(true)
	AuctionsItemButton:SetTemplate("Default")
	AuctionsItemButton.IconBorder:Kill()

	AuctionsItemButton:HookScript("OnEvent", function(self, event)
		if event == "NEW_AUCTION_UPDATE" and self:GetNormalTexture() then
			self:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			self:GetNormalTexture():ClearAllPoints()
			self:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			self:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end)

	local sorttabs = {
		"BrowseQualitySort",
		"BrowseLevelSort",
		"BrowseDurationSort",
		"BrowseHighBidderSort",
		"BrowseCurrentBidSort",
		"BidQualitySort",
		"BidLevelSort",
		"BidDurationSort",
		"BidBuyoutSort",
		"BidStatusSort",
		"BidBidSort",
		"AuctionsQualitySort",
		"AuctionsDurationSort",
		"AuctionsHighBidderSort",
		"AuctionsBidSort"
	}

	for _, sorttab in pairs(sorttabs) do
		_G[sorttab.."Left"]:Kill()
		_G[sorttab.."Middle"]:Kill()
		_G[sorttab.."Right"]:Kill()
	end

	for i = 1, AuctionFrame.numTabs do
		T.SkinTab(_G["AuctionFrameTab"..i])
	end

	for i = 1, NUM_FILTERS_TO_DISPLAY do
		local tab = _G["AuctionFilterButton"..i]
		tab:StyleButton()
		_G["AuctionFilterButton"..i.."NormalTexture"]:SetAlpha(0)
		_G["AuctionFilterButton"..i.."NormalTexture"].SetAlpha = T.dummy
	end

	local editboxs = {
		"BrowseName",
		"BrowseMinLevel",
		"BrowseMaxLevel",
		"BrowseBidPriceGold",
		"BrowseBidPriceSilver",
		"BrowseBidPriceCopper",
		"BidBidPriceGold",
		"BidBidPriceSilver",
		"BidBidPriceCopper",
		"AuctionsStackSizeEntry",
		"AuctionsNumStacksEntry",
		"StartPriceGold",
		"StartPriceSilver",
		"StartPriceCopper",
		"BuyoutPriceGold",
		"BuyoutPriceSilver",
		"BuyoutPriceCopper"
	}

	for _, editbox in pairs(editboxs) do
		T.SkinEditBox(_G[editbox])
		_G[editbox]:SetTextInsets(1, 1, -1, 1)
	end
	_G["BrowseName"]:SetTextInsets(15, 15, -1, 1)
	BrowseMaxLevel:SetPoint("LEFT", BrowseMinLevel, "RIGHT", 8, 0)
	AuctionsStackSizeEntry.backdrop:SetAllPoints()
	AuctionsNumStacksEntry.backdrop:SetAllPoints()

	for i = 1, NUM_BROWSE_TO_DISPLAY do
		local button = _G["BrowseButton"..i]
		local icon = _G["BrowseButton"..i.."Item"]

		if _G["BrowseButton"..i.."ItemIconTexture"] then
			_G["BrowseButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["BrowseButton"..i.."ItemIconTexture"]:ClearAllPoints()
			_G["BrowseButton"..i.."ItemIconTexture"]:SetPoint("TOPLEFT", 2, -2)
			_G["BrowseButton"..i.."ItemIconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)
		end

		if icon then
			icon:StripTextures()
			icon:StyleButton()
			icon:CreateBackdrop("Default")
			icon.backdrop:SetAllPoints()
			icon.IconBorder:Kill()
		end

		if button then
			button:StripTextures()
			button:StyleButton()
			_G["BrowseButton"..i.."Highlight"] = button:GetHighlightTexture()
			button:GetHighlightTexture():ClearAllPoints()
			button:GetHighlightTexture():SetPoint("TOPLEFT", icon, "TOPRIGHT", 2, 0)
			button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
			button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
		end
	end

	for i = 1, NUM_AUCTIONS_TO_DISPLAY do
		local button = _G["AuctionsButton"..i]
		local icon = _G["AuctionsButton"..i.."Item"]

		_G["AuctionsButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["AuctionsButton"..i.."ItemIconTexture"]:ClearAllPoints()
		_G["AuctionsButton"..i.."ItemIconTexture"]:SetPoint("TOPLEFT", 2, -2)
		_G["AuctionsButton"..i.."ItemIconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)

		icon:StripTextures()
		icon:StyleButton()
		icon:CreateBackdrop("Default")
		icon.backdrop:SetAllPoints()
		icon.IconBorder:Kill()

		button:StripTextures()
		button:StyleButton()
		_G["AuctionsButton"..i.."Highlight"] = button:GetHighlightTexture()
		button:GetHighlightTexture():ClearAllPoints()
		button:GetHighlightTexture():SetPoint("TOPLEFT", icon, "TOPRIGHT", 2, 0)
		button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
		button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
	end

	for i = 1, NUM_BIDS_TO_DISPLAY do
		local button = _G["BidButton"..i]
		local icon = _G["BidButton"..i.."Item"]

		_G["BidButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["BidButton"..i.."ItemIconTexture"]:ClearAllPoints()
		_G["BidButton"..i.."ItemIconTexture"]:SetPoint("TOPLEFT", 2, -2)
		_G["BidButton"..i.."ItemIconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)

		icon:StripTextures()
		icon:StyleButton()
		icon:CreateBackdrop("Default")
		icon.backdrop:SetAllPoints()
		icon.IconBorder:Kill()

		button:StripTextures()
		button:StyleButton()
		_G["BidButton"..i.."Highlight"] = button:GetHighlightTexture()
		button:GetHighlightTexture():ClearAllPoints()
		button:GetHighlightTexture():SetPoint("TOPLEFT", icon, "TOPRIGHT", 2, 0)
		button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
		button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
	end

	-- Custom Backdrops
	AuctionFrameBrowse.bg1 = CreateFrame("Frame", nil, AuctionFrameBrowse)
	AuctionFrameBrowse.bg1:SetTemplate("Overlay")
	AuctionFrameBrowse.bg1:SetPoint("TOPLEFT", 20, -103)
	AuctionFrameBrowse.bg1:SetPoint("BOTTOMRIGHT", -575, 40)
	BrowseFilterScrollFrame:SetHeight(300)

	AuctionFrameBrowse.bg2 = CreateFrame("Frame", nil, AuctionFrameBrowse)
	AuctionFrameBrowse.bg2:SetTemplate("Overlay")
	AuctionFrameBrowse.bg2:SetPoint("TOPLEFT", AuctionFrameBrowse.bg1, "TOPRIGHT", 4, 0)
	AuctionFrameBrowse.bg2:SetPoint("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT", -8, 40)
	AuctionFrameBrowse.bg2:SetFrameLevel(AuctionFrameBrowse.bg2:GetFrameLevel() - 2)
	BrowseScrollFrame:SetHeight(300)

	AuctionFrameBid.bg = CreateFrame("Frame", nil, AuctionFrameBid)
	AuctionFrameBid.bg:SetTemplate("Overlay")
	AuctionFrameBid.bg:SetPoint("TOPLEFT", 22, -72)
	AuctionFrameBid.bg:SetPoint("BOTTOMRIGHT", 66, 40)
	AuctionFrameBid.bg:SetFrameLevel(AuctionFrameBid.bg:GetFrameLevel() - 2)
	BidScrollFrame:SetHeight(332)

	AuctionsScrollFrame:SetHeight(336)
	AuctionFrameAuctions.bg1 = CreateFrame("Frame", nil, AuctionFrameAuctions)
	AuctionFrameAuctions.bg1:SetTemplate("Overlay")
	AuctionFrameAuctions.bg1:SetPoint("TOPLEFT", 15, -70)
	AuctionFrameAuctions.bg1:SetPoint("BOTTOMRIGHT", -545, 35)
	AuctionFrameAuctions.bg1:SetFrameLevel(AuctionFrameAuctions.bg1:GetFrameLevel() - 2)

	AuctionFrameAuctions.bg2 = CreateFrame("Frame", nil, AuctionFrameAuctions)
	AuctionFrameAuctions.bg2:SetTemplate("Overlay")
	AuctionFrameAuctions.bg2:SetPoint("TOPLEFT", AuctionFrameAuctions.bg1, "TOPRIGHT", 3, 0)
	AuctionFrameAuctions.bg2:SetPoint("BOTTOMRIGHT", AuctionFrame, -8, 35)
	AuctionFrameAuctions.bg2:SetFrameLevel(AuctionFrameAuctions.bg2:GetFrameLevel() - 2)

	-- Auctionator
	if not IsAddOnLoaded("Auctionator") then return end

	local buttons = {
		"Atr_Search_Button",
		"Atr_Back_Button",
		"Atr_Buy1_Button",
		"Atr_FullScanButton",
		"Auctionator1Button",
		"Atr_ListTabsTab1",
		"Atr_ListTabsTab2",
		"Atr_ListTabsTab3",
		"Atr_CreateAuctionButton",
		"Atr_RemFromSListButton",
		"Atr_AddToSListButton",
		"Atr_SrchSListButton",
		"Atr_DelSListButton",
		"Atr_NewSListButton",
		"Atr_CheckActiveButton",
		"AuctionatorCloseButton",
		"Atr_CancelSelectionButton",
		"Atr_FullScanStartButton",
		"Atr_FullScanDone",
		"Atr_CheckActives_Yes_Button",
		"Atr_CheckActives_No_Button",
		"Atr_Adv_Search_ResetBut",
		"Atr_Adv_Search_OKBut",
		"Atr_Adv_Search_CancelBut",
		"Atr_Buy_Confirm_OKBut",
		"Atr_Buy_Confirm_CancelBut",
		"Atr_MngSListsButton",
		"Auctionator_Search",
		"Atr_SaveThisList_Button",
	}

	for i = 1, getn(buttons) do
		local frame = _G[buttons[i]]
		if frame then
			_G[buttons[i]]:SkinButton(true)
		end
	end

	local dropdown = {
		"Atr_DropDown1",
		"Atr_Duration",
		"Atr_DropDownSL",
		"Atr_ASDD_Class",
		"Atr_ASDD_Subclass"
	}

	for i = 1, getn(dropdown) do
		local frame = _G[dropdown[i]]
		if frame then
			T.SkinDropDownBox(_G[dropdown[i]])
		end
	end

	local editbox = {
		"Atr_StackPriceGold",
		"Atr_StackPriceSilver",
		"Atr_StackPriceCopper",
		"Atr_ItemPriceGold",
		"Atr_ItemPriceSilver",
		"Atr_ItemPriceCopper",
		"Atr_Batch_NumAuctions",
		"Atr_Batch_Stacksize",
		"Atr_Search_Box",
		"Atr_AS_Searchtext",
		"Atr_AS_Minlevel",
		"Atr_AS_Maxlevel",
		"Atr_AS_MinItemlevel",
		"Atr_AS_MaxItemlevel",
		"Atr_StartingPriceGold",
		"Atr_StartingPriceSilver",
		"Atr_StartingPriceCopper"
	}

	for i = 1, getn(editbox) do
		local frame = _G[editbox[i]]
		if frame then
			T.SkinEditBox(_G[editbox[i]])
		end
	end

	local frames = {
		"Atr_FullScanResults",
		"Atr_Adv_Search_Dialog",
		"Atr_FullScanFrame",
		"Atr_HeadingsBar",
		"Atr_Error_Frame",
		"Atr_Hlist",
		"Atr_Buy_Confirm_Frame",
		"Atr_CheckActives_Frame",
		"Atr_Hilite1",
		"Atr_BasicOptionsFrame",
		"Atr_TooltipsOptionsFrame",
		"Atr_UCConfigFrame",
		"Atr_StackingOptionsFrame",
		"Atr_ShpList_Options_Frame",
		"AuctionatorResetsFrame",
		"Atr_ScanningOptionsFrame",
		"AuctionatorDescriptionFrame"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			_G[frames[i]]:StripTextures()
		end
	end

	T.SkinCheckBox(Atr_Exact_Search_Button)
	T.SkinCheckBox(Atr_Adv_Search_Button)

	Atr_Mask:ClearAllPoints()
	Atr_Mask:SetPoint("TOPLEFT", AuctionFrame, "TOPLEFT", 0, 0)
	Atr_Mask:SetPoint("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT", 0, 0)

	Atr_Adv_Search_Dialog:SetTemplate("Transparent")
	Atr_FullScanFrame:SetTemplate("Overlay")

	Atr_FullScanResults:CreateBorder(true, true)
	local border = CreateFrame("Frame", "Atr_FullScanResultsBorder", Atr_FullScanResults)
	border:SetPoint("TOPLEFT")
	border:SetPoint("BOTTOMRIGHT")
	border:SetBackdrop({
		edgeFile = C.media.blank, edgeSize = T.mult,
		insets = {left = T.mult, right = T.mult, top = T.mult, bottom = T.mult}
	})
	border:SetBackdropBorderColor(unpack(C.media.border_color))

	Atr_Buy_Confirm_Frame:SetTemplate("Default")
	Atr_CheckActives_Frame:SetTemplate("Transparent")
	Atr_Error_Frame:SetTemplate("Transparent")

	Atr_HeadingsBar:CreateBackdrop("Overlay")
	Atr_HeadingsBar.backdrop:SetPoint("TOPLEFT", 0, -25)
	Atr_HeadingsBar.backdrop:SetPoint("BOTTOMRIGHT", 3, -183)

	Atr_SellControls:CreateBackdrop("Overlay")
	Atr_SellControls.backdrop:SetPoint("TOPLEFT", -2, 0)
	Atr_SellControls.backdrop:SetPoint("BOTTOMRIGHT", 25, 0)

	Atr_DropDownSL:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -190, -41)

	Atr_Hlist:CreateBackdrop("Overlay")
	Atr_Hlist.backdrop:SetPoint("TOPLEFT", -2, 0)
	Atr_Hlist.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)
	Atr_Hlist:SetWidth(195)

	Atr_Hlist_ScrollFrameScrollBar:ClearAllPoints()
	Atr_Hlist_ScrollFrameScrollBar:SetPoint("TOPRIGHT", Atr_Hlist, "TOPRIGHT", -5, -20)
	Atr_Hlist_ScrollFrameScrollBar:SetPoint("BOTTOMRIGHT", Atr_Hlist, "BOTTOMRIGHT", -5, 22)
	T.SkinScrollBar(Atr_Hlist_ScrollFrameScrollBar)

	T.SkinScrollBar(AuctionatorScrollFrameScrollBar)

	hooksecurefunc("AuctionFrameTab_OnClick", function(self)
		local index = self:GetID()
		if index == 4 then
			Atr_Hlist:SetPoint("TOPLEFT", -193, -67)
		else
			Atr_Hlist:SetHeight(337)
			Atr_Hlist_ScrollFrame:SetHeight(337)
			Atr_Hlist:SetPoint("TOPLEFT", -193, -75)
		end
	end)

	Atr_AddToSListButton:SetWidth(97)
	Atr_RemFromSListButton:SetWidth(97)
	Atr_SrchSListButton:SetWidth(197)
	Atr_MngSListsButton:SetWidth(197)
	Atr_NewSListButton:SetWidth(197)

	Atr_AddToSListButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -195, -321)
	Atr_RemFromSListButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -95, -321)
	Atr_SrchSListButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -195, -344)
	Atr_MngSListsButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -195, -367)
	Atr_NewSListButton:SetPoint("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -195, -390)

	Atr_Hilite1:CreateBackdrop("Overlay")
	Atr_Hilite1.backdrop:SetPoint("TOPLEFT", 1, -3)
	Atr_Hilite1.backdrop:SetPoint("BOTTOMRIGHT", 3, -1)

	Atr_Search_Box:SetHeight(Atr_Search_Box:GetHeight() - 2)
	Auctionator1Button:SetSize(66, 18)
	Auctionator1Button:ClearAllPoints()
	Auctionator1Button:SetPoint("TOPRIGHT", Atr_Main_Panel, "TOPRIGHT", -35, -4)
	Atr_Search_Button:SetHeight(22)
	Atr_Back_Button:SetHeight(22)
	Atr_FullScanButton:SetSize(100, 25)
	Atr_FullScanButton:ClearAllPoints()
	Atr_FullScanButton:SetPoint("TOPRIGHT", Auctionator1Button, "BOTTOMRIGHT", 0, -20)

	Atr_CreateAuctionButton:SetWidth(165)
	Atr_CreateAuctionButton:ClearAllPoints()
	Atr_CreateAuctionButton:SetPoint("CENTER", 14, -20)

	AuctionatorCloseButton:ClearAllPoints()
	AuctionatorCloseButton:SetPoint("BOTTOMRIGHT", Atr_Main_Panel, "BOTTOMRIGHT", -8, 10)
	Atr_Buy1_Button:SetPoint("RIGHT", AuctionatorCloseButton, "LEFT", -4, 0)
	Atr_CancelSelectionButton:SetPoint("RIGHT", Atr_Buy1_Button, "LEFT", -4, 0)

	Atr_RecommendItem_Tex:SetTemplate("Default")
	Atr_RecommendItem_Tex:StyleButton()
	Atr_RecommendItem_Tex:SetScript("OnUpdate", function()
		if Atr_RecommendItem_Tex:GetNormalTexture() then
			Atr_RecommendItem_Tex:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			Atr_RecommendItem_Tex:GetNormalTexture():ClearAllPoints()
			Atr_RecommendItem_Tex:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			Atr_RecommendItem_Tex:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end)

	Atr_SellControls_Tex:SetTemplate("Default")
	Atr_SellControls_Tex:StyleButton()

	Atr_SellControls_Tex:SetScript("OnUpdate", function()
		if Atr_SellControls_Tex:GetNormalTexture() then
			Atr_SellControls_Tex:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			Atr_SellControls_Tex:GetNormalTexture():ClearAllPoints()
			Atr_SellControls_Tex:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			Atr_SellControls_Tex:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end)
end

T.SkinFuncs["Blizzard_AuctionUI"] = LoadSkin
