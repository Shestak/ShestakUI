----------------------------------------------------------------------------------------
--	WorldMap style(m_Map by Monolit)
----------------------------------------------------------------------------------------
if not SettingsCF.map.enable == true then return end

-- Mini World Map scale
local map_scale = SettingsCF.map.scale

-- Moving/removing world map elements
local w = CreateFrame"Frame"
w:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		SetCVar("questPOI", 1)
		SetCVar("advancedWorldMap",1)
		BlackoutWorld:Hide()
		BlackoutWorld.Show = SettingsDB.dummy
		BlackoutWorld.Hide = SettingsDB.dummy
		WORLDMAP_RATIO_MINI = map_scale
		WORLDMAP_WINDOWED_SIZE = map_scale 
		WORLDMAP_SETTINGS.size = map_scale 
		WorldMapBlobFrame.Show = SettingsDB.dummy
		WorldMapBlobFrame.Hide = SettingsDB.dummy
		WorldMapQuestPOI_OnLeave = function()
			WorldMapTooltip:Hide()
		end
		WorldMap_ToggleSizeDown()
		for i = 1, 40 do
			local ri = _G["WorldMapRaid"..i]
			ri:SetWidth(20)
			ri:SetHeight(20)
		end
		if FeedbackUIMapTip then 
			FeedbackUIMapTip:Hide()
			FeedbackUIMapTip.Show = SettingsDB.dummy
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		WorldMapFrameSizeUpButton:Disable()
		WorldMap_ToggleSizeDown()
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, false)
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, true)
	elseif event == "PLAYER_REGEN_ENABLED" then
		WorldMapFrameSizeUpButton:Enable()
	elseif event == "WORLD_MAP_UPDATE" then
		if (GetNumDungeonMapLevels() == 0) then
			WorldMapLevelUpButton:Hide()
			WorldMapLevelDownButton:Hide()
		else
			WorldMapLevelUpButton:Show()
			WorldMapLevelDownButton:Show()
			WorldMapLevelUpButton:ClearAllPoints()
			WorldMapLevelUpButton:SetPoint("TOPLEFT", WorldMapFrameCloseButton, "BOTTOMLEFT", 8, 8)
			WorldMapLevelUpButton:SetFrameStrata("MEDIUM")
			WorldMapLevelUpButton:SetFrameLevel(100)
			WorldMapLevelDownButton:ClearAllPoints()
			WorldMapLevelDownButton:SetPoint("TOP", WorldMapLevelUpButton, "BOTTOM",0,-2)
			WorldMapLevelDownButton:SetFrameStrata("MEDIUM")
			WorldMapLevelDownButton:SetFrameLevel(100)
			WorldMapLevelDownButton:SetParent("WorldMapFrame")
			WorldMapLevelUpButton:SetParent("WorldMapFrame")
		end
	end
end)
w:RegisterEvent("PLAYER_ENTERING_WORLD")
w:RegisterEvent("WORLD_MAP_UPDATE")
w:RegisterEvent("PLAYER_REGEN_DISABLED")
w:RegisterEvent("PLAYER_REGEN_ENABLED")

