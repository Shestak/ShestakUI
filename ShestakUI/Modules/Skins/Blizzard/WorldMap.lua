local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

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
	QuestScrollFrame:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 4, 0)
	QuestScrollFrame.DetailFrame:StripTextures()
	QuestScrollFrame.Background:SetAlpha(0)
	QuestScrollFrame.Contents.Separator.Divider:Hide()
	QuestScrollFrame:SetSize(259, 463)

	local questHeader = {
		QuestScrollFrame.Contents.WarCampaignHeader,
		QuestScrollFrame.Contents.StoryHeader
	}

	for i = 1, #questHeader do
		local frame = questHeader[i]
		frame:CreateBackdrop("Overlay")
		frame.backdrop:SetPoint("TOPLEFT", 6, -2)
		frame.backdrop:SetPoint("BOTTOMRIGHT", -6, 2)
		frame.HighlightTexture:Hide()
		frame.Background:Hide()
		if i == 1 then -- WarCampaignHeader
			if UnitFactionGroup("player") == "Horde" then
				frame.backdrop.overlay:SetVertexColor(0.2, 0.1, 0.1)
			else
				frame.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.2)
			end
		else -- StoryHeader
			frame.backdrop.overlay:SetVertexColor(1, 1, 1, 0.2)
		end
	end

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