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
	SetCVar("lossOfControl", 0)
	SetCVar("nameplateShowSelf", 0)

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
	ShestakUIPositions = {}
	ShestakUISettingsPerChar = {}

	ShestakUISettingsPerChar.Install = true
	ShestakUISettingsPerChar.FogOfWar = true
	ShestakUISettingsPerChar.Coords = true
	ShestakUISettingsPerChar.Archaeology = false
	ShestakUISettingsPerChar.BarsLocked = false
	ShestakUISettingsPerChar.SplitBars = true
	ShestakUISettingsPerChar.RightBars = C.actionbar.rightbars
	ShestakUISettingsPerChar.BottomBars = C.actionbar.bottombars

	if ShestakUISettings.RaidLayout ~= "UNKNOWN" then
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
	OnCancel = function() ShestakUISettingsPerChar.Install = false
	if ShestakUISettings.RaidLayout == "UNKNOWN" then StaticPopup_Show("SWITCH_RAID") end end,
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
	OnCancel = function() ShestakUISettingsPerChar.Install = true end,
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
	OnAccept = function() ShestakUIStats = {} ReloadUI() end,
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
	OnAccept = function() ShestakUISettings.RaidLayout = "DPS" ReloadUI() end,
	OnCancel = function() ShestakUISettings.RaidLayout = "HEAL" ReloadUI() end,
	OnAlt = function() ShestakUISettings.RaidLayout = "NONE" ReloadUI() end,
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
OnLogon:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	-- TODO delete old variable
	if SavedOptions then
		ShestakUISettings = SavedOptions
		SavedOptions = nil
	end

	if SavedStats then
		ShestakUIStats = SavedStats
		SavedStats = nil
	end

	if SavedBindings then
		ShestakUIBindings = SavedBindings
		SavedBindings = nil
	end

	if SavedCurrency then
		ShestakUICurrency = SavedCurrency
		SavedCurrency = nil
	end

	if ShestakUISettings == nil then ShestakUISettings = {} end
	if not ShestakUISettings.Migrated then
		if SavedOptionsPerChar then
			if SavedOptionsPerChar.UFPos then
				SavedPositions.UFPos = SavedOptionsPerChar.UFPos
				SavedOptionsPerChar.UFPos = nil
				StaticPopup_Show("INSTALL_UI")
			end
			ShestakUISettingsPerChar = SavedOptionsPerChar
			SavedOptionsPerChar = nil
		end

		if SavedPositions then
			ShestakUIPositions = SavedPositions
			SavedPositions = nil
		end

		ShestakUISettings.Migrated = true
	end

	-- Create empty CVar if they doesn't exist
	if ShestakUISettings == nil then ShestakUISettings = {} end
	if ShestakUIPositions == nil then ShestakUIPositions = {} end
	if ShestakUISettingsPerChar == nil then ShestakUISettingsPerChar = {} end
	if ShestakUISettings.RaidLayout == nil then ShestakUISettings.RaidLayout = "UNKNOWN" end
	if ShestakUISettingsPerChar.FogOfWar == nil then ShestakUISettingsPerChar.FogOfWar = true end
	if ShestakUISettingsPerChar.Coords == nil then ShestakUISettingsPerChar.Coords = true end
	if ShestakUISettingsPerChar.Archaeology == nil then ShestakUISettingsPerChar.Archaeology = false end
	if ShestakUISettingsPerChar.BarsLocked == nil then ShestakUISettingsPerChar.BarsLocked = false end
	if ShestakUISettingsPerChar.SplitBars == nil then ShestakUISettingsPerChar.SplitBars = true end
	if ShestakUISettingsPerChar.RightBars == nil then ShestakUISettingsPerChar.RightBars = C.actionbar.rightbars end
	if ShestakUISettingsPerChar.BottomBars == nil then ShestakUISettingsPerChar.BottomBars = C.actionbar.bottombars end

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
		if not ShestakUISettingsPerChar.Install then
			StaticPopup_Show("INSTALL_UI")
		end
	end

	if ShestakUISettings.RaidLayout == "UNKNOWN" and ShestakUISettingsPerChar.Install then
		StaticPopup_Show("SWITCH_RAID")
	end

	-- Welcome message
	if C.general.welcome_message == true then
		print("|cffffff00"..L_WELCOME_LINE_1..T.version.." "..T.client..", "..T.name..".|r")
		print("|cffffff00"..L_WELCOME_LINE_2_1.." |cffffff00"..L_WELCOME_LINE_2_2.."|r")
	end
end)
