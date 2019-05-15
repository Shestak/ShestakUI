local T, C, L, _ = unpack(select(2, ...))
if C.minimap.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Minimap border
----------------------------------------------------------------------------------------
local MinimapAnchor = CreateFrame("Frame", "MinimapAnchor", UIParent)
MinimapAnchor:CreatePanel("ClassColor", C.minimap.size, C.minimap.size, unpack(C.position.minimap))

----------------------------------------------------------------------------------------
--	Shape, location and scale
----------------------------------------------------------------------------------------
-- Kill Minimap Cluster
MinimapCluster:Kill()

-- Parent Minimap into our frame
Minimap:SetParent(MinimapAnchor)
Minimap:ClearAllPoints()
Minimap:SetPoint("TOPLEFT", MinimapAnchor, "TOPLEFT", 2, -2)
Minimap:SetPoint("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", -2, 2)
Minimap:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())

MinimapBackdrop:ClearAllPoints()
MinimapBackdrop:SetPoint("TOPLEFT", MinimapAnchor, "TOPLEFT", 2, -2)
MinimapBackdrop:SetPoint("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", -2, 2)
MinimapBackdrop:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Blob Ring
if not T.classic then
	Minimap:SetArchBlobRingScalar(0)
	Minimap:SetQuestBlobRingScalar(0)
end

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Game Time
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 8, -10)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Mail.tga")
MiniMapMailIcon:SetSize(16, 16)

-- Move QueueStatus icon
if not T.classic then
	QueueStatusFrame:SetClampedToScreen(true)
	QueueStatusFrame:SetFrameStrata("TOOLTIP")
	QueueStatusMinimapButton:ClearAllPoints()
	QueueStatusMinimapButton:SetPoint("TOP", Minimap, "TOP", 1, 6)
	QueueStatusMinimapButton:SetHighlightTexture(nil)
	QueueStatusMinimapButtonBorder:Hide()
end

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- Garrison icon
if not T.classic then
	if C.minimap.garrison_icon == true then
		GarrisonLandingPageMinimapButton:ClearAllPoints()
		GarrisonLandingPageMinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 2)
		GarrisonLandingPageMinimapButton:SetSize(32, 32)
	else
		GarrisonLandingPageMinimapButton:SetScale(0.0001)
		GarrisonLandingPageMinimapButton:SetAlpha(0)
	end
end

-- Instance Difficulty icon
if not T.classic then
	MiniMapInstanceDifficulty:SetParent(Minimap)
	MiniMapInstanceDifficulty:ClearAllPoints()
	MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 2)
	MiniMapInstanceDifficulty:SetScale(0.75)
end

-- Guild Instance Difficulty icon
if not T.classic then
	GuildInstanceDifficulty:SetParent(Minimap)
	GuildInstanceDifficulty:ClearAllPoints()
	GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -2, 2)
	GuildInstanceDifficulty:SetScale(0.75)
end

-- Challenge Mode icon
if not T.classic then
	MiniMapChallengeMode:SetParent(Minimap)
	MiniMapChallengeMode:ClearAllPoints()
	MiniMapChallengeMode:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -2, -2)
	MiniMapChallengeMode:SetScale(0.75)
end

-- Invites icon
if not T.classic then
	GameTimeCalendarInvitesTexture:ClearAllPoints()
	GameTimeCalendarInvitesTexture:SetParent(Minimap)
	GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)
end

-- Default LFG icon
LFG_EYE_TEXTURES.raid = LFG_EYE_TEXTURES.default
LFG_EYE_TEXTURES.unknown = LFG_EYE_TEXTURES.default

-- Feedback icon
if FeedbackUIButton then
	FeedbackUIButton:ClearAllPoints()
	FeedbackUIButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 0)
	FeedbackUIButton:SetScale(0.8)
end

-- Streaming icon
if StreamingIcon then
	StreamingIcon:ClearAllPoints()
	StreamingIcon:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -10)
	StreamingIcon:SetScale(0.8)
	StreamingIcon:SetFrameStrata("BACKGROUND")
end

-- Ticket icon
HelpOpenTicketButton:SetParent(Minimap)
HelpOpenTicketButton:CreateBackdrop("ClassColor")
HelpOpenTicketButton:SetFrameLevel(4)
HelpOpenTicketButton:ClearAllPoints()
HelpOpenTicketButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 2)
HelpOpenTicketButton:SetHighlightTexture(nil)
HelpOpenTicketButton:SetPushedTexture("Interface\\Icons\\inv_misc_note_03")
HelpOpenTicketButton:SetNormalTexture("Interface\\Icons\\inv_misc_note_03")
HelpOpenTicketButton:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
HelpOpenTicketButton:GetPushedTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
HelpOpenTicketButton:SetSize(16, 16)

