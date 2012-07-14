local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PetJournal skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"MountJournal",
		"PetJournalParent",
		"PetJournalRightInset",
		"PetJournalLeftInset",
		"PetJournalPrimaryAbilityTooltip",
		--"PetJournalPetCardListHealthStatusBar",
		--"PetJournalPetCardListStatusBar",
		"PetJournalPetCard",
		"PetJournalPetCardInset"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local buttons = {
		"MountJournalMountButton",
		"PetJournalSummonButton",
		"PetJournalFindBattle",
		"PetJournalFilterButton",
	}

	for i = 1, #buttons do
		if i == 4 then
			_G[buttons[i]]:StripTextures(true)
		end
		_G[buttons[i]]:SkinButton()
	end

	PetJournalParent:SetTemplate("Transparent")
	PetJournalParentPortrait:Hide()
	T.SkinTab(PetJournalParentTab1)
	T.SkinTab(PetJournalParentTab2)
	T.SkinCloseButton(PetJournalParentCloseButton)

	-- MountJournal
	MountJournal.LeftInset:StripTextures()
	MountJournal.RightInset:StripTextures()
	MountJournal.MountDisplay:StripTextures()
	MountJournal.MountDisplay.ShadowOverlay:StripTextures()
	MountJournal.MountCount:StripTextures()

	T.SkinScrollBar(MountJournalListScrollFrameScrollBar)
	T.SkinRotateButton(MountJournal.MountDisplay.ModelFrame.RotateLeftButton)
	T.SkinRotateButton(MountJournal.MountDisplay.ModelFrame.RotateRightButton)

	for i = 1, #MountJournal.ListScrollFrame.buttons do
		local b = _G["MountJournalListScrollFrameButton"..i]
		local t = _G["MountJournalListScrollFrameButton"..i.."Name"]

		if not b.isSkinned then
			b:StripTextures()
			b:CreateBackdrop("Overlay")
			b.backdrop:Point("TOPLEFT", 2, -2)
			b.backdrop:Point("BOTTOMRIGHT", -2, 2)

			b.border = CreateFrame("Frame", nil, b)
			b.border:CreateBackdrop("Default")
			b.border.backdrop:Point("TOPLEFT", b.icon, -2, 2)
			b.border.backdrop:Point("BOTTOMRIGHT", b.icon, 2, -2)

			b.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			b.icon:SetParent(b.border.backdrop)

			t:SetParent(b.border.backdrop)

			b.isSkinned = true
		end
	end

	local function ColorSelectedMount()
		for i = 1, #MountJournal.ListScrollFrame.buttons do
			local b = _G["MountJournalListScrollFrameButton"..i]
			local t = _G["MountJournalListScrollFrameButton"..i.."Name"]

			if b.selectedTexture:IsShown() then
				t:SetTextColor(1, 1, 0)
				b.backdrop:SetBackdropBorderColor(1, 1, 0)
				b.border.backdrop:SetBackdropBorderColor(1, 1, 0)
			else
				t:SetTextColor(1, 1, 1)
				b.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				b.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end
	hooksecurefunc("MountJournal_UpdateMountList", ColorSelectedMount)

	MountJournalListScrollFrame:HookScript("OnVerticalScroll", ColorSelectedMount)
	MountJournalListScrollFrame:HookScript("OnMouseWheel", ColorSelectedMount)

	-- PetJournal
	for i = 1, 3 do
		local f = _G["PetJournalLoadoutPet"..i.."HelpFrame"]
		f:StripTextures()
	end

	PetJournalTutorialButton.Ring:Hide()
	PetJournalTutorialButton:SetPoint("TOPLEFT", PetJournal, "TOPLEFT", -5, 10)

	PetJournal.PetCount:StripTextures()
	T.SkinEditBox(PetJournalSearchBox)
	PetJournalSearchBox:SetHeight(18)

	PetJournalFilterButton:SetPoint("TOPLEFT", PetJournalSearchBox, "TOPRIGHT", 5, 2)

	T.SkinScrollBar(PetJournalListScrollFrameScrollBar)

	for i = 1, #PetJournal.listScroll.buttons do
		local b = _G["PetJournalListScrollFrameButton"..i]
		local t = _G["PetJournalListScrollFrameButton"..i.."Name"]

		if not b.isSkinned then
			b:StripTextures()
			b:CreateBackdrop("Overlay")
			b.backdrop:Point("TOPLEFT", 2, -2)
			b.backdrop:Point("BOTTOMRIGHT", -2, 2)

			b.border = CreateFrame("Frame", nil, b)
			b.border:CreateBackdrop("Default")
			b.border.backdrop:Point("TOPLEFT", b.icon, -2, 2)
			b.border.backdrop:Point("BOTTOMRIGHT", b.icon, 2, -2)

			b.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			b.icon:SetParent(b.border.backdrop)

			t:SetParent(b.border.backdrop)

			b.isSkinned = true
		end
	end

	local function ColorSelectedPet()
		for i = 1, #PetJournal.listScroll.buttons do
			local b = _G["PetJournalListScrollFrameButton"..i]
			local t = _G["PetJournalListScrollFrameButton"..i.."Name"]

			if b.selectedTexture:IsShown() then
				t:SetTextColor(1, 1, 0)
				b.backdrop:SetBackdropBorderColor(1, 1, 0)
				b.border.backdrop:SetBackdropBorderColor(1, 1, 0)
			else
				t:SetTextColor(1, 1, 1)
				b.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				b.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end
	hooksecurefunc("PetJournal_UpdatePetList", ColorSelectedPet)

	PetJournalListScrollFrame:HookScript("OnVerticalScroll", ColorSelectedPet)
	PetJournalListScrollFrame:HookScript("OnMouseWheel", ColorSelectedPet)

	PetJournalAchievementStatus:DisableDrawLayer("BACKGROUND")

	PetJournalHealPetButton:StripTextures()
	PetJournalHealPetButton:CreateBackdrop()
	PetJournalHealPetButton.backdrop:SetAllPoints()
	PetJournalHealPetButton:StyleButton()

	PetJournalHealPetButton.texture:SetTexture("Interface\\Icons\\spell_magic_polymorphrabbit")
	PetJournalHealPetButton.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	PetJournalHealPetButton.texture:ClearAllPoints()
	PetJournalHealPetButton.texture:Point("TOPLEFT", 2, -2)
	PetJournalHealPetButton.texture:Point("BOTTOMRIGHT", -2, 2)

	PetJournalLoadoutBorder:StripTextures()

	for i = 1, 3 do
		_G["PetJournalLoadoutPet"..i]:StripTextures()
		_G["PetJournalLoadoutPet"..i]:SetTemplate("Overlay")

		_G["PetJournalLoadoutPet"..i].dragButton:SetTemplate("Default", true)
		_G["PetJournalLoadoutPet"..i].dragButton:StyleButton()
	end

	PetJournalPetCard:CreateBackdrop("Overlay")
	PetJournalPetCard.backdrop:Point("TOPLEFT", 2, -2)
	PetJournalPetCard.backdrop:Point("BOTTOMRIGHT", -4, 2)

	PetJournalPetCardPetInfo:StripTextures()
	PetJournalPetCardPetInfoIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	PetJournalPrimaryAbilityTooltip:SetTemplate("Transparent")

	for i = 1, 6 do
		local b = _G["PetJournalPetCardSpell"..i]

		b:StripTextures()
		b:SetTemplate("Default")
		b:StyleButton()

		b.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		b.icon:ClearAllPoints()
		b.icon:Point("TOPLEFT", 2, -2)
		b.icon:Point("BOTTOMRIGHT", -2, 2)

		b.isSkinned = true
	end

	--PetJournalPetCardListHealthStatusBar:CreateBackdrop("Default")
	--PetJournalPetCardListHealthStatusBar:SetStatusBarTexture(C.media.texture)
	--PetJournalPetCardListHealthStatusBar.healthRankText:SetPoint("CENTER", 0, 1)

	--PetJournalPetCardListStatusBar:CreateBackdrop("Default")
	--PetJournalPetCardListStatusBar:SetStatusBarTexture(C.media.texture)
	--PetJournalPetCardListStatusBar:SetPoint("TOP", PetJournalPetCardListHealthStatusBar, "BOTTOM", 0, -6)
	--PetJournalPetCardListStatusBar.rankText:SetPoint("CENTER", 0, 1)
end

T.SkinFuncs["Blizzard_PetJournal"] = LoadSkin