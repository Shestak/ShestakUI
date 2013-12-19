local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	First Time Launch and On Login file
----------------------------------------------------------------------------------------
local function InstallUI()
	-- Don't need to set CVar multiple time
	SetCVar("screenshotQuality", 8)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("showTutorials", 0)
	SetCVar("gameTip", "0")
	SetCVar("UberTooltips", 1)
	SetCVar("chatMouseScroll", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("WhisperMode", "inline")
	SetCVar("BnWhisperMode", "inline")
	SetCVar("colorblindMode", 0)
	SetCVar("lootUnderMouse", 0)
	SetCVar("autoLootDefault", 1)
	SetCVar("RotateMinimap", 0)
	SetCVar("ConsolidateBuffs", 0)
	SetCVar("autoQuestProgress", 1)
	SetCVar("scriptErrors", 0)
	SetCVar("taintLog", 0)
	SetCVar("buffDurations", 1)
	SetCVar("enableCombatText", 1)
	SetCVar("autoOpenLootHistory", 0)

	-- Setting chat frames
	if C.chat.enable == true and not (IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter")) then
		FCF_ResetChatWindows()
		FCF_OpenNewWindow(LOOT)
		FCF_SetLocked(ChatFrame3, 1)
		FCF_UnDockFrame(ChatFrame3)
		FCF_OpenNewWindow(CHANNELS)
		FCF_SetLocked(ChatFrame4, 1)
		FCF_DockFrame(ChatFrame4)
		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()
			local chatName = FCF_GetChatWindowInfo(chatFrameId)

			frame:SetSize(C.chat.width, C.chat.height)

			-- Default width and height of chats
			SetChatWindowSavedDimensions(chatFrameId, T.Scale(C.chat.width), T.Scale(C.chat.height))

			-- Move general chat to bottom left
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint(unpack(C.position.chat))
			elseif i == 3 then
				frame:ClearAllPoints()
				frame:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5])
				frame:SetJustifyH("RIGHT")
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

		ChatFrame_RemoveMessageGroup(ChatFrame1, "LOOT")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "CURRENCY")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "CHANNEL")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "MONEY")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "COMBAT_FACTION_CHANGE")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "SKILL")
		ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_GENERAL)
		ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_TRADE)
		ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_DEFENSE)
		ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_RECRUTMENT)
		ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_LFG)


		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame3, "SKILL")
		ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_GUILD_XP_GAIN")

		ChatFrame_RemoveAllMessageGroups(ChatFrame4)
		ChatFrame_AddChannel(ChatFrame4, L_CHAT_GENERAL)
		ChatFrame_AddChannel(ChatFrame4, L_CHAT_TRADE)
		ChatFrame_AddChannel(ChatFrame4, L_CHAT_DEFENSE)
		ChatFrame_AddChannel(ChatFrame4, L_CHAT_RECRUTMENT)
		ChatFrame_AddChannel(ChatFrame4, L_CHAT_LFG)

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
	
	SavedOptionsPerChar.FogOfWar = false
	SavedOptionsPerChar.AutoInvite = false
	SavedOptionsPerChar.Archaeology = false
	SavedOptionsPerChar.BarsLocked = false
	SavedOptionsPerChar.SplitBars = true
	SavedOptionsPerChar.LootFrame = true
	SavedOptionsPerChar.DamageMeter = false
	SavedOptionsPerChar.RightBars = C.actionbar.rightbars
	SavedOptionsPerChar.BottomBars = C.actionbar.bottombars
end

local function DisableUI()
	DisableAddOn("DarkShestakUI")
	ReloadUI()
end

local function PerChar(v)
	if GUIConfigAll then
		for realm, name in pairs(GUIConfigAll) do
			for name, value in pairs(GUIConfigAll[realm]) do
				GUIConfigAll[realm][name] = v
			end
		end
	end
end

local function SwitchLayout(layout)
	if SavedOptions.PerChar == true then
		SavedOptionsPerChar.RaidLayout = layout
	else
		SavedOptions.RaidLayout = layout
	end
