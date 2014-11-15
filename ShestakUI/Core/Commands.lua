local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Slash commands
----------------------------------------------------------------------------------------
SlashCmdList.RELOADUI = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"
SLASH_RELOADUI2 = "/кд"

SlashCmdList.RCSLASH = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"
SLASH_RCSLASH2 = "/кс"

SlashCmdList.TICKET = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"
SLASH_TICKET2 = "/гм"
SLASH_TICKET3 = "/пь"

SlashCmdList.JOURNAL = function() ToggleEncounterJournal() end
SLASH_JOURNAL1 = "/ej"
SLASH_JOURNAL2 = "/уо"

SlashCmdList.ROLECHECK = function() InitiateRolePoll() end
SLASH_ROLECHECK1 = "/role"
SLASH_ROLECHECK2 = "/кщду"

SlashCmdList.SHOWCLOAK = function() if ShowingCloak() then ShowCloak(false) else ShowCloak() end end
SLASH_SHOWCLOAK1 = "/showcloak"
SLASH_SHOWCLOAK2 = "/sc"
SLASH_SHOWCLOAK3 = "/ыс"

SlashCmdList.SHOWHELM = function() if ShowingHelm() then ShowHelm(false) else ShowHelm() end end
SLASH_SHOWHELM1 = "/showhelm"
SLASH_SHOWHELM2 = "/sh"
SLASH_SHOWHELM3 = "/ыр"

SlashCmdList.CLEARCOMBAT = function() CombatLogClearEntries() end
SLASH_CLEARCOMBAT1 = "/clc"
SLASH_CLEARCOMBAT2 = "/сдс"

----------------------------------------------------------------------------------------
--	Description of the slash commands
----------------------------------------------------------------------------------------
SlashCmdList.UIHELP = function()
	for i, v in ipairs(L_SLASHCMD_HELP) do print("|cffffff00"..("%s"):format(tostring(v)).."|r") end
end
SLASH_UIHELP1 = "/uihelp"
SLASH_UIHELP2 = "/helpui"
SLASH_UIHELP3 = "/гшрудз"

----------------------------------------------------------------------------------------
--	Enable/Disable addons
----------------------------------------------------------------------------------------
SlashCmdList.DISABLE_ADDON = function(addon)
	local _, _, _, _, _, reason = GetAddOnInfo(addon)
	if reason ~= "MISSING" then
		DisableAddOn(addon)
		ReloadUI()
	else
		print("|cffffff00"..L_TOGGLE_ADDON.."'"..addon.."'"..L_TOGGLE_NOT_FOUND.."|r")
	end
end
SLASH_DISABLE_ADDON1 = "/dis"
SLASH_DISABLE_ADDON2 = "/disable"

SlashCmdList.ENABLE_ADDON = function(addon)
	local _, _, _, _, _, reason = GetAddOnInfo(addon)
	if reason ~= "MISSING" then
		EnableAddOn(addon)
		LoadAddOn(addon)
		ReloadUI()
	else
		print("|cffffff00"..L_TOGGLE_ADDON.."'"..addon.."'"..L_TOGGLE_NOT_FOUND.."|r")
	end
end
SLASH_ENABLE_ADDON1 = "/en"
SLASH_ENABLE_ADDON2 = "/enable"

----------------------------------------------------------------------------------------
--	Disband party or raid(by Monolit)
----------------------------------------------------------------------------------------
function DisbandRaidGroup()
	if InCombatLockdown() then return end
	if UnitInRaid("player") then
		SendChatMessage(L_INFO_DISBAND, "RAID")
		for i = 1, GetNumGroupMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= T.name then
				UninviteUnit(name)
			end
		end
	else
		SendChatMessage(L_INFO_DISBAND, "PARTY")
		for i = MAX_PARTY_MEMBERS, 1, -1 do
			if GetNumGroupMembers(i) then
				UninviteUnit(UnitName("party"..i))
			end
		end
	end
	LeaveParty()
end

