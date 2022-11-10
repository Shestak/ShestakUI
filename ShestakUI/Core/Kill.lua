local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Kill all stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_AchievementUI" then
		if C.tooltip.enable then
			--BETA hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	if ClassPowerBar then
		ClassPowerBar.OnEvent = T.dummy -- Fix error with druid on logon
	end

	if C.unitframe.enable and C.raidframe.layout ~= "BLIZZARD" then
		--BETA InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
		-- InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
		-- if not InCombatLockdown() then
			-- CompactRaidFrameManager:Kill()
			-- CompactRaidFrameContainer:Kill()
		-- end
		-- ShowPartyFrame = T.dummy
		-- HidePartyFrame = T.dummy
		-- CompactUnitFrameProfiles_ApplyProfile = T.dummy
		if CompactRaidFrameManager then
			local function HideFrames()
				CompactRaidFrameManager:UnregisterAllEvents()
				CompactRaidFrameContainer:UnregisterAllEvents()
				if not InCombatLockdown() then
					CompactRaidFrameManager:Hide()
					local shown = CompactRaidFrameManager_GetSetting("IsShown")
					if shown and shown ~= "0" then
						CompactRaidFrameManager_SetSetting("IsShown", "0")
					end
				end
			end
			local hiddenFrame = CreateFrame("Frame")
			hiddenFrame:Hide()
			hooksecurefunc("CompactRaidFrameManager_UpdateShown", HideFrames)
			CompactRaidFrameManager:HookScript("OnShow", HideFrames)
			CompactRaidFrameContainer:HookScript("OnShow", HideFrames)
			HideFrames()
		end
	end

	--BETA Display_UseUIScale:Kill()
	-- Display_UIScaleSlider:Kill()
	TutorialFrameAlertButton:Kill()
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_WORLD_MAP_FRAME, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_PET_JOURNAL, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_GARRISON_BUILDING, true)

	SetCVar("countdownForCooldowns", 0)
	--BETA InterfaceOptionsActionBarsPanelCountdownCooldowns:Hide()

	if C.chat.enable then
		--BETA InterfaceOptionsSocialPanelChatStyle:Hide()
		SetCVar("chatStyle", "im")
	end

	if C.unitframe.enable then
		if T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune ~= true then
			RuneFrame:Kill()
		end
		--BETA InterfaceOptionsDisplayPanelDisplayDropDown:Hide()
		--BETA InterfaceOptionsCombatPanelTargetOfTarget:Hide()
		SetCVar("showPartyBackground", 0)
	end

	if C.actionbar.enable then
		--BETA InterfaceOptionsActionBarsPanelBottomLeft:Hide()
		-- InterfaceOptionsActionBarsPanelBottomRight:Hide()
		-- InterfaceOptionsActionBarsPanelRight:Hide()
		-- InterfaceOptionsActionBarsPanelRightTwo:Hide()
		-- InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Hide()
		-- InterfaceOptionsActionBarsPanelStackRightBars:Hide()
		if not InCombatLockdown() then
			SetCVar("multiBarRightVerticalLayout", 0)
		end
	end

	if C.nameplate.enable then
		SetCVar("ShowClassColorInNameplate", 1)
	end

	if C.minimap.enable then
		--BETA InterfaceOptionsDisplayPanelRotateMinimap:Hide()
		SetCVar("minimapTrackingShowAll", 1)
	end

	if C.bag.enable then
		if not T.newPatch then -- BETA
			SetSortBagsRightToLeft(true)
			SetInsertItemsLeftToRight(false)
		else
			C_Container.SetSortBagsRightToLeft(true)
			C_Container.SetInsertItemsLeftToRight(false)
		end
	end

	if C.combattext.enable then
		--BETA InterfaceOptionsCombatPanelEnableFloatingCombatText:Hide()
		if C.combattext.incoming then
			SetCVar("enableFloatingCombatText", 1)
		else
			SetCVar("enableFloatingCombatText", 0)
		end
	end

	SetCVar("ActionButtonUseKeyDown", 0) -- BETA
end)

local function AcknowledgeTips()
	if InCombatLockdown() then return end

	for frame in _G.HelpTip.framePool:EnumerateActive() do
		frame:Acknowledge()
	end
end

AcknowledgeTips()
hooksecurefunc(_G.HelpTip, "Show", AcknowledgeTips)
