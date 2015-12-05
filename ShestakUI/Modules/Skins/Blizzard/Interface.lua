local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Interface skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	InterfaceOptionsFrame:StripTextures()
	InterfaceOptionsFrame:SetTemplate("Transparent")

	InterfaceOptionsFrameHeader:SetTexture(nil)
	InterfaceOptionsFrameHeader:ClearAllPoints()
	InterfaceOptionsFrameHeader:SetPoint("TOP", InterfaceOptionsFrame, 0, 0)

	InterfaceOptionsFrameTab1:StripTextures()
	InterfaceOptionsFrameTab2:StripTextures()

	local frames = {
		"InterfaceOptionsFramePanelContainer",
		"InterfaceOptionsFrameAddOns",
		"InterfaceOptionsFrameCategories",
		"InterfaceOptionsFrameTab1",
		"InterfaceOptionsFrameTab2"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			frame:SetTemplate("Overlay")
		end
	end

	local buttons = {
		"InterfaceOptionsFrameDefaults",
		"InterfaceOptionsFrameOkay",
		"InterfaceOptionsFrameCancel",
		"InterfaceOptionsFrameTab1",
		"InterfaceOptionsFrameTab2",
		"InterfaceOptionsSocialPanelTwitterLoginButton",
		"InterfaceOptionsHelpPanelResetTutorials"
	}

	for i = 1, getn(buttons) do
		local button = _G[buttons[i]]
		if button then
			button:SkinButton()
		end
	end

	local checkboxes = {
		-- Controls
		"ControlsPanelStickyTargeting",
		"ControlsPanelAutoDismount",
		"ControlsPanelAutoClearAFK",
		"ControlsPanelBlockTrades",
		"ControlsPanelBlockGuildInvites",
		"ControlsPanelBlockChatChannelInvites",
		"ControlsPanelLootAtMouse",
		"ControlsPanelAutoLootCorpse",
		"ControlsPanelInteractOnLeftClick",
		"ControlsPanelAutoOpenLootHistory",
		"ControlsPanelReverseCleanUpBags",
		"ControlsPanelReverseNewLoot",
		-- Combat
		"CombatPanelAutoSelfCast",
		"CombatPanelAttackOnAssist",
		"CombatPanelStopAutoAttack",
		"CombatPanelTargetOfTarget",
		"CombatPanelShowSpellAlerts",
		"CombatPanelReducedLagTolerance",
		"CombatPanelActionButtonUseKeyDown",
		"CombatPanelEnemyCastBarsOnPortrait",
		"CombatPanelEnemyCastBarsOnNameplates",
		"CombatPanelLossOfControl",
		-- Display
		"DisplayPanelShowCloak",
		"DisplayPanelShowHelm",
		"DisplayPanelShowAggroPercentage",
		"DisplayPanelPlayAggroSounds",
		"DisplayPanelShowSpellPointsAvg",
		"DisplayPanelCinematicSubtitles",
		"DisplayPanelRotateMinimap",
		"DisplayPanelShowAccountAchievments",
		"DisplayPanelShowFreeBagSpace",
		"DisplayPanelAJAlerts",
		-- Objectives
		"ObjectivesPanelAutoQuestTracking",
		"ObjectivesPanelMapQuestDifficulty",
		"ObjectivesPanelWatchFrameWidth",
		"ObjectivesPanelMapFade",
		-- Social
		"SocialPanelProfanityFilter",
		"SocialPanelSpamFilter",
		"SocialPanelChatBubbles",
		"SocialPanelPartyChat",
		"SocialPanelChatHoverDelay",
		"SocialPanelGuildMemberAlert",
		"SocialPanelChatMouseScroll",
		"SocialPanelWholeChatWindowClickable",
		"SocialPanelEnableTwitter",
		-- ActionBars
		"ActionBarsPanelBottomLeft",
		"ActionBarsPanelBottomRight",
		"ActionBarsPanelRight",
		"ActionBarsPanelRightTwo",
		"ActionBarsPanelAlwaysShowActionBars",
		"ActionBarsPanelLockActionBars",
		"ActionBarsPanelSecureAbilityToggle",
		"ActionBarsPanelCountdownCooldowns",
		-- Names
		"NamesPanelMyName",
		"NamesPanelFriendlyPlayerNames",
		"NamesPanelFriendlyPets",
		"NamesPanelFriendlyGuardians",
		"NamesPanelFriendlyTotems",
		"NamesPanelUnitNameplatesFriends",
		"NamesPanelUnitNameplatesFriendlyGuardians",
		"NamesPanelUnitNameplatesFriendlyPets",
		"NamesPanelUnitNameplatesFriendlyTotems",
		"NamesPanelGuilds",
		"NamesPanelGuildTitles",
		"NamesPanelTitles",
		"NamesPanelNonCombatCreature",
		"NamesPanelEnemyPlayerNames",
		"NamesPanelEnemyPets",
		"NamesPanelEnemyGuardians",
		"NamesPanelEnemyTotems",
		"NamesPanelUnitNameplatesEnemyPets",
		"NamesPanelUnitNameplatesEnemies",
		"NamesPanelUnitNameplatesEnemyGuardians",
		"NamesPanelUnitNameplatesEnemyTotems",
		"NamesPanelUnitNameplatesNameplateClassColors",
		"NamesPanelMinus",
		"NamesPanelUnitNameplatesEnemyMinus",
		-- Floating Combat Text
		"CombatTextPanelTargetDamage",
		"CombatTextPanelPeriodicDamage",
		"CombatTextPanelPetDamage",
		"CombatTextPanelHealing",
		"CombatTextPanelHealingAbsorbTarget",
		"CombatTextPanelHealingAbsorbSelf",
		"CombatTextPanelTargetEffects",
		"CombatTextPanelOtherTargetEffects",
		"CombatTextPanelEnableFCT",
		"CombatTextPanelDodgeParryMiss",
		"CombatTextPanelDamageReduction",
		"CombatTextPanelRepChanges",
		"CombatTextPanelReactiveAbilities",
		"CombatTextPanelFriendlyHealerNames",
		"CombatTextPanelCombatState",
		"CombatTextPanelComboPoints",
		"CombatTextPanelLowManaHealth",
		"CombatTextPanelEnergyGains",
		"CombatTextPanelPeriodicEnergyGains",
		"CombatTextPanelHonorGains",
		"CombatTextPanelAuras",
		"CombatTextPanelPetBattle",
		-- Status Text
		"StatusTextPanelPlayer",
		"StatusTextPanelPet",
		"StatusTextPanelParty",
		"StatusTextPanelTarget",
		"StatusTextPanelAlternateResource",
		"StatusTextPanelPercentages",
		"StatusTextPanelXP",
		-- Unit Frames
		"UnitFramePanelPartyPets",
		"UnitFramePanelArenaEnemyFrames",
		"UnitFramePanelArenaEnemyCastBar",
		"UnitFramePanelArenaEnemyPets",
		"UnitFramePanelFullSizeFocusFrame",
		-- Buffs and Debuffs
		"BuffsPanelDispellableDebuffs",
		"BuffsPanelCastableBuffs",
		"BuffsPanelConsolidateBuffs",
		"BuffsPanelShowAllEnemyDebuffs",
		-- Battle.net
		"BattlenetPanelConversations",
		"BattlenetPanelOnlineFriends",
		"BattlenetPanelOfflineFriends",
		"BattlenetPanelBroadcasts",
		"BattlenetPanelFriendRequests",
		"BattlenetPanelShowToastWindow",
		-- Camera
		"CameraPanelFollowTerrain",
		"CameraPanelHeadBob",
		"CameraPanelWaterCollision",
		"CameraPanelSmartPivot",
		-- Mouse
		"MousePanelInvertMouse",
		"MousePanelClickToMove",
		"MousePanelWoWMouse",
		"MousePanelEnableMouseSpeed",
		--Assessability
		"AccessibilityPanelMovePad",
		"AccessibilityPanelColorblindMode",
		--Watev
		"NamesPanelUnitNameplatesNameplateClassColors",
		-- Help
		"HelpPanelShowTutorials",
		"HelpPanelEnhancedTooltips",
		"HelpPanelShowLuaErrors",
		"HelpPanelColorblindMode",
		"HelpPanelMovePad"
	}

	for i = 1, getn(checkboxes) do
		local checkbox = _G["InterfaceOptions"..checkboxes[i]]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	local checkboxes2 = {
		"AutoActivate2Players",
		"AutoActivate3Players",
		"AutoActivate5Players",
		"AutoActivate10Players",
		"AutoActivate15Players",
		"AutoActivate25Players",
		"AutoActivate40Players",
		"AutoActivateSpec1",
		"AutoActivateSpec2",
		"AutoActivatePvE",
		"AutoActivatePvP",
		"KeepGroupsTogether",
		"HorizontalGroups",
		"DisplayIncomingHeals",
		"DisplayPowerBar",
		"DisplayAggroHighlight",
		"UseClassColors",
		"DisplayPets",
		"DisplayMainTankAndAssist",
		"DisplayBorder",
		"ShowDebuffs",
		"DisplayOnlyDispellableDebuffs"
	}

	for i = 1, getn(checkboxes2) do
		local checkbox = _G["CompactUnitFrameProfilesGeneralOptionsFrame"..checkboxes2[i]]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	T.SkinCheckBox(CompactUnitFrameProfilesRaidStylePartyFrames)

	local dropdown = {
		"ControlsPanelAutoLootKeyDropDown",
		"CombatPanelFocusCastKeyDropDown",
		"CombatPanelSelfCastKeyDropDown",
		"CombatPanelLossOfControlFullDropDown",
		"CombatPanelLossOfControlSilenceDropDown",
		"CombatPanelLossOfControlInterruptDropDown",
		"CombatPanelLossOfControlDisarmDropDown",
		"CombatPanelLossOfControlRootDropDown",
		"SocialPanelChatStyle",
		"SocialPanelWhisperMode",
		"SocialPanelTimestamps",
		"SocialPanelBnWhisperMode",
		"SocialPanelConversationMode",
		"ActionBarsPanelPickupActionKeyDropDown",
		"NamesPanelNPCNamesDropDown",
		"NamesPanelUnitNameplatesMotionDropDown",
		"CombatTextPanelFCTDropDown",
		"CombatTextPanelTargetModeDropDown",
		"CameraPanelStyleDropDown",
		"MousePanelClickMoveStyleDropDown",
		"ObjectivesPanelQuestSorting",
		"AccessibilityPanelColorFilterDropDown",
		"DisplayPanelOutlineDropDown"
	}

	for i = 1, getn(dropdown) do
		local frame = _G["InterfaceOptions"..dropdown[i]]
		if frame then
			T.SkinDropDownBox(frame)
		end
	end

	T.SkinDropDownBox(CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdown)
	T.SkinDropDownBox(CompactUnitFrameProfilesGeneralOptionsFrameSortByDropdown)
	T.SkinDropDownBox(CompactUnitFrameProfilesProfileSelector)

	local buttons = {
		"CompactUnitFrameProfilesGeneralOptionsFrameResetPositionButton",
		"CompactUnitFrameProfilesDeleteButton",
		"CompactUnitFrameProfilesSaveButton"
	}

	for i = 1, getn(buttons) do
		local button = _G[buttons[i]]
		if button then
			button:SkinButton()
		end
	end

	local sliders = {
		"InterfaceOptionsCombatPanelSpellAlertOpacitySlider",
		"InterfaceOptionsCombatPanelMaxSpellStartRecoveryOffset",
		"CompactUnitFrameProfilesGeneralOptionsFrameHeightSlider",
		"CompactUnitFrameProfilesGeneralOptionsFrameWidthSlider",
		"InterfaceOptionsBattlenetPanelToastDurationSlider",
		"InterfaceOptionsCameraPanelMaxDistanceSlider",
		"InterfaceOptionsCameraPanelFollowSpeedSlider",
		"InterfaceOptionsMousePanelMouseSensitivitySlider",
		"InterfaceOptionsMousePanelMouseLookSpeedSlider",
		"InterfaceOptionsAccessibilityPanelColorblindStrengthSlider",
		"OpacityFrameSlider"
	}

	for i = 1, getn(sliders) do
		local slider = _G[sliders[i]]
		if slider then
			T.SkinSlider(slider)
			slider:SetFrameLevel(slider:GetFrameLevel() + 2)
		end
	end

	_G["InterfaceOptionsFrameDefaults"]:ClearAllPoints()
	_G["InterfaceOptionsFrameDefaults"]:SetPoint("TOPLEFT", _G["InterfaceOptionsFrameCategories"], "BOTTOMLEFT", 0, -14)
	_G["InterfaceOptionsFrameCancel"]:ClearAllPoints()
	_G["InterfaceOptionsFrameCancel"]:SetPoint("TOPRIGHT", _G["InterfaceOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
	_G["InterfaceOptionsFrameOkay"]:ClearAllPoints()
	_G["InterfaceOptionsFrameOkay"]:SetPoint("RIGHT", _G["InterfaceOptionsFrameCancel"], "LEFT", -4, 0)
	_G["ColorPickerOkayButton"]:ClearAllPoints()
	_G["InterfaceOptionsFrameTab1"]:ClearAllPoints()
	_G["InterfaceOptionsFrameTab1"]:SetPoint("TOPLEFT", _G["InterfaceOptionsFrameCategories"], "TOPLEFT", 0, 27)
	_G["InterfaceOptionsFrameTab1"]:SetWidth(60)
	_G["InterfaceOptionsFrameTab1"].SetWidth = T.dummy
	_G["InterfaceOptionsFrameTab2"]:ClearAllPoints()
	_G["InterfaceOptionsFrameTab2"]:SetPoint("TOPLEFT", _G["InterfaceOptionsFrameTab1"], "TOPRIGHT", 3, 0)
	_G["InterfaceOptionsFrameTab2"]:SetWidth(112)
	_G["InterfaceOptionsFrameTab2"].SetWidth = T.dummy
	_G["InterfaceOptionsFrameTab1TabSpacer"]:Kill()
	_G["InterfaceOptionsFrameTab2TabSpacer1"]:Kill()
	_G["InterfaceOptionsFrameTab2TabSpacer2"]:Kill()
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
