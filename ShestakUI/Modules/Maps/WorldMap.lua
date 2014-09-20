local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Floors scroll
----------------------------------------------------------------------------------------
--WoD WorldMapButton:SetScript("OnMouseWheel", function(self, delta)
	-- local level = GetCurrentMapDungeonLevel() - delta
	-- if level >= 1 and level <= GetNumDungeonMapLevels() then
		-- SetDungeonMapLevel(level)
		-- PlaySound("UChatScrollButton")
	-- end
-- end)

----------------------------------------------------------------------------------------
--	WorldMap style(m_Map by Monolit)
----------------------------------------------------------------------------------------
local _G = _G
local WorldMap = CreateFrame("Frame")

WorldMap.QuestTexts = {
	QuestInfoTitleHeader,
	QuestInfoDescriptionHeader,
	QuestInfoObjectivesHeader,
	QuestInfoRewardsFrame.Header,
	QuestInfoDescriptionText,
	QuestInfoObjectivesText,
	QuestInfoGroupSize,
	QuestInfoRewardText,
	QuestInfoRewardsFrame.ItemChooseText,
	QuestInfoRewardsFrame.ItemReceiveText,
	QuestInfoRewardsFrame.SpellLearnText,
	QuestInfoRewardsFrame.PlayerTitleText,
	QuestInfoRewardsFrame.XPFrame.ReceiveText,
}

function WorldMap:ColorQuestText()
	for _, Text in pairs(WorldMap.QuestTexts) do Text:SetTextColor(1, 1, 1) end

	local Objectives = QuestInfoObjectivesFrame.Objectives

	for i = 1, #Objectives do
		local Objective = _G["QuestInfoObjective"..i]
		local Completed = select(3, GetQuestLogLeaderBoard(i))

		if Completed then Objective:SetTextColor(0, 1, 0) else Objective:SetTextColor(1, 0, 0) end
	end
end

function WorldMap:SkinReward(i)
	local Reward = _G[self:GetName().."QuestInfoItem"..i]
	local Texture = Reward.Icon:GetTexture()

	Reward:StripTextures()
	Reward:StyleButton()
	Reward:CreateBackdrop("Default")
	Reward.Icon:SetTexture(Texture)
	Reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Reward.backdrop:ClearAllPoints()
	Reward.backdrop:SetPoint("TOPLEFT", Reward.Icon, -2, 2)
	Reward.backdrop:SetPoint("BOTTOMRIGHT", Reward.Icon, 2, -2)

end

