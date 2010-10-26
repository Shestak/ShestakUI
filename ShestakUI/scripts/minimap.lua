if not SettingsCF["minimap"].enable == true then return end
----------------------------------------------------------------------------------------
--	Minimap border
----------------------------------------------------------------------------------------
local UIMinimap = CreateFrame("Frame", "UIMinimap", Minimap)
UIMinimap:RegisterEvent("ADDON_LOADED")

SettingsDB.CreatePanel(UIMinimap, SettingsDB.Scale(SettingsCF.minimap.size), SettingsDB.Scale(SettingsCF.minimap.size), "CENTER", Minimap, "CENTER", 0, 0)
UIMinimap:ClearAllPoints()
UIMinimap:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
UIMinimap:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
UIMinimap:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)

----------------------------------------------------------------------------------------
--	Shape, location and scale
----------------------------------------------------------------------------------------
Minimap:ClearAllPoints()
Minimap:SetPoint(unpack(SettingsCF.position.minimap))
Minimap:SetSize(SettingsDB.Scale(SettingsCF.minimap.size), SettingsDB.Scale(SettingsCF.minimap.size))

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Voice Chat Frame
SettingsDB.Kill(MiniMapVoiceChatFrame)
SettingsDB.Kill(VoiceChatTalkers)

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Tracking Button
--MiniMapTracking:Hide()
MiniMapTrackingBackground:Hide()

-- Hide Game Time
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", SettingsDB.Scale(6), SettingsDB.Scale(-8))
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\ShestakUI\\media\\mail")

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("TOP", Minimap, "TOP", SettingsDB.Scale(1), SettingsDB.Scale(6))
MiniMapBattlefieldBorder:Hide()

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- Instance Difficulty icon
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", SettingsDB.Scale(3), SettingsDB.Scale(2))
MiniMapInstanceDifficulty:SetScale(0.75)

GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
GuildInstanceDifficulty:SetScale(0.75)

-- Invites Icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent(Minimap)
GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT")

local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("TOP", Minimap, "TOP", SettingsDB.Scale(1), SettingsDB.Scale(6))
	MiniMapLFGFrame:SetHighlightTexture(nil)
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

UIMinimap:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TimeManager" then
		-- Hide Game Time
		SettingsDB.Kill(TimeManagerClockButton)
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local micromenu = {
    {text = CHARACTER_BUTTON,
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = SPELLBOOK_ABILITIES_BUTTON,
    func = function() ToggleFrame(SpellBookFrame) end},
    {text = TALENTS_BUTTON,
	func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end PlayerTalentFrame_Toggle() end},
    {text = ACHIEVEMENT_BUTTON,
    func = function() ToggleAchievementFrame() end},
    {text = QUESTLOG_BUTTON,
    func = function() ToggleFrame(QuestLogFrame) end},
    {text = SOCIAL_BUTTON,
    func = function() ToggleFriendsFrame(1) end},
    {text = PLAYER_V_PLAYER,
    func = function() ToggleFrame(PVPFrame) end},
	{text = ACHIEVEMENTS_GUILD_TAB,
    func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() end end},
    {text = LFG_TITLE,
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = LOOKING_FOR_RAID,
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = HELP_BUTTON,
    func = function() ToggleHelpFrame() end},
    {text = L_MINIMAP_CALENDAR,
    func = function()
    if not CalendarFrame then LoadAddOn("Blizzard_Calendar") end Calendar_Toggle() end},
}

local addonmenu = {
	{text = "AtlasLoot",
    func = function() if IsAddOnLoaded("AtlasLoot") then AtlasLootDefaultFrame:Show() end end},
	{text = "DBM",
    func = function() if IsAddOnLoaded("DBM-Core") then DBM:LoadGUI() end end},
	{text = "DXE",
    func = function() if IsAddOnLoaded("DXE") then DXE:ToggleConfig() end end},
	{text = "Skada",
    func = function() if IsAddOnLoaded("Skada") then Skada:ToggleWindow() end end},
	{text = "WIM",
    func = function() if IsAddOnLoaded("WIM") then WIM.ShowAllWindows() end end},
	{text = "Omen",
    func = function() if IsAddOnLoaded("Omen") then Omen:Toggle() end end},
	{text = "Recount",
    func = function() if IsAddOnLoaded("Recount") then Recount.MainWindow:Show() end end},
	{text = "TinyDPS",
    func = function() if IsAddOnLoaded("TinyDPS") then tdpsFrame:Show() end end},
}

