----------------------------------------------------------------------------------------
--	GUI for ShestakUI(by Fernir, Tukz and Tohveli)
----------------------------------------------------------------------------------------
local myPlayerRealm = GetCVar("realmName")
local myPlayerName  = UnitName("player")

local ALLOWED_GROUPS = {
	["general"] = 1,
	["misc"] = 1,
	["announcements"] = 1,
	["skins"] = 1,
	["combattext"] = 1,
	["reminder"] = 1,
	["raidcooldown"] = 1,
	["enemycooldown"] = 1,
	["pulsecooldown"] = 1,
	["threat"] = 1,
	["tooltip"] = 1,
	["chat"] = 1,
	["bag"] = 1,
	["minimap"] = 1,
	["map"] = 1,
	["loot"] = 1,
	["nameplate"] = 1,
	["actionbar"] = 1,
	["aura"] = 1,
	["unitframe"] = 1,
	["raidframe"] = 1,
	["toppanel"] = 1,
	["error"] = 1,
	["stats"] = 1,
}

-- List of "Table Names" that we do not want to show in the config
local TableFilter = {
	--["table_name"] = 1,
}

local function Local(o)
	local T, C, L = unpack(ShestakUI)
	-- General options
	if o == "UIConfiggeneral" then o = GENERAL_LABEL end
	if o == "UIConfiggeneralauto_scale" then o = L_GUI_GENERAL_AUTOSCALE end
	if o == "UIConfiggeneralmultisampleprotect" then o = L_GUI_GENERAL_MULTISAMPLE end
	if o == "UIConfiggeneraluiscale" then o = L_GUI_GENERAL_UISCALE end
	if o == "UIConfiggeneralwelcome_message" then o = L_GUI_GENERAL_WELCOME_MESSAGE end
	if o == "UIConfiggeneralcustom_lagtolerance" then o = L_GUI_GENERAL_LAG_TOLERANCE end

	-- Miscellaneous options
	if o == "UIConfigmisc" then o = OTHER end
	if o == "UIConfigmiscauto_quest" then o = L_GUI_MISC_AUTOQUEST end
	if o == "UIConfigmiscauto_decline_duel" then o = L_GUI_MISC_AUTODUEL end
	if o == "UIConfigmiscauto_accept_invite" then o = L_GUI_MISC_AUTOACCEPT end
	if o == "UIConfigmiscauto_resurrection" then o = L_GUI_MISC_AUTORESSURECT end
	if o == "UIConfigmiscshift_marking" then o = L_GUI_MISC_MARKING end
	if o == "UIConfigmiscinvite_keyword" then o = L_GUI_MISC_INVKEYWORD end
	if o == "UIConfigmiscafk_spin_camera" then o = L_GUI_MISC_SPIN_CAMERA end
	if o == "UIConfigmiscvehicle_mouseover" then o = L_GUI_MISC_VEHICLE_MOUSEOVER end
	if o == "UIConfigmiscquest_auto_button" then o = L_GUI_MISC_QUEST_AUTOBUTTON end
	if o == "UIConfigmiscraid_tools" then o = L_GUI_MISC_RAID_TOOLS end
	if o == "UIConfigmiscach_screens" then o = L_GUI_MISC_ACH_SCREENS end
	if o == "UIConfigmiscprofession_tabs" then o = L_GUI_MISC_PROFESSION_TABS end

	-- Announcements options
	if o == "UIConfigannouncements" then o = L_GUI_ANNOUNCEMENTS end
	if o == "UIConfigannouncementsdrinking" then o = L_GUI_ANNOUNCEMENTS_DRINKING end
	if o == "UIConfigannouncementsinterrupts" then o = L_GUI_ANNOUNCEMENTS_INTERRUPTS end
	if o == "UIConfigannouncementsspells" then o = L_GUI_ANNOUNCEMENTS_SPELLS end
	if o == "UIConfigannouncementsspells_from_all" then o = L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL end

	-- Skins options
	if o == "UIConfigskins" then o = L_GUI_SKINS end
	if o == "UIConfigskinsblizzard_frames" then o = L_GUI_SKINS_BLIZZARD end
	if o == "UIConfigskinsminimap_buttons" then o = L_GUI_SKINS_MINIMAP_BUTTONS end
	if o == "UIConfigskinsclcret" then o = L_GUI_SKINS_CLCR end
	if o == "UIConfigskinsbigwigs" then o = L_GUI_SKINS_BW end
	if o == "UIConfigskinsdbm" then o = L_GUI_SKINS_DBM end
	if o == "UIConfigskinsdxe" then o = L_GUI_SKINS_DXE end
	if o == "UIConfigskinskle" then o = L_GUI_SKINS_KLE end
	if o == "UIConfigskinsomen" then o = L_GUI_SKINS_OMEN end
	if o == "UIConfigskinspallypower" then o = L_GUI_SKINS_PP end
	if o == "UIConfigskinsrecount" then o = L_GUI_SKINS_RECOUNT end

	-- Combat text options
	if o == "UIConfigcombattext" then o = L_GUI_COMBATTEXT end
	if o == "UIConfigcombattextenable" then o = L_GUI_COMBATTEXT_ENABLE end
	if o == "UIConfigcombattextblizz_head_numbers" then o = L_GUI_COMBATTEXT_BLIZZ_HEAD_NUMBERS end
	if o == "UIConfigcombattextdamage_style" then o = L_GUI_COMBATTEXT_DAMAGE_STYLE end
	if o == "UIConfigcombattextdamage" then o = L_GUI_COMBATTEXT_DAMAGE end
	if o == "UIConfigcombattexthealing" then o = L_GUI_COMBATTEXT_HEALING end
	if o == "UIConfigcombattextshow_hots" then o = L_GUI_COMBATTEXT_HOTS end
	if o == "UIConfigcombattextshow_overhealing" then o = L_GUI_COMBATTEXT_OVERHEALING end
	if o == "UIConfigcombattextpet_damage" then o = L_GUI_COMBATTEXT_PET_DAMAGE end
	if o == "UIConfigcombattextdot_damage" then o = L_GUI_COMBATTEXT_DOT_DAMAGE end
	if o == "UIConfigcombattextdamage_color" then o = L_GUI_COMBATTEXT_DAMAGE_COLOR end
	if o == "UIConfigcombattextcrit_prefix" then o = L_GUI_COMBATTEXT_CRIT_PREFIX end
	if o == "UIConfigcombattextcrit_postfix" then o = L_GUI_COMBATTEXT_CRIT_POSTFIX end
	if o == "UIConfigcombattexticons" then o = L_GUI_COMBATTEXT_ICONS end
	if o == "UIConfigcombattexticon_size" then o = L_GUI_COMBATTEXT_ICON_SIZE end
	if o == "UIConfigcombattexttreshold" then o = L_GUI_COMBATTEXT_TRESHOLD end
	if o == "UIConfigcombattextheal_treshold" then o = L_GUI_COMBATTEXT_HEAL_TRESHOLD end
	if o == "UIConfigcombattextscrollable" then o = L_GUI_COMBATTEXT_SCROLLABLE end
	if o == "UIConfigcombattextmax_lines" then o = L_GUI_COMBATTEXT_MAX_LINES end
	if o == "UIConfigcombattexttime_visible" then o = L_GUI_COMBATTEXT_TIME_VISIBLE end
	if o == "UIConfigcombattextstop_ve_spam" then o = L_GUI_COMBATTEXT_STOP_VE_SPAM end
	if o == "UIConfigcombattextdk_runes" then o = L_GUI_COMBATTEXT_DK_RUNES end
	if o == "UIConfigcombattextkillingblow" then o = L_GUI_COMBATTEXT_KILLINGBLOW end
	if o == "UIConfigcombattextmerge_aoe_spam" then o = L_GUI_COMBATTEXT_MERGE_AOE_SPAM end
	if o == "UIConfigcombattextmerge_aoe_spam_time" then o = L_GUI_COMBATTEXT_MERGE_AOE_SPAM_TIME end
	if o == "UIConfigcombattextdispel" then o = L_GUI_COMBATTEXT_DISPEL end
	if o == "UIConfigcombattextinterrupt" then o = L_GUI_COMBATTEXT_INTERRUPT end

	-- Buffs reminder options
	if o == "UIConfigreminder" then o = L_GUI_REMINDER end
	if o == "UIConfigremindersolo_buffs_enable" then o = L_GUI_REMINDER_SOLO_ENABLE end
	if o == "UIConfigremindersolo_buffs_sound" then o = L_GUI_REMINDER_SOLO_SOUND end
	if o == "UIConfigremindersolo_buffs_size" then o = L_GUI_REMINDER_SOLO_SIZE end
	if o == "UIConfigreminderraid_buffs_enable" then o = L_GUI_REMINDER_RAID_ENABLE end
	if o == "UIConfigreminderraid_buffs_always" then o = L_GUI_REMINDER_RAID_ALWAYS end
	if o == "UIConfigreminderraid_buffs_size" then o = L_GUI_REMINDER_RAID_SIZE end
	if o == "UIConfigreminderraid_buffs_alpha" then o = L_GUI_REMINDER_RAID_ALPHA end

	-- Raid cooldowns options
	if o == "UIConfigraidcooldown" then o = L_GUI_COOLDOWN_RAID end
	if o == "UIConfigraidcooldownenable" then o = L_GUI_COOLDOWN_RAID_ENABLE end
	if o == "UIConfigraidcooldownheight" then o = L_GUI_COOLDOWN_RAID_HEIGHT end
	if o == "UIConfigraidcooldownwidth" then o = L_GUI_COOLDOWN_RAID_WIDTH end
	if o == "UIConfigraidcooldownupwards" then o = L_GUI_COOLDOWN_RAID_SORT end
	if o == "UIConfigraidcooldownshow_icon" then o = L_GUI_COOLDOWN_RAID_ICONS end
	if o == "UIConfigraidcooldownshow_inraid" then o = L_GUI_COOLDOWN_RAID_IN_RAID end
	if o == "UIConfigraidcooldownshow_inparty" then o = L_GUI_COOLDOWN_RAID_IN_PARTY end
	if o == "UIConfigraidcooldownshow_inarena" then o = L_GUI_COOLDOWN_RAID_IN_ARENA end

	-- Enemy cooldowns options
	if o == "UIConfigenemycooldown" then o = L_GUI_COOLDOWN_ENEMY end
	if o == "UIConfigenemycooldownenable" then o = L_GUI_COOLDOWN_ENEMY_ENABLE end
	if o == "UIConfigenemycooldownsize" then o = L_GUI_COOLDOWN_ENEMY_SIZE end
	if o == "UIConfigenemycooldowndirection" then o = L_GUI_COOLDOWN_ENEMY_DIRECTION end
	if o == "UIConfigenemycooldownshow_always" then o = L_GUI_COOLDOWN_ENEMY_EVERYWHERE end
	if o == "UIConfigenemycooldownshow_inpvp" then o = L_GUI_COOLDOWN_ENEMY_IN_BG end
	if o == "UIConfigenemycooldownshow_inarena" then o = L_GUI_COOLDOWN_ENEMY_IN_ARENA end

	-- Pulse cooldown options
	if o == "UIConfigpulsecooldown" then o = L_GUI_COOLDOWN_PULSE end
	if o == "UIConfigpulsecooldownenable" then o = L_GUI_COOLDOWN_PULSE_ENABLE end
	if o == "UIConfigpulsecooldownsize" then o = L_GUI_COOLDOWN_PULSE_SIZE end
	if o == "UIConfigpulsecooldownsound" then o = L_GUI_COOLDOWN_PULSE_SOUND end
	if o == "UIConfigpulsecooldownanim_scale" then o = L_GUI_COOLDOWN_PULSE_ANIM_SCALE end
	if o == "UIConfigpulsecooldownhold_time" then o = L_GUI_COOLDOWN_PULSE_HOLD_TIME end

	-- Threat options
	if o == "UIConfigthreat" then o = L_GUI_THREAT end
	if o == "UIConfigthreatenable" then o = L_GUI_THREAT_ENABLE end
	if o == "UIConfigthreatheight" then o = L_GUI_THREAT_HEIGHT end
	if o == "UIConfigthreatwidth" then o = L_GUI_THREAT_WIDTH end
	if o == "UIConfigthreatbar_rows" then o = L_GUI_THREAT_ROWS end
	if o == "UIConfigthreathide_solo" then o = L_GUI_THREAT_HIDE_SOLO end

	-- Tooltip options
	if o == "UIConfigtooltip" then o = L_GUI_TOOLTIP end
	if o == "UIConfigtooltipenable" then o = L_GUI_TOOLTIP_ENABLE end
	if o == "UIConfigtooltipshift_modifer" then o = L_GUI_TOOLTIP_SHIFT end
	if o == "UIConfigtooltipcursor" then o = L_GUI_TOOLTIP_CURSOR end
	if o == "UIConfigtooltipitem_icon" then o = L_GUI_TOOLTIP_ICON end
	if o == "UIConfigtooltiphealth_value" then o = L_GUI_TOOLTIP_HEALTH end
	if o == "UIConfigtooltiphidebuttons" then o = L_GUI_TOOLTIP_HIDE end
	if o == "UIConfigtooltiphide_combat" then o = L_GUI_TOOLTIP_HIDE_COMBAT end
	if o == "UIConfigtooltiptalents" then o = L_GUI_TOOLTIP_TALENTS end
	if o == "UIConfigtooltipachievements" then o = L_GUI_TOOLTIP_ACHIEVEMENTS end
	if o == "UIConfigtooltiptarget" then o = L_GUI_TOOLTIP_TARGET end
	if o == "UIConfigtooltiptitle" then o = L_GUI_TOOLTIP_TITLE end
	if o == "UIConfigtooltiprank" then o = L_GUI_TOOLTIP_RANK end
	if o == "UIConfigtooltiparena_experience" then o = L_GUI_TOOLTIP_ARENA_EXPERIENCE end
	if o == "UIConfigtooltipspell_id" then o = L_GUI_TOOLTIP_SPELL_ID end
	if o == "UIConfigtooltipaverage_lvl" then o = STAT_AVERAGE_ITEM_LEVEL end
	if o == "UIConfigtooltipraid_icon" then o = L_GUI_TOOLTIP_RAID_ICON end
	if o == "UIConfigtooltipwho_targetting" then o = L_GUI_TOOLTIP_WHO_TARGETTING end
	if o == "UIConfigtooltipitem_count" then o = L_GUI_TOOLTIP_ITEM_COUNT end

	-- Chat options
	if o == "UIConfigchat" then o = SOCIALS end
	if o == "UIConfigchatenable" then o = L_GUI_CHAT_ENABLE end
	if o == "UIConfigchatbackground" then o = L_GUI_CHAT_BACKGROUND end
	if o == "UIConfigchatbackground_alpha" then o = L_GUI_CHAT_BACKGROUND_ALPHA end
	if o == "UIConfigchatfilter" then o = L_GUI_CHAT_SPAM end
	if o == "UIConfigchatspam" then o = L_GUI_CHAT_GOLD end
	if o == "UIConfigchatwidth" then o = L_GUI_CHAT_WIDTH end
	if o == "UIConfigchatheight" then o = L_GUI_CHAT_HEIGHT end
	if o == "UIConfigchatchat_bar" then o = L_GUI_CHAT_BAR end
	if o == "UIConfigchattime_color" then o = L_GUI_CHAT_TIMESTAMP end
	if o == "UIConfigchatwhisp_sound" then o = L_GUI_CHAT_WHISP end
	if o == "UIConfigchatbubbles" then o = L_GUI_CHAT_SKIN_BUBBLE end
	if o == "UIConfigchatcombatlog" then o = L_GUI_CHAT_CL_TAB end
	if o == "UIConfigchatsticky" then o = L_GUI_CHAT_STICKY end

	-- Bag options
	if o == "UIConfigbag" then o = L_GUI_BAGS end
	if o == "UIConfigbagenable" then o = L_GUI_BAGS_ENABLE end
	if o == "UIConfigbagbutton_size" then o = L_GUI_BAGS_BUTTON_SIZE end
	if o == "UIConfigbagbutton_space" then o = L_GUI_BAGS_BUTTON_SPACE end
	if o == "UIConfigbagbank_columns" then o = L_GUI_BAGS_BANK end
	if o == "UIConfigbagbag_columns" then o = L_GUI_BAGS_BAG end

	-- Minimap options
	if o == "UIConfigminimap" then o = MINIMAP_LABEL end
	if o == "UIConfigminimapenable" then o = L_GUI_MINIMAP_ENABLE end
	if o == "UIConfigminimaptracking_icon" then o = L_GUI_MINIMAP_ICON end
	if o == "UIConfigminimapsize" then o = L_GUI_MINIMAP_SIZE end
	if o == "UIConfigminimaphide_combat" then o = L_GUI_MINIMAP_HIDE_COMBAT end
	if o == "UIConfigminimapmerge_menus" then o = L_GUI_MINIMAP_MERGE_MENUS end

	-- Map options
	if o == "UIConfigmap" then o = WORLD_MAP end
	if o == "UIConfigmapenable" then o = L_GUI_MAP_ENABLE end
	if o == "UIConfigmapscale" then o = L_GUI_MAP_SCALE end
	if o == "UIConfigmapbg_map_stylization" then o = L_GUI_MAP_BG_STYLIZATION end

	-- Loot options
	if o == "UIConfigloot" then o = LOOT end
	if o == "UIConfiglootlootframe" then o = L_GUI_LOOT_ENABLE end
	if o == "UIConfiglootrolllootframe" then o = L_GUI_LOOT_ROLL_ENABLE end
	if o == "UIConfiglooticon_size" then o = L_GUI_LOOT_ICON_SIZE end
	if o == "UIConfiglootwidth" then o = L_GUI_LOOT_WIDTH end
	if o == "UIConfiglootauto_greed" then o = L_GUI_LOOT_AUTOGREED end
	if o == "UIConfiglootauto_confirm_de" then o = L_GUI_LOOT_AUTODE end

	-- Nameplate options
	if o == "UIConfignameplate" then o = UNIT_NAMEPLATES end
	if o == "UIConfignameplateenable" then o = L_GUI_NAMEPLATE_ENABLE end
	if o == "UIConfignameplateheight" then o = L_GUI_NAMEPLATE_HEIGHT end
	if o == "UIConfignameplatewidth" then o = L_GUI_NAMEPLATE_WIDTH end
	if o == "UIConfignameplatead_height" then o = L_GUI_NAMEPLATE_AD_HEIGHT end
	if o == "UIConfignameplatead_width" then o = L_GUI_NAMEPLATE_AD_WIDTH end
	if o == "UIConfignameplatecombat" then o = L_GUI_NAMEPLATE_COMBAT end
	if o == "UIConfignameplatehealth_value" then o = L_GUI_NAMEPLATE_HEALTH end
	if o == "UIConfignameplateshow_castbar" then o = L_GUI_NAMEPLATE_CASTBAR end
	if o == "UIConfignameplateshow_castbar_name" then o = L_GUI_NAMEPLATE_CASTBAR_NAME end
	if o == "UIConfignameplateenhance_threat" then o = L_GUI_NAMEPLATE_THREAT end
	if o == "UIConfignameplateclass_icons" then o = L_GUI_NAMEPLATE_CLASS_ICON end
	if o == "UIConfignameplatename_abbrev" then o = L_GUI_NAMEPLATE_NAME_ABBREV end
	if o == "UIConfignameplategood_color" then o = L_GUI_NAMEPLATE_GOOD_COLOR end
	if o == "UIConfignameplatenear_color" then o = L_GUI_NAMEPLATE_NEAR_COLOR end
	if o == "UIConfignameplatebad_color" then o = L_GUI_NAMEPLATE_BAD_COLOR end
	if o == "UIConfignameplatetrack_auras" then o = L_GUI_NAMEPLATE_SHOW_DEBUFFS end

	-- ActionBar options
	if o == "UIConfigactionbar" then o = ACTIONBARS_LABEL end
	if o == "UIConfigactionbarenable" then o = L_GUI_ACTIONBAR_ENABLE end
	if o == "UIConfigactionbarhotkey" then o = L_GUI_ACTIONBAR_HOTKEY end
	if o == "UIConfigactionbarmacro" then o = L_GUI_ACTIONBAR_MACRO end
	if o == "UIConfigactionbarshow_grid" then o = L_GUI_ACTIONBAR_GRID end
	if o == "UIConfigactionbarbutton_size" then o = L_GUI_ACTIONBAR_BUTTON_SIZE end
	if o == "UIConfigactionbarbutton_space" then o = L_GUI_ACTIONBAR_BUTTON_SPACE end
	if o == "UIConfigactionbarsplit_bars" then o = L_GUI_ACTIONBAR_SPLIT_BARS end
	if o == "UIConfigactionbarclasscolor_border" then o = L_GUI_ACTIONBAR_CLASSCOLOR_BORDER end
	if o == "UIConfigactionbartoggle_mode" then o = L_GUI_ACTIONBAR_TOGGLE_MODE end
	if o == "UIConfigactionbarlight_macro" then o = L_GUI_ACTIONBAR_LIGHT_MACRO end
	if o == "UIConfigactionbarbottombars" then o = L_GUI_ACTIONBAR_BOTTOMBARS end
	if o == "UIConfigactionbarrightbars" then o = L_GUI_ACTIONBAR_RIGHTBARS end
	if o == "UIConfigactionbarrightbars_mouseover" then o = L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER end
	if o == "UIConfigactionbarpetbar_mouseover" then o = L_GUI_ACTIONBAR_PETBAR_MOUSEOVER end
	if o == "UIConfigactionbarpetbar_hide" then o = L_GUI_ACTIONBAR_PETBAR_HIDE end
	if o == "UIConfigactionbarpetbar_horizontal" then o = L_GUI_ACTIONBAR_PETBAR_HORIZONTAL end
	if o == "UIConfigactionbarshapeshift_mouseover" then o = L_GUI_ACTIONBAR_SHAPESHIFT_MOUSEOVER end
	if o == "UIConfigactionbarshapeshift_hide" then o = L_GUI_ACTIONBAR_SHAPESHIFT_HIDE end
	if o == "UIConfigactionbarshapeshift_horizontal" then o = L_GUI_ACTIONBAR_SHAPESHIFT_HORIZONTAL end

	-- Auras/Buffs/Debuffs
	if o == "UIConfigaura" then o = BUFFOPTIONS_LABEL end
	if o == "UIConfigauraplayer_buff_size" then o = L_GUI_AURA_PLAYER_BUFF_SIZE end
	if o == "UIConfigaurashow_spiral" then o = L_GUI_AURA_SHOW_SPIRAL end
	if o == "UIConfigaurashow_timer" then o = L_GUI_AURA_SHOW_TIMER end
	if o == "UIConfigauraplayer_auras" then o = L_GUI_AURA_PLAYER_AURAS end
	if o == "UIConfigauratarget_auras" then o = L_GUI_AURA_TARGET_AURAS end
	if o == "UIConfigaurafocus_debuffs" then o = L_GUI_AURA_FOCUS_DEBUFFS end
	if o == "UIConfigaurafot_debuffs" then o = L_GUI_AURA_FOT_DEBUFFS end
	if o == "UIConfigaurapet_debuffs" then o = L_GUI_AURA_PET_DEBUFFS end
	if o == "UIConfigauratot_debuffs" then o = L_GUI_AURA_TOT_DEBUFFS end
	if o == "UIConfigauraboss_buffs" then o = L_GUI_AURA_BOSS_BUFFS end
	if o == "UIConfigauraplayer_aura_only" then o = L_GUI_AURA_PLAYER_AURA_ONLY end
	if o == "UIConfigauradebuff_color_type" then o = L_GUI_AURA_DEBUFF_COLOR_TYPE end
	if o == "UIConfigauracast_by" then o = L_GUI_AURA_CAST_BY end
	if o == "UIConfigauraclasscolor_border" then o = L_GUI_AURA_CLASSCOLOR_BORDER end

	-- Unit Frames options
	if o == "UIConfigunitframe" then o = UNITFRAME_LABEL end
	if o == "UIConfigunitframeenable" then o = L_GUI_UF_ENABLE end
	if o == "UIConfigunitframeown_color" then o = L_GUI_UF_OWN_COLOR end
	if o == "UIConfigunitframeuf_color" then o = L_GUI_UF_UF_COLOR end
	if o == "UIConfigunitframeenemy_health_color" then o = L_GUI_UF_ENEMY_HEALTH_COLOR end
	if o == "UIConfigunitframeshow_total_value" then o = L_GUI_UF_TOTAL_VALUE end
	if o == "UIConfigunitframecolor_value" then o = L_GUI_UF_COLOR_VALUE end
	if o == "UIConfigunitframebar_color_value" then o = L_GUI_UF_BAR_COLOR_VALUE end
	if o == "UIConfigunitframeunit_castbar" then o = L_GUI_UF_UNIT_CASTBAR end
	if o == "UIConfigunitframecastbar_icon" then o = L_GUI_UF_CASTBAR_ICON end
	if o == "UIConfigunitframecastbar_latency" then o = L_GUI_UF_CASTBAR_LATENCY end
	if o == "UIConfigunitframeshow_pet" then o = L_GUI_UF_SHOW_PET end
	if o == "UIConfigunitframeshow_focus" then o = L_GUI_UF_SHOW_FOCUS end
	if o == "UIConfigunitframeshow_target_target" then o = L_GUI_UF_SHOW_TOT end
	if o == "UIConfigunitframeshow_boss" then o = L_GUI_UF_SHOW_BOSS end
	if o == "UIConfigunitframeboss_on_right" then o = L_GUI_UF_BOSS_RIGHT end
	if o == "UIConfigunitframeshow_arena" then o = L_GUI_UF_SHOW_ARENA end
	if o == "UIConfigunitframearena_on_right" then o = L_GUI_UF_ARENA_RIGHT end
	if o == "UIConfigunitframeicons_pvp" then o = L_GUI_UF_ICONS_PVP end
	if o == "UIConfigunitframeicons_combat" then o = L_GUI_UF_ICONS_COMBAT end
	if o == "UIConfigunitframeicons_resting" then o = L_GUI_UF_ICONS_RESTING end
	if o == "UIConfigunitframeicons_combo_point" then o = L_GUI_UF_ICONS_COMBO_POINT end
	if o == "UIConfigunitframeicons_combo_point_new" then o = L_GUI_UF_ICONS_COMBO_POINT_NEW end
	if o == "UIConfigunitframeportrait_enable" then o = L_GUI_UF_PORTRAIT_ENABLE end
	if o == "UIConfigunitframeportrait_classcolor_border" then o = L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER end
	if o == "UIConfigunitframeportrait_height" then o = L_GUI_UF_PORTRAIT_HEIGHT end
	if o == "UIConfigunitframeportrait_width" then o = L_GUI_UF_PORTRAIT_WIDTH end
	if o == "UIConfigunitframeplugins_gcd" then o = L_GUI_UF_PLUGINS_GCD end
	if o == "UIConfigunitframeplugins_swing" then o = L_GUI_UF_PLUGINS_SWING end
	if o == "UIConfigunitframeplugins_eclipse_bar" then o = L_GUI_UF_PLUGINS_ECLIPSE_BAR end
	if o == "UIConfigunitframeplugins_holy_bar" then o = L_GUI_UF_PLUGINS_HOLY_BAR end
	if o == "UIConfigunitframeplugins_shard_bar" then o = L_GUI_UF_PLUGINS_SHARD_BAR end
	if o == "UIConfigunitframeplugins_rune_bar" then o = L_GUI_UF_PLUGINS_RUNE_BAR end
	if o == "UIConfigunitframeplugins_vengeance_bar" then o = L_GUI_UF_PLUGINS_VENGEANCE_BAR end
	if o == "UIConfigunitframeplugins_totem_bar" then o = L_GUI_UF_PLUGINS_TOTEM_BAR end
	if o == "UIConfigunitframeplugins_totem_bar_name" then o = L_GUI_UF_PLUGINS_TOTEM_BAR_NAME end
	if o == "UIConfigunitframeplugins_reputation_bar" then o = L_GUI_UF_PLUGINS_REPUTATION_BAR end
	if o == "UIConfigunitframeplugins_experience_bar" then o = L_GUI_UF_PLUGINS_EXPERIENCE_BAR end
	if o == "UIConfigunitframeplugins_smooth_bar" then o = L_GUI_UF_PLUGINS_SMOOTH_BAR end
	if o == "UIConfigunitframeplugins_talents" then o = L_GUI_UF_PLUGINS_TALENTS end
	if o == "UIConfigunitframeplugins_combat_feedback" then o = L_GUI_UF_PLUGINS_COMBAT_FEEDBACK end
	if o == "UIConfigunitframeplugins_fader" then o = L_GUI_UF_PLUGINS_FADER end

	-- Raid Frames options
	if o == "UIConfigraidframe" then o = RAID_FRAMES_LABEL end
	if o == "UIConfigraidframeaggro_border" then o = L_GUI_UF_AGGRO_BORDER end
	if o == "UIConfigraidframedeficit_health" then o = L_GUI_UF_DEFICIT_HEALTH end
	if o == "UIConfigraidframeshow_party" then o = L_GUI_UF_SHOW_PARTY end
	if o == "UIConfigraidframeshow_raid" then o = L_GUI_UF_SHOW_RAID end
	if o == "UIConfigraidframevertical_health" then o = L_GUI_UF_VERTICAL_HEALTH end
	if o == "UIConfigraidframealpha_health" then o = L_GUI_UF_ALPHA_HEALTH end
	if o == "UIConfigraidframeshow_range" then o = L_GUI_UF_SHOW_RANGE end
	if o == "UIConfigraidframerange_alpha" then o = L_GUI_UF_RANGE_ALPHA end
	if o == "UIConfigraidframesolo_mode" then o = L_GUI_UF_SOLO_MODE end
	if o == "UIConfigraidframeplayer_in_party" then o = L_GUI_UF_PLAYER_PARTY end
	if o == "UIConfigraidframeraid_tanks" then o = L_GUI_UF_SHOW_TANK end
	if o == "UIConfigraidframeraid_tanks_tt" then o = L_GUI_UF_SHOW_TANK_TT end
	if o == "UIConfigraidframeraid_groups" then o = L_GUI_UF_RAID_GROUP end
	if o == "UIConfigraidframeraid_groups_vertical" then o = L_GUI_UF_RAID_VERTICAL_GROUP end
	if o == "UIConfigraidframeicons_leader" then o = L_GUI_UF_ICONS_LEADER end
	if o == "UIConfigraidframeicons_lfd_role" then o = L_GUI_UF_ICONS_LFD_ROLE end
	if o == "UIConfigraidframeicons_raid_mark" then o = L_GUI_UF_ICONS_RAID_MARK end
	if o == "UIConfigraidframeicons_ready_check" then o = L_GUI_UF_ICONS_READY_CHECK end
	if o == "UIConfigraidframeplugins_debuffhighlight_icon" then o = L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON end
	if o == "UIConfigraidframeplugins_aura_watch" then o = L_GUI_UF_PLUGINS_AURA_WATCH end
	if o == "UIConfigraidframeplugins_aura_watch_timer" then o = L_GUI_UF_PLUGINS_AURA_WATCH_TIMER end
	if o == "UIConfigraidframeplugins_healcomm" then o = L_GUI_UF_PLUGINS_HEALCOMM end

	-- Panel options
	if o == "UIConfigtoppanel" then o = L_GUI_TOP_PANEL end
	if o == "UIConfigtoppanelenable" then o = L_GUI_TOP_PANEL_ENABLE end
	if o == "UIConfigtoppanelmouseover" then o = L_GUI_TOP_PANEL_MOUSE end
	if o == "UIConfigtoppanelheight" then o = L_GUI_TOP_PANEL_HEIGHT end
	if o == "UIConfigtoppanelwidth" then o = L_GUI_TOP_PANEL_WIDTH end

	-- Stats options
	if o == "UIConfigstats" then o = L_GUI_STATS end
	if o == "UIConfigstatsbattleground" then o = L_GUI_STATS_BG end
	if o == "UIConfigstatsclock" then o = L_GUI_STATS_CLOCK end
	if o == "UIConfigstatslatency" then o = L_GUI_STATS_LATENCY end
	if o == "UIConfigstatsmemory" then o = L_GUI_STATS_MEMORY end
	if o == "UIConfigstatsfps" then o = L_GUI_STATS_FPS end
	if o == "UIConfigstatsfriend" then o = FRIENDS end
	if o == "UIConfigstatsguild" then o = GUILD end
	if o == "UIConfigstatsdurability" then o = DURABILITY end
	if o == "UIConfigstatsexperience" then o = L_GUI_STATS_EXPERIENCE end
	if o == "UIConfigstatscoords" then o = L_GUI_STATS_COORDS end
	if o == "UIConfigstatslocation" then o = L_GUI_STATS_LOCATION end
	if o == "UIConfigstatsguild_repair" then o = L_GUI_STATS_GUILD_REPAIR end

	-- Error options
	if o == "UIConfigerror" then o = L_GUI_ERROR end
	if o == "UIConfigerrorhide" then o = L_GUI_ERROR_HIDE end
	if o == "UIConfigerrorblack" then o = L_GUI_ERROR_BLACK end
	if o == "UIConfigerrorwhite" then o = L_GUI_ERROR_WHITE end
	if o == "UIConfigerrorcombat" then o = L_GUI_ERROR_HIDE_COMBAT end

	T.option = o
