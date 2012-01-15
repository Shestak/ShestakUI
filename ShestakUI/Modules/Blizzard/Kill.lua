local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Kill all shit stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		if C.tooltip.enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	if C.unitframe.enable and (addon == "ShestakUI_DPS" or addon == "ShestakUI_Heal") then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)

		local function KillRaidFrame()
			CompactRaidFrameManager:UnregisterAllEvents()
			if not InCombatLockdown() then CompactRaidFrameManager:Hide() end

			local shown = CompactRaidFrameManager_GetSetting("IsShown")
			if shown and shown ~= "0" then
				CompactRaidFrameManager_SetSetting("IsShown", "0")
			end
		end

		hooksecurefunc("CompactRaidFrameManager_UpdateShown", function()
			KillRaidFrame()
		end)

		KillRaidFrame()

		local function KillPartyFrame()
			CompactPartyFrame:SetScale(0.00001)
			CompactPartyFrame:SetAlpha(0)

			for i = 1, MEMBERS_PER_RAID_GROUP do
				local name = "CompactPartyFrameMember"..i
				local frame = _G[name]
				frame:UnregisterAllEvents()
			end
		end

		for i = 1, MAX_PARTY_MEMBERS do
			local name = "PartyMemberFrame"..i
			local frame = _G[name]

			frame:Kill()

			_G[name.."HealthBar"]:UnregisterAllEvents()
			_G[name.."ManaBar"]:UnregisterAllEvents()
		end
		
		if CompactPartyFrame then
			KillPartyFrame()
		elseif CompactPartyFrame_Generate then
			hooksecurefunc("CompactPartyFrame_Generate", KillPartyFrame)
		end
	end

	if addon ~= "ShestakUI" then return end

	Advanced_UseUIScale:Kill()
	Advanced_UIScaleSlider:Kill()
	TutorialFrameAlertButton:Kill()
	HelpOpenTicketButtonTutorial:Kill()
	PlayerTalentFrameLearnButtonTutorialArrow:Kill()
	TalentMicroButtonAlert:Kill()

	if C.chat.enable then
		SetCVar("WholeChatWindowClickable", 0)
		SetCVar("ConversationMode", "inline")
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
		InterfaceOptionsSocialPanelConversationMode:Kill()
	end

	if C.unitframe.enable then
		PlayerFrame:Kill()
		if T.class == "DEATHKNIGHT" and C.unitframe.plugins_rune_bar ~= true then
			RuneFrame:Kill()
		end
		InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)
		InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
		InterfaceOptionsBuffsPanelCastableBuffs:Kill()
		InterfaceOptionsBuffsPanelDispellableDebuffs:Kill()
		InterfaceOptionsBuffsPanelBuffDurations:Kill()
		InterfaceOptionsBuffsPanelShowAllEnemyDebuffs:Kill()
		InterfaceOptionsUnitFramePanelPartyBackground:Kill()
		PartyMemberBackground:Kill()

		if C.unitframe.show_arena then
			InterfaceOptionsUnitFramePanelArenaEnemyFrames:Kill()
			InterfaceOptionsUnitFramePanelArenaEnemyCastBar:Kill()
			InterfaceOptionsUnitFramePanelArenaEnemyPets:Kill()
		end
	end

	if C.actionbar.enable then
		InterfaceOptionsActionBarsPanelBottomLeft:Kill()
		InterfaceOptionsActionBarsPanelBottomRight:Kill()
		InterfaceOptionsActionBarsPanelRight:Kill()
		InterfaceOptionsActionBarsPanelRightTwo:Kill()
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
	end

	if C.nameplate.enable == true and C.nameplate.enhance_threat == true then
		InterfaceOptionsDisplayPanelAggroWarningDisplay:Kill()
	end

	if C.combattext.enable then
		InterfaceOptionsCombatTextPanelFCTDropDown:Kill()
		if C.combattext.blizz_head_numbers ~= true then
			SetCVar("CombatLogPeriodicSpells", 0)
			SetCVar("PetMeleeDamage", 0)
			SetCVar("CombatDamage", 0)
			SetCVar("CombatHealing", 0)
			InterfaceOptionsCombatTextPanelTargetDamage:Kill()
			InterfaceOptionsCombatTextPanelPeriodicDamage:Kill()
			InterfaceOptionsCombatTextPanelPetDamage:Kill()
			InterfaceOptionsCombatTextPanelHealing:Kill()
		end
	end
end)