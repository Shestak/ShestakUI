local T, C, L = unpack(select(2, ...))
if not C.minimap.enable == true then return end

----------------------------------------------------------------------------------------
--	Minimap border
----------------------------------------------------------------------------------------
local MinimapAnchor = CreateFrame("Frame", "MinimapAnchor", UIParent)
MinimapAnchor:CreatePanel("Transparent", C.minimap.size, C.minimap.size, "CENTER", UIParent, "CENTER", 0, 0)
MinimapAnchor:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
MinimapAnchor:RegisterEvent("ADDON_LOADED")
MinimapAnchor:Point(unpack(C.position.minimap))
MinimapAnchor:SetClampedToScreen(true)
MinimapAnchor:SetMovable(true)
MinimapAnchor.text = MinimapAnchor:CreateFontString("MinimapAnchorText", "OVERLAY")
MinimapAnchor.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
MinimapAnchor.text:SetPoint("CENTER")

----------------------------------------------------------------------------------------
--	Shape, location and scale
----------------------------------------------------------------------------------------
-- Kill Minimap Cluster
MinimapCluster:Kill()

-- Parent Minimap into our frame
Minimap:SetParent(MinimapAnchor)
Minimap:ClearAllPoints()
Minimap:Point("TOPLEFT", MinimapAnchor, "TOPLEFT", 2, -2)
Minimap:Point("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", -2, 2)
Minimap:Size(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Voice Chat Frame
MiniMapVoiceChatFrame:Kill()
VoiceChatTalkers:Kill()

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Tracking Button
MiniMapTrackingBackground:Hide()

-- Hide Game Time
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 6, -8)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Mail.tga")

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:Point("TOP", Minimap, "TOP", 1, 6)
MiniMapBattlefieldBorder:Hide()

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- Instance Difficulty icon
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:Point("TOPRIGHT", Minimap, "TOPRIGHT", 3, 2)
MiniMapInstanceDifficulty:SetScale(0.75)

-- Guild Instance Difficulty icon
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:Point("TOPRIGHT", Minimap, "TOPRIGHT", -2, 2)
GuildInstanceDifficulty:SetScale(0.75)

-- Invites icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent(Minimap)
GameTimeCalendarInvitesTexture:Point("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)

-- Random Group icon
local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:Point("TOP", Minimap, "TOP", 1, 6)
	MiniMapLFGFrame:SetHighlightTexture(nil)
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- Feedback icon
if FeedbackUIButton then
	FeedbackUIButton:ClearAllPoints()
	FeedbackUIButton:Point("BOTTOM", Minimap, "BOTTOM", 0, 0)
	FeedbackUIButton:SetScale(0.8)
end

-- Streaming icon
if StreamingIcon then
	StreamingIcon:ClearAllPoints()
	StreamingIcon:Point("BOTTOM", Minimap, "BOTTOM", 0, -10)
	StreamingIcon:SetScale(0.8)
end

-- GhostFrame
GhostFrameContentsFrame:Width(C.minimap.size)
GhostFrameContentsFrame:ClearAllPoints()
GhostFrameContentsFrame:SetPoint("CENTER")
GhostFrameContentsFrame.SetPoint = T.dummy
GhostFrame:SetFrameStrata("HIGH")
GhostFrame:SetFrameLevel(10)
GhostFrame:ClearAllPoints()
GhostFrame:SetPoint("BOTTOM", Minimap, "TOP", 0, 5)
GhostFrameContentsFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

-- LFDSearchStatus
local function UpdateLFGTooltip()
	local position = MinimapAnchor:GetPoint()
	LFDSearchStatus:ClearAllPoints()
	if position:match("BOTTOMRIGHT") then
		LFDSearchStatus:Point("BOTTOMRIGHT", MiniMapLFGFrame, "BOTTOMLEFT", 0, 0)
	elseif position:match("BOTTOM") then
		LFDSearchStatus:Point("BOTTOMLEFT", MiniMapLFGFrame, "BOTTOMRIGHT", 4, 0)
	elseif position:match("LEFT") then		
		LFDSearchStatus:Point("TOPLEFT", MiniMapLFGFrame, "TOPRIGHT", 4, 0)
	else
		LFDSearchStatus:Point("TOPRIGHT", MiniMapLFGFrame, "TOPLEFT", 0, 0)	
	end
end

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- Hide Game Time
MinimapAnchor:RegisterEvent("PLAYER_LOGIN")
MinimapAnchor:RegisterEvent("ADDON_LOADED")
MinimapAnchor:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		UpdateLFGTooltip()
	elseif addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:Kill()
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1,
		func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1,
		func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON, notCheckable = 1,
		func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end if not GlyphFrame then LoadAddOn("Blizzard_GlyphUI") end PlayerTalentFrame_Toggle() end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1,
		func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON, notCheckable = 1,
		func = function() ToggleFrame(QuestLogFrame) end},
	{text = SOCIAL_BUTTON, notCheckable = 1,
		func = function() ToggleFriendsFrame(1) end},
	{text = PLAYER_V_PLAYER, notCheckable = 1,
		func = function() ToggleFrame(PVPFrame) end},
	{text = ACHIEVEMENTS_GUILD_TAB, notCheckable = 1,
		func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() GuildFrame_TabClicked(GuildFrameTab2) end end},
	{text = LFG_TITLE, notCheckable = 1,
		func = function() ToggleFrame(LFDParentFrame) end},
	{text = LOOKING_FOR_RAID, notCheckable = 1,
		func = function() ToggleFrame(LFRParentFrame) end},
	{text = HELP_BUTTON, notCheckable = 1,
		func = function() ToggleHelpFrame() end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1,
		func = function() if not CalendarFrame then LoadAddOn("Blizzard_Calendar") end Calendar_Toggle() end},
}

