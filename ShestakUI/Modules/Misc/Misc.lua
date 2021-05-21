local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Force readycheck warning
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(_, initiator)
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
ForceWarning:RegisterEvent("PET_BATTLE_QUEUE_PROPOSE_MATCH")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("RESURRECT_REQUEST")
ForceWarning:SetScript("OnEvent", function(_, event)
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
		PlaySound(37, "Master")
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
PVPReadyDialog.leaveButton:Hide()
PVPReadyDialog.enterButton:ClearAllPoints()
PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 25)

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
	SpinCam:SetScript("OnEvent", function(_, event)
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
--	Undress button in dress-up frame(by Nefarion)
----------------------------------------------------------------------------------------
local strip = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate")
strip:SetText(L_MISC_UNDRESS)
strip:SetWidth(strip:GetTextWidth() + 40)
strip:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
strip:RegisterForClicks("AnyUp")
strip:SetScript("OnClick", function(_, button)
	local actor = DressUpFrame.ModelScene:GetPlayerActor()
	if not actor then return end
	if button == "RightButton" then
		actor:UndressSlot(19)
	else
		actor:Undress()
	end
	PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)

----------------------------------------------------------------------------------------
--	Boss Banner Hider
----------------------------------------------------------------------------------------
if C.general.hide_banner == true then
	BossBanner.PlayBanner = function() end
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
				if oUF_MainTank then
					oUF_MainTank:SetAlpha(0)
				end
			end
			show = true
		else
			if oUF_RaidDPS1 then
				for i = 1, C.raidframe.raid_groups do
					_G["oUF_RaidDPS"..i]:SetAlpha(1)
				end
				if oUF_MainTank then
					oUF_MainTank:SetAlpha(1)
				end
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
		if C.unitframe.enable == true and C.raidframe.layout == "DPS" then
			self:Show()
		end
	end)
end

----------------------------------------------------------------------------------------
--	Easy delete good items
----------------------------------------------------------------------------------------
hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_ITEM"], "OnShow", function(s) s.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) s.editBox:SetAutoFocus(false) s.editBox:ClearFocus() end)

----------------------------------------------------------------------------------------
--	Change UIErrorsFrame strata
----------------------------------------------------------------------------------------
UIErrorsFrame:SetFrameLevel(0)