end

local NewButton = function(text, parent)
	local T, C, L = unpack(ShestakUI)

	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetText(text)
	result:SetWidth(label:GetWidth())
	result:SetHeight(label:GetHeight())
	result:SetFontString(label)
	result:SetNormalTexture("")
	result:SetHighlightTexture("")
	result:SetPushedTexture("")

	return result
end

local NormalButton = function(text, parent)
	local T, C, L = unpack(ShestakUI)

	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetJustifyH("LEFT")
	label:SetText(text)
	result:Width(100)
	result:Height(23)
	result:SetFontString(label)
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.Reskin(result)
	else
		result:SkinButton()
	end

	return result
end

StaticPopupDialogs["PERCHAR"] = {
	text = L_GUI_PER_CHAR,
	OnAccept = function() 
		if UIConfigAllCharacters:GetChecked() then 
			GUIConfigAll[myPlayerRealm][myPlayerName] = true
		else 
			GUIConfigAll[myPlayerRealm][myPlayerName] = false
		end
		ReloadUI() 
	end,
	OnCancel = function() 
		UIConfigCover:Hide()
		if UIConfigAllCharacters:GetChecked() then 
			UIConfigAllCharacters:SetChecked(false)
		else 
			UIConfigAllCharacters:SetChecked(true)
		end
	end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs["RESET_PERCHAR"] = {
	text = L_GUI_RESET_CHAR,
	OnAccept = function() 
		GUIConfig = GUIConfigSettings
		ReloadUI() 
	end,
	OnCancel = function() if UIConfig and UIConfig:IsShown() then UIConfigCover:Hide() end end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs["RESET_ALL"] = {
	text = L_GUI_RESET_ALL,
	OnAccept = function() 
		GUIConfigSettings = nil
		GUIConfig = nil
		ReloadUI() 
	end,
	OnCancel = function() UIConfigCover:Hide() end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

local function SetValue(group, option, value)
	local mergesettings
	if GUIConfig == GUIConfigSettings then
		mergesettings = true
	else
		mergesettings = false
	end

	if GUIConfigAll[myPlayerRealm][myPlayerName] == true then
		if not GUIConfig then GUIConfig = {} end
		if not GUIConfig[group] then GUIConfig[group] = {} end
		GUIConfig[group][option] = value
	else
		if mergesettings == true then
			if not GUIConfig then GUIConfig = {} end
			if not GUIConfig[group] then GUIConfig[group] = {} end
			GUIConfig[group][option] = value
		end

		if not GUIConfigSettings then GUIConfigSettings = {} end
		if not GUIConfigSettings[group] then GUIConfigSettings[group] = {} end
		GUIConfigSettings[group][option] = value
	end
end

local VISIBLE_GROUP = nil
local lastbutton = nil
local function ShowGroup(group, button)
	local T, C, L = unpack(ShestakUI)

	if lastbutton then
		lastbutton:SetText(lastbutton:GetText().sub(lastbutton:GetText(), 11, -3))
	end
	if VISIBLE_GROUP then
		_G["UIConfig"..VISIBLE_GROUP]:Hide()
	end
	if _G["UIConfig"..group] then
		local o = "UIConfig"..group
		Local(o)
		_G["UIConfigTitle"]:SetText(T.option)
		local height = _G["UIConfig"..group]:GetHeight()
		_G["UIConfig"..group]:Show()
		local scrollamntmax = 405
		local scrollamntmin = scrollamntmax - 10
		local max = height > scrollamntmax and height-scrollamntmin or 1

		if max == 1 then
			_G["UIConfigGroupSlider"]:SetValue(1)
			_G["UIConfigGroupSlider"]:Hide()
		else
			_G["UIConfigGroupSlider"]:SetMinMaxValues(0, max)
			_G["UIConfigGroupSlider"]:Show()
			_G["UIConfigGroupSlider"]:SetValue(1)
		end
		_G["UIConfigGroup"]:SetScrollChild(_G["UIConfig"..group])

		local x
		if UIConfigGroupSlider:IsShown() then 
			_G["UIConfigGroup"]:EnableMouseWheel(true)
			_G["UIConfigGroup"]:SetScript("OnMouseWheel", function(self, delta)
				if UIConfigGroupSlider:IsShown() then
					if delta == -1 then
						x = _G["UIConfigGroupSlider"]:GetValue()
						_G["UIConfigGroupSlider"]:SetValue(x + 10)
					elseif delta == 1 then
						x = _G["UIConfigGroupSlider"]:GetValue()
						_G["UIConfigGroupSlider"]:SetValue(x - 30)
					end
				end
			end)
		else
			_G["UIConfigGroup"]:EnableMouseWheel(false)
		end

		VISIBLE_GROUP = group
		lastbutton = button
	end
end

function CreateUIConfig()
	local T, C, L = unpack(ShestakUI)

	if UIConfigMain then
		ShowGroup("general")
		UIConfigMain:Show()
		return
	end

	-- Main Frame
	local UIConfigMain = CreateFrame("Frame", "UIConfigMain", UIParent)
	UIConfigMain:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 200)
	UIConfigMain:SetWidth(780)
	UIConfigMain:SetHeight(520)
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.CreateBD(UIConfigMain)
		F.CreateSD(UIConfigMain)
	else
		UIConfigMain:SetTemplate("Transparent")
	end
	UIConfigMain:SetFrameStrata("DIALOG")
	UIConfigMain:SetFrameLevel(20)
	tinsert(UISpecialFrames, "UIConfigMain")

	-- Version Title
	local TitleBoxVer = CreateFrame("Frame", "TitleBoxVer", UIConfigMain)
	TitleBoxVer:SetWidth(180)
	TitleBoxVer:SetHeight(24)
	TitleBoxVer:SetPoint("TOPLEFT", UIConfigMain, "TOPLEFT", 23, -15)

	local TitleBoxVerText = TitleBoxVer:CreateFontString("UIConfigTitleVer", "OVERLAY", "GameFontNormal")
	TitleBoxVerText:SetPoint("CENTER")
	TitleBoxVerText:SetText("ShestakUI "..T.version)

	-- Main Frame Title
	local TitleBox = CreateFrame("Frame", "TitleBox", UIConfigMain)
	TitleBox:SetWidth(540)
	TitleBox:SetHeight(24)
	TitleBox:SetPoint("TOPLEFT", TitleBoxVer, "TOPRIGHT", 15, 0)

	local TitleBoxText = TitleBox:CreateFontString("UIConfigTitle", "OVERLAY", "GameFontNormal")
	TitleBoxText:SetPoint("LEFT", TitleBox, "LEFT", 15, 0)

	-- Main Frame
	local UIConfig = CreateFrame("Frame", "UIConfig", UIConfigMain)
	UIConfig:SetPoint("TOPLEFT", TitleBox, "BOTTOMLEFT", 10, -15)
	UIConfig:SetWidth(520)
	UIConfig:SetHeight(400)
	UIConfig:SetFrameStrata("DIALOG")
	UIConfig:SetFrameLevel(20)

	local UIConfigBG = CreateFrame("Frame", "UIConfigBG", UIConfig)
	UIConfigBG:SetPoint("TOPLEFT", -10, 10)
	UIConfigBG:SetPoint("BOTTOMRIGHT", 10, -10)

	-- Group selection(left side)
	local groups = CreateFrame("ScrollFrame", "UIConfigCategoryGroup", UIConfig)
	groups:SetPoint("TOPLEFT", TitleBoxVer, "BOTTOMLEFT", 10, -15)
	groups:SetWidth(160)
	groups:SetHeight(400)

	local groupsBG = CreateFrame("Frame", "groupsBG", UIConfig)
	groupsBG:SetPoint("TOPLEFT", groups, -10, 10)
	groupsBG:SetPoint("BOTTOMRIGHT", groups, 10, -10)

	local UIConfigCover = CreateFrame("Frame", "UIConfigCover", UIConfig)
	UIConfigCover:SetPoint("TOPLEFT", UIConfigCategoryGroup, "TOPLEFT")
	UIConfigCover:SetPoint("BOTTOMRIGHT", UIConfig, "BOTTOMRIGHT")
	UIConfigCover:SetFrameLevel(UIConfig:GetFrameLevel() + 20)
	UIConfigCover:EnableMouse(true)
	UIConfigCover:SetScript("OnMouseDown", function(self) print(L_GUI_MAKE_SELECTION) end)
	UIConfigCover:Hide()

	local slider = CreateFrame("Slider", "UIConfigCategorySlider", groups)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self,value) groups:SetVerticalScroll(value) end)

	local child = CreateFrame("Frame", nil, groups)
	child:SetPoint("TOPLEFT")
	local offset = 5
	for group in pairs(ALLOWED_GROUPS) do
		local o = "UIConfig"..group
		Local(o)
		local button = NewButton(T.option, child)
		button:SetHeight(16)
		button:SetWidth(125)
		button:SetPoint("TOPLEFT", 5, -(offset))
		button:SetScript("OnClick", function(self) ShowGroup(group, button) self:SetText("|cff00ff00"..T.option.."|r") end)
		offset = offset + 20
	end
	child:SetWidth(125)
	child:SetHeight(offset)
	slider:SetMinMaxValues(0, (offset == 0 and 1 or offset - 12 * 32))
	slider:SetValue(1)
	groups:SetScrollChild(child)

	local x
	_G["UIConfigCategoryGroup"]:EnableMouseWheel(true)
	_G["UIConfigCategoryGroup"]:SetScript("OnMouseWheel", function(self, delta)
		if _G["UIConfigCategorySlider"]:IsShown() then
			if delta == -1 then
				x = _G["UIConfigCategorySlider"]:GetValue()
				_G["UIConfigCategorySlider"]:SetValue(x + 10)
			elseif delta == 1 then
				x = _G["UIConfigCategorySlider"]:GetValue()
				_G["UIConfigCategorySlider"]:SetValue(x - 20)
			end
		end
	end)

	-- Group scroll frame(right side)
	local group = CreateFrame("ScrollFrame", "UIConfigGroup", UIConfig)
	group:SetPoint("TOPLEFT", 0, 5)
	group:SetWidth(520)
	group:SetHeight(400)

	local slider = CreateFrame("Slider", "UIConfigGroupSlider", group)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self,value) group:SetVerticalScroll(value) end)

	for group in pairs(ALLOWED_GROUPS) do
		local frame = CreateFrame("Frame", "UIConfig"..group, UIConfigGroup)
		frame:SetPoint("TOPLEFT")
		frame:SetWidth(225)

		local offset = 5

		if type(C[group]) ~= "table" then error(group.." GroupName not found in config table.") return end
		for option, value in pairs(C[group]) do

			if type(value) == "boolean" then
				local button = CreateFrame("CheckButton", "UIConfig"..group..option, frame, "InterfaceOptionsCheckButtonTemplate")
				if IsAddOnLoaded("Aurora") then
					local F = unpack(Aurora)
					F.ReskinCheck(button)
				end
				local o = "UIConfig"..group..option
				Local(o)
				_G["UIConfig"..group..option.."Text"]:SetText(T.option)
				_G["UIConfig"..group..option.."Text"]:SetFontObject(GameFontHighlight)
				_G["UIConfig"..group..option.."Text"]:SetWidth(460)
				_G["UIConfig"..group..option.."Text"]:SetJustifyH("LEFT")
				button:SetChecked(value)
				button:SetScript("OnClick", function(self) SetValue(group, option, (self:GetChecked() and true or false)) end)
				button:SetPoint("TOPLEFT", 5, -(offset))
				offset = offset + 25
			elseif type(value) == "number" or type(value) == "string" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "UIConfig"..group..option
				Local(o)
				label:SetText(T.option)
				label:SetWidth(460)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -(offset))

				local editbox = CreateFrame("EditBox", nil, frame)
				editbox:SetAutoFocus(false)
				editbox:SetMultiLine(false)
				editbox:SetWidth(220)
				editbox:SetHeight(20)
				editbox:SetMaxLetters(255)
				editbox:SetTextInsets(3, 0, 0, 0)
				editbox:SetFontObject(GameFontHighlight)
				editbox:SetPoint("TOPLEFT", 8, -(offset + 20))
				editbox:SetText(value)
				editbox:SetTemplate("Transparent")

				local okbutton = CreateFrame("Button", nil, frame)
				okbutton:SetHeight(editbox:GetHeight())
				okbutton:SkinButton()
				okbutton:SetPoint("LEFT", editbox, "RIGHT", 2, 0)

				local oktext = okbutton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				oktext:SetText(OKAY)
				oktext:SetPoint("CENTER", okbutton, "CENTER", -1, 0)
				okbutton:SetWidth(oktext:GetWidth() + 5)
				okbutton:Hide()
 
				if type(value) == "number" then
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(group, option, tonumber(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(group, option, tonumber(editbox:GetText())) end)
				else
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(group, option, tostring(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(group, option, tostring(editbox:GetText())) end)
				end

				offset = offset + 45
			elseif type(value) == "table" and not TableFilter[option] then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "UIConfig"..group..option
				Local(o)
				label:SetText(T.option)
				label:SetWidth(440)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -(offset))

				colorbuttonname = (label:GetText().."ColorPicker")
				local colorbutton = CreateFrame("Button", colorbuttonname, frame)
				colorbutton:SetHeight(20)
				colorbutton:SetTemplate("Transparent")
				colorbutton:SetBackdropBorderColor(unpack(value))
				colorbutton:SetBackdropColor(value[1], value[2], value[3], 0.3)
				colorbutton:SetPoint("LEFT", label, "RIGHT", 2, 0)
				local colortext = colorbutton:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				colortext:SetText(COLOR)
				colortext:SetPoint("CENTER")
				colortext:SetJustifyH("CENTER")
				colorbutton:SetWidth(colortext:GetWidth() + 5)

				local oldvalue = value

				local function round(number, decimal)
					return (("%%.%df"):format(decimal)):format(number)
				end

				colorbutton:SetScript("OnMouseDown", function(self) 
					if ColorPickerFrame:IsShown() then return end
					local newR, newG, newB, newA
					local fired = 0

					local r, g, b, a = self:GetBackdropBorderColor();
					r, g, b, a = round(r, 2), round(g, 2), round(b, 2), round(a, 2)
					local originalR,originalG,originalB,originalA = r, g, b, a

					local function ShowColorPicker(r, g, b, a, changedCallback)
						ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, changedCallback;
						ColorPickerFrame:SetColorRGB(r, g, b)
						a = tonumber(a)
						ColorPickerFrame.hasOpacity = (a ~= nil and a ~= 1)
						ColorPickerFrame.opacity = a
						ColorPickerFrame.previousValues = {originalR,originalG,originalB,originalA}
						ColorPickerFrame:Hide()
						ColorPickerFrame:Show()
					end

					local function myColorCallback(restore)
						fired = fired + 1
						if restore ~= nil then
							-- The user bailed, we extract the old color from the table created by ShowColorPicker
							newR, newG, newB, newA = unpack(restore)
						else
							-- Something changed
							newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
						end

						value = { newR, newG, newB, newA }
						SetValue(group, option, (value)) 
						self:SetBackdropBorderColor(newR, newG, newB, newA)
						self:SetBackdropColor(newR, newG, newB, 0.3)
					end

					ShowColorPicker(originalR, originalG, originalB, originalA, myColorCallback)
				end)

				offset = offset + 25
			end
		end

		frame:SetHeight(offset)
		frame:Hide()
	end

	local reset = NormalButton(DEFAULT, UIConfigMain)
	reset:SetPoint("TOPLEFT", UIConfig, "BOTTOMLEFT", -10, -25)
	reset:SetScript("OnClick", function(self) 
		UIConfigCover:Show()
		if GUIConfigAll[myPlayerRealm][myPlayerName] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end)

	local close = NormalButton(CLOSE, UIConfigMain)
	close:SetPoint("TOPRIGHT", UIConfig, "BOTTOMRIGHT", 10, -25)
	close:SetScript("OnClick", function(self) PlaySound("igMainMenuOption") UIConfigMain:Hide() end)

	local load = NormalButton(APPLY, UIConfigMain)
	load:SetPoint("RIGHT", close, "LEFT", -4, 0)
	load:SetScript("OnClick", function(self) ReloadUI() end)

	local totalreset = NormalButton(L_GUI_BUTTON_RESET, UIConfigMain)
	totalreset:SetWidth(180)
	totalreset:SetPoint("TOPLEFT", groupsBG, "BOTTOMLEFT", 0, -15)
	totalreset:SetScript("OnClick", function(self)
		StaticPopup_Show("RESET_UI")
		GUIConfig = {}
		if GUIConfigAll[myPlayerRealm][myPlayerName] == true then
			GUIConfigAll[myPlayerRealm][myPlayerName] = {}
		end
		GUIConfigSettings = {}
	end)

	if GUIConfigAll then
		local button = CreateFrame("CheckButton", "UIConfigAllCharacters", TitleBox, "InterfaceOptionsCheckButtonTemplate")
		button:SetScript("OnClick", function(self) StaticPopup_Show("PERCHAR") UIConfigCover:Show() end)
		button:SetPoint("RIGHT", TitleBox, "RIGHT", -3, 0)
		if IsAddOnLoaded("Aurora") then
			local F = unpack(Aurora)
			F.ReskinCheck(button)
		else
			T.SkinCheckBox(button)
		end

		local label = UIConfigAllCharacters:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		label:SetText(L_GUI_SET_SAVED_SETTTINGS)
		label:SetPoint("RIGHT", button, "LEFT")

		if GUIConfigAll[myPlayerRealm][myPlayerName] == true then
			button:SetChecked(true)
		else
			button:SetChecked(false)
		end
	end

	local bgskins = {TitleBox, TitleBoxVer, UIConfigBG, groupsBG}
	for _, sb in pairs(bgskins) do
		if IsAddOnLoaded("Aurora") then
			local F = unpack(Aurora)
			F.CreateBD(sb)
			F.CreateSD(sb)
		else
			sb:SetTemplate("Overlay")
		end
	end

	ShowGroup("general")
end

do
	SLASH_CONFIG1 = "/config"
	SLASH_CONFIG2 = "/cfg"
	SLASH_CONFIG3 = "/configui"
	function SlashCmdList.CONFIG(msg, editbox)
		if not UIConfigMain or not UIConfigMain:IsShown() then
			PlaySound("igMainMenuOption")
			CreateUIConfig()
			HideUIPanel(GameMenuFrame)
		else
			PlaySound("igMainMenuOption")
			UIConfigMain:Hide()
		end
	end

	SLASH_RESETCONFIG1 = "/resetconfig"
	function SlashCmdList.RESETCONFIG()
		if UIConfigMain and UIConfigMain:IsShown() then UIConfigCover:Show() end

		if GUIConfigAll[myPlayerRealm][myPlayerName] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end
end

do
	local thxui = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
	thxui:Hide()

	thxui.name = "ShestakUI"
	thxui:SetScript("OnShow", function(self)
		local T, C, L = unpack(ShestakUI)
		local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText("Info:")

		local subtitle = self:CreateFontString(nil, "ARTWORK")
		subtitle:SetFont(C.media.normal_font, 12)
		subtitle:SetWidth(380)
		subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
		subtitle:SetJustifyH("LEFT")
		subtitle:SetText("UI Site: http//shestak.org\nGitHub: https://github.com/Shestak/ShestakUI\nCurse: http://wow.curseforge.com/addons/shestakui/\nWoWInterface: http://www.wowinterface.com/downloads/info19033-ShestakUI.html\nChange Log: https://github.com/Shestak/ShestakUI/commits/master/")

		local title2 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title2:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -16)
		title2:SetText("Credits:")

		local subtitle2 = self:CreateFontString(nil, "ARTWORK")
		subtitle2:SetFont(C.media.normal_font, 12)
		subtitle2:SetWidth(380)
		subtitle2:SetPoint("TOPLEFT", title2, "BOTTOMLEFT", 0, -8)
		subtitle2:SetJustifyH("LEFT")
		subtitle2:SetText("ALZA, Katae, pHishr, Roth, P3lim, Led++, Haste, Caellian, Tekkub, Neal, Industrial, Nightcracker, Kemayo, Yleaf, Monolit, Tukz, Totalpackage, Syzgyn, AlleyKat, Phanx, v6o, Meurtcriss, Favorit, Allez, Fernir, Affli, Eclipse, Elv22, Foof, Tohveli, FourOne, Havoc74, Duffed, Hydra, Gorlasch, Nefarion, Compost, Blamdarot, Suicidal Katt, Tuller, Rostok, Nebula, Thizzelle, Astromech, Ammo, Slakah, Xuerian, Thalyra, Soeters, Evilpaul.")

		local title3 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title3:SetPoint("TOPLEFT", subtitle2, "BOTTOMLEFT", 0, -16)
		title3:SetText("Thanks:")

		local subtitle3 = self:CreateFontString(nil, "ARTWORK")
		subtitle3:SetFont(C.media.normal_font, 12)
		subtitle3:SetWidth(380)
		subtitle3:SetPoint("TOPLEFT", title3, "BOTTOMLEFT", 0, -8)
		subtitle3:SetJustifyH("LEFT")
		subtitle3:SetText("Akimba, Sart, Antthemage, Homicidal Retribution, Sitatunga, Mania, Baine, Sw2rT1, Nanjiqq, Cranan, Leots, Ianchan, Spacedragon, Seal, eXecrate, Aelb, Halogen, Illusion, Obakol, Elfrey, k07n, Kazarl, Scorpions, Yakodzuna, MoLLIa, Erratic, gromcha, PterOs, tat2dawn, UI Users, Russian Community and Others.")

		local version = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		version:SetPoint("BOTTOMRIGHT", -16, 16)
		version:SetText("Version: "..T.version)
	end)

	InterfaceOptions_AddCategory(thxui)
end