﻿local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI main configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
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
	["whisp_sound"] = [[Interface\AddOns\ShestakUI\Media\Sounds\Whisper.mp3]],		-- Sound for whispers
	["warning_sound"] = [[Interface\AddOns\ShestakUI\Media\Sounds\Warning.mp3]],	-- Sound for warning
	["proc_sound"] = [[Interface\AddOns\ShestakUI\Media\Sounds\Proc.mp3]],			-- Sound for procs
	["border_color"] = {0.1, 0.1, 0.1, 1},		-- Color for borders
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
	["custom_lagtolerance"] = true,			-- Custom lag tolerance to your latency
}

----------------------------------------------------------------------------------------
--	Miscellaneous options
----------------------------------------------------------------------------------------
C["misc"] = {
	["shift_marking"] = true,					-- Marks target when you push "shift"
	["invite_keyword"] = "invite",				-- Short keyword for invite(for enable - in game type /ainv)
	["afk_spin_camera"] = true,				-- Spin camera while afk
	["vehicle_mouseover"] = false,				-- Vehicle frame on mouseover
	["quest_auto_button"] = false,				-- Quest auto button
	["raid_tools"] = true,						-- Raid tools
	["profession_tabs"] = true,					-- Professions tabs on TradeSkill frames
	["profession_database"] = true,			-- Professions Database on Professions frame
	["dungeon_tabs"] = true,					-- PvP/PvE tabs on own frames
	["hide_bg_spam"] = true,					-- Remove Boss Emote spam during BG("Arathi Basin" and "The Battle for Gilneas")
	["item_level"] = true,						-- Item level on character slot buttons
	["gem_counter"] = true,					-- Displays how many red/blue/yellow gems you have
	["already_known"] = true,					-- Colorizes recipes/mounts/pets that is already known
	["disenchanting"] = true,					-- One-click Milling, Prospecting and Disenchanting
	["sum_buyouts"] = true,					-- Sum up all current auctions
	["click_cast"] = false,						-- Simple click2cast spell binder
	["move_blizzard"] = true,					-- Move some Blizzard frames
	["color_picker"] = true,					-- Improved ColorPicker
	["enchantment_scroll"] = true,				-- Enchantment scroll on TradeSkill frame
	["archaeology"] = true,					-- Archaeology artifacts and cooldown
	["chars_currency"] = true,					-- Tracks your currency tokens across multiple characters
}

