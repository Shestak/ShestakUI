local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PvP skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	PVPUIFrame:StripTextures()
	PVPUIFrame:SetTemplate("Transparent")
	PVPUIFrame.LeftInset:StripTextures()
	PVPUIFrame.Shadows:StripTextures()

	T.SkinCloseButton(PVPUIFrameCloseButton)

	-- Bottom Tabs
	for i = 1, 2 do
		T.SkinTab(_G["PVPUIFrameTab"..i])
	end

	for i = 1, 3 do
		local button = _G["PVPQueueFrameCategoryButton"..i]

		button.Ring:Kill()
		button:CreateBackdrop("Overlay")
		button.backdrop:SetAllPoints()
		button:StyleButton()

		button.Background:Kill()

		button.Icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)
		button.Icon:SetPoint("LEFT", button, "LEFT", 10, 0)
		button.Icon:SetDrawLayer("OVERLAY")
		button.Icon:SetSize(40, 40)

		button.border = CreateFrame("Frame", nil, button)
		button.border:CreateBackdrop("Default")
		button.border.backdrop:SetPoint("TOPLEFT", button.Icon, -2, 2)
		button.border.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, 2, -2)
	end

	for i = 1, 3 do
		local button = _G["PVPArenaTeamsFrameTeam"..i]
		button:SetTemplate("Overlay")
		button.Background:Kill()
		button:StyleButton()
	end

	hooksecurefunc("PVPQueueFrame_SelectButton", function(index)
		local self = PVPQueueFrame
		for i = 1, 3 do
			local button = self["CategoryButton"..i]
			if i == index then
				button.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				button.backdrop.overlay:SetVertexColor(1, 0.82, 0, 0.3)
				button.border.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
			else
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				button.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end)

	-- HonorFrame
	HonorFrame.Inset:StripTextures()
	HonorFrame.RoleInset:StripTextures()
	T.SkinDropDownBox(HonorFrameTypeDropDown, 165)
	T.SkinScrollBar(HonorFrameSpecificFrameScrollBar)
	HonorFrameSoloQueueButton:SkinButton(true)
	HonorFrameGroupQueueButton:SkinButton(true)
	HonorFrame.BonusFrame:StripTextures()
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:CreateBackdrop("Overlay")
	HonorFrame.BonusFrame.RandomBGButton.backdrop:SetPoint("TOPLEFT", 2, -2)
	HonorFrame.BonusFrame.RandomBGButton.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetPoint("TOPLEFT", 4, -4)
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetPoint("BOTTOMRIGHT", -4, 4)
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	HonorFrame.BonusFrame.CallToArmsButton:StripTextures()
	HonorFrame.BonusFrame.CallToArmsButton:CreateBackdrop("Overlay")
	HonorFrame.BonusFrame.CallToArmsButton.backdrop:SetPoint("TOPLEFT", 2, -2)
	HonorFrame.BonusFrame.CallToArmsButton.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetPoint("TOPLEFT", 4, -4)
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetPoint("BOTTOMRIGHT", -4, 4)
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetTexture(0, 1, 0, 0.1)

	for i = 1, 2 do
		local b = HonorFrame.BonusFrame["WorldPVP"..i.."Button"]
		b:StripTextures()
		b:CreateBackdrop("Overlay")
		b.backdrop:SetPoint("TOPLEFT", 2, -3)
		b.backdrop:SetPoint("BOTTOMRIGHT", -2, 3)
		b.SelectedTexture:ClearAllPoints()
		b.SelectedTexture:SetPoint("TOPLEFT", 4, -5)
		b.SelectedTexture:SetPoint("BOTTOMRIGHT", -4, 5)
		b.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	end

	for _, roleButton in pairs({HonorFrame.RoleInset.HealerIcon, HonorFrame.RoleInset.TankIcon, HonorFrame.RoleInset.DPSIcon}) do
		roleButton.checkButton:SetFrameLevel(roleButton:GetFrameLevel() + 2)
		T.SkinCheckBox(roleButton.checkButton)
	end

	-- ConquestFrame
	ConquestFrame.Inset:StripTextures()
	ConquestPointsBarLeft:Kill()
	ConquestPointsBarRight:Kill()
	ConquestPointsBarMiddle:Kill()
	ConquestPointsBarBG:Kill()
	ConquestPointsBarShadow:Kill()
	ConquestPointsBar.progress:SetTexture(C.media.texture)
	ConquestPointsBar:CreateBackdrop("Default")
	ConquestPointsBar.backdrop:SetPoint("TOPLEFT", ConquestPointsBar, "TOPLEFT", -2, -1)
	ConquestPointsBar.backdrop:SetPoint("BOTTOMRIGHT", ConquestPointsBar, "BOTTOMRIGHT", 2, 1)
	ConquestFrame:StripTextures()
	ConquestFrame.ShadowOverlay:StripTextures()
	ConquestFrame.RatedBG:StripTextures()
	ConquestFrame.RatedBG:SkinButton()
	ConquestFrame.RatedBG.SelectedTexture:ClearAllPoints()
	ConquestFrame.RatedBG.SelectedTexture:SetAllPoints()
	ConquestFrame.RatedBG.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	ConquestJoinButton:SkinButton(true)

	-- PvP Ready Dialog
	PVPReadyDialog:StripTextures()
	PVPReadyDialog:SetTemplate("Transparent")
	PVPReadyDialog.SetBackdrop = T.dummy
	PVPReadyDialog.filigree:SetAlpha(0)
	PVPReadyDialog.bottomArt:SetAlpha(0)
	PVPReadyDialogEnterBattleButton:SkinButton()
	PVPReadyDialogLeaveQueueButton:SkinButton()
	T.SkinCloseButton(PVPReadyDialogCloseButton, PVPReadyDialog, "-")

	-- WarGamesFrame
	WarGamesFrame:StripTextures()
	WarGamesFrame.RightInset:StripTextures()
	WarGameStartButton:SkinButton(true)
	T.SkinScrollBar(WarGamesFrameScrollFrameScrollBar)
	WarGamesFrameInfoScrollFrameScrollBar:StripTextures()
	WarGamesFrame.HorizontalBar:StripTextures()
	WarGamesFrameDescription:SetTextColor(1, 1, 1)
	WarGamesFrameDescription:SetFont(C.media.normal_font, 13)
	WarGamesFrameDescription:SetShadowOffset(1, -1)

	-- ArenaTeamFrame
	PVPArenaTeamsFrame:StripTextures()
	ArenaTeamFrame.TopInset:StripTextures()
	ArenaTeamFrame.BottomInset:StripTextures()
	ArenaTeamFrame.WeeklyDisplay:StripTextures()
	T.SkinNextPrevButton(ArenaTeamFrame.weeklyToggleRight)
	T.SkinNextPrevButton(ArenaTeamFrame.weeklyToggleLeft)
	ArenaTeamFrame:StripTextures()
	ArenaTeamFrame.TopShadowOverlay:StripTextures()

	for i = 1, 4 do
		_G["ArenaTeamFrameHeader"..i.."Left"]:Kill()
		_G["ArenaTeamFrameHeader"..i.."Middle"]:Kill()
		_G["ArenaTeamFrameHeader"..i.."Right"]:Kill()
		_G["ArenaTeamFrameHeader"..i]:SetHighlightTexture(nil)
	end

	for i = 1, 3 do
		local b = ARENA_BUTTONS[i]
		b:StripTextures()
		b:SkinButton()
		b.SelectedTexture:ClearAllPoints()
		b.SelectedTexture:SetAllPoints()
		b.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	end

	ArenaTeamFrame.AddMemberButton:SkinButton(true)

	-- PVP Banners
	PVPBannerFrame:StripTextures()
	PVPBannerFramePortrait:SetAlpha(0)
	PVPBannerFrame:SetTemplate("Transparent")
	T.SkinCloseButton(PVPBannerFrameCloseButton)
	PVPBannerFrame.Inset:StripTextures()

	PVPBannerFrameAcceptButton:SkinButton(true)
	PVPBannerFrameCancelButton:SkinButton(true)

	for i = 1, PVPBannerFrame:GetNumChildren() do
		local child = select(i, PVPBannerFrame:GetChildren())
		if child:GetObjectType() == "Button" then
			local name = child:GetName()
			if name ~= "PVPBannerFrameCloseButton" then child:SkinButton() end
		end
	end

	PVPBannerFrameEditBoxLeft:Kill()
	PVPBannerFrameEditBoxRight:Kill()
	PVPBannerFrameEditBoxMiddle:Kill()

	PVPBannerFrameEditBox:CreateBackdrop("Overlay")
	PVPBannerFrameEditBox.backdrop:SetPoint("TOPLEFT", PVPBannerFrameEditBox, "TOPLEFT" , -3, -6)
	PVPBannerFrameEditBox.backdrop:SetPoint("BOTTOMRIGHT", PVPBannerFrameEditBox, "BOTTOMRIGHT", 3, 6)

	-- Duplicate button name
	for i = 1, PVPBannerFrame:GetNumChildren() do
		local child = select(i, PVPBannerFrame:GetChildren())
		if child and child:GetObjectType() == "Button" and child:GetWidth() == 80 then
			child:SkinButton(true)
		end
	end

	for i = 1, 3 do
		_G["PVPColorPickerButton"..i]:SkinButton(true)
		_G["PVPColorPickerButton"..i]:SetHeight(_G["PVPColorPickerButton"..i]:GetHeight() - 2)
	end

	PVPBannerFrameCustomizationFrame:StripTextures()

	for i = 1, 2 do
		_G["PVPBannerFrameCustomization"..i]:StripTextures()
		T.SkinNextPrevButton(_G["PVPBannerFrameCustomization"..i.."RightButton"])
		T.SkinNextPrevButton(_G["PVPBannerFrameCustomization"..i.."LeftButton"])
	end
end

T.SkinFuncs["Blizzard_PVPUI"] = LoadSkin