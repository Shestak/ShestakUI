----------------------------------------------------------------------------------------
--	LiteStats configuration file
--	BACKUP YOUR CHANGES TO THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------

LPSTAT_FONT = {
	font = SettingsCF.font.stats_font,		-- Path to your font
	color = {1, 1, 1},						-- {red,green,blue} or "CLASS"
	size = SettingsCF.font.stats_font_size,	-- Point font size
	alpha = 1,								-- Alpha transparency
	outline = 3,							-- Thin outline. 0 = no outline.
	shadow = {alpha=SettingsCF.font.stats_font_shadow and 1 or 0, x=1, y=-1},			-- Font shadow = 1
}
LTIPICONSIZE = 12							-- Icon sizes in info tips
HIDE_IN_COMBAT = false						-- Enable in-combat hiding for all texts

-- Player class coloring function for optional use with fmt strings config.
-- Example use: fmt = class'G:'.." %d"..class'/'.."%d" (colors 'G:' and '/' and numbers retain the default text color)
-- Example2: fmt = class'%d'.."fps" (colors the fps number and "fps" retains the default text color)
local ctab = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local function class(string)
	local color = ctab[select(2,UnitClass'player')]
	return format("|cff%02x%02x%02x%s|r",color.r*255,color.g*255,color.b*255,string or '')
end

