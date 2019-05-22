local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Kill all stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		if C.tooltip.enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	-- Temporarily permit Blizzard CRFM since oUF is presently not spawning correctly.
	if not T.classic then
		if C.unitframe.enable and (SavedOptions and (SavedOptions.RaidLayout == "HEAL" or SavedOptions.RaidLayout == "DPS")) then
			InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
			if not InCombatLockdown() then
				CompactRaidFrameManager:Kill()
				CompactRaidFrameContainer:Kill()
			end
			ShowPartyFrame = T.dummy
			HidePartyFrame = T.dummy
			CompactUnitFrameProfiles_ApplyProfile = T.dummy
			CompactRaidFrameManager_UpdateShown = T.dummy
			CompactRaidFrameManager_UpdateOptionsFlowContainer = T.dummy
		end
	end

	Advanced_UseUIScale:Kill()
	Advanced_UIScaleSlider:Kill()
	if not T.classic then
		TutorialFrameAlertButton:Kill()
	end
	HelpOpenTicketButtonTutorial:Kill()
	if not T.classic then
		TalentMicroButtonAlert:Kill()
		CollectionsMicroButtonAlert:Kill()
		ReagentBankHelpBox:Kill()
	end
	BagHelpBox:Kill()
	if not T.classic then
		EJMicroButtonAlert:Kill()
		PremadeGroupsPvETutorialAlert:Kill()
	end
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_WORLD_MAP_FRAME, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_PET_JOURNAL, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_GARRISON_BUILDING, true)

	SetCVar("countdownForCooldowns", 0)
	InterfaceOptionsActionBarsPanelCountdownCooldowns:Kill()

	if C.chat.enable then
		SetCVar("chatStyle", "im")
	end

	if C.unitframe.enable then
		if T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune ~= true then
			RuneFrame:Kill()
		end
		InterfaceOptionsCombatPanelTargetOfTarget:Kill()
		SetCVar("showPartyBackground", 0)
	end

	if C.actionbar.enable then
		InterfaceOptionsActionBarsPanelBottomLeft:Kill()
		InterfaceOptionsActionBarsPanelBottomRight:Kill()
		InterfaceOptionsActionBarsPanelRight:Kill()
		InterfaceOptionsActionBarsPanelRightTwo:Kill()
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
		InterfaceOptionsActionBarsPanelStackRightBars:Kill()
	end

	if C.nameplate.enable then
		SetCVar("ShowClassColorInNameplate", 1)
	end

	if C.minimap.enable then
		InterfaceOptionsDisplayPanelRotateMinimap:Kill()
	end

	if C.bag.enable then
		if not T.classic then
			SetSortBagsRightToLeft(true)
		end
		SetInsertItemsLeftToRight(false)
	end
end)