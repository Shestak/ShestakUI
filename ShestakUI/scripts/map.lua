----------------------------------------------------------------------------------------
--	WorldMap style(m_Map by Monolit)
----------------------------------------------------------------------------------------
if not SettingsCF.map.enable == true then return end

WORLDMAP_WINDOWED_SIZE = SettingsCF.map.scale
local mapscale = WORLDMAP_WINDOWED_SIZE

local mapbg = CreateFrame("Frame", nil, WorldMapDetailFrame)
	mapbg:SetBackdrop( { 
	bgFile = SettingsCF["media"].blank, 
	edgeFile = SettingsCF["media"].blank, 
	tile = false, edgeSize = SettingsDB.mult, 
	insets = { left = -SettingsDB.mult, right = -SettingsDB.mult, top = -SettingsDB.mult, bottom = -SettingsDB.mult }
})

local addon = CreateFrame("Frame")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("PLAYER_REGEN_DISABLED")

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
	mapbg:SetBackdropColor(unpack(SettingsCF["media"].backdrop_color))
	mapbg:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
	mapbg:SetScale(1 / mapscale)
	mapbg:SetPoint("TOPLEFT", WorldMapDetailFrame, SettingsDB.Scale(-2), SettingsDB.Scale(2))
	mapbg:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, SettingsDB.Scale(2), SettingsDB.Scale(-2))
	mapbg:SetFrameStrata("MEDIUM")
	mapbg:SetFrameLevel(20)
	
	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	WorldMapFrame:SetFrameStrata("MEDIUM")
	
	WorldMapDetailFrame:ClearAllPoints()
	WorldMapDetailFrame:SetPoint(unpack(SettingsCF.position.map))
	WorldMapDetailFrame:SetFrameStrata("MEDIUM")
	
	WorldMapTitleButton:Show()
	WorldMapTitleButton:SetFrameStrata("MEDIUM")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")
	
	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()
	WorldMapFrameSizeUpButton:Hide()
	
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapButton, "TOPRIGHT", SettingsDB.Scale(3), SettingsDB.Scale(3))
	WorldMapFrameCloseButton:SetFrameStrata("HIGH")
	
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetParent(WorldMapDetailFrame)
	WorldMapFrameTitle:SetPoint("TOP", WorldMapDetailFrame, 0, SettingsDB.Scale(-3))
	WorldMapFrameTitle:SetFontObject("GameFontNormal")
	WorldMapFrameTitle:SetFont(SettingsCF.media.normal_font, 20)
	
	WorldMapQuestShowObjectivesText:SetFontObject("GameFontNormal")
	WorldMapQuestShowObjectivesText:SetFont(SettingsCF.media.normal_font, 17)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:SetPoint("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, SettingsDB.Scale(4))
	
	WorldMapQuestShowObjectives:SetParent(WorldMapDetailFrame)
	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:SetPoint("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", 0, 0)
	WorldMapQuestShowObjectives:SetFrameStrata("TOOLTIP")
	
	WorldMapTrackQuest:SetParent(WorldMapDetailFrame)
	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 0, 0)
	WorldMapTrackQuest:SetFrameStrata("TOOLTIP")
	
	WorldMapTrackQuestText:SetFontObject("GameFontNormal")
	WorldMapTrackQuestText:SetFont(SettingsCF.media.normal_font, 17)
	
	WorldMapFrameAreaLabel:SetFontObject("GameFontNormal")
	WorldMapFrameAreaLabel:SetFont(SettingsCF.media.normal_font, 40)
	WorldMapFrameAreaLabel:SetTextColor(0.9, 0.83, 0.64)
	
	WorldMapLevelDropDown:SetAlpha(0)
	WorldMapLevelDropDown:SetScale(0.00001)

	-- Fix tooltip not hidding after leaving quest # tracker icon
	hooksecurefunc("WorldMapQuestPOI_OnLeave", function() WorldMapTooltip:Hide() end)
end
hooksecurefunc("WorldMap_ToggleSizeDown", function() SmallerMapSkin() end)

