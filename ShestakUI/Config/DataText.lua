local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	LiteStats configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
LPSTAT_FONT = {
	font = C.font.stats_font,				-- Path to your font
	color = {1, 1, 1},						-- {red,green,blue} or "CLASS"
	size = C.font.stats_font_size,			-- Point font size
	alpha = 1,								-- Alpha transparency
	outline = 3,							-- Thin outline. 0 = no outline.
	shadow = {alpha=C.font.stats_font_shadow and 1 or 0, x=1, y=-1},	-- Font shadow = 1
}
LTIPICONSIZE = 11							-- Icon sizes in info tips

-- Player class coloring function for optional use with fmt strings config.
-- Example use: fmt = class"G:".." %d"..class"/".."%d" (colors "G:" and "/" and numbers retain the default text color)
-- Example2: fmt = class"%d".."fps" (colors the fps number and "fps" retains the default text color)
local ctab = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local function class(string)
	local color = ctab[select(2, UnitClass("player"))]
	return format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, string or "")
end

-- Modules Config. Note: omitting any variable will likely cause errors, check carefully when updating.
-- * More tip_anchor strings: http://www.wowwiki.com/API_GameTooltip_SetOwner
-- * To color any of your "fmt" strings, use hex format ("|cffFFFF55*string*|r") or the class format described above.
-- * You can start a new line by using "\n" in your format strings.
LPSTAT_CONFIG = {
-- Bottomleft block
	Clock = {
		enabled = C.stats.clock, -- Local time and the 24 hour clock can be enabled in-game via time manager (right-click)
		AM = "A", PM = "P", colon = ":", -- These values apply to the displayed clock.
		anchor_frame = "UIParent", anchor_to = "left", anchor_from = "bottomleft",
		x_off = 20, y_off = 11, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20,
		justify_h = "left",
	},
	Latency = {
		enabled = C.stats.latency,
		fmt = "[color]%d|r".."ms", -- "77ms", [color] inserts latency color code.
	 	anchor_frame = "Clock", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.clock and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Memory = {
		enabled = C.stats.memory,
		fmt_mb = "%.1f".."mb", -- "12.5mb"
		fmt_kb = "%.0f".."kb", -- "256kb" - only shows if memory is under one megabyte
		--max_addons = 15, -- Set to nil or comment/delete this line to disable. Holding Alt reveals hidden addons.
		anchor_frame = "Latency", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.latency and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	FPS = {
		enabled = C.stats.fps,
		fmt = "%d".."fps", -- "42fps"
		anchor_frame = "Memory", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.memory and 3 or 0, y_off = 0,
	},
	Friends = {
		enabled = C.stats.friend,
		fmt = "%d/%d".."f", -- "F: 3/40"
		maxfriends = nil, -- Set max friends listed, nil means no limit.
		anchor_frame = "FPS", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.fps and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Guild = {
		enabled = C.stats.guild,
		fmt = "%d/%d".."g", -- "G: 5/114"
		maxguild = nil, -- Set max members listed, nil means no limit. Alt-key reveals hidden members.
		threshold = 1, -- Minimum level displayed (1-80).
		show_xp = true, -- Show guild experience.
		sorting = "class", -- Default roster sorting: name, level, class, zone, rank, note.
		anchor_frame = "Friends", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.friend and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Durability = {
		enabled = C.stats.durability,
		fmt = "[color]%d|r%%".."d",-- "54%D" -- %% outputs %, [color] inserts durability color code.
		man = true, -- Hide bliz durability man.
		ignore_inventory = false, -- Ignore inventory gear when auto-repairing.
		gear_icons = false, -- Show your gear icons in the tooltip.
		anchor_frame = "Guild", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.guild and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Experience = {
		enabled = C.stats.experience,
			-- Experience & Played tags...
			--	Player Level [level]
			--	Current XP [curxp]				Max XP [totalxp]				Current/Max% [cur%]
			--	Remaining XP [remainingxp]		Remaining% [remaining%]
			--	Session Gained [sessiongained]	Session Rate [sessionrate]		Session Time To Level [sessionttl]
			--	Level Rate [levelrate]			Level Time To Level [levelttl]
			--	Rested XP [rest]				Rested/Level% [rest%]
			--	Quests To Level [questsleft]	Kills To Level [killsleft]
			--	Total Played [playedtotal]		Level Played [playedlevel]		Session Played [playedsession]
		xp_normal_fmt = "[curxp]([cur%]%)".."XP", -- XP string used when not rested.
		xp_rested_fmt = "[curxp]([cur%]%)".."XP ".." [restxp]([rest%]%)".."R", -- XP string used when rested.		
		played_fmt = "Online: ".."|r".."[playedsession]", -- Played time format.
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
			["Клан Громового Молота"] = "Громовой Молот",
			["Защитники Тол Барада"] = "Тол Барад",
			["Гидраксианские Повелители Вод"] = "Повелители Вод",
			["Комсомольский Авангард"] = "КМ",
		},
		anchor_frame = "Durability", anchor_to = "left", anchor_from = "right",
		x_off = C.stats.durability and 3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
-- Minimap block
	Coords = {
		enabled = C.stats.coords, -- Location tooltip has coords, this module is for displaying it as a separate stat.
		fmt = "%d,%d", -- "44,19"
		anchor_frame = "Minimap", anchor_to = "right", anchor_from = "topright",
		x_off = 3, y_off = -4, justify_h = "right",
	},
	Location = {
		enabled = C.stats.location,
		subzone = true, -- Set to false to display the main zone's name instead of the subzone.
		truncate = 16, -- Max number of letters for location text, set to 0 to disable.
		coord_fmt = "%d,%d", -- "44,19", to add tenths, use "%.1f" (digit determines decimal)
		anchor_frame = "Coords", anchor_to = "right", anchor_from = "left",
		x_off = C.stats.coords and -3 or 0, y_off = 0, tip_frame = "UIParent", tip_anchor = "TOPRIGHT", tip_x = -21, tip_y = -153
	},
-- Bottomright block 3
	Stats = {
		enabled = C.stats.bags,
			-- Available stat tags...
			--   Attack Power [ap]				Ranged Attack Power [rangedap]	Mastery [mastery]				Expertise% [expertise]
			--   Melee Hit% [meleehit]			Ranged Hit% [rangedhit]			Spell Hit% [spellhit]			Melee Haste [meleehaste]
			--   Ranged Haste% [rangedhaste]	Spell Haste% [spellhaste]		Melee Crit% [meleecrit]			Ranged Crit% [rangedcrit]
			--   Spell Crit% [spellcrit]		Spellpower [spellpower]			Healing [healing]
			--   Dodge% [dodge]					Parry% [parry]					Block% [block]					Combat table Coverage% [blockcap]
			--   Avoidance% [avoidance]			MP5 I5SR [manaregen]			Armor Value [armor]				Resilience [resilience]
		spec1fmt = "SP: ".."[healing]".."  Crit: ".."[spellcrit]%".."  Haste: ".."[spellhaste]%", -- Spec #1 string
		spec2fmt = "SP: ".."[spellpower]".."  Crit: ".."[spellcrit]%".."  Hit: ".."[spellhit]%", -- Spec #2 string
		anchor_frame = "Talents", anchor_to = "right", anchor_from = "left",
		x_off = 0, y_off = 0,
	},
-- Bottomright block 1
	Bags = {
		enabled = C.stats.bags,
		fmt = "B: ".."%d/%d", -- "B: 24/98"
		anchor_frame = "UIParent", anchor_to = "right", anchor_from = "bottomright",
		x_off = -16, y_off = 11, tip_frame = "UIParent", tip_anchor = "BOTTOMRIGHT", tip_x = 41, tip_y = 5,
		justify_h = "right",
	},
	-- Top block
	Helm = {
		enabled = C.toppanel.enable,
		fmt = "H: ".."%s", -- "Helm"
		anchor_frame = "TopPanel", anchor_to = "center", anchor_from = "center",
		x_off = -69, y_off = 0,
	},
	Cloak = {
		enabled = C.toppanel.enable,
		fmt = "C: ".."%s", -- "Cloak"
		anchor_frame = "Helm", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Loot = {
		enabled = C.toppanel.enable,
		fmt = "L: ".."%s", -- "Loot"
		anchor_frame = "Cloak", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Nameplates = {
		enabled = C.toppanel.enable,
		fmt = "N: ".."%s", -- "Nameplates"
		anchor_frame = "Loot", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
-- Bottomleft block 2
	Talents = {
		enabled = C.stats.bags,
		anchor_frame = "UIParent", anchor_to = "right", anchor_from = "bottomright",
		anchor_frame = "Bags", anchor_to = "right", anchor_from = "left", tip_frame = "UIParent", tip_anchor = "BOTTOMRIGHT", tip_x = 66, tip_y = 5,
		x_off = 0, y_off = 0,
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
		enabled = true,
		style = 1, -- Display styles: [1] 55g 21s 11c [2] 8829.4g [3] 823.55.94
		anchor_frame = C.bag.enable and "StuffingFrameBags" or "Location",
		anchor_to = "right", anchor_from = C.bag.enable and "topright" or "left",
		x_off = C.bag.enable and -25 or -9, y_off = C.bag.enable and -13 or 0,
		tip_frame = C.bag.enable and "StuffingFrameBags" or "UIParent",
		tip_anchor = C.bag.enable and "TOPRIGHT" or "BOTTOMRIGHT",
		tip_x = C.bag.enable and -50 or -21, tip_y = C.bag.enable and 0 or 20
	},
}

LPSTAT_PROFILES = {
	DEATHKNIGHT = {
		Stats = {
			spec1fmt = "SP: ".."[spellpower]".." Crit: ".."[spellcrit]%".." Hit: ".."[spellhit]%",
			spec2fmt = "SP: ".."[spellpower]".." Crit: ".."[spellcrit]%".." Hit: ".."[spellhit]%",
		}
	},
	HUNTER = {
		Stats = {
			spec1fmt = "AP: ".."[rangedap]".." Crit: ".."[rangedcrit]%".." Hit: ".."[rangedhit]%",
			spec2fmt = "AP: ".."[rangedap]".." Crit: ".."[rangedcrit]%".." Hit: ".."[rangedhit]%",
		}
	},
	MAGE = {
		Stats = {
			spec1fmt = "SP: ".."[spellpower]".." Crit: ".."[spellcrit]%".." Hit: ".."[spellhit]%",
			spec2fmt = "SP: ".."[spellpower]".." Crit: ".."[spellcrit]%".." Hit: ".."[spellhit]%",
		}
	},
	PALADIN = {
		Stats = {
			spec1fmt = "Mastery: ".."[mastery]".." BlockCap: ".."[blockcap]%".." Avoid: ".."[avoidance]%",
			spec1fmt = "Mastery: ".."[mastery]".." BlockCap: ".."[blockcap]%".." Avoid: ".."[avoidance]%",
		}
	},
	PRIEST = {
		Stats = {
			spec1fmt = "SP: ".."[spellpower]".." Crit: ".."[spellcrit]%".." Hit: ".."[spellhit]%",
			spec2fmt = "SP: ".."[spellpower]".." Crit: ".."[spellcrit]%".." Hit: ".."[spellhit]%",
		}
	},
	ROGUE = {
		Stats = {
			spec1fmt = "AP: ".."[ap]".." Exp: ".."[expertise]%".." Hit: ".."[meleehit]%",
			spec2fmt = "AP: ".."[ap]".." Exp: ".."[expertise]%".." Hit: ".."[meleehit]%",
		}
	},
	WARLOCK = {
		Stats = {
			spec1fmt = "SP: ".."[spellpower]".." Crit: ".."[spellcrit]%".." Hit: ".."[spellhit]%",
			spec2fmt = "SP: ".."[spellpower]".." Crit: ".."[spellcrit]%".." Hit: ".."[spellhit]%",
		}
	},
	WARRIOR = {
		Stats = {
			spec1fmt = "Mastery: ".."[mastery]".." Armor: ".."[armor]".." Avoid: ".."[avoidance]%",
			spec2fmt = "Mastery: ".."[mastery]".." Hit: ".."[meleehit]%".." Haste: ".."[meleehaste]%",
		}
	},
}

-- edit by Oz of shestak. org --