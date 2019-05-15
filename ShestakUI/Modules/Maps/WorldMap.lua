local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Font replacement
----------------------------------------------------------------------------------------
MapQuestInfoRewardsFrame.XPFrame.Name:SetFont(C.media.normal_font, 13)

----------------------------------------------------------------------------------------
--	Change position
----------------------------------------------------------------------------------------
if not T.classic then
	hooksecurefunc(WorldMapFrame, "SynchronizeDisplayState", function()
		if CharacterFrame:IsShown() or SpellBookFrame:IsShown() or (PlayerTalentFrame and PlayerTalentFrame:IsShown()) or (ChannelFrame and ChannelFrame:IsShown()) or PVEFrame:IsShown() then return end
		if not WorldMapFrame:IsMaximized() then
			WorldMapFrame:ClearAllPoints()
			WorldMapFrame:SetPoint(unpack(C.position.map))
		end
	end)
	WorldMapFrame:SetClampedToScreen(true)
else
	function SetUIPanelAttribute(frame, name, value)
		local info = UIPanelWindows[frame:GetName()]
		if not info then return end

		if not frame:GetAttribute("UIPanelLayout-defined") then
			frame:SetAttribute("UIPanelLayout-defined", true)
			for name,value in pairs(info) do
				frame:SetAttribute("UIPanelLayout-"..name, value)
			end
		end

		frame:SetAttribute("UIPanelLayout-"..name, value)
	end

	WorldMapFrame.BlackoutFrame:StripTextures()
	WorldMapFrame.BlackoutFrame:EnableMouse(false)
	WorldMapFrame:SetParent(UIParent)
	WorldMapFrame:SetScale(1)
	WorldMapFrame:EnableKeyboard(false)
	WorldMapFrame:EnableMouse(false)
	WorldMapFrame:SetToplevel()

	table.insert(UISpecialFrames, WorldMapFrame:GetName())

	if WorldMapFrame:GetAttribute("UIPanelLayout-area") ~= "center" then
		SetUIPanelAttribute(WorldMapFrame, "area", "center")
	end

	if WorldMapFrame:GetAttribute("UIPanelLayout-allowOtherPanels") ~= true then
		SetUIPanelAttribute(WorldMapFrame, "allowOtherPanels", true)
	end

	DropDownList1:HookScript("OnShow", function()
		if DropDownList1:GetScale() ~= UIParent:GetScale() then
			DropDownList1:SetScale(UIParent:GetScale())
		end
	end)

	-- WorldMapTooltip:SetFrameLevel(WorldMapPositioningGuide:GetFrameLevel() + 110)
end

----------------------------------------------------------------------------------------
--	Creating coordinate
----------------------------------------------------------------------------------------
local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
coords:SetFrameLevel(WorldMapFrame.BorderFrame:GetFrameLevel() + 2)
coords:SetFrameStrata(WorldMapFrame.BorderFrame:GetFrameStrata())
coords.PlayerText = coords:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.PlayerText:SetPoint("BOTTOM", WorldMapFrame.ScrollContainer, "BOTTOM", 5, 20)
coords.PlayerText:SetJustifyH("LEFT")
coords.PlayerText:SetText(UnitName("player")..": 0,0")

coords.MouseText = coords:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.MouseText:SetJustifyH("LEFT")
coords.MouseText:SetPoint("BOTTOMLEFT", coords.PlayerText, "TOPLEFT", 0, 5)
coords.MouseText:SetText(L_MAP_CURSOR..": 0,0")

