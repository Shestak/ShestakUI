local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Collections skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, _, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end
	if addon == "Blizzard_Collections" then
		local tt = PetJournalPrimaryAbilityTooltip
		tt.Background:SetTexture(nil)
		tt.Delimiter1:SetTexture(nil)
		tt.Delimiter2:SetTexture(nil)
		tt.BorderTop:SetTexture(nil)
		tt.BorderTopLeft:SetTexture(nil)
		tt.BorderTopRight:SetTexture(nil)
		tt.BorderLeft:SetTexture(nil)
		tt.BorderRight:SetTexture(nil)
		tt.BorderBottom:SetTexture(nil)
		tt.BorderBottomRight:SetTexture(nil)
		tt.BorderBottomLeft:SetTexture(nil)
		tt:SetTemplate("Transparent")
	end
end)

if C.skins.blizzard_frames ~= true then return end
local function LoadSkin()
	CollectionsJournal:StripTextures()
	CollectionsJournal:SetTemplate("Transparent")
	CollectionsJournalPortrait:SetAlpha(0)

	for i = 1, 5 do
		T.SkinTab(_G["CollectionsJournalTab"..i])
	end

	local buttons = {
		"MountJournalMountButton",
		"PetJournalSummonButton",
		"PetJournalFindBattle",
		"PetJournalFilterButton",
		"MountJournalFilterButton",
		"HeirloomsJournalFilterButton",
		"ToyBoxFilterButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end


	for i = 1, 3 do
		T.SkinTab(_G["PetJournalParentTab"..i])
	end

	T.SkinCloseButton(CollectionsJournalCloseButton)

	local function StyleItemButton(frame)
		frame:CreateBackdrop("Default")
		frame.backdrop:SetAllPoints()
		frame:StyleButton()
		_G[frame:GetName().."Border"]:Hide()
		frame.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.texture:ClearAllPoints()
		frame.texture:SetPoint("TOPLEFT", 2, -2)
		frame.texture:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	-- MountJournal
	MountJournal.LeftInset:StripTextures()
	MountJournal.RightInset:StripTextures()
	MountJournal.MountDisplay:StripTextures()
	MountJournal.MountDisplay.ShadowOverlay:StripTextures()
	MountJournal.MountCount:StripTextures()

	MountJournal.MountDisplay:SetPoint("BOTTOMRIGHT", MountJournal.RightInset, "BOTTOMRIGHT", -3, 6)
	MountJournal.MountDisplay:CreateBackdrop("Overlay")
	MountJournal.MountDisplay.backdrop:SetPoint("TOPLEFT", 2, -2)
	MountJournal.MountDisplay.backdrop:SetPoint("BOTTOMRIGHT", 1, -2)

	T.SkinEditBox(MountJournalSearchBox, nil, 18)
	T.SkinScrollBar(MountJournalListScrollFrameScrollBar)
	T.SkinRotateButton(MountJournal.MountDisplay.ModelScene.RotateLeftButton)
	T.SkinRotateButton(MountJournal.MountDisplay.ModelScene.RotateRightButton)

	MountJournalListScrollFrameScrollBar:SetPoint("TOPLEFT", MountJournalListScrollFrame, "TOPRIGHT", 4, 17)
	MountJournalFilterButton:SetPoint("TOPLEFT", MountJournalSearchBox, "TOPRIGHT", 5, 2)

	-- New Mount Equip. 8.2
	MountJournal.BottomLeftInset:StripTextures()
	MountJournal.BottomLeftInset:CreateBackdrop("Overlay")
	MountJournal.BottomLeftInset.backdrop:SetPoint("TOPLEFT", 0, 2)
	MountJournal.BottomLeftInset:SetPoint("BOTTOMLEFT", 0, 32)
	MountJournal.BottomLeftInset.SlotButton:StripTextures()
	MountJournal.BottomLeftInset.SlotButton.ItemIcon:SkinIcon()

	T.SkinCheckBox(MountJournal.MountDisplay.ModelScene.TogglePlayer, 26)

	for i = 1, #MountJournal.ListScrollFrame.buttons do
		local button = _G["MountJournalListScrollFrameButton"..i]

		if not button.isSkinned then
			button:GetRegions():Hide()
			button.selectedTexture:SetTexture(nil)
			button:CreateBackdrop("Overlay")
			button.backdrop:SetPoint("TOPLEFT", 2, -2)
			button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
			button:StyleButton(nil, 4)

			button.DragButton:CreateBackdrop("Default")
			button.DragButton.backdrop:SetPoint("TOPLEFT", -1, 1)
			button.DragButton.backdrop:SetPoint("BOTTOMRIGHT", 1, -1)
			button.DragButton:StyleButton(nil, 1)
			button.DragButton.ActiveTexture:SetColorTexture(0, 1, 0, 0.3)
			button.DragButton.ActiveTexture:SetPoint("TOPLEFT", 1, -1)
			button.DragButton.ActiveTexture:SetPoint("BOTTOMRIGHT", -1, 1)

			button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.icon:ClearAllPoints()

			if i == 1 then
				button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", -3, 3)
			else
				button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", -3, 4)
			end

			button.isSkinned = true
		end
	end

	local function ColorSelectedMount()
		for i = 1, #MountJournal.ListScrollFrame.buttons do
			local button = _G["MountJournalListScrollFrameButton"..i]

			if button.selectedTexture:IsShown() then
				button.name:SetTextColor(1, 1, 0)
				button.backdrop:SetBackdropBorderColor(1, 1, 0)
				button.DragButton.backdrop:SetBackdropBorderColor(1, 1, 0)
			else
				button.name:SetTextColor(1, 1, 1)
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.DragButton.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end
	hooksecurefunc("MountJournal_UpdateMountList", ColorSelectedMount)

	MountJournalListScrollFrame:HookScript("OnVerticalScroll", ColorSelectedMount)
	MountJournalListScrollFrame:HookScript("OnMouseWheel", ColorSelectedMount)

	StyleItemButton(MountJournalSummonRandomFavoriteButton)

	do
		local button = MountJournal.MountDisplay.InfoButton
		local icon = MountJournal.MountDisplay.InfoButton.Icon
		button:CreateBackdrop("Default")
		button.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	-- PetJournal
	PetJournal.LeftInset:StripTextures()
	PetJournal.RightInset:StripTextures()
	PetJournal.PetCardInset:StripTextures()
	PetJournal.loadoutBorder:StripTextures()
	PetJournalPetCardBG:Hide()

	PetJournalTutorialButton.Ring:Hide()
	PetJournalTutorialButton:SetPoint("TOPLEFT", PetJournal, "TOPLEFT", -5, 10)

	PetJournal.PetCount:StripTextures()
	T.SkinEditBox(PetJournalSearchBox, nil, 18)

	PetJournalFilterButton:SetPoint("TOPLEFT", PetJournalSearchBox, "TOPRIGHT", 5, 2)

	PetJournalLoadoutBorderSlotHeaderText:SetParent(PetJournal)
	PetJournalLoadoutBorderSlotHeaderText:SetPoint("CENTER", PetJournalLoadoutBorderTop, "TOP", 0, 4)

	PetJournalListScrollFrameScrollBar:SetPoint("TOPLEFT", PetJournalListScrollFrame, "TOPRIGHT", 4, 17)
	PetJournalListScrollFrameScrollBar:SetPoint("BOTTOMLEFT", PetJournalListScrollFrame, "BOTTOMRIGHT", 4, 14)
	T.SkinScrollBar(PetJournalListScrollFrameScrollBar)

	for i = 1, #PetJournal.listScroll.buttons do
		local button = _G["PetJournalListScrollFrameButton"..i]
		local name = _G["PetJournalListScrollFrameButton"..i.."Name"]
		local level = _G["PetJournalListScrollFrameButton"..i.."Level"]

		if not button.isSkinned then
			button:GetRegions():Hide()
			button.selectedTexture:SetTexture(nil)
			button:CreateBackdrop("Overlay")
			button.backdrop:SetPoint("TOPLEFT", 2, -2)
			button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
			button:StyleButton(nil, 4)

			button.dragButton:CreateBackdrop("Default")
			button.dragButton.backdrop:SetPoint("TOPLEFT", -1, 1)
			button.dragButton.backdrop:SetPoint("BOTTOMRIGHT", 1, -1)
			button.dragButton:StyleButton(nil, 1)
			button.dragButton.ActiveTexture:SetColorTexture(0, 1, 0, 0.3)
			button.dragButton.ActiveTexture:SetPoint("TOPLEFT", 1, -1)
			button.dragButton.ActiveTexture:SetPoint("BOTTOMRIGHT", -1, 1)
			button.dragButton.favorite:SetParent(button.dragButton.backdrop)
			button.dragButton.levelBG:SetAlpha(0)

			button.petTypeIcon:SetParent(button.backdrop)
			button.petTypeIcon:SetDrawLayer("OVERLAY")
			button.isDead:SetParent(button.dragButton.backdrop)

			name:SetParent(button.backdrop)

			level:SetParent(button.dragButton.backdrop)
			level:SetFontObject("SystemFont_Outline_Small")
			level:SetDrawLayer("OVERLAY")

			button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.icon:SetDrawLayer("ARTWORK")
			button.icon:SetParent(button.dragButton.backdrop)
			button.icon:ClearAllPoints()
			button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", -3, 4)

			button.isSkinned = true
		end
	end

	local function ColorSelectedPet()
		if PetJournal.listScroll.buttons then
			for i = 1, #PetJournal.listScroll.buttons do
				local button = PetJournal.listScroll.buttons[i]

				if PetJournal.listScroll.buttons[i].index then
					local petID, _, isOwned = C_PetJournal.GetPetInfoByIndex(PetJournal.listScroll.buttons[i].index)

					if petID and isOwned then
						local _, _, _, _, rarity = C_PetJournal.GetPetStats(petID)

						if rarity then
							local color = ITEM_QUALITY_COLORS[rarity-1]
							button.name:SetTextColor(color.r, color.g, color.b)
							button.dragButton.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
						else
							button.name:SetTextColor(1, 1, 1)
							button.dragButton.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
						end
					else
						button.name:SetTextColor(0.5, 0.5, 0.5)
					end

					if button.selectedTexture:IsShown() then
						button.backdrop:SetBackdropBorderColor(1, 1, 0)
						button.dragButton.backdrop:SetBackdropBorderColor(1, 1, 0)
					else
						button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
						button.dragButton.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
					end
				end
			end
		end
	end

	hooksecurefunc("PetJournal_UpdatePetList", ColorSelectedPet)
	hooksecurefunc(PetJournalListScrollFrame, "update", ColorSelectedPet)
	PetJournalAchievementStatus:DisableDrawLayer("BACKGROUND")

	StyleItemButton(PetJournalHealPetButton)
	StyleItemButton(PetJournalSummonRandomFavoritePetButton)

	for i = 1, 3 do
		local button = _G["PetJournalLoadoutPet"..i]

		button:CreateBackdrop("Overlay")
		button.backdrop:SetPoint("TOPLEFT", -2, 0)
		button.backdrop:SetPoint("BOTTOMRIGHT", 5, 0)

		button.dragButton:CreateBackdrop("Default")
		button.dragButton.backdrop:SetPoint("TOPLEFT", 0, 0)
		button.dragButton.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
		button.dragButton:StyleButton()

		button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.icon:SetSize(36, 36)

		button.level:SetParent(button.dragButton.backdrop)
		button.level:SetFontObject("SystemFont_Outline_Small")
		button.level:ClearAllPoints()
		button.level:SetPoint("BOTTOMRIGHT", -2, 3)

		hooksecurefunc(button.qualityBorder, "SetVertexColor", function(_, r, g, b)
			button.name:SetTextColor(r, g, b)
		end)

		for j = 1, 3 do
			local spell = button["spell"..j]

			spell:StyleButton()
			spell:SetTemplate("Default")

			spell.BlackCover:SetPoint("TOPLEFT", 2, -2)
			spell.BlackCover:SetPoint("BOTTOMRIGHT", -2, 2)

			spell.FlyoutArrow:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")

			spell.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			spell.icon:ClearAllPoints()
			spell.icon:SetPoint("TOPLEFT", 2, -2)
			spell.icon:SetPoint("BOTTOMRIGHT", -2, 2)

			_G["PetJournalLoadoutPet"..i.."Spell"..j.."Background"]:SetTexture(nil)
			_G["PetJournalLoadoutPet"..i.."Spell"..j.."Selected"]:SetTexture(nil)
		end

		button.iconBorder:SetAlpha(0)
		button.qualityBorder:SetTexture("")
		button.levelBG:SetAlpha(0)
		button.helpFrame:StripTextures()

		 _G["PetJournalLoadoutPet"..i.."BG"]:Hide()

		button.petTypeIcon:ClearAllPoints()
		button.petTypeIcon:SetPoint("BOTTOMLEFT", button.backdrop, 2, 2)

		button.healthFrame.healthBar:StripTextures()
		button.healthFrame.healthBar:CreateBackdrop("Overlay")
		button.healthFrame.healthBar:SetStatusBarTexture(C.media.texture)

		button.xpBar:StripTextures()
		button.xpBar:CreateBackdrop("Overlay")
		button.xpBar:SetStatusBarTexture(C.media.texture)
		button.xpBar:SetFrameLevel(button.xpBar:GetFrameLevel() + 2)
	end

	PetJournal.SpellSelect.BgEnd:Hide()
	PetJournal.SpellSelect.BgTiled:Hide()

	for i = 1, 2 do
		local button = _G["PetJournalSpellSelectSpell"..i]
		local icon = _G["PetJournalSpellSelectSpell"..i.."Icon"]

		button:StyleButton()
		button:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
		icon:SetDrawLayer("OVERLAY")

		button.BlackCover:SetDrawLayer("OVERLAY", 1)
	end

	for i = 1, 6 do
		local button = _G["PetJournalPetCardSpell"..i]

		button:StyleButton()
		button:SetTemplate("Default")

		button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.icon:ClearAllPoints()
		button.icon:SetPoint("TOPLEFT", 2, -2)
		button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	PetJournalPetCard.AbilitiesBG1:SetAlpha(0)
	PetJournalPetCard.AbilitiesBG2:SetAlpha(0)
	PetJournalPetCard.AbilitiesBG3:SetAlpha(0)

	PetJournalPetCard:CreateBackdrop("Overlay")
	PetJournalPetCard.backdrop:SetPoint("TOPLEFT", 0, -2)
	PetJournalPetCard.backdrop:SetPoint("BOTTOMRIGHT", 1, -2)

	PetJournalPetCardPetInfo:SetPoint("TOPLEFT", PetJournalPetCard.backdrop, 2, -2)
	PetJournalPetCardPetInfo:CreateBackdrop("Default")
	PetJournalPetCardPetInfo.backdrop:SetPoint("TOPLEFT", PetJournalPetCardPetInfoIcon, -2, 2)
	PetJournalPetCardPetInfo.backdrop:SetPoint("BOTTOMRIGHT", PetJournalPetCardPetInfoIcon, 2, -2)

	PetJournalPetCardPetInfoIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	PetJournalPetCardPetInfoLevelBubble:SetTexture(nil)
	PetJournalPetCardPetInfoLevel:SetFontObject("SystemFont_Outline_Small")

	PetJournalPetCardPetInfoQualityBorder:SetTexture(nil)

	PetJournalPetCardHealthFrame.healthBar:StripTextures()
	PetJournalPetCardHealthFrame.healthBar:CreateBackdrop("Overlay")
	PetJournalPetCardHealthFrame.healthBar:SetStatusBarTexture(C.media.texture)

	PetJournalPetCardXPBar:StripTextures()
	PetJournalPetCardXPBar:CreateBackdrop("Overlay")
	PetJournalPetCardXPBar:SetStatusBarTexture(C.media.texture)
	PetJournalPetCardXPBar:SetPoint("BOTTOM", PetJournalPetCard.backdrop, "BOTTOM", 0, 6)
	PetJournalPetCardXPBar:SetFrameLevel(PetJournalPetCardXPBar:GetFrameLevel() + 2)

	hooksecurefunc(PetJournalPetCardPetInfo.qualityBorder, "SetVertexColor", function(_, r, g, b)
		PetJournalPetCardPetInfo.name:SetTextColor(r, g, b)
	end)

	-- ToyBox
	ToyBox.iconsFrame:StripTextures()
	T.SkinEditBox(ToyBox.searchBox, nil, 18)
	T.SkinNextPrevButton(ToyBox.PagingFrame.PrevPageButton)
	T.SkinNextPrevButton(ToyBox.PagingFrame.NextPageButton)
	ToyBoxFilterButton:SetPoint("TOPLEFT", ToyBox.searchBox, "TOPRIGHT", 5, 2)
	ToyBox.progressBar:StripTextures()
	ToyBox.progressBar:CreateBackdrop("Overlay")
	ToyBox.progressBar:SetStatusBarTexture(C.media.texture)
	ToyBox.progressBar:SetFrameLevel(ToyBox.progressBar:GetFrameLevel() + 2)

	for i = 1, 18 do
		ToyBox.iconsFrame["spellButton"..i].slotFrameCollected:SetTexture("")
		ToyBox.iconsFrame["spellButton"..i].slotFrameUncollected:SetTexture("")
		local button = ToyBox.iconsFrame["spellButton"..i]
		local icon = ToyBox.iconsFrame["spellButton"..i].iconTexture
		local uicon = ToyBox.iconsFrame["spellButton"..i].iconTextureUncollected

		button:StyleButton(nil, 0)
		button:CreateBackdrop("Default")
		button.cooldown:SetAllPoints(icon)

		icon:SetPoint("TOPLEFT")
		icon:SetPoint("BOTTOMRIGHT")
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		uicon:SetPoint("TOPLEFT")
		uicon:SetPoint("BOTTOMRIGHT")
		uicon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	-- Heirlooms
	HeirloomsJournal.iconsFrame:StripTextures()
	T.SkinEditBox(HeirloomsJournal.SearchBox, nil, 18)
	T.SkinNextPrevButton(HeirloomsJournal.PagingFrame.PrevPageButton)
	T.SkinNextPrevButton(HeirloomsJournal.PagingFrame.NextPageButton)
	HeirloomsJournalFilterButton:SetPoint("TOPLEFT", HeirloomsJournal.SearchBox, "TOPRIGHT", 5, 2)
	HeirloomsJournal.progressBar:StripTextures()
	HeirloomsJournal.progressBar:CreateBackdrop("Overlay")
	HeirloomsJournal.progressBar:SetStatusBarTexture(C.media.texture)
	HeirloomsJournal.progressBar:SetFrameLevel(HeirloomsJournal.progressBar:GetFrameLevel() + 2)
	T.SkinDropDownBox(HeirloomsJournalClassDropDown, 170)

	hooksecurefunc(HeirloomsJournal, "LayoutCurrentPage", function(self)
		for i = 1, #self.heirloomHeaderFrames do
			local header = self.heirloomHeaderFrames[i]
			if not header.styled then
				header.text:SetTextColor(0.9, 0.8, 0.5)
				header.styled = true
			end
		end
	end)

	hooksecurefunc(HeirloomsJournal, "UpdateButton", function(_, button)
		if not button.styled then
			button:StyleButton(nil, 0)
			button:CreateBackdrop("Default")

			hooksecurefunc(button.level, "SetFontObject", function(self, font)
				if font ~= "SystemFont_Outline_Small" then
					self:SetFontObject("SystemFont_Outline_Small")
					self:SetTextColor(1, 1, 1)
				end
			end)

			button.levelBackground:SetAlpha(0)

			button.slotFrameCollected:SetTexture("")
			button.slotFrameUncollected:SetTexture("")

			button.iconTexture:SetPoint("TOPLEFT")
			button.iconTexture:SetPoint("BOTTOMRIGHT")
			button.iconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			button.iconTextureUncollected:SetPoint("TOPLEFT")
			button.iconTextureUncollected:SetPoint("BOTTOMRIGHT")
			button.iconTextureUncollected:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			button.styled = true
		end

		if C_Heirloom.PlayerHasHeirloom(button.itemID) then
			button.name:SetTextColor(0.9, 0.8, 0.5)
		else
			button.name:SetTextColor(0.6, 0.6, 0.6)
		end
	end)

	-- Wardrobe
	WardrobeFrame:StripTextures()
	WardrobeFrame:SetTemplate("Transparent")
	T.SkinCloseButton(WardrobeFrameCloseButton)
	T.SkinDropDownBox(WardrobeOutfitDropDown)
	WardrobeOutfitDropDown:SetSize(221, 34)
	WardrobeOutfitDropDown.SaveButton:SkinButton()
	WardrobeOutfitDropDown.SaveButton:SetPoint("TOPLEFT", WardrobeOutfitDropDown, "TOPRIGHT", -2, -2)
	WardrobeTransmogFrame:StripTextures()
	WardrobeTransmogFrame.Inset:StripTextures()
	WardrobeTransmogFrame.SpecButton:SkinButton()
	WardrobeTransmogFrame.ApplyButton:SkinButton()
	WardrobeTransmogFrame.SpecButton:SetPoint("RIGHT", WardrobeTransmogFrame.ApplyButton, "LEFT", -2, 0)
	WardrobeTransmogFrame.ModelScene.ClearAllPendingButton:SkinButton()
	T.SkinCheckBox(WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox)

	for i = 1, #WardrobeTransmogFrame.SlotButtons do
		local slot = WardrobeTransmogFrame.SlotButtons[i]
		local icon = slot.Icon
		local border = slot.Border

		if slot then
			border:Kill()

			slot:StyleButton()
			slot:SetFrameLevel(slot:GetFrameLevel() + 2)
			slot:CreateBackdrop("Default")
			slot.backdrop:SetAllPoints()

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end

	WardrobeCollectionFrame.ItemsCollectionFrame:StripTextures()
	WardrobeCollectionFrame.SetsTransmogFrame:StripTextures()
	WardrobeCollectionFrame.progressBar:StripTextures()
	WardrobeCollectionFrame.progressBar:CreateBackdrop("Overlay")
	WardrobeCollectionFrame.progressBar:SetStatusBarTexture(C.media.texture)
	WardrobeCollectionFrame.progressBar:SetFrameLevel(WardrobeCollectionFrame.progressBar:GetFrameLevel() + 2)
	T.SkinEditBox(WardrobeCollectionFrameSearchBox, nil, 18)
	WardrobeCollectionFrameSearchBox:SetFrameLevel(WardrobeCollectionFrameSearchBox:GetFrameLevel() + 2)
	WardrobeCollectionFrame.FilterButton:SkinButton()
	WardrobeCollectionFrame.FilterButton:SetPoint("TOPLEFT", WardrobeCollectionFrameSearchBox, "TOPRIGHT", 5, 2)
	T.SkinDropDownBox(WardrobeCollectionFrameWeaponDropDown, 170)
	T.SkinNextPrevButton(WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.PrevPageButton)
	T.SkinNextPrevButton(WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.NextPageButton)
	T.SkinNextPrevButton(WardrobeCollectionFrame.SetsTransmogFrame.PagingFrame.PrevPageButton)
	T.SkinNextPrevButton(WardrobeCollectionFrame.SetsTransmogFrame.PagingFrame.NextPageButton)

	WardrobeCollectionFrame.SetsCollectionFrame.LeftInset:StripTextures()
	WardrobeCollectionFrame.SetsCollectionFrame.RightInset:StripTextures()
	WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame:StripTextures()
	WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame:CreateBackdrop("Overlay")
	WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame.backdrop:SetPoint("TOPLEFT", 4, -4)
	WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame.backdrop:SetPoint("BOTTOMRIGHT", 1, 4)
	WardrobeSetsCollectionVariantSetsButton:SkinButton()
	T.SkinScrollBar(WardrobeCollectionFrameScrollFrameScrollBar)
	WardrobeCollectionFrameScrollFrameScrollBar:SetPoint("TOPLEFT", WardrobeCollectionFrame.SetsCollectionFrame.ScrollFrame, "TOPRIGHT", 4, 15)
	WardrobeCollectionFrameScrollFrameScrollBar:SetPoint("BOTTOMLEFT", WardrobeCollectionFrame.SetsCollectionFrame.ScrollFrame, "BOTTOMRIGHT", 4, 14)

	local function SetItemQuality(_, itemFrame)
		if (itemFrame.backdrop) then
			local _, _, quality = GetItemInfo(itemFrame.itemID);
			local alpha = 1
			if (not itemFrame.collected) then
				alpha = 0.4
			end

			if (not quality or quality < 2) then -- Not collected or item is white or grey
				itemFrame.backdrop:SetBackdropBorderColor(0, 0, 0)
			else
				itemFrame.backdrop:SetBackdropBorderColor(ITEM_QUALITY_COLORS[quality].r, ITEM_QUALITY_COLORS[quality].g, ITEM_QUALITY_COLORS[quality].b, alpha)
			end
		end
	end
	hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame, "SetItemFrameQuality", SetItemQuality)


	for i = 1, 2 do
		T.SkinTab(_G["WardrobeCollectionFrameTab"..i], true)
	end

	for i = 1, #WardrobeCollectionFrame.SetsCollectionFrame.ScrollFrame.buttons do
		local button = _G["WardrobeCollectionFrameScrollFrameButton"..i]

		if not button.isSkinned then
			button:GetRegions():Hide()
			button:CreateBackdrop("Overlay")
			button.backdrop:SetPoint("TOPLEFT", 2, -2)
			button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
			button:StyleButton(nil, 4)

			button.HighlightTexture:SetTexture(nil)
			button.SelectedTexture:SetTexture(nil)

			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			button.border = CreateFrame("Frame", nil, button)
			button.border:CreateBackdrop("Default")
			button.border.backdrop:SetPoint("TOPLEFT", button.Icon, -2, 2)
			button.border.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, 2, -2)

			button.ProgressBar:SetPoint("TOPLEFT", button.backdrop, "BOTTOMLEFT", 2, 4)

			button.isSkinned = true
		end
	end

	local function ColorSelectedSet()
		for i = 1, #WardrobeCollectionFrame.SetsCollectionFrame.ScrollFrame.buttons do
			local button = _G["WardrobeCollectionFrameScrollFrameButton"..i]

			if button.SelectedTexture:IsShown() then
				button.backdrop:SetBackdropBorderColor(1, 1, 0)
				button.border.backdrop:SetBackdropBorderColor(1, 1, 0)
			else
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end
	hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame, "SelectSet", ColorSelectedSet)
	hooksecurefunc(WardrobeCollectionFrameScrollFrame, "update", ColorSelectedSet)

	hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame, "DisplaySet", function()
		for _, child in ipairs({WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame:GetChildren()}) do
			if child.Icon and not child.isSkinned then
				child.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				child:CreateBackdrop("Default")
				child.backdrop:SetPoint("TOPLEFT", child.Icon, -2, 2)
				child.backdrop:SetPoint("BOTTOMRIGHT", child.Icon, 2, -2)

				child.isSkinned = true
			end
		end
	end)

    for i = 1, #WardrobeCollectionFrame.ItemsCollectionFrame.Models do
        local model = WardrobeCollectionFrame.ItemsCollectionFrame.Models[i]
		model.Border:SetAlpha(0)
		local bg = CreateFrame("Frame", nil, model)
		bg:CreateBackdrop("Overlay")
		bg.backdrop:SetOutside(model, 3, 3)

		hooksecurefunc(model.Border, 'SetAtlas', function(_, texture)
			local color
			if texture == "transmog-wardrobe-border-uncollected" then
				color = {0.3, 0.3, 1}
			elseif texture == "transmog-wardrobe-border-unusable" then
				color = {0.8, 0, 0}
			else
				color = C.media.border_color
			end
			bg.backdrop:SetBackdropBorderColor(unpack(color))
		end)
    end

	for i = 1, #WardrobeCollectionFrame.SetsTransmogFrame.Models do
        local model = WardrobeCollectionFrame.SetsTransmogFrame.Models[i]
		model.Border:SetAlpha(0)
		local bg = CreateFrame("Frame", nil, model)
		bg:CreateBackdrop("Overlay")
		bg.backdrop:SetOutside(model, 3, 3)
    end

	local function SkinSetItemButtons(self)
		for itemFrame in self.DetailsFrame.itemFramesPool:EnumerateActive() do
			itemFrame.IconBorder:SetAlpha(0)
			SetItemQuality(self, itemFrame)
		end
	end
	hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame, "DisplaySet", SkinSetItemButtons)

	-- Help box
	local HelpBox = {
		ToyBox.favoriteHelpBox,
		WardrobeCollectionFrame.ItemsCollectionFrame.HelpBox,
		WardrobeCollectionFrame.SetsTabHelpBox,
		WardrobeTransmogFrame.SpecHelpBox,
		WardrobeTransmogFrame.OutfitHelpBox
	}

	for i = 1, #HelpBox do
		local frame = HelpBox[i]
		T.SkinHelpBox(frame)
	end
end

T.SkinFuncs["Blizzard_Collections"] = LoadSkin