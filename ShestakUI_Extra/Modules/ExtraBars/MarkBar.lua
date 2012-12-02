local T, C, L, _ = unpack(ShestakUI)
if C.extra_bar.mark_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Mark Bar(by Smelly)
----------------------------------------------------------------------------------------
local button_size = 30

local bar = CreateFrame("Frame", "ExtraMarkBar", UIParent)
bar:CreatePanel("Invisible", (button_size * 6) + 15, (button_size * 2) + 3, unpack(C.extra_position.mark_bar))
bar:SetFrameLevel(0)
tinsert(T.MoverFrames, bar)

local icon = {}
local mark = {}
for i = 0, 8 do
	mark[i] = CreateFrame("Button", "$parentButton"..i, bar)
	mark[i]:CreatePanel("Transparent", button_size, button_size, "LEFT", bar, "LEFT", 0, 0)
	if i == 1 then
		mark[i]:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
	elseif i == 5 then
		mark[i]:SetPoint("TOP", mark[1], "BOTTOM", 0, -3)
	else
		mark[i]:SetPoint("LEFT", mark[i-1], "RIGHT", 3, 0)
	end
	mark[0]:SetPoint("TOPLEFT", mark[4], "TOPRIGHT", 3, 0)
	mark[i]:EnableMouse(true)
	mark[i]:SetScript("OnEnter", T.SetModifiedBackdrop)
	mark[i]:SetScript("OnLeave", T.SetOriginalBackdrop)
	mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", i) PlaySound("igMainMenuOptionCheckBoxOn") end)

	icon[i] = mark[i]:CreateTexture(nil, "OVERLAY")
	if i == 0 then
		icon[i]:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
	else
		icon[i]:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end
	icon[i]:SetSize(button_size - 5, button_size - 5)
	icon[i]:SetPoint("CENTER", mark[i])

	-- Set up each button
	if i == 1 then
		icon[i]:SetTexCoord(0, 0.25, 0, 0.25)
	elseif i == 2 then
		icon[i]:SetTexCoord(0.25, 0.5, 0, 0.25)
	elseif i == 3 then
		icon[i]:SetTexCoord(0.5, 0.75, 0, 0.25)
	elseif i == 4 then
		icon[i]:SetTexCoord(0.75, 1, 0, 0.25)
	elseif i == 5 then
		icon[i]:SetTexCoord(0, 0.25, 0.25, 0.5)
	elseif i == 6 then
		icon[i]:SetTexCoord(0.25, 0.5, 0.25, 0.5)
	elseif i == 7 then
		icon[i]:SetTexCoord(0.5, 0.75, 0.25, 0.5)
	elseif i == 8 then
		icon[i]:SetTexCoord(0.75, 1, 0.25, 0.5)
	end
end

-- Create ReadyCheck Button
local ReadyCheckButton = CreateFrame("Button", "ReadyCheckButton", bar)
ReadyCheckButton:CreatePanel("Transparent", button_size, button_size, "TOPLEFT", mark[8], "TOPRIGHT", 3, 0)
ReadyCheckButton:SetScript("OnEnter", T.SetModifiedBackdrop)
ReadyCheckButton:SetScript("OnLeave", T.SetOriginalBackdrop)
ReadyCheckButton:SetScript("OnMouseUp", function() DoReadyCheck() end)

local ReadyCheckButtonTexture = ReadyCheckButton:CreateTexture(nil, "OVERLAY")
ReadyCheckButtonTexture:SetTexture(READY_CHECK_READY_TEXTURE)
ReadyCheckButtonTexture:SetAllPoints(ReadyCheckButton)

-- Create WorldMark Button
local WorldMarkButton = CreateFrame("Button", "WorldMarkButton", bar, "SecureActionButtonTemplate")
WorldMarkButton:CreatePanel("Transparent", button_size, button_size, "TOPLEFT", mark[0], "TOPRIGHT", 3, 0)
WorldMarkButton:SetScript("OnEnter", T.SetModifiedBackdrop)
WorldMarkButton:SetScript("OnLeave", T.SetOriginalBackdrop)
WorldMarkButton:SetAttribute("type1", "macro")
WorldMarkButton:SetAttribute("macrotext1", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton")
WorldMarkButton:HookScript("OnClick", function(self)
	DropDownList1:ClearAllPoints()
	DropDownList1:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 2, -4)
end)

local WorldMarkButtonTexture = WorldMarkButton:CreateTexture(nil, "OVERLAY")
WorldMarkButtonTexture:SetTexture("Interface\\RaidFrame\\Raid-WorldPing")
WorldMarkButtonTexture:SetPoint("CENTER", 0, 0)
WorldMarkButtonTexture:SetHeight(23)
WorldMarkButtonTexture:SetWidth(23)

-- Create Pull Button
local PullTargetButton = CreateFrame("Frame", "PullTargetButton", bar)
PullTargetButton:CreatePanel("Transparent", button_size, button_size, "TOP", WorldMarkButton, "BOTTOM", 0, -3)
PullTargetButton:SetScript("OnEnter", T.SetModifiedBackdrop)
PullTargetButton:SetScript("OnLeave", T.SetOriginalBackdrop)
PullTargetButton:SetScript("OnMouseUp", function()
	if C.announcements.pull_countdown then
		PullCountdown.Pull()
	else
		print("|cffffff00Enable 'Pull countdown announce' option.|r")
	end
end)

local PullTargetButtonTexture = PullTargetButton:CreateTexture(nil, "OVERLAY")
PullTargetButtonTexture:SetTexture("Interface\\Icons\\Ability_Hunter_Beastcall")
PullTargetButtonTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
PullTargetButtonTexture:SetPoint("TOPLEFT", PullTargetButton, 2, -2)
PullTargetButtonTexture:SetPoint("BOTTOMRIGHT", PullTargetButton, -2, 2)

-- Check if we are Raid Leader/Officer or in Party
local function CheckRaidStatus()
	local inInstance, instanceType = IsInInstance()
	if ((GetNumGroupMembers() > 0 and UnitIsGroupLeader("player") and not UnitInRaid("player")) or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and not (inInstance and (instanceType == "pvp" or instanceType == "arena")) then
		return true
	else
		return false
	end
end

-- Automatically show/hide the frame if we have Raid Leader or Raid Officer or in Party
local LeadershipCheck = CreateFrame("Frame")
LeadershipCheck:RegisterEvent("GROUP_ROSTER_UPDATE")
LeadershipCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
LeadershipCheck:SetScript("OnEvent", function(self, event)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	if CheckRaidStatus() then
		bar:Show()
	else
		bar:Hide()
	end

	if event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end)