local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	LiteStats configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
local cBN = IsAddOnLoaded("cargBags_Nivaya")
local ctab = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local function class(string)
	local color = ctab[T.class]
	return format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, string or "")
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
		AM = class"A", PM = class"P", colon = class":", -- These values apply to the displayed clock
		anchor_frame = "UIParent", anchor_to = "left", anchor_from = "bottomleft",
		x_off = 20, y_off = 11, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Latency = {
		enabled = C.stats.latency,
		fmt = "[color]%d|r"..class"ms", -- "77ms", [color] inserts latency color code
	 	anchor_frame = "Clock", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.clock and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Memory = {
		enabled = C.stats.memory,
		fmt_mb = "%.1f"..class"mb", -- "12.5mb"
		fmt_kb = "%.0f"..class"kb", -- "256kb"
		max_addons = nil, -- Holding Alt reveals hidden addons
		anchor_frame = C.stats.latency and "Latency" or "Clock", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	FPS = {
		enabled = C.stats.fps,
		fmt = "%d"..class"fps", -- "42fps"
		anchor_frame = C.stats.memory and "Memory" or "Latency", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Friends = {
		enabled = C.stats.friend,
		fmt = "%d/%d"..class"f", -- "3/40F"
		maxfriends = nil, -- Set max friends listed, nil means no limit
		anchor_frame = C.stats.fps and "FPS" or "Memory", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Guild = {
		enabled = C.stats.guild,
		fmt = "%d/%d"..class"g", -- "5/114G"
		maxguild = nil, -- Set max members listed, nil means no limit. Alt-key reveals hidden members
		threshold = 1, -- Minimum level displayed (1-90)
		show_xp = true, -- Show guild experience
		sorting = "class", -- Default roster sorting: name, level, class, zone, rank, note
		anchor_frame = "Friends", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.friend and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Durability = {
		enabled = C.stats.durability,
		fmt = "[color]%d|r%%"..class"d", -- "54%D", [color] inserts durability color code
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
		xp_normal_fmt = "[curxp]([cur%]%)"..class"XP", -- XP string used when not rested
		xp_rested_fmt = "[curxp]([cur%]%)"..class"XP ".." [restxp]([rest%]%)"..class"R", -- XP string used when rested
		played_fmt = class"Online: ".."|r".."[playedsession]", -- Played time format
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
		anchor_frame = "UIParent", anchor_to = "right", anchor_from = "bottomright",
		x_off = -17, y_off = 11
	},
	Location = {
		enabled = C.stats.location,
		subzone = true, -- Set to false to display the main zone's name instead of the subzone
		truncate = 0, -- Max number of letters for location text, set to 0 to disable
		coord_fmt = "%d,%d",
		anchor_frame = "Coords", anchor_to = "right", anchor_from = "left",
		x_off = C.stats.coords and -3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMRIGHT", tip_x = -21, tip_y = 20
	},
-- Top block
	Stats = {
		enabled = C.toppanel.enable,
			-- Available stat tags:
			--	Attack Power [ap]				Ranged Attack Power [rangedap]	Mastery% [mastery]			Expertise% [expertise]
			--	Melee Hit% [meleehit]			Ranged Hit% [rangedhit]			Spell Hit% [spellhit]		Melee Haste [meleehaste]
			--	Ranged Haste% [rangedhaste]		Spell Haste% [spellhaste]		Melee Crit% [meleecrit]		Ranged Crit% [rangedcrit]
			--	Spell Crit% [spellcrit]			Spellpower [spellpower]			Healing [healing]			MP5 [manaregen]
			--	Dodge% [dodge]					Parry% [parry]					Block% [block]				Avoidance% [avoidance]
			--	Armor Value [armor]				Resilience [resilience]
		spec1fmt = class"SP: ".."[healing]"..class"  Crit: ".."[spellcrit]%"..class"  Haste: ".."[spellhaste]%", -- Spec #1 string
		spec2fmt = class"SP: ".."[spellpower]"..class"  Crit: ".."[spellcrit]%"..class"  Hit: ".."[spellhit]%", -- Spec #2 string
		anchor_frame = "TopPanel", anchor_to = "center", anchor_from = "center",
		x_off = -20, y_off = 6,
	},
	Bags = {
		enabled = C.toppanel.enable,
		fmt = class"B: ".."%d/%d",
		anchor_frame = "Stats", anchor_to = "topleft", anchor_from = "bottomleft",
		x_off = 0, y_off = -5,
	},
	Helm = {
		enabled = C.toppanel.enable,
		fmt = class"H: ".."%s",
		anchor_frame = "Bags", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Cloak = {
		enabled = C.toppanel.enable,
		fmt = class"C: ".."%s",
		anchor_frame = "Helm", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Loot = {
		enabled = C.toppanel.enable,
		fmt = class"L: ".."%s",
		anchor_frame = "Cloak", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Nameplates = {
		enabled = C.toppanel.enable,
		fmt = class"N: ".."%s",
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
		anchor_frame = cBN and "NivayacBniv_Bag" or C.bag.enable and "StuffingFrameBags" or "Location",
		anchor_to = "right", anchor_from = cBN and "bottom" or C.bag.enable and "topright" or "left",
		x_off = cBN and 15 or C.bag.enable and -25 or -3,
		y_off = cBN and 8 or C.bag.enable and -13 or 0,
		tip_frame = cBN and "NivayacBniv_Bag" or C.bag.enable and "StuffingFrameBags" or "UIParent",
		tip_anchor = cBN and "TOPRIGHT" or C.bag.enable and "TOPRIGHT" or "BOTTOMRIGHT",
		tip_x = cBN and 0 or C.bag.enable and -50 or -21,
		tip_y = cBN and 85 or C.bag.enable and 0 or 20
	},
}

LPSTAT_PROFILES = {
	DEATHKNIGHT = {
		Stats = {
			spec1fmt = class"Mastery: ".."[mastery]%"..class"  Armor: ".."[armor]"..class"  Avoid: ".."[avoidance]%",
			spec2fmt = class"AP: ".."[ap]"..class"  Exp: ".."[expertise]%"..class"  Hit: ".."[meleehit]%",
		}
	},
	HUNTER = {
		Stats = {
			spec1fmt = class"AP: ".."[rangedap]"..class"  Crit: ".."[rangedcrit]%"..class"  Hit: ".."[rangedhit]%",
			spec2fmt = class"AP: ".."[rangedap]"..class"  Crit: ".."[rangedcrit]%"..class"  Hit: ".."[rangedhit]%",
		}
	},
	MAGE = {
		Stats = {
			spec1fmt = class"SP: ".."[spellpower]"..class"  Crit: ".."[spellcrit]%"..class"  Hit: ".."[spellhit]%",
			spec2fmt = class"SP: ".."[spellpower]"..class"  Crit: ".."[spellcrit]%"..class"  Hit: ".."[spellhit]%",
		}
	},
	MONK = {
		Stats = {
			spec1fmt = class"Mastery: ".."[mastery]%"..class"  Armor: ".."[armor]"..class"  Avoid: ".."[avoidance]%",
			spec2fmt = class"AP: ".."[ap]"..class"  Exp: ".."[expertise]%"..class"  Hit: ".."[meleehit]%",
		}
	},
	PALADIN = {
		Stats = {
			spec1fmt = class"Mastery: ".."[mastery]%"..class"  Block: ".."[block]%"..class"  Avoid: ".."[avoidance]%",
			spec2fmt = class"AP: ".."[ap]"..class"  Exp: ".."[expertise]%"..class"  Hit: ".."[meleehit]%",
		}
	},
	PRIEST = {
		Stats = {
			spec1fmt = class"SP: ".."[spellpower]"..class"  Crit: ".."[spellcrit]%"..class"  Hit: ".."[spellhit]%",
			spec2fmt = class"SP: ".."[spellpower]"..class"  Crit: ".."[spellcrit]%"..class"  Hit: ".."[spellhit]%",
		}
	},
	ROGUE = {
		Stats = {
			spec1fmt = class"AP: ".."[ap]"..class"  Exp: ".."[expertise]%"..class"  Hit: ".."[meleehit]%",
			spec2fmt = class"AP: ".."[ap]"..class"  Exp: ".."[expertise]%"..class"  Hit: ".."[meleehit]%",
		}
	},
	WARLOCK = {
		Stats = {
			spec1fmt = class"SP: ".."[spellpower]"..class"  Crit: ".."[spellcrit]%"..class"  Hit: ".."[spellhit]%",
			spec2fmt = class"SP: ".."[spellpower]"..class"  Crit: ".."[spellcrit]%"..class"  Hit: ".."[spellhit]%",
		}
	},
	WARRIOR = {
		Stats = {
			spec1fmt = class"Armor: ".."[armor]"..class"  Block: ".."[block]%"..class"  Avoid: ".."[avoidance]%",
			spec2fmt = class"AP: ".."[ap]"..class"  Crit: ".."[meleecrit]%"..class"  Hit: ".."[meleehit]%",
		}
	},
}