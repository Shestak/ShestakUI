local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	WorldMap skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsAddOnLoaded("Mapster") then return end

	local SmallerMap = GetCVarBool("miniWorldMap")
	if not SmallerMap then
		ToggleWorldMap()
		WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:Click()
		ToggleWorldMap()
	end

	WorldMapFrame:StripTextures()
	WorldMapFrame:CreateBackdrop("Default")
	WorldMapFrame.backdrop:ClearAllPoints()
	WorldMapFrame.backdrop:SetSize(700, 468)
	WorldMapFrame.backdrop:SetPoint("TOPLEFT", 1, -66)
	WorldMapFrame.Header = CreateFrame("Frame", nil, WorldMapFrame)
	WorldMapFrame.Header:SetSize(WorldMapFrame.backdrop:GetWidth(), 23)
	WorldMapFrame.Header:SetPoint("BOTTOMLEFT", WorldMapFrame.backdrop, "TOPLEFT", 0, 2)
	WorldMapFrame.Header:SetTemplate("Overlay")

	WorldMapFrame.BorderFrame:StripTextures()
	--BETA WorldMapFrame.BorderFrame.Inset:StripTextures()
	QuestMapFrame.DetailsFrame:StripTextures()
	QuestMapFrame.DetailsFrame.RewardsFrame:StripTextures()
	--BETA QuestScrollFrame.Contents.StoryHeader.Shadow:Hide()
	QuestMapFrame:StripTextures()

	QuestMapFrame:CreateBackdrop("Overlay")
	QuestMapFrame.backdrop:ClearAllPoints()
	QuestMapFrame.backdrop:SetSize(284, 468)
	QuestMapFrame.backdrop:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 2, 0)

	WorldMapFrame.BorderFrame.Tutorial:Kill()

	QuestScrollFrame:ClearAllPoints()
	QuestScrollFrame:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 4, 0)
	QuestScrollFrame.DetailFrame:StripTextures()
	QuestScrollFrame.Background:SetAlpha(0)
	QuestScrollFrame.Contents.Separator.Divider:Hide()
	QuestScrollFrame:SetSize(259, 463)

	QuestScrollFrame.Contents.WarCampaignHeader:CreateBackdrop("Overlay")
	QuestScrollFrame.Contents.WarCampaignHeader.backdrop:SetPoint("TOPLEFT", 2, -2)
	QuestScrollFrame.Contents.WarCampaignHeader.backdrop:SetPoint("BOTTOMRIGHT", -6, 2)
	QuestScrollFrame.Contents.WarCampaignHeader.HighlightTexture:Hide()
	QuestScrollFrame.Contents.WarCampaignHeader.Background:Hide()

	QuestScrollFrame.Contents.StoryHeader:CreateBackdrop("Overlay")
	QuestScrollFrame.Contents.StoryHeader.backdrop:SetPoint("TOPLEFT", 2, -2)
	QuestScrollFrame.Contents.StoryHeader.backdrop:SetPoint("BOTTOMRIGHT", -6, 2)
	QuestScrollFrame.Contents.StoryHeader.HighlightTexture:Hide()
	QuestScrollFrame.Contents.StoryHeader.Background:Hide()

	QuestScrollFrameScrollBar:SetPoint("TOPLEFT", QuestScrollFrame, "TOPRIGHT", 4, -16)
	QuestScrollFrameScrollBar:SetPoint("BOTTOMLEFT", QuestScrollFrame, "BOTTOMRIGHT", 4, 15)
	T.SkinScrollBar(QuestScrollFrameScrollBar)

	local QuestScrollFrameTopBorder = CreateFrame("Frame", "$parentBorder", QuestScrollFrame)
	QuestScrollFrameTopBorder:CreateBackdrop("Overlay")
	QuestScrollFrameTopBorder.backdrop:ClearAllPoints()
	QuestScrollFrameTopBorder.backdrop:SetSize(284, 23)
	QuestScrollFrameTopBorder.backdrop:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)

	QuestMapDetailsScrollFrameScrollBar:SetPoint("TOPLEFT", QuestMapDetailsScrollFrame, "TOPRIGHT", 0, -18)
	T.SkinScrollBar(QuestMapDetailsScrollFrameScrollBar)

	QuestMapFrame.DetailsFrame.BackButton:SkinButton()
	QuestMapFrame.DetailsFrame.BackButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.BackButton:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)
	QuestMapFrame.DetailsFrame.BackButton:SetSize(284, 23)

	QuestMapFrame.DetailsFrame.AbandonButton:SkinButton()
	QuestMapFrame.DetailsFrame.AbandonButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.AbandonButton:SetPoint("BOTTOMLEFT", QuestMapFrame.backdrop, "BOTTOMLEFT", 4, 4)

	QuestMapFrame.DetailsFrame.TrackButton:SkinButton()
	QuestMapFrame.DetailsFrame.TrackButton:SetSize(90, 22)
	QuestMapFrame.DetailsFrame.TrackButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.TrackButton:SetPoint("BOTTOMRIGHT", QuestMapFrame.backdrop, "BOTTOMRIGHT", -4, 4)

	QuestMapFrame.DetailsFrame.ShareButton:SkinButton(true)
	QuestMapFrame.DetailsFrame.ShareButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.ShareButton:SetPoint("LEFT", QuestMapFrame.DetailsFrame.AbandonButton, "RIGHT", 3, 0)
	QuestMapFrame.DetailsFrame.ShareButton:SetPoint("RIGHT", QuestMapFrame.DetailsFrame.TrackButton, "LEFT", -3, 0)

	QuestMapFrame.DetailsFrame.CompleteQuestFrame:StripTextures()
	QuestMapFrame.DetailsFrame.CompleteQuestFrame.CompleteButton:SkinButton(true)
	QuestMapFrame.DetailsFrame.CompleteQuestFrame.CompleteButton:SetPoint("TOP", 0, 4)

	QuestNPCModel:StripTextures()
	QuestNPCModel:CreateBackdrop("Transparent")
	QuestNPCModelTextFrame:StripTextures()
	QuestNPCModelTextFrame:CreateBackdrop("Overlay")
	QuestNPCModelTextFrame.backdrop:SetPoint("TOPLEFT", QuestNPCModel.backdrop, "BOTTOMLEFT", 0, -1)
	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, _, _, _, _, x, y)
		if parentFrame == QuestLogPopupDetailFrame or parentFrame == QuestFrame then
			x = x + 8
			y = y + 40
		end
		QuestNPCModel:ClearAllPoints()
		QuestNPCModel:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x, y)
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

	-- Bounty Board
	local function WorldMapBountyBoard(frame)
		frame.BountyName:SetFont(C.media.normal_font, 16)
		frame.BountyName:SetShadowOffset(1, -1)

		T.SkinCloseButton(frame.TutorialBox.CloseButton)
		frame.TutorialBox:StripTextures()
		frame.TutorialBox.Arrow:Hide()
		frame.TutorialBox:CreateBackdrop("Transparent")
	end

	-- Elements
	WorldMapFloorNavigationDropDown(WorldMapFrame.overlayFrames[1])
	WorldMapTrackingOptionsButton(WorldMapFrame.overlayFrames[2])
	WorldMapBountyBoard(WorldMapFrame.overlayFrames[3])
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)