StaticPopupDialogs.DISBAND_RAID = {
	text = L_POPUP_DISBAND_RAID,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisbandRaidGroup,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

SlashCmdList.GROUPDISBAND = function()
	StaticPopup_Show("DISBAND_RAID")
end
SLASH_GROUPDISBAND1 = "/rd"
SLASH_GROUPDISBAND2 = "/кв"

----------------------------------------------------------------------------------------
--	Convert party to raid
----------------------------------------------------------------------------------------
SlashCmdList.PARTYTORAID = function()
	if GetNumGroupMembers() > 0 then
		if UnitInRaid("player") and IsGroupLeader() then
			ConvertToParty()
		elseif UnitInParty("player") and IsGroupLeader() then
			ConvertToRaid()
		end
	else
		print("|cffffff00"..ERR_NOT_IN_GROUP.."|r")
	end
end
SLASH_PARTYTORAID1 = "/toraid"
SLASH_PARTYTORAID2 = "/toparty"
SLASH_PARTYTORAID3 = "/convert"
SLASH_PARTYTORAID4 = "/сщтмуке"

----------------------------------------------------------------------------------------
--	Instance teleport
----------------------------------------------------------------------------------------
SlashCmdList.INSTTELEPORT = function()
	local inInstance = IsInInstance()
	if inInstance then
		LFGTeleport(true)
	else
		LFGTeleport()
	end
end
SLASH_INSTTELEPORT1 = "/teleport"
SLASH_INSTTELEPORT2 = "/еудузщке"

----------------------------------------------------------------------------------------
--	Spec switching(by Monolit)
----------------------------------------------------------------------------------------
SlashCmdList.SPEC = function()
	if T.level >= SHOW_TALENT_LEVEL then
		local spec = GetActiveSpecGroup()
		if spec == 1 then SetActiveSpecGroup(2) elseif spec == 2 then SetActiveSpecGroup(1) end
	else
		print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_TALENT_LEVEL).."|r")
	end
end
SLASH_SPEC1 = "/ss"
SLASH_SPEC2 = "/spec"
SLASH_SPEC3 = "/ыы"

----------------------------------------------------------------------------------------
--	Demo mode for DBM
----------------------------------------------------------------------------------------
SlashCmdList.DBMTEST = function() if IsAddOnLoaded("DBM-Core") then DBM:DemoMode() end end
SLASH_DBMTEST1 = "/dbmtest"
SLASH_DBMTEST2 = "/виьеуые"

----------------------------------------------------------------------------------------
--	Switch to heal layout
----------------------------------------------------------------------------------------
SlashCmdList.HEAL = function()
	SavedOptions.RaidLayout = "HEAL"
	ReloadUI()
end
SLASH_HEAL1 = "/heal"
SLASH_HEAL2 = "/руфд"

----------------------------------------------------------------------------------------
--	Switch to dps layout
----------------------------------------------------------------------------------------
SlashCmdList.DPS = function()
	SavedOptions.RaidLayout = "DPS"
	ReloadUI()
end
SLASH_DPS1 = "/dps"
SLASH_DPS2 = "/взы"

