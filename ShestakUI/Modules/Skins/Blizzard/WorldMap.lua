local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	WorldMap skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsAddOnLoaded("Mapster") then return end

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("VARIABLES_LOADED")
	frame:SetScript("OnEvent", function()
		SetCVar("miniWorldMap", 1)
	end)

	WorldMapFrame:StripTextures()
	WorldMapFrame:CreateBackdrop("Default")
	WorldMapFrame.backdrop:ClearAllPoints()
	WorldMapFrame.backdrop:SetPoint("TOPLEFT", 1, -66)
	WorldMapFrame.backdrop:SetSize(700, 468)
	WorldMapFrame.Header = CreateFrame("Frame", nil, WorldMapFrame)
	WorldMapFrame.Header:SetSize(WorldMapFrame.backdrop:GetWidth(), 23)
	WorldMapFrame.Header:SetPoint("BOTTOMLEFT", WorldMapFrame.backdrop, "TOPLEFT", 0, 2)
	WorldMapFrame.Header:SetTemplate("Overlay")

	WorldMapFrame.BorderFrame:StripTextures()
	WorldMapFrame.BorderFrame.NineSlice:Hide()
	WorldMapFrame.BorderFrame.Tutorial:Kill()

	QuestMapFrame:StripTextures()
	QuestMapFrame:CreateBackdrop("Overlay")
	QuestMapFrame.backdrop:ClearAllPoints()
	QuestMapFrame.backdrop:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 2, 0)
	QuestMapFrame.backdrop:SetSize(284, 468)

	QuestScrollFrame:ClearAllPoints()
	QuestScrollFrame:SetPoint("TOP", WorldMapFrame.backdrop, "TOP", 0, -3)
	QuestScrollFrame:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 4, 0)
	QuestScrollFrame.DetailFrame:StripTextures()
	QuestScrollFrame.DetailFrame.BottomDetail:Hide()
	QuestScrollFrame.Contents.Separator.Divider:Hide()
	QuestScrollFrame:SetSize(259, 463)

	local CampaignOverview = QuestMapFrame.CampaignOverview
	CampaignOverview:StripTextures()
	CampaignOverview.ScrollFrame:StripTextures()
	T.SkinScrollBar(QuestMapFrameScrollBar)
	CampaignOverview:CreateBackdrop("Overlay")
	CampaignOverview.backdrop:SetPoint("TOPLEFT", CampaignOverview.Header, "TOPLEFT",  8, -5)
	CampaignOverview.backdrop:SetPoint("BOTTOMRIGHT", CampaignOverview.Header, "BOTTOMRIGHT", -4, 10)
	if UnitFactionGroup("player") == "Horde" then
		CampaignOverview.backdrop.overlay:SetVertexColor(0.2, 0.1, 0.1)
	else
		CampaignOverview.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.2)
	end
	CampaignOverview.Header.Background:SetAlpha(0)
	CampaignOverview.Header.TopFiligree:Hide()

	do
		local frame = QuestScrollFrame.Contents.StoryHeader
		frame:CreateBackdrop("Overlay")
		frame.backdrop:SetPoint("TOPLEFT", 6, -9)
		frame.backdrop:SetPoint("BOTTOMRIGHT", -6, 11)
		frame.HighlightTexture:Hide()
		frame.Background:SetAlpha(0)
		frame.backdrop.overlay:SetVertexColor(1, 1, 1, 0.2)
	end

	QuestScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestScrollFrame, "TOPRIGHT", 4, -16)
	QuestScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestScrollFrame, "BOTTOMRIGHT", 4, 15)
	T.SkinScrollBar(QuestScrollFrame.ScrollBar)

	local QuestScrollFrameTopBorder = CreateFrame("Frame", "$parentBorder", QuestScrollFrame)
	QuestScrollFrameTopBorder:CreateBackdrop("Overlay")
	QuestScrollFrameTopBorder.backdrop:ClearAllPoints()
	QuestScrollFrameTopBorder.backdrop:SetSize(284, 23)
	QuestScrollFrameTopBorder.backdrop:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)

	local QuestScrollFrameTopBorder = CreateFrame("Frame", "$parentBorder", QuestMapFrame.CampaignOverview)
	QuestScrollFrameTopBorder:CreateBackdrop("Overlay")
	QuestScrollFrameTopBorder.backdrop:ClearAllPoints()
	QuestScrollFrameTopBorder.backdrop:SetSize(284, 23)
	QuestScrollFrameTopBorder.backdrop:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)

	QuestMapDetailsScrollFrame:SetPoint("TOPLEFT", 1, 0)
	QuestMapDetailsScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestMapDetailsScrollFrame, "TOPRIGHT", 0, -18)
	T.SkinScrollBar(QuestMapDetailsScrollFrame.ScrollBar)

	QuestMapFrame.Background:SetAlpha(0)

	QuestMapFrame.DetailsFrame:StripTextures()
	QuestMapFrame.DetailsFrame.RewardsFrame:StripTextures()

	QuestMapFrame.DetailsFrame.BackButton:SkinButton()
	QuestMapFrame.DetailsFrame.BackButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.BackButton:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)
	QuestMapFrame.DetailsFrame.BackButton:SetSize(284, 23)

	local AbandonButton = QuestMapFrame.DetailsFrame.AbandonButton
	AbandonButton:SkinButton()
	AbandonButton:ClearAllPoints()
	AbandonButton:SetPoint("BOTTOMLEFT", QuestMapFrame.backdrop, "BOTTOMLEFT", 4, 4)

	local TrackButton = QuestMapFrame.DetailsFrame.TrackButton
	TrackButton:SkinButton()
	TrackButton:SetSize(90, 22)
	TrackButton:ClearAllPoints()
	TrackButton:SetPoint("BOTTOMRIGHT", QuestMapFrame.backdrop, "BOTTOMRIGHT", -4, 4)

	local ShareButton = QuestMapFrame.DetailsFrame.ShareButton
	ShareButton:SkinButton(true)
	ShareButton:ClearAllPoints()
	ShareButton:SetPoint("LEFT", AbandonButton, "RIGHT", 3, 0)
	ShareButton:SetPoint("RIGHT", TrackButton, "LEFT", -3, 0)

	QuestMapFrame.DetailsFrame.CompleteQuestFrame:StripTextures()
	QuestMapFrame.DetailsFrame.CompleteQuestFrame.CompleteButton:SkinButton(true)
	QuestMapFrame.DetailsFrame.CompleteQuestFrame.CompleteButton:SetPoint("TOP", 0, 4)

	QuestModelScene:StripTextures()
	QuestModelScene:CreateBackdrop("Overlay")
	QuestModelScene.backdrop:SetBackdropColor(C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha)
	QuestNPCModelNameTooltipFrame:CreateBackdrop("Overlay")
	QuestNPCModelNameTooltipFrame.backdrop:SetBackdropColor(C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha)
	QuestNPCModelNameTooltipFrame.backdrop:SetPoint("TOPLEFT", QuestModelScene.backdrop, "BOTTOMLEFT", 0, -1)
	QuestNPCModelNameTooltipFrame.backdrop:SetPoint("TOPRIGHT", QuestModelScene.backdrop, "BOTTOMRIGHT", 0, -1)
	QuestNPCModelNameText:SetPoint("TOPLEFT", QuestNPCModelNameplate, 15, -15)
	QuestNPCModelNameText:SetPoint("BOTTOMRIGHT", QuestNPCModelNameplate, -15, 12)
	QuestNPCModelTextFrame:StripTextures()
	QuestNPCModelTextFrame:CreateBackdrop("Overlay")
	QuestNPCModelTextFrame.backdrop:SetBackdropColor(C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha)
	QuestNPCModelTextFrame.backdrop:SetPoint("TOPLEFT", QuestNPCModelNameTooltipFrame.backdrop, "BOTTOMLEFT", 0, -1)
	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, _, _, _, _, x, y)
		if parentFrame == QuestLogPopupDetailFrame or parentFrame == QuestFrame then
			x = x + 8
			y = y + 40

			QuestModelScene.backdrop.overlay:Hide()
			QuestNPCModelNameTooltipFrame.backdrop.overlay:Hide()
			QuestNPCModelTextFrame.backdrop.overlay:Hide()
		else
			QuestModelScene.backdrop.overlay:Show()
			QuestNPCModelNameTooltipFrame.backdrop.overlay:Show()
			QuestNPCModelTextFrame.backdrop.overlay:Show()
		end
		QuestModelScene:ClearAllPoints()
		QuestModelScene:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x, y)
	end)

	-- Quests Buttons
	for i = 1, 2 do
		local button = i == 1 and WorldMapFrame.SidePanelToggle.CloseButton or WorldMapFrame.SidePanelToggle.OpenButton
		local texture = i == 1 and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up"

		button:ClearAllPoints()
		button:SetPoint("BOTTOMRIGHT", -2, 2)
		button:SetSize(20, 20)
		button:StripTextures()
		button:SetTemplate("Default")
		button:StyleButton()

		button.icon = button:CreateTexture(nil, "BORDER")
		button.icon:SetTexture(texture)
		button.icon:SetTexCoord(0.3, 0.29, 0.3, 0.79, 0.65, 0.29, 0.65, 0.79)
		button.icon:ClearAllPoints()
		button.icon:SetPoint("TOPLEFT", 2, -2)
		button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	WorldMapFrame.NavBar:Hide()
	WorldMapFrame.BorderFrame.TitleText:ClearAllPoints()
	WorldMapFrame.BorderFrame.TitleText:SetPoint("CENTER", WorldMapFrame.Header)

	T.SkinCloseButton(WorldMapFrameCloseButton)
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("RIGHT", WorldMapFrame.Header, "RIGHT", -4, 0)
	WorldMapFrameCloseButton:SetSize(15, 15)

	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MaximizeButton:Kill()
	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:Kill()

	-- Floor Dropdown
	local function WorldMapFloorNavigationDropDown(frame)
		T.SkinDropDownBox(frame)
		frame:SetPoint("TOPLEFT", -15, -67)
	end

	-- Tracking Button
	local function WorldMapTrackingOptionsButton(button)
		local shadow = button:GetRegions()
		shadow:Hide()

		button.Background:Hide()
		button.IconOverlay:SetAlpha(0)
		button.Border:Hide()

		local tex = button:GetHighlightTexture()
		tex:SetTexture([[Interface\Minimap\Tracking\None]], "ADD")
		tex:SetAllPoints(button.Icon)
	end

	-- Tracking Pin
	local function WorldMapTrackingPinButton(button)
		local shadow = button:GetRegions()
		shadow:Hide()

		button.Background:Hide()
		button.IconOverlay:SetAlpha(0)
		button.Border:Hide()

		local tex = button:GetHighlightTexture()
		tex:SetAtlas("Waypoint-MapPin-Untracked")
		tex:SetAllPoints(button.Icon)
	end

	-- Elements
	WorldMapFloorNavigationDropDown(WorldMapFrame.overlayFrames[1])
	WorldMapTrackingOptionsButton(WorldMapFrame.overlayFrames[2])
	WorldMapTrackingPinButton(WorldMapFrame.overlayFrames[3])

	-- QuestSessionManagement skin (based on skin from Aurora)
	QuestMapFrame.QuestSessionManagement:StripTextures()

	local ExecuteSessionCommand = QuestMapFrame.QuestSessionManagement.ExecuteSessionCommand
	ExecuteSessionCommand:SetTemplate("Default")
	ExecuteSessionCommand:StyleButton()

	local icon = ExecuteSessionCommand:CreateTexture(nil, "ARTWORK")
	icon:SetPoint("TOPLEFT", 0, 0)
	icon:SetPoint("BOTTOMRIGHT", 0, 0)
	ExecuteSessionCommand.normalIcon = icon

	local sessionCommandToButtonAtlas = { -- Skin from Aurora
		[_G.Enum.QuestSessionCommand.Start] = "QuestSharing-DialogIcon",
		[_G.Enum.QuestSessionCommand.Stop] = "QuestSharing-Stop-DialogIcon"
	}

	hooksecurefunc(QuestMapFrame.QuestSessionManagement, "UpdateExecuteCommandAtlases", function(self, command)
		self.ExecuteSessionCommand:SetNormalTexture("")
		self.ExecuteSessionCommand:SetPushedTexture("")
		self.ExecuteSessionCommand:SetDisabledTexture("")

		local atlas = sessionCommandToButtonAtlas[command]
		if atlas then
			self.ExecuteSessionCommand.normalIcon:SetAtlas(atlas)
		end
	end)

	hooksecurefunc(QuestSessionManager, "NotifyDialogShow", function(_, dialog)
		if not dialog.isSkinned then
			dialog:StripTextures()
			dialog:SetTemplate("Transparent")
			dialog.ButtonContainer.Confirm:SkinButton()
			dialog.ButtonContainer.Decline:SkinButton()
			if dialog.MinimizeButton then
				T.SkinCloseButton(dialog.MinimizeButton, nil, "-")
			end
			dialog.isSkinned = true
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)