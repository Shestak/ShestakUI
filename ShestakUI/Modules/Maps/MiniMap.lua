local T, C, L, _ = unpack(select(2, ...))
if C.minimap.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Minimap border
----------------------------------------------------------------------------------------
local MinimapAnchor = CreateFrame("Frame", "MinimapAnchor", UIParent)
MinimapAnchor:CreatePanel("ClassColor", C.minimap.size, C.minimap.size, unpack(C.position.minimap))

-- Disable Minimap Cluster
MinimapCluster:EnableMouse(false)

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent(event)
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

	-- Instance Difficulty icon
	MinimapCluster.InstanceDifficulty:SetParent(Minimap)
	MinimapCluster.InstanceDifficulty:ClearAllPoints()
	MinimapCluster.InstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 1, 3)
	MinimapCluster.InstanceDifficulty.Instance.Border:Hide()
	MinimapCluster.InstanceDifficulty.Instance.Background:SetSize(28, 28)
	MinimapCluster.InstanceDifficulty.Instance.Background:SetVertexColor(0.6, 0.3, 0)

	-- Guild Instance Difficulty icon
	MinimapCluster.InstanceDifficulty.Guild.Border:Hide()
	MinimapCluster.InstanceDifficulty.Guild.Background:SetSize(28, 28)
	MinimapCluster.InstanceDifficulty.Guild.Background:ClearAllPoints()
	MinimapCluster.InstanceDifficulty.Guild.Background:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -1, 0)

	-- Challenge Mode icon
	MinimapCluster.InstanceDifficulty.ChallengeMode.Border:Hide()
	MinimapCluster.InstanceDifficulty.ChallengeMode.Background:SetSize(28, 28)
	MinimapCluster.InstanceDifficulty.ChallengeMode.Background:SetVertexColor(0.8, 0.8, 0)
	MinimapCluster.InstanceDifficulty.ChallengeMode.Background:ClearAllPoints()
	MinimapCluster.InstanceDifficulty.ChallengeMode.Background:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -1, 0)

	-- Move QueueStatus icon
	QueueStatusFrame:SetClampedToScreen(true)
	QueueStatusFrame:SetFrameStrata("TOOLTIP")
	QueueStatusButton:ClearAllPoints()
	QueueStatusButton:SetPoint("TOP", Minimap, "TOP", 1, -1)
	QueueStatusButton:SetParent(Minimap)
	QueueStatusButton:SetScale(0.5)

	-- Invites icon
	GameTimeCalendarInvitesTexture:ClearAllPoints()
	GameTimeCalendarInvitesTexture:SetParent(Minimap)
	GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -1, -4)
	GameTimeFrame:Hide() -- BETA Need another solution to keep showing calendar invites
end)

-- Adjusting for patch 9.0.1 Minimap.xml
Minimap:SetFrameStrata("LOW")
Minimap:SetFrameLevel(2)

-- Hide Border
MinimapCompassTexture:Hide()
MinimapCluster.BorderTop:StripTextures()

-- Hide Zoom Buttons
Minimap.ZoomIn:Kill()
Minimap.ZoomOut:Kill()

-- Hide Blob Ring
Minimap:SetArchBlobRingScalar(0)
Minimap:SetQuestBlobRingScalar(0)

-- Hide Zone Frame
MinimapCluster.ZoneTextButton:Hide()

-- Move Mail icon
MinimapCluster.MailFrame:ClearAllPoints()
MinimapCluster.MailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 4, -1)
MiniMapMailIcon:SetTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Mail.tga")
MiniMapMailIcon:SetSize(16, 16)

-- Garrison icon
if C.minimap.garrison_icon == true then
	ExpansionLandingPageMinimapButton:SetScale(0.75)
	hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIconForGarrison", function()
		ExpansionLandingPageMinimapButton:ClearAllPoints()
		ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -5, 2)
	end)
else
	ExpansionLandingPageMinimapButton:SetScale(0.0001)
	ExpansionLandingPageMinimapButton:SetAlpha(0)
end

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

