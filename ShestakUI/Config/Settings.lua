local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Media options
----------------------------------------------------------------------------------------
C["media"] = {
	["normal_font"] = [[Interface\AddOns\ShestakUI\Media\Fonts\Normal.ttf]],		-- Normal font
	["blank_font"] = [[Interface\AddOns\ShestakUI\Media\Fonts\Blank.ttf]],			-- Blank font
	["pixel_font"] = [[Interface\AddOns\ShestakUI\Media\Fonts\Pixel.ttf]],			-- Pixel font
	["pixel_font_style"] = "OUTLINEMONOCHROME",										-- Pixel font style("OUTLINEMONOCHROME" or "OUTLINE")
	["pixel_font_size"] = 8,														-- Pixel font size for those places where it is not specified
	["blank"] = [[Interface\AddOns\ShestakUI\Media\Textures\White.tga]],			-- Texture for borders
	["texture"] = [[Interface\AddOns\ShestakUI\Media\Textures\Texture.tga]],		-- Texture for status bars
	["highlight"] = [[Interface\AddOns\ShestakUI\Media\Textures\Highlight.tga]],	-- Texture for debuffs highlight
	["whisp_sound"] = [[Interface\AddOns\ShestakUI\Media\Sounds\Whisper.mp3]],		-- Sound for wispers
	["warning_sound"] = [[Interface\AddOns\ShestakUI\Media\Sounds\Warning.mp3]],	-- Sound for warning
	["proc_sound"] = [[Interface\AddOns\ShestakUI\Media\Sounds\Proc.mp3]],			-- Sound for procs
	["border_color"] = {0.37, 0.3, 0.3, 1},		-- Color for borders
	["backdrop_color"] = {0, 0, 0, 1},			-- Color for borders backdrop
	["overlay_color"] = {0, 0, 0, 0.7},			-- Color for action bars overlay
}

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
C["general"] = {
	["auto_scale"] = true,						-- Autoscale
	["uiscale"] = 0.96,							-- Your value(between 0.64 and 1) if "auto_scale" is disable
	["multisampleprotect"] = true,				-- Disable this if you want multisample > 1
	["welcome_message"] = true,					-- Enable welcome message in chat
	["custom_lagtolerance"] = false,			-- Custom lag tollerance to your latency
}

----------------------------------------------------------------------------------------
--	Miscellaneous options
----------------------------------------------------------------------------------------
C["misc"] = {
	["auto_quest"] = false,						-- Auto accept quests(if hold shift or alt, auto accept is disable)
	["auto_decline_duel"] = true,				-- Auto decline duel
	["auto_accept_invite"] = false,				-- Auto accept invite
	["auto_resurrection"] = true,				-- Auto resurrection in Battle Ground
	["auto_buy_reagents"] = false,				-- Auto buy reagents(if hold shift or alt, auto buy is disable)
	["shift_marking"] = true,					-- Marks target when you push "shift"
	["invite_keyword"] = "invite",				-- Short keyword for invite(for enable - in game type /ainv)
	["afk_spin_camera"] = false,				-- Spin camera while afk
	["vehicle_mouseover"] = false,				-- Vehicle frame on mouseover
	["quest_auto_button"] = false,				-- Quest auto button
	["raid_tools"] = true,						-- Raid tools
	["ach_screens"] = false,					-- Take screenshot when player get achievement
	["profession_tabs"] = true,					-- Professions tabs on tradeskill frame
	["hide_bg_spam"] = false,					-- Remove Boss Emote spam during BG("Arathi Basin" and "The Battle for Gilneas")
}

----------------------------------------------------------------------------------------
--	Announcements options
----------------------------------------------------------------------------------------
C["announcements"] = {
	["drinking"] = false,						-- Announce in chat when arena enemy is drinking
	["interrupts"] = false,						-- Announce in party/raid when you interrupt
	["spells"] = false,							-- Announce in party/raid when you cast some spell
	["spells_from_all"] = false,				-- Check spells cast from all members
}

