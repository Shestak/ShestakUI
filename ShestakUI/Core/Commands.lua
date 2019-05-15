local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Slash commands
----------------------------------------------------------------------------------------
SlashCmdList.RELOADUI = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"
SLASH_RELOADUI2 = "/кд"
SLASH_RELOADUI3 = "//"
SLASH_RELOADUI4 = "/."

SlashCmdList.RCSLASH = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"
SLASH_RCSLASH2 = "/кс"

SlashCmdList.TICKET = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"
SLASH_TICKET2 = "/гм"
SLASH_TICKET3 = "/пь"

if not T.classic then
	SlashCmdList.JOURNAL = function() ToggleEncounterJournal() end
	SLASH_JOURNAL1 = "/ej"
	SLASH_JOURNAL2 = "/уо"
end

if not T.classic then
	SlashCmdList.ROLECHECK = function() InitiateRolePoll() end
	SLASH_ROLECHECK1 = "/role"
	SLASH_ROLECHECK2 = "/кщду"
end

SlashCmdList.CLEARCOMBAT = function() CombatLogClearEntries() end
SLASH_CLEARCOMBAT1 = "/clc"
SLASH_CLEARCOMBAT2 = "/сдс"

----------------------------------------------------------------------------------------
--	Description of the slash commands
----------------------------------------------------------------------------------------
SlashCmdList.UIHELP = function()
	for _, v in ipairs(L_SLASHCMD_HELP) do print("|cffffff00"..("%s"):format(tostring(v)).."|r") end
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
		if UnitInRaid("player") and (UnitIsGroupLeader("player")) then
			ConvertToParty()
		elseif UnitInParty("player") and (UnitIsGroupLeader("player")) then
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
if not T.classic then
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
end

----------------------------------------------------------------------------------------
--	Spec switching(by Monolit)
----------------------------------------------------------------------------------------
if not T.classic then
	SlashCmdList.SPEC = function(spec)
		if T.level >= SHOW_SPEC_LEVEL then
			if GetSpecialization() ~= tonumber(spec) then
				SetSpecialization(spec)
			end
		else
			print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_SPEC_LEVEL).."|r")
		end
	end
	SLASH_SPEC1 = "/ss"
	SLASH_SPEC2 = "/spec"
	SLASH_SPEC3 = "/ыы"
end

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
	if arg ~= nil and not arg:IsForbidden() and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		print("|cffCC0000--------------------------------------------------------------------|r")
		print("Name: |cffFFD100"..arg:GetName().."|r")
		if arg:GetParent() and arg:GetParent():GetName() then
			print("Parent: |cffFFD100"..arg:GetParent():GetName().."|r")
		end

		print("Width: |cffFFD100"..format("%.2f", arg:GetWidth()).."|r")
		print("Height: |cffFFD100"..format("%.2f", arg:GetHeight()).."|r")
		print("Strata: |cffFFD100"..arg:GetFrameStrata().."|r")
		print("Level: |cffFFD100"..arg:GetFrameLevel().."|r")

		if relativeTo and relativeTo:GetName() then
			print('Point: |cffFFD100 "'..point..'", '..relativeTo:GetName()..', "'..relativePoint..'"'.."|r")
		end
		if xOfs then
			print("X: |cffFFD100"..format("%.2f", xOfs).."|r")
		end
		if yOfs then
			print("Y: |cffFFD100"..format("%.2f", yOfs).."|r")
		end
		print("|cffCC0000--------------------------------------------------------------------|r")
	elseif arg == nil then
		print("Invalid frame name")
	else
		print("Could not find frame info")
	end
end
SLASH_FRAME1 = "/frame"
SLASH_FRAME2 = "/акфьу"

