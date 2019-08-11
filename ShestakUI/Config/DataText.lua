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
	FPS = {
		enabled = C.stats.fps,
		fmt = "%d"..class"fps", -- "42fps"
		max_addons = nil, -- Holding Alt reveals hidden addons
		anchor_frame = C.stats.latency and "Latency" or "Clock", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Friends = {
		enabled = C.stats.friend,
		fmt = "%d/%d"..class"f", -- "3/40F"
		maxfriends = nil, -- Set max friends listed, nil means no limit
		anchor_frame = C.stats.fps and "FPS" or C.stats.latency and "Latency" or "Clock", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Guild = {
		enabled = C.stats.guild,
		fmt = "%d/%d"..class"g", -- "5/114G"
		maxguild = nil, -- Set max members listed, nil means no limit. Alt-key reveals hidden members
		threshold = 1, -- Minimum level displayed (1-90)
		show_xp = true, -- Show guild experience
		sorting = "class", -- Default roster sorting: name, level, class, zone, rank, note
		anchor_frame = C.stats.friend and "Friends" or C.stats.fps and "FPS" or C.stats.latency and "Latency" or "Clock", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Durability = {
		enabled = C.stats.durability,
		fmt = "[color]%d|r%%"..class"d", -- "54%D", [color] inserts durability color code
		man = true, -- Hide bliz durability man
		ignore_inventory = false, -- Ignore inventory gear when auto-repairing
		gear_icons = false, -- Show your gear icons in the tooltip
		anchor_frame = C.stats.guild and "Guild" or C.stats.friend and "Friends" or C.stats.fps and "FPS" or C.stats.latency and "Latency" or "Clock", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
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
		short = true, thousand = "k", million = "m", billion = "b", -- Short numbers ("4.5m" "355.3k")
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
		artifact_fmt = "[curart]([curart%]%)"..class"AP", -- Artifact power format
		anchor_frame = C.stats.durability and "Durability" or C.stats.guild and "Guild" or C.stats.friend and "Friends" or C.stats.fps and "FPS" or C.stats.latency and "Latency" or "Clock", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
	},
	Talents = {
		enabled = C.stats.talents,
		anchor_frame = C.stats.experience and "Experience" or C.stats.durability and "Durability" or C.stats.guild and "Guild" or C.stats.friend and "Friends" or C.stats.fps and "FPS" or C.stats.latency and "Latency" or "Clock", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0, tip_frame = "UIParent", tip_anchor = "BOTTOMLEFT", tip_x = 21, tip_y = 20
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
			--	Power [power]	MP5 [manaregen]			Block [block]%			Avoidance [avoidance]%
			--	Haste [haste]%	Crit [crit]%			Mastery [mastery]%		Versatility [versatility]%
			--	Armor [armor]	Dodge [dodge]%			Parry [parry]%			Resilience [resilience]%
			--	Leech [leech]%
		spec1fmt = class"Power: ".."[power]"..class"  Crit: ".."[crit]%"..class"  Haste: ".."[haste]%", -- Spec #1 string
		spec2fmt = class"Power: ".."[power]"..class"  Crit: ".."[crit]%"..class"  Haste: ".."[haste]%", -- Spec #2 string
		spec3fmt = class"Power: ".."[power]"..class"  Crit: ".."[crit]%"..class"  Haste: ".."[haste]%", -- Spec #3 string
		spec4fmt = class"Power: ".."[power]"..class"  Crit: ".."[crit]%"..class"  Haste: ".."[haste]%", -- Spec #4 string
		anchor_frame = "TopPanel", anchor_to = "center", anchor_from = "center",
		x_off = 0, y_off = 6,
	},
	Bags = {
		enabled = C.toppanel.enable,
		fmt = class"B: ".."%d/%d",
		anchor_frame = "Stats", anchor_to = "topleft", anchor_from = "bottomleft",
		x_off = 20, y_off = -5,
	},
	Loot = {
		enabled = C.toppanel.enable,
		fmt = class"L: ".."%s",
		anchor_frame = "Bags", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
	},
	Nameplates = {
		enabled = C.toppanel.enable,
		fmt = class"N: ".."%s",
		anchor_frame = "Loot", anchor_to = "left", anchor_from = "right",
		x_off = 3, y_off = 0,
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
		style = 1, -- Display styles: [1] 55g 21s 11c [2] 8829.4g [3] 823.55.94 [4] with texture
		anchor_frame = cBN and "NivayacBniv_Bag" or C.bag.enable and "StuffingFrameBags" or "Location",
		anchor_to = "right", anchor_from = cBN and "bottom" or C.bag.enable and "topright" or "left",
		x_off = cBN and 15 or C.bag.enable and -25 or -3,
		y_off = cBN and 8 or C.bag.enable and -13 or 0,
		tip_frame = cBN and "NivayacBniv_Bag" or C.bag.enable and "StuffingFrameBags" or "UIParent",
		tip_anchor = cBN and "TOPRIGHT" or C.bag.enable and "TOPRIGHT" or "BOTTOMRIGHT",
		tip_x = cBN and 0 or C.bag.enable and -50 or -21,
		tip_y = cBN and 85 or C.bag.enable and 0 or 20,
		strata = cBN and "DIALOG" or "MEDIUM"
	},
}

LPSTAT_PROFILES = {
	-- Main stats like agil, str > power. Stamina and bonus armor not listed even if higher pri then other stats. This is not a guide, just a pointer!
	DEATHKNIGHT = {
		Stats = {
			spec1fmt = class"Armor: ".."[armor]"..class" Mastery: ".."[mastery]%"..class"  Vers: ".."[versatility]%", --Blood 				-> Stamina > Bonus Armor = Armor > Strength > Versatility >= Haste > Mastery > Crit
			spec2fmt = class"Power: ".."[power]"..class" Mastery: ".."[mastery]%"..class"  Vers: ".."[versatility]%", -- Frost 				-> Strength > Mastery > Haste > Versatility > Crit
			spec3fmt = class"Power: ".."[power]"..class" Vers: ".."[versatility]%"..class" Mastery: ".."[mastery]%", --Unholy 				-> Strength > Mastery > Crit >= Haste > Versatility
		}
	},
	DRUID = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class" Mastery: ".."[mastery]%"..class"  Vers: ".."[versatility]%", --Balance 			-> Intellect > Mastery >= Crit >= Haste > Versatility
			spec2fmt = class"Power: ".."[power]"..class" Crit: ".."[crit]%"..class"  Haste: ".."[haste]%", -- Feral 					-> Agility > Crit > Versatility >= Haste > Mastery
			spec3fmt = class"Armor: ".."[armor]"..class" Vers: ".."[versatility]%"..class" Mastery: ".."[mastery]%", --Guardian 			-> Armor > Stamina > Bonus Armor > Mastery > Versatility >= Agility = Haste > Crit
			spec4fmt = class"Power: ".."[power]"..class" Haste: ".."[haste]%"..class" Mastery: ".."[mastery]%", --Restoration 			-> Intellect > Haste > Mastery > Crit > Versatility > Spirit
		}
	},
	HUNTER = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class" Mastery: ".."[mastery]%"..class"  Haste: ".."[haste]%", --Beast Mastery		-> Agility > Haste = Mastery > Crit > Versatility
			spec2fmt = class"Power: ".."[power]"..class" Vers: ".."[versatility]%"..class"  Crit: ".."[crit]%", -- Marksmanship				-> Agility > Crit > Mastery >= Versatility >= Haste
			spec3fmt = class"Power: ".."[power]"..class" Vers: ".."[versatility]%"..class"  Crit: ".."[crit]%", --Survival					-> Agility > Crit >= Versatility > Mastery > Haste
		}
	},
	MAGE = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class" Mastery: ".."[mastery]%"..class" Haste: ".."[haste]%", --Arcane				-> Intellect > Mastery >= Haste >= Crit > Versatility
			spec2fmt = class"Power: ".."[power]"..class" Crit: ".."[crit]%"..class" Mastery: ".."[mastery]%", -- Fire					-> Intellect > Crit > Mastery >= Haste > Versatility
			spec3fmt = class"Power: ".."[power]"..class" Vers: ".."[versatility]%"..class" Crit: ".."[crit]%", --Frost						-> Intellect > Crit > Versatility > Haste > Mastery
		}
	},
	MONK = {
		Stats = {
			spec1fmt = class"Armor: ".."[armor]"..class" Mastery: ".."[mastery]%"..class" Vers: ".."[versatility]%", --Brewmaster		-> Stamina > Armor > Bonus Armor > Mastery > Versatility >= Agility > Crit > Haste
			spec2fmt = class"Power: ".."[power]"..class" Vers: ".."[versatility]%"..class" Crit: ".."[crit]%", -- Mistweaver				-> Intellect > Crit > Versatility > Haste > Mastery > Spirit
			spec3fmt = class"Power: ".."[power]"..class" Crit: ".."[crit]%"..class" Vers: ".."[versatility]%", --Windwalker					-> Agility > Crit > Versatility >= Haste > Mastery
		}
	},
	PALADIN = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class" Crit: ".."[crit]%"..class" Vers: ".."[versatility]%", -- Holy						-> Intellect > Crit > Mastery > Versatility > Haste > Spirit
			spec2fmt = class"Armor: ".."[armor]"..class" Haste: ".."[haste]%"..class" Vers: ".."[versatility]%", -- Protection			-> Stamina > Bonus Armor > Armor > Haste >= Versatility >= Strength >= Mastery > Crit
			spec3fmt = class"Power: ".."[power]"..class" Mastery: ".."[mastery]%"..class" Vers: ".."[versatility]%", -- Retribution			-> Strength > Mastery > Crit >= Versatility > Haste
		}
	},
	PRIEST = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class" Crit: ".."[crit]%"..class" Mastery: ".."[mastery]%", -- Discipline				-> Intellect > Crit > Mastery > Versatility > Haste > Spirit
			spec2fmt = class"Power: ".."[power]"..class" Vers: ".."[versatility]%"..class" Mastery: ".."[mastery]%", -- Holy				-> Intellect > Mastery > Crit > Versatility > Haste > Spirit
			spec3fmt = class"Power: ".."[power]"..class" Haste: ".."[haste]%"..class" Mastery: ".."[mastery]%", -- Shadow				-> Intellect > Haste >= Mastery > Crit > Versatility
		}
	},
	ROGUE = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class" Crit: ".."[crit]%"..class" Vers: ".."[versatility]%", -- Assassination				-> Agility > Crit > Mastery >= Haste = Versatility
			spec2fmt = class"Power: ".."[power]"..class" Haste: ".."[haste]%"..class" Vers: ".."[versatility]%", -- Combat					-> Agility > Haste > Crit >= Mastery >= Versatility
			spec3fmt = class"Power: ".."[power]"..class" Vers: ".."[versatility]%"..class" Mastery: ".."[mastery]%", -- Subtlety			-> Agility > Mastery > Versatility = Crit >= Haste
		}
	},
	SHAMAN = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class" Vers: ".."[versatility]%"..class" Haste: ".."[haste]%", -- Elemental				-> Intellect > Haste > Crit > Versatility > Mastery
			spec2fmt = class"Power: ".."[power]"..class" Haste: ".."[haste]%"..class" Vers: ".."[versatility]%", -- Enhancement				-> Agility > Haste > Mastery > Versatility = Crit
			spec3fmt = class"Power: ".."[power]"..class" Crit: ".."[crit]%"..class" Mastery: ".."[mastery]%", -- Restoration			-> Intellect > Crit > Mastery > Versatility > Haste > Spirit
		}
	},
	WARLOCK = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class"  Haste: ".."[haste]%"..class"  Mastery: ".."[mastery]%", -- Affliction			-> Intellect > Haste > Mastery > Crit > Versatility
			spec2fmt = class"Power: ".."[power]"..class"  Haste: ".."[haste]%"..class"  Mastery: ".."[mastery]%", -- Demonology			-> Intellect > Haste > Mastery > Crit > Versatility
			spec3fmt = class"Power: ".."[power]"..class"  Crit: ".."[crit]%"..class"  Vers: ".."[versatility]%", -- Destruction				-> Intellect > Crit > Haste > Mastery >= Versatility
		}
	},
	WARRIOR = {
		Stats = {
			spec1fmt = class"Power: ".."[power]"..class"  Crit: ".."[crit]%"..class"  Vers: ".."[versatility]%", -- Arms					-> Strength > Crit > Haste > Versatility >= Mastery
			spec2fmt = class"Power: ".."[power]"..class"  Crit: ".."[crit]%"..class"  Haste: ".."[haste]%", -- Fury						-> Strength > Crit > Haste > Mastery > Versatility
			spec3fmt = class"Armor: ".."[armor]"..class"  Vers: ".."[versatility]%"..class"  Crit: ".."[crit]%", -- Protection			-> Stamina > Bonus Armor >= Armor > Versatility > Strength > Crit >= Mastery > Haste
		}
	},
}
