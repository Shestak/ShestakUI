local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Character skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinCloseButton(CharacterFrameCloseButton)

	-- Azerite Items
	local function UpdateAzeriteItem(self)
		if not self.styled then
			self.AzeriteTexture:SetAlpha(0)
			self.RankFrame.Texture:SetTexture("")
			self.RankFrame.Label:SetFontObject("SystemFont_Outline_Small")
			self.RankFrame.Label:SetPoint("CENTER", self.RankFrame.Texture, 0, 3)

			self.styled = true
		end
		self:GetHighlightTexture():SetColorTexture(1, 1, 1, 0.3)
		self:GetHighlightTexture():SetAllPoints()
	end

	local function UpdateAzeriteEmpoweredItem(self)
		self.AzeriteTexture:SetAtlas("AzeriteIconFrame")
		self.AzeriteTexture:SetPoint("TOPLEFT", 2, -2)
		self.AzeriteTexture:SetPoint("BOTTOMRIGHT", -2, 2)
		self.AzeriteTexture:SetDrawLayer("BORDER", 1)
	end

	local slots = {
		"HeadSlot",
		"NeckSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"Finger0Slot",
		"Finger1Slot",
		"Trinket0Slot",
		"Trinket1Slot",
		"MainHandSlot",
		"SecondaryHandSlot"
	}

	select(14, _G["CharacterMainHandSlot"]:GetRegions()):Hide()
	select(14, _G["CharacterSecondaryHandSlot"]:GetRegions()):Hide()

	for _, i in pairs(slots) do
		_G["Character"..i.."Frame"]:Hide()
		local icon = _G["Character"..i.."IconTexture"]
		local slot = _G["Character"..i]
		local border = _G["Character"..i].IconBorder

		border:Kill()
		slot:StyleButton()
		slot:SetNormalTexture("")
		slot.SetHighlightTexture = T.dummy
		slot:GetHighlightTexture().SetAllPoints = T.dummy
		slot:SetFrameLevel(slot:GetFrameLevel() + 2)
		slot:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)

		hooksecurefunc(slot, "DisplayAsAzeriteItem", UpdateAzeriteItem)
		hooksecurefunc(slot, "DisplayAsAzeriteEmpoweredItem", UpdateAzeriteEmpoweredItem)
	end

	-- Strip Textures
	local charframe = {
		"CharacterFrame",
		"CharacterModelFrame",
		"CharacterFrameInset",
		"CharacterStatsPane",
		"CharacterFrameInsetRight",
		"PaperDollSidebarTabs",
		"PaperDollEquipmentManagerPane"
	}

	for _, object in pairs(charframe) do
		_G[object]:StripTextures()
	end

	EquipmentFlyoutFrameHighlight:Kill()
	local function SkinItemFlyouts()
		EquipmentFlyoutFrameButtons:StripTextures()

		for i = 1, 23 do
			local button = _G["EquipmentFlyoutFrameButton"..i]
			local icon = _G["EquipmentFlyoutFrameButton"..i.."IconTexture"]
			if button then
				button:StyleButton()
				button.IconBorder:Hide()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetNormalTexture():SetTexture(nil)

				icon:ClearAllPoints()
				icon:SetPoint("TOPLEFT", 2, -2)
				icon:SetPoint("BOTTOMRIGHT", -2, 2)
				button:SetFrameStrata("DIALOG")
				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:SetAllPoints()
				end
			end
		end
	end

	-- Swap item flyout frame (shown when holding alt over a slot)
	EquipmentFlyoutFrame:HookScript("OnShow", SkinItemFlyouts)
	hooksecurefunc("EquipmentFlyout_Show", SkinItemFlyouts)

	-- Icon in upper right corner of character frame
	CharacterFramePortrait:Kill()
	CharacterModelFrameBackgroundOverlay:SetColorTexture(0, 0, 0)
	CharacterModelFrame:CreateBackdrop("Default")
	CharacterModelFrame.backdrop:SetPoint("TOPLEFT", -3, 4)
	CharacterModelFrame.backdrop:SetPoint("BOTTOMRIGHT", 4, 0)

	local scrollbars = {
		"PaperDollTitlesPaneScrollBar",
		"PaperDollEquipmentManagerPaneScrollBar",
		"TokenFrameContainerScrollBar",
		"ReputationListScrollFrameScrollBar",
		"GearManagerDialogPopupScrollFrameScrollBar"
	}

	for _, scrollbar in pairs(scrollbars) do
		T.SkinScrollBar(_G[scrollbar])
	end

	local function SkinStatsPane(frame)
		frame:StripTextures()

		local bg = frame.Background
		bg:SetTexture(C.media.blank)
		bg:ClearAllPoints()
		bg:SetPoint("CENTER", 0, -15)
		bg:SetSize(165, 1)
		bg:SetVertexColor(unpack(C.media.border_color))

		local border = CreateFrame("Frame", "$parentOuterBorder", frame)
		border:SetPoint("TOPLEFT", bg, "TOPLEFT", -T.mult, T.mult)
		border:SetPoint("BOTTOMRIGHT", bg, "BOTTOMRIGHT", T.mult, -T.mult)
		border:SetFrameLevel(frame:GetFrameLevel() + 1)
		border:SetBackdrop({
			edgeFile = C.media.blank, edgeSize = T.mult,
			insets = {left = T.mult, right = T.mult, top = T.mult, bottom = T.mult}
		})
		border:SetBackdropBorderColor(unpack(C.media.backdrop_color))
	end

	CharacterStatsPane.ItemLevelFrame.Value:SetFont(C.media.normal_font, 18)
	CharacterStatsPane.ItemLevelFrame.Value:SetShadowOffset(1, -1)
	CharacterStatsPane.ItemLevelFrame.Background:Hide()

	SkinStatsPane(CharacterStatsPane.ItemLevelCategory)
	SkinStatsPane(CharacterStatsPane.AttributesCategory)
	SkinStatsPane(CharacterStatsPane.EnhancementsCategory)

	-- Titles
	PaperDollTitlesPane:HookScript("OnShow", function(self)
		for _, object in pairs(PaperDollTitlesPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)
			object.Check:SetTexture(nil)
		end
	end)

	-- Equipement Manager
	PaperDollEquipmentManagerPaneEquipSet:SkinButton()
	PaperDollEquipmentManagerPaneSaveSet:SkinButton()
	PaperDollEquipmentManagerPaneEquipSet:SetWidth(PaperDollEquipmentManagerPaneEquipSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneSaveSet:SetWidth(PaperDollEquipmentManagerPaneSaveSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneEquipSet:SetPoint("TOPLEFT", PaperDollEquipmentManagerPane, "TOPLEFT", 8, 0)
	PaperDollEquipmentManagerPaneSaveSet:SetPoint("LEFT", PaperDollEquipmentManagerPaneEquipSet, "RIGHT", 4, 0)
	PaperDollEquipmentManagerPane:HookScript("OnShow", function(self)
		for _, object in pairs(PaperDollEquipmentManagerPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)

			object.Check:SetTexture(nil)
			object.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			if not object.backdrop then
				object:CreateBackdrop("Default")
			end

			object.backdrop:SetPoint("TOPLEFT", object.icon, "TOPLEFT", -2, 2)
			object.backdrop:SetPoint("BOTTOMRIGHT", object.icon, "BOTTOMRIGHT", 2, -2)
			object.icon:SetParent(object.backdrop)

			-- Making all icons the same size and position because otherwise BlizzardUI tries to attach itself to itself when it refreshes
			object.icon:SetPoint("LEFT", object, "LEFT", 4, 0)
			object.icon.SetPoint = T.dummy
			object.icon:SetSize(36, 36)
			object.icon.SetSize = T.dummy
		end
	end)

	T.SkinIconSelectionFrame(GearManagerDialogPopup, NUM_GEARSET_ICONS_SHOWN, "GearManagerDialogPopupButton", frameNameOverride)

	-- Handle Tabs at bottom of character frame
	for i = 1, 4 do
		T.SkinTab(_G["CharacterFrameTab"..i])
	end

	-- Buttons used to toggle between equipment manager, titles, and character stats
	local function FixSidebarTabCoords()
		for i = 1, #PAPERDOLL_SIDEBARS do
			local tab = _G["PaperDollSidebarTab"..i]
			if tab then
				tab.Highlight:SetColorTexture(1, 1, 1, 0.3)
				tab.Highlight:SetPoint("TOPLEFT", 3, -4)
				tab.Highlight:SetPoint("BOTTOMRIGHT", -1, 0)
				tab.Hider:SetColorTexture(0.4, 0.4, 0.4, 0.4)
				tab.Hider:SetPoint("TOPLEFT", 3, -4)
				tab.Hider:SetPoint("BOTTOMRIGHT", -1, 0)
				tab.TabBg:Kill()

				if i == 1 then
					for i = 1, tab:GetNumRegions() do
						local region = select(i, tab:GetRegions())
						region:SetTexCoord(0.16, 0.86, 0.16, 0.86)
						region.SetTexCoord = T.dummy
					end
				end
				tab:CreateBackdrop("Default")
				tab.backdrop:SetPoint("TOPLEFT", 1, -2)
				tab.backdrop:SetPoint("BOTTOMRIGHT", 1, -2)
			end
		end
	end
	hooksecurefunc("PaperDollFrame_UpdateSidebarTabs", FixSidebarTabCoords)

	-- Reputation
	local function UpdateFactionSkins()
		ReputationListScrollFrame:StripTextures()
		ReputationFrame:StripTextures(true)
		local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)
		for i = 1, GetNumFactions() do
			local statusbar = _G["ReputationBar"..i.."ReputationBar"]
			local button = _G["ReputationBar"..i.."ExpandOrCollapseButton"]
			local factionIndex = factionOffset + i
			local _, _, _, _, _, _, _, _, _, isCollapsed = GetFactionInfo(factionIndex)

			if statusbar then
				statusbar:SetStatusBarTexture(C.media.texture)

				if not statusbar.backdrop then
					statusbar:CreateBackdrop("Overlay")
				end

				_G["ReputationBar"..i.."Background"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarHighlight1"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarHighlight2"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarAtWarHighlight1"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarAtWarHighlight2"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarLeftTexture"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarRightTexture"]:SetTexture(nil)
			end

			if button then
				if not button.isSkinned then
					T.SkinExpandOrCollapse(button)
					if isCollapsed then
						button.bg.plus:Show()
					else
						button.bg.plus:Hide()
					end
					button.isSkinned = true
				end
			end
		end
		ReputationDetailFrame:StripTextures()
		ReputationDetailFrame:SetTemplate("Transparent")
		ReputationDetailFrame:SetPoint("TOPLEFT", ReputationFrame, "TOPRIGHT", 3, 0)
		T.SkinCloseButton(ReputationDetailCloseButton)
		T.SkinCheckBox(ReputationDetailMainScreenCheckBox)
		T.SkinCheckBox(ReputationDetailInactiveCheckBox)
		T.SkinCheckBox(ReputationDetailAtWarCheckBox)
		T.SkinCheckBox(ReputationDetailLFGBonusReputationCheckBox)
	end
	ReputationFrame:HookScript("OnShow", UpdateFactionSkins)
	hooksecurefunc("ExpandFactionHeader", UpdateFactionSkins)
	hooksecurefunc("CollapseFactionHeader", UpdateFactionSkins)

	-- Currency
	TokenFrame:HookScript("OnShow", function()
		local buttons = TokenFrameContainer.buttons
		local numButtons = #buttons

		for i = 1, numButtons do
			local button = buttons[i]
			if button then
				button.highlight:Kill()
				button.categoryMiddle:Kill()
				button.categoryLeft:Kill()
				button.categoryRight:Kill()

				if button.icon then
					button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				end
			end
		end
		TokenFramePopup:StripTextures()
		TokenFramePopup:SetTemplate("Transparent")
		TokenFramePopup:SetPoint("TOPLEFT", TokenFrame, "TOPRIGHT", 3, 0)
		T.SkinCloseButton(TokenFramePopupCloseButton)
		T.SkinCheckBox(TokenFramePopupBackpackCheckBox)
		T.SkinCheckBox(TokenFramePopupInactiveCheckBox)
	end)

	CharacterFrame:SetTemplate("Transparent")

	-- Help box
	T.SkinHelpBox(CharacterFrame.ReputationTabHelpBox)
	T.SkinHelpBox(PaperDollItemsFrame.UnspentAzeriteHelpBox)
	PaperDollItemsFrame.UnspentAzeriteHelpBox.CloseButton:SetPoint("TOPRIGHT", PaperDollItemsFrame.UnspentAzeriteHelpBox, "TOPRIGHT", -3, -3)
	PaperDollItemsFrame.UnspentAzeriteHelpBox.CloseButton.SetPoint = T.dummy

	-- Unit Background Texture
	CharacterModelFrameBackgroundTopLeft:SetPoint("TOPLEFT", CharacterModelFrame.backdrop, "TOPLEFT", 2, -2)
	CharacterModelFrameBackgroundTopRight:SetPoint("TOPRIGHT", CharacterModelFrame.backdrop, "TOPRIGHT", -2, -2)
	CharacterModelFrameBackgroundBotLeft:SetPoint("BOTTOMLEFT", CharacterModelFrame.backdrop, "BOTTOMLEFT", 2, -50)
	CharacterModelFrameBackgroundBotRight:SetPoint("BOTTOMRIGHT", CharacterModelFrame.backdrop, "BOTTOMRIGHT", -2, -50)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