function WorldMap:Skin()
	local Map = WorldMapFrame
	local QuestScroll = QuestScrollFrame
	local Navigation = WorldMapFrameNavBar
	local TutorialButton = WorldMapFrameTutorialButton
	local TitleButton = WorldMapTitleButton
	local ViewAllButton = QuestScrollFrame.ViewAll
	local BackButton = QuestMapFrame.DetailsFrame.BackButton
	local AbandonButton = QuestMapFrame.DetailsFrame.AbandonButton
	local ShareButton = QuestMapFrame.DetailsFrame.ShareButton
	local TrackButton = QuestMapFrame.DetailsFrame.TrackButton
	local ScrollBar = QuestScrollFrame.ScrollBar
	local Title = WorldMapFrame.BorderFrame.TitleText
	local CloseButton = WorldMapFrameCloseButton
	local SizeButton = WorldMapFrameSizeUpButton
	local RewardsInfo = MapQuestInfoRewardsFrame
	local Money = MapQuestInfoRewardsFrame.MoneyFrame
	local XP = MapQuestInfoRewardsFrame.XPFrame
	local QuestBackground = QuestScrollFrame.Background
	local StoryTooltip = QuestScrollFrame.StoryTooltip
	local MapDetails = WorldMapDetailFrame
	local TrackingMenuButton = WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Button
	local TrackingMenuBackground = WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Background
	local DetailsScroll = QuestMapDetailsScrollFrame
	local WMDropDown = WorldMapLevelDropDown

	Map:StripTextures()
	Map:CreateBackdrop("Default")
	Map.backdrop:ClearAllPoints()
	Map.backdrop:SetSize(701, 470)
	Map.backdrop:SetPoint("TOPLEFT", 0, -66)
	Map.Header = CreateFrame("Frame", nil, Map)
	Map.Header:SetSize(Map.backdrop:GetWidth(), 23)
	Map.Header:SetPoint("BOTTOMLEFT", Map.backdrop, "TOPLEFT", 0, 2)
	Map.Header:SetTemplate("Overlay")

	WorldMapFrame.BorderFrame:StripTextures()
	WorldMapFrame.BorderFrame.Inset:StripTextures()
	QuestMapFrame.DetailsFrame:StripTextures()
	QuestMapFrame.DetailsFrame.RewardsFrame:StripTextures()
	QuestScrollFrame.Contents.StoryHeader:StripTextures()
	QuestMapFrame:StripTextures()

	QuestBackground:SetAlpha(0)

	TutorialButton:Kill()
	TrackingMenuButton:SetAlpha(0)
	TrackingMenuBackground:SetAlpha(0)

	QuestScroll:CreateBackdrop("Overlay")
	QuestScroll.backdrop:ClearAllPoints()
	QuestScroll.backdrop:SetSize(299, 470)
	QuestScroll.backdrop:SetPoint("LEFT", Map.backdrop, "RIGHT", 2, 0)
	T.SkinScrollBar(QuestScrollFrameScrollBar)

	DetailsScroll:CreateBackdrop("Overlay")
	DetailsScroll.backdrop:SetAllPoints(QuestScroll.backdrop)
	DetailsScroll.backdrop:ClearAllPoints()
	DetailsScroll.backdrop:SetSize(299, 470)
	DetailsScroll.backdrop:SetPoint("LEFT", Map.backdrop, "RIGHT", 2, 0)
	T.SkinScrollBar(QuestMapDetailsScrollFrameScrollBar)

	ViewAllButton:SkinButton()
	ViewAllButton:ClearAllPoints()
	ViewAllButton:SetPoint("LEFT", Map.Header, "RIGHT", 2, 0)
	ViewAllButton:SetSize(299, 23)

	BackButton:SkinButton()
	BackButton:ClearAllPoints()
	BackButton:SetPoint("LEFT", Map.Header, "RIGHT", 2, 0)
	BackButton:SetSize(299, 23)

	AbandonButton:SkinButton()
	AbandonButton:ClearAllPoints()
	AbandonButton:SetPoint("BOTTOMLEFT", QuestScroll.backdrop, "BOTTOMLEFT", 3, 3)

	select(6, ShareButton:GetRegions()):Hide()
	select(7, ShareButton:GetRegions()):Hide()
	ShareButton:SkinButton()
	TrackButton:SkinButton()

	QuestNPCModel:StripTextures()
	QuestNPCModel:CreateBackdrop("Transparent")
	QuestNPCModel:ClearAllPoints()
	QuestNPCModel:SetPoint("TOPLEFT", BackButton, "TOPRIGHT", 2, -2)
	QuestNPCModelTextFrame:StripTextures()
	QuestNPCModelTextFrame:CreateBackdrop("Default")
	QuestNPCModelTextFrame.backdrop:SetPoint("TOPLEFT", QuestNPCModel.backdrop, "BOTTOMLEFT", 0, -2)
	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, portrait, text, name, x, y)
		QuestNPCModel:ClearAllPoints()
		QuestNPCModel:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x + 16, y)
	end)

	-- Quests Buttons
	for i = 1, 2 do
		local Button = i == 1 and WorldMapFrame.UIElementsFrame.OpenQuestPanelButton or WorldMapFrame.UIElementsFrame.CloseQuestPanelButton
		local Text = (i == 1 and QUESTS_LABEL.." ->") or ("<- "..QUESTS_LABEL)

		Button:ClearAllPoints()
		Button:SetPoint("BOTTOMRIGHT", -3, 3)
		Button:SetSize(100, 23)
		Button:SkinButton()
		Button.Text = Button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		Button.Text:SetPoint("CENTER")
		Button.Text:SetText(Text)
	end

	Navigation:Hide()
	TitleButton:ClearAllPoints()
	TitleButton:SetAllPoints(Map.Header)
	Title:ClearAllPoints()
	Title:SetPoint("CENTER", Map.Header)

	T.SkinCloseButton(CloseButton)
	CloseButton:ClearAllPoints()
	CloseButton:SetPoint("RIGHT", Map.Header, "RIGHT", -4, 0)
	CloseButton:SetSize(15, 15)

	SizeButton:Kill()
	ScrollBar:Hide()

	Money:StripTextures()
	Money:CreateBackdrop("Default")
	Money.Icon:SetTexture("Interface\\Icons\\inv_misc_coin_01")
	Money.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Money.backdrop:ClearAllPoints()
	Money.backdrop:SetPoint("TOPLEFT", Money.Icon, -2, 2)
	Money.backdrop:SetPoint("BOTTOMRIGHT", Money.Icon, 2, -2)

	XP:StripTextures()
	XP:CreateBackdrop("Default")
	XP.Icon:SetTexture("Interface\\Icons\\XP_Icon")
	XP.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	XP.backdrop:ClearAllPoints()
	XP.backdrop:SetPoint("TOPLEFT", XP.Icon, -2, 2)
	XP.backdrop:SetPoint("BOTTOMRIGHT", XP.Icon, 2, -2)

	T.SkinDropDownBox(WMDropDown)
	WMDropDown:ClearAllPoints()
	WMDropDown:SetPoint("TOPLEFT", -18, -2)

	WorldMapFrameAreaLabel:SetFont(C.media.normal_font, 30)
	WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
	WorldMapFrameAreaLabel:SetTextColor(0.9, 0.83, 0.64)

	WorldMapFrameAreaPetLevels:SetFont(C.media.normal_font, 30)
	WorldMapFrameAreaPetLevels:SetShadowOffset(2, -2)

	WorldMapFrameAreaDescription:SetFont(C.media.normal_font, 30)
	WorldMapFrameAreaDescription:SetShadowOffset(2, -2)