----------------------------------------------------------------------------------------
--	Skins options
----------------------------------------------------------------------------------------
C["skins"] = {
	["blizzard_frames"] = false,				-- Blizzard frames skin
	["minimap_buttons"] = false,				-- Skin addons icons on minimap
	["clcprot"] = false,						-- CLCProt skin
	["clcret"] = false,							-- CLCRet skin
	["combustion_helper"] = false,				-- CombustionHelper skin
	["bigwigs"] = false,						-- BigWigs skin
	["dbm"] = false,							-- DBM skin
	["dxe"] = false,							-- DXE skin
	["omen"] = false,							-- Omen skin
	["pallypower"] = false,						-- PallyPower skin
	["recount"] = false,						-- Recount skin
}

----------------------------------------------------------------------------------------
--	Combat text options
----------------------------------------------------------------------------------------
C["combattext"] = {
	["enable"] = true,							-- Global enable combat text
	["blizz_head_numbers"] = false,				-- Use blizzard damage/healing output(above mob/player head)
	["damage_style"] = true,					-- Change default damage/healing font above mobs/player heads(you need to restart WoW to see changes)
	["damage"] = true,							-- Show outgoing damage in it's own frame
	["healing"] = true,							-- Show outgoing healing in it's own frame
	["show_hots"] = true,						-- Show periodic healing effects in healing frame
	["show_overhealing"] = true,				-- Show outgoing overhealing
	["pet_damage"] = true,						-- Show your pet damage
	["dot_damage"] = true,						-- Show damage from your dots
	["damage_color"] = true,					-- Display damage numbers depending on school of magic
	["crit_prefix"] = "*",						-- Symbol that will be added before crit
	["crit_postfix"] = "*",						-- Symbol that will be added after crit
	["icons"] = true,							-- Show outgoing damage icons
	["icon_size"] = 16,							-- Icon size of spells in outgoing damage frame, also has effect on dmg font size
	["treshold"] = 1,							-- Minimum damage to show in damage frame
	["heal_treshold"] = 1,						-- Minimum healing to show in incoming/outgoing healing messages
	["scrollable"] = false,						-- Allows you to scroll frame lines with mousewheel
	["max_lines"] = 15,							-- Max lines to keep in scrollable mode(more lines = more memory)
	["time_visible"] = 3,						-- Time(seconds) a single message will be visible
	["stop_ve_spam"] = false,					-- Automaticly turns off healing spam for priests in shadowform
	["dk_runes"] = true,						-- Show deathknight rune recharge
	["killingblow"] = false,					-- Tells you about your killingblows
	["merge_aoe_spam"] = true,					-- Merges multiple aoe damage spam into single message
	["merge_aoe_spam_time"] = 3,				-- Time in seconds aoe spell will be merged into single message(works only with ["damage"] = true)
	["dispel"] = true,							-- Tells you about your dispels(works only with ["damage"] = true)
	["interrupt"] = true,						-- Tells you about your interrupts(works only with ["damage"] = true)
	["direction"] = "bottom",					-- Scrolling Direction("top"(goes down) or "bottom"(goes up))
}

----------------------------------------------------------------------------------------
--	Buffs reminder options
----------------------------------------------------------------------------------------
C["reminder"] = {
	-- Self buffs
	["solo_buffs_enable"] = true,				-- Enable buff reminder
	["solo_buffs_sound"] = false,				-- Enable warning sound notification for buff reminder
	["solo_buffs_size"] = 45,					-- Icon size
	-- Raid buffs
	["raid_buffs_enable"] = true,				-- Show missing raid buffs
	["raid_buffs_always"] = false,				-- Show frame always
	["raid_buffs_size"] = 19,					-- Icon size
	["raid_buffs_alpha"] = 0,					-- Transparent icons when the buff is present
}

----------------------------------------------------------------------------------------
--	Raid cooldowns options
----------------------------------------------------------------------------------------
C["raidcooldown"] = {
	["enable"] = true,							-- Enable raid cooldowns
	["height"] = 15,							-- Bars height
	["width"] = 186,							-- Bars width(if show_icon = false, bar width+28)
	["upwards"] = false,						-- Sort upwards bars
	["show_icon"] = true,						-- Show icons
	["show_inraid"] = true,						-- Show in raid zone
	["show_inparty"] = true,					-- Show in party zone
	["show_inarena"] = true,					-- Show in arena zone
}

