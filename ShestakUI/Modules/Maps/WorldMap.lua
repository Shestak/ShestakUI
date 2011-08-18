local T, C, L = unpack(select(2, ...))
if not C.map.enable == true then return end

----------------------------------------------------------------------------------------
--	WorldMap style(m_Map by Monolit)
----------------------------------------------------------------------------------------
WORLDMAP_WINDOWED_SIZE = C.map.scale
local mapscale = WORLDMAP_WINDOWED_SIZE

local mapbg = CreateFrame("Frame", nil, WorldMapDetailFrame)
mapbg:SetTemplate("ClassColor")

-- Create move button for map
local movebutton = CreateFrame("Frame", nil, WorldMapFrameSizeUpButton)
movebutton:Height(32)
movebutton:Width(32)
movebutton:Point("TOP", WorldMapFrameSizeUpButton, "BOTTOM", -1, 4)
movebutton:SetBackdrop({bgFile = "Interface\\AddOns\\ShestakUI\\Media\\Textures\\Cross.tga"})
movebutton:EnableMouse(true)

movebutton:SetScript("OnMouseDown", function()
	local maplock = GetCVar("advancedWorldMap")
	if maplock ~= "1" or InCombatLockdown() then return end
	WorldMapScreenAnchor:ClearAllPoints()
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:StartMoving()
	WorldMapBlobFrame:Hide()
end)

movebutton:SetScript("OnMouseUp", function()
	local maplock = GetCVar("advancedWorldMap")
	if maplock ~= "1" or InCombatLockdown() then return end
	WorldMapFrame:StopMovingOrSizing()
	WorldMapScreenAnchor:StartMoving()
	WorldMapScreenAnchor:StopMovingOrSizing()
	WorldMapBlobFrame:Show()
	WorldMapFrame:Hide()
	WorldMapFrame:Show()
end)

local SmallerMap = GetCVarBool("miniWorldMap")
if SmallerMap == nil then
	SetCVar("miniWorldMap", 1)
end

local MoveMap = GetCVarBool("advancedWorldMap")
if MoveMap == nil then
	SetCVar("advancedWorldMap", 1)
end

