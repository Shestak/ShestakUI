----------------------------------------------------------------------------------------
--	GUI for ShestakUI(by Fernir, Tukz and Tohveli)
----------------------------------------------------------------------------------------
local ALLOWED_GROUPS = {
	["general"] = 1,
	["misc"] = 1,
	["skins"] = 1,
	["combattext"] = 1,
	["reminder"] = 1,
	["cooldown"] = 1,
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
	["toppanel"] = 1,
	["error"] = 1,
	["stats"] = 1,
}

local function Local(o)
	-- General options
	if o == "UIConfiggeneral" then o = GENERAL_LABEL end
	if o == "UIConfiggeneralauto_scale" then o = L_GUI_GENERAL_AUTOSCALE end
	if o == "UIConfiggeneralmultisampleprotect" then o = L_GUI_GENERAL_MULTISAMPLE end
	if o == "UIConfiggeneraluiscale" then o = L_GUI_GENERAL_UISCALE end
	if o == "UIConfiggeneralminimap_icon" then o = L_GUI_GENERAL_UIICON end
	if o == "UIConfiggeneralwelcome_message" then o = L_GUI_GENERAL_WELCOME_MESSAGE end
	
	-- Miscellaneous options
	if o == "UIConfigmisc" then o = OTHER end
	if o == "UIConfigmiscauto_quest" then o = L_GUI_MISC_AUTOQUEST end
	if o == "UIConfigmiscauto_decline_duel" then o = L_GUI_MISC_AUTODUEL end
	if o == "UIConfigmiscauto_accept_invite" then o = L_GUI_MISC_AUTOACCEPT end
	if o == "UIConfigmiscauto_resurrection" then o = L_GUI_MISC_AUTORESSURECT end
	if o == "UIConfigmiscshift_marking" then o = L_GUI_MISC_MARKING end
	if o == "UIConfigmiscinvite_keyword" then o = L_GUI_MISC_INVKEYWORD end
	if o == "UIConfigmiscafk_spin_camera" then o = L_GUI_MISC_SPIN_CAMERA end
	if o == "UIConfigmiscmove_watchframe" then o = L_GUI_MISC_MOVE_WATCH_FRAME end
	if o == "UIConfigmiscvehicle_mouseover" then o = L_GUI_MISC_VEHICLE_MOUSEOVER end
	if o == "UIConfigmiscquest_auto_button" then o = L_GUI_MISC_QUEST_AUTOBUTTON end
	if o == "UIConfigmiscraid_tools" then o = L_GUI_MISC_RAID_TOOLS end
	
	-- Skins options
	if o == "UIConfigskins" then o = L_GUI_SKINS end
	if o == "UIConfigskinsdbm" then o = L_GUI_SKINS_DBM end
	if o == "UIConfigskinspallypower" then o = L_GUI_SKINS_PP end
	
	-- Combat text options
	if o == "UIConfigcombattext" then o = L_GUI_COMBATTEXT end
	if o == "UIConfigcombattextfont_size" then o = L_GUI_COMBATTEXT_FONT_SIZE end
	if o == "UIConfigcombattextblizz_head_numbers" then o = L_GUI_COMBATTEXT_BLIZZ_HEAD_NUMBERS end
	if o == "UIConfigcombattextdamage_style" then o = L_GUI_COMBATTEXT_DAMAGE_STYLE end
	if o == "UIConfigcombattextdamage" then o = L_GUI_COMBATTEXT_DAMAGE end
	if o == "UIConfigcombattexthealing" then o = L_GUI_COMBATTEXT_HEALING end
	if o == "UIConfigcombattextshow_hots" then o = L_GUI_COMBATTEXT_HOTS end
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
	
	-- Buffs reminder options
	if o == "UIConfigreminder" then o = L_GUI_REMINDER end
	if o == "UIConfigremindersolo_buffs_enable" then o = L_GUI_REMINDER_SOLO_ENABLE end
	if o == "UIConfigremindersolo_buffs_sound" then o = L_GUI_REMINDER_SOLO_SOUND end
	if o == "UIConfigremindersolo_buffs_size" then o = L_GUI_REMINDER_SOLO_SIZE end
	if o == "UIConfigreminderraid_buffs_enable" then o = L_GUI_REMINDER_RAID_ENABLE end
	if o == "UIConfigreminderraid_buffs_always" then o = L_GUI_REMINDER_RAID_ALWAYS end
	if o == "UIConfigreminderraid_buffs_size" then o = L_GUI_REMINDER_RAID_SIZE end
	if o == "UIConfigreminderraid_buffs_alpha" then o = L_GUI_REMINDER_RAID_ALPHA end
	
	-- Raid/Enemy cooldown options
	if o == "UIConfigcooldown" then o = L_GUI_COOLDOWN end
	if o == "UIConfigcooldownraid_enable" then o = L_GUI_COOLDOWN_RAID_ENABLE end
	if o == "UIConfigcooldownraid_font_size" then o = L_GUI_COOLDOWN_RAID_FONT end
	if o == "UIConfigcooldownraid_height" then o = L_GUI_COOLDOWN_RAID_HEIGHT end
	if o == "UIConfigcooldownraid_width" then o = L_GUI_COOLDOWN_RAID_WIDTH end
	if o == "UIConfigcooldownraid_upwards" then o = L_GUI_COOLDOWN_RAID_SORT end
	if o == "UIConfigcooldownraid_show_icon" then o = L_GUI_COOLDOWN_RAID_ICONS end
	if o == "UIConfigcooldownraid_show_inraid" then o = L_GUI_COOLDOWN_RAID_IN_RAID end
	if o == "UIConfigcooldownraid_show_inparty" then o = L_GUI_COOLDOWN_RAID_IN_PARTY end
	if o == "UIConfigcooldownraid_show_inarena" then o = L_GUI_COOLDOWN_RAID_IN_ARENA end
	if o == "UIConfigcooldownenemy_enable" then o = L_GUI_COOLDOWN_ENEMY end
	if o == "UIConfigcooldownenemy_size" then o = L_GUI_COOLDOWN_ENEMY_SIZE end
	if o == "UIConfigcooldownenemy_show_always" then o = L_GUI_COOLDOWN_ENEMY_EVERYWHERE end
	if o == "UIConfigcooldownenemy_show_inpvp" then o = L_GUI_COOLDOWN_ENEMY_IN_BG end
	if o == "UIConfigcooldownenemy_show_inarena" then o = L_GUI_COOLDOWN_ENEMY_IN_ARENA end
	
	-- Threat options
	if o == "UIConfigthreat" then o = L_GUI_THREAT end
	if o == "UIConfigthreatenable" then o = L_GUI_THREAT_ENABLE end
	if o == "UIConfigthreatfont_size" then o = L_GUI_THREAT_FONT_SIZE end
	if o == "UIConfigthreatheight" then o = L_GUI_THREAT_HEIGHT end
	if o == "UIConfigthreatwidth" then o = L_GUI_THREAT_WIDTH end
	if o == "UIConfigthreatbar_rows" then o = L_GUI_THREAT_ROWS end
	if o == "UIConfigthreattest_mode" then o = L_GUI_THREAT_TEST_MODE end	
	
	-- Tooltip options
	if o == "UIConfigtooltip" then o = L_GUI_TOOLTIP end
	if o == "UIConfigtooltipenable" then o = L_GUI_TOOLTIP_ENABLE end
	if o == "UIConfigtooltipshift_modifer" then o = L_GUI_TOOLTIP_SHIFT end
	if o == "UIConfigtooltipcursor" then o = L_GUI_TOOLTIP_CURSOR end
	if o == "UIConfigtooltipitem_icon" then o = L_GUI_TOOLTIP_ICON end
	if o == "UIConfigtooltiphealth_value" then o = L_GUI_TOOLTIP_HEALTH end
	if o == "UIConfigtooltiphidebuttons" then o = L_GUI_TOOLTIP_HIDE end
	if o == "UIConfigtooltiptalents" then o = L_GUI_TOOLTIP_TALENTS end
	if o == "UIConfigtooltipachievements" then o = L_GUI_TOOLTIP_ACHIEVEMENTS end
	if o == "UIConfigtooltiptarget" then o = L_GUI_TOOLTIP_TARGET end
	if o == "UIConfigtooltiptitle" then o = L_GUI_TOOLTIP_TITLE end
	if o == "UIConfigtooltiprank" then o = L_GUI_TOOLTIP_RANK end
	if o == "UIConfigtooltiparena_experience" then o = L_GUI_TOOLTIP_ARENA_EXPERIENCE end
	if o == "UIConfigtooltipspell_id" then o = L_GUI_TOOLTIP_SPELL_ID end
	
	-- Chat options
	if o == "UIConfigchat" then o = SOCIALS end
	if o == "UIConfigchatenable" then o = L_GUI_CHAT_ENABLE end
	if o == "UIConfigchatbackground" then o = L_GUI_CHAT_BACKGROUND end
	if o == "UIConfigchatbackground_alpha" then o = L_GUI_CHAT_BACKGROUND_ALPHA end
	if o == "UIConfigchatfont_size" then o = L_GUI_CHAT_FONT_SIZE end
	if o == "UIConfigchatfont_style" then o = L_GUI_CHAT_FONT_STYLE end
	if o == "UIConfigchattab_font_size" then o = L_GUI_CHAT_TAB_FONT_SIZE end	
	if o == "UIConfigchattab_font_style" then o = L_GUI_CHAT_TAB_FONT_STYLE end
	if o == "UIConfigchatfilter" then o = L_GUI_CHAT_SPAM end
	if o == "UIConfigchatwidth" then o = L_GUI_CHAT_WIDTH end
	if o == "UIConfigchatheight" then o = L_GUI_CHAT_HEIGHT end
	if o == "UIConfigchatchat_bar" then o = L_GUI_CHAT_BAR end
	if o == "UIConfigchattime_color" then o = L_GUI_CHAT_TIMESTAMP end
	if o == "UIConfigchatwhisp_sound" then o = L_GUI_CHAT_WHISP end
	if o == "UIConfigchatbubbles" then o = L_GUI_CHAT_SKIN_BUBBLE end
	
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
	
	-- Map options
	if o == "UIConfigmap" then o = WORLD_MAP end
	if o == "UIConfigmapenable" then o = L_GUI_MAP_ENABLE end
	if o == "UIConfigmapscale" then o = L_GUI_MAP_SCALE end
	if o == "UIConfigmapbg_map_stylization" then o = L_GUI_MAP_BG_STYLIZATION end
	
	-- Loot options
	if o == "UIConfigloot" then o = LOOT end
	if o == "UIConfiglootlootframe" then o = L_GUI_LOOT_ENABLE end
	if o == "UIConfiglootrolllootframe" then o = L_GUI_LOOT_ROLL_ENABLE end
	if o == "UIConfiglootfont_size" then o = L_GUI_LOOT_FONT_SIZE end
	if o == "UIConfiglooticon_size" then o = L_GUI_LOOT_ICON_SIZE end
	if o == "UIConfiglootwidth" then o = L_GUI_LOOT_WIDTH end
	if o == "UIConfiglootauto_greed" then o = L_GUI_LOOT_AUTOGREED end
	if o == "UIConfiglootauto_confirm_de" then o = L_GUI_LOOT_AUTODE end
	
	-- Nameplate options
	if o == "UIConfignameplate" then o = UNIT_NAMEPLATES end
	if o == "UIConfignameplateenable" then o = L_GUI_NAMEPLATE_ENABLE end
	if o == "UIConfignameplatefont_size" then o = L_GUI_NAMEPLATE_FONT_SIZE end
	if o == "UIConfignameplateheight" then o = L_GUI_NAMEPLATE_HEIGHT end
	if o == "UIConfignameplatewidth" then o = L_GUI_NAMEPLATE_WIDTH end
	if o == "UIConfignameplatecombat" then o = L_GUI_NAMEPLATE_COMBAT end
	if o == "UIConfignameplatehealth_value" then o = L_GUI_NAMEPLATE_HEALTH end
	if o == "UIConfignameplateshow_castbar" then o = L_GUI_NAMEPLATE_CASTBAR end
	if o == "UIConfignameplateshow_castbar_name" then o = L_GUI_NAMEPLATE_CASTBAR_NAME end
	if o == "UIConfignameplateenhance_threat" then o = L_GUI_NAMEPLATE_THREAT end
	if o == "UIConfignameplateclass_icons" then o = L_GUI_NAMEPLATE_CLASS_ICON end
	if o == "UIConfignameplatename_abbrev" then o = L_GUI_NAMEPLATE_NAME_ABBREV end
	if o == "UIConfignameplateoverlap" then o = L_GUI_NAMEPLATE_OVERLAP end
	
	-- ActionBar options
	if o == "UIConfigactionbar" then o = ACTIONBARS_LABEL end
	if o == "UIConfigactionbarenable" then o = L_GUI_ACTIONBAR_ENABLE end
	if o == "UIConfigactionbarhotkey" then o = L_GUI_ACTIONBAR_HOTKEY end
	if o == "UIConfigactionbarshow_grid" then o = L_GUI_ACTIONBAR_GRID end
	if o == "UIConfigactionbarbutton_size" then o = L_GUI_ACTIONBAR_BUTTON_SIZE end
	if o == "UIConfigactionbarbutton_space" then o = L_GUI_ACTIONBAR_BUTTON_SPACE end
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
	if o == "UIConfigaurafont_size" then o = L_GUI_AURA_FONT_SIZE end
	if o == "UIConfigauraplayer_buff_size" then o = L_GUI_AURA_PLAYER_BUFF_SIZE end
	if o == "UIConfigaurashow_spiral" then o = L_GUI_AURA_SHOW_SPIRAL end
	if o == "UIConfigaurashow_timer" then o = L_GUI_AURA_SHOW_TIMER end
	if o == "UIConfigauraplayer_auras" then o = L_GUI_AURA_PLAYER_AURAS end
	if o == "UIConfigauratarget_auras" then o = L_GUI_AURA_TARGET_AURAS end
	if o == "UIConfigaurafocus_debuffs" then o = L_GUI_AURA_FOCUS_DEBUFFS end
	if o == "UIConfigaurafot_debuffs" then o = L_GUI_AURA_FOT_DEBUFFS end
	if o == "UIConfigaurapet_debuffs" then o = L_GUI_AURA_PET_DEBUFFS end
	if o == "UIConfigauratot_debuffs" then o = L_GUI_AURA_TOT_DEBUFFS end
	if o == "UIConfigauraplayer_aura_only" then o = L_GUI_AURA_PLAYER_AURA_ONLY end
	if o == "UIConfigauradebuff_color_type" then o = L_GUI_AURA_DEBUFF_COLOR_TYPE end
	
	-- Unit frame options
	if o == "UIConfigunitframe" then o = UNITFRAME_LABEL end
	if o == "UIConfigunitframeenable" then o = L_GUI_UF_ENABLE end
	if o == "UIConfigunitframefont_size" then o = L_GUI_UF_FONT_SIZE end
	if o == "UIConfigunitframeaggro_border" then o = L_GUI_UF_AGGRO_BORDER end
	if o == "UIConfigunitframeown_color" then o = L_GUI_UF_OWN_COLOR end
	if o == "UIConfigunitframeenemy_health_color" then o = L_GUI_UF_ENEMY_HEALTH_COLOR end
	if o == "UIConfigunitframeshow_total_value" then o = L_GUI_UF_TOTAL_VALUE end
	if o == "UIConfigunitframedeficit_health" then o = L_GUI_UF_DEFICIT_HEALTH end
	if o == "UIConfigunitframecolor_value" then o = L_GUI_UF_COLOR_VALUE end
	if o == "UIConfigunitframeunit_castbar" then o = L_GUI_UF_UNIT_CASTBAR end
	if o == "UIConfigunitframecastbar_icon" then o = L_GUI_UF_CASTBAR_ICON end
	if o == "UIConfigunitframecastbar_latency" then o = L_GUI_UF_CASTBAR_LATENCY end
	if o == "UIConfigunitframeshow_boss" then o = L_GUI_UF_SHOW_BOSS end
	if o == "UIConfigunitframeshow_arena" then o = L_GUI_UF_SHOW_ARENA end
	if o == "UIConfigunitframearena_on_right" then o = L_GUI_UF_ARENA_RIGHT end
	if o == "UIConfigunitframeshow_raid" then o = L_GUI_UF_SHOW_RAID end
	if o == "UIConfigunitframevertical_health" then o = L_GUI_UF_VERTICAL_HEALTH end
	if o == "UIConfigunitframealpha_health" then o = L_GUI_UF_ALPHA_HEALTH end
	if o == "UIConfigunitframeshow_range" then o = L_GUI_UF_SHOW_RANGE end
	if o == "UIConfigunitframerange_alpha" then o = L_GUI_UF_RANGE_ALPHA end
	if o == "UIConfigunitframesolo_mode" then o = L_GUI_UF_SOLO_MODE end
	if o == "UIConfigunitframeplayer_in_party" then o = L_GUI_UF_PLAYER_PARTY end
	if o == "UIConfigunitframeraid_tanks" then o = L_GUI_UF_SHOW_TANK end
	if o == "UIConfigunitframeraid_groups" then o = L_GUI_UF_RAID_GROUP end
	if o == "UIConfigunitframeraid_groups_vertical" then o = L_GUI_UF_RAID_VERTICAL_GROUP end
	if o == "UIConfigunitframeicons_pvp" then o = L_GUI_UF_ICONS_PVP end
	if o == "UIConfigunitframeicons_leader" then o = L_GUI_UF_ICONS_LEADER end
	if o == "UIConfigunitframeicons_combat" then o = L_GUI_UF_ICONS_COMBAT end
	if o == "UIConfigunitframeicons_resting" then o = L_GUI_UF_ICONS_RESTING end
	if o == "UIConfigunitframeicons_lfd_role" then o = L_GUI_UF_ICONS_LFD_ROLE end
	if o == "UIConfigunitframeicons_raid_mark" then o = L_GUI_UF_ICONS_RAID_MARK end
	if o == "UIConfigunitframeicons_combo_point" then o = L_GUI_UF_ICONS_COMBO_POINT end
	if o == "UIConfigunitframeicons_ready_check" then o = L_GUI_UF_ICONS_READY_CHECK end
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
	if o == "UIConfigunitframeplugins_totem_bar" then o = L_GUI_UF_PLUGINS_TOTEM_BAR end
	if o == "UIConfigunitframeplugins_totem_bar_name" then o = L_GUI_UF_PLUGINS_TOTEM_BAR_NAME end
	if o == "UIConfigunitframeplugins_reputation_bar" then o = L_GUI_UF_PLUGINS_REPUTATION_BAR end
	if o == "UIConfigunitframeplugins_experience_bar" then o = L_GUI_UF_PLUGINS_EXPERIENCE_BAR end
	if o == "UIConfigunitframeplugins_smooth_bar" then o = L_GUI_UF_PLUGINS_SMOOTH_BAR end
	if o == "UIConfigunitframeplugins_talents" then o = L_GUI_UF_PLUGINS_TALENTS end
	if o == "UIConfigunitframeplugins_combat_feedback" then o = L_GUI_UF_PLUGINS_COMBAT_FEEDBACK end
	if o == "UIConfigunitframeplugins_debuffhighlight_icon" then o = L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON end
	if o == "UIConfigunitframeplugins_aura_watch" then o = L_GUI_UF_PLUGINS_AURA_WATCH end
	if o == "UIConfigunitframeplugins_healcomm" then o = L_GUI_UF_PLUGINS_HEALCOMM end
	
	-- Panel options
	if o == "UIConfigtoppanel" then o = L_GUI_TOP_PANEL end
	if o == "UIConfigtoppanelenable" then o = L_GUI_TOP_PANEL_ENABLE end
	if o == "UIConfigtoppanelmouseover" then o = L_GUI_TOP_PANEL_MOUSE end
	if o == "UIConfigtoppanelheight" then o = L_GUI_TOP_PANEL_HEIGHT end
	if o == "UIConfigtoppanelwidth" then o = L_GUI_TOP_PANEL_WIDTH end
	
	-- Stats options
	if o == "UIConfigstats" then o = L_GUI_STATS end
	if o == "UIConfigstatsfont_size" then o = L_GUI_STATS_FONT_SIZE end
	if o == "UIConfigstatsbattleground" then o = L_GUI_STATS_BG end
	if o == "UIConfigstatsclock" then o = L_GUI_STATS_CLOCK end
	if o == "UIConfigstatslatency" then o = L_GUI_STATS_LATENCY end
	if o == "UIConfigstatsmemory" then o = L_GUI_STATS_MEMORY end
	if o == "UIConfigstatsfps" then o = L_GUI_STATS_FPS end
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

	SettingsDB.option = o