-- Styling World Map
function m_MapShrink()
	local bg = CreateFrame("Frame", nil, WorldMapButton)
	bg:SetParent("WorldMapDetailFrame")
	bg:SetFrameStrata("MEDIUM")
	bg:SetFrameLevel(30)
	bg:SetScale(1 / map_scale)
	bg:SetPoint("TOPLEFT", WorldMapButton, SettingsDB.Scale(-2), SettingsDB.Scale(2))
	bg:SetPoint("BOTTOMRIGHT", WorldMapButton, SettingsDB.Scale(2), SettingsDB.Scale(-2))
	SettingsDB.CreateTemplate(bg)
	bg:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)

	WorldMapDetailFrame:ClearAllPoints()
	WorldMapDetailFrame:SetPoint(unpack(SettingsCF.position.map))
	WorldMapFrame.scale = map_scale
	WorldMapDetailFrame:SetScale(map_scale)
	WorldMapButton:SetScale(map_scale)
	WorldMapFrameAreaFrame:SetScale(map_scale)
	WorldMapTitleButton:Show()
	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()
	WorldMapPOIFrame.ratio = map_scale
	
	WorldMapFrameSizeUpButton.Show = SettingsDB.dummy
	WorldMapFrameSizeUpButton:Hide()
	
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapButton, "TOPRIGHT", 0, 0)
	WorldMapFrameCloseButton:SetFrameStrata("HIGH")
	
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetPoint("TOP", WorldMapDetailFrame, 0, -3)
	WorldMapFrameTitle:SetParent(WorldMapDetailFrame)
	WorldMapFrameTitle:SetFontObject("GameFontNormal")
	WorldMapFrameTitle:SetFont(SettingsCF.media.normal_font, 20)
	
	WorldMapTitleButton:SetFrameStrata("TOOLTIP")
	WorldMapTitleButton:ClearAllPoints()
	WorldMapTitleButton:SetPoint("TOP", WorldMapFrame, "TOP", 0, -18)
	
	WorldMapTooltip:SetFrameStrata("TOOLTIP")
	WorldMapLevelDropDown.Show = SettingsDB.dummy
	WorldMapLevelDropDown:Hide()
	
	WorldMapQuestShowObjectivesText:SetFontObject("GameFontNormal")
	WorldMapQuestShowObjectivesText:SetFont(SettingsCF.media.normal_font, 17)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:SetPoint("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, 4)
	
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
	
	WorldMapShowDigSites:SetScale(map_scale)
	
	WorldMapFrame_SetOpacity(WORLDMAP_SETTINGS.opacity)
end
hooksecurefunc("WorldMap_ToggleSizeDown", m_MapShrink)

----------------------------------------------------------------------------------------
--	Creating coords
----------------------------------------------------------------------------------------
local c = CreateFrame("Frame", "Coords", UIParent)
local player, cursor
local function gen_string(point, X, Y)
	local t = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	t:SetPoint(point, WorldMapButton, X, Y)
	t:SetFont(SettingsCF.media.normal_font, 17)
	t:SetJustifyH("LEFT")
	return t
end
local function Cursor()
	local left, top = WorldMapDetailFrame:GetLeft() or 0, WorldMapDetailFrame:GetTop() or 0
	local width, height = WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight()
	local scale = WorldMapDetailFrame:GetEffectiveScale()
	local x, y = GetCursorPosition()
	local cx = (x/scale - left) / width
	local cy = (top - y/scale) / height
	if cx < 0 or cx > 1 or cy < 0 or cy > 1 then return end
	return cx, cy
end
local function OnUpdate(player, cursor)
	local cx, cy = Cursor()
	local px, py = GetPlayerMapPosition("player")
	if cx and cy then
		cursor:SetFormattedText(L_MAP_CURSOR.."%.2d,%.2d", 100 * cx, 100 * cy)
	else
		cursor:SetText(L_MAP_CURSOR.."|cffff0000"..L_MAP_BOUNDS.."|r")
	end
	if px == 0 or py == 0 then
		player:SetText("")
	else
		player:SetFormattedText(UnitName("player")..": %.2d,%.2d", 100 * px, 100 * py)
	end
	
	if (IsAddOnLoaded("_NPCScan.Overlay")) then
		player:SetPoint("TOPLEFT", 3, -45)
		cursor:SetPoint("TOPLEFT", 3, -65)
	else
		player:SetPoint("TOPLEFT", 3, -5)
		cursor:SetPoint("TOPLEFT", 3, -25)
	end
end
local function UpdateCoords(self, elapsed)
	self.elapsed = self.elapsed - elapsed
	if self.elapsed <= 0 then
		self.elapsed = 0.1
		OnUpdate(player, cursor)
	end
end
local function gen_coords(self)
	if player or cursor then return end
	player = gen_string("TOPLEFT", 3, -5)
	cursor = gen_string("TOPLEFT", 3, -25)
end
local function OnLogin(self, event)
	gen_coords(self)
	local cond = false
	if (event == "WORLD_MAP_UPDATE") then 
		self:SetScript("OnEvent", function() 
			if not WorldMapFrame:IsVisible() and cond then
				self.elapsed = nil
				self:SetScript("OnUpdate", nil)
				cond = false
			else
				self.elapsed = 0.1
				self:SetScript("OnUpdate", UpdateCoords)
				cond = true
			end
		end)
	end
	self:UnregisterEvent("PLAYER_LOGIN")
end
c:RegisterEvent("PLAYER_LOGIN") 
c:RegisterEvent("WORLD_MAP_UPDATE")
c:SetScript("OnEvent", OnLogin)

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