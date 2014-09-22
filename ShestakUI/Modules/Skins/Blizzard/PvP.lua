local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PvP skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	--WoD PVPUIFrame:StripTextures()
	-- PVPUIFrame:SetTemplate("Transparent")
	-- PVPUIFrame.LeftInset:StripTextures()
	-- PVPUIFrame.Shadows:StripTextures()

	-- T.SkinCloseButton(PVPUIFrameCloseButton)

	-- Bottom Tabs
	for i = 1, 2 do
		T.SkinTab(_G["PVPUIFrameTab"..i])
	end

	for i = 1, 4 do
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
	HonorFrame.BonusFrame.DiceButton:SkinButton()
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:SkinButton(true)
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	--WoD HonorFrame.BonusFrame.CallToArmsButton:SkinButton(true)
	-- HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:ClearAllPoints()
	-- HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetAllPoints()
	-- HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetTexture(0, 1, 0, 0.1)

	for i = 1, 2 do
		local b = HonorFrame.BonusFrame["Arena"..i.."Button"]
		b:SkinButton(true)
		b.SelectedTexture:ClearAllPoints()
		b.SelectedTexture:SetAllPoints()
		b.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	end

	for _, b in pairs(HonorFrame.SpecificFrame.buttons) do
		b:SetHighlightTexture("")
		b.SelectedTexture:SetTexture(1, 0.82, 0, 0.3)
	end

	for _, roleButton in pairs{HonorFrame.RoleInset.TankIcon, HonorFrame.RoleInset.HealerIcon, HonorFrame.RoleInset.DPSIcon} do
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
	ConquestFrame.Arena2v2:SkinButton(true)
	ConquestFrame.Arena2v2.SelectedTexture:ClearAllPoints()
	ConquestFrame.Arena2v2.SelectedTexture:SetAllPoints()
	ConquestFrame.Arena2v2.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	ConquestFrame.Arena3v3:SkinButton(true)
	ConquestFrame.Arena3v3.SelectedTexture:ClearAllPoints()
	ConquestFrame.Arena3v3.SelectedTexture:SetAllPoints()
	ConquestFrame.Arena3v3.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	ConquestFrame.Arena5v5:SkinButton(true)
	ConquestFrame.Arena5v5.SelectedTexture:ClearAllPoints()
	ConquestFrame.Arena5v5.SelectedTexture:SetAllPoints()
	ConquestFrame.Arena5v5.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	ConquestFrame.RatedBG:SkinButton(true)
	ConquestFrame.RatedBG.SelectedTexture:ClearAllPoints()
	ConquestFrame.RatedBG.SelectedTexture:SetAllPoints()
	ConquestFrame.RatedBG.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	ConquestJoinButton:SkinButton(true)

	ConquestTooltip:SetTemplate("Transparent")

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
	T.SkinCheckBox(WarGameTournamentModeCheckButton)

	for _, btn in pairs(WarGamesFrame.scrollFrame.buttons) do
		local bu = btn.Entry
		bu:SetSize(307, 38)
		bu:SkinButton(true)
		bu.SelectedTexture:SetDrawLayer("ARTWORK")
		bu.SelectedTexture:SetTexture(1, 0.82, 0, 0.3)
		bu.SelectedTexture:SetPoint("TOPLEFT", 0, 0)
		bu.SelectedTexture:SetPoint("BOTTOMRIGHT", 0, 0)
	end
end

T.SkinFuncs["Blizzard_PVPUI"] = LoadSkin