----------------------------------------------------------------------------------------
--	Enemy cooldowns options
----------------------------------------------------------------------------------------
C["enemycooldown"] = {
	["enable"] = true,							-- Enable enemy cooldowns
	["size"] = 30,								-- Icon size
	["direction"] = "RIGHT",					-- Icon direction
	["show_always"] = false,					-- Show everywhere
	["show_inpvp"] = false,						-- Show in bg zone
	["show_inarena"] = true,					-- Show in arena zone
}

----------------------------------------------------------------------------------------
--	Pulse cooldowns options
----------------------------------------------------------------------------------------
C["pulsecooldown"] = {
	["enable"] = false,							-- Show cooldowns pulse
	["size"] = 75,								-- Icon size
	["sound"] = false,							-- Warning sound notification
	["anim_scale"] = 1.5,						-- Animation scaling
	["hold_time"] = 0,							-- Max opacity hold time
	["threshold"] = 3,							-- Minimal threshold time
}

----------------------------------------------------------------------------------------
--	Threat options
----------------------------------------------------------------------------------------
C["threat"] = {
	["enable"] = true,							-- Enable threat meter
	["height"] = 12,							-- Bars height
	["width"] = 217,							-- Bars width
	["bar_rows"] = 7,							-- Number of bars
	["hide_solo"] = false,						-- Show only in party/raid
}

----------------------------------------------------------------------------------------
--	Tooltip options
----------------------------------------------------------------------------------------
C["tooltip"] = {
	["enable"] = true,							-- Enable tooltip
	["shift_modifer"] = false,					-- Show tooltip when "shift" is pushed
	["cursor"] = false,							-- ToolTip under cursor
	["item_icon"] = false,						-- Item icon in tooltip
	["health_value"] = false,					-- Numeral health value
	["hidebuttons"] = false,					-- Hide tooltip for actions bars
	["hide_combat"] = false,					-- Hide tooltip in combat
	-- Plugins
	["talents"] = false,						-- Show tooltip talents
	["achievements"] = true,					-- Comparing achievements in tooltip
	["target"] = true,							-- Target player in tooltip
	["title"] = false,							-- Player title in tooltip
	["rank"] = true,							-- Player guild-rank in tooltip
	["arena_experience"] = false,				-- Player PVP experience in arena
	["spell_id"] = false,						-- Id number spells
	["average_lvl"] = false,					-- Average items level
	["raid_icon"] = false,						-- Raid icon
	["who_targetting"] = false,					-- Show who is targetting the unit(in raid or party)
	["item_count"] = false,						-- Item count in tooltip
	["unit_role"] = false,						-- Unit role in tooltip
}

