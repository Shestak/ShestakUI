local T, C, L, _ = unpack(select(2, ...))

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

local selfText
StaticPopupDialogs.WATCHFRAME_URL = {
	text = L_WATCH_WOWHEAD_LINK,
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 350,
	OnShow = function(self, text)
		self.editBox:SetMaxLetters(0)
		self.editBox:SetText(text)
		self.editBox:HighlightText()
		selfText = text
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	EditBoxOnTextChanged = function(self)
		if self:GetText():len() < 1 then
			self:GetParent():Hide()
		else
			self:SetText(selfText)
			self:HighlightText()
		end
	end,
	preferredIndex = 5,
}

hooksecurefunc("QuestObjectiveTracker_OnOpenDropDown", function(self)
	local id = self.activeFrame.id
	local info = UIDropDownMenu_CreateInfo()
	info.text = L_WATCH_WOWHEAD_LINK
	info.func = function()
		local text = linkQuest:format(id)
		StaticPopup_Show("WATCHFRAME_URL", _, _, text)
	end
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

hooksecurefunc("BonusObjectiveTracker_OnOpenDropDown", function(self)
	local id = self.activeFrame.TrackedQuest.questID
	local info = UIDropDownMenu_CreateInfo()
	info.text = L_WATCH_WOWHEAD_LINK
	info.func = function()
		local text = linkQuest:format(id)
		StaticPopup_Show("WATCHFRAME_URL", _, _, text)
	end
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

hooksecurefunc("AchievementObjectiveTracker_OnOpenDropDown", function(self)
	local id = self.activeFrame.id
	local info = UIDropDownMenu_CreateInfo()
	info.text = L_WATCH_WOWHEAD_LINK
	info.func = function()
		local text = linkAchievement:format(id)
		StaticPopup_Show("WATCHFRAME_URL", _, _, text)
	end
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_AchievementUI" then
		hooksecurefunc(AchievementTemplateMixin, "OnClick", function(self)
			local elementData = self:GetElementData()
			if elementData and elementData.id and IsControlKeyDown() then
				local text = linkAchievement:format(elementData.id)
				StaticPopup_Show("WATCHFRAME_URL", _, _, text)
			end
		end)
	end
end)