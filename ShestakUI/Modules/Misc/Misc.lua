local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Force readycheck warning
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(self, initiator, timeLeft)
	if initiator ~= "player" then
		PlaySound("ReadyCheck", "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	Spin camera while afk(by Telroth and Eclipse)
----------------------------------------------------------------------------------------
if C.misc.afk_spin_camera == true then
	local SpinCam = CreateFrame("Frame")

	local OnEvent = function(self, event, unit)
		if event == "PLAYER_FLAGS_CHANGED" then
			if unit == "player" then
				if UnitIsAFK(unit) then
					SpinStart()
				else
					SpinStop()
				end
			end
		elseif event == "PLAYER_LEAVING_WORLD" then
			SpinStop()
		end
	end
	SpinCam:RegisterEvent("PLAYER_ENTERING_WORLD")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", OnEvent)

	function SpinStart()
		spinning = true
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		UIParent:Show()
	end
end

----------------------------------------------------------------------------------------
--	Custom Lag Tolerance(by Elv22)
----------------------------------------------------------------------------------------
if C.general.custom_lagtolerance == true then
	InterfaceOptionsCombatPanelMaxSpellStartRecoveryOffset:Hide()
	InterfaceOptionsCombatPanelReducedLagTolerance:Hide()

	local customlag = CreateFrame("Frame")
	local int = 5
	local LatencyUpdate = function(self, elapsed)
		int = int - elapsed
		if int < 0 then
			if GetCVar("reducedLagTolerance") ~= tostring(1) then SetCVar("reducedLagTolerance", tostring(1)) end
			if select(3, GetNetStats()) ~= 0 and select(3, GetNetStats()) <= 400 then
				SetCVar("maxSpellStartRecoveryOffset", tostring(select(3, GetNetStats())))
			end
			int = 5
		end
	end
	customlag:SetScript("OnUpdate", LatencyUpdate)
	LatencyUpdate(customlag, 10)
end

----------------------------------------------------------------------------------------
--	Remove Boss Emote spam during BG(ArathiBasin SpamFix by Partha)
----------------------------------------------------------------------------------------
if C.misc.hide_bg_spam == true then
	local Fixer = CreateFrame("Frame")
	local RaidBossEmoteFrame, spamDisabled = RaidBossEmoteFrame

	local function DisableSpam()
		if GetZoneText() == L_ZONE_ARATHIBASIN or GetZoneText() == L_ZONE_GILNEAS then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = true
		elseif spamDisabled then
			RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = false
		end
	end

	Fixer:RegisterEvent("PLAYER_ENTERING_WORLD")
	Fixer:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	Fixer:SetScript("OnEvent", DisableSpam)
end

----------------------------------------------------------------------------------------
--	Undress button in auction dress-up frame(by Nefarion)
----------------------------------------------------------------------------------------
local strip = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate")
strip:SetText(L_MISC_UNDRESS)
strip:SetHeight(22)
strip:SetWidth(strip:GetTextWidth() + 40)
strip:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
strip:RegisterForClicks("AnyUp")
strip:SetScript("OnClick", function(self, button)
	if button == "RightButton" then
		self.model:UndressSlot(19)
	else
		self.model:Undress()
	end
	PlaySound("gsTitleOptionOK")
end)
strip.model = DressUpModel

strip:RegisterEvent("AUCTION_HOUSE_SHOW")
strip:RegisterEvent("AUCTION_HOUSE_CLOSED")
strip:SetScript("OnEvent", function(self)
	if AuctionFrame:IsVisible() and self.model ~= SideDressUpModel then
		self:SetParent(SideDressUpModel)
		self:ClearAllPoints()
		self:SetPoint("TOP", SideDressUpModelResetButton, "BOTTOM", 0, -3)
		self.model = SideDressUpModel
	elseif self.model ~= DressUpModel then
		self:SetParent(DressUpModel)
		self:ClearAllPoints()
		self:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
		self.model = DressUpModel
	end
end)

----------------------------------------------------------------------------------------
--	GuildTab in FriendsFrame
----------------------------------------------------------------------------------------
local n = FriendsFrame.numTabs + 1
local gtframe = CreateFrame("Button", "FriendsFrameTab"..n, FriendsFrame, "FriendsFrameTabTemplate")
gtframe:SetID(n)
gtframe:SetText(GUILD)
gtframe:SetPoint("LEFT", _G["FriendsFrameTab"..n - 1], "RIGHT", -15, 0)
gtframe:RegisterForClicks("AnyUp")
gtframe:SetScript("OnClick", function()
	if IsInGuild() then
		if not GuildFrame then
			LoadAddOn("Blizzard_GuildUI")
		end
		ToggleGuildFrame()
		GuildFrame_TabClicked(GuildFrameTab2)
	else
		if not LookingForGuildFrame then
			LoadAddOn("Blizzard_LookingForGuildUI")
		end
		if not LookingForGuildFrame then return end
		LookingForGuildFrame_Toggle()
	end
end)
PanelTemplates_SetNumTabs(FriendsFrame, n)
PanelTemplates_EnableTab(FriendsFrame, n)

----------------------------------------------------------------------------------------
--	Misclicks for some popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE_XREALM.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.PET_BATTLE_QUEUE_PROPOSE_MATCH.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_BATTLEFIELD_ENTRY.button2 = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil

----------------------------------------------------------------------------------------
--	Honor shown in tooltip
----------------------------------------------------------------------------------------
PVPFrameCurrency:HookScript("OnEnter", function()
	GameTooltip:AddLine(HONORABLE_KILLS..": |cffffffff"..GetStatistic(588))
	GameTooltip:Show()
end)

----------------------------------------------------------------------------------------
--	Old achievements filter
----------------------------------------------------------------------------------------
function AchievementFrame_GetCategoryNumAchievements_OldIncomplete(categoryID)
	local numAchievements, numCompleted = GetCategoryNumAchievements(categoryID)
	return numAchievements - numCompleted, 0, numCompleted
end

function old_nocomplete_filter_init()
	AchievementFrameFilters = {
		{text = ACHIEVEMENTFRAME_FILTER_ALL, func = AchievementFrame_GetCategoryNumAchievements_All},
		{text = ACHIEVEMENTFRAME_FILTER_COMPLETED, func = AchievementFrame_GetCategoryNumAchievements_Complete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE, func = AchievementFrame_GetCategoryNumAchievements_Incomplete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE.." ("..ALL.." )", func = AchievementFrame_GetCategoryNumAchievements_OldIncomplete}
	}
end

local filter = CreateFrame("Frame")
filter:RegisterEvent("ADDON_LOADED")
filter:SetScript("OnEvent", function(self, event, addon, ...)
	if addon == "Blizzard_AchievementUI" then
		if AchievementFrame then
			old_nocomplete_filter_init()
			AchievementFrameFilterDropDown:SetWidth(AchievementFrameFilterDropDown:GetWidth() + 20)
			filter:UnregisterEvent("ADDON_LOADED")
		end
	end
end)

----------------------------------------------------------------------------------------
--	Queue timer on LFGDungeonReadyDialog
----------------------------------------------------------------------------------------
local queue = CreateFrame("Frame", nil, LFGDungeonReadyDialog)
queue:SetPoint("TOPLEFT", LFGDungeonReadyDialogEnterDungeonButton, "BOTTOMLEFT", 2, -7)
queue:CreateBackdrop("Overlay")
queue:SetSize(240, 10)

queue.bar = CreateFrame("StatusBar", nil, queue)
queue.bar:SetStatusBarTexture(C.media.texture)
queue.bar:SetAllPoints()
queue.bar:SetFrameLevel(LFGDungeonReadyDialog:GetFrameLevel() + 1)
queue.bar:SetStatusBarColor(1, 0.7, 0)

LFGDungeonReadyDialog.nextUpdate = 0

local function UpdateBar()
	local obj = LFGDungeonReadyDialog
	local oldTime = GetTime()
	local flag = 0
	local duration = 40
	local interval = 0.1
	obj:SetScript("OnUpdate", function(self, elapsed)
		obj.nextUpdate = obj.nextUpdate + elapsed
		if obj.nextUpdate > interval then
			local newTime = GetTime()
			if (newTime - oldTime) < duration then
				local width = queue:GetWidth() * (newTime - oldTime) / duration
				queue.bar:SetPoint("BOTTOMRIGHT", queue, 0 - width, 0)
				flag = flag + 1
				if flag >= 10 then
					flag = 0
				end
			else
				obj:SetScript("OnUpdate", nil)
			end
			obj.nextUpdate = 0
		end
	end)
end

queue:RegisterEvent("LFG_PROPOSAL_SHOW")
queue:SetScript("OnEvent", function(self)
	if LFGDungeonReadyDialog:IsShown() then
		UpdateBar()
	end
end)

----------------------------------------------------------------------------------------
--	Loot frame and DamageMeter toggle button
----------------------------------------------------------------------------------------
if C.chat.enable ~= true then return end
local LootButton = CreateFrame("Frame", "LootToggleButton", UIParent)
LootButton:EnableMouse(true)
LootButton:SetAlpha(0)

LootButton.Text = LootButton:CreateFontString(nil, "OVERLAY")
LootButton.Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
LootButton.Text:SetPoint("CENTER", 2, 0)
LootButton.Text:SetTextColor(0.3, 0.3, 0.9)
LootButton:CreatePanel("Transparent", 17, (C.chat.height - 20) / 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -1, 20)

local DamageButton = CreateFrame("Frame", "DamageToggleButton", UIParent)
DamageButton:EnableMouse(true)
DamageButton:SetAlpha(0)

DamageButton.Text = DamageButton:CreateFontString(nil, "OVERLAY")
DamageButton.Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
DamageButton.Text:SetPoint("CENTER", 2, 0)
DamageButton.Text:SetTextColor(0.9, 0.3, 0.3)
DamageButton:CreatePanel("Transparent", 17, (C.chat.height - 20) / 2, "BOTTOM", LootToggleButton, "TOP", 0, 1)

local LootShow = function()
	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetSize(C.chat.width, C.chat.height)
	if C.chat.background == true then
		ChatFrame3:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5] + 4)
		TooltipAnchor:SetPoint("BOTTOMRIGHT", ChatTabsPanelRight, "TOPRIGHT", 0, 3)
	else
		ChatFrame3:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5])
		TooltipAnchor:SetPoint("BOTTOMRIGHT", RightPanel, "TOPRIGHT", 0, 3)
		RightPanel:Show()
	end
	FCF_SavePositionAndDimensions(ChatFrame3)
	LootButton.Text:SetText(">\n>\n>")
	SavedOptionsPerChar.LootFrame = true