-- Styling World Map
local SmallerMapSkin = function()
	mapbg:SetScale(1 / mapscale)
	mapbg:Point("TOPLEFT", WorldMapDetailFrame, -2, 2)
	mapbg:Point("BOTTOMRIGHT", WorldMapDetailFrame, 2, -2)
	mapbg:SetFrameStrata("MEDIUM")
	mapbg:SetFrameLevel(20)

	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	WorldMapFrame:SetFrameStrata("MEDIUM")
	WorldMapFrame:SetClampedToScreen(true)
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint(unpack(C.position.map))

	WorldMapDetailFrame:SetFrameStrata("MEDIUM")

	WorldMapTitleButton:Show()
	WorldMapTitleButton:SetFrameStrata("MEDIUM")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")

	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()

	WorldMapFrameSizeUpButton:ClearAllPoints()
	WorldMapFrameSizeUpButton:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, -18)
	WorldMapFrameSizeUpButton:SetFrameStrata("HIGH")
	WorldMapFrameSizeUpButton:SetFrameLevel(18)

	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, 3)
	WorldMapFrameCloseButton:SetFrameStrata("HIGH")

	WorldMapFrameSizeDownButton:Point("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", -66, 7)

	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetParent(WorldMapDetailFrame)
	WorldMapFrameTitle:Point("TOP", WorldMapDetailFrame, 0, -3)
	WorldMapFrameTitle:SetFont(C.media.normal_font, 17)

	WorldMapQuestShowObjectivesText:SetFont(C.media.normal_font, 17)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:Point("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, 4)

	WorldMapQuestShowObjectives:SetParent(WorldMapDetailFrame)
	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:Point("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", 0, 0)
	WorldMapQuestShowObjectives:SetFrameStrata("HIGH")

	WorldMapTrackQuest:SetParent(WorldMapDetailFrame)
	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:Point("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 0, 0)
	WorldMapTrackQuest:SetFrameStrata("HIGH")

	WorldMapTrackQuestText:SetFont(C.media.normal_font, 17)

	WorldMapShowDigSites:SetParent(WorldMapDetailFrame)
	WorldMapShowDigSites:ClearAllPoints()
	WorldMapShowDigSites:Point("BOTTOM", WorldMapQuestShowObjectives, "TOP", 0, 0)
	WorldMapShowDigSites:SetFrameStrata("HIGH")

	WorldMapShowDigSitesText:ClearAllPoints()
	WorldMapShowDigSitesText:Point("LEFT", WorldMapShowDigSites, "RIGHT", 0, 0)
	WorldMapShowDigSitesText:SetFont(C.media.normal_font, 17)

	WorldMapFrameAreaLabel:SetFontObject("GameFontNormal")
	WorldMapFrameAreaLabel:SetFont(C.media.normal_font, 40)
	WorldMapFrameAreaLabel:SetTextColor(0.9, 0.83, 0.64)

	WorldMapLevelDropDown:SetAlpha(0)
	WorldMapLevelDropDown:SetScale(0.00001)

	-- Fix tooltip not hidding after leaving quest # tracker icon
	hooksecurefunc("WorldMapQuestPOI_OnLeave", function() WorldMapTooltip:Hide() end)
end
hooksecurefunc("WorldMap_ToggleSizeDown", function() SmallerMapSkin() end)

local BiggerMapSkin = function()
	WorldMapLevelDropDown:SetAlpha(1)
	WorldMapLevelDropDown:SetScale(1)

	WorldMapQuestShowObjectivesText:SetFont(C.media.normal_font, 11)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:Point("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, 4)

	WorldMapQuestShowObjectives:SetParent(WorldMapDetailFrame)
	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:Point("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", 0, 0)
	WorldMapQuestShowObjectives:SetFrameStrata("TOOLTIP")

	WorldMapShowDigSites:SetParent(WorldMapDetailFrame)
	WorldMapShowDigSites:ClearAllPoints()
	WorldMapShowDigSites:Point("BOTTOM", WorldMapQuestShowObjectives, "TOP", 0, 0)
	WorldMapShowDigSites:SetFrameStrata("TOOLTIP")

	WorldMapShowDigSitesText:ClearAllPoints()
	WorldMapShowDigSitesText:Point("LEFT", WorldMapShowDigSites, "RIGHT", 0, 0)
	WorldMapShowDigSitesText:SetFont(C.media.normal_font, 17)
end
hooksecurefunc("WorldMap_ToggleSizeUp", function() BiggerMapSkin() end)

mapbg:SetScript("OnShow", function(self)
	local SmallerMap = GetCVarBool("miniWorldMap")
	if SmallerMap == nil then
		BiggerMapSkin()
	end
	self:SetScript("OnShow", function() end)
end)

local addon = CreateFrame("Frame")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("PLAYER_REGEN_DISABLED")
addon:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		SetCVar("questPOI", 1)
		BlackoutWorld:Hide()
		BlackoutWorld.Show = function() end
		BlackoutWorld.Hide = function() end
		WorldMapBlobFrame.Show = function() end
		WorldMapBlobFrame.Hide = function() end
		WorldMapQuestPOI_OnLeave = function()
			WorldMapTooltip:Hide()
		end
		WorldMap_ToggleSizeDown()
		if FeedbackUIMapTip then 
			FeedbackUIMapTip:Hide()
			FeedbackUIMapTip.Show = function() end
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		WorldMapFrameSizeUpButton:Disable()
		WorldMap_ToggleSizeDown()
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, false)
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, true)
	elseif event == "PLAYER_REGEN_ENABLED" then
		WorldMapFrameSizeUpButton:Enable()
	end
end)

----------------------------------------------------------------------------------------
--	Creating coords
----------------------------------------------------------------------------------------
local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
coords.PlayerText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.PlayerText:SetFont(C.media.normal_font, 17)
coords.PlayerText:SetJustifyH("LEFT")
coords.PlayerText:SetText(UnitName("player")..": 0,0")
if (IsAddOnLoaded("_NPCScan.Overlay")) then
	coords.PlayerText:Point("TOPLEFT", WorldMapButton, "TOPLEFT", 3, -50)
