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
	WorldMapFrame.BorderFrame.Inset:StripTextures()
	QuestMapFrame.DetailsFrame:StripTextures()
	QuestMapFrame.DetailsFrame.RewardsFrame:StripTextures()
	QuestScrollFrame.Contents.StoryHeader.HighlightTexture:Hide()
	QuestScrollFrame.Contents.StoryHeader.Background:Hide()
	QuestScrollFrame.Contents.StoryHeader.Shadow:Hide()
	QuestMapFrame:StripTextures()

	QuestScrollFrame.Background:SetAlpha(0)

	WorldMapFrameTutorialButton:Kill()

	local TrackingOptions = WorldMapFrame.UIElementsFrame.TrackingOptionsButton
	TrackingOptions.Button:SetAlpha(0)
	TrackingOptions.Background:SetAlpha(0)
	TrackingOptions.IconOverlay:SetTexture("")

	QuestScrollFrame:ClearAllPoints()
	QuestScrollFrame:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 4, 0)
	QuestMapFrame:CreateBackdrop("Overlay")
	QuestMapFrame.backdrop:ClearAllPoints()
	QuestMapFrame.backdrop:SetSize(284, 468)
	QuestMapFrame.backdrop:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 2, 0)
	QuestScrollFrameScrollBar:SetPoint("TOPLEFT", QuestScrollFrame, "TOPRIGHT", 4, -16)
	T.SkinScrollBar(QuestScrollFrameScrollBar)

	local QuestScrollFrameTopBorder = CreateFrame("Frame", "$parentBorder", QuestScrollFrame)
	QuestScrollFrameTopBorder:CreateBackdrop("Overlay")
	QuestScrollFrameTopBorder.backdrop:ClearAllPoints()
	QuestScrollFrameTopBorder.backdrop:SetSize(284, 23)
	QuestScrollFrameTopBorder.backdrop:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)

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
	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, _, _, _, x, y)
		if parentFrame == QuestLogPopupDetailFrame or parentFrame == QuestFrame then
			x = x + 8
			y = y + 40
		elseif parentFrame == QuestFrame then
			x = x + 3
		end
		QuestNPCModel:ClearAllPoints()
		QuestNPCModel:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x, y)
	end)

	-- Quests Buttons
	for i = 1, 2 do
		local button = i == 1 and WorldMapFrame.UIElementsFrame.OpenQuestPanelButton or WorldMapFrame.UIElementsFrame.CloseQuestPanelButton
		local texture = i == 1 and "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up" or "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up"

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

	WorldMapFrameNavBar:Hide()
	WorldMapTitleButton:ClearAllPoints()
	WorldMapTitleButton:SetAllPoints(WorldMapFrame.Header)
	WorldMapFrame.BorderFrame.TitleText:ClearAllPoints()
	WorldMapFrame.BorderFrame.TitleText:SetPoint("CENTER", WorldMapFrame.Header)

	T.SkinCloseButton(WorldMapFrameCloseButton)
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("RIGHT", WorldMapFrame.Header, "RIGHT", -4, 0)
	WorldMapFrameCloseButton:SetSize(15, 15)
	
	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MaximizeButton:Kill()
	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:Kill()

	T.SkinDropDownBox(WorldMapLevelDropDown)
	WorldMapLevelDropDown:ClearAllPoints()
	WorldMapLevelDropDown:SetPoint("TOPLEFT", -18, -2)
	
	T.SkinCloseButton(WorldMapFrame.UIElementsFrame.BountyBoard.TutorialBox.CloseButton)
	WorldMapFrame.UIElementsFrame.BountyBoard.TutorialBox:StripTextures()
	WorldMapFrame.UIElementsFrame.BountyBoard.TutorialBox.Arrow:Hide()
	WorldMapFrame.UIElementsFrame.BountyBoard.TutorialBox:CreateBackdrop("Transparent")
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