end

local LootHide = function()
	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 200, 0)
	if C.chat.background ~= true then RightPanel:Hide() end
	FCF_SavePositionAndDimensions(ChatFrame3)
	LootButton.Text:SetText("<\n<\n<")
	SavedOptionsPerChar.LootFrame = false
end

local DamageShow = function()
	alDamageMeterFrame:ClearAllPoints()
	alDamageMeterFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -23, 26)
	TooltipAnchor:SetPoint("BOTTOMRIGHT", alDamageMeterFrame, "TOPRIGHT", 2, 5)
	DamageButton.Text:SetText(">\n>\n>")
	SavedOptionsPerChar.DamageMeter = true
end

local DamageHide = function()
	alDamageMeterFrame:ClearAllPoints()
	alDamageMeterFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 23, 26)
	DamageButton.Text:SetText("<\n<\n<")
	SavedOptionsPerChar.DamageMeter = false
end

LootButton:SetScript("OnEnter", function()
	LootButton:FadeIn()
end)

LootButton:SetScript("OnLeave", function()
	LootButton:FadeOut()
end)

DamageButton:SetScript("OnEnter", function()
	DamageButton:FadeIn()
end)

DamageButton:SetScript("OnLeave", function()
	DamageButton:FadeOut()
end)

ChatFrame3:RegisterEvent("PLAYER_LOGIN")
ChatFrame3:HookScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		self:UnregisterEvent(event)
		_, _, _, alDamageMeterEnabled = GetAddOnInfo("alDamageMeter")
		if SavedOptionsPerChar.LootFrame == nil then SavedOptionsPerChar.LootFrame = true end
		if SavedOptionsPerChar.DamageMeter == nil then SavedOptionsPerChar.DamageMeter = false end
		if SavedOptionsPerChar.LootFrame == true and alDamageMeterEnabled ~= nil then
			LootShow()
			DamageHide()
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == true and alDamageMeterEnabled ~= nil then
			LootHide()
			DamageShow()
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == false and alDamageMeterEnabled ~= nil then
			LootHide()
			DamageHide()
			TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
		else
			LootShow()
			LootButton:SetHeight(C.chat.height - 19)
			DamageButton:ClearAllPoints()
			LootHistoryButton:SetPoint("BOTTOM", LootToggleButton, "TOP", 0, 1)
		end
	end