-- GhostFrame
if not T.classic then
	GhostFrame:StripTextures()
	GhostFrame:SetTemplate("Overlay")
	GhostFrame:StyleButton()
	GhostFrame:ClearAllPoints()
	GhostFrame:SetPoint(unpack(C.position.ghost))
	GhostFrameContentsFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	GhostFrameContentsFrameIcon:SetSize(34, 34)
	GhostFrameContentsFrame:SetFrameLevel(GhostFrameContentsFrame:GetFrameLevel() + 2)
	GhostFrameContentsFrame:CreateBackdrop("Overlay")
	GhostFrameContentsFrame.backdrop:SetPoint("TOPLEFT", GhostFrameContentsFrameIcon, -2, 2)
	GhostFrameContentsFrame.backdrop:SetPoint("BOTTOMRIGHT", GhostFrameContentsFrameIcon, 2, -2)
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
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:Kill()
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local guildText = IsInGuild() and ACHIEVEMENTS_GUILD_TAB or LOOKINGFORGUILD
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1, func = function()
		ToggleCharacter("PaperDollFrame")
	end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
		end
		ToggleFrame(SpellBookFrame)
	end},
	{text = TALENTS_BUTTON, notCheckable = 1, func = function()
		if not PlayerTalentFrame then
			TalentFrame_LoadUI()
		end
		if T.level >= SHOW_SPEC_LEVEL then
			if not T.classic then
				ShowUIPanel(PlayerTalentFrame)
			else
				ToggleTalentFrame()
			end
		else
			if C.error.white == false then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_SPEC_LEVEL), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_SPEC_LEVEL).."|r")
			end
		end
	end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1, func = function()
		ToggleAchievementFrame()
	end},
	{text = QUESTLOG_BUTTON, notCheckable = 1, func = function()
		ToggleQuestLog()
	end},
	{text = guildText, notCheckable = 1, func = function()
		ToggleGuildFrame()
	end},
	{text = SOCIAL_BUTTON, notCheckable = 1, func = function()
		ToggleFriendsFrame()
	end},
	{text = CHAT_CHANNELS, notCheckable = 1, func = function()
		ToggleChannelFrame()
	end},
	{text = PLAYER_V_PLAYER, notCheckable = 1, func = function()
		if T.level >= SHOW_PVP_LEVEL then
			TogglePVPUI()
		else
			if C.error.white == false then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL).."|r")
			end
		end
	end},
	{text = DUNGEONS_BUTTON, notCheckable = 1, func = function()
		if T.level >= SHOW_LFD_LEVEL then
			PVEFrame_ToggleFrame("GroupFinderFrame", nil)
		else
			if C.error.white == false then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_LFD_LEVEL), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_LFD_LEVEL).."|r")
			end
		end
	end},
	{text = ADVENTURE_JOURNAL, notCheckable = 1, func = function()
		if C_AdventureJournal.CanBeShown() then
			ToggleEncounterJournal()
		else
			if C.error.white == false then
				UIErrorsFrame:AddMessage(FEATURE_NOT_YET_AVAILABLE, 1, 0.1, 0.1)
			else
				print("|cffffff00"..FEATURE_NOT_YET_AVAILABLE.."|r")
			end
		end
	end},
	{text = COLLECTIONS, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
		end
		ToggleCollectionsJournal()
	end},
	{text = HELP_BUTTON, notCheckable = 1, func = function()
		ToggleHelpFrame()
	end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1, func = function()
		ToggleCalendar()
	end},
	{text = BATTLEFIELD_MINIMAP, notCheckable = 1, func = function()
		ToggleBattlefieldMap()
	end},
	{text = LOOT_ROLLS, notCheckable = 1, func = function()
		ToggleFrame(LootHistoryFrame)
	end},
}
if T.classic then
	tremove(micromenu, 14)
	tremove(micromenu, 12)
	tremove(micromenu, 11)
	tremove(micromenu, 10)
	tremove(micromenu, 9) -- remove once PvP is added in
	tremove(micromenu, 6)
	tremove(micromenu, 4)
end

if not T.classic and not IsTrialAccount() and not C_StorePublic.IsDisabledByParentalControls() then
	tinsert(micromenu, {text = BLIZZARD_STORE, notCheckable = 1, func = function() StoreMicroButton:Click() end})
end

if T.level > 99 then
	tinsert(micromenu, {text = ORDER_HALL_LANDING_PAGE_TITLE, notCheckable = 1, func = function() GarrisonLandingPage_Toggle() end})
elseif T.level > 89 then
	tinsert(micromenu, {text = GARRISON_LANDING_PAGE_TITLE, notCheckable = 1, func = function() GarrisonLandingPage_Toggle() end})
end

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = MinimapAnchor:GetPoint()
	if button == "RightButton" then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU")
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU")
		end
	elseif not T.classic and button == "MiddleButton" then
		if position:match("LEFT") then
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", 0, 0, "MENU", 2)
		else
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "LeftButton" then
		Minimap_OnClick(self)
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture(C.media.blank)
if not T.classic then
	Minimap:SetArchBlobRingAlpha(0)
	Minimap:SetQuestBlobRingAlpha(0)
end

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
if not T.classic then
	if C.minimap.tracking_icon then
		MiniMapTrackingBackground:Hide()
		MiniMapTracking:ClearAllPoints()
		MiniMapTracking:SetPoint("BOTTOMLEFT", MinimapAnchor, "BOTTOMLEFT", 0, -5)
		MiniMapTrackingButton:SetHighlightTexture(nil)
		MiniMapTrackingButtonBorder:Hide()
		MiniMapTrackingIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		MiniMapTrackingIcon:SetSize(16, 16)
		MiniMapTrackingIcon.SetPoint = T.dummy

		MiniMapTracking:CreateBackdrop("ClassColor")
		MiniMapTracking.backdrop:SetPoint("TOPLEFT", MiniMapTrackingIcon, -2, 2)
		MiniMapTracking.backdrop:SetPoint("BOTTOMRIGHT", MiniMapTrackingIcon, 2, -2)
	else
		MiniMapTracking:Hide()
	end
end