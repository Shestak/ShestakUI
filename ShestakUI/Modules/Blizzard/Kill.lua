local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Kill all shit stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:RegisterEvent("PLAYER_LOGIN")
Kill:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		if C.unitframe.enable and (IsAddOnLoaded("ShestakUI_DPS") or IsAddOnLoaded("ShestakUI_Heal")) then
			InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
			SetCVar("useCompactPartyFrames", 0)
			CompactRaidFrameManager:Kill()
			CompactRaidFrameContainer:Kill()
			CompactUnitFrame_UpateVisible = T.dummy
			CompactUnitFrame_UpdateAll = T.dummy
		end
	else
		if addon == "Blizzard_AchievementUI" then
			if C.tooltip.enable then
				hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
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
				SetCVar("showArenaEnemyFrames", 0)
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
	end
end)