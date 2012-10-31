local T, C, L, _ = unpack(select(2, ...))
if C.misc.shift_marking ~= true then return end

----------------------------------------------------------------------------------------
--	Mob marking(by ALZA)
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MarkingFrame", UIParent, "UIDropDownMenuTemplate")
local menuIcon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons"
local menuList = {
	{text = RAID_TARGET_NONE, notCheckable = 1, icon = "Interface\\Buttons\\UI-GroupLoot-Pass-Up",
		func = function() SetRaidTarget("target", 0) end},
	{text = RAID_TARGET_8, notCheckable = 1, icon = menuIcon, tCoordLeft = 0.75, tCoordRight = 1, tCoordTop = 0.25, tCoordBottom = 0.5,
		func = function() SetRaidTarget("target", 8) end},
	{text = "|cffff0000"..RAID_TARGET_7.."|r", notCheckable = 1, icon = menuIcon, tCoordLeft = 0.5, tCoordRight = 0.75, tCoordTop = 0.25, tCoordBottom = 0.5,
		func = function() SetRaidTarget("target", 7) end},
	{text = "|cff00ffff"..RAID_TARGET_6.."|r", notCheckable = 1, icon = menuIcon, tCoordLeft = 0.25, tCoordRight = 0.5, tCoordTop = 0.25, tCoordBottom = 0.5,
		func = function() SetRaidTarget("target", 6) end},
	{text = "|cffC7C7C7"..RAID_TARGET_5.."|r", notCheckable = 1, icon = menuIcon, tCoordLeft = 0, tCoordRight = 0.25, tCoordTop = 0.25, tCoordBottom = 0.5,
		func = function() SetRaidTarget("target", 5) end},
	{text = "|cff00ff00"..RAID_TARGET_4.."|r", notCheckable = 1, icon = menuIcon, tCoordLeft = 0.75, tCoordRight = 1, tCoordTop = 0, tCoordBottom = 0.25,
		func = function() SetRaidTarget("target", 4) end},
	{text = "|cff912CEE"..RAID_TARGET_3.."|r", notCheckable = 1, icon = menuIcon, tCoordLeft = 0.5, tCoordRight = 0.75, tCoordTop = 0, tCoordBottom = 0.25,
		func = function() SetRaidTarget("target", 3) end},
	{text = "|cffFF8000"..RAID_TARGET_2.."|r", notCheckable = 1, icon = menuIcon, tCoordLeft = 0.25, tCoordRight = 0.5, tCoordTop = 0, tCoordBottom = 0.25,
		func = function() SetRaidTarget("target", 2) end},
	{text = "|cffffff00"..RAID_TARGET_1.."|r", notCheckable = 1, icon = menuIcon, tCoordLeft = 0, tCoordRight = 0.25, tCoordTop = 0, tCoordBottom = 0.25,
		func = function() SetRaidTarget("target", 1) end},
}

WorldFrame:HookScript("OnMouseDown", function(self, button)
	if button == "LeftButton" and IsShiftKeyDown() and UnitExists("mouseover") then
		if (GetNumGroupMembers() > 0 and not UnitInRaid("player")) or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU")
		end
	end
end)