else
	coords.PlayerText:Point("TOPLEFT", WorldMapButton, "TOPLEFT", 3, -3)
end

coords.MouseText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.MouseText:SetFont(C.media.normal_font, 17)
coords.MouseText:SetJustifyH("LEFT")
coords.MouseText:Point("TOPLEFT", coords.PlayerText, "BOTTOMLEFT", 0, -3)
coords.MouseText:SetText(L_MAP_CURSOR..": 0,0")

local int = 0
coords:SetScript("OnUpdate", function(self, elapsed)
	int = int + 1

	if int >= 3 then
		local inInstance, _ = IsInInstance()
		local x,y = GetPlayerMapPosition("player")
		x = math.floor(100 * x)
		y = math.floor(100 * y)
		if x ~= 0 and y ~= 0 then
			self.PlayerText:SetText(UnitName("player")..": "..x..","..y)
		else
			self.PlayerText:SetText(UnitName("player")..": ".."|cffff0000"..L_MAP_BOUNDS.."|r")
		end

		local scale = WorldMapDetailFrame:GetEffectiveScale()
		local width = WorldMapDetailFrame:GetWidth()
		local height = WorldMapDetailFrame:GetHeight()
		local centerX, centerY = WorldMapDetailFrame:GetCenter()
		local x, y = GetCursorPosition()
		local adjustedX = (x / scale - (centerX - (width/2))) / width
		local adjustedY = (centerY + (height/2) - y / scale) / height

		if (adjustedX >= 0 and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1) then
			adjustedX = math.floor(100 * adjustedX)
			adjustedY = math.floor(100 * adjustedY)
			coords.MouseText:SetText(L_MAP_CURSOR..adjustedX..","..adjustedY)
		else
			coords.MouseText:SetText(L_MAP_CURSOR.."|cffff0000"..L_MAP_BOUNDS.."|r")
		end

		int = 0
	end
end)

----------------------------------------------------------------------------------------
--	Hide boss buttons on worlmap(Hide Boss Buttons by nebula)
----------------------------------------------------------------------------------------
local button = CreateFrame("CheckButton", "WorldMapFrameShowBossButtons", WorldMapFrame, "OptionsCheckButtonTemplate")
button:SetSize(19, 19)
button:SetFrameStrata("HIGH")
_G[button:GetName().."Text"]:SetFont(C.media.normal_font, 14)
_G[button:GetName().."Text"]:SetText(L_MAP_HIDE_BOSSES)

local function setAnchor(self)
	self:ClearAllPoints()
	local arch = select(3, GetProfessions())
	if arch then
		self:SetPoint("BOTTOM", WorldMapShowDigSites, "TOP", 0, 0)
	else
		self:SetPoint("BOTTOM", WorldMapQuestShowObjectives, "TOP", 0, 0)
	end
end

local function checkHideShow(self)
	if EJ_GetMapEncounter(1) then
		self:Show()
	else
		self:Hide()
	end
end

button:SetScript("OnShow", checkHideShow)

button:SetScript("OnClick", function(self, button)
	if self:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOn")
		SavedOptionsPerChar.ShowMapBoss = true
		WorldMapBossButtonFrame:Hide()
	else
		PlaySound("igMainMenuOptionCheckBoxOff")
		SavedOptionsPerChar.ShowMapBoss = false
		WorldMapBossButtonFrame:Show()
	end
end)

button:SetScript("OnEvent", function(self, event)
	if event == "WORLD_MAP_UPDATE" then
		checkHideShow(self)
	elseif event == "SKILL_LINES_CHANGED" then
		setAnchor(self)
	elseif event == "PLAYER_LOGIN" then
		if SavedOptionsPerChar.ShowMapBoss == nil then SavedOptionsPerChar.ShowMapBoss = false end
		self:SetChecked(SavedOptionsPerChar.ShowMapBoss)
		setAnchor(self)
		if SavedOptionsPerChar.ShowMapBoss then
			WorldMapBossButtonFrame:Hide()
		end
	end
end)
button:RegisterEvent("WORLD_MAP_UPDATE")
button:RegisterEvent("SKILL_LINES_CHANGED")
button:RegisterEvent("PLAYER_LOGIN")