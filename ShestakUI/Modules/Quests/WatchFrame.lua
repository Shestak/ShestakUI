local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Move WatchFrame by Tukz
----------------------------------------------------------------------------------------
local UIWatchFrame = CreateFrame("Frame", "UIWatchFrame", UIParent)
UIWatchFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Compatible with Blizzard option
local wideFrame = GetCVar("watchFrameWidth")

-- Create our moving area
local WatchFrameAnchor = CreateFrame("Frame", "WatchFrameAnchor", UIParent)
WatchFrameAnchor:Height(150)

-- Set default position
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

-- Execute setup after we enter world
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

----------------------------------------------------------------------------------------
--	Skin item buttons
----------------------------------------------------------------------------------------
hooksecurefunc("SetItemButtonTexture", function(button, texture)
	if button:GetName():match("WatchFrameItem%d+") and not button.skinned and not InCombatLockdown() then
		local icon = _G[button:GetName().."IconTexture"]
		local border = _G[button:GetName().."NormalTexture"]
		local count = _G[button:GetName().."Count"]
		local hotkey = _G[button:GetName().."HotKey"]

		button:Size(T.buttonsize)
		button:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", button, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", button, -2, 2)

		count:ClearAllPoints()
		count:Point("BOTTOMRIGHT", 0, 2)
		count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)

		hotkey:SetText("")
		hotkey:Kill()

		border:ClearAllPoints()
		border:SetAllPoints()
		border:SetTexture(nil)

		button:StyleButton()

		button.skinned = true
	end
end)

----------------------------------------------------------------------------------------
--	Difficulty color for watchframe lines
----------------------------------------------------------------------------------------
hooksecurefunc("WatchFrame_Update", function()
	local questIndex
	local numQuestWatches = GetNumQuestWatches()

	for i = 1, numQuestWatches do
		questIndex = GetQuestIndexForWatch(i)
		if questIndex then
			local title, level = GetQuestLogTitle(questIndex)
			local col = GetQuestDifficultyColor(level)

			for j = 1, #WATCHFRAME_QUESTLINES do
				if WATCHFRAME_QUESTLINES[j].text:GetText() == title then
					WATCHFRAME_QUESTLINES[j].text:SetTextColor(col.r, col.g, col.b)
					WATCHFRAME_QUESTLINES[j].col = col
				end
			end
		end
	end
end)

hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(self, onEnter)
	for i = self.startLine, self.lastLine do
		if not self.lines[i] then return end
		if self.lines[i].col then
			if onEnter then
				self.lines[i].text:SetTextColor(1, 0.8, 0)
			else
				self.lines[i].text:SetTextColor(self.lines[i].col.r, self.lines[i].col.g, self.lines[i].col.b)
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Skin WatchFrameCollapseExpandButton
----------------------------------------------------------------------------------------
if C.skins.blizzard_frames == true then
	T.SkinCloseButton(WatchFrameCollapseExpandButton, nil, "-", true)
	WatchFrameCollapseExpandButton:HookScript("OnClick", function(self)
		if WatchFrame.collapsed then
			self.text:SetText("+")
		else
			self.text:SetText("-")
		end
	end)
end