local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Force readycheck warning
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(self, initiator)
	if initiator ~= "player" then
		PlaySound(SOUNDKIT.READY_CHECK, "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	Force other warning
----------------------------------------------------------------------------------------
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
if not T.classic then
	ForceWarning:RegisterEvent("PET_BATTLE_QUEUE_PROPOSE_MATCH")
	ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
end
ForceWarning:RegisterEvent("RESURRECT_REQUEST")
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" then
		for i = 1, GetMaxBattlefieldID() do
			local status = GetBattlefieldStatus(i)
			if status == "confirm" then
				PlaySound(SOUNDKIT.PVP_THROUGH_QUEUE, "Master")
				break
			end
			i = i + 1
		end
	elseif event == "PET_BATTLE_QUEUE_PROPOSE_MATCH" then
		PlaySound(SOUNDKIT.PVP_THROUGH_QUEUE, "Master")
	elseif event == "LFG_PROPOSAL_SHOW" then
		PlaySound(SOUNDKIT.READY_CHECK, "Master")
	elseif event == "RESURRECT_REQUEST" then
		PlaySoundFile("Sound\\Spells\\Resurrection.wav", "Master")
	end
end)

----------------------------------------------------------------------------------------
--	Misclicks for some popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
PetBattleQueueReadyFrame.hideOnEscape = nil
if not T.classic then
	PVPReadyDialog.leaveButton:Hide()
	PVPReadyDialog.enterButton:ClearAllPoints()
	PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 25)
end

----------------------------------------------------------------------------------------
--	Spin camera while afk(by Telroth and Eclipse)
----------------------------------------------------------------------------------------
if C.misc.afk_spin_camera == true then
	local spinning
	local function SpinStart()
		spinning = true
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	local function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		if InCombatLockdown() then return end
		UIParent:Show()
	end

	local SpinCam = CreateFrame("Frame")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", function(self, event, unit)
		if event == "PLAYER_LEAVING_WORLD" then
			SpinStop()
		else
			if UnitIsAFK("player") and not InCombatLockdown() then
				SpinStart()
			else
				SpinStop()
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
----------------------------------------------------------------------------------------
if not T.classic then
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
if T.classic then
	strip:SetFrameLevel(DressUpModelFrame:GetFrameLevel() + 2)
end
strip:RegisterForClicks("AnyUp")
strip:SetScript("OnClick", function(self, button)
	if button == "RightButton" then
		self.model:UndressSlot(19)
	else
		self.model:Undress()
	end
	PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)
if not T.classic then
	strip.model = DressUpModel
else
	strip.model = DressUpModelFrame
end

strip:RegisterEvent("AUCTION_HOUSE_SHOW")
strip:RegisterEvent("AUCTION_HOUSE_CLOSED")
strip:SetScript("OnEvent", function(self)
	if AuctionFrame:IsVisible() and self.model ~= SideDressUpModel then
		self:SetParent(SideDressUpModel)
		self:ClearAllPoints()
		self:SetPoint("TOP", SideDressUpModelResetButton, "BOTTOM", 0, -3)
		self.model = SideDressUpModel
	elseif not T.classic and self.model ~= DressUpModel then
		self:SetParent(DressUpModel)
		self:ClearAllPoints()
		self:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
		self.model = DressUpModel
	elseif T.classic and self.model ~= DressUpModelFrame then
		self:SetParent(DressUpModelFrame)
		self:ClearAllPoints()
		self:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
		self.model = DressUpModelFrame
	end
end)

----------------------------------------------------------------------------------------
--	GuildTab in FriendsFrame
----------------------------------------------------------------------------------------
if not T.classic then
	local n = FriendsFrame.numTabs + 1
	local gtframe = CreateFrame("Button", "FriendsFrameTab"..n, FriendsFrame, "FriendsFrameTabTemplate")
	gtframe:SetText(GUILD)
	gtframe:SetPoint("LEFT", _G["FriendsFrameTab"..n - 1], "RIGHT", -15, 0)
	PanelTemplates_DeselectTab(gtframe)
	gtframe:SetScript("OnClick", function() ToggleGuildFrame() end)
end

----------------------------------------------------------------------------------------
--	Force quit
----------------------------------------------------------------------------------------
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)

----------------------------------------------------------------------------------------
--	Old achievements filter
----------------------------------------------------------------------------------------
if not T.classic then
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
end

----------------------------------------------------------------------------------------
--	Boss Banner Hider
----------------------------------------------------------------------------------------
if not T.classic then
	if C.misc.hide_banner == true then
		BossBanner.PlayBanner = function() end
	end
end

----------------------------------------------------------------------------------------
--	Hide TalkingHeadFrame
----------------------------------------------------------------------------------------
if C.misc.hide_talking_head == true then
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(self, event, addon)
		if addon == "Blizzard_TalkingHeadUI" then
			hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
				TalkingHeadFrame:Hide()
			end)
			self:UnregisterEvent(event)
		end
	end)
end

----------------------------------------------------------------------------------------
--	Hide button for oUF_RaidDPS 
----------------------------------------------------------------------------------------
if C.misc.hide_raid_button == true then
	local show = false
	SlashCmdList.HideRaidMODE = function()
		if show == false then
			if oUF_RaidDPS1 then
				for i = 1, C.raidframe.raid_groups do
					_G["oUF_RaidDPS"..i]:SetAlpha(0)
				end
				oUF_MainTank:SetAlpha(0)
			end
			show = true
		else
			if oUF_RaidDPS1 then
				for i = 1, C.raidframe.raid_groups do
					_G["oUF_RaidDPS"..i]:SetAlpha(1)
				end
				oUF_MainTank:SetAlpha(1)
			end
			show = false
		end

	end
	SLASH_HIDERAIDMODE1 = "/hideraid"

	local HideRaid = CreateFrame("Button", "HideRaidMode", UIParent)
	HideRaid:SetTemplate("ClassColor")
	HideRaid:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
	HideRaid:SetSize(19, 19)
	HideRaid:SetAlpha(0)
	HideRaid:Hide()

	HideRaid.t = HideRaid:CreateTexture(nil, "OVERLAY")
	HideRaid.t:SetTexture("Interface\\Icons\\inv_misc_spyglass_03")
	HideRaid.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	HideRaid.t:SetPoint("TOPLEFT", HideRaid, 2, -2)
	HideRaid.t:SetPoint("BOTTOMRIGHT", HideRaid, -2, 2)

	HideRaid:SetScript("OnClick", function()
		if oUF_RaidDPS1 and oUF_RaidDPS1:IsShown() then
			SlashCmdList.HideRaidMODE()
		end
	end)

	HideRaid:SetScript("OnEnter", function()
		if oUF_RaidDPS1 and oUF_RaidDPS1:IsShown() then
			HideRaid:FadeIn()
		end
	end)

	HideRaid:SetScript("OnLeave", function()
		HideRaid:FadeOut()
	end)

	HideRaid:RegisterEvent("PLAYER_LOGIN")
	HideRaid:SetScript("OnEvent", function(self)
		if C.unitframe.enable == true and SavedOptions and SavedOptions.RaidLayout == "DPS" then
			self:Show()
		end
	end)
end

----------------------------------------------------------------------------------------
--	Change UIErrorsFrame strata
----------------------------------------------------------------------------------------
UIErrorsFrame:SetFrameLevel(0)