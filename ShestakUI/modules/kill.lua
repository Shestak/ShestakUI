----------------------------------------------------------------------------------------
--	Kill all shit stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local k = SettingsDB.Kill

local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:RegisterEvent("PLAYER_ENTERING_WORLD")
Kill:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		
		if IsAddOnLoaded("ShestakUI_DPS") or IsAddOnLoaded("ShestakUI_Heal") then
			InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
			CompactRaidFrameManager:SetScale(0.00001)
			CompactRaidFrameManager:SetAlpha(0)
			CompactRaidFrameContainer:SetScale(0.00001)
			CompactRaidFrameContainer:SetAlpha(0)
			CompactPartyFrame:SetScale(0.00001)
			CompactPartyFrame:SetAlpha(0)
		end
	else
		if addon ~= "ShestakUI" then return end
		
		--k(StreamingIcon)
		k(Advanced_UseUIScale)
		k(Advanced_UIScaleSlider)
		k(PartyMemberBackground)
		k(TutorialFrameAlertButton)
		
		k(InterfaceOptionsUnitFramePanelPartyBackground)
		
		if SettingsCF.chat.enable then
			SetCVar("WholeChatWindowClickable", 0)
			SetCVar("ConversationMode", "inline")
			k(InterfaceOptionsSocialPanelWholeChatWindowClickable)
			k(InterfaceOptionsSocialPanelConversationMode)
		end
		
		if SettingsCF.unitframe.enable then
			InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)	
			InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
			k(InterfaceOptionsBuffsPanelShowCastableDebuffs)
			k(InterfaceOptionsBuffsPanelCastableBuffs)
			k(InterfaceOptionsBuffsPanelDispellableDebuffs)
			k(InterfaceOptionsBuffsPanelBuffDurations)
			if SettingsDB.class == "DEATHKNIGHT" then
				k(RuneFrame)
			end
		end
		
		if SettingsCF.unitframe.show_arena then
			SetCVar("showArenaEnemyFrames", 0)
			k(InterfaceOptionsUnitFramePanelArenaEnemyFrames)
			k(InterfaceOptionsUnitFramePanelArenaEnemyCastBar)
			k(InterfaceOptionsUnitFramePanelArenaEnemyPets)
		end
		
		if SettingsCF.actionbar.enable then
			k(InterfaceOptionsActionBarsPanelBottomLeft)
			k(InterfaceOptionsActionBarsPanelBottomRight)
			k(InterfaceOptionsActionBarsPanelRight)
			k(InterfaceOptionsActionBarsPanelRightTwo)
			k(InterfaceOptionsActionBarsPanelAlwaysShowActionBars)
		end
	end
end)