end

local NewButton = function(text,parent)
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

local function SetValue(group, option, value)
	if not GUIConfig then
		GUIConfig = {}
	end
	if not GUIConfig[group] then
		GUIConfig[group] = {}
	end
	GUIConfig[group][option] = value
end

local VISIBLE_GROUP = nil
local lastbutton = nil
local function ShowGroup(group, button)
	if (lastbutton) then
		lastbutton:SetText(lastbutton:GetText().sub(lastbutton:GetText(), 11, -3))
	end
	if (VISIBLE_GROUP) then
		_G["UIConfig"..VISIBLE_GROUP]:Hide()
	end
	if _G["UIConfig"..group] then
		local o = "UIConfig"..group
		Local(o)
		_G["UIConfigTitle"]:SetText(SettingsDB.option)
		local height = _G["UIConfig"..group]:GetHeight()
		_G["UIConfig"..group]:Show()
		local scrollamntmax = 305
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
	if UIConfig then
		ShowGroup("general")
		UIConfig:Show()
		return
	end
	
	-- Main Frame
	local UIConfig = CreateFrame("Frame", "UIConfig", UIParent)
	UIConfig:SetPoint("BOTTOM", UIParent, "BOTTOM", 90, 350)
	UIConfig:SetWidth(400)
	UIConfig:SetHeight(300)
	UIConfig:SetFrameStrata("DIALOG")
	UIConfig:SetFrameLevel(20)
	tinsert(UISpecialFrames, "UIConfig")
	
	-- Title
	local TitleBox = CreateFrame("Frame", "UIConfig", UIConfig)
	TitleBox:SetWidth(420)
	TitleBox:SetHeight(24)
	TitleBox:SetPoint("TOPLEFT", -10, 42)
	SettingsDB.SkinFadedPanel(TitleBox)
	
	local TitleBoxText = TitleBox:CreateFontString("UIConfigTitle", "OVERLAY", "GameFontNormal")
	TitleBoxText:SetPoint("CENTER")
	
	local UIConfigBG = CreateFrame("Frame", "UIConfig", UIConfig)
	UIConfigBG:SetPoint("TOPLEFT", -10, 10)
	UIConfigBG:SetPoint("BOTTOMRIGHT", 10, -10)
	SettingsDB.SkinFadedPanel(UIConfigBG)
	
	-- Group selection(left side)
	local groups = CreateFrame("ScrollFrame", "UIConfigCategoryGroup", UIConfig)
	groups:SetPoint("TOPLEFT", -180, 0)
	groups:SetWidth(150)
	groups:SetHeight(300)

	local groupsBG = CreateFrame("Frame", "UIConfig", UIConfig)
	groupsBG:SetPoint("TOPLEFT", groups, -10, 10)
	groupsBG:SetPoint("BOTTOMRIGHT", groups, 10, -10)
	SettingsDB.SkinFadedPanel(groupsBG)
	
	-- Title 2
	local TitleBoxVer = CreateFrame("Frame", "TitleBoxVer", UIConfig)
	TitleBoxVer:SetWidth(170)
	TitleBoxVer:SetHeight(24)
	TitleBoxVer:SetPoint("BOTTOMLEFT", groupsBG, "TOPLEFT", 0, 8)
	SettingsDB.SkinFadedPanel(TitleBoxVer)
	
	local TitleBoxVerText = TitleBoxVer:CreateFontString("UIConfigTitleVer", "OVERLAY", "GameFontNormal")
	TitleBoxVerText:SetPoint("CENTER")
	TitleBoxVerText:SetText("ShestakUI "..SettingsDB.version)
	
	local slider = CreateFrame("Slider", "UIConfigCategorySlider", groups)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(300)
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
		local button = NewButton(SettingsDB.option, child)
		button:SetHeight(16)
		button:SetWidth(125)
		button:SetPoint("TOPLEFT", 5, -(offset))
		button:SetScript("OnClick", function(self) ShowGroup(group, button) self:SetText("|cff00ff00"..SettingsDB.option.."|r") end)
		offset = offset + 20
	end
	child:SetWidth(125)
	child:SetHeight(offset)
	slider:SetMinMaxValues(0, (offset == 0 and 1 or offset-12*25))
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
	group:SetWidth(400)
	group:SetHeight(300)
	
	local slider = CreateFrame("Slider", "UIConfigGroupSlider", group)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(300)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self,value) group:SetVerticalScroll(value) end)
	
	for group in pairs(ALLOWED_GROUPS) do
		local frame = CreateFrame("Frame", "UIConfig"..group, UIConfigGroup)
		frame:SetPoint("TOPLEFT")
		frame:SetWidth(225)
	
		local offset=5
		for option,value in pairs(SettingsCF[group]) do
			
			if type(value) == "boolean" then
				local button = CreateFrame("CheckButton", "UIConfig"..group..option, frame, "InterfaceOptionsCheckButtonTemplate")
				local o = "UIConfig"..group..option
				Local(o)
				_G["UIConfig"..group..option.."Text"]:SetText(SettingsDB.option)
				_G["UIConfig"..group..option.."Text"]:SetFontObject(GameFontHighlight)
				button:SetChecked(value)
				button:SetScript("OnClick", function(self) SetValue(group,option,(self:GetChecked() and true or false)) end)
				button:SetPoint("TOPLEFT", 5, -(offset))
				offset = offset + 25
			elseif type(value) == "number" or type(value) == "string" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "UIConfig"..group..option
				Local(o)
				label:SetText(SettingsDB.option)
				label:SetWidth(390)
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
				editbox:SetPoint("TOPLEFT", 5, -(offset + 20))
				editbox:SetText(value)
				SettingsDB.CreateTemplate(editbox)
				editbox:SetBackdropColor(0, 0, 0, 0.5)
				
				local okbutton = CreateFrame("Button", nil, frame)
				okbutton:SetHeight(editbox:GetHeight())
				okbutton:SetWidth(editbox:GetHeight() + 5)
				SettingsDB.CreateTemplate(okbutton)
				okbutton:SetBackdropColor(0, 0, 0, 0.5)
				okbutton:SetPoint("LEFT", editbox, "RIGHT", 2, 0)
				
				local oktext = okbutton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				oktext:SetText(OKAY)
				oktext:SetPoint("CENTER")
				okbutton:Hide()
 
				if type(value) == "number" then
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(group,option,tonumber(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(group,option,tonumber(editbox:GetText())) end)
				else
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(group,option,tostring(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(group,option,tostring(editbox:GetText())) end)
				end
				
				offset = offset + 45
			--[[elseif type(value) == "table" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "UIConfig"..group..option
				Local(o)
				label:SetText(SettingsDB.option)
				label:SetWidth(280)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -(offset))
				
				colorbuttonname = (label:GetText().."ColorPicker")
				
				local colorbutton = CreateFrame("Button", colorbuttonname, frame)
				colorbutton:SetHeight(20)
				colorbutton:SetWidth(60)
				SettingsDB.CreateTemplate(colorbutton)
				colorbutton:SetBackdropBorderColor(unpack(value))
				colorbutton:SetPoint("LEFT", label, "RIGHT", 2, 1 * UIParent:GetEffectiveScale())
				
				local colortext = colorbutton:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				colortext:SetText(COLOR)
				colortext:SetPoint("CENTER")
				colortext:SetJustifyH("CENTER")
				
				local oldvalue = value
				
				local function round(number, decimal)
					return (("%%.%df"):format(decimal)):format(number)
				end	
				
				colorbutton:SetScript("OnMouseDown", function(self) 
					local button = _G[self:GetName()]
					local r, g, b, a = button:GetBackdropBorderColor();
					r, g, b, a = round(r, 2), round(g, 2), round(b, 2), round(a, 2)
					local originalR, originalG, originalB, originalA = r, g, b, a

					local function ShowColorPicker(r, g, b, a, changedCallback)
						ColorPickerFrame:SetColorRGB(r,g,b)
						ColorPickerFrame.hasOpacity = false
						ColorPickerFrame.previousValues = {originalR, originalG, originalB, originalA}
						ColorPickerFrame.func, ColorPickerFrame.cancelFunc = changedCallback, changedCallback
						ColorPickerFrame:Hide()
						ColorPickerFrame:Show()
					end

					local function myColorCallback(restore)
						local newR, newG, newB, newA
						if restore then
							-- The user bailed, we extract the old color from the table created by ShowColorPicker
							newR, newG, newB, newA = unpack(restore)
							button:SetBackdropBorderColor(newR, newG, newB, newA)
							value = oldvalue
							if self == button then
								SetValue(group, option, (oldvalue)) 
							end
						else
							-- Something changed
							newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
							value = { newR, newG, newB, newA }
							if self == button then
								SetValue(group, option, (value)) 
							end
						button:SetBackdropBorderColor(unpack(value))
					end

					r, g, b, a = newR, newG, newB, newA
					end
					
					ShowColorPicker(originalR, originalG, originalB, originalA, myColorCallback)
				end)
				
				offset = offset + 25]]
			end
		end
		
		frame:SetHeight(offset)
		frame:Hide()
	end

	local reset = NewButton(DEFAULT, UIConfig)
	reset:SetWidth(100)
	reset:SetHeight(20)
	reset:SetPoint("BOTTOMLEFT", -10, -38)
	reset:SetScript("OnClick", function(self) GUIConfig = {} ReloadUI() end)
	SettingsDB.SkinFadedPanel(reset)
	
	local close = NewButton(CLOSE, UIConfig)
	close:SetWidth(100)
	close:SetHeight(20)
	close:SetPoint("BOTTOMRIGHT", 10, -38)
	close:SetScript("OnClick", function(self) PlaySound("igMainMenuOption") UIConfig:Hide() end)
	SettingsDB.SkinFadedPanel(close)
	
	local load = NewButton(APPLY, UIConfig)
	load:SetHeight(20)
	load:SetPoint("LEFT", reset, "RIGHT", 15, 0)
	load:SetPoint("RIGHT", close, "LEFT", -15, 0)
	load:SetScript("OnClick", function(self) ReloadUI() end)
	SettingsDB.SkinFadedPanel(load)
	
	local totalreset = NewButton(L_GUI_BUTTON_RESET, groupsBG)
	totalreset:SetHeight(20)
	totalreset:SetWidth(170)
	totalreset:SetPoint("TOPLEFT", groupsBG, "BOTTOMLEFT", 0, -8)
	totalreset:SetScript("OnClick", function(self) StaticPopup_Show("RESET_UI") UIConfig:Hide() end)
	SettingsDB.SkinFadedPanel(totalreset)
	
	ShowGroup("general")
end

do
	SLASH_CONFIG1 = "/config"
	SLASH_CONFIG2 = "/cfg"
	function SlashCmdList.CONFIG(msg, editbox)
		if not UIConfig or not UIConfig:IsShown() then
			PlaySound("igMainMenuOption")
			CreateUIConfig()
			HideUIPanel(GameMenuFrame)
		else
			PlaySound("igMainMenuOption")
			UIConfig:Hide()
		end
	end
end

do
	local thxui = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
	thxui:Hide()

	thxui.name = "ShestakUI"
	thxui:SetScript("OnShow", function(self)
		local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText("Special Thanks and Credits to:")

		local subtitle = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		subtitle:SetHeight(150)
		subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
		subtitle:SetPoint("RIGHT", self, -32, 0)
		subtitle:SetNonSpaceWrap(true)
		subtitle:SetWordWrap(true)
		subtitle:SetJustifyH("LEFT")
		subtitle:SetText("ALZA, Katae, pHishr, Roth, P3lim, Led++, Haste, Caellian, Tekkub, Neal, Industrial, Nightcracker, Kemayo, Yleaf, Awbee, Monolit, Sart, Akimba, Antthemage, Tukz, Totalpackage, Syzgyn, AlleyKat, Phanx, Senryo, v6o, Stuck, Meurtcriss, Homicidal Retribution, Favorit, Leots, Allez, Baine, Ianchan, Aelb, Spacedragon, Sw2rT1, Nanjiqq, Cranan, Seal, Halogen, Mania, Fernir, Affli, Eclipse, Elv22, Sitatunga, Foof, Tohveli, FourOne, Addon Authors, UI Users, Russian Community and Other.")
	end)

	InterfaceOptions_AddCategory(thxui)
end