-- GhostFrame
GhostFrame:StripTextures()
GhostFrame:SetTemplate("Overlay")
GhostFrame:StyleButton()
GhostFrame:ClearAllPoints()
GhostFrame:SetPoint(unpack(C.position.ghost))
GhostFrameContentsFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
GhostFrameContentsFrameIcon:SetSize(32, 32)
GhostFrameContentsFrame:SetFrameLevel(GhostFrameContentsFrame:GetFrameLevel() + 2)
GhostFrameContentsFrame:CreateBackdrop("Overlay")
GhostFrameContentsFrame.backdrop:SetPoint("TOPLEFT", GhostFrameContentsFrameIcon, -2, 2)
GhostFrameContentsFrame.backdrop:SetPoint("BOTTOMRIGHT", GhostFrameContentsFrameIcon, 2, -2)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(_, d)
	if d > 0 then
		_G.Minimap.ZoomIn:Click()
	elseif d < 0 then
		_G.Minimap.ZoomOut:Click()
	end
end)

-- Hide Game Time
MinimapAnchor:RegisterEvent("PLAYER_LOGIN")
MinimapAnchor:RegisterEvent("ADDON_LOADED")
MinimapAnchor:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:Kill()
	elseif addon == "Blizzard_HybridMinimap" then
		HybridMinimap:SetFrameStrata("BACKGROUND")
		HybridMinimap:SetFrameLevel(100)
		HybridMinimap.MapCanvas:SetUseMaskTexture(false)
		HybridMinimap.CircleMask:SetTexture("Interface\\BUTTONS\\WHITE8X8")
		HybridMinimap.MapCanvas:SetUseMaskTexture(true)
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local guildText = IsInGuild() and ACHIEVEMENTS_GUILD_TAB or LOOKINGFORGUILD
local journalText = T.client == "ruRU" and ENCOUNTER_JOURNAL or ADVENTURE_JOURNAL
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
		if T.level >= 10 then
			ShowUIPanel(PlayerTalentFrame)
		else
			if C.general.error_filter ~= "WHITELIST" then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10).."|r")
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
		if T.level >= 10 then
			TogglePVPUI()
		else
			if C.general.error_filter ~= "WHITELIST" then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10).."|r")
			end
		end
	end},
	{text = GROUP_FINDER, notCheckable = 1, func = function()
		if T.level >= 10 then
			PVEFrame_ToggleFrame("GroupFinderFrame", nil)
		else
			if C.general.error_filter ~= "WHITELIST" then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10).."|r")
			end
		end
	end},
	{text = journalText, notCheckable = 1, func = function()
		if C_AdventureJournal.CanBeShown() then
			ToggleEncounterJournal()
		else
			if C.general.error_filter ~= "WHITELIST" then
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
}

if not IsTrialAccount() and not C_StorePublic.IsDisabledByParentalControls() then
	tinsert(micromenu, {text = BLIZZARD_STORE, notCheckable = 1, func = function() StoreMicroButton:Click() end})
end