end

local function ThemeSetup(r, g, b)
	if not GUIConfigAll then return end
	if GUIConfigAll[T.realm][T.name] == true then
		if GUIConfig == nil then GUIConfig = {} end
		if GUIConfig["skins"] == nil then GUIConfig["skins"] = {} end
		GUIConfig["skins"]["color_theme"] = {r, g, b}
	else
		if GUIConfigSettings == nil then GUIConfigSettings = {} end
		if GUIConfigSettings["skins"] == nil then GUIConfigSettings["skins"] = {} end
		GUIConfigSettings["skins"]["color_theme"] = {r, g, b}
	end
end

----------------------------------------------------------------------------------------
--	Setup Wizard(by Tukz)
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame", "DarkShestakUIInstallFrame", UIParent)
f:SetSize(540, 95)
f:SetPoint("CENTER", 0, 200)
f:SetTemplate("Transparent", "Shadow")
f:SetFrameStrata("FULLSCREEN_DIALOG")
f:Hide()

local head = CreateFrame("Frame", "DarkShestakUIInstallFrameHead", f)
head:SetSize(250, 30)
head:SetPoint("BOTTOM", f, "TOP", 0, -20)
head:SetTemplate("Default", "Shadow")
head:SetFrameLevel(f:GetFrameLevel() + 1)

local header = head:CreateFontString(nil, "OVERLAY")
header:SetFont(C.media.normal_font, 13, "OUTLINE")
header:SetPoint("CENTER", head, "CENTER", 0, 0)
local r, g, b = unpack(C.skins.color_theme)
header:SetText(format("|cff%02x%02x%02x%s %s|r", 255 * r, 255 * g, 255 * b, "Dark ShestakUI", T.version))

local text = f:CreateFontString(nil, "OVERLAY")
text:SetFont(C.media.normal_font, 13)
text:SetWidth(f:GetWidth() - 40)
text:SetPoint("CENTER", f, "CENTER", 0, 5)

local option1 = CreateFrame("Button", "DarkShestakUIInstallOption1", f)
option1:SetPoint("BOTTOM", f, "BOTTOM", 0, 7)
option1:SetSize(128, 25)
option1:SetTemplate("Overlay")
option1:FontString("Text", C.media.normal_font, 12)
option1.Text:SetTextColor(1, 0.82, 0)
option1.Text:SetPoint("CENTER")
option1:HookScript("OnEnter", T.SetModifiedBackdrop)
option1:HookScript("OnLeave", T.SetOriginalBackdrop)

local option2 = CreateFrame("Button", "DarkShestakUIInstallOption2", f)
option2:SetPoint("LEFT", option1, "RIGHT", 4, 0)
option2:SetSize(128, 25)
option2:SetTemplate("Overlay")
option2:FontString("Text", C.media.normal_font, 12)
option2.Text:SetTextColor(1, 0.82, 0)
option2.Text:SetPoint("CENTER")
option2:HookScript("OnEnter", T.SetModifiedBackdrop)
option2:HookScript("OnLeave", T.SetOriginalBackdrop)

local option3 = CreateFrame("Button", "DarkShestakUIInstallOption1", f)
option3:SetPoint("RIGHT", option1, "LEFT", -4, 0)
option3:SetSize(128, 25)
option3:SetTemplate("Overlay")
option3:FontString("Text", C.media.normal_font, 12)
option3.Text:SetTextColor(1, 0.82, 0)
option3.Text:SetPoint("CENTER")
option3:HookScript("OnEnter", T.SetModifiedBackdrop)
option3:HookScript("OnLeave", T.SetOriginalBackdrop)

