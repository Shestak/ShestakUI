local T, C, L = unpack(select(2, ...))
if not C.misc.raid_tools == true then return end

----------------------------------------------------------------------------------------
--	Raid Utility(by Elv22)
----------------------------------------------------------------------------------------
-- Create main frame
local RaidUtilityPanel = CreateFrame("Frame", "RaidUtilityPanel", UIParent)
RaidUtilityPanel:CreatePanel("Transparent", 170, 125, "TOP", UIParent, "TOP", -300, 127)

local r, g, b, _ = C.media.backdrop_color

-- Check if We are Raid Leader or Raid Officer
local function CheckRaidStatus()
	local inInstance, instanceType = IsInInstance()
	if ((GetNumPartyMembers() > 0 and not UnitInRaid("player")) or IsRaidLeader() or IsRaidOfficer()) and not (inInstance and (instanceType == "pvp" or instanceType == "arena")) then
		return true
	else
		return false
	end
end

-- Function to create buttons in this module
local function CreateButton(name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
	local b = CreateFrame("Button", name, parent, template)
	b:Width(width)
	b:Height(height)
	b:Point(point, relativeto, point2, xOfs, yOfs)
	b:HookScript("OnEnter", T.SetModifiedBackdrop)
	b:HookScript("OnLeave", T.SetOriginalBackdrop)
	b:EnableMouse(true)
	if name == "ShowButton" then
		b:SetTemplate("Transparent")
	else
		b:SetTemplate("Overlay")
	end
	if text then
		local t = b:CreateFontString(nil, "OVERLAY", b)
		t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		t:SetPoint("CENTER")
		t:SetJustifyH("CENTER")
		t:SetText(text)
	elseif texture then
		local t = b:CreateTexture(nil, "OVERLAY", nil)
		t:SetTexture(texture)
		t:Point("TOPLEFT", b, "TOPLEFT", T.mult, -T.mult)
		t:Point("BOTTOMRIGHT", b, "BOTTOMRIGHT", -T.mult, T.mult)	
	end
end

-- Create button to toggle the frame
CreateButton("ShowButton", RaidUtilityPanel, "SecureHandlerClickTemplate", RaidUtilityPanel:GetWidth() / 1.5, 18, "TOP", UIParent, "TOP", -300, 2, RAID_CONTROL, nil)
ShowButton:SetAttribute("_onclick", [=[
	if select(5, self:GetPoint()) > 0 then
		self:GetParent():ClearAllPoints()
		self:GetParent():SetPoint("TOP", UIParent, "TOP", -300, 1)
		self:ClearAllPoints()
		self:SetPoint("TOP", UIParent, "TOP", -300, -125)
	else
		self:GetParent():ClearAllPoints()
		self:GetParent():SetPoint("TOP", UIParent, "TOP", -300, 500)
		self:ClearAllPoints()
		self:SetPoint("TOP", UIParent, "TOP", -300, 1) 
	end
]=])

-- Disband Raid button
CreateButton("DisbandRaidButton", RaidUtilityPanel, nil, RaidUtilityPanel:GetWidth() * 0.8, 18, "TOP", RaidUtilityPanel, "TOP", 0, -5, L_RAID_UTIL_DISBAND, nil)
DisbandRaidButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		StaticPopup_Show("DISBAND_RAID")
	end
end)

-- Convert Party button
CreateButton("SwitchRaidButton", RaidUtilityPanel, nil, RaidUtilityPanel:GetWidth() * 0.8, 18, "TOP", DisbandRaidButton, "BOTTOM", 0, -5, CONVERT_TO_PARTY, nil)
SwitchRaidButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		ConvertToParty()
	end
end)

-- Role Check button
CreateButton("RoleCheckButton", RaidUtilityPanel, nil, RaidUtilityPanel:GetWidth() * 0.8, 18, "TOP", SwitchRaidButton, "BOTTOM", 0, -5, ROLE_POLL, nil)
RoleCheckButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		InitiateRolePoll()
	end
end)

-- MainTank Button
CreateButton("MainTankButton", RaidUtilityPanel, "SecureActionButtonTemplate", (DisbandRaidButton:GetWidth() / 2) - 2, 18, "TOPLEFT", RoleCheckButton, "BOTTOMLEFT", 0, -5, TANK, nil)
MainTankButton:SetAttribute("type", "maintank")
MainTankButton:SetAttribute("unit", "target")
MainTankButton:SetAttribute("action", "set")