local OnEvent = function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		ShowUIPanel(WorldMapFrame)
		HideUIPanel(WorldMapFrame)
	elseif event == "PLAYER_REGEN_DISABLED" then
		WorldMapFrameSizeDownButton:Disable() 
		WorldMapFrameSizeUpButton:Disable()
		HideUIPanel(WorldMapFrame)
		WorldMap_ToggleSizeDown()
		WatchFrame.showObjectives = nil
		WorldMapQuestShowObjectives:SetChecked(false)
		WorldMapQuestShowObjectives:Hide()
		WorldMapTitleButton:Hide()
		WorldMapBlobFrame:Hide()
		WorldMapPOIFrame:Hide()

		WorldMapQuestShowObjectives.Show = SettingsDB.dummy
		WorldMapTitleButton.Show = SettingsDB.dummy
		WorldMapBlobFrame.Show = SettingsDB.dummy
		WorldMapPOIFrame.Show = SettingsDB.dummy       

		WatchFrame_Update()
	elseif event == "PLAYER_REGEN_ENABLED" then
		WorldMapFrameSizeDownButton:Enable()
		WorldMapFrameSizeUpButton:Enable()
		WorldMapQuestShowObjectives.Show = WorldMapQuestShowObjectives:Show()
		WorldMapTitleButton.Show = WorldMapTitleButton:Show()
		WorldMapBlobFrame.Show = WorldMapBlobFrame:Show()
		WorldMapPOIFrame.Show = WorldMapPOIFrame:Show()

		WorldMapQuestShowObjectives:Show()
		WorldMapTitleButton:Show()

		WatchFrame.showObjectives = true
		WorldMapQuestShowObjectives:SetChecked(true)

		WorldMapBlobFrame:Show()
		WorldMapPOIFrame:Show()

		WatchFrame_Update()
	end
end
addon:SetScript("OnEvent", OnEvent)

----------------------------------------------------------------------------------------
--	Creating coords
----------------------------------------------------------------------------------------
coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
coords.PlayerText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.PlayerText:SetFont(SettingsCF.media.normal_font, 17)
coords.PlayerText:SetJustifyH("LEFT")
coords.PlayerText:SetText(UnitName("player")..": 0,0")
if (IsAddOnLoaded("_NPCScan.Overlay")) then
	coords.PlayerText:SetPoint("TOPLEFT", WorldMapButton, "TOPLEFT", SettingsDB.Scale(3), SettingsDB.Scale(-25))
else
	coords.PlayerText:SetPoint("TOPLEFT", WorldMapButton, "TOPLEFT", SettingsDB.Scale(3), SettingsDB.Scale(-3))
end

coords.MouseText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.MouseText:SetFont(SettingsCF.media.normal_font, 17)
coords.MouseText:SetJustifyH("LEFT")
coords.MouseText:SetPoint("TOPLEFT", coords.PlayerText, "BOTTOMLEFT", 0, SettingsDB.Scale(-3))
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
		
		if (adjustedX >= 0  and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1) then
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
--	BattlefieldMinimap style
----------------------------------------------------------------------------------------
if SettingsCF.map.bg_map_stylization then
	local bm = CreateFrame("Frame")
	bm:RegisterEvent("ADDON_LOADED")
	bm:SetScript("OnEvent", function(self, event, addon)
		if not BattlefieldMinimap_Update then return end
		self:SetParent(BattlefieldMinimap)
		self:SetScript("OnShow", function()
			BattlefieldMinimapCorner:Hide()
			BattlefieldMinimapBackground:Hide()
			BattlefieldMinimapCloseButton:Hide()
		end)
		local background = CreateFrame("Frame", "BACKGROUND", BattlefieldMinimap)
		SettingsDB.CreateTemplate(background)
		background:SetFrameLevel(0)
		background:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		background:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-4), SettingsDB.Scale(2))
		background:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
		
		self:UnregisterEvent("ADDON_LOADED")
		self:SetScript("OnEvent", nil)
	end)
end