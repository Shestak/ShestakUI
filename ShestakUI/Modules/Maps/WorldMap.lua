local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Floors scroll
----------------------------------------------------------------------------------------
WorldMapButton:SetScript("OnMouseWheel", function(self, delta)
	local level = GetCurrentMapDungeonLevel() - delta
	if level >= 1 then
		SetDungeonMapLevel(level)
		PlaySound("UChatScrollButton")
	end
end)

----------------------------------------------------------------------------------------
--	WorldMap style(m_Map by Monolit)
----------------------------------------------------------------------------------------
hooksecurefunc("WorldMap_ToggleSizeDown", function()
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
end)

local SmallerMap = GetCVarBool("miniWorldMap")
if not SmallerMap then
	ToggleWorldMap()
	WorldMapFrameSizeUpButton:Click()
	ToggleWorldMap()
end

local QuestTexts = {
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

local function SkinReward(frame, index)
	local Reward = _G[frame:GetName().."QuestInfoItem"..index]
	local Texture = Reward.Icon:GetTexture()

	Reward:StripTextures()
	Reward:CreateBackdrop("Default")
	Reward.Icon:SetTexture(Texture)
	Reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Reward.backdrop:ClearAllPoints()
	Reward.backdrop:SetPoint("TOPLEFT", Reward.Icon, -2, 2)
	Reward.backdrop:SetPoint("BOTTOMRIGHT", Reward.Icon, 2, -2)
end

hooksecurefunc("QuestInfo_GetRewardButton", SkinReward)

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
QuestScrollFrame.Contents.StoryHeader:StripTextures()
QuestMapFrame:StripTextures()

QuestScrollFrame.Background:SetAlpha(0)

WorldMapFrameTutorialButton:Kill()
WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Button:SetAlpha(0)
WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Background:SetAlpha(0)

QuestScrollFrame:CreateBackdrop("Overlay")
QuestScrollFrame.backdrop:ClearAllPoints()
QuestScrollFrame.backdrop:SetSize(284, 468)
QuestScrollFrame.backdrop:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 2, 0)
T.SkinScrollBar(QuestScrollFrameScrollBar)

QuestMapDetailsScrollFrame:CreateBackdrop("Overlay")
QuestMapDetailsScrollFrame.backdrop:SetAllPoints(QuestScrollFrame.backdrop)
QuestMapDetailsScrollFrame.backdrop:ClearAllPoints()
QuestMapDetailsScrollFrame.backdrop:SetSize(284, 470)
QuestMapDetailsScrollFrame.backdrop:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 2, 0)
T.SkinScrollBar(QuestMapDetailsScrollFrameScrollBar)

QuestScrollFrame.ViewAll:SkinButton()
QuestScrollFrame.ViewAll:ClearAllPoints()
QuestScrollFrame.ViewAll:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)
QuestScrollFrame.ViewAll:SetSize(284, 23)

QuestMapFrame.DetailsFrame.BackButton:SkinButton()
QuestMapFrame.DetailsFrame.BackButton:ClearAllPoints()
QuestMapFrame.DetailsFrame.BackButton:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)
QuestMapFrame.DetailsFrame.BackButton:SetSize(284, 23)

QuestMapFrame.DetailsFrame.AbandonButton:SkinButton()
QuestMapFrame.DetailsFrame.AbandonButton:ClearAllPoints()
QuestMapFrame.DetailsFrame.AbandonButton:SetPoint("BOTTOMLEFT", QuestScrollFrame.backdrop, "BOTTOMLEFT", 4, 4)

QuestMapFrame.DetailsFrame.TrackButton:SkinButton()
QuestMapFrame.DetailsFrame.TrackButton:SetSize(75, 22)
QuestMapFrame.DetailsFrame.TrackButton:ClearAllPoints()
QuestMapFrame.DetailsFrame.TrackButton:SetPoint("BOTTOMRIGHT", QuestScrollFrame.backdrop, "BOTTOMRIGHT", -4, 4)

QuestMapFrame.DetailsFrame.ShareButton:SkinButton(true)
QuestMapFrame.DetailsFrame.ShareButton:ClearAllPoints()
QuestMapFrame.DetailsFrame.ShareButton:SetPoint("LEFT", QuestMapFrame.DetailsFrame.AbandonButton, "RIGHT", 3, 0)
QuestMapFrame.DetailsFrame.ShareButton:SetPoint("RIGHT", QuestMapFrame.DetailsFrame.TrackButton, "LEFT", -3, 0)

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
	local texture = (i == 1 and "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up") or ("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")

	button:ClearAllPoints()
	button:SetPoint("BOTTOMRIGHT", -2, 2)
	button:SetSize(20, 20)
	button:StripTextures()
	button:SetTemplate("Default")
	button:StyleButton()

	button.icon = button:CreateTexture(nil, "BORDER")
	button.icon:SetTexture(texture)
	button.icon:SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
	button.icon:ClearAllPoints()
	button.icon:SetPoint("TOPLEFT", 2, -2)
	button.icon:SetPoint("BOTTOMRIGHT", -2, -1)
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

WorldMapFrameSizeUpButton:Kill()

MapQuestInfoRewardsFrame.MoneyFrame:StripTextures()
MapQuestInfoRewardsFrame.MoneyFrame:CreateBackdrop("Default")
MapQuestInfoRewardsFrame.MoneyFrame.Icon:SetTexture("Interface\\Icons\\inv_misc_coin_01")
MapQuestInfoRewardsFrame.MoneyFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
MapQuestInfoRewardsFrame.MoneyFrame.backdrop:ClearAllPoints()
MapQuestInfoRewardsFrame.MoneyFrame.backdrop:SetPoint("TOPLEFT", MapQuestInfoRewardsFrame.MoneyFrame.Icon, -2, 2)
MapQuestInfoRewardsFrame.MoneyFrame.backdrop:SetPoint("BOTTOMRIGHT", MapQuestInfoRewardsFrame.MoneyFrame.Icon, 2, -2)

MapQuestInfoRewardsFrame.XPFrame:StripTextures()
MapQuestInfoRewardsFrame.XPFrame:CreateBackdrop("Default")
MapQuestInfoRewardsFrame.XPFrame.Icon:SetTexture("Interface\\Icons\\XP_Icon")
MapQuestInfoRewardsFrame.XPFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
MapQuestInfoRewardsFrame.XPFrame.backdrop:ClearAllPoints()
MapQuestInfoRewardsFrame.XPFrame.backdrop:SetPoint("TOPLEFT", MapQuestInfoRewardsFrame.XPFrame.Icon, -2, 2)
MapQuestInfoRewardsFrame.XPFrame.backdrop:SetPoint("BOTTOMRIGHT", MapQuestInfoRewardsFrame.XPFrame.Icon, 2, -2)

T.SkinDropDownBox(WorldMapLevelDropDown)
WorldMapLevelDropDown:ClearAllPoints()
WorldMapLevelDropDown:SetPoint("TOPLEFT", -18, -2)

WorldMapFrameAreaLabel:SetFont(C.media.normal_font, 30)
WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
WorldMapFrameAreaLabel:SetTextColor(0.9, 0.83, 0.64)

WorldMapFrameAreaPetLevels:SetFont(C.media.normal_font, 30)
WorldMapFrameAreaPetLevels:SetShadowOffset(2, -2)

WorldMapFrameAreaDescription:SetFont(C.media.normal_font, 30)
WorldMapFrameAreaDescription:SetShadowOffset(2, -2)

----------------------------------------------------------------------------------------
--	Creating coords
----------------------------------------------------------------------------------------
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