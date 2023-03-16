local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ProfessionsOrders skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = ProfessionsCustomerOrdersFrame
	T.SkinFrame(frame)

	frame.MoneyFrameBorder:StripTextures()
	frame.MoneyFrameInset:StripTextures()

	local buttons = {
		frame.BrowseOrders.SearchBar.SearchButton,
		frame.BrowseOrders.SearchBar.FilterButton,
		frame.BrowseOrders.SearchBar.FavoritesSearchButton,
		frame.Form.BackButton,
		frame.Form.PaymentContainer.ListOrderButton,
		frame.Form.CurrentListings.CloseButton,
		frame.Form.PaymentContainer.CancelOrderButton
	}

	for i = 1, #buttons do
		buttons[i]:SkinButton()
	end

	local scrollbars = {
		frame.BrowseOrders.RecipeList.ScrollBar,
		frame.BrowseOrders.CategoryList.ScrollBar,
		frame.MyOrdersPage.OrderList.ScrollBar,
		frame.Form.CurrentListings.OrderList.ScrollBar
	}

	for i = 1, #scrollbars do
		T.SkinScrollBar(scrollbars[i], true)
	end

	local tabs = {
		ProfessionsCustomerOrdersFrameBrowseTab,
		ProfessionsCustomerOrdersFrameOrdersTab,
	}

	for _, tab in pairs(tabs) do
		if tab then
			T.SkinTab(tab)
		end
	end

	ProfessionsCustomerOrdersFrameBrowseTab:ClearAllPoints()
	ProfessionsCustomerOrdersFrameBrowseTab:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, -32)

	local orders = frame.BrowseOrders
	orders.SearchBar.FavoritesSearchButton:SetSize(22, 22)
	T.SkinEditBox(orders.SearchBar.SearchBox, nil, 18)
	T.SkinCloseButton(orders.SearchBar.FilterButton.ClearFiltersButton)
	orders.SearchBar.FilterButton.ClearFiltersButton:SetPoint("TOPRIGHT", 3, 6)

	orders.CategoryList:StripTextures()

	orders.CategoryList.ScrollBar:SetPoint("TOPLEFT", orders.CategoryList.ScrollBox, "TOPRIGHT", 6, -1)
	orders.CategoryList.ScrollBar:SetPoint("BOTTOMLEFT", orders.CategoryList.ScrollBox, "BOTTOMRIGHT", 7, 2)

	local function skinCategoryButton(button)
		button:CreateBackdrop("Overlay")
		button.backdrop:SetPoint("TOPLEFT", button.SelectedTexture, "TOPLEFT", 1, -1)
		button.backdrop:SetPoint("BOTTOMRIGHT", button.SelectedTexture, "BOTTOMRIGHT", -1, 1)

		button.NormalTexture:SetAlpha(0)
		button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.2)
		button.HighlightTexture:SetColorTexture(1, 1, 1, 0.2)
	end

	hooksecurefunc(orders.CategoryList.ScrollBox, "Update", function(self)
		for i = 1, self.ScrollTarget:GetNumChildren() do
			local child = select(i, self.ScrollTarget:GetChildren())
			if child.Text and not child.styled then
				if not child.SpacerLine:IsShown() then
					skinCategoryButton(child)
					hooksecurefunc(child, "Init", skinCategoryButton)
				end

				child.styled = true
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

	frame.BrowseOrders.RecipeList:StripTextures()

	hooksecurefunc(frame.BrowseOrders, "SetupTable", function()
		SkinHeaders(frame.BrowseOrders.RecipeList)
	end)
	hooksecurefunc(frame.BrowseOrders, "StartSearch", SkinListIcon)

	local form = frame.Form
	form.RecipeHeader:Hide()
	form.RecipeHeader:CreateBackdrop("Overlay")
	form.RecipeHeader:GetParent().backdrop:SetAllPoints(form.RecipeHeader)
	form.LeftPanelBackground:StripTextures()
	form.RightPanelBackground:StripTextures()

	T.SkinCheckBox(form.TrackRecipeCheckBox.Checkbox, 20)
	if form.AllocateBestQualityCheckBox then
		T.SkinCheckBox(form.AllocateBestQualityCheckBox)
	end
	T.SkinDropDownBox(form.OrderRecipientDropDown)

	form.OrderRecipientDropDown:SetPoint("TOPRIGHT", form, "TOPRIGHT", -3, -10)

	T.SkinEditBox(form.OrderRecipientTarget)
	form.OrderRecipientTarget.backdrop:SetPoint("TOPLEFT", -3, -2)
	form.OrderRecipientTarget.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
	T.SkinDropDownBox(form.MinimumQuality.DropDown)

	local OutputIcon = form.OutputIcon
	OutputIcon.Icon:SkinIcon()
	T.SkinIconBorder(OutputIcon.IconBorder, OutputIcon.Icon:GetParent().backdrop)
	OutputIcon:GetHighlightTexture():Hide()
	OutputIcon.CircleMask:Hide()

	local qualityDialog = form.QualityDialog
	qualityDialog:StripTextures()
	qualityDialog:SetTemplate("Transparent")
	T.SkinCloseButton(qualityDialog.ClosePanelButton)
	qualityDialog.AcceptButton:SkinButton()
	qualityDialog.CancelButton:SkinButton()

	local function ReskinQualityContainer(container)
		local button = container.Button
		button:StripTextures()
		button:SetNormalTexture(0)
		button:SetPushedTexture(0)
		button:GetHighlightTexture():Hide()
		button.Icon:SkinIcon()
		T.SkinIconBorder(button.IconBorder, button.Icon:GetParent().backdrop)

		local box = container.EditBox
		box:DisableDrawLayer("BACKGROUND")
		T.SkinEditBox(box, nil, 18)
		T.SkinNextPrevButton(box.DecrementButton, true)
		T.SkinNextPrevButton(box.IncrementButton)
		box.DecrementButton:SetSize(22, 22)
		box.IncrementButton:SetSize(22, 22)
		box.IncrementButton:SetPoint("LEFT", box, "RIGHT", 6, 0)
	end

	ReskinQualityContainer(qualityDialog.Container1)
	ReskinQualityContainer(qualityDialog.Container2)
	ReskinQualityContainer(qualityDialog.Container3)

	hooksecurefunc(form, "Init", function(self)
		for slot in self.reagentSlotPool:EnumerateActive() do
			local button = slot.Button
			if button and not button.styled then
				button.Icon:SkinIcon()
				button:SetNormalTexture(0)
				button:SetPushedTexture(0)
				button:GetHighlightTexture():Hide()
				T.SkinIconBorder(button.IconBorder, button.Icon:GetParent().backdrop)

				button.HighlightTexture:SetColorTexture(1, 0.8, 0, 0.4)
				button.HighlightTexture:SetAllPoints(button)

				if button.SlotBackground then
					button.SlotBackground:Hide()
				end

				T.SkinCheckBox(slot.Checkbox)
				button.styled = true
			end
		end
	end)

	local payment = form.PaymentContainer
	payment.NoteEditBox:StripTextures()
	payment.NoteEditBox:CreateBackdrop("Overlay")
	payment.NoteEditBox.backdrop:SetPoint("TOPLEFT", 15, 5)
	payment.NoteEditBox.backdrop:SetPoint("BOTTOMRIGHT", -18, 0)

	local function SkinMoneyBox(frame)
		frame:DisableDrawLayer("BACKGROUND")
		frame:CreateBackdrop("Overlay")
		frame.backdrop:SetPoint("TOPLEFT", 6, -2)
		frame.backdrop:SetPoint("BOTTOMRIGHT", -4, 6)
	end

	SkinMoneyBox(payment.TipMoneyInputFrame.GoldBox)
	SkinMoneyBox(payment.TipMoneyInputFrame.SilverBox)

	local viewButton = payment.ViewListingsButton
	viewButton:SetAlpha(0)
	local buttonFrame = CreateFrame("Frame", nil, payment)
	buttonFrame:SetInside(viewButton)
	local tex = buttonFrame:CreateTexture(nil, "ARTWORK")
	tex:SetAllPoints()
	tex:SetTexture("Interface\\CURSOR\\Crosshair\\Repair")

	T.SkinDropDownBox(payment.DurationDropDown)

	local currentListings = frame.Form.CurrentListings
	currentListings:StripTextures()
	currentListings:SetTemplate("Transparent")
	SkinHeaders(currentListings.OrderList)
	currentListings.OrderList:StripTextures()
	currentListings:ClearAllPoints()
	currentListings:SetPoint("LEFT", frame, "RIGHT", 5, 0)

	local myOrders = frame.MyOrdersPage
	myOrders.OrderList:StripTextures()
	myOrders.RefreshButton:SkinButton()
	myOrders.RefreshButton:SetSize(24, 24)
	SkinHeaders(myOrders.OrderList)
end

T.SkinFuncs["Blizzard_ProfessionsCustomerOrders"] = LoadSkin