local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	LiteStats configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
local cBN = IsAddOnLoaded("cargBags_Nivaya")
local r, g, b = unpack(C.skins.color_theme)
local function theme(string)
	return format("|cff%02x%02x%02x%s|r", 255 * r, 255 * g, 255 * b, string or "")
end

LPSTAT_FONT = {
	font = C.font.stats_font,				-- Path to your font
	color = {1, 1, 1},						-- {red, green, blue} or "CLASS"
	size = C.font.stats_font_size,			-- Point font size
	alpha = 1,								-- Alpha transparency
	outline = 3,							-- Thin outline. 0 = no outline.
	shadow = {alpha = C.font.stats_font_shadow and 1 or 0, x = 1, y = -1},	-- Font shadow = 1
}

LTIPICONSIZE = 14							-- Icon sizes in info tips

LPSTAT_CONFIG = {
-- Bottomleft block
	Clock = {
		enabled = C.stats.clock, -- Local time and the 24 hour clock can be enabled in-game via time manager (right-click)
		AM = theme"A", PM = theme"P", colon = theme":", -- These values apply to the displayed clock
		anchor_frame = "UIParent", anchor_to = "left", anchor_from = "bottomleft",
		x_off = 20, y_off = 11, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Latency = {
		enabled = C.stats.latency,
		fmt = "[color]%d|r"..theme"ms", -- "77ms", [color] inserts latency color code
	 	anchor_frame = "UIParent", anchor_to = "right", anchor_from = "bottomright",
		x_off = -17, y_off = 11, tip_frame = "UIParent", tip_anchor = "BOTTOMRIGHT", tip_x = -21, tip_y = 20
	},
	Memory = {
		enabled = C.stats.memory,
		fmt_mb = "%.1f"..theme"mb", -- "12.5mb"
		fmt_kb = "%.0f"..theme"kb", -- "256kb"
		max_addons = nil, -- Holding Alt reveals hidden addons
		anchor_frame = C.stats.latency and "Latency", anchor_to = "right", anchor_from = "left",
		x_off = -3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMRIGHT", tip_x = -21, tip_y = 20
	},
	FPS = {
		enabled = C.stats.fps,
		fmt = "%d"..theme"fps", -- "42fps"
		anchor_frame = C.stats.memory and "Memory" or "Latency", anchor_to = "right", anchor_from = "left",
		x_off = -3, y_off = 0,
	},
	Friends = {
		enabled = C.stats.friend,
		fmt = "%d/%d"..theme"f", -- "3/40F"
		maxfriends = nil, -- Set max friends listed, nil means no limit
		anchor_frame = "Clock", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Guild = {
		enabled = C.stats.guild,
		fmt = "%d/%d"..theme"g", -- "5/114G"
		maxguild = nil, -- Set max members listed, nil means no limit. Alt-key reveals hidden members
		threshold = 1, -- Minimum level displayed (1-90)
		show_xp = true, -- Show guild experience
		sorting = "class", -- Default roster sorting: name, level, class, zone, rank, note
		anchor_frame = "Friends", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.friend and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Durability = {
		enabled = C.stats.durability,
		fmt = "[color]%d|r%%"..theme"d", -- "54%D", [color] inserts durability color code
		man = true, -- Hide bliz durability man
		ignore_inventory = false, -- Ignore inventory gear when auto-repairing
		gear_icons = false, -- Show your gear icons in the tooltip
		anchor_frame = "Guild", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.guild and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Experience = {
		enabled = C.stats.experience,
			-- Experience & Played tags:
			--	Player Level [level]
			--	Current XP [curxp]				Max XP [totalxp]				Current/Max% [cur%]
			--	Remaining XP [remainingxp]		Remaining% [remaining%]
			--	Session Gained [sessiongained]	Session Rate [sessionrate]		Session Time To Level [sessionttl]
			--	Level Rate [levelrate]			Level Time To Level [levelttl]
			--	Rested XP [rest]				Rested/Level% [rest%]
			--	Quests To Level [questsleft]	Kills To Level [killsleft]
			--	Total Played [playedtotal]		Level Played [playedlevel]		Session Played [playedsession]
		xp_normal_fmt = "[curxp]([cur%]%)"..theme"XP", -- XP string used when not rested
		xp_rested_fmt = "[curxp]([cur%]%)"..theme"XP ".." [restxp]([rest%]%)"..theme"R", -- XP string used when rested
		played_fmt = theme"Online: ".."|r".."[playedsession]", -- Played time format
		short = true, thousand = "k", million = "m", -- Short numbers ("4.5m" "355.3k")
			-- Faction tags:
			--	Faction name [repname]
			--	Standing Color Code [repcolor]	Standing Name [standing]
			--	Current Rep [currep]			Current Rep Percent [rep%]
			--	Rep Left [repleft]				Max. Rep [maxrep]
		faction_fmt = "[repname]: [repcolor][currep]/[maxrep]|r",
		faction_subs = {
		--	["An Very Long Rep Name"] = "Shortened",
			["The Wyrmrest Accord"] = "Wyrmrest",
			["Knights of the Ebon Blade"] = "Ebon Blade",
			["Клан Громового Молота"] = "Громовой Молот",
			["Защитники Тол Барада"] = "Тол Барад",
			["Гидраксианские Повелители Вод"] = "Повелители Вод",
		},
		anchor_frame = "Durability", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.durability and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
-- Bottomright block
	Coords = {
		enabled = C.stats.coords,
		fmt = "%d,%d",
		anchor_frame = "UIParent", anchor_to = "right", anchor_from = "topright",
		x_off = -17, y_off = -11
	},
	Location = {
		enabled = C.stats.location,
		subzone = true, -- Set to false to display the main zone's name instead of the subzone
		truncate = 0, -- Max number of letters for location text, set to 0 to disable
		coord_fmt = "%d,%d",
		anchor_frame = "Coords", anchor_to = "right", anchor_from = "left",
		x_off = C.stats.coords and -3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "TOPRIGHT", tip_x = -21, tip_y = -21
	},
-- Top block
	Stats = {
		enabled = C.toppanel.enable,
			-- Available stat tags:
			--	Power [power]	MP5 [manaregen]			Multistrike [strike]%	Block [block]%
			--	Haste [haste]%	Crit [crit]%			Mastery [mastery]%		Versatility [versatility]%
			--	Armor [armor]	Dodge [dodge]%			Parry [parry]%			Resilience [resilience]%
			--	Leech [leech]%	Avoidance [avoidance]%
		spec1fmt = theme"Power: ".."[power]"..theme"  Crit: ".."[crit]%"..theme"  Haste: ".."[haste]%", -- Spec #1 string
		spec2fmt = theme"Power: ".."[power]"..theme"  Crit: ".."[crit]%"..theme"  Haste: ".."[haste]%", -- Spec #2 string
		anchor_frame = "TopPanel", anchor_to = "center", anchor_from = "center",
		x_off = -20, y_off = 6,
	},
	Bags = {
		enabled = C.toppanel.enable,
		fmt = theme"B: ".."%d/%d",
		anchor_frame = "Stats", anchor_to = "topleft", anchor_from = "bottomleft",
		x_off = 0, y_off = -5,
	},
	Helm = {
		enabled = C.toppanel.enable,
		fmt = theme"H: ".."%s",
		anchor_frame = "Bags", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Cloak = {
		enabled = C.toppanel.enable,
		fmt = theme"C: ".."%s",
		anchor_frame = "Helm", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Loot = {
		enabled = C.toppanel.enable,
		fmt = theme"L: ".."%s",
		anchor_frame = "Cloak", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Nameplates = {
		enabled = C.toppanel.enable,
		fmt = theme"N: ".."%s",
		anchor_frame = "Loot", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Talents = {
		enabled = C.toppanel.enable,
		anchor_frame = "Stats", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_anchor = "ANCHOR_BOTTOMLEFT", tip_x = -3, tip_y = 13
	},
-- MiniMap block
	Ping = {
		enabled = true,
		fmt = "|cffff5555*|r %s |cffff5555*|r", -- "* PlayerName *"
		hide_self = true, -- Hide player's ping
		anchor_frame = "Minimap", anchor_to = "bottom", anchor_from = "bottom",
		x_off = 0, y_off = 25,
	},
-- Bags block
	Gold = {
		enabled = true,
		style = 1, -- Display styles: [1] 55g 21s 11c [2] 8829.4g [3] 823.55.94
		anchor_frame = cBN and "NivayacBniv_Bag" or C.bag.enable and "StuffingFrameBags" or "FPS",
		anchor_to = "bottomright", anchor_from = cBN and "bottomright" or C.bag.enable and "topright" or "left",
		x_off = cBN and -1 or C.bag.enable and -25 or -3,
		y_off = cBN and 18 or C.bag.enable and -13 or 0,
		tip_frame = cBN and "NivayacBniv_Bag" or C.bag.enable and "StuffingFrameBags" or "UIParent",
		tip_anchor = cBN and "TOPRIGHT" or C.bag.enable and "TOPRIGHT" or "BOTTOMRIGHT",
		tip_x = cBN and 0 or C.bag.enable and -50 or -21,
		tip_y = cBN and 85 or C.bag.enable and 0 or 20
	},
}

LPSTAT_PROFILES = {
	DEATHKNIGHT = {
		Stats = {
			spec1fmt = theme"Mastery: ".."[mastery]%"..theme"  Armor: ".."[armor]"..theme"  Avoid: ".."[avoidance]%",
			spec2fmt = theme"Power: ".."[power]"..theme"  Mastery: ".."[mastery]%"..theme"  Crit: ".."[crit]%",
		}
	},
	MONK = {
		Stats = {
			spec1fmt = theme"Mastery: ".."[mastery]%"..theme"  Armor: ".."[armor]"..theme"  Avoid: ".."[avoidance]%",
			spec2fmt = theme"Power: ".."[power]"..theme"  Mastery: ".."[mastery]%"..theme"  Crit: ".."[crit]%",
		}
	},
	PALADIN = {
		Stats = {
			spec1fmt = theme"Mastery: ".."[mastery]%"..theme"  Block: ".."[block]%"..theme"  Avoid: ".."[avoidance]%",
			spec2fmt = theme"Power: ".."[power]"..theme"  Mastery: ".."[mastery]%"..theme"  Crit: ".."[crit]%",
		}
	},
	ROGUE = {
		Stats = {
			spec1fmt = theme"Power: ".."[power]"..theme"  Mastery: ".."[mastery]%"..theme"  Crit: ".."[crit]%",
			spec2fmt = theme"Power: ".."[power]"..theme"  Mastery: ".."[mastery]%"..theme"  Crit: ".."[crit]%",
		}
	},
	WARRIOR = {
		Stats = {
			spec1fmt = theme"Armor: ".."[armor]"..theme"  Block: ".."[block]%"..theme"  Avoid: ".."[avoidance]%",
			spec2fmt = theme"Power: ".."[power]"..theme"  Crit: ".."[crit]%"..theme"  Crit: ".."[crit]%",
		}
	},
}