-- Modules Config. Note: omitting any variable will likely cause errors, check carefully when updating.
-- * More tip_anchor strings: http://www.wowwiki.com/API_GameTooltip_SetOwner
-- * To color any of your 'fmt' strings, use hex format ("|cffFFFF55*string*|r") or the class format described above.
-- * You can start a new line by using '\n' in your format strings.
LPSTAT_CONFIG = {
-- Bottomleft block
	Clock = {
		enabled = SettingsCF.stats.clock, -- Local time and the 24 hour clock can be enabled in-game via time manager (right-click)
		AM = class"A", PM = class"P", colon = class":", -- These values apply to the displayed clock.
		anchor_frame = "UIParent", anchor_to = "left", anchor_from = "bottomleft",
		x_off = 20, y_off = 11, tip_anchor = "ANCHOR_TOPLEFT", tip_x = 1, tip_y = 5,
		justify_h = "left",
	},
	Latency = {
		enabled = SettingsCF.stats.latency,
		fmt = "[color]%d|r"..class"ms", -- "77ms", [color] inserts latency color code.
	 	anchor_frame = "Clock", anchor_to = "left", anchor_from = "right",
		x_off = SettingsCF.stats.clock and 3 or 0, y_off = 0,
	},
	Memory = {
		enabled = SettingsCF.stats.memory,
		fmt_mb = "%.1f"..class"mb", -- "12.5mb"
		fmt_kb = "%.0f"..class"kb", -- "256kb" - only shows if memory is under one megabyte
		--max_addons = 15, -- Set to nil or comment/delete this line to disable. Holding Alt reveals hidden addons.
		anchor_frame = "Latency", anchor_to = "left", anchor_from = "right",
		x_off = SettingsCF.stats.latency and 3 or 0, y_off = 0, tip_anchor = "ANCHOR_TOPRIGHT", tip_x = 0, tip_y = 5
	},
	FPS = {
		enabled = SettingsCF.stats.fps,
		fmt = "%d"..class"fps", -- "42fps"
		anchor_frame = "Memory", anchor_to = "left", anchor_from = "right",
		x_off = SettingsCF.stats.memory and 3 or 0, y_off = 0,
	},
	Experience = {
		enabled = SettingsCF.stats.experience,
			-- Experience & Played tags...
			--	Player Level [level]
			--	Current XP [curxp]				Max XP [totalxp]				Current/Max% [cur%]
			--	Remaining XP [remainingxp]		Remaining% [remaining%]
			--	Session Gained [sessiongained]	Session Rate [sessionrate]		Session Time To Level [sessionttl]
			--	Level Rate [levelrate]			Level Time To Level [levelttl]
			--	Rested XP [rest]				Rested/Level% [rest%]
			--	Quests To Level [questsleft]	Kills To Level [killsleft]
			--	Total Played [playedtotal]		Level Played [playedlevel]		Session Played [playedsession]
		xp_normal_fmt = "[cur%]%"..class"XP", -- XP string used when not rested.
		xp_rested_fmt = "[cur%]%"..class"XP ".."[rest%]%"..class"R", -- XP string used when rested.		
		played_fmt = class"Online: ".."|r".."[playedsession]", -- Played time format.
		short = true, thousand = "k", million = "m", -- Short numbers ("4.5m" "355.3k")		
			-- day = "d", hour = "h", minute = "m", second = "s", -- Customizable time labels. Will localize by default.
			-- Faction tags...
			--	Faction name [repname]
			--	Standing Color Code [repcolor]	Standing Name [standing]
			--	Current Rep [currep]			Current Rep Percent [rep%]
			--	Rep Left [repleft]				Max. Rep [maxrep]
		faction_fmt = "[repname]: [repcolor][currep]/[maxrep]|r",
		faction_subs = {
		--	["An Very Long Rep Name"] = "Shortened",
			["The Wyrmrest Accord"] = "Wyrmrest",
			["Knights of the Ebon Blade"] = "Ebon Blade",
		},
		anchor_frame = "FPS", anchor_to = "left", anchor_from = "right",
		x_off = SettingsCF.stats.fps and 3 or 0, y_off = 0, tip_anchor = "ANCHOR_TOPRIGHT", tip_x = 0, tip_y = 5
	},
-- Bottomright block
	Coords = {
		enabled = SettingsCF.stats.coords, -- Location tooltip has coords, this module is for displaying it as a separate stat.
		fmt = "%d,%d", -- "44,19"
		anchor_frame = "UIParent", anchor_to = "right", anchor_from = "bottomright",
		x_off = -17, y_off = 11, justify_h = "right",
	},
	Location = {
		enabled = SettingsCF.stats.location,
		subzone = true, -- Set to false to display the main zone's name instead of the subzone.
		truncate = 0, -- Max number of letters for location text, set to 0 to disable.
		coord_fmt = "%d,%d", -- "44,19", to add tenths, use '%.1f' (digit determines decimal)
		anchor_frame = "Coords", anchor_to = "right", anchor_from = "left",
		x_off = SettingsCF.stats.coords and -3 or 0, y_off = 0, tip_anchor = "ANCHOR_TOPRIGHT", tip_x = 0, tip_y = 5
	},
-- Top block
	Friends = {
		enabled = SettingsCF["toppanel"].enable,
		fmt = class"F: ".."%d/%d", -- "F: 3/40"
		maxfriends = nil, -- Set max friends listed, nil means no limit.
		anchor_frame = "StatContainer", anchor_to = "center", anchor_from = "left",
		x_off = 35, y_off = 6, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = -6
	},
	Guild = {
		enabled = SettingsCF["toppanel"].enable,
		fmt = class"G: ".."%d/%d", -- "G: 5/114"
		maxguild = nil, -- Set max members listed, nil means no limit. Alt-key reveals hidden members.
		threshold = 1, -- Minimum level displayed (1-80).
		sorting = "class", -- Default roster sorting: name, level, class, zone, rank, note.
		anchor_frame = "Friends", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = -6
	},
	Durability = {
		enabled = SettingsCF["toppanel"].enable,
		fmt = class"D: ".."[color]%d|r%%",-- "54%D" -- %% outputs %, [color] inserts durability color code.
		man = true, -- Hide bliz durability man.
		gfunds = SettingsCF.stats.guild_repair, -- Change to false to disable guild repairing.
		ignore_inventory = false, -- Ignore inventory gear when auto-repairing.
		gear_icons = false, -- Show your gear icons in the tooltip.
		anchor_frame = "Guild", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = -6
	},
	Stats = {
		enabled = SettingsCF["toppanel"].enable,
			-- Available stat tags...
			--   Attack Power [ap]				Ranged Attack Power [rangedap]	Armor Penetration% [armorpen]	Expertise% [expertise]
			--   Melee Hit% [meleehit]			Ranged Hit% [rangedhit]			Spell Hit% [spellhit]			Melee Haste [meleehaste]
			--   Ranged Haste% [rangedhaste]	Spell Haste% [spellhaste]		Melee Crit% [meleecrit]			Ranged Crit% [rangedcrit]
			--   Spell Crit% [spellcrit]		Spellpower [spellpower]			Healing [healing]				Spell Pen [spellpen]
			--   Dodge% [dodge]					Parry% [parry]					Block% [block]					Defense Rating [defense]
			--   Avoidance% [avoidance]			MP5 I5SR [manaregen]			Armor Value [armor]				Resilience [resilience]
		spec1fmt = class"SP: ".."[healing]"..class"  Crit: ".."[spellcrit]%"..class"  Haste: ".."[spellhaste]%", -- Spec #1 string
		spec2fmt = class"SP: ".."[spellpower]"..class"  Crit: ".."[spellcrit]%"..class"  Hit: ".."[spellhit]%", -- Spec #2 string
		anchor_frame = "Durability", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Bags = {
		enabled = SettingsCF["toppanel"].enable,
		fmt = class"B: ".."%d/%d", -- "B: 24/98"
		anchor_frame = "Friends", anchor_to = "topleft", anchor_from = "bottomleft",
		x_off = 0, y_off = -5,
	},
	-- New block
	Helm = {
		enabled = SettingsCF["toppanel"].enable,
		fmt = class"H: ".."%s", -- "Helm"
		anchor_frame = "Bags", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Cloak = {
		enabled = SettingsCF["toppanel"].enable,
		fmt = class"C: ".."%s", -- "Cloak"
		anchor_frame = "Helm", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Loot = {
		enabled = SettingsCF["toppanel"].enable,
		fmt = class"L: ".."%s", -- "Loot"
		anchor_frame = "Cloak", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Talents = {
		enabled = SettingsCF["toppanel"].enable,
		fmt = class"T: ".."[spec %d/%d/%d] [unspent]", -- "Protection: 15/0/51 +5", [shortname] shortens spec name.
		iconsize = 15,  -- Size of talent [icon].
		name_subs = { -- Substitutions for long talent tree names, remove and/or change any/all.
			["Protection"] = "Prot.",
			["Restoration"] = "Resto.",
			["Feral Combat"] = "Feral",
			["Retribution"] = "Ret.",
			["Discipline"] = "Disc.",
			["Enhancement"] = "Enhance.",
			["Elemental"] = "Ele.",
			["Demonology"] = "Demon.",
			["Destruction"] = "Destro.",
			["Assassination"] = "Assassin.",
			["Marksmanship"] = "Marks.",
			["Beast Mastery"] = "B.M.",
		},
		anchor_frame = "Loot", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = 0, tip_y = -6
	},
-- MiniMap block
	Ping = {
		enabled = true,
		fmt = "|cffff5555*|r %s |cffff5555*|r", -- "* Katae *"
		hide_self = false, -- Hide player's ping.
		anchor_frame = "Minimap", anchor_to = "bottom", anchor_from = "bottom",
		x_off = 0, y_off = 25,
	},
-- Bags block
	Gold = {
		enabled = true, -- To clear all money data: /script for _,t in pairs(LPSTAT) do if type(t)=='table' then t.Gold = nil end end
		style = 1, -- Display styles: [1] 55g 21s 11c [2] 8829.4g [3] 823.55.94
		anchor_frame = "StuffingFrameBags", anchor_to = "right", anchor_from = "topright",
		x_off = -25, y_off = -15, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = -3, tip_y = 7
	},
}

LPSTAT_PROFILES = {
	MAGE = { 
		Stats = { 
			spec1fmt = class"SP: ".."[spellpower]"..class" Crit: ".."[spellcrit]%"..class" Hit:".."[spellhit]%",
			spec2fmt = class"SP: ".."[spellpower]"..class" Crit: ".."[spellcrit]%"..class" Hit:".."[spellhit]%",
		}
	},
	PRIEST = { 
		Stats = {
			spec1fmt = class"SP: ".."[spellpower]"..class" Crit: ".."[spellcrit]%"..class" Hit:".."[spellhit]%",
			spec2fmt = class"SP: ".."[spellpower]"..class" Crit: ".."[spellcrit]%"..class" Hit:".."[spellhit]%",
		}
	},
	WARLOCK = { 
		Stats = {
			spec1fmt = class"SP: ".."[spellpower]"..class" Crit: ".."[spellcrit]%"..class" Hit:".."[spellhit]%",
			spec2fmt = class"SP: ".."[spellpower]"..class" Crit: ".."[spellcrit]%"..class" Hit:".."[spellhit]%",
		}
	},
	HUNTER = {
		Stats = {
			spec1fmt = class"AP: ".."[rangedap]"..class" Crit: ".."[rangedcrit]%"..class" Hit:".."[rangedhit]%",
			spec2fmt = class"AP: ".."[rangedap]"..class" Crit: ".."[rangedcrit]%"..class" Hit:".."[rangedhit]%",
		}
	},
	ROGUE = {
		Stats = {
			spec1fmt = class"AP: ".."[ap]"..class" ArP: ".."[armorpen]%"..class" Exp:".."[expertise]%",
			spec2fmt = class"AP: ".."[ap]"..class" ArP: ".."[armorpen]%"..class" Exp:".."[expertise]%",
		}
	},
	WARRIOR = {
		Stats = { 
			spec1fmt = class"Def: ".."[defense]"..class" Armor: ".."[armor]"..class" Avoid:".."[avoidance]%",
			spec2fmt = class"AP: ".."[ap]"..class" Crit: ".."[meleecrit]%"..class" Hit:".."[meleehit]%",
		}
	},
}