if SettingsCF.misc.move_watchframe ~= true then return end

local UIWatchFrame = CreateFrame("Frame", "UIWatchFrame", UIParent)
UIWatchFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Compatible with Blizzard option
local wideFrame = GetCVar("watchFrameWidth")

-- Create our moving area
local WatchFrameAnchor = CreateFrame("Button", "WatchFrameAnchor", UIParent)
WatchFrameAnchor:SetFrameStrata("HIGH")
WatchFrameAnchor:SetFrameLevel(20)
WatchFrameAnchor:SetHeight(20)
WatchFrameAnchor:SetClampedToScreen(true)
WatchFrameAnchor:SetMovable(true)
WatchFrameAnchor:EnableMouse(false)
SettingsDB.SkinFadedPanel(WatchFrameAnchor)
WatchFrameAnchor:SetBackdropColor(0, 0, 0, 0)
WatchFrameAnchor:SetBackdropBorderColor(0, 0, 0, 0)
WatchFrameAnchor.iborder:SetBackdropBorderColor(0, 0, 0, 0)
WatchFrameAnchor.oborder:SetBackdropBorderColor(0, 0, 0, 0)
WatchFrameAnchor.text = WatchFrameAnchor:CreateFontString("WatchFrameAnchor", "OVERLAY", nil)
WatchFrameAnchor.text:SetFont(SettingsCF.media.pixel_font, SettingsCF.media.pixel_font_size, SettingsCF.media.pixel_font_style)
WatchFrameAnchor.text:SetPoint("CENTER")
WatchFrameAnchor.text:SetText("WatchFrame Anchor")
WatchFrameAnchor.text:Hide()

-- Set default position according to how many right bars we have
WatchFrameAnchor:SetPoint(unpack(SettingsCF.position.quest))

-- Width of the watchframe according to our Blizzard cVar
if wideFrame == "1" then
	UIWatchFrame:SetWidth(350)
	WatchFrameAnchor:SetWidth(350)
else
	UIWatchFrame:SetWidth(250)
	WatchFrameAnchor:SetWidth(250)
end

local screenheight = SettingsDB.getscreenheight
UIWatchFrame:SetParent(WatchFrameAnchor)
UIWatchFrame:SetHeight(screenheight / 1.6)
UIWatchFrame:ClearAllPoints()
UIWatchFrame:SetPoint("TOP")

local function init()
	UIWatchFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	UIWatchFrame:RegisterEvent("CVAR_UPDATE")
	UIWatchFrame:SetScript("OnEvent", function(_, _, cvar, value)
		if cvar == "WATCH_FRAME_WIDTH_TEXT" then
			if not WatchFrame.userCollapsed then
				if value == "1" then
					UIWatchFrame:SetWidth(350)
					WatchFrameAnchor:SetWidth(350)
				else
					UIWatchFrame:SetWidth(250)
					WatchFrameAnchor:SetWidth(250)
				end
			end
			wideFrame = value
		end
	end)
end

local function setup()	
	WatchFrame:SetParent(UIWatchFrame)
	WatchFrame:SetFrameStrata("MEDIUM")
	WatchFrame:SetFrameLevel(3)
	WatchFrame:SetClampedToScreen(false)
	WatchFrame:ClearAllPoints()
	WatchFrame.ClearAllPoints = function() end
	WatchFrame:SetPoint("TOPLEFT", 25, 2)
	WatchFrame:SetPoint("BOTTOMRIGHT", 0, 0)
	WatchFrame.SetPoint = SettingsDB.dummy
end

----------------------------------------------------------------------------------------
--	Execute setup after we enter world
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame")
f:Hide()
f.elapsed = 0
f:SetScript("OnUpdate", function(self, elapsed)
	f.elapsed = f.elapsed + elapsed
	if f.elapsed > .5 then
		setup()
		f:Hide()
	end
end)
UIWatchFrame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("Who Framed Watcher Wabbit") or not IsAddOnLoaded("Fux") then 
		init()
		f:Show()
	end
end)

----------------------------------------------------------------------------------------
--	Auto collapse when enganging bosses(oWatchFrameToggler by Haste)
----------------------------------------------------------------------------------------
local addon = CreateFrame"Frame"

addon:RegisterEvent"PLAYER_ENTERING_WORLD"
addon:RegisterEvent"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
addon:RegisterEvent"UNIT_TARGETABLE_CHANGED"
addon:RegisterEvent"PLAYER_REGEN_ENABLED"

local BossExists = function()
	for i = 1, MAX_BOSS_FRAMES do
		if(UnitExists("boss" .. i)) then
			return true
		end
	end
end

addon:SetScript("OnEvent", function(self, event)
	if(BossExists()) then
		if(not WatchFrame.collapsed) then
			WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
		end
	elseif(WatchFrame.collapsed and not InCombatLockdown()) then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	end
end)