local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Force readycheck warning
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(self, initiator)
	if initiator ~= "player" then
		PlaySound("ReadyCheck", "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	Misclicks for some popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE_XREALM.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
PetBattleQueueReadyFrame.hideOnEscape = nil
PVPReadyDialog.leaveButton:Hide()
PVPReadyDialog.enterButton:ClearAllPoints()
PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 25)

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
--	Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
----------------------------------------------------------------------------------------
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = 1
		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetType(id)
			end
		end
	end
end)

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
gtframe:SetText(GUILD)
gtframe:SetPoint("LEFT", _G["FriendsFrameTab"..n - 1], "RIGHT", -15, 0)
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
			if C.skins.blizzard_frames == true then
				AchievementFrameFilterDropDown:SetWidth(AchievementFrameFilterDropDown:GetWidth() + 20)
			end
			filter:UnregisterEvent("ADDON_LOADED")
		end
	end
end)

----------------------------------------------------------------------------------------
--  RangeDisplay
----------------------------------------------------------------------------------------
if C.unitframe.enable ~= true or C.unitframe.enable == true and C.unitframe_class_bar.range == true and T.class == "PRIEST" then return end
local RangeDisplay = UIParent:CreateFontString(nil, "OVERLAY")
RangeDisplay:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
RangeDisplay:SetPoint("CENTER", oUF_Target, "CENTER", 0, -9)
local Items = {
["Friend"] = {
        37727,  -- 5
        34368,  -- 8
        32321,  -- 10
        1251,   -- 15
        21519,  -- 20
        31463,  -- 25
        1180,   -- 30
        18904,  -- 35
        34471,  -- 40
    },
    ["Enemy"] = {
        37727,  -- 5
        34368,  -- 8
        32321,  -- 10
        33069,  -- 15
        10645,  -- 20
        31463,  -- 25
        835,    -- 30
        18904,  -- 35
        28767,  -- 40
    },
}
local Colors = {
    {0.3, 0.3, 0.9},    -- 0-5
    {0.3, 0.9, 0.9},    -- 5-8
    {0.3, 0.9, 0.9},    -- 5-10
    {0.3, 0.9, 0.9},    -- 10-15
    {0.9, 0.9, 0.1},    -- 15-20
    {0.9, 0.9, 0.1},    -- 20-25
    {0.1, 0.9, 0.1},    -- 25-30
    {0.9, 0.9, 0.1},    -- 30-35
    {0.9, 0.9, 0.1},    -- 35-40
    {0.9, 0.1, 0.1},    -- >40
}

local timer = 0
local f = CreateFrame("Frame")
f:SetScript("OnUpdate", function(self, elapsed)
    timer = timer + elapsed
    if timer >= 0.2 then
        local distance = 0
        local target = nil
        
        if UnitCanAssist("player", "target") and UnitIsUnit("target", "player") == nil then
            target = Items.Friend
        elseif UnitCanAttack("player", "target") then
            target = Items.Enemy
        end
        
        if target ~= nil then
            RangeDisplay:Show()
            for key, item in pairs(target) do
                if IsItemInRange(item, "target") == 0 then
                    distance = key
                end
            end
            for key, color in pairs(Colors) do
                local r, g, b = unpack(color)
                if distance == key - 1 then
                    RangeDisplay:SetTextColor(r, g, b)
                end
            end
        else
            RangeDisplay:Hide()
        end
        
        if distance == 0 then
            RangeDisplay:SetText("< 5")
        elseif distance == 1 then
            RangeDisplay:SetText("5-8")
        elseif distance == 2 then
            RangeDisplay:SetText("8-10")
        elseif distance < 9 then
            local minDistance = distance * 5 - 5
            local maxDistance = distance * 5
            RangeDisplay:SetText(minDistance.."-"..maxDistance)
        else
            RangeDisplay:SetText("> 40")
        end
        
        timer = 0
    end
end)

-- Edit by Oz of shestakdotorg --