----------------------------------------------------------------------------------------
--	Announcements options
----------------------------------------------------------------------------------------
C["announcements"] = {
	["drinking"] = true,						-- Announce when arena enemy is drinking
	["interrupts"] = true,						-- Announce when you interrupt
	["spells"] = true,							-- Announce when you cast some spell
	["spells_from_all"] = true,				-- Check spells cast from all members
	["lightwell"] = true,						-- Announce your Lightwell
	["toys"] = true,							-- Announce some toys
	["says_thanks"] = true,					-- Says thanks for some spells
	["pull_countdown"] = true,					-- Pull countdown announce(/pc #)
	["flask_food"] = true,						-- Announce the usage of flasks and food
	["flask_food_auto"] = true,				-- Auto announce when ReadyCheck(if enable, announce to raid channel)
	["flask_food_raid"] = true,				-- Announce to raid channel
	["feasts"] = true,							-- Announce Feasts/Souls/Repair Bots cast
	["portals"] = true,						-- Announce Portals/Ritual of Summoning cast
	["bad_gear"] = true,						-- Check bad gear in instance
}

----------------------------------------------------------------------------------------
--	Automation options
----------------------------------------------------------------------------------------
C["automation"] = {
	["resurrection"] = true,					-- Auto resurrection in battlegrounds
	["screenshot"] = false,						-- Take screenshot when player get achievement
	["solve_artifact"] = true,					-- Auto popup for solve artifact
	["chefs_hat"] = true,						-- Auto equip Chef's Hat
	["safari_hat"] = true,						-- Auto equip Safari Hat
	["accept_invite"] = true,					-- Auto accept invite
	["decline_duel"] = true,					-- Auto decline duel
	["accept_quest"] = false,					-- Auto accept quests(if hold shift or alt, auto accept is disable)
	["auto_collapse"] = true,					-- Auto collapse WatchFrame in instance
	["skip_cinematic"] = true,					-- Auto skip cinematics/movies
	["auto_role"] = true,						-- Auto set your role
	["cancel_bad_buffs"] = true,				-- Auto cancel various buffs
	["tab_binder"] = true,						-- Auto change Tab key to only target enemy players
	["logging_combat"] = false,					-- Auto enables combat log text file in raid instances
	["currency_cap"] = true,					-- Auto popup for currency cap
	["buff_on_scroll"] = true,					-- Cast buff on mouse scroll
}

----------------------------------------------------------------------------------------
--	Skins options
----------------------------------------------------------------------------------------
C["skins"] = {
	["blizzard_frames"] = true,				-- Blizzard frames skin
	["minimap_buttons"] = true,				-- Skin addons icons on minimap
	["clcprot"] = true,						-- CLCProt skin
	["clcret"] = true,							-- CLCRet skin
	["combustion_helper"] = true,				-- CombustionHelper skin
	["bigwigs"] = true,						-- BigWigs skin
	["dbm"] = true,							-- DBM skin
	["dxe"] = true,							-- DXE skin
	["omen"] = true,							-- Omen skin
	["recount"] = true,						-- Recount skin
	["blood_shield_tracker"] = true,			-- BloodShieldTracker skin
	["dominos"] = true,						-- Dominos skin
	["flyout_button"] = true,					-- FlyoutButtonCustom skin
	["nug_running"] = true,					-- NugRunning skin
	["ovale"] = true,							-- OvaleSpellPriority skin
	["clique"] = true,							-- Clique skin
	["ace3"] = true,							-- Ace3 options elements skin
	["pallypower"] = true,						-- PallyPower skin
	["capping"] = true,						-- Capping skin
	["cool_line"] = true,						-- CoolLine skin
	["atlasloot"] = true,						-- AtlasLoot skin
	["tiny_dps"] = true,						-- TinyDPS skin
	["face_shooter"] = true,					-- FaceShooter skin
	["mage_nuggets"] = true,					-- MageNuggets skin
	["npcscan"] = true,						-- NPCScan skin
	["vanaskos"] = true,						-- VanasKoS skin
	["weak_auras"] = true,						-- WeakAuras skin
	["skada"] = true,							-- Skada skin
	["my_role_play"] = true,					-- MyRolePlay skin
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
	["dk_runes"] = true,						-- Show deathknight rune recharge
	["killingblow"] = false,					-- Tells you about your killingblows
	["merge_aoe_spam"] = true,					-- Merges multiple aoe damage spam into single message
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
	["solo_buffs_sound"] = true,				-- Enable warning sound notification for buff reminder
	["solo_buffs_size"] = 60,					-- Icon size
	-- Raid buffs
	["raid_buffs_enable"] = true,				-- Show missing raid buffs
	["raid_buffs_always"] = false,				-- Show frame always
	["raid_buffs_size"] = 19.2,					-- Icon size
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
	["show_inpvp"] = true,						-- Show in bg zone
	["show_inarena"] = true,					-- Show in arena zone
}

----------------------------------------------------------------------------------------
--	Pulse cooldowns options
----------------------------------------------------------------------------------------
C["pulsecooldown"] = {
	["enable"] = true,							-- Show cooldowns pulse
	["size"] = 60,								-- Icon size
	["sound"] = true,							-- Warning sound notification
	["anim_scale"] = 1.5,						-- Animation scaling
	["hold_time"] = 0,							-- Max opacity hold time
	["threshold"] = 3,							-- Minimal threshold time
}

----------------------------------------------------------------------------------------
--	Threat options
----------------------------------------------------------------------------------------
C["threat"] = {
	["enable"] = false,							-- Enable threat meter
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
	["cursor"] = false,							-- Tooltip above cursor
	["item_icon"] = true,						-- Item icon in tooltip
	["health_value"] = true,					-- Numeral health value
	["hidebuttons"] = false,					-- Hide tooltip for actions bars
	["hide_combat"] = false,					-- Hide tooltip in combat
	-- Plugins
	["talents"] = true,						-- Show tooltip talents
	["achievements"] = true,					-- Comparing achievements in tooltip
	["target"] = true,							-- Target player in tooltip
	["title"] = true,							-- Player title and realm name in tooltip
	["rank"] = true,							-- Player guild-rank in tooltip
	["arena_experience"] = true,				-- Player PvP experience in arena
	["spell_id"] = true,						-- Id number spells
	["average_lvl"] = true,					-- Average items level
	["raid_icon"] = true,						-- Raid icon
	["who_targetting"] = true,					-- Show who is targetting the unit(in raid or party)
	["item_count"] = true,						-- Item count in tooltip
	["unit_role"] = true,						-- Unit role in tooltip
	["symbiosis"] = true,						-- Symbiosis info
	["instance_lock"] = true,					-- Your instance lock status in tooltip
	["item_transmogrify"] = true,				-- Displays items can not be transmogrified
}

----------------------------------------------------------------------------------------
--	Chat options
----------------------------------------------------------------------------------------
C["chat"] = {
	["enable"] = true,							-- Enable chat
	["background"] = false,						-- Enable background for chat
	["background_alpha"] = 0.7,					-- Background alpha
	["filter"] = true,							-- Removing some systems spam("Player1" won duel "Player2")
	["spam"] = true,							-- Removing some players spam(gold/portals/etc)
	["width"] = 350,							-- Chat width
	["height"] = 112,							-- Chat height
	["chat_bar"] = true,						-- Lite Button Bar for switch chat channel
	["chat_bar_mouseover"] = true,				-- Lite Button Bar on mouseover
	["time_color"] = {1, 1, 0},					-- Timestamp coloring(http://www.december.com/html/spec/colorcodescompact.html)
	["whisp_sound"] = true,						-- Sound when whisper
	["bubbles"] = true,							-- Skin Blizzard chat bubbles
	["combatlog"] = true,						-- Show CombatLog tab(need two reloads when false)
	["tabs_mouseover"] = true,					-- Chat tabs on mouseover
	["sticky"] = true,							-- Remember last channel
	["damage_meter_spam"] = true,				-- Merge damage meter spam in one line-link
}

----------------------------------------------------------------------------------------
--	Bag options
----------------------------------------------------------------------------------------
C["bag"] = {
	["enable"] = true,							-- Enable bags
	["button_size"] = 30,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["bank_columns"] = 17,						-- Horizontal number of columns in bank
	["bag_columns"] = 10,						-- Horizontal number of columns in main bag
}

----------------------------------------------------------------------------------------
--	Minimap options
----------------------------------------------------------------------------------------
C["minimap"] = {
	["enable"] = true,							-- Enable minimap
	["tracking_icon"] = true,					-- Tracking icon
	["size"] = 130,								-- Minimap size
	["hide_combat"] = false,					-- Hide minimap in combat
	["toggle_menu"] = true,						-- Show toggle menu
}

----------------------------------------------------------------------------------------
--	Map options
----------------------------------------------------------------------------------------
C["map"] = {
	["enable"] = true,							-- Enable World Map
	["scale"] = 0.8,							-- World Map scale
	["bg_map_stylization"] = true,				-- BG map stylization
	["map_boss_count"] = true,					-- Show boss count in World Map
	["explore_map"] = true,					-- Tracking Explorer and Lore Master achievements in World Map
	["fog_of_war"] = true,						-- Fog of war on World Map
}

----------------------------------------------------------------------------------------
--	Loot options
----------------------------------------------------------------------------------------
C["loot"] = {
	["lootframe"] = true,						-- Enable loot frame
	["rolllootframe"] = true,					-- Enable group roll frame
	["icon_size"] = 22,							-- Icon size
	["width"] = 221,							-- Loot window width
	["auto_greed"] = true,						-- Push "greed" or "disenchant" button when an item roll
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
	["combat"] = true,							-- Automatically show nameplate in combat
	["health_value"] = true,					-- Numeral health value
	["show_castbar_name"] = true,				-- Show castbar name
	["enhance_threat"] = true,					-- If tank good aggro = green, bad = red
	["class_icons"] = true,					-- Icons by class in PvP
	["name_abbrev"] = false,					-- Display the abbreviated names
	["good_color"] = {0.2, 0.8, 0.2},			-- Good threat color
	["near_color"] = {1, 1, 0},					-- Near threat color
	["bad_color"] = {1, 0, 0},					-- Bad threat color
	["track_auras"] = true,					-- Show debuffs
	["auras_size"] = 22,						-- Debuffs size
	["healer_icon"] = true,					-- Show icon above enemy healers nameplate in battlegrounds
}

----------------------------------------------------------------------------------------
--	ActionBar options
----------------------------------------------------------------------------------------
C["actionbar"] = {
	-- Main
	["enable"] = true,							-- Enable actionbars
	["hotkey"] = true,							-- Show hotkey on buttons
	["macro"] = true,							-- Show macro name on buttons
	["show_grid"] = true,						-- Show empty action bar buttons
	["button_size"] = 30,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["split_bars"] = false,						-- Split the fifth bar on two bars on 6 buttons
	["classcolor_border"] = false,				-- Enable classcolor border
	["toggle_mode"] = false,						-- Enable toggle mode
	["hide_highlight"] = false,					-- Hide proc highlight
	-- Bottom bars
	["bottombars"] = 3,							-- Number of action bars on the bottom
	-- Right bars
	["rightbars"] = 2,							-- Number of action bars on right
	["rightbars_mouseover"] = false,				-- Right bars on mouseover
	-- Pet bar
	["petbar_mouseover"] = false,				-- Pet bar on mouseover(only for horizontal pet bar)
	["petbar_hide"] = false,					-- Hide pet bar
	["petbar_horizontal"] = true,				-- Enable horizontal pet bar
	-- Stance bar
	["stancebar_mouseover"] = false,				-- Stance bar on mouseover
	["stancebar_hide"] = false,					-- Hide stance bar
	["stancebar_horizontal"] = true,			-- Enable horizontal stance bar
	-- MicroMenu
	["micromenu"] = true,						-- Enable micro menu
	["micromenu_mouseover"] = false,			-- Micro menu on mouseover
}

----------------------------------------------------------------------------------------
--	Auras/Buffs/Debuffs options
----------------------------------------------------------------------------------------
C["aura"] = {
	["player_buff_size"] = 25,					-- Player buffs size
	["show_spiral"] = true,					-- Spiral on aura icons
	["show_timer"] = true,						-- Show cooldown timer on aura icons
	["player_auras"] = true,					-- Auras on player frame
	["target_auras"] = true,					-- Auras on target frame
	["focus_debuffs"] = true,					-- DeBuffs on focus frame
	["fot_debuffs"] = true,					-- DeBuffs on focustarget frame
	["pet_debuffs"] = true,					-- DeBuffs on pet frame
	["tot_debuffs"] = true,					-- DeBuffs on targettarget frame
	["boss_buffs"] = true,						-- Buffs on boss frame
	["player_aura_only"] = true,				-- Only your debuff on target frame
	["debuff_color_type"] = true,				-- Color debuff by type
	["cast_by"] = true,						-- Show who cast a buff/debuff in its tooltip
	["classcolor_border"] = false,				-- Enable classcolor border for player buffs
}

----------------------------------------------------------------------------------------
--	Unit Frames options
----------------------------------------------------------------------------------------
C["unitframe"] = {
	-- Main
	["enable"] = true,							-- Enable unit frames
	["own_color"] = true,						-- Set your color for health bars
	["uf_color"] = {0.1, 0.1, 0.1},				-- Color for UF if ["own_color"] = true
	["enemy_health_color"] = true,				-- If enable, enemy target color is red
	["show_total_value"] = true,				-- Display of info text on player and target with XXXX/Total
	["color_value"] = true,					-- Health/mana value is colored
	["bar_color_value"] = true,				-- Health bar color by current health remaining
	-- Cast bars
	["unit_castbar"] = true,					-- Show castbars
	["castbar_icon"] = true,					-- Show castbar icons
	["castbar_latency"] = true,					-- Castbar latency
	["castbar_ticks"] = true,					-- Castbar ticks
	-- Frames
	["show_pet"] = true,						-- Show pet frame
	["show_focus"] = true,						-- Show focus frame
	["show_target_target"] = true,				-- Show target target frame
	["show_boss"] = true,						-- Show boss frames
	["boss_on_right"] = true,					-- Boss frames on the right
	["show_arena"] = true,						-- Show arena frames
	["arena_on_right"] = true,					-- Arena frames on the right
	-- Icons
	["icons_pvp"] = true,						-- Mouseover PvP text(not icons) on player and target frames
	["icons_combat"] = true,					-- Combat icon
	["icons_resting"] = true,					-- Resting icon for low lvl chars
	-- Portraits
	["portrait_enable"] = false,				-- Enable player/target portraits
	["portrait_classcolor_border"] = true,		-- Enable classcolor border
	["portrait_height"] = 92,					-- Portrait height
	["portrait_width"] = 67,					-- Portrait width
	-- Plugins
	["plugins_gcd"] = false,					-- Global cooldown spark
	["plugins_swing"] = false,					-- Swing bar
	["plugins_necro_strike"] = false,			-- Necrotic Strike bar
	["plugins_reputation_bar"] = true,			-- Reputation bar
	["plugins_experience_bar"] = true,			-- Experience bar
	["plugins_friendship_bar"] = true,			-- Friendship bar
	["plugins_smooth_bar"] = false,				-- Smooth bar
	["plugins_talents"] = true,				-- Enemy specialization
	["plugins_combat_feedback"] = false,		-- Combat text on player/target frame
	["plugins_fader"] = false,					-- Fade unit frames
	["plugins_diminishing"] = true,			-- Diminishing Returns icons on arena frames
}

----------------------------------------------------------------------------------------
--	Unit Frames Class bar options
----------------------------------------------------------------------------------------
C["unitframe_class_bar"] = {
	["combo"] = true,							-- Rogue/Druid Combo bar
	["shadow"] = true,							-- Shadow Orbs bar
	["chi"] = true,								-- Chi bar
	["vengeance"] = true,						-- Vengeance bar
	["eclipse"] = true,							-- Eclipse bar
	["holy"] = true,							-- Holy Power bar
	["shard"] = true,							-- Shard/Burning bar
	["rune"] = true,							-- Rune bar
	["totem"] = true,							-- Totem bar
	["range"] = true,							-- Range bar
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
	["solo_mode"] = true,						-- Show player frame always
	["player_in_party"] = true,					-- Show player frame in party
	["raid_tanks"] = true,						-- Show raid tanks
	["raid_tanks_tt"] = true,					-- Show raid tanks target target
	["raid_groups"] = 5,						-- Number of groups in raid
	["raid_groups_vertical"] = true,			-- Vertical raid groups(only for heal layout)
	-- Icons
	["icons_role"] = true,						-- Role icon on frames
	["icons_raid_mark"] = true,					-- Raid mark icons on frames
	["icons_ready_check"] = true,				-- Ready check icons on frames
	["icons_leader"] = true,					-- Leader icon, assistant icon, master loot icon on frames
	-- Plugins
	["plugins_debuffhighlight_icon"] = true,	-- Debuff highlight texture + icon
	["plugins_aura_watch"] = true,				-- Raid debuff icons
	["plugins_aura_watch_timer"] = true,		-- Timer on raid debuff icons
	["plugins_healcomm"] = true,				-- Incoming heal bar on raid frame
	["plugins_auto_resurrection"] = true,		-- Auto cast resurrection on middle-click(doesn't work with Clique)
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
	["battleground"] = true,					-- BG Score
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
}

----------------------------------------------------------------------------------------
--	Error options
----------------------------------------------------------------------------------------
C["error"] = {
	["black"] = true,							-- Hide errors from black list
	["white"] = false,							-- Show errors from white list
	["combat"] = false,							-- Hide all errors in combat
}