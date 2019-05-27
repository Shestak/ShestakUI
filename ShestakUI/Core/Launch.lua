local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	First Time Launch and On Login file
----------------------------------------------------------------------------------------
local function InstallUI()
	-- Don't need to set CVar multiple time
	SetCVar("screenshotQuality", 8)
	SetCVar("cameraDistanceMaxZoomFactor", 2.6)
	SetCVar("showTutorials", 0)
	SetCVar("gameTip", "0")
	SetCVar("UberTooltips", 1)
	SetCVar("chatMouseScroll", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("WhisperMode", "inline")
	SetCVar("colorblindMode", 0)
	SetCVar("lootUnderMouse", 0)
	SetCVar("autoLootDefault", 1)
	SetCVar("RotateMinimap", 0)
	SetCVar("autoQuestProgress", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("taintLog", 0)
	SetCVar("buffDurations", 1)
	SetCVar("autoOpenLootHistory", 0)
	if not T.classic then
		SetCVar("lossOfControl", 0)
		SetCVar("nameplateShowSelf", 0)
	end

	-- Setting chat frames
	if C.chat.enable == true and not (IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter")) then
		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()

			frame:SetSize(C.chat.width, C.chat.height)

			-- Default width and height of chats
			SetChatWindowSavedDimensions(chatFrameId, T.Scale(C.chat.width), T.Scale(C.chat.height))

			-- Move general chat to bottom left
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint(unpack(C.position.chat))
			end

			-- Save new default position and dimension
			FCF_SavePositionAndDimensions(frame)

			-- Set default font size
			FCF_SetChatWindowFontSize(nil, frame, 11)

			-- Rename general and combat log tabs
			if i == 1 then FCF_SetWindowName(frame, GENERAL) end
			if i == 2 then FCF_SetWindowName(frame, GUILD_BANK_LOG) end

			-- Lock them if unlocked
			if not frame.isLocked then FCF_SetLocked(frame, 1) end
		end

		-- Enable classcolor automatically on login and on each character without doing /configure each time
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	end

	-- Reset saved variables on char
	SavedPositions = {}
	SavedOptionsPerChar = {}

	SavedOptionsPerChar.Install = true
	SavedOptionsPerChar.FogOfWar = false
	SavedOptionsPerChar.Coords = false
	SavedOptionsPerChar.AutoInvite = false
	SavedOptionsPerChar.Archaeology = false
	SavedOptionsPerChar.BarsLocked = false
	SavedOptionsPerChar.SplitBars = true
	SavedOptionsPerChar.RightBars = C.actionbar.rightbars
	SavedOptionsPerChar.BottomBars = C.actionbar.bottombars

	if SavedOptions.RaidLayout ~= "UNKNOWN" then
		ReloadUI()
	else
		StaticPopup_Show("SWITCH_RAID")
	end
end

local function DisableUI()
	DisableAddOn("ShestakUI")
	ReloadUI()
end

----------------------------------------------------------------------------------------
--	Popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.INSTALL_UI = {
	text = L_POPUP_INSTALLUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = false
	if SavedOptions.RaidLayout == "UNKNOWN" then StaticPopup_Show("SWITCH_RAID") end end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

StaticPopupDialogs.DISABLE_UI = {
	text = L_POPUP_DISABLEUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableUI,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_UI = {
	text = L_POPUP_RESETUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = true end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_STATS = {
	text = L_POPUP_RESETSTATS,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() SavedStats = {} ReloadUI() end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.SWITCH_RAID = {
	text = L_POPUP_SWITCH_RAID,
	button1 = DAMAGER,
	button2 = HEALER,
	button3 = "Blizzard",
	OnAccept = function() SavedOptions.RaidLayout = "DPS" ReloadUI() end,
	OnCancel = function() SavedOptions.RaidLayout = "HEAL" ReloadUI() end,
	OnAlt = function() SavedOptions.RaidLayout = "NONE" ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("RESET_UI") end

SLASH_RESETSTATS1 = "/resetstats"
SlashCmdList.RESETSTATS = function() StaticPopup_Show("RESET_STATS") end

----------------------------------------------------------------------------------------
--	On logon function
----------------------------------------------------------------------------------------
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	-- Create empty CVar if they doesn't exist
	if SavedOptions == nil then SavedOptions = {} end
	if SavedPositions == nil then SavedPositions = {} end
	if SavedAddonProfiles == nil then SavedAddonProfiles = {} end
	if SavedOptionsPerChar == nil then SavedOptionsPerChar = {} end
	if SavedOptions.RaidLayout == nil then SavedOptions.RaidLayout = "UNKNOWN" end
	if SavedOptionsPerChar.FogOfWar == nil then SavedOptionsPerChar.FogOfWar = false end
	if SavedOptionsPerChar.Coords == nil then SavedOptionsPerChar.Coords = false end
	if SavedOptionsPerChar.AutoInvite == nil then SavedOptionsPerChar.AutoInvite = false end
	if SavedOptionsPerChar.Archaeology == nil then SavedOptionsPerChar.Archaeology = false end
	if SavedOptionsPerChar.BarsLocked == nil then SavedOptionsPerChar.BarsLocked = false end
	if SavedOptionsPerChar.SplitBars == nil then SavedOptionsPerChar.SplitBars = true end
	if SavedOptionsPerChar.RightBars == nil then SavedOptionsPerChar.RightBars = C.actionbar.rightbars end
	if SavedOptionsPerChar.BottomBars == nil then SavedOptionsPerChar.BottomBars = C.actionbar.bottombars end

	if T.screenWidth < 1024 and GetCVar("gxMonitor") == "0" then
		SetCVar("useUiScale", 0)
		StaticPopup_Show("DISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if C.general.uiscale > 1.28 then C.general.uiscale = 1.28 end

		-- Set our uiScale
		if tonumber(GetCVar("uiScale")) ~= tonumber(C.general.uiscale) then
			SetCVar("uiScale", C.general.uiscale)
		end

		-- Hack for 4K and WQHD Resolution
		if C.general.uiscale < 0.64 then
			UIParent:SetScale(C.general.uiscale)
		end

		-- Install default if we never ran ShestakUI on this character
		if not SavedOptionsPerChar.Install then
			StaticPopup_Show("INSTALL_UI")
		end
	end

	if SavedOptions.RaidLayout == "UNKNOWN" and SavedOptionsPerChar.Install then
		StaticPopup_Show("SWITCH_RAID")
	end

	-- Welcome message
	if C.general.welcome_message == true then
		print("|cffffff00"..L_WELCOME_LINE_1..T.version.." "..T.client..", "..T.name..".|r")
		print("|cffffff00"..L_WELCOME_LINE_2_1.." |cffffff00"..L_WELCOME_LINE_2_2.."|r")
		print("|cffffff00Please note that party & raid frames are currently disabled in this build due to a Blizzard bug. Using default party & raid frames for now.|r")
	end
end)