end)

LootButton:SetScript("OnMouseDown", function()
	if alDamageMeterEnabled ~= nil then
		if SavedOptionsPerChar.LootFrame == true and SavedOptionsPerChar.DamageMeter == false then
			LootHide()
			TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == true then
			LootShow()
			DamageHide()
		else
			LootShow()
		end
	else
		if SavedOptionsPerChar.LootFrame == true then
			LootHide()
			TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
		else
			LootShow()
		end
	end
end)

DamageButton:SetScript("OnMouseDown", function()
	if SavedOptionsPerChar.DamageMeter == true and SavedOptionsPerChar.LootFrame == false then
		DamageHide()
		TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
	elseif SavedOptionsPerChar.DamageMeter == false and SavedOptionsPerChar.LootFrame == true then
		DamageShow()
		LootHide()
	else
		DamageShow()
	end
end)

----------------------------------------------------------------------------------------
--	LootHistory toggle button
----------------------------------------------------------------------------------------
local LootHistoryButton = CreateFrame("Button", "LootHistoryButton", UIParent)
LootHistoryButton:EnableMouse(true)
LootHistoryButton:SetAlpha(0)

LootHistoryButton.Text = LootHistoryButton:CreateFontString(nil, "OVERLAY")
LootHistoryButton.Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
LootHistoryButton.Text:SetPoint("CENTER", 2, 0)
LootHistoryButton.Text:SetText("L")
LootHistoryButton.Text:SetTextColor(0.3, 0.3, 0.9)