local option4 = CreateFrame("Button", "DarkShestakUIInstallOption2", f)
option4:SetPoint("LEFT", option2, "RIGHT", 4, 0)
option4:SetSize(128, 25)
option4:SetTemplate("Overlay")
option4:FontString("Text", C.media.normal_font, 12)
option4.Text:SetTextColor(1, 0.82, 0)
option4.Text:SetPoint("CENTER")
option4:HookScript("OnEnter", T.SetModifiedBackdrop)
option4:HookScript("OnLeave", T.SetOriginalBackdrop)

local close = CreateFrame("Button", "DarkShestakUIInstallCloseButton", f, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", f, "TOPRIGHT")
T.SkinCloseButton(close)
close:SetScript("OnClick", function()
	SavedOptionsPerChar.Install = false
	f:Hide()
end)

local step4 = function()
	option2:Hide()
	option3:Hide()
	option4:Hide()
	
	option1:ClearAllPoints()
	option1:SetPoint("BOTTOM", f, "BOTTOM", 0, 7)
	
	text:SetText(L_INSTALL_STEP4)
	option1.Text:SetText(L_INSTALL_STEP4_RELOAD)
	
	option1:SetScript("OnClick", function()
		SavedOptionsPerChar.Install = true
		PlaySoundFile("Sound\\interface\\LevelUp.wav")
		ReloadUI()
	end)
end

local step3 = function()
	text:SetText(L_INSTALL_STEP3)
	option1.Text:SetText(L_INSTALL_STEP3_GREEN)
	option2.Text:SetText(L_INSTALL_STEP3_BLUE)
	option3.Text:SetText(L_INSTALL_STEP3_RED)
	
	if GUIConfigAll and GUIConfigAll[T.realm][T.name] == true then
		option4:Show()
		option1:ClearAllPoints()
		option1:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -2, 7)
		option4.Text:SetText(format("|cff%02x%02x%02x%s|r", 255 * T.color.r, 255 * T.color.g, 255 * T.color.b, L_INSTALL_STEP3_CLASS))
		option4:SetScript("OnClick", function()
			ThemeSetup(T.color.r, T.color.g, T.color.b)
			step4()
		end)
	end
	
	option1:SetScript("OnClick", function()
		ThemeSetup(0.3, 0.9, 0.3)
		step4()
	end)
	option2:SetScript("OnClick", function()
		ThemeSetup(0.1, 0.5, 0.9)
		step4()
	end)
	option3:SetScript("OnClick", function()
		ThemeSetup(0.9, 0.2, 0.2)
		step4()
	end)
end

local step2 = function()
	option2:Show()
	option3:Show()
	
	option1:ClearAllPoints()
	option1:SetPoint("BOTTOM", f, "BOTTOM", 0, 7)
	
	text:SetText(L_INSTALL_STEP2)
	option1.Text:SetText(HEALER)
	option2.Text:SetText(TANK.."/"..DAMAGER)
	option3.Text:SetText("Blizzard")

	option1:SetScript("OnClick", function()
		SwitchLayout("HEAL")
		if IsAddOnLoaded("DarkShestakUI_Config") then
			step3()
		else
			step4()
		end
	end)
	option2:SetScript("OnClick", function()
		SwitchLayout("DPS")
		if IsAddOnLoaded("DarkShestakUI_Config") then
			step3()
		else
			step4()
		end
	end)
	option3:SetScript("OnClick", function()
		SwitchLayout("NONE")
		if IsAddOnLoaded("DarkShestakUI_Config") then
			step3()
		else
			step4()
		end
	end)
end

local step1 = function()
	close:Hide()
	option2:Show()
	
	option1:ClearAllPoints()
	option1:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -2, 7)
	text:SetText(L_INSTALL_STEP1)
	
	option1.Text:SetText(L_INSTALL_STEP1_ACC)
	option2.Text:SetText(L_INSTALL_STEP1_CHAR)

	option1:SetScript("OnClick", function()
		SavedOptions.PerChar = false
		PerChar(false)
		step2()
	end)
	option2:SetScript("OnClick", function()
		SavedOptions.PerChar = true
		PerChar(true)
		step2()
	end)
end

