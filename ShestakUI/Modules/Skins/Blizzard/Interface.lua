local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Interface skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local checkbox = {
		-- Controls
		"ControlsPanelStickyTargeting",
		"ControlsPanelAutoDismount",
		"ControlsPanelAutoClearAFK",
		"ControlsPanelBlockTrades",
		"ControlsPanelBlockGuildInvites",
		"ControlsPanelLootAtMouse",
		"ControlsPanelAutoLootCorpse",
		-- Combat
		"CombatPanelAutoSelfCast",
		"CombatPanelAttackOnAssist",
		"CombatPanelStopAutoAttack",
		"CombatPanelNameplateClassColors",
		"CombatPanelTargetOfTarget",
		"CombatPanelShowSpellAlerts",
		"CombatPanelReducedLagTolerance",
		"CombatPanelActionButtonUseKeyDown",
		"CombatPanelEnemyCastBarsOnPortrait",
		"CombatPanelEnemyCastBarsOnNameplates",
		-- Display
		"DisplayPanelShowCloak",
		"DisplayPanelShowHelm",
		"DisplayPanelShowAggroPercentage",
		"DisplayPanelPlayAggroSounds",
		"DisplayPanelDetailedLootInfo",
		"DisplayPanelShowSpellPointsAvg",
		"DisplayPanelemphasizeMySpellEffects",
		"DisplayPanelShowFreeBagSpace",
		"DisplayPanelCinematicSubtitles",
		"DisplayPanelRotateMinimap",
		"DisplayPanelScreenEdgeFlash",
		--Objectives
		"ObjectivesPanelAutoQuestTracking",
		"ObjectivesPanelAutoQuestProgress",
		"ObjectivesPanelMapQuestDifficulty",
		"ObjectivesPanelAdvancedWorldMap",
		"ObjectivesPanelWatchFrameWidth",
		-- Social
		"SocialPanelProfanityFilter",
		"SocialPanelSpamFilter",
		"SocialPanelChatBubbles",
		"SocialPanelPartyChat",
		"SocialPanelChatHoverDelay",
		"SocialPanelGuildMemberAlert",
		"SocialPanelChatMouseScroll",
		-- Action bars
		"ActionBarsPanelLockActionBars",
		"ActionBarsPanelSecureAbilityToggle",
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
		-- CombatText
		"CombatTextPanelTargetDamage",
		"CombatTextPanelPeriodicDamage",
		"CombatTextPanelPetDamage",
		"CombatTextPanelHealing",
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
		"CombatTextPanelAutoSelfCast",
		-- Buffs
		"BuffsPanelBuffDurations",
		"BuffsPanelDispellableDebuffs",
		"BuffsPanelCastableBuffs",
		"BuffsPanelShowCastableDebuffs",
		"BuffsPanelConsolidateBuffs",
		-- Battlenet
		"BattlenetPanelConversations",
		"BattlenetPanelOnlineFriends",
		"BattlenetPanelOfflineFriends",
		"BattlenetPanelBroadcasts",
		"BattlenetPanelFriendRequests",
		"BattlenetPanelOnlineFriendsConversations",
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
		-- Help
		"HelpPanelShowTutorials",
		"HelpPanelLoadingScreenTips",
		"HelpPanelEnhancedTooltips",
		"HelpPanelBeginnerTooltips",
		"HelpPanelShowLuaErrors",
		"HelpPanelColorblindMode",
		"HelpPanelMovePad",
	}

	for i = 1, getn(checkbox) do
		local button = _G["InterfaceOptions"..checkbox[i]]
		if button then
			T.SkinCheckBox(button)
		end
	end

	local dropdown ={
		"ControlsPanelAutoLootKeyDropDown",
		"CombatPanelTOTDropDown",
		"CombatPanelFocusCastKeyDropDown",
		"CombatPanelSelfCastKeyDropDown",
		"DisplayPanelAggroWarningDisplay",
		"DisplayPanelWorldPVPObjectiveDisplay",
		"SocialPanelChatStyle",
		"SocialPanelWhisperMode",
		"SocialPanelTimestamps",
		"SocialPanelBnWhisperMode",
		"ActionBarsPanelPickupActionKeyDropDown",
		"NamesPanelNPCNamesDropDown",
		"NamesPanelUnitNameplatesMotionDropDown",
		"CombatTextPanelFCTDropDown",
		"CameraPanelStyleDropDown",
		"MousePanelClickMoveStyleDropDown",
		"LanguagesPanelLocaleDropDown",
	}

	for i = 1, getn(dropdown) do
		local frame = _G["InterfaceOptions"..dropdown[i]]
		if frame then
			T.SkinDropDownBox(frame)
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)