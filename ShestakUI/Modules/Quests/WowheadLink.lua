local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

----------------------------------------------------------------------------------------
--	Add quest/achievement wowhead link
----------------------------------------------------------------------------------------
local linkQuest, linkAchievement
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
elseif T.client == "ptBR" or T.client == "ptPT" then
	linkQuest = "http://pt.wowhead.com/quest=%d"
	linkAchievement = "http://pt.wowhead.com/achievement=%d"
elseif T.client == "itIT" then
	linkQuest = "http://it.wowhead.com/quest=%d"
	linkAchievement = "http://it.wowhead.com/achievement=%d"
elseif T.client == "koKR" then
	linkQuest = "http://ko.wowhead.com/quest=%d"
	linkAchievement = "http://ko.wowhead.com/achievement=%d"
elseif T.client == "zhTW" or T.client == "zhCN" then
	linkQuest = "http://cn.wowhead.com/quest=%d"
	linkAchievement = "http://cn.wowhead.com/achievement=%d"
else
	linkQuest = "http://www.wowhead.com/quest=%d"
	linkAchievement = "http://www.wowhead.com/achievement=%d"
end

StaticPopupDialogs.WATCHFRAME_URL = {
	text = L_WATCH_WOWHEAD_LINK,
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 350,
	OnShow = function(self, ...) self.editBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	preferredIndex = 5,
}

hooksecurefunc("QuestObjectiveTracker_OnOpenDropDown", function(self)
	local _, b, info, questID
	b = self.activeFrame
	questID = b.id
	info = UIDropDownMenu_CreateInfo()
	info.text = L_WATCH_WOWHEAD_LINK
	info.func = function()
		local inputBox = StaticPopup_Show("WATCHFRAME_URL")
		inputBox.editBox:SetText(linkQuest:format(questID))
		inputBox.editBox:HighlightText()
	end
	info.arg1 = questID
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

hooksecurefunc("AchievementObjectiveTracker_OnOpenDropDown", function(self)
	local _, b, i, info
	b = self.activeFrame
	i = b.id
	info = UIDropDownMenu_CreateInfo()
	info.text = L_WATCH_WOWHEAD_LINK
	info.func = function(_, i)
		local inputBox = StaticPopup_Show("WATCHFRAME_URL")
		inputBox.editBox:SetText(linkAchievement:format(i))
		inputBox.editBox:HighlightText()
	end
	info.arg1 = i
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

hooksecurefunc("BonusObjectiveTracker_OnOpenDropDown", function(self)
	local block = self.activeFrame
	local questID = block.TrackedQuest.questID
	info = UIDropDownMenu_CreateInfo()
	info.text = L_WATCH_WOWHEAD_LINK
	info.func = function()
		local inputBox = StaticPopup_Show("WATCHFRAME_URL")
		inputBox.editBox:SetText(linkQuest:format(questID))
		inputBox.editBox:HighlightText()
	end
	info.arg1 = questID
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		hooksecurefunc("AchievementButton_OnClick", function(self)
			if self.id and IsControlKeyDown() then
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkAchievement:format(self.id))
				inputBox.editBox:HighlightText()
			end
		end)
	end
end)