----------------------------------------------------------------------------------------
--	Print /framestack info in chat
----------------------------------------------------------------------------------------
SlashCmdList["FRAMELIST"] = function(msg)
	if not FrameStackTooltip then
		UIParentLoadAddOn("Blizzard_DebugTools")
	end

	local isPreviouslyShown = FrameStackTooltip:IsShown()
	if not isPreviouslyShown then
		if msg == tostring(true) then
			FrameStackTooltip_Toggle(true, true, true)
		else
			FrameStackTooltip_Toggle(false, true, true)
		end
	end

	print("|cffCC0000--------------------------------------------------------------------|r")
	for i = 2, FrameStackTooltip:NumLines() do
		local text = _G["FrameStackTooltipTextLeft"..i]:GetText()
		if text and text ~= "" then
			local r, g, b = _G["FrameStackTooltipTextLeft"..i]:GetTextColor()
			text = format("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, text)
			print(text)
		end
	end
	print("|cffCC0000--------------------------------------------------------------------|r")

	FrameStackTooltip_Toggle()
	SlashCmdList.COPY_CHAT()
end
SLASH_FRAMELIST1 = "/framelist"
SLASH_FRAMELIST2 = "/акфьудшые"
SLASH_FRAMELIST3 = "/fl"
SLASH_FRAMELIST4 = "/ад"

----------------------------------------------------------------------------------------
--	Frame Stack on Cyrillic
----------------------------------------------------------------------------------------
SlashCmdList.FSTACK = function()
	SlashCmdList.FRAMESTACK(0)
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
if not T.classic then
	SlashCmdList.TEST_ACHIEVEMENT = function()
		PlaySound(SOUNDKIT.LFG_REWARDS)
		if not AchievementFrame then
			AchievementFrame_LoadUI()
		end
		AchievementAlertSystem:AddAlert(112)
		CriteriaAlertSystem:AddAlert(9023, "Doing great!")
		GuildChallengeAlertSystem:AddAlert(3, 2, 5)
		InvasionAlertSystem:AddAlert(678, DUNGEON_FLOOR_THENEXUS1, true, 1, 1)
		WorldQuestCompleteAlertSystem:AddAlert(AlertFrameMixin:BuildQuestData(42114))
		-- GarrisonFollowerAlertSystem:AddAlert(32, "Dagg", 90, 2, true, C_Garrison.GetFollowerInfo(32)) -- error when mouseover
		-- GarrisonShipFollowerAlertSystem:AddAlert(592, "Ship", "Transport", "GarrBuilding_Barracks_1_H", 3, 2, 1) -- error when mouseover
		GarrisonBuildingAlertSystem:AddAlert(GARRISON_CACHE)
		GarrisonTalentAlertSystem:AddAlert(3, _G.C_Garrison.GetTalent(370))
		LegendaryItemAlertSystem:AddAlert("\124cffa335ee\124Hitem:18832:0:0:0:0:0:0:0:0:0:0\124h[Brutality Blade]\124h\124r")
		LootAlertSystem:AddAlert("\124cffa335ee\124Hitem:18832::::::::::\124h[Brutality Blade]\124h\124r", 1, 1, 100, 2, false, false, 0, false, false)
		LootUpgradeAlertSystem:AddAlert("\124cffa335ee\124Hitem:18832::::::::::\124h[Brutality Blade]\124h\124r", 1, 1, 1, nil, nil, false)
		MoneyWonAlertSystem:AddAlert(81500)
		StorePurchaseAlertSystem:AddAlert("", "Interface\\Icons\\Ability_pvp_gladiatormedallion", TRINKET0SLOT, 214)
		DigsiteCompleteAlertSystem:AddAlert("Human")
		NewRecipeLearnedAlertSystem:AddAlert(204)
	end
	SLASH_TEST_ACHIEVEMENT1 = "/tach"
	SLASH_TEST_ACHIEVEMENT2 = "/ефср"
end

----------------------------------------------------------------------------------------
--	Test Blizzard Extra Action Button
----------------------------------------------------------------------------------------
if not T.classic then
	SlashCmdList.TEST_EXTRABUTTON = function()
		if ExtraActionBarFrame:IsShown() then
			ExtraActionBarFrame:Hide()
		else
			ExtraActionBarFrame:Show()
			ExtraActionBarFrame:SetAlpha(1)
			ExtraActionButton1:Show()
			ExtraActionButton1:SetAlpha(1)
			ExtraActionButton1.icon:SetTexture("Interface\\Icons\\spell_deathknight_breathofsindragosa")
			ExtraActionButton1.icon:Show()
			ExtraActionButton1.icon:SetAlpha(1)
		end
	end
	SLASH_TEST_EXTRABUTTON1 = "/teb"
	SLASH_TEST_EXTRABUTTON2 = "/еуи"
end

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
				texture:SetColorTexture(1, 0, 0, 0.8)
			else
				texture:SetColorTexture(0, 0, 0, 0.8)
			end
			texture:SetPoint("TOPLEFT", grid, "TOPLEFT", i * width - 1, 0)
			texture:SetPoint("BOTTOMRIGHT", grid, "BOTTOMLEFT", i * width, 0)
		end
		for i = 0, 72 do
			local texture = grid:CreateTexture(nil, "BACKGROUND")
			if i == 36 then
				texture:SetColorTexture(1, 0, 0, 0.8)
			else
				texture:SetColorTexture(0, 0, 0, 0.8)
			end
			texture:SetPoint("TOPLEFT", grid, "TOPLEFT", 0, -i * height)
			texture:SetPoint("BOTTOMRIGHT", grid, "TOPRIGHT", 0, -i * height - 1)
		end
	end
end
SLASH_GRIDONSCREEN1 = "/align"
SLASH_GRIDONSCREEN2 = "/фдшпт"