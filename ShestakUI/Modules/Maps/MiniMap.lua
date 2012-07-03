local T, C, L = unpack(select(2, ...))
if C.minimap.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Minimap border
----------------------------------------------------------------------------------------
local MinimapAnchor = CreateFrame("Frame", "MinimapAnchor", UIParent)
MinimapAnchor:CreatePanel("ClassColor", C.minimap.size, C.minimap.size, "CENTER", UIParent, "CENTER", 0, 0)
MinimapAnchor:RegisterEvent("ADDON_LOADED")
MinimapAnchor:Point(unpack(C.position.minimap))

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
Minimap:Size(MinimapAnchor:GetWidth())

MinimapBackdrop:ClearAllPoints()
MinimapBackdrop:Point("TOPLEFT", MinimapAnchor, "TOPLEFT", 2, -2)
MinimapBackdrop:Point("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", -2, 2)
MinimapBackdrop:Size(MinimapAnchor:GetWidth())

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

-- Hide Game Time
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 8, -10)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Mail.tga")
MiniMapMailIcon:Size(16)

-- Move QueueStatus icon
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:Point("TOP", Minimap, "TOP", 1, 6)
QueueStatusMinimapButton:SetHighlightTexture(nil)
QueueStatusMinimapButtonBorder:Hide()

local function UpdateLFGTooltip()
	local position = MinimapAnchor:GetPoint()
	QueueStatusFrame:ClearAllPoints()
	if position:match("BOTTOMRIGHT") then
		QueueStatusFrame:Point("BOTTOMRIGHT", QueueStatusMinimapButton, "BOTTOMLEFT", 0, 0)
	elseif position:match("BOTTOM") then
		QueueStatusFrame:Point("BOTTOMLEFT", QueueStatusMinimapButton, "BOTTOMRIGHT", 4, 0)
	elseif position:match("LEFT") then
		QueueStatusFrame:Point("TOPLEFT", QueueStatusMinimapButton, "TOPRIGHT", 4, 0)
	else
		QueueStatusFrame:Point("TOPRIGHT", QueueStatusMinimapButton, "TOPLEFT", 0, 0)
	end
end
QueueStatusFrame:HookScript("OnShow", UpdateLFGTooltip)
QueueStatusFrame:SetFrameStrata("TOOLTIP")

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

-- Default LFG icon
--MiniMapLFGFrameGroupSize:Hide()
LFG_EYE_TEXTURES.raid = LFG_EYE_TEXTURES.default
LFG_EYE_TEXTURES.unknown = LFG_EYE_TEXTURES.default

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

-- Ticket icon
HelpOpenTicketButton:SetParent(Minimap)
HelpOpenTicketButton:ClearAllPoints()
HelpOpenTicketButton:Point("BOTTOM", Minimap, "BOTTOM", 0, -5)
HelpOpenTicketButton:SetHighlightTexture(nil)

-- GhostFrame
GhostFrameContentsFrame:SetTemplate("Overlay")
GhostFrameContentsFrame:Width(C.minimap.size)
GhostFrameContentsFrame:ClearAllPoints()
GhostFrameContentsFrame:SetPoint("CENTER")
GhostFrameContentsFrame.SetPoint = T.dummy
GhostFrame:ClearAllPoints()
GhostFrame:SetPoint("BOTTOM", Minimap, "TOP", 0, 5)
GhostFrameContentsFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

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
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:Kill()
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1, func = function()
		ToggleCharacter("PaperDollFrame")
	end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return
		end
		ToggleFrame(SpellBookFrame)
	end},
	{text = TALENTS_BUTTON, notCheckable = 1, func = function()
		if not PlayerTalentFrame then
			LoadAddOn("Blizzard_TalentUI")
		end
		if not GlyphFrame then
			LoadAddOn("Blizzard_GlyphUI")
		end
		if T.level >= SHOW_TALENT_LEVEL then
			PlayerTalentFrame_Toggle()
		else
			print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_TALENT_LEVEL).."|r")
		end
	end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1, func = function()
		ToggleAchievementFrame()
		--AchievementFrame_SetFilter(3)
	end},
	{text = QUESTLOG_BUTTON, notCheckable = 1, func = function()
		ToggleFrame(QuestLogFrame)
	end},
	{text = MOUNTS_AND_PETS, notCheckable = 1, func = function()
		TogglePetJournal()
	end},
	{text = SOCIAL_BUTTON, notCheckable = 1, func = function()
		ToggleFriendsFrame(1)
	end},
	{text = PLAYER_V_PLAYER, notCheckable = 1, func = function()
		if T.level >= SHOW_PVP_LEVEL then
			ToggleFrame(PVPFrame)
		else
			print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL).."|r")
		end
	end},
	{text = ACHIEVEMENTS_GUILD_TAB, notCheckable = 1, func = function()
		if IsInGuild() then
			if not GuildFrame then
				LoadAddOn("Blizzard_GuildUI")
			end
			ToggleGuildFrame()
			GuildFrame_TabClicked(GuildFrameTab2)
		else
			if not LookingForGuildFrame then
				LoadAddOn("Blizzard_LookingForGuildUI")
			end
			if not LookingForGuildFrame then return end
			LookingForGuildFrame_Toggle()
		end
	end},
	{text = LFG_TITLE, notCheckable = 1, func = function()
		if T.level >= SHOW_LFD_LEVEL then
			PVEFrame_ToggleFrame()
		else
			print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_LFD_LEVEL).."|r")
		end
	end},
	{text = LOOKING_FOR_RAID, notCheckable = 1, func = function()
		ToggleRaidFrame(3)
	end},
	{text = HELP_BUTTON, notCheckable = 1, func = function()
		ToggleHelpFrame()
	end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1, func = function()
		if not CalendarFrame then
			LoadAddOn("Blizzard_Calendar")
		end
		Calendar_Toggle()
	end},
	{text = BATTLEFIELD_MINIMAP, notCheckable = true, func = function()
		ToggleBattlefieldMinimap()
	end},
	{text = ENCOUNTER_JOURNAL, notCheckable = 1, func = function()
		if not IsAddOnLoaded("Blizzard_EncounterJournal") then
			LoadAddOn("Blizzard_EncounterJournal")
		end
		ToggleFrame(EncounterJournal)
	end},
}

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = MinimapAnchor:GetPoint()
	if button == "RightButton" then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU", 2)
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "MiddleButton" then
		if position:match("LEFT") then
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor", 0, 0, "MENU", 2)
		else
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "LeftButton" then
		Minimap_OnClick(self)
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture(C.media.blank)
Minimap:SetArchBlobRingAlpha(0)
Minimap:SetQuestBlobRingAlpha(0)

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
--	Tracking icon
----------------------------------------------------------------------------------------
if C.minimap.tracking_icon then
	local trackborder = CreateFrame("Frame", nil, UIParent)
	trackborder:SetFrameLevel(4)
	trackborder:SetFrameStrata("BACKGROUND")
	trackborder:Height(20)
	trackborder:Width(20)
	trackborder:Point("BOTTOMLEFT", MinimapAnchor, "BOTTOMLEFT", 2, 2)
	trackborder:SetTemplate("ClassColor")

	MiniMapTrackingBackground:Hide()
	MiniMapTracking:ClearAllPoints()
	MiniMapTracking:Point("CENTER", trackborder, 2, -2)
	MiniMapTrackingButton:SetHighlightTexture(nil)
	MiniMapTrackingButtonBorder:Hide()
	MiniMapTrackingIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	MiniMapTrackingIcon:Width(16)
	MiniMapTrackingIcon:Height(16)
else
	MiniMapTracking:Hide()
end