local config = function()
	close:Hide()
	option2:Show()
	
	option1:ClearAllPoints()
	option1:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -2, 7)
	text:SetText(L_INSTALL_CONFIG)
	
	option1.Text:SetText(ACCEPT)
	option2.Text:SetText(DECLINE)

	option1:SetScript("OnClick", function()
		EnableAddOn("DarkShestakUI_Config")
		ReloadUI()
	end)
	option2:SetScript("OnClick", function()
		if SavedOptions.PerChar == nil then
			step1()
		elseif SavedOptions.PerChar == true then
			PerChar(true)
			step2()
		else
			PerChar(false)
			step4()
		end
	end)
end

local function Setup()
	f:Show()
	option1:Show()
	option2:Hide()
	option3:Hide()
	option4:Hide()
	close:Show()
	
	text:SetText(L_INSTALL_WELCOME.."\""..CONTINUE.."\".")
	option1.Text:SetText(CONTINUE)

	option1:SetScript("OnClick", function()
		InstallUI()
		if not IsAddOnLoaded("DarkShestakUI_Config") then
			config()
		elseif SavedOptions.PerChar == nil then
			step1()
		elseif SavedOptions.PerChar == true then
			PerChar(true)
			step2()
		else
			PerChar(false)
			step4()
		end
	end)
end

----------------------------------------------------------------------------------------
--	Popups
----------------------------------------------------------------------------------------

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

StaticPopupDialogs.DISABLE_OLD_ADDONS = {
	text = L_POPUP_DISABLE_OLD_ADDONS,
	button1 = ACCEPT,
	OnAccept = ReloadUI,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_UI = {
	text = L_POPUP_RESETUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() SavedOptionsPerChar.Install = false SavedOptions.PerChar = nil Setup() end,
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
	if SavedOptionsPerChar.AutoInvite == nil then SavedOptionsPerChar.AutoInvite = false end
	if SavedOptionsPerChar.Archaeology == nil then SavedOptionsPerChar.Archaeology = false end
	if SavedOptionsPerChar.BarsLocked == nil then SavedOptionsPerChar.BarsLocked = false end
	if SavedOptionsPerChar.SplitBars == nil then SavedOptionsPerChar.SplitBars = true end
	if SavedOptionsPerChar.RightBars == nil then SavedOptionsPerChar.RightBars = C.actionbar.rightbars end
	if SavedOptionsPerChar.BottomBars == nil then SavedOptionsPerChar.BottomBars = C.actionbar.bottombars end

	if T.getscreenwidth < 1024 and GetCVar("gxMonitor") == "0" then
		SetCVar("useUiScale", 0)
		StaticPopup_Show("DISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if C.general.multisampleprotect == true and GetCVar("gxMultisample") ~= "1" then
			SetMultisampleFormat(1)
		end
		if C.general.uiscale > 1.28 then C.general.uiscale = 1.28 end
		if C.general.uiscale < 0.64 then C.general.uiscale = 0.64 end

		-- Set our uiscale
		SetCVar("uiScale", C.general.uiscale)

		-- Install default if we never ran ShestakUI on this character
		if not SavedOptionsPerChar.Install then
			Setup()
		end
		
		if IsAddOnLoaded("DarkShestakUI_Heal") or IsAddOnLoaded("DarkShestakUI_DPS") then
			if IsAddOnLoaded("DarkShestakUI_Heal") then
				DisableAddOn("DarkShestakUI_Heal")
			end
		
			if IsAddOnLoaded("DarkShestakUI_DPS") then
				DisableAddOn("DarkShestakUI_DPS")
			end
		
			StaticPopup_Show("DISABLE_OLD_ADDONS")
		end
	end
	
	-- Welcome message
	if C.general.welcome_message == true then
		print("|cffffff00"..L_WELCOME_LINE_1..T.version.." "..T.client..", "..T.name..".|r")
		print("|cffffff00"..L_WELCOME_LINE_2_1.." |cffffff00"..L_WELCOME_LINE_2_2)
	end
end)