local T, C, L = unpack(select(2, ...))

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

----------------------------------------------------------------------------------------
--	Description of the slash commands
----------------------------------------------------------------------------------------
local function Print(text)
	DEFAULT_CHAT_FRAME:AddMessage(("%s"):format(tostring(text)), 1, 1, 0)
end

SlashCmdList.UIHELP = function()
	for i, v in ipairs(L_SLASHCMD_HELP) do Print(v) end
end
SLASH_UIHELP1 = "/uihelp"
SLASH_UIHELP2 = "/helpui"
SLASH_UIHELP3 = "/гшрудз"

----------------------------------------------------------------------------------------
--	Enable/Disable addons
----------------------------------------------------------------------------------------
SlashCmdList.DISABLE_ADDON = function(addon) 
	local _, _, _, _, _, reason, _ = GetAddOnInfo(addon)
	if reason ~= "MISSING" then
		DisableAddOn(addon)
		ReloadUI()
	else
		print("|cffffff00"..L_TOGGLE_ADDON.."'"..addon.."' not found.|r")
	end
end
SLASH_DISABLE_ADDON1 = "/dis"
SLASH_DISABLE_ADDON2 = "/disable"

SlashCmdList.ENABLE_ADDON = function(addon)
	local _, _, _, _, _, reason, _ = GetAddOnInfo(addon)
	if reason ~= "MISSING" then
		EnableAddOn(addon)
		LoadAddOn(addon)
		ReloadUI()
	else
		print("|cffffff00"..L_TOGGLE_ADDON.."'"..addon.."' not found.|r")
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
		for i = 1, GetNumRaidMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= T.name then
				UninviteUnit(name)
			end
		end
	else
		SendChatMessage(L_INFO_DISBAND, "PARTY")
		for i = MAX_PARTY_MEMBERS, 1, -1 do
			if GetPartyMember(i) then
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
	preferredIndex = 3,
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
	if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
		if UnitInRaid("player") and IsRaidLeader() then
			ConvertToParty()
		elseif UnitInParty("player") and IsPartyLeader() then
			ConvertToRaid()
		end
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
	local inInstance, _ = IsInInstance()
	if inInstance then
		LFGTeleport(true)
	else
		LFGTeleport()
	end
end
SLASH_INSTTELEPORT1 = "/teleport"
SLASH_INSTTELEPORT2 = "/еудузщке"

----------------------------------------------------------------------------------------
--	Enable lua error
----------------------------------------------------------------------------------------
SlashCmdList.LUAERROR = function (msg, editbox)
	if (msg == "on") then
		SetCVar("scriptErrors", 1)
		ReloadUI()
	elseif (msg == "off") then
		SetCVar("scriptErrors", 0)
	else
		print("|cffffff00".."/luaerror on - /luaerror off".."|r")
	end
end
SLASH_LUAERROR1 = "/luaerror"
SLASH_LUAERROR2 = "/дгфуккщк"

----------------------------------------------------------------------------------------
--	Spec switching(by Monolit)
----------------------------------------------------------------------------------------
SlashCmdList.SPEC = function()
	if T.level >= SHOW_TALENT_LEVEL then
		local spec = GetActiveTalentGroup()
		if spec == 1 then SetActiveTalentGroup(2) elseif spec == 2 then SetActiveTalentGroup(1) end
	else
		print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_TALENT_LEVEL).."|r")
	end
end
SLASH_SPEC1 = "/ss"
SLASH_SPEC2 = "/spec"
SLASH_SPEC3 = "/ыы"

----------------------------------------------------------------------------------------
--	Fix combatlog after a crash (2.4 and 3.3.2 bug)
----------------------------------------------------------------------------------------
SlashCmdList.CLFIX = function() CombatLogClearEntries() end
SLASH_CLFIX1 = "/clfix"
SLASH_CLFIX2 = "/сдашч"

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
	DisableAddOn("ShestakUI_DPS")
	EnableAddOn("ShestakUI_Heal")
	ReloadUI()
end
SLASH_HEAL1 = "/heal"
SLASH_HEAL2 = "/руфд"