-- MainAssist Button
CreateButton("MainAssistButton", RaidUtilityPanel, "SecureActionButtonTemplate", (DisbandRaidButton:GetWidth() / 2) - 2, 18, "TOPRIGHT", RoleCheckButton, "BOTTOMRIGHT", 0, -5, MAINASSIST, nil)
MainAssistButton:SetAttribute("type", "mainassist")
MainAssistButton:SetAttribute("unit", "target")
MainAssistButton:SetAttribute("action", "set")

-- Ready Check button
CreateButton("ReadyCheckButton", RaidUtilityPanel, nil, RoleCheckButton:GetWidth() * 0.75, 18, "TOPLEFT", MainTankButton, "BOTTOMLEFT", 0, -5, READY_CHECK, nil)
ReadyCheckButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		DoReadyCheck()
	end
end)

-- World Marker button
CreateButton("WorldMarkerButton", RaidUtilityPanel, "SecureHandlerClickTemplate", RoleCheckButton:GetWidth() * 0.2, 18, "TOPRIGHT", MainAssistButton, "BOTTOMRIGHT", 0, -5, nil, "Interface\\RaidFrame\\Raid-WorldPing")
WorldMarkerButton:SetAttribute("_onclick", [=[
	if self:GetChildren():IsShown() then
		self:GetChildren():Hide()
	else
		self:GetChildren():Show()
	end
]=])

-- Marker Buttons
local function CreateMarkerButton(name, text, point, relativeto, point2)
	local f = CreateFrame("Button", name, MarkerFrame, "SecureActionButtonTemplate")
	f:Point(point, relativeto, point2, 0, -5)
	f:Width(MarkerFrame:GetWidth())
	f:Height((MarkerFrame:GetHeight() / 6) + -5)
	f:SetFrameLevel(MarkerFrame:GetFrameLevel() + 1)
	f:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	
	local t = f:CreateFontString(nil, "OVERLAY", f)
	t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	t:SetText(text)
	t:SetPoint("CENTER")
	t:SetJustifyH("CENTER")	
	
	f:SetAttribute("type", "macro")
end

-- Marker Holder Frame
local MarkerFrame = CreateFrame("Frame", "MarkerFrame", WorldMarkerButton)
MarkerFrame:SetTemplate("Transparent")
MarkerFrame:Width(RaidUtilityPanel:GetWidth() * 0.6)
MarkerFrame:Height(RaidUtilityPanel:GetHeight()* 1.2)
MarkerFrame:Point("TOPLEFT", WorldMarkerButton, "BOTTOMRIGHT", 2, -2)
MarkerFrame:Hide()

-- Setup Secure Buttons
MarkerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
MarkerFrame:SetScript("OnEvent", function(self, event)
	CreateMarkerButton("BlueFlare", WORLD_MARKER1, "TOPLEFT", MarkerFrame, "TOPLEFT")
	BlueFlare:SetAttribute("macrotext", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button1")
	CreateMarkerButton("GreenFlare", WORLD_MARKER2, "TOPLEFT", BlueFlare, "BOTTOMLEFT")
	GreenFlare:SetAttribute("macrotext", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button2")
	CreateMarkerButton("PurpleFlare", WORLD_MARKER3, "TOPLEFT", GreenFlare, "BOTTOMLEFT")
	PurpleFlare:SetAttribute("macrotext", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button3")
	CreateMarkerButton("RedFlare", WORLD_MARKER4, "TOPLEFT", PurpleFlare, "BOTTOMLEFT")
	RedFlare:SetAttribute("macrotext", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button4")
	CreateMarkerButton("WhiteFlare", WORLD_MARKER5, "TOPLEFT", RedFlare, "BOTTOMLEFT")
	WhiteFlare:SetAttribute("macrotext", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button5")
	CreateMarkerButton("ClearFlare", REMOVE_WORLD_MARKERS, "TOPLEFT", WhiteFlare, "BOTTOMLEFT")
	ClearFlare:SetAttribute("macrotext", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button6")
	self:UnregisterAllEvents()
end)
MarkerFrame:Height(MarkerFrame:GetHeight() + 4)

local function ToggleRaidUtil(self, event)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end
	
	if CheckRaidStatus() then
		RaidUtilityPanel:Show()
	else
		RaidUtilityPanel:Hide()
	end
	
	if event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end

-- Automatically show/hide the frame if we have RaidLeader or RaidOfficer
local LeadershipCheck = CreateFrame("Frame")
LeadershipCheck:RegisterEvent("RAID_ROSTER_UPDATE")
LeadershipCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
LeadershipCheck:RegisterEvent("PARTY_MEMBERS_CHANGED")
LeadershipCheck:SetScript("OnEvent", ToggleRaidUtil)