local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	PetJournal skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "Blizzard_PetJournal" then
		PetJournalPrimaryAbilityTooltip.Background:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.Delimiter1:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.Delimiter2:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.BorderTop:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.BorderTopLeft:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.BorderTopRight:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.BorderLeft:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.BorderRight:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.BorderBottom:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.BorderBottomRight:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip.BorderBottomLeft:SetTexture(nil)
		PetJournalPrimaryAbilityTooltip:SetTemplate("Transparent")
	end
end)

if C.skins.blizzard_frames ~= true then return end

local function LoadSkin()
	local StripAllTextures = {
		"MountJournal",
		"PetJournalParent",
		"PetJournalRightInset",
		"PetJournalLeftInset",
		"PetJournalPetCard",
		"PetJournalPetCardInset",
		"PetJournalLoadoutBorder",
		"PetJournalSpellSelect",
		"PetJournalPetCardXPBar",
		"ToyBoxProgressBar"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local buttons = {
		"MountJournalMountButton",
		"PetJournalSummonButton",
		"PetJournalFindBattle",
		"PetJournalFilterButton",
		"MountJournalFilterButton",
		"ToyBoxFilterButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end

	PetJournalParent:SetTemplate("Transparent")
	PetJournalParentPortrait:Hide()
	T.SkinTab(PetJournalParentTab1)
	T.SkinTab(PetJournalParentTab2)
	T.SkinTab(PetJournalParentTab3)
	T.SkinCloseButton(PetJournalParentCloseButton)

	-- MountJournal
	MountJournal.LeftInset:StripTextures()
	MountJournal.RightInset:StripTextures()
	MountJournal.MountDisplay:StripTextures()
	MountJournal.MountDisplay.ShadowOverlay:StripTextures()
	MountJournal.MountCount:StripTextures()

	MountJournal.MountDisplay:CreateBackdrop("Overlay")
	MountJournal.MountDisplay.backdrop:SetPoint("TOPLEFT", 2, -2)
	MountJournal.MountDisplay.backdrop:SetPoint("BOTTOMRIGHT", 1, 2)

	T.SkinEditBox(MountJournalSearchBox, nil, 18)
	T.SkinScrollBar(MountJournalListScrollFrameScrollBar)
	T.SkinRotateButton(MountJournal.MountDisplay.ModelFrame.RotateLeftButton)
	T.SkinRotateButton(MountJournal.MountDisplay.ModelFrame.RotateRightButton)

	MountJournalFilterButton:SetPoint("TOPLEFT", MountJournalSearchBox, "TOPRIGHT", 5, 2)

	for i = 1, #MountJournal.ListScrollFrame.buttons do
		local button = _G["MountJournalListScrollFrameButton"..i]
		local name = _G["MountJournalListScrollFrameButton"..i.."Name"]

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
			button.DragButton.ActiveTexture:SetTexture(0, 1, 0, 0.3)
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
			local name = _G["MountJournalListScrollFrameButton"..i.."Name"]

			if button.selectedTexture:IsShown() then
				name:SetTextColor(1, 1, 0)
				button.backdrop:SetBackdropBorderColor(1, 1, 0)
				button.DragButton.backdrop:SetBackdropBorderColor(1, 1, 0)
			else
				name:SetTextColor(1, 1, 1)
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.DragButton.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end
	hooksecurefunc("MountJournal_UpdateMountList", ColorSelectedMount)

	MountJournalListScrollFrame:HookScript("OnVerticalScroll", ColorSelectedMount)
	MountJournalListScrollFrame:HookScript("OnMouseWheel", ColorSelectedMount)

	MountJournalSummonRandomFavoriteButton:CreateBackdrop("Default")
	MountJournalSummonRandomFavoriteButton.backdrop:SetAllPoints()
	MountJournalSummonRandomFavoriteButton:StyleButton()
	MountJournalSummonRandomFavoriteButtonBorder:Hide()
	MountJournalSummonRandomFavoriteButton.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	MountJournalSummonRandomFavoriteButton.texture:ClearAllPoints()
	MountJournalSummonRandomFavoriteButton.texture:SetPoint("TOPLEFT", 2, -2)
	MountJournalSummonRandomFavoriteButton.texture:SetPoint("BOTTOMRIGHT", -2, 2)

	do
		local button = MountJournal.MountDisplay.InfoButton
		local icon = MountJournal.MountDisplay.InfoButton.Icon
		button:CreateBackdrop("Default")
		button.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	-- PetJournal
	PetJournalTutorialButton.Ring:Hide()
	PetJournalTutorialButton:SetPoint("TOPLEFT", PetJournal, "TOPLEFT", -5, 10)

	PetJournal.PetCount:StripTextures()
	T.SkinEditBox(PetJournalSearchBox, nil, 18)

	PetJournalFilterButton:SetPoint("TOPLEFT", PetJournalSearchBox, "TOPRIGHT", 5, 2)

	PetJournalLoadoutBorderSlotHeaderText:SetParent(PetJournal)
	PetJournalLoadoutBorderSlotHeaderText:SetPoint("CENTER", PetJournalLoadoutBorderTop, "TOP", 0, 4)

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
			button.dragButton.ActiveTexture:SetTexture(0, 1, 0, 0.3)
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

	PetJournalHealPetButton:CreateBackdrop("Default")
	PetJournalHealPetButton.backdrop:SetAllPoints()
	PetJournalHealPetButton:StyleButton()
	PetJournalHealPetButtonBorder:Hide()
	PetJournalHealPetButton.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	PetJournalHealPetButton.texture:ClearAllPoints()
	PetJournalHealPetButton.texture:SetPoint("TOPLEFT", 2, -2)
	PetJournalHealPetButton.texture:SetPoint("BOTTOMRIGHT", -2, 2)

	for i = 1, 3 do
		local button = _G["PetJournalLoadoutPet"..i]
		local icon = _G["PetJournalLoadoutPet"..i.."Icon"]
		local level = _G["PetJournalLoadoutPet"..i.."Level"]

		button:CreateBackdrop("Overlay")
		button.backdrop:SetPoint("TOPLEFT", -2, 0)
		button.backdrop:SetPoint("BOTTOMRIGHT", 5, 0)

		button.dragButton:CreateBackdrop("Default")
		button.dragButton.backdrop:SetPoint("TOPLEFT", 0, 0)
		button.dragButton.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
		button.dragButton:StyleButton()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetSize(36, 36)

		level:SetParent(button.dragButton.backdrop)
		level:SetFontObject("SystemFont_Outline_Small")
		level:ClearAllPoints()
		level:SetPoint("BOTTOMRIGHT", -2, 3)

		for j = 1, 3 do
			local button = _G["PetJournalLoadoutPet"..i.."Spell"..j]
			local icon = _G["PetJournalLoadoutPet"..i.."Spell"..j.."Icon"]

			button:StyleButton()
			button:SetTemplate("Default")

			button.FlyoutArrow:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)

			_G["PetJournalLoadoutPet"..i.."Spell"..j.."Background"]:SetTexture(nil)
			_G["PetJournalLoadoutPet"..i.."Spell"..j.."Selected"]:SetTexture(nil)
		end

		_G["PetJournalLoadoutPet"..i.."HelpFrame"]:StripTextures()
		_G["PetJournalLoadoutPet"..i.."BG"]:SetTexture(nil)
		_G["PetJournalLoadoutPet"..i.."Shadows"]:SetTexture(nil)
		_G["PetJournalLoadoutPet"..i.."IconBorder"]:SetTexture(nil)
		_G["PetJournalLoadoutPet"..i.."LevelBG"]:SetTexture(nil)
		_G["PetJournalLoadoutPet"..i.."QualityBorder"]:SetTexture(nil)

		_G["PetJournalLoadoutPet"..i.."PetTypeIcon"]:ClearAllPoints()
		_G["PetJournalLoadoutPet"..i.."PetTypeIcon"]:SetPoint("BOTTOMLEFT", button.backdrop, 2, 2)

		_G["PetJournalLoadoutPet"..i.."HealthFrame"].healthBar:StripTextures()
		_G["PetJournalLoadoutPet"..i.."HealthFrame"].healthBar:CreateBackdrop("Overlay")
		_G["PetJournalLoadoutPet"..i.."HealthFrame"].healthBar:SetStatusBarTexture(C.media.texture)

		_G["PetJournalLoadoutPet"..i.."XPBar"]:StripTextures()
		_G["PetJournalLoadoutPet"..i.."XPBar"]:CreateBackdrop("Overlay")
		_G["PetJournalLoadoutPet"..i.."XPBar"]:SetStatusBarTexture(C.media.texture)
		_G["PetJournalLoadoutPet"..i.."XPBar"]:SetFrameLevel(_G["PetJournalLoadoutPet"..i.."XPBar"]:GetFrameLevel() + 2)
	end

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

	PetJournalPetCardXPBar:CreateBackdrop("Overlay")
	PetJournalPetCardXPBar:SetStatusBarTexture(C.media.texture)
	PetJournalPetCardXPBar:SetPoint("BOTTOM", PetJournalPetCard.backdrop, "BOTTOM", 0, 6)
	PetJournalPetCardXPBar:SetFrameLevel(PetJournalPetCardXPBar:GetFrameLevel() + 2)

	-- ToyBox
	ToyBoxIconsFrame:StripTextures()
	T.SkinEditBox(ToyBox.searchBox, nil, 18)
	T.SkinNextPrevButton(ToyBoxPrevPageButton)
	T.SkinNextPrevButton(ToyBoxNextPageButton)
	ToyBoxFilterButton:SetPoint("TOPLEFT", ToyBox.searchBox, "TOPRIGHT", 5, 2)
	ToyBoxProgressBarBar:SetTexture(C.media.texture)
	ToyBoxProgressBar:CreateBackdrop("Overlay")
	ToyBoxProgressBar:SetFrameLevel(ToyBoxProgressBar:GetFrameLevel() + 2)

	for i = 1, 18 do
		_G["ToySpellButton"..i.."SlotFrameCollected"]:SetTexture("")
		_G["ToySpellButton"..i.."SlotFrameUncollected"]:SetTexture("")
		local button = _G["ToySpellButton"..i]
		local icon = _G["ToySpellButton"..i.."IconTexture"]
		local uicon = _G["ToySpellButton"..i.."IconTextureUncollected"]

		button:StyleButton(nil, 0)
		button:CreateBackdrop("Default")

		icon:SetPoint("TOPLEFT")
		icon:SetPoint("BOTTOMRIGHT")
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		uicon:SetPoint("TOPLEFT")
		uicon:SetPoint("BOTTOMRIGHT")
		uicon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	hooksecurefunc("ToySpellButton_UpdateButton", function(self)
		local toyString = _G[self:GetName().."ToyName"]

		if PlayerHasToy(self.itemID) then
			local _, _, quality = GetItemInfo(self.itemID)
			if quality then
				toyString:SetTextColor(GetItemQualityColor(quality))
			else
				toyString:SetTextColor(1, 1, 1)
			end
		else
			toyString:SetTextColor(0.5, 0.5, 0.5)
		end
	end)
end

T.SkinFuncs["Blizzard_PetJournal"] = LoadSkin