----------------------------------------------------------------------------------------
--	Switch to dps layout
----------------------------------------------------------------------------------------
SlashCmdList.DPS = function()
	DisableAddOn("ShestakUI_Heal")
	EnableAddOn("ShestakUI_DPS")
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
--	Addons group
----------------------------------------------------------------------------------------
SlashCmdList.CHANGEADDONS = function(s)
	if(s and s == "raid") then
		for i in pairs(C.addon.party) do
			DisableAddOn(C.addon.party[i])
		end
		for i in pairs(C.addon.pvp) do
			DisableAddOn(C.addon.pvp[i])
		end
		for i in pairs(C.addon.quest) do
			DisableAddOn(C.addon.quest[i])
		end
		for i in pairs(C.addon.trade) do
			DisableAddOn(C.addon.trade[i])
		end
		for i in pairs(C.addon.raid) do
			EnableAddOn(C.addon.raid[i])
		end
		ReloadUI()
	elseif(s and s == "party") then
		for i in pairs(C.addon.raid) do
			DisableAddOn(C.addon.raid[i])
		end
		for i in pairs(C.addon.pvp) do
			DisableAddOn(C.addon.pvp[i])
		end
		for i in pairs(C.addon.quest) do
			DisableAddOn(C.addon.quest[i])
		end
		for i in pairs(C.addon.trade) do
			DisableAddOn(C.addon.trade[i])
		end
		for i in pairs(C.addon.party) do
			EnableAddOn(C.addon.party[i])
		end
		ReloadUI()
	elseif(s and s == "pvp") then
		for i in pairs(C.addon.raid) do
			DisableAddOn(C.addon.raid[i])
		end
		for i in pairs(C.addon.party) do
			DisableAddOn(C.addon.party[i])
		end
		for i in pairs(C.addon.quest) do
			DisableAddOn(C.addon.quest[i])
		end
		for i in pairs(C.addon.trade) do
			DisableAddOn(C.addon.trade[i])
		end
		for i in pairs(C.addon.pvp) do
			EnableAddOn(C.addon.pvp[i])
		end
		ReloadUI()
	elseif(s and s == "quest") then
		for i in pairs(C.addon.raid) do
			DisableAddOn(C.addon.raid[i])
		end
		for i in pairs(C.addon.party) do
			DisableAddOn(C.addon.party[i])
		end
		for i in pairs(C.addon.pvp) do
			DisableAddOn(C.addon.pvp[i])
		end
		for i in pairs(C.addon.trade) do
			DisableAddOn(C.addon.trade[i])
		end
		for i in pairs(C.addon.quest) do
			EnableAddOn(C.addon.quest[i])
		end
		ReloadUI()
	elseif(s and s == "trade") then
		for i in pairs(C.addon.raid) do
			DisableAddOn(C.addon.raid[i])
		end
		for i in pairs(C.addon.party) do
			DisableAddOn(C.addon.party[i])
		end
		for i in pairs(C.addon.pvp) do
			DisableAddOn(C.addon.pvp[i])
		end
		for i in pairs(C.addon.quest) do
			DisableAddOn(C.addon.quest[i])
		end
		for i in pairs(C.addon.trade) do
			EnableAddOn(C.addon.trade[i])
		end
		ReloadUI()
	elseif(s and s == "solo") then
		for i in pairs(C.addon.raid) do
			DisableAddOn(C.addon.raid[i])
		end
		for i in pairs(C.addon.party) do
			DisableAddOn(C.addon.party[i])
		end
		for i in pairs(C.addon.pvp) do
			DisableAddOn(C.addon.pvp[i])
		end
		for i in pairs(C.addon.quest) do
			DisableAddOn(C.addon.quest[i])
		end
		for i in pairs(C.addon.trade) do
			DisableAddOn(C.addon.trade[i])
		end
		ReloadUI()
	else
		print("|cffffff00"..L_INFO_ADDON_SETS1.."|r")
		print("|cffffff00"..L_INFO_ADDON_SETS2.."|r")
	end
end
SLASH_CHANGEADDONS1 = "/addons"

----------------------------------------------------------------------------------------
--	Farm mode for minimap(by Elv22)
----------------------------------------------------------------------------------------
local farm = false
SlashCmdList.FARMMODE = function(msg, editbox)
	if farm == false then
		MinimapAnchor:Size(C.minimap.size * 1.65, C.minimap.size * 1.65)
		Minimap:Size(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())
		farm = true
	else
		MinimapAnchor:Size(C.minimap.size, C.minimap.size)
		Minimap:Size(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())
		farm = false
	end
end
SLASH_FARMMODE1 = "/farmmode"
SLASH_FARMMODE2 = "/афкььщву"

----------------------------------------------------------------------------------------
--	Frame Stack on Cyrillic
----------------------------------------------------------------------------------------
SlashCmdList.FSTACK = function()
	T.RunSlashCmd("/fstack")
end
SLASH_FSTACK1 = "/аыефсл"
SLASH_FSTACK2 = "/fs"