if T.level == MAX_PLAYER_LEVEL then
	tinsert(micromenu, {text = RATED_PVP_WEEKLY_VAULT, notCheckable = 1, func = function()
		if not WeeklyRewardsFrame then
			WeeklyRewards_LoadUI()
		end
		ToggleFrame(WeeklyRewardsFrame)
	end})
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("GARRISON_SHOW_LANDING_PAGE")
frame:SetScript("OnEvent", function()
	local textTitle
	local garrisonType = C_Garrison.GetLandingPageGarrisonType()
	if garrisonType == Enum.GarrisonType.Type_6_0 then
		textTitle = GARRISON_LANDING_PAGE_TITLE
	elseif garrisonType == Enum.GarrisonType.Type_7_0 then
		textTitle = ORDER_HALL_LANDING_PAGE_TITLE
	elseif garrisonType == Enum.GarrisonType.Type_8_0 then
		textTitle = GARRISON_TYPE_8_0_LANDING_PAGE_TITLE
	elseif garrisonType == Enum.GarrisonType.Type_9_0 then
		textTitle = GARRISON_TYPE_9_0_LANDING_PAGE_TITLE
	end

	if textTitle then
		tinsert(micromenu, {text = textTitle, notCheckable = 1, func = function() GarrisonLandingPage_Toggle() end})
	end
	frame:UnregisterAllEvents()
end)

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = MinimapAnchor:GetPoint()
	if button == "RightButton" then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU")
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU")
		end
	elseif button == "MiddleButton" then
		if position:match("LEFT") then
			ToggleDropDownMenu(1, nil, MinimapCluster.Tracking.DropDown, "cursor", 0, 0, "MENU", 2)
		else
			ToggleDropDownMenu(1, nil, MinimapCluster.Tracking.DropDown, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "LeftButton" then
		Minimap.OnClick(self)
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
			if not T.FarmMode then
				self:Hide()
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Tracking icon
----------------------------------------------------------------------------------------
if C.minimap.tracking_icon then
	MinimapCluster.Tracking.Background:Hide()
	MinimapCluster.Tracking:ClearAllPoints()
	MinimapCluster.Tracking:SetPoint("BOTTOMLEFT", MinimapAnchor, "BOTTOMLEFT", 5, 6)
	MinimapCluster.Tracking.Button:SetHighlightTexture(0)
	MinimapCluster.Tracking.Button:SetSize(16, 16)

	MinimapCluster.Tracking:CreateBackdrop("ClassColor")
	MinimapCluster.Tracking.backdrop:SetPoint("TOPLEFT", MinimapCluster.Tracking.Button, -2, 2)
	MinimapCluster.Tracking.backdrop:SetPoint("BOTTOMRIGHT", MinimapCluster.Tracking.Button, 2, -2)
else
	MinimapCluster.Tracking:Hide()
end

----------------------------------------------------------------------------------------
--	Move minimap on top
----------------------------------------------------------------------------------------
if C.minimap.on_top then
	MinimapAnchor:ClearAllPoints()
	MinimapAnchor:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -21, -21)
	BuffsAnchor:ClearAllPoints()
	BuffsAnchor:SetPoint("TOPRIGHT", MinimapAnchor, "TOPLEFT", -25, 0)

	LPSTAT_CONFIG.Location.tip_frame = MinimapAnchor
	LPSTAT_CONFIG.Location.tip_anchor = "BOTTOMRIGHT"
	LPSTAT_CONFIG.Location.tip_x = 0
	LPSTAT_CONFIG.Location.tip_y = -50

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:SetScript("OnEvent", function()
		frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if LP_Coords then
			LP_Coords:ClearAllPoints()
			LP_Coords:SetPoint("BOTTOMRIGHT", MinimapAnchor, "TOPRIGHT", 0, 5)
		end
		if TeleportMenu then
			TeleportMenu:ClearAllPoints()
			TeleportMenu:SetPoint("TOPLEFT", MinimapAnchor, "BOTTOMLEFT", 0, -13)
		end
		if RaidBuffsAnchor and not ShestakUIPositions[RaidBuffsAnchor:GetName()] then
			RaidBuffsAnchor:ClearAllPoints()
			RaidBuffsAnchor:SetPoint("TOPLEFT", MinimapAnchor, "BOTTOMLEFT", 0, -3)
		end
		if not ShestakUIPositions[VehicleAnchor:GetName()] then
			VehicleAnchor:ClearAllPoints()
			VehicleAnchor:SetPoint("TOP", Minimap, "BOTTOM", 0, -27)
		end
		if TooltipAnchor and not ShestakUIPositions[TooltipAnchor:GetName()] then
			TooltipAnchor:ClearAllPoints()
			TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 20)
		end

		GhostFrame:ClearAllPoints()
		GhostFrame:SetPoint("TOP", Minimap, "BOTTOM", 0, -5)

		if stArchaeologyFrame then
			stArchaeologyFrame:ClearAllPoints()
			stArchaeologyFrame:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 2, -5)
		end

		if AutoButtonAnchor and not ShestakUIPositions[AutoButtonAnchor:GetName()] then
			AutoButtonAnchor:ClearAllPoints()
			AutoButtonAnchor:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", -2, -27)
		end

		if AutoButtonAnchor and not ShestakUIPositions[AutoButtonAnchor:GetName()] then
			AutoButtonAnchor:ClearAllPoints()
			AutoButtonAnchor:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", -2, -27)
		end

		if StuffingFrameBags and not ShestakUIPositions[StuffingFrameBags:GetName()] then
			StuffingFrameBags:ClearAllPoints()
			StuffingFrameBags:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 20)
		end

		if TTMenuBackground then
			TTMenuBackground:ClearAllPoints()
			TTMenuBackground:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 2, -5)

			TTOpenMenuBackground:ClearAllPoints()
			TTOpenMenuBackground:SetPoint("TOP", Minimap, "BOTTOM", 0, -5)

			TTMenuAddOnBackground:ClearAllPoints()
			TTMenuAddOnBackground:SetPoint("TOP", TTMenuBackground, "TOP", 0, 0)
		end
	end)
end