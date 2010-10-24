----------------------------------------------------------------------------------------
--	ShestakUI main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Media options
----------------------------------------------------------------------------------------
SettingsCF["media"] = {
	["normal_font"] = [[Interface\AddOns\ShestakUI\media\font.ttf]],		-- Main non pixel font
	["pixel_font"] = [[Interface\AddOns\ShestakUI\media\pixel.ttf]],		-- Main pixel font
	["pixel_font_style"] = "OUTLINEMONOCHROME",								-- Font style, select "OUTLINEMONOCHROME" or "OUTLINE"
	["pixel_font_size"] = 8,												-- Font size for those places where it is not specified
	["blank"] = [[Interface\AddOns\ShestakUI\media\white.tga]],				-- Bright texture for border, etc
	["texture"] = [[Interface\AddOns\ShestakUI\media\gray.tga]],			-- Dull texture for status bars
	["highlight"] = [[Interface\AddOns\ShestakUI\media\highlight.tga]],		-- Highlight texture for debuffs
	["whisp_sound"] = [[Interface\AddOns\ShestakUI\media\whisp.mp3]],		-- Sound for wispers
	["border_color"] = {0.37, 0.3, 0.3},		-- Color for borders
	["backdrop_color"] = {0, 0, 0},				-- Color for borders backdrop
	["overlay_color"] = {0, 0, 0, 0.7},			-- Color for action bars overlay
	["uf_color"] = {0.4, 0.4, 0.4},				-- Color for UF if ["own_color"] = true
}

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
SettingsCF["general"] = {
	["auto_scale"] = true,						-- Autoscale
	["multisampleprotect"] = true,				-- Disable this if you want multisample > 1
	["uiscale"] = 0.96,							-- Your value(between 0.64 and 1) if "auto_scale" is disable
	["minimap_icon"] = true,					-- UI icon near minimap
	["welcome_message"] = true,					-- Enable welcome message in chat
	--[[Correct UI Scale for resoluitons:
		y-resolution | scale
		768          | 1
		800          | 0.96
		900          | 0.8533333333333333
		1024         | 0.75
		1050         | 0.7314285714285714
		1080         | 0.7111111111111111
		1200         | 0.64
	]]
}

----------------------------------------------------------------------------------------
--	Miscellaneous options
----------------------------------------------------------------------------------------
SettingsCF["misc"] = {
	["auto_quest"] = false,						-- Auto accept quests(if hold shift, auto accept is disable)
	["auto_decline_duel"] = true,				-- Auto decline duel
	["auto_accept_invite"] = false,				-- Auto accept invite
	["auto_resurrection"] = true,				-- Auto resurrection in Battle Ground
	["shift_marking"] = true,					-- Marks target when you push "shift"
	["invite_keyword"] = "invite",				-- Short keyword for invite(for enable - in game type /ainv)
	["afk_spin_camera"] = false,				-- Spin camera while afk
	["move_watchframe"] = true,					-- Quest Watch frame movable
	["vehicle_mouseover"] = false,				-- Vehicle frame on mouseover
	["quest_auto_button"] = false,				-- Quest auto button
	["raid_tools"] = false,						-- Raid tools
}

----------------------------------------------------------------------------------------
--	Skins options
----------------------------------------------------------------------------------------
SettingsCF["skins"] = {
	["dbm"] = true,								-- DBM skin
	["pallypower"] = true,						-- PallyPower skin
}

----------------------------------------------------------------------------------------
--	Combat text options
----------------------------------------------------------------------------------------
SettingsCF["combattext"] = {
	["font_size"] = 16,							-- Font size
	["blizz_head_numbers"] = false,				-- Use blizzard damage/healing output(above mob/player head)
	["damage_style"] = true,					-- Change default damage/healing font above mobs/player heads(you need to restart WoW to see changes)
	["damage"] = true,							-- Show outgoing damage in it's own frame
	["healing"] = true,							-- Show outgoing healing in it's own frame
	["show_hots"] = true,						-- Show periodic healing effects in healing frame
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
	["dk_runes"] = true,						-- Show deatchknight rune recharge
}

----------------------------------------------------------------------------------------
--	Buffs reminder options
----------------------------------------------------------------------------------------
SettingsCF["reminder"] = {
	-- Self buffs
	["solo_buffs_enable"] = true,				-- Enable buff reminder
	["solo_buffs_sound"] = false,				-- Enable warning sound notification for buff reminder
	["solo_buffs_size"] = 45,					-- Icon size
	-- Raid buffs
	["raid_buffs_enable"] = true,				-- Show missing raid buffs
	["raid_buffs_always"] = false,				-- Show frame always
	["raid_buffs_size"] = 15,					-- Icon size
	["raid_buffs_alpha"] = 0,					-- Transparent icons when the buff is present
}