local int = 0
WorldMapFrame:HookScript("OnUpdate", function(self)
	int = int + 1
	if int >= 3 then
		local UnitMap = C_Map.GetBestMapForUnit("player")
		local x, y = 0, 0

		if UnitMap then
			local GetPlayerMapPosition = C_Map.GetPlayerMapPosition(UnitMap, "player")
			if GetPlayerMapPosition then
				x, y = GetPlayerMapPosition:GetXY()
			end
		end

		x = math.floor(100 * x)
		y = math.floor(100 * y)
		if x ~= 0 and y ~= 0 then
			coords.PlayerText:SetText(UnitName("player")..": "..x..","..y)
		else
			coords.PlayerText:SetText(UnitName("player")..": ".."|cffff0000"..L_MAP_BOUNDS.."|r")
		end

		local scale = WorldMapFrame.ScrollContainer:GetEffectiveScale()
		local width = WorldMapFrame.ScrollContainer:GetWidth()
		local height = WorldMapFrame.ScrollContainer:GetHeight()
		local centerX, centerY = WorldMapFrame.ScrollContainer:GetCenter()
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

coords:RegisterEvent("PLAYER_ENTERING_WORLD")
coords:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent(event)
	if SavedOptionsPerChar and SavedOptionsPerChar.Coords ~= true then
		coords:SetAlpha(0)
	end
end)

----------------------------------------------------------------------------------------
--	Dropdown menu for close button
----------------------------------------------------------------------------------------
local WorldMap_DDMenu = CreateFrame("Frame", "WorldMapDropDownMenu")
WorldMap_DDMenu.displayMode = "MENU"
WorldMap_DDMenu.info = {}
WorldMap_DDMenu.HideMenu = function()
	if UIDROPDOWNMENU_OPEN_MENU == WorldMap_DDMenu then
		CloseDropDownMenus()
	end
end

local function WorldMapMenu(self, level)
	if not level then return end

	local info = self.info

	wipe(info)

	if level ~= 1 then return end

	wipe(info)
	info.text = L_MAP_COORDS
	info.checked = function()
		return SavedOptionsPerChar.Coords == true
	end

	info.func = function()
		if SavedOptionsPerChar.Coords == true then
			SavedOptionsPerChar.Coords = false
			coords:SetAlpha(0)
		else
			SavedOptionsPerChar.Coords = true
			coords:SetAlpha(1)
		end
	end
	UIDropDownMenu_AddButton(info, level)

	if C.minimap.fog_of_war == true then
		wipe(info)
		info.text = L_MAP_FOG
		info.checked = function()
			return SavedOptionsPerChar.FogOfWar == true
		end

		info.func = function()
			if SavedOptionsPerChar.FogOfWar == true then
				SavedOptionsPerChar.FogOfWar = false
				for i = 1, #T.overlayTextures do
					T.overlayTextures[i]:Hide()
				end
			else
				SavedOptionsPerChar.FogOfWar = true
				for i = 1, #T.overlayTextures do
					T.overlayTextures[i]:Show()
				end
			end
		end
		UIDropDownMenu_AddButton(info, level)
	end

	wipe(info)
	info.disabled = nil
	info.notCheckable = 1
	info.text = CLOSE
	info.func = self.HideMenu
	info.tooltipTitle = CLOSE
	UIDropDownMenu_AddButton(info, level)
end

WorldMapFrameCloseButton:RegisterForClicks("AnyUp")
WorldMapFrameCloseButton:SetScript("OnClick", function(self, btn)
	if btn == "RightButton" then
		if WorldMap_DDMenu.initialize ~= WorldMapMenu then
			CloseDropDownMenus()
			WorldMap_DDMenu.initialize = WorldMapMenu
		end
		ToggleDropDownMenu(nil, nil, WorldMap_DDMenu, self:GetName(), -10, -6)
		return
	else
		UIPanelCloseButton_OnClick(self)
	end
end)

local tooltip_hide = function()
	GameTooltip:Hide()
end

local tooltip_show = function(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT", 19, 7)
	GameTooltip:ClearLines()
	GameTooltip:SetText(L_BAG_RIGHT_CLICK_CLOSE)
end

WorldMapFrameCloseButton:HookScript("OnEnter", tooltip_show)
WorldMapFrameCloseButton:HookScript("OnLeave", tooltip_hide)