Minimap:SetScript("OnMouseUp", function(self, button)
	if button == "RightButton" and not InCombatLockdown() then
		EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU", 2)
	elseif button == "MiddleButton" then
		EasyMenu(addonmenu, menuFrame, "cursor", 0, 0, "MENU", 2)
	elseif button == "LeftButton" then
		Minimap_OnClick(self)
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture(SettingsCF.media.blank)

-- For others mods with a minimap button, set minimap buttons position in square mode
function GetMinimapShape() return 'SQUARE' end

----------------------------------------------------------------------------------------
--	Hide minimap in combat
----------------------------------------------------------------------------------------
if SettingsCF.minimap.hide_combat == true then
	MinimapCluster:RegisterEvent("PLAYER_REGEN_ENABLED")
	MinimapCluster:RegisterEvent("PLAYER_REGEN_DISABLED")
	MinimapCluster:HookScript("OnEvent",function(self, event)
		if event == "PLAYER_REGEN_ENABLED" then
			self:Show()
		elseif event == "PLAYER_REGEN_DISABLED" then
			self:Hide()
		end
	end)
end

----------------------------------------------------------------------------------------
--	Tracking text and icon
----------------------------------------------------------------------------------------
local trackborder = CreateFrame("Frame", nil, UIParent)
trackborder:SetFrameLevel(4)
trackborder:SetFrameStrata("BACKGROUND")
trackborder:SetHeight(20)
trackborder:SetWidth(20)
trackborder:SetPoint("BOTTOMLEFT", UIMinimap, SettingsDB.Scale(4), SettingsDB.Scale(4))
if SettingsCF.minimap.tracking_icon then
	SettingsDB.SkinFadedPanel(trackborder)
	trackborder:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
else
	MiniMapTrackingButton:SetAlpha(0)
	MiniMapTrackingIcon:SetAlpha(0)
end
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("CENTER", trackborder, SettingsDB.Scale(2), SettingsDB.Scale(-2))
MiniMapTrackingButton:SetHighlightTexture(nil)
MiniMapTrackingButtonBorder:Hide()
MiniMapTrackingIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
MiniMapTrackingIcon:SetHeight(SettingsDB.Scale(16))
MiniMapTrackingIcon:SetWidth(SettingsDB.Scale(16))


local function Minimap_GetTrackType()
	local track = nil
	for i = 1, GetNumTrackingTypes() do
		local name, _, isActive = GetTrackingInfo(i)
		if (isActive) then
			track = isActive
			MinimapTrackingText:SetText(name)
		end
		if (not track) then
			MinimapTrackingText:SetText(NONE)
		end
	end
end

MinimapTrackingText = Minimap:CreateFontString("$parentTrackingText", "OVERLAY")
MinimapTrackingText:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
MinimapTrackingText:SetTextColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
MinimapTrackingText:SetPoint("CENTER", Minimap, 0, SettingsDB.Scale(35))
MinimapTrackingText:SetWidth((Minimap:GetWidth() - 5))
MinimapTrackingText:SetAlpha(0)

Minimap:SetScript("OnEnter", function()
	Minimap_GetTrackType()
	UIFrameFadeIn(MinimapTrackingText, 0.15, MinimapTrackingText:GetAlpha(), 1)
end)

Minimap:SetScript("OnLeave", function()
	Minimap_GetTrackType()
	UIFrameFadeOut(MinimapTrackingText, 0.15, MinimapTrackingText:GetAlpha(), 0)
end)

----------------------------------------------------------------------------------------
--	GUI icon on minimap
----------------------------------------------------------------------------------------
if SettingsCF["general"].minimap_icon == true and IsAddOnLoaded("ShestakUI_Config") then
	local color = RAID_CLASS_COLORS[SettingsDB.class]
	local menuIcon = CreateFrame("Button", "GUIButton", Minimap)
	SettingsDB.SkinFadedPanel(menuIcon)
	menuIcon:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
	menuIcon:SetWidth(SettingsDB.Scale(20))
	menuIcon:SetHeight(SettingsDB.Scale(20))
	menuIcon:SetMovable(true)
	menuIcon:RegisterForClicks("AnyUp")
	menuIcon:RegisterForDrag("LeftButton")
	menuIcon:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", SettingsDB.Scale(-5), SettingsDB.Scale(-2))

	local minimapShapes = {
		["ROUND"] = {true, true, true, true},
		["SQUARE"] = {false, false, false, false},
		["CORNER-TOPLEFT"] = {true, false, false, false},
		["CORNER-TOPRIGHT"] = {false, false, true, false},
		["CORNER-BOTTOMLEFT"] = {false, true, false, false},
		["CORNER-BOTTOMRIGHT"] = {false, false, false, true},
		["SIDE-LEFT"] = {true, true, false, false},
		["SIDE-RIGHT"] = {false, false, true, true},
		["SIDE-TOP"] = {true, false, true, false},
		["SIDE-BOTTOM"] = {false, true, false, true},
		["TRICORNER-TOPLEFT"] = {true, true, true, false},
		["TRICORNER-TOPRIGHT"] = {true, false, true, true},
		["TRICORNER-BOTTOMLEFT"] = {true, true, false, true},
		["TRICORNER-BOTTOMRIGHT"] = {false, true, true, true},
	}

	local function onupdate(self)
		if self.isMoving then
			local mx, my = Minimap:GetCenter()
			local px, py = GetCursorPosition()
			local scale = Minimap:GetEffectiveScale()
			px, py = px / scale, py / scale
			
			local angle = math.rad(math.deg(math.atan2(py - my, px - mx)) % 360)
				
			local x, y, q = math.cos(angle), math.sin(angle), 1
			if x < 0 then q = q + 1 end
			if y > 0 then q = q + 2 end

			local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
			local quadTable = minimapShapes[minimapShape]
			if quadTable[q] then
				x, y = x*80, y*80
			else
				local diagRadius = 103.13708498985 --math.sqrt(2*(80)^2)-10
				x = math.max(-78, math.min(x*diagRadius, 78));
				y = math.max(-78, math.min(y*diagRadius, 78));
			end
			self:ClearAllPoints();
			self:SetPoint("CENTER", Minimap, "CENTER", x, y);
		end
	end
		
	menuIcon:SetScript("OnClick", function(self, button)
		if IsShiftKeyDown() and button == "RightButton" then
			ReloadUI()
		else
			if button == "LeftButton" then
				PlaySound("igMainMenuOption")
				HideUIPanel(GameMenuFrame)
				if not UIConfig or not UIConfig:IsShown() then
					CreateUIConfig()
				else
					UIConfig:Hide()
				end
			elseif button == "RightButton" then
				ToggleDropDownMenu(1, nil, iconMenuDrop, self, 0, 15)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
			end
		end
	end)

	menuIcon:SetScript("OnDragStart", function(self)
		if IsShiftKeyDown() then
			self.isMoving = true
			self:SetScript("OnUpdate", function(self) onupdate(self) end)
		end
	end)

	menuIcon:SetScript("OnDragStop", function(self)
		self.isMoving = nil
		self:SetScript("OnUpdate", nil)
		self:SetUserPlaced(true)
	end)	

	menuIcon:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:AddLine("ShestakUI "..SettingsDB.version)
		GameTooltip:AddLine(L_GUI_MINIMAP_ICON_LM, 1, 1, 1)
		GameTooltip:AddLine(L_GUI_MINIMAP_ICON_RM, 1, 1, 1)
		GameTooltip:AddLine(L_GUI_MINIMAP_ICON_SRM, 1, 1, 1)
		GameTooltip:AddLine(L_GUI_MINIMAP_ICON_SD, 1, 1, 1)
		GameTooltip:Show()
	end)

	menuIcon:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	function addDrop(array)
		local info = array
		
		local function dropDown_create(self, level)
			 for i, j in pairs(info) do
				UIDropDownMenu_AddButton(j, level)
			 end
		end

		local iconMenu = CreateFrame("Frame", "iconMenu", nil, "UIDropDownMenuTemplate")
		UIDropDownMenu_Initialize(iconMenu, dropDown_create, "MENU", level)
		return iconMenu
	end

	iconMenuDrop = addDrop({
		{ text = L_GUI_MINIMAP_ICON_SLASH, isTitle = 1, notCheckable = 1, keepShownOnClick = 1 },
		{ text = L_GUI_MINIMAP_ICON_SPEC, func = function() 
			local spec = GetActiveTalentGroup()
			if spec == 1 then 
				SetActiveTalentGroup(2) 
			elseif spec == 2 then 
				SetActiveTalentGroup(1) 
			end
		end },
		{ text = L_GUI_MINIMAP_ICON_CL, func = function() CombatLogClearEntries() end },
		{ text = L_GUI_MINIMAP_ICON_DBM, func = function() DBM:DemoMode() end },
		{ text = L_GUI_MINIMAP_ICON_HEAL, func = function()
			DisableAddOn("ShestakUI_DPS")
			EnableAddOn("ShestakUI_Heal")
			ReloadUI()
		end },
		{ text = L_GUI_MINIMAP_ICON_DPS, func = function()
			DisableAddOn("ShestakUI_Heal")
			EnableAddOn("ShestakUI_DPS")
			ReloadUI()
		end },
	})
end