----------------------------------------------------------------------------------------
--	Chat options
----------------------------------------------------------------------------------------
C["chat"] = {
	["enable"] = true,							-- Enable chat
	["background"] = false,						-- Enable background for chat
	["background_alpha"] = 0.7,					-- Background alpha
	["filter"] = true,							-- Removing some systems spam("Player1" won duel "Player2")
	["spam"] = false,							-- Removing some players spam(gold/portals/etc)
	["width"] = 350,							-- Chat width
	["height"] = 112,							-- Chat height
	["chat_bar"] = false,						-- Lite Button Bar for switch chat channel
	["time_color"] = {1, 1, 0},					-- Timestamp coloring(http://www.december.com/html/spec/colorcodes.html)
	["whisp_sound"] = true,						-- Sound when whisper
	["bubbles"] = true,							-- Skin Blizzard chat bubbles
	["combatlog"] = true,						-- Show CombatLog tab(need two reloads when false)
	["tabs_mouseover"] = false,					-- Chat tabs on mouseover
	["sticky"] = true,							-- Remember last channel
}

----------------------------------------------------------------------------------------
--	Bag options
----------------------------------------------------------------------------------------
C["bag"] = {
	["enable"] = true,							-- Enable bags
	["button_size"] = 27,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["bank_columns"] = 17,						-- Horizontal number of columns in bank
	["bag_columns"] = 10,						-- Horizontal number of columns in main bag
}

----------------------------------------------------------------------------------------
--	Minimap options
----------------------------------------------------------------------------------------
C["minimap"] = {
	["enable"] = true,							-- Enable minimap
	["tracking_icon"] = false,					-- Tracking icon
	["size"] = 130,								-- Minimap size
	["hide_combat"] = false,					-- Hide minimap in combat
	["toggle_menu"] = true,						-- Show toggle menu
	["merge_menus"] = true,						-- Merge main and addon buttons in toggle menu
}

----------------------------------------------------------------------------------------
--	Map options
----------------------------------------------------------------------------------------
C["map"] = {
	["enable"] = true,							-- Enable world map
	["scale"] = 0.8,							-- World map scale
	["bg_map_stylization"] = true,				-- BG map stylization
}

----------------------------------------------------------------------------------------
--	Loot options
----------------------------------------------------------------------------------------
C["loot"] = {
	["lootframe"] = true,						-- Enable loot frame
	["rolllootframe"] = true,					-- Enable group roll frame
	["icon_size"] = 22,							-- Icon size
	["width"] = 221,							-- Loot window width
	["auto_greed"] = true,						-- Push "greed" button when an item roll
	["auto_confirm_de"] = true,					-- Auto confirm disenchant
}

----------------------------------------------------------------------------------------
--	Nameplate options
----------------------------------------------------------------------------------------
C["nameplate"] = {
	["enable"] = true, 							-- Enable nameplate
	["height"] = 9,								-- Nameplate height
	["width"] = 120,							-- Nameplate width
	["ad_height"] = 0,							-- Additional height for selected nameplate
	["ad_width"] = 0,							-- Additional width for selected nameplate
	["combat"] = false,							-- Automatically show nameplate in combat
	["health_value"] = false,					-- Numeral health value
	["show_castbar_name"] = false,				-- Show castbar name
	["enhance_threat"] = true,					-- If tank good aggro = green, bad = red
	["class_icons"] = false,					-- Icons by class in pvp
	["name_abbrev"] = false,					-- Display the abbreviated names
	["good_color"] = {0.2, 0.8, 0.2},			-- Good threat color
	["near_color"] = {1, 1, 0},					-- Near threat color
	["bad_color"] = {1, 0, 0},					-- Bad threat color
	["track_auras"] = false,					-- Show debuffs
	["auras_size"] = 22,						-- Debuffs size
}

----------------------------------------------------------------------------------------
--	ActionBar options
----------------------------------------------------------------------------------------
C["actionbar"] = {
	-- Main
	["enable"] = true,							-- Enable actionbars
	["hotkey"] = true,							-- Show hotkey on buttons
	["macro"] = false,							-- Show macro name on buttons
	["show_grid"] = true,						-- Show empty action bar buttons
	["button_size"] = 25,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["split_bars"] = false,						-- Split the fifth bar on two bars on 6 buttons
	["classcolor_border"] = false,				-- Enable classcolor border
	["toggle_mode"] = true,						-- Enable toggle mode
	-- Bottom bars
	["bottombars"] = 2,							-- Number of action bars on the bottom
	-- Right bars
	["rightbars"] = 3,							-- Number of action bars on right
	["rightbars_mouseover"] = true,				-- Right bars on mouseover
	-- Pet bar
	["petbar_mouseover"] = false,				-- Petbar on mouseover(only for horizontal petbar)
	["petbar_hide"] = false,					-- Hide pet bar
	["petbar_horizontal"] = false,				-- Enable horizontal pet bar
	-- Shapeshift/Stance/Totem bars
	["shapeshift_mouseover"] = true,			-- Shapeshift/Stance/Totem bars on mouseover
	["shapeshift_hide"] = false,				-- Hide shapeshift
	["shapeshift_horizontal"] = true,			-- Enable horizontal shapeshift bar
}

----------------------------------------------------------------------------------------
--	Auras/Buffs/Debuffs options
----------------------------------------------------------------------------------------
C["aura"] = {
	["player_buff_size"] = 25,					-- Player buffs size
	["show_spiral"] = false,					-- Spiral on aura icons
	["show_timer"] = true,						-- Show cooldown timer on aura icons
	["player_auras"] = true,					-- Auras on player frame
	["target_auras"] = true,					-- Auras on target frame
	["focus_debuffs"] = false,					-- DeBuffs on focus frame
	["fot_debuffs"] = false,					-- DeBuffs on focustarget frame
	["pet_debuffs"] = false,					-- DeBuffs on pet frame
	["tot_debuffs"] = false,					-- DeBuffs on targettarget frame
	["boss_buffs"] = true,						-- Buffs on boss frame
	["player_aura_only"] = false,				-- Only your debuff on target frame
	["debuff_color_type"] = true,				-- Color debuff by type
	["cast_by"] = false,						-- Show who cast a buff/debuff in its tooltip
	["classcolor_border"] = false,				-- Enable classcolor border for player buffs
}

----------------------------------------------------------------------------------------
--	Unit Frames options
----------------------------------------------------------------------------------------
C["unitframe"] = {
	-- Main
	["enable"] = true,							-- Enable unit frames
	["own_color"] = false,						-- Set your color for health bars
	["uf_color"] = {0.4, 0.4, 0.4},				-- Color for UF if ["own_color"] = true
	["enemy_health_color"] = true,				-- If enable, enemy target color is red
	["show_total_value"] = false,				-- Display of info text on player and target with XXXX/Total
	["color_value"] = false,					-- Health/mana value is colored
	["bar_color_value"] = false,				-- Health bar color by current health remaining
	-- Cast bars
	["unit_castbar"] = true,					-- Show castbars
	["castbar_icon"] = false,					-- Show castbar icons
	["castbar_latency"] = true,					-- Castbar latency
	["castbar_ticks"] = false,					-- Castbar ticks
	-- Frames
	["show_pet"] = true,						-- Show pet frame
	["show_focus"] = true,						-- Show focus frame
	["show_target_target"] = true,				-- Show target target frame
	["show_boss"] = true,						-- Show boss frames
	["boss_on_right"] = true,					-- Set true for ShestakUI_DPS
	["show_arena"] = true,						-- Show arena frames
	["arena_on_right"] = true,					-- Set true for ShestakUI_DPS
	-- Icons
	["icons_pvp"] = false,						-- Mouseover pvp text(not icons) on player and target frames
	["icons_combat"] = true,					-- Combat icon
	["icons_resting"] = true,					-- Resting icon for low lvl chars
	["icons_combo_point"] = true,				-- Rogue|Druid combo point icons
	["icons_combo_point_new"] = true,			-- New style for combo points
	-- Portraits
	["portrait_enable"] = false,				-- Enable player/target portraits
	["portrait_classcolor_border"] = true,		-- Enable classcolor border
	["portrait_height"] = 94,					-- Portrait height
	["portrait_width"] = 67,					-- Portrait width
	-- Plugins
	["plugins_gcd"] = false,					-- Global cooldown spark
	["plugins_swing"] = false,					-- Swing bar
	["plugins_eclipse_bar"] = true,				-- Elipse bar
	["plugins_holy_bar"] = true,				-- Holy bar
	["plugins_shard_bar"] = true,				-- Shard bar
	["plugins_rune_bar"] = true,				-- Rune bar
	["plugins_necro_strike"] = false,			-- Necrotic Strike bar
	["plugins_vengeance_bar"] = true,			-- Vengeance bar
	["plugins_totem_bar"] = true,				-- Totem bar
	["plugins_totem_bar_name"] = false,			-- Totem name
	["plugins_reputation_bar"] = false,			-- Reputation bar
	["plugins_experience_bar"] = false,			-- Experience bar
	["plugins_smooth_bar"] = false,				-- Smooth bar
	["plugins_talents"] = false,				-- Enemy talents spec
	["plugins_combat_feedback"] = false,		-- Combat text on player/target frame
	["plugins_fader"] = false,					-- Fade unit frames
	["plugins_diminishing"] = false,			-- Diminishing Returns icons on arena frames
}

----------------------------------------------------------------------------------------
--	Raid Frames options
----------------------------------------------------------------------------------------
C["raidframe"] = {
	-- Main
	["aggro_border"] = true,					-- Aggro border
	["deficit_health"] = false,					-- Raid deficit health
	["vertical_health"] = false,				-- Vertical orientation of health
	["alpha_health"] = false,					-- Alpha of healthbars when 100%hp
	["show_range"] = true,						-- Show range opacity for raidframes
	["range_alpha"] = 0.5,						-- Alpha of unitframes when unit is out of range
	-- Frames
	["show_party"] = true,						-- Show party frames
	["show_raid"] = true,						-- Show raid frames
	["solo_mode"] = false,						-- Show player frame always
	["player_in_party"] = true,					-- Show player frame in party
	["raid_tanks"] = true,						-- Show raid tanks
	["raid_tanks_tt"] = false,					-- Show raid tanks target target
	["raid_groups"] = 5,						-- Number of groups in raid
	["raid_groups_vertical"] = false,			-- Vertical raid groups(only for ShestakUI_Heal)
	-- Icons
	["icons_lfd_role"] = false,					-- Party leader icon on frames
	["icons_raid_mark"] = true,					-- Raid mark icons on frames
	["icons_ready_check"] = true,				-- Ready check icons on frames
	["icons_leader"] = true,					-- Leader icon, assistant icon, master loot icon on frames
	-- Plugins
	["plugins_debuffhighlight_icon"] = false,	-- Debuff highlight texture + icon
	["plugins_aura_watch"] = true,				-- Raid debuff icons
	["plugins_aura_watch_timer"] = false,		-- Timer on raid debuff icons
	["plugins_healcomm"] = true,				-- Incoming heal bar on raid frame
	["plugins_auto_resurrection"] = false,		-- Auto cast resurrection on middle click when the unit is dead(does not work with Clique enabled)
}

----------------------------------------------------------------------------------------
--	Panel options
----------------------------------------------------------------------------------------
C["toppanel"] = {
	["enable"] = true,							-- Enable top panel
	["mouseover"] = true,						-- Top panel on mouseover
	["height"] = 55,							-- Panel height
	["width"] = 250,							-- Panel width
}

----------------------------------------------------------------------------------------
--	Stats options
----------------------------------------------------------------------------------------
C["stats"] = {
	["battleground"] = false,					-- BG Score
	["clock"] = true,							-- Clock
	["latency"] = true,							-- Latency
	["memory"] = true,							-- Memory
	["fps"] = true,								-- FPS
	["friend"] = true,							-- Friends
	["guild"] = true,							-- Guild
	["durability"] = true,						-- Durability
	["experience"] = true,						-- Experience
	["coords"] = true,							-- Coords
	["location"] = true,						-- Location
	["guild_repair"] = true,					-- Repair from guild bank
}

----------------------------------------------------------------------------------------
--	Error options
----------------------------------------------------------------------------------------
C["error"] = {	-- http://www.wowwiki.com/WoW_Constants/Errors
	["hide"] = true,							-- Enable hide combat errors
	["black"] = true,							-- Hide errors from black list
	["white"] = false,							-- Show errors from white list
	["combat"] = false,							-- Hide errors in combat
}

----------------------------------------------------------------------------------------
--	Addons group
----------------------------------------------------------------------------------------
C["addon"] = {	-- Group AddOns for fast selection
	raid = {									-- Type /addons raid
		"DBM-Core",
		"DXE",
		"PallyPower",
		"alDamageMeter",
		"Skada",
		"Recount",
		"Omen",
		"sThreatMeter2",
	},
	party = {									-- Type /addons party
		"DBM-Core",
		"DXE",
		"PallyPower",
		"alDamageMeter",
		"Skada",
		"Recount",
		"Omen",
		"sThreatMeter2",
	},
	pvp = {										-- Type /addons pvp
		"ArenaHistorian",
		"ncSpellalert",
	},
	quest = {									-- Type /addons quest
		"QuestHelper",
	},
	trade = {									-- Type /addons trade
		"Auctionator",
		"AuctionLite",
		"!Swatter",
		"Auc-Advanced",
		"Auc-Filter-Basic",
		"Auc-ScanData",
		"Auc-Stat-Histogram",
		"Auc-Stat-iLevel",
		"Auc-Stat-Purchased",
		"Auc-Stat-Simple",
		"Auc-Stat-StdDev",
		"Auc-Util-FixAH",
		"BeanCounter",
		"Enchantrix",
		"Enchantrix-Barker",
		"Informant",
		"SlideBar",
		"Stubby",
	},
}