local addonmenu = {
	{text = "Damage Meters", isTitle = 1, notCheckable = 1, keepShownOnClick = 1},
	{text = "alDamageMeter", notCheckable = 1,
		func = function() if IsAddOnLoaded("alDamageMeter") then ToggleFrame(alDamageMeterFrame) end end},
	{text = "Skada", notCheckable = 1,
		func = function() if IsAddOnLoaded("Skada") then Skada:ToggleWindow() end end},
	{text = "Recount", notCheckable = 1,
		func = function() if IsAddOnLoaded("Recount") then ToggleFrame(Recount.MainWindow) Recount.RefreshMainWindow() end end},
	{text = "TinyDPS", notCheckable = 1,
		func = function() if IsAddOnLoaded("TinyDPS") then ToggleFrame(tdpsFrame) end end},
	{text = "Threat Meters", isTitle = 1, notCheckable = 1, keepShownOnClick = 1},
	{text = "Omen", notCheckable = 1,
		func = function() if IsAddOnLoaded("Omen") then ToggleFrame(Omen.Anchor) end end},
	{text = "Boss addons", isTitle = 1, notCheckable = 1, keepShownOnClick = 1},
	{text = "DBM", notCheckable = 1,
		func = function() if IsAddOnLoaded("DBM-Core") then DBM:LoadGUI() end end},
	{text = "DXE", notCheckable = 1,
		func = function() if IsAddOnLoaded("DXE") then DXE:ToggleConfig() end end},
	{text = "Other addons", isTitle = 1, notCheckable = 1, keepShownOnClick = 1},
	{text = "Archy", notCheckable = 1,
		func = function() if IsAddOnLoaded("Archy") then ToggleFrame(ArchyDigSiteFrame) end end},
	{text = "AtlasLoot", notCheckable = 1,
		func = function() if IsAddOnLoaded("AtlasLoot") then ToggleFrame(AtlasLootDefaultFrame) end end},
	{text = "PhoenixStyle", notCheckable = 1,
		func = function() if IsAddOnLoaded("PhoenixStyle") then PS_MinimapButton:Click() end end},
	{text = "WIM", notCheckable = 1,
		func = function() if IsAddOnLoaded("WIM") then WIM.ShowAllWindows() end end},
}

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = MinimapAnchor:GetPoint()
	if button == "RightButton" and not InCombatLockdown() then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU", 2)
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "MiddleButton" then
		if position:match("LEFT") then
			EasyMenu(addonmenu, menuFrame, "cursor", 0, 0, "MENU", 2)
		else
			EasyMenu(addonmenu, menuFrame, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "LeftButton" then
		Minimap_OnClick(self)
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture(C.media.blank)

-- For others mods with a minimap button, set minimap buttons position in square mode
function GetMinimapShape() return "SQUARE" end

----------------------------------------------------------------------------------------
--	Hide minimap in combat
----------------------------------------------------------------------------------------
if C.minimap.hide_combat == true then
	MinimapAnchor:RegisterEvent("PLAYER_REGEN_ENABLED")
	MinimapAnchor:RegisterEvent("PLAYER_REGEN_DISABLED")
	MinimapAnchor:HookScript("OnEvent", function(self, event)
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
trackborder:Height(20)
trackborder:Width(20)
trackborder:Point("BOTTOMLEFT", MinimapAnchor, "BOTTOMLEFT", 2, 2)
if C.minimap.tracking_icon then
	trackborder:SetTemplate("ClassColor")
else
	MiniMapTrackingButton:SetAlpha(0)
	MiniMapTrackingIcon:SetAlpha(0)
end
MiniMapTracking:ClearAllPoints()
MiniMapTracking:Point("CENTER", trackborder, 2, -2)
MiniMapTrackingButton:SetHighlightTexture(nil)
MiniMapTrackingButtonBorder:Hide()
MiniMapTrackingIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
MiniMapTrackingIcon:Height(16)
MiniMapTrackingIcon:Width(16)

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
MinimapTrackingText:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
MinimapTrackingText:SetTextColor(T.color.r, T.color.g, T.color.b)
MinimapTrackingText:Point("CENTER", Minimap, 0, 35)
MinimapTrackingText:Width(Minimap:GetWidth() - 5)
MinimapTrackingText:SetAlpha(0)

Minimap:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	Minimap_GetTrackType()
	MinimapTrackingText:FadeIn()
end)

Minimap:SetScript("OnLeave", function()
	Minimap_GetTrackType()
	MinimapTrackingText:FadeOut()
end)

----------------------------------------------------------------------------------------
--	GUI icon on minimap
----------------------------------------------------------------------------------------
if C.general.minimap_icon == true and IsAddOnLoaded("ShestakUI_Config") then
	local menuIcon = CreateFrame("Button", "GUIButton", Minimap)
	menuIcon:SetTemplate("Transparent")
	menuIcon:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	menuIcon:Width(20)
	menuIcon:Height(20)
	menuIcon:SetMovable(true)
	menuIcon:RegisterForClicks("AnyUp")
	menuIcon:RegisterForDrag("LeftButton")
	menuIcon:SetFrameStrata("HIGH")
	menuIcon:Point("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -5, -2)
	
	local buttontexture = menuIcon:CreateTexture(nil, "BORDER")
	buttontexture:Point("CENTER", menuIcon)
	buttontexture:SetTexture("Interface\\CURSOR\\Interact")
	buttontexture:Height(18)
	buttontexture:Width(18)
	buttontexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	
	menuIcon:SetScript("OnClick", function(self, button)
		if IsShiftKeyDown() and button == "RightButton" then
			ReloadUI()
		else
			if button == "LeftButton" and not IsShiftKeyDown() then
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

	menuIcon:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and button == "LeftButton" then
			self:StartMoving()
			GameTooltip:Hide()
		end
	end)
	
	menuIcon:SetScript("OnMouseUp", menuIcon.StopMovingOrSizing)

	menuIcon:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:AddLine("ShestakUI "..T.version)
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
		{text = L_GUI_MINIMAP_ICON_SLASH, isTitle = 1, notCheckable = 1, keepShownOnClick = 1 },
		{text = L_GUI_MINIMAP_ICON_SPEC, notCheckable = 1,
		func = function() 
			local spec = GetActiveTalentGroup()
			if spec == 1 then 
				SetActiveTalentGroup(2) 
			elseif spec == 2 then 
				SetActiveTalentGroup(1) 
			end
		end},
		{text = L_GUI_MINIMAP_ICON_CL, notCheckable = 1, func = function() CombatLogClearEntries() end},
		{text = L_GUI_MINIMAP_ICON_DBM, notCheckable = 1, func = function() if IsAddOnLoaded("DBM-Core") then DBM:DemoMode() end end},
		{text = L_GUI_MINIMAP_ICON_HEAL, notCheckable = 1, func = function()
			DisableAddOn("ShestakUI_DPS")
			EnableAddOn("ShestakUI_Heal")
			ReloadUI()
		end},
		{text = L_GUI_MINIMAP_ICON_DPS, notCheckable = 1,
		func = function()
			DisableAddOn("ShestakUI_Heal")
			EnableAddOn("ShestakUI_DPS")
			ReloadUI()
		end},
		{text = "Move same UI elements (/moveui)", notCheckable = 1, func = function() T.moving() end},
	})
end