----------------------------------------------------------------------------------------
--	Command to show frame you currently have mouseovered
----------------------------------------------------------------------------------------
SlashCmdList.FRAME = function(arg)
	if arg ~= "" then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end
	if arg ~= nil then FRAME = arg end
	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		ChatFrame1:AddMessage("Name: |cffFFD100"..arg:GetName())
		if arg:GetParent() and arg:GetParent():GetName() then
			ChatFrame1:AddMessage("Parent: |cffFFD100"..arg:GetParent():GetName())
		end

		ChatFrame1:AddMessage("Width: |cffFFD100"..format("%.2f", arg:GetWidth()))
		ChatFrame1:AddMessage("Height: |cffFFD100"..format("%.2f", arg:GetHeight()))
		ChatFrame1:AddMessage("Strata: |cffFFD100"..arg:GetFrameStrata())
		ChatFrame1:AddMessage("Level: |cffFFD100"..arg:GetFrameLevel())

		if relativeTo and relativeTo:GetName() then
			ChatFrame1:AddMessage("Point: |cffFFD100"..point.."|r anchored to "..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		if xOfs then
			ChatFrame1:AddMessage("X: |cffFFD100"..format("%.2f", xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage("Y: |cffFFD100"..format("%.2f", yOfs))
		end
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	elseif arg == nil then
		ChatFrame1:AddMessage("Invalid frame name")
	else
		ChatFrame1:AddMessage("Could not find frame info")
	end
end
SLASH_FRAME1 = "/frame"
SLASH_FRAME2 = "/акфьу"

----------------------------------------------------------------------------------------
--	Frame Stack on Cyrillic
----------------------------------------------------------------------------------------
SlashCmdList.FSTACK = function()
	SlashCmdList.FRAMESTACK()
end
SLASH_FSTACK1 = "/аыефсл"
SLASH_FSTACK2 = "/fs"
SLASH_FSTACK3 = "/аы"

----------------------------------------------------------------------------------------
--	Clear chat
----------------------------------------------------------------------------------------
SlashCmdList.CLEAR_CHAT = function()
	for i = 1, NUM_CHAT_WINDOWS do
		_G[format("ChatFrame%d", i)]:Clear()
	end
end
SLASH_CLEAR_CHAT1 = "/clear"
SLASH_CLEAR_CHAT2 = "/сдуфк"

----------------------------------------------------------------------------------------
--	Test Blizzard Alerts
----------------------------------------------------------------------------------------
SlashCmdList.TEST_ACHIEVEMENT = function()
	PlaySound("LFG_Rewards")
	if not AchievementFrame then
		AchievementFrame_LoadUI()
	end
	AchievementAlertFrame_ShowAlert(4912)
	AchievementAlertFrame_ShowAlert(6193)
	GuildChallengeAlertFrame_ShowAlert(3, 2, 5)
	CriteriaAlertFrame_ShowAlert(6301, 29918)
	MoneyWonAlertFrame_ShowAlert(9999999)
	LootWonAlertFrame_ShowAlert(select(2, GetItemInfo(6948)) or GetInventoryItemLink("player", 5), -1, 1, 100)
	ChallengeModeAlertFrame_ShowAlert()
	AlertFrame_AnimateIn(ScenarioAlertFrame1)
	--GarrisonMissionAlertFrame_ShowAlert(missionID)
	StorePurchaseAlertFrame_ShowAlert(select(3, GetSpellInfo(2060)), GetSpellInfo(2060), 2060)
	LootUpgradeFrame_ShowAlert(select(2, GetItemInfo(6948)) or GetInventoryItemLink("player", 5), 1, 1, 1)
	GarrisonBuildingAlertFrame_ShowAlert(T.name)
	--GarrisonFollowerAlertFrame_ShowAlert(followerID, name, displayID, level, quality, isUpgraded)
	AlertFrame_FixAnchors()
end
SLASH_TEST_ACHIEVEMENT1 = "/tach"
SLASH_TEST_ACHIEVEMENT2 = "/ефср"

----------------------------------------------------------------------------------------
--	Test and move Blizzard Extra Action Button
----------------------------------------------------------------------------------------
SlashCmdList.TEST_EXTRABUTTON = function()
	if ExtraActionBarFrame:IsShown() then
		ExtraActionBarFrame:Hide()
	else
		ExtraActionBarFrame:Show()
		ExtraActionBarFrame:SetAlpha(1)
		ExtraActionButton1:Show()
		ExtraActionButton1:SetAlpha(1)
		ExtraActionButton1.icon:SetTexture("Interface\\Icons\\INV_Pet_DiseasedSquirrel")
		ExtraActionButton1.icon:Show()
		ExtraActionButton1.icon:SetAlpha(1)
	end
end
SLASH_TEST_EXTRABUTTON1 = "/teb"
SLASH_TEST_EXTRABUTTON2 = "/еуи"

----------------------------------------------------------------------------------------
--	Grid on screen
----------------------------------------------------------------------------------------
local grid
SlashCmdList.GRIDONSCREEN = function()
	if grid then
		grid:Hide()
		grid = nil
	else
		grid = CreateFrame("Frame", nil, UIParent)
		grid:SetAllPoints(UIParent)
		local width = GetScreenWidth() / 128
		local height = GetScreenHeight() / 72
		for i = 0, 128 do
			local texture = grid:CreateTexture(nil, "BACKGROUND")
			if i == 64 then
				texture:SetTexture(1, 0, 0, 0.8)
			else
				texture:SetTexture(0, 0, 0, 0.8)
			end
			texture:SetPoint("TOPLEFT", grid, "TOPLEFT", i * width - 1, 0)
			texture:SetPoint("BOTTOMRIGHT", grid, "BOTTOMLEFT", i * width, 0)
		end
		for i = 0, 72 do
			local texture = grid:CreateTexture(nil, "BACKGROUND")
			if i == 36 then
				texture:SetTexture(1, 0, 0, 0.8)
			else
				texture:SetTexture(0, 0, 0, 0.8)
			end
			texture:SetPoint("TOPLEFT", grid, "TOPLEFT", 0, -i * height)
			texture:SetPoint("BOTTOMRIGHT", grid, "TOPRIGHT", 0, -i * height - 1)
		end
	end
end
SLASH_GRIDONSCREEN1 = "/align"
SLASH_GRIDONSCREEN2 = "/фдшпт"