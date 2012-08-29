local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI_Extra main configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	General options
----------------------------------------------------------------------------------------
C["extra_general"] = {
	["move_blizzard"] = true,					-- Move Blizzard frames
	["arena_calc"] = true,						-- Arena calculator(/calc)
	["align"] = true,							-- Grid on screen(/align)
	["buff_automator"] = false,					-- Personal buff automator
	["color_picker"] = false,					-- Improved ColorPickerFrame
	["archaeology"] = false,					-- Archaeology artifacts and cooldown
}

----------------------------------------------------------------------------------------
--	Announce options
----------------------------------------------------------------------------------------
C["extra_announce"] = {
	-- Nick Alert
	["nick_alert_enable"] = false,				-- Enable nick alert warning sound
	["nick_alert_names"] = {					-- Abbreviations and nicks of your name(full name of your character does not need to enter)
		UnitName("player"),						-- You do not need to make all the exact names of your characters
		--"YourNickOrName1",
		--"YourNickOrName2",
		--"YourNickOrName3",
	},
	-- Other
	["my_fps"] = false,							-- Announce fps in guild chat(!fps)
	["bad_tank"] = false,						-- Announce taunt from not tanks
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
	-- Battleground
	["battleground"] = false,					-- Battleground defence bar for for announce
	["battleground_two_row"] = true,			-- Two row for BG bar
	-- Other
	["mark_bar"] = false,						-- Mark bar
	["switch_spec"] = false,					-- Talent spec bar
}

----------------------------------------------------------------------------------------
--	Skins options(Maybe not work correctly!!!)
----------------------------------------------------------------------------------------
C["extra_skins"] = {
	["adibags"] = true,							-- AdiBags skin(Not Ready)
	["atlasloot"] = true,						-- AtlasLoot skin
	["capping"] = true,							-- Capping skin
	["cool_line"] = true,						-- CoolLine skin
	["epgp"] = true,							-- EPGP skin(Not Ready)
	["face_shooter"] = true,					-- FaceShooter skin
	["mage_mana_bar"] = true,					-- MageManaBar skin
	["mage_nuggets"] = true,					-- MageNuggets skin
	["mfclip"] = true,							-- MFClip skin
	["mog_it"] = true,							-- MogIt skin(Not Ready)
	["my_role_play"] = true,					-- MyRolePlay skin
	["npcscan"] = true,							-- NPCScan skin
	["overachiever"] = true,					-- Overachiever skin(Not Ready)
	["preform_av"] = true,						-- PreformAVEnabler skin
	["quartz"] = true,							-- Quartz skin(Not Ready)
	["roll_tracker"] = true,					-- RollTracker skin
	["shield_monitor"] = true,					-- ShieldMonitor skin
	["skada"] = true,							-- Skada skin(Not Ready)
	["tiny_dps"] = true,						-- TinyDPS skin
	["vanaskos"] = true,						-- VanasKoS skin(Not Ready)
}

-- edit by Oz of shestak. org --