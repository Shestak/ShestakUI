local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Kill all shit stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:RegisterEvent("PLAYER_LOGIN")
Kill:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		if IsAddOnLoaded("ShestakUI_DPS") or IsAddOnLoaded("ShestakUI_Heal") then
			InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
			SetCVar("useCompactPartyFrames", 0)
			CompactRaidFrameManager:Kill()
			CompactRaidFrameContainer:Kill()
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
		PartyMemberBackground:Kill()
		TutorialFrameAlertButton:Kill()
		InterfaceOptionsUnitFramePanelPartyBackground:Kill()
		
		if C.chat.enable then
			SetCVar("WholeChatWindowClickable", 0)
			SetCVar("ConversationMode", "inline")
			InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
			InterfaceOptionsSocialPanelConversationMode:Kill()
		end
		
		if C.unitframe.enable then
			InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)	
			InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
			InterfaceOptionsBuffsPanelShowCastableDebuffs:Kill()
			InterfaceOptionsBuffsPanelCastableBuffs:Kill()
			InterfaceOptionsBuffsPanelDispellableDebuffs:Kill()
			InterfaceOptionsBuffsPanelBuffDurations:Kill()
		end
		
		if C.unitframe.show_arena then
			SetCVar("showArenaEnemyFrames", 0)
			InterfaceOptionsUnitFramePanelArenaEnemyFrames:Kill()
			InterfaceOptionsUnitFramePanelArenaEnemyCastBar:Kill()
			InterfaceOptionsUnitFramePanelArenaEnemyPets:Kill()
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