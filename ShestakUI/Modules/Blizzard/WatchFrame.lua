local T, C, L = unpack(select(2, ...))

local UIWatchFrame = CreateFrame("Frame", "UIWatchFrame", UIParent)
UIWatchFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Compatible with Blizzard option
local wideFrame = GetCVar("watchFrameWidth")

-- Create our moving area
local WatchFrameAnchor = CreateFrame("Button", "WatchFrameAnchor", UIParent)
WatchFrameAnchor:SetFrameStrata("HIGH")
WatchFrameAnchor:SetFrameLevel(20)
WatchFrameAnchor:Height(T.getscreenheight / 1.6)
WatchFrameAnchor:SetClampedToScreen(true)
WatchFrameAnchor:SetMovable(true)
WatchFrameAnchor:EnableMouse(false)
WatchFrameAnchor:SetTemplate("Transparent")
WatchFrameAnchor:SetBackdropColor(0, 0, 0, 0)
WatchFrameAnchor:SetBackdropBorderColor(0, 0, 0, 0)
WatchFrameAnchor.iborder:SetBackdropBorderColor(0, 0, 0, 0)
WatchFrameAnchor.oborder:SetBackdropBorderColor(0, 0, 0, 0)
WatchFrameAnchor.text = WatchFrameAnchor:CreateFontString("WatchFrameAnchorText", "OVERLAY", nil)
WatchFrameAnchor.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
WatchFrameAnchor.text:SetPoint("CENTER")
WatchFrameAnchor.text:SetText("WatchFrame Anchor")
WatchFrameAnchor.text:Hide()

-- Set default position according to how many right bars we have
WatchFrameAnchor:Point(unpack(C.position.quest))

-- Width of the watchframe according to our Blizzard cVar
if wideFrame == "1" then
	UIWatchFrame:Width(350)
	WatchFrameAnchor:Width(350)
else
	UIWatchFrame:Width(250)
	WatchFrameAnchor:Width(250)
end

UIWatchFrame:SetParent(WatchFrameAnchor)
UIWatchFrame:Height(T.getscreenheight / 1.6)
UIWatchFrame:ClearAllPoints()
UIWatchFrame:Point("TOP", WatchFrameAnchor, "TOP", 0, 0)

local function init()
	UIWatchFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	UIWatchFrame:RegisterEvent("CVAR_UPDATE")
	UIWatchFrame:SetScript("OnEvent", function(_, _, cvar, value)
		if cvar == "WATCH_FRAME_WIDTH_TEXT" then
			if not WatchFrame.userCollapsed then
				if value == "1" then
					UIWatchFrame:Width(350)
					WatchFrameAnchor:Width(350)
				else
					UIWatchFrame:Width(250)
					WatchFrameAnchor:Width(250)
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
	WatchFrame:Point("TOPLEFT", 25, 2)
	WatchFrame:Point("BOTTOMRIGHT", 0, 0)
	WatchFrame.SetPoint = T.dummy
end

----------------------------------------------------------------------------------------
--	Execute setup after we enter world
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame")
f:Hide()
f.elapsed = 0
f:SetScript("OnUpdate", function(self, elapsed)
	f.elapsed = f.elapsed + elapsed
	if f.elapsed > 0.5 then
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