LootHistoryButton:CreatePanel("Transparent", 17, 17, "BOTTOM", DamageToggleButton, "TOP", 0, 1)

LootHistoryButton:SetScript("OnEnter", function()
	LootHistoryButton:FadeIn()
end)

LootHistoryButton:SetScript("OnLeave", function()
	LootHistoryButton:FadeOut()
end)

LootHistoryButton:SetScript("OnMouseDown", function()
	if LootHistoryFrame:IsShown() then
		LootHistoryButton.Text:SetTextColor(0.3, 0.3, 0.9)
	else
		LootHistoryButton.Text:SetTextColor(0.9, 0.3, 0.3)
	end
	ToggleLootHistoryFrame()
end)

----------------------------------------------------------------------------------------
--	RangeDisplay
----------------------------------------------------------------------------------------
--if T.class ~= "PRIEST" then return end
local RangeDisplayText = UIParent:CreateFontString(nil, "OVERLAY")
RangeDisplayText:SetFont(C.media.pixel_font, C.media.pixel_font_size * 2, C.media.pixel_font_style)
RangeDisplayText:SetPoint("CENTER", 0, -100)
local FriendItems = {
	37727,	-- 5
	34368,	-- 8
	32321,	-- 10
	1251,	-- 15
	21519,	-- 20
	31463,	-- 25
	1180,	-- 30
	18904,	-- 35
	34471,	-- 40
	}
local EnemyItems = {
	37727,	-- 5
	34368,	-- 8
	32321,	-- 10
	33069,	-- 15
	10645,	-- 20
	31463,	-- 25
	835,	-- 30
	24269,	-- 35
	28767,	-- 40
	}
local Target = nil
local Distance = 0
local RangeDisplay = CreateFrame("Frame")
RangeDisplay:SetScript("OnUpdate", function()
	if UnitCanAssist("player", "target") and UnitName("target") ~= T.name then
		Target = FriendItems
	elseif UnitCanAttack("player", "target") then
		Target = EnemyItems
	end
	if Target ~= nil then
		for key, item in pairs(Target) do
			if IsItemInRange(item, "target") == 0 then
				Distance = key
			end
		end
	end
	if Target == nil then
		RangeDisplayText:Hide()
	else
		RangeDisplayText:Show()
	end
	if Distance == 0 then
		RangeDisplayText:SetText("< 5")
		RangeDisplayText:SetTextColor(0.9, 0.9, 0.9)
	elseif Distance == 1 then
		RangeDisplayText:SetText("5-8")
	elseif Distance == 2 then
		RangeDisplayText:SetText("8-10")
	elseif Distance <= 8 then
		minDistance = Distance * 5 - 5
		maxDistance = Distance * 5
		RangeDisplayText:SetText(minDistance.."-"..maxDistance)
		RangeDisplayText:SetTextColor(0.9, 0.9, 0.3)
	else
		RangeDisplayText:SetTextColor(0.9, 0.2, 0.2)
		RangeDisplayText:SetText("> 40")
	end
	if Distance > 0 and Distance <= 4 then
		RangeDisplayText:SetTextColor(0.3, 0.9, 0.9)
	elseif Distance ~= 0 and Distance <= 6 then
		RangeDisplayText:SetTextColor(0.3, 0.9, 0.3)
	end
	Distance = 0
	Target = nil
end)