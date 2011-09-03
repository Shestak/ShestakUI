local T, C, L = unpack(select(2, ...))
if not C.misc.raid_tools == true then return end

----------------------------------------------------------------------------------------
--	Raid Utility(by Elv22)
----------------------------------------------------------------------------------------
-- Create main frame
local RaidUtilityPanel = CreateFrame("Frame", "RaidUtilityPanel", UIParent)
RaidUtilityPanel:CreatePanel("Transparent", 170, 145, "TOP", UIParent, "TOP", -300, 1)
RaidUtilityPanel.toggled = false

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
	b:EnableMouse(true)
	if text then
		local t = b:CreateFontString(nil, "OVERLAY", b)
		t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		t:SetPoint("CENTER")
		t:SetJustifyH("CENTER")
		t:SetText(text)
	end
end

-- Show button
CreateButton("ShowButton", UIParent, "UIMenuButtonStretchTemplate, SecureHandlerClickTemplate", RaidUtilityPanel:GetWidth() / 1.5, 18, "TOP", UIParent, "TOP", -300, 2, RAID_CONTROL, nil)
ShowButton:SetFrameRef("RaidUtilityPanel", RaidUtilityPanel)
ShowButton:SetAttribute("_onclick", [=[self:Hide(); self:GetFrameRef("RaidUtilityPanel"):Show();]=])
ShowButton:SetScript("OnMouseUp", function(self) RaidUtilityPanel.toggled = true end)

-- Close button
CreateButton("CloseButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate, SecureHandlerClickTemplate", RaidUtilityPanel:GetWidth() / 1.5, 18, "TOP", RaidUtilityPanel, "BOTTOM", 0, -1, CLOSE, nil)
CloseButton:SetFrameRef("ShowButton", ShowButton)
CloseButton:SetAttribute("_onclick", [=[self:GetParent():Hide(); self:GetFrameRef("ShowButton"):Show();]=])
CloseButton:SetScript("OnMouseUp", function(self) RaidUtilityPanel.toggled = false end)

-- Disband Raid button
CreateButton("DisbandRaidButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RaidUtilityPanel:GetWidth() * 0.8, 18, "TOP", RaidUtilityPanel, "TOP", 0, -5, L_RAID_UTIL_DISBAND, nil)
DisbandRaidButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		StaticPopup_Show("DISBAND_RAID")
	end
end)

-- Convert Party button
CreateButton("SwitchRaidButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RaidUtilityPanel:GetWidth() * 0.8, 18, "TOP", DisbandRaidButton, "BOTTOM", 0, -5, CONVERT_TO_PARTY, nil)
SwitchRaidButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		if UnitInRaid("player") then
			ConvertToParty()
		elseif UnitInParty("player") then
			ConvertToRaid()
		end
	end
end)

-- Role Check button
CreateButton("RoleCheckButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RaidUtilityPanel:GetWidth() * 0.8, 18, "TOP", SwitchRaidButton, "BOTTOM", 0, -5, ROLE_POLL, nil)
RoleCheckButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		InitiateRolePoll()
	end
end)

-- MainTank button
CreateButton("MainTankButton", RaidUtilityPanel, "SecureActionButtonTemplate, UIMenuButtonStretchTemplate", (DisbandRaidButton:GetWidth() / 2) - 2, 18, "TOPLEFT", RoleCheckButton, "BOTTOMLEFT", 0, -5, TANK, nil)
MainTankButton:SetAttribute("type", "maintank")
MainTankButton:SetAttribute("unit", "target")
MainTankButton:SetAttribute("action", "toggle")

-- MainAssist button
CreateButton("MainAssistButton", RaidUtilityPanel, "SecureActionButtonTemplate, UIMenuButtonStretchTemplate", (DisbandRaidButton:GetWidth() / 2) - 2, 18, "TOPRIGHT", RoleCheckButton, "BOTTOMRIGHT", 0, -5, MAINASSIST, nil)
MainAssistButton:SetAttribute("type", "mainassist")
MainAssistButton:SetAttribute("unit", "target")
MainAssistButton:SetAttribute("action", "toggle")

-- Ready Check button
CreateButton("ReadyCheckButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RoleCheckButton:GetWidth() * 0.75, 18, "TOPLEFT", MainTankButton, "BOTTOMLEFT", 0, -5, READY_CHECK, nil)
ReadyCheckButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		DoReadyCheck()
	end
end)

-- World Marker button
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:ClearAllPoints()
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:Point("TOPRIGHT", MainAssistButton, "BOTTOMRIGHT", 0, -5)
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:SetParent("RaidUtilityPanel")
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:Height(18)
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:Width(RoleCheckButton:GetWidth() * 0.22)

-- Put other stuff back
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:ClearAllPoints()
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:Point("BOTTOMLEFT", CompactRaidFrameManagerDisplayFrameLockedModeToggle, "TOPLEFT", 0, 1)
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck:Point("BOTTOMRIGHT", CompactRaidFrameManagerDisplayFrameHiddenModeToggle, "TOPRIGHT", 0, 1)

CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:ClearAllPoints()
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:Point("BOTTOMLEFT", CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck, "TOPLEFT", 0, 1)
CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll:Point("BOTTOMRIGHT", CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck, "TOPRIGHT", 0, 1)

local MarkTexture = CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton:CreateTexture(nil, "OVERLAY")
MarkTexture:SetTexture("Interface\\RaidFrame\\Raid-WorldPing")
MarkTexture:Point("CENTER", 0, -1)

-- Raid Control Panel
CreateButton("RaidControlButton", RaidUtilityPanel, "UIMenuButtonStretchTemplate", RoleCheckButton:GetWidth(), 18, "TOPLEFT", ReadyCheckButton, "BOTTOMLEFT", 0, -5, RAID_CONTROL, nil)
RaidControlButton:SetScript("OnMouseUp", function(self)
	ToggleFriendsFrame(4)
end)

local function ToggleRaidUtil(self, event)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	if CheckRaidStatus() then
		if RaidUtilityPanel.toggled == true then
			ShowButton:Hide()
			RaidUtilityPanel:Show()
		else
			ShowButton:Show()
			RaidUtilityPanel:Hide()
		end
	else
		ShowButton:Hide()
		RaidUtilityPanel:Hide()
	end

	if event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end

-- Automatically show/hide the frame if we have Raid Leader or Raid Officer
local LeadershipCheck = CreateFrame("Frame")
LeadershipCheck:RegisterEvent("RAID_ROSTER_UPDATE")
LeadershipCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
LeadershipCheck:RegisterEvent("PARTY_MEMBERS_CHANGED")
LeadershipCheck:SetScript("OnEvent", ToggleRaidUtil)