----------------------------------------------------------------------------------------
--	Raid/Enemy cooldown options
----------------------------------------------------------------------------------------
SettingsCF["cooldown"] = {
	-- Raid cooldowns
	["raid_enable"] = true,						-- Enable raid cooldowns
	["raid_font_size"] = 8,						-- Font size
	["raid_height"] = 15,						-- Bars height
	["raid_width"] = 186,						-- Bars width(if show_icon = false, bar width+28)
	["raid_upwards"] = false,					-- Sort upwards bars
	["raid_show_icon"] = true,					-- Show icons
	["raid_show_inraid"] = true,				-- Show in raid zone
	["raid_show_inparty"] = true,				-- Show in party zone
	["raid_show_inarena"] = true,				-- Show in arena zone
	-- Enemy cooldowns
	["enemy_enable"] = true,					-- Enable enemy cooldowns
	["enemy_size"] = 30,						-- Icon size
	["enemy_show_always"] = false,				-- Show everywhere
	["enemy_show_inpvp"] = false,				-- Show in bg zone
	["enemy_show_inarena"] = true,				-- Show in arena zone
}

----------------------------------------------------------------------------------------
--	Threat options
----------------------------------------------------------------------------------------
SettingsCF["threat"] = {
	["enable"] = false,							-- Enable threat meter
	["font_size"] = 8,							-- Font size
	["height"] = 12,							-- Bars height
	["width"] = 217,							-- Bars width
	["bar_rows"] = 7,							-- Number of bars
	["test_mode"] = false,						-- Test mode
}

----------------------------------------------------------------------------------------
--	Tooltip options
----------------------------------------------------------------------------------------
SettingsCF["tooltip"] = {
	["enable"] = true,							-- Enable tooltip
	["shift_modifer"] = false,					-- Show tooltip when "shift" is pushed
	["cursor"] = false,							-- ToolTip under cursor
	["item_icon"] = false,						-- Item icon in tooltip
	["health_value"] = false,					-- Numeral health value
	["hidebuttons"] = false,					-- Hide tooltips for actions bars
	-- Plugins
	["talents"] = false,						-- Show tooltip talents
	["achievements"] = true,					-- Comparing achievements in tooltip
	["target"] = true,							-- Target player in tooltip
	["title"] = false,							-- Player title in tooltip
	["rank"] = true,							-- Player guild-rank in tooltip
	["arena_experience"] = false,				-- Player PVP experience in arena
	["spell_id"] = false,						-- Id number spells
}

