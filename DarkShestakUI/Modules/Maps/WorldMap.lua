local T, C, L, _ = unpack(select(2, ...))
if C.map.enable ~= true or IsAddOnLoaded("Aurora") then return end

----------------------------------------------------------------------------------------
--	WorldMap style(m_Map by Monolit)
----------------------------------------------------------------------------------------
WORLDMAP_WINDOWED_SIZE = C.map.scale

local mapbg = CreateFrame("Frame", nil, WorldMapDetailFrame)
mapbg:SetTemplate("Default", "Shadow")

local SmallerMap = GetCVarBool("miniWorldMap")
if SmallerMap == nil then
	SetCVar("miniWorldMap", 1)
end

-- Styling World Map
local SmallerMapSkin = function()
	mapbg:SetScale(1 / WORLDMAP_WINDOWED_SIZE)
	mapbg:SetPoint("TOPLEFT", WorldMapDetailFrame, -2, 2)
	mapbg:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, 2, -2)
	mapbg:SetFrameStrata("MEDIUM")
	mapbg:SetFrameLevel(20)

	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	WorldMapFrame:SetFrameStrata("MEDIUM")
	WorldMapFrame:SetClampedToScreen(true)
	WorldMapFrame:SetClampRectInsets(12, 227, -31, -134)
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint(unpack(C.position.map))

	WorldMapDetailFrame:SetFrameStrata("MEDIUM")
	-- WorldMapPing:SetAlpha(0)
	WorldMapPlayerUpper:EnableMouse(false)
	WorldMapPlayerLower:EnableMouse(false)

	WorldMapTitleButton:Show()
	WorldMapTitleButton:SetFrameStrata("MEDIUM")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")

	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()
	WorldMapFrameCloseButton:Hide()
	WorldMapFrameSizeUpButton:Hide()
	WorldMapFrameSizeDownButton:Hide()

	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetParent(WorldMapDetailFrame)
	WorldMapFrameTitle:SetPoint("TOP", WorldMapDetailFrame, 0, -3)
	WorldMapFrameTitle:SetFont(C.media.normal_font, 17)

	T.SkinCheckBox(WorldMapTrackQuest)
	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 0, 0)

	WorldMapFrameAreaLabel:SetFont(C.media.normal_font, 40)
	WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
	WorldMapFrameAreaLabel:SetTextColor(0.9, 0.83, 0.64)

	WorldMapFrameAreaDescription:SetFont(C.media.normal_font, 40)
	WorldMapFrameAreaDescription:SetShadowOffset(2, -2)

	WorldMapFrameAreaPetLevels:SetFont(C.media.normal_font, 32)
	WorldMapFrameAreaPetLevels:SetShadowOffset(2, -2)

	MapBarFrame.Description:SetFont(C.media.normal_font, 17)
	MapBarFrame.Description:SetShadowOffset(1, -1)

	MapBarFrame.Title:SetFont(C.media.normal_font, 17)
	MapBarFrame.Title:SetShadowOffset(1, -1)

	WorldMapLevelDropDown:SetAlpha(0)
	WorldMapLevelDropDown:SetScale(0.00001)

	WorldMapShowDropDown:SetScale(WORLDMAP_WINDOWED_SIZE)
	WorldMapShowDropDown:ClearAllPoints()
	WorldMapShowDropDown:SetPoint("TOPRIGHT", WorldMapButton, "TOPRIGHT", 10, -3)
	WorldMapShowDropDown:SetFrameStrata("HIGH")
end
hooksecurefunc("WorldMap_ToggleSizeDown", function() SmallerMapSkin() end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		WorldMap_ToggleSizeDown()
		WorldMapBlobFrame.Show = function() end
		WorldMapBlobFrame.Hide = function() end
		WorldMapQuestPOI_OnLeave = function()
			WorldMapTooltip:Hide()
		end
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
if IsAddOnLoaded("_NPCScan.Overlay") then
	coords.PlayerText:SetPoint("TOPLEFT", WorldMapButton, "TOPLEFT", 3, -50)
else
	coords.PlayerText:SetPoint("TOPLEFT", WorldMapButton, "TOPLEFT", 3, -3)
end

coords.MouseText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.MouseText:SetFont(C.media.normal_font, 17)
coords.MouseText:SetJustifyH("LEFT")
coords.MouseText:SetPoint("TOPLEFT", coords.PlayerText, "BOTTOMLEFT", 0, -3)
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

		if adjustedX >= 0 and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1 then
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
--	Floors scroll
----------------------------------------------------------------------------------------
WorldMapButton:SetScript("OnMouseWheel", function(self, delta)
	local level = GetCurrentMapDungeonLevel() - delta
	if level >= 1 and level <= GetNumDungeonMapLevels() then
		SetDungeonMapLevel(level)
		PlaySound("UChatScrollButton")
	end
end)