end

----------------------------------------------------------------------------------------
--	Creating coords
----------------------------------------------------------------------------------------
function WorldMap:Coords()
	local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
	coords:SetFrameLevel(90)
	coords.PlayerText = coords:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	coords.PlayerText:SetPoint("BOTTOMLEFT", WorldMapFrame.UIElementsFrame, "BOTTOMLEFT", 5, 5)
	coords.PlayerText:SetJustifyH("LEFT")
	coords.PlayerText:SetText(UnitName("player")..": 0,0")

	coords.MouseText = coords:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	coords.MouseText:SetJustifyH("LEFT")
	coords.MouseText:SetPoint("BOTTOMLEFT", coords.PlayerText, "TOPLEFT", 0, 5)
	coords.MouseText:SetText(L_MAP_CURSOR..": 0,0")

	local int = 0
	WorldMapFrame:HookScript("OnUpdate", function(self, elapsed)
		int = int + 1
		if int >= 3 then
			local x, y = GetPlayerMapPosition("player")
			x = math.floor(100 * x)
			y = math.floor(100 * y)
			if x ~= 0 and y ~= 0 then
				coords.PlayerText:SetText(UnitName("player")..": "..x..","..y)
			else
				coords.PlayerText:SetText(UnitName("player")..": ".."|cffff0000"..L_MAP_BOUNDS.."|r")
			end

			local scale = WorldMapDetailFrame:GetEffectiveScale()
			local width = WorldMapDetailFrame:GetWidth()
			local height = WorldMapDetailFrame:GetHeight()
			local centerX, centerY = WorldMapDetailFrame:GetCenter()
			local x, y = GetCursorPosition()
			local adjustedX = (x / scale - (centerX - (width/2))) / width
			local adjustedY = (centerY + (height/2) - y / scale) / height

			if adjustedX >= 0  and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1 then
				adjustedX = math.floor(100 * adjustedX)
				adjustedY = math.floor(100 * adjustedY)
				coords.MouseText:SetText(L_MAP_CURSOR..adjustedX..","..adjustedY)
			else
				coords.MouseText:SetText(L_MAP_CURSOR.."|cffff0000"..L_MAP_BOUNDS.."|r")
			end
			int = 0
		end
	end)
end

function WorldMap:AddHooks()
	hooksecurefunc("QuestInfo_Display", self.ColorQuestText)
	hooksecurefunc("QuestInfo_GetRewardButton", self.SkinReward)
end

function WorldMap:Enable()
	local SmallerMap = GetCVarBool("miniWorldMap")

	if not SmallerMap then
		ToggleWorldMap()
		WorldMapFrameSizeUpButton:Click()
		ToggleWorldMap()
	end
	self:Skin()
	self:Coords()
	self:AddHooks()
end

WorldMap:RegisterEvent("ADDON_LOADED")
WorldMap:RegisterEvent("PLAYER_ENTERING_WORLD")
WorldMap:SetScript("OnEvent", function(self, event, ...)
	if C.map.enable ~= true or IsAddOnLoaded("Aurora") then return end
	WorldMap:Enable()
end)