----------------------------------------------------------------------------------------
--	Chat options
----------------------------------------------------------------------------------------
SettingsCF["chat"] = {
	["enable"] = true,							-- Enable chat
	["background"] = false,						-- Enable background for chat
	["background_alpha"] = 0.7,					-- Background alpha
	["font_size"] = 11,							-- Chat font size
	["font_style"] = "",						-- Font style("OUTLINE", "OUTLINEMONOCHROME", "THICKOUTLINE" or "")
	["tab_font_size"] = 8,						-- Chat tab font size
	["tab_font_style"] = "OUTLINEMONOCHROME",	-- Tab font style("OUTLINE", "OUTLINEMONOCHROME", "THICKOUTLINE" or "")
	["filter"] = true,							-- Removing some chat spam("Player1" won duel "Player2")
	["width"] = 350,							-- Chat width
	["height"] = 112,							-- Chat height
	["chat_bar"] = false,						-- Lite Button Bar for switch chat channel
	["time_color"] = "FFD700",					-- Timestamp coloring(http://www.december.com/html/spec/colorcodes.html)
	["whisp_sound"] = true,						-- Sound when whisper
	["bubbles"] = true,							-- Skin Blizzard chat bubbles
}

----------------------------------------------------------------------------------------
--	Bag options
----------------------------------------------------------------------------------------
SettingsCF["bag"] = {
	["enable"] = true,							-- Enable bags
	["button_size"] = 27,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["bank_columns"] = 17,						-- Horizontal number of columns in bank
	["bag_columns"] = 10,						-- Horizontal number of columns in main bag
}

----------------------------------------------------------------------------------------
--	Minimap options
----------------------------------------------------------------------------------------
SettingsCF["minimap"] = {
	["enable"] = true,							-- Enable minimap
	["tracking_icon"] = false,					-- Tracking icon
	["size"] = 126,								-- Minimap size
	["hide_combat"] = false,					-- Hide minimap in combat
}

----------------------------------------------------------------------------------------
--	Map options
----------------------------------------------------------------------------------------
SettingsCF["map"] = {
	["enable"] = true,							-- Enable world map
	["scale"] = 0.8,							-- World map scale
	["bg_map_stylization"] = true,				-- BG map stylization
}

----------------------------------------------------------------------------------------
--	Loot options
----------------------------------------------------------------------------------------
SettingsCF["loot"] = {
	["lootframe"] = true,						-- Enable loot frame
	["rolllootframe"] = true,					-- Enable group roll frame
	["font_size"] = 8,							-- Loot frame font size
	["icon_size"] = 22,							-- Icon size
	["width"] = 221,							-- Loot window width
	["auto_greed"] = true,						-- Push "greed" button when an item roll
	["auto_confirm_de"] = true,					-- Auto confirm disenchant
}

----------------------------------------------------------------------------------------
--	Nameplate options
----------------------------------------------------------------------------------------
SettingsCF["nameplate"] = {
	["enable"] = true, 							-- Enable nameplate
	["font_size"] = 8,							-- Nameplate font size
	["height"] = 9,								-- Nameplate height
	["width"] = 120,							-- Nameplate width
	["combat"] = false,							-- Automatically show nameplate in combat
	["health_value"] = false,					-- Numeral health value
	["show_castbar_name"] = false,				-- Show castbar name
	["enhance_threat"] = true,					-- If tank good aggro = green, bad = red
	["class_icons"] = false,					-- Icons by class in pvp
	["name_abbrev"] = true,						-- Display the abbreviated names
	["overlap"] = true,							-- Allow nameplates to overlap
}

----------------------------------------------------------------------------------------
--	ActionBar options
----------------------------------------------------------------------------------------
SettingsCF["actionbar"] = {
	-- Main
	["enable"] = true,							-- Enable actionbars
	["hotkey"] = true,							-- Show text on you hotkey
	["show_grid"] = true,						-- Show empty action bar buttons
	["button_size"] = 25,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
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
--	Auras/Buffs/Debuffs
----------------------------------------------------------------------------------------
SettingsCF["aura"] = {
	["font_size"] = 8,							-- Auras font size
	["player_buff_size"] = 25,					-- Player buffs size
	["show_spiral"] = false,					-- Spiral on aura icons
	["show_timer"] = true,						-- Show cooldown tier on aura icons
	["player_auras"] = true,					-- Auras on player frame
	["target_auras"] = true,					-- Auras on target frame
	["focus_debuffs"] = false,					-- DeBuffs on focus frame
	["fot_debuffs"] = false,					-- DeBuffs on focustarget frame
	["pet_debuffs"] = false,					-- DeBuffs on pet frame
	["tot_debuffs"] = false,					-- DeBuffs on targettarget frame
	["player_aura_only"] = false,				-- Only your debuff on target frame
	["debuff_color_type"] = true,				-- Color debuff by type
}

----------------------------------------------------------------------------------------
--	UnitFrame options
----------------------------------------------------------------------------------------
SettingsCF["unitframe"] = {
	-- Main
	["enable"] = true,							-- Enable unitframes
	["font_size"] = 8,							-- Font size
	["aggro_border"] = true,					-- Aggro border
	["own_color"] = false,						-- Set your color for health bars
	["enemy_health_color"] = true,				-- If enable, enemy target color is red
	["show_total_value"] = false,				-- Display of info text on player and target with XXXX/Total
	["deficit_health"] = false,					-- Raid deficit health
	["color_value"] = false,					-- Health/mana value is colored
	["unit_castbar"] = true,					-- Show castbars
	["castbar_icon"] = false,					-- Show castbar icons
	["castbar_latency"] = true,					-- Castbar latency
	["show_boss"] = true,						-- Show boss frames
	["show_arena"] = true,						-- Show arena frames
	["arena_on_right"] = true,					-- Set true for ShestakUI_DPS
	-- Raid
	["show_raid"] = true,						-- Show raid frames
	["vertical_health"] = false,				-- Vertical orientation of health
	["alpha_health"] = false,					-- Alpha of healthbars when 100%hp
	["show_range"] = true,						-- Show range opacity for raidframes
	["range_alpha"] = 0.5,						-- Alpha of unitframes when unit is out of range
	["solo_mode"] = false,						-- Show player frame always
	["player_in_party"] = true,					-- Show player frame in party
	["raid_tanks"] = true,						-- Show raid tanks
	["raid_groups"] = 5,						-- Number of groups in raid(Only for ShestakUI_Heal)
	["raid_groups_vertical"] = false,			-- Vertical raid groups(Only for ShestakUI_Heal)
	-- Icons
	["icons_pvp"] = false,						-- Mouseover pvp text(not icons) on player and target frames
	["icons_leader"] = true,					-- Leader icon, assistant icon, master loot icon on frames
	["icons_combat"] = true,					-- Combat icon
	["icons_resting"] = true,					-- Resting icon for low lvl chars
	["icons_lfd_role"] = false,					-- Party leader icon on frames
	["icons_raid_mark"] = true,					-- Raid marks
	["icons_combo_point"] = true,				-- Rogue|Druid combo point icons
	["icons_ready_check"] = true,				-- Ready check icons
	-- Portraits
	["portrait_enable"] = false,				-- Enable player/target portraits
	["portrait_classcolor_border"] = true,		-- Enable classcolor border
	["portrait_height"] = 94,					-- Portrait height
	["portrait_width"] = 67,					-- Portrait width
	-- oUF Plugins
	["plugins_gcd"] = false,					-- Global cooldown spark
	["plugins_swing"] = false,					-- Swing bar
	["plugins_eclipse_bar"] = true,				-- Elipse bar
	["plugins_holy_bar"] = true,				-- Holy bar
	["plugins_shard_bar"] = true,				-- Shard bar
	["plugins_rune_bar"] = true,				-- Rune bar
	["plugins_totem_bar"] = true,				-- Totem bar
	["plugins_totem_bar_name"] = false,			-- Totem name
	["plugins_reputation_bar"] = false,			-- Reputation bar
	["plugins_experience_bar"] = false,			-- Experience bar
	["plugins_smooth_bar"] = false,				-- Smooth bar
	["plugins_talents"] = false,				-- Enemy talents spec
	["plugins_combat_feedback"] = false,		-- Combat text on player/target frame
	["plugins_debuffhighlight_icon"] = false,	-- Debuff highlight texture + icon
	["plugins_aura_watch"] = true,				-- *RAID* Auras watch
	["plugins_healcomm"] = true,				-- Incoming heal bar on raid frame
}

----------------------------------------------------------------------------------------
--	Panel options
----------------------------------------------------------------------------------------
SettingsCF["toppanel"] = {
	["enable"] = true,							-- Enable top panel
	["mouseover"] = true,						-- Top panel on mouseover
	["height"] = 55,							-- Panel height
	["width"] = 320,							-- Panel width
}

----------------------------------------------------------------------------------------
--	Stats options
----------------------------------------------------------------------------------------
SettingsCF["stats"] = {
	["font_size"] = 8,							-- Stats font size
	["battleground"] = true,					-- BG Score
	["clock"] = true,							-- Clock
	["latency"] = true,							-- Latency
	["memory"] = true,							-- Memory
	["fps"] = true,								-- FPS
	["experience"] = false,						-- Experience
	["coords"] = true,							-- Coords
	["location"] = true,						-- Location
	["guild_repair"] = true,					-- Repair from guild bank
}

----------------------------------------------------------------------------------------
--	Error options
----------------------------------------------------------------------------------------
SettingsCF["error"] = {							-- http://www.wowwiki.com/WoW_Constants/Errors
	["hide"] = true,							-- Enable hide combat errors
	["black"] = true,							-- Hide errors from black list
	["white"] = false,							-- Show errors from white list
	["combat"] = false,							-- Hide errors in combat
}

----------------------------------------------------------------------------------------
--	Addons group
----------------------------------------------------------------------------------------
SettingsCF["addon"] = {							-- Group AddOns for fast selection
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

----------------------------------------------------------------------------------------
--	Position options
----------------------------------------------------------------------------------------
SettingsCF["position"] = {
	-- Miscellaneous positions
	["minimap"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -23, 26},		-- Minimap
	["map"] = {"CENTER", UIParent, "CENTER", 0, 70},						-- Map
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 24, 22},				-- Chat
	["bag"]	= {"BOTTOMRIGHT", Minimap, "TOPRIGHT", -1, 8},					-- Bag
	["bank"] = {"LEFT", UIParent, "LEFT", 23, 150},							-- Bank
	["bn_popup"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 21, 20},			-- BattleNet popup
	["tooltip"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},				-- Tooltip
	["ticket"] = {"TOPLEFT", UIParent, "TOPLEFT", 20, -20},					-- GM ticket
	["attempt"] = {"TOP", UIParent, "TOP", -85, -20},						-- Attempts frame
	["capture_bar"] = {"TOP", UIParent, "TOP", 0, 0},						-- BG capture bars
	["vehicle"] = {"BOTTOM", Minimap, "TOP", 0, 30},						-- Vehicle frame
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},							-- Errors frame
	["quest"] = {"TOPLEFT", UIParent, "TOPLEFT", 25, -10},					-- Quest log
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},					-- Loot
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -210, 500},				-- Group roll loot
	["threat_meter"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, -123},	-- Threat meter
	["raid_cooldown"] = {"TOPLEFT", UIParent, "TOPLEFT", 51, -28},			-- Raid cooldowns
	["enemy_cooldown"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, 62},	-- Enemy cooldowns
	["bg_score"] = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 6},				-- BG stats
	-- ActionBar positions
	["bottom_bars"] = {"BOTTOM", UIParent, "BOTTOM", 0, 8},					-- Bottom bars
	["right_bars"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 320},	-- Right bars
	["pet_horizontal"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -175, 167},	-- Horizontal pet bar
	["stance_bar"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -202, 167},		-- Stance/Shift/Totem bars
	["vehicle_bar"] = {"BOTTOMRIGHT", "Bar1Holder", "BOTTOMLEFT", -3, 0},	-- Vehicle button
	-- UnitFrame positions
	["player_buffs"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -22, -20},		-- Player buffs
	unitframes = {
		["player"] = {"BOTTOM", UIParent, "BOTTOM", -284, 236},						-- Player frame
		["target"] = {"BOTTOM", UIParent, "BOTTOM", 284, 236},						-- Target frame
		["target_target"] = {"BOTTOMRIGHT", "oUF_Target", "TOPRIGHT", 0, -54},		-- ToT frame
		["pet"] = {"BOTTOMLEFT", "oUF_Player", "TOPLEFT", 0, -54},					-- Pet frame
		["focus"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, -54},				-- Focus frame
		["focus_target"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, -54},			-- Focus target frame
		["party_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Party frames
		["raid_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Raid frames
		["party_dps"] = {"BOTTOMLEFT", UIParent, "LEFT", 22, -70},					-- DPS layout Party frames
		["raid_dps"] = {"TOPLEFT", UIParent, "TOPLEFT", 22, -22},					-- DPS layout Raid frames
		["arena"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -20, -70},					-- Arena frames
		["boss"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -20, -70},					-- Boss frames
		["tank"] = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 26},						-- Tank frames
		["player_portrait"] = {"TOPRIGHT", "oUF_Player", "TOPLEFT", -11, 28},		-- Player Portrait
		["target_portrait"] = {"TOPLEFT", "oUF_Target", "TOPRIGHT", 11, 28},		-- Target Portrait
		["player_castbar"] = {"BOTTOMLEFT", "oUF_Player", "BOTTOMRIGHT", 58, 0},	-- Player Castbar
		["target_castbar"] = {"CENTER", "oUF_Player_Castbar", "CENTER", -23, 35},	-- Target Castbar
		["focus_castbar"] = {"CENTER", UIParent, "CENTER", 0, 250},					-- Focus Castbar icon
	},
}

----------------------------------------------------------------------------------------
--	Fonts options !!!!!!!!!!!NOT WORKING!!!!!!!!!!!
----------------------------------------------------------------------------------------
SettingsCF["pixelfont"] = {
	["stats_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["stats_font_size"] = 8,
	["stats_font_style"] = "OUTLINEMONOCHROME",
	["unit_frames_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["unit_frames_font_size"] = 8,
	["unit_frames_font_style"] = "OUTLINEMONOCHROME",
	["auras_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["auras_font_size"] = 8,
	["auras_font_style"] = "OUTLINEMONOCHROME",
	["combat_text_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["combat_text_font_size"] = 16,
	["combat_text_font_style"] = "OUTLINEMONOCHROME",
	["chat_tabs_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["chat_tabs_font_size"] = 8,
	["chat_tabs_font_style"] = "OUTLINEMONOCHROME",
	["action_bars_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["action_bars_font_size"] = 8,
	["action_bars_font_style"] = "OUTLINEMONOCHROME",
	["threat_meter_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["threat_meter_font_size"] = 8,
	["threat_meter_font_style"] = "OUTLINEMONOCHROME",
	["raid_cooldowns_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["raid_cooldowns_font_size"] = 8,
	["raid_cooldowns_font_style"] = "OUTLINEMONOCHROME",
	["cooldown_timers_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["cooldown_timers_font_size"] = 16,
	["cooldown_timers_font_style"] = "OUTLINEMONOCHROME",
	["filger_bars_name_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["filger_bars_name_font_size"] = 8,
	["filger_bars_name_font_style"] = "OUTLINEMONOCHROME",
	["stylization_font"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
	["stylization_font_size"] = 8,
	["stylization_font_style"] = "OUTLINEMONOCHROME",
}