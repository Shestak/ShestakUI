local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Move WatchFrame by Tukz
----------------------------------------------------------------------------------------
local UIWatchFrame = CreateFrame("Frame", "UIWatchFrame", UIParent)
UIWatchFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Compatible with Blizzard option
local wideFrame = GetCVar("watchFrameWidth")

-- Create our moving area
local WatchFrameAnchor = CreateFrame("Button", "WatchFrameAnchor", UIParent)
WatchFrameAnchor:SetFrameStrata("HIGH")
WatchFrameAnchor:SetFrameLevel(20)
WatchFrameAnchor:Height(150)
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
	if button:GetName():match("WatchFrameItem%d+") and not button.skinned then
		local icon = _G[button:GetName().."IconTexture"]
		local border = _G[button:GetName().."NormalTexture"]
		local count = _G[button:GetName().."Count"]
		local hotkey = _G[button:GetName().."HotKey"]

		button:Size(T.buttonsize, T.buttonsize)
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

		button:StyleButton(false)

		button.skinned = true
	end
end)

----------------------------------------------------------------------------------------
--	Add quest/achievement wowhead link
----------------------------------------------------------------------------------------
local linkQuest
local linkAchievement
if T.client == "ruRU" then
	linkQuest = "http://ru.wowhead.com/quest=%d"
	linkAchievement = "http://ru.wowhead.com/achievement=%d"
elseif T.client == "frFR" then
	linkQuest = "http://fr.wowhead.com/quest=%d"
	linkAchievement = "http://fr.wowhead.com/achievement=%d"
elseif T.client == "deDE" then
	linkQuest = "http://de.wowhead.com/quest=%d"
	linkAchievement = "http://de.wowhead.com/achievement=%d"
elseif T.client == "esES" or T.client == "esMX" then
	linkQuest = "http://es.wowhead.com/quest=%d"
	linkAchievement = "http://es.wowhead.com/achievement=%d"
else
	linkQuest = "http://www.wowhead.com/quest=%d"
	linkAchievement = "http://www.wowhead.com/achievement=%d"
end

_G.StaticPopupDialogs["WATCHFRAME_URL"] = {
	text = L_WATCH_WOWHEAD_LINK,
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 350,
	OnShow = function(self, ...) self.editBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

local tblDropDown = {}
hooksecurefunc("WatchFrameDropDown_Initialize", function(self)
	if self.type == "QUEST" then
		tblDropDown = {
			text = L_WATCH_WOWHEAD_LINK, notCheckable = true, arg1 = self.index,
			func = function(_, watchId)
				local logId = GetQuestIndexForWatch(watchId)
				local _, _, _, _, _, _, _, _, questId = GetQuestLogTitle(logId)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkQuest:format(questId))
				inputBox.editBox:HighlightText()
			end
		}
		UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
	elseif self.type == "ACHIEVEMENT" then
		tblDropDown = {
			text = L_WATCH_WOWHEAD_LINK, notCheckable = true, arg1 = self.index,
			func = function(_, id)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkAchievement:format(id))
				inputBox.editBox:HighlightText()
			end
		}
		UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
	end
end)
UIDropDownMenu_Initialize(WatchFrameDropDown, WatchFrameDropDown_Initialize, "MENU")

----------------------------------------------------------------------------------------
--	CTRL+Click to abandon a quest
----------------------------------------------------------------------------------------
hooksecurefunc("QuestLogTitleButton_OnClick", function(self, button)
	local questIndex = self:GetID()
	local questName = self:GetText()
	if IsModifiedClick() then
		if self.isHeader then return end
		if IsControlKeyDown() then
			QuestLog_SetSelection(questIndex)
			AbandonQuest()
			QuestLog_Update()
			QuestLog_SetSelection(questIndex)
		end
	end
end)