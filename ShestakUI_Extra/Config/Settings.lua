local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
C["extra_general"] = {
	["click_cast"] = false,						-- Click2Cast mod
	["move_blizzard"] = true,					-- Move Blizzard frames
	["arena_calc"] = true,						-- Arena calculator(/calc)
	["align"] = true,							-- Grid on screen(/align)
	["buff_automator"] = false,					-- Personal buff automator
	["switch_spec"] = false,					-- Talent spec panel
	["mark_bar"] = false,						-- Mark bar
	["color_picker"] = false,					-- Improved ColorPickerFrame
	["archaeology"] = false,					-- Archaeology artifacts and cooldown
	["skip_cinematic"] = false,					-- Skip cinematics/movies
	["disenchanting"] = false,					-- One-click Milling, Prospecting and Disenchanting
	["poison"] = false,							-- One-click poison enchant
	["item_level"] = true,						-- Item level on slot buttons
	["auto_role"] = false,						-- Auto set role
	["tab_binder"] = false,						-- Auto change Tab key to only target enemy players
	["explore_map"] = false,					-- Tracking completion of the Explorer and Lore Master achievements in WorldMap
	["map_boss_count"] = true,					-- Show boss count in WorldMap
	["instance_lock"] = false,					-- Your instance lock status in tooltip
	["item_transmogrify"] = true,				-- Displays items can not be transmogrified
	["healer_icon"] = true,						-- Show healer icon on all enemy healers nameplate in battlegrounds
	["damage_meter_spam"] = true,				-- Merge damage meter spam in one line-link
	["sum_buyouts"] = false,					-- Sum upp all current auctions
	["gem_counter"] = false,					-- Displays how many red/blue/yellow gems you have
	["cancel_bad_buffs"] = false,				-- Auto cancel various buffs
}

----------------------------------------------------------------------------------------
--	Chat options
----------------------------------------------------------------------------------------
C["extra_chat"] = {
	["nick_alert_enable"] = true,				-- Enable nick alert warning sound
	["nick_alert_names"] = {					-- Abbreviations and nicks of your name(full name of your character does not need to enter)
		UnitName("player"),						-- You do not need to make all the exact names of your characters
		--"YourNickOrName1",
		--"YourNickOrName2",
		--"YourNickOrName3",
	},
	["nick_alert_sound"] = "Sound\\Event Sounds\\Wisp\\WispPissed1.wav",
}

----------------------------------------------------------------------------------------
--	Announce options
----------------------------------------------------------------------------------------
C["extra_announce"] = {
	-- Battleground
	["battleground"] = false,					-- Battleground defence announce
	["battleground_two_row"] = true,			-- Two row for BG panel
	-- Flask and Food
	["flask_food"] = true,						-- Announce the usage of flasks and food
	["flask_food_auto"] = false,				-- Auto announce when ReadyCheck(if enable, announce to raid channel)
	["flask_food_raid"] = false,				-- Announce to raid channel
	-- Other
	["my_fps"] = false,							-- Announce fps in guild chat(!fps)
	["lightwell"] = false,						-- Announce your Lightwell
	["toy_train"] = false,						-- Announce Toy Train set
	["bad_tank"] = false,						-- Announce taunt from not tanks
	["says_thanks"] = false,					-- Says thanks for some spells
}

----------------------------------------------------------------------------------------
--	Extra Bars options
----------------------------------------------------------------------------------------
C["extra_bar"] = {
	-- ActionBar
	["enable"] = false,							-- Enable extra actionbar
	["show_grid"] = true,						-- Show empty action bar buttons
	["button_size"] = 30,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["style"] = "4*3",							-- Buttons style(1*12|12*1|6*2|4*3)
	["mouseover"] = false,						-- Show bar on mouseover
	-- MicroMenu
	["micro_menu"] = false,						-- Enable micro menu
	["micro_menu_mouse"] = false,				-- Micro menu on mouseover
}

----------------------------------------------------------------------------------------
--	Skins options(Maybe not work correctly!!!)
----------------------------------------------------------------------------------------
C["extra_skins"] = {
	["adibags"] = true,							-- AdiBags skin(Not Ready)
	["atlasloot"] = true,						-- AtlasLoot skin
	["blood_shield_tracker"] = true,			-- BloodShieldTracker skin
	["capping"] = true,							-- Capping skin
	["cool_line"] = true,						-- CoolLine skin
	["dominos"] = true,							-- Dominos skin(Not Ready)
	["epgp"] = true,							-- EPGP skin(Not Ready)
	["face_shooter"] = true,					-- FaceShooter skin
	["flyout_button"] = true,					-- FlyoutButtonCustom skin
	["mage_mana_bar"] = true,					-- MageManaBar skin
	["mage_nuggets"] = true,					-- MageNuggets skin
	["mfclip"] = true,							-- MFClip skin
	["mog_it"] = true,							-- MogIt skin(Not Ready)
	["my_role_play"] = true,					-- MyRolePlay skin
	["npcscan"] = true,							-- NPCScan skin
	["nug_running"] = true,						-- NugRunning skin
	["overachiever"] = true,					-- Overachiever skin(Not Ready)
	["preform_av"] = true,						-- PreformAVEnabler skin
	["roll_tracker"] = true,					-- RollTracker skin
	["shield_monitor"] = true,					-- ShieldMonitor skin
	["skada"] = true,							-- Skada skin(Not Ready)
	["tiny_dps"] = true,						-- TinyDPS skin
}

-- Edit by Oz of shestak.org --