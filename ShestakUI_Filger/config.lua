Filger_Settings = {
	configmode = false,
}

Filger_Spells = {
	["DRUID"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- Lifebloom
			{ spellID = 33763, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Rejuvenation
			{ spellID = 774, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Regrowth
			{ spellID = 8936, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Savage roar
			{ spellID = 52610, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Barkskin
			{ spellID = 22812, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Survival Instincts
			{ spellID = 61336, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tree of Life
			{ spellID = 33891, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Moonfire
			{ spellID = 8921, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sunfire
			{ spellID = 93402, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Insect Swarm
			{ spellID = 5570, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Faerie Fire
			{ spellID = 770, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots
			{ spellID = 339, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Earth and Moon
			{ spellID = 48506, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Rake
			{ spellID = 1822, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Rip
			{ spellID = 1079, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Lacerate
			{ spellID = 33745, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Pounce Bleed
			{ spellID = 9007, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Mangle
			{ spellID = 33876, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Eclipse (Lunar)
			{ spellID = 48518, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Eclipse (Solar)
			{ spellID = 48517, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shooting Stars
			{ spellID = 93400, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 16870, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Siphoned Power
			{ spellID = 71636, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Cultivated Power
			{ spellID = 71572, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hardened Skin
			{ spellID = 71586, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "BOTTOMLEFT", SettingsCF["unitframe"].portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", SettingsCF["unitframe"].portrait_enable and 3 or 9, SettingsCF["unitframe"].portrait_enable and 0 or -41 },
			
			-- Lifebloom
			{ spellID = 33763, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Rejuvenation
			{ spellID = 774, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Regrowth
			{ spellID = 8936, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Wild Growth
			{ spellID = 48438, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Demoralizing Roar
			{ spellID = 99, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Entangling Roots
			{ spellID = 339, size = 25, barWidth = 192, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Cyclone
			{ spellID = 33786, size = 25, barWidth = 192, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 25, barWidth = 192, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },
			
			-- Wild Growth
			{ spellID = 48438, size = 30, filter = "CD" },
			-- Swiftmend
			{ spellID = 18562, size = 30, filter = "CD" },
			-- Barkskin
			{ spellID = 22812, size = 30, filter = "CD" },
			-- Mangle(Bear)
			{ spellID = 33878, size = 30, filter = "CD" },
			-- Nature's Grasp
			{ spellID = 16689, size = 30, filter = "CD" },
			-- Starfall
			{ spellID = 48505, size = 30, filter = "CD" },
			-- Growl
			{ spellID = 6795, size = 30, filter = "CD" },
			-- Enrage
			{ spellID = 5229, size = 30, filter = "CD" },
			-- Faerie Fire(Feral)
			{ spellID = 16857, size = 30, filter = "CD" },
			-- Feral Charge - Bear
			{ spellID = 16979, size = 30, filter = "CD" },
			-- Feral Charge - Cat
			{ spellID = 49376, size = 30, filter = "CD" },
			-- Bash
			{ spellID = 5211, size = 30, filter = "CD" },
			-- Maim
			{ spellID = 22570, size = 30, filter = "CD" },
			-- Cower
			{ spellID = 8998, size = 30, filter = "CD" },
			-- Thorns
			{ spellID = 467, size = 30, filter = "CD" },
			-- Tree of Life
			{ spellID = 33891, size = 30, filter = "CD" },
		},
	},
	["HUNTER"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },
			
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },
			
			-- Hunter's Mark
			{ spellID = 1130, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Marked for Death
			{ spellID = 88691, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Piercing shots
			{ spellID = 63468, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Serpent Sting
			{ spellID = 1978, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Black Arrow
			{ spellID = 3674, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Explosive Shot
			{ spellID = 53301, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },
			
			-- Ready, Set, Aim... (*MM spec)
			{ spellID = 82925, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lock and Load (*SV spec)
			{ spellID = 56342, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Master Tactician (*SV spec)
			{ spellID = 34837, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Rapid Fire (*all spec)
			{ spellID = 3045, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Call of the Wild (*ferocity pet use)
			{ spellID = 53434, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Berserking (*troll racial)
			{ spellID = 26297, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Blood Fury (*orc racial)
			{ spellID = 20572, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Acceleration (*engineer use)
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Potion of Speed (*)
			{ spellID = 53908, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Potion of Wild Magic (*)
			{ spellID = 53909, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Exploit Weakness (2t10 proc)
			{ spellID = 70728, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stinger (4t10 proc)
			{ spellID = 71007, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Piercing Twilight (halion25 trinket)
			{ spellID = 75458, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Power of the Taunka (DBW icc25 trinket)
			{ spellID = 71486, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Aim of the Iron Dwarves (DBW icc25 trinket)
			{ spellID = 71491, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Agility of the Vrykul (DBW icc25 trinket)
			{ spellID = 71485, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Icy Rage (icc10 trinket)
			{ spellID = 71401, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Frostforged Champion (icc reputation ring)
			{ spellID = 72412, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Mjolnir Runestone (ulduar10hm trinket)
			{ spellID = 65019, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fury of the Five Flights (sartharion25 trinket)
			{ spellID = 60314, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Greatness (darkmoon dark trinket)
			{ spellID = 60233, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Steady Shot
			{ spellID = 53220, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fire!
			{ spellID = 82926, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "BOTTOMLEFT", SettingsCF["unitframe"].portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", SettingsCF["unitframe"].portrait_enable and 3 or 9, SettingsCF["unitframe"].portrait_enable and 0 or -41 },
			
			-- Hunter's Mark
			{ spellID = 1130, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Marked for Death
			{ spellID = 88691, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Piercing shots
			{ spellID = 63468, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Serpent Sting
			{ spellID = 1978, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Black Arrow
			{ spellID = 3674, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Explosive Shot
			{ spellID = 53301, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },	
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Wyvern Sting
			{ spellID = 19386, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },
			
			-- Explosive Shot
			{ spellID = 53301, size = 30, filter = "CD" },
			-- Aimed Shot
			{ spellID = 19434, size = 30, filter = "CD" },
			-- Kill Shot
			{ spellID = 53351, size = 30, filter = "CD" },
			-- Disengage
			{ spellID = 781, size = 30, filter = "CD" },
			-- Misdirection
			{ spellID = 34477, size = 30, filter = "CD" },
			-- Kill Command
			{ spellID = 34026, size = 30, filter = "CD" },
			-- Feign Death
			{ spellID = 28728, size = 30, filter = "CD" },
			-- Snake Trap
			{ spellID = 34600, size = 30, filter = "CD" },
			-- Wyvern Sting
			{ spellID = 19386, size = 30, filter = "CD" },
			-- Scare Beast
			{ spellID = 1513, size = 30, filter = "CD" },
			-- Master's Call
			{ spellID = 53271, size = 30, filter = "CD" },
			-- Deterrence
			{ spellID = 19263, size = 30, filter = "CD" },
			-- Concussive Shot
			{ spellID = 5116, size = 30, filter = "CD" },
			-- Counterattack
			{ spellID = 19306, size = 30, filter = "CD" },
			-- Intimidation
			{ spellID = 19577, size = 30, filter = "CD" },
			-- Rapid Fire
			{ spellID = 3045, size = 30, filter = "CD" },
			-- Blood Fury
			{ spellID = 20572, size =30, filter = "CD" },
			-- Readiness
			{ spellID = 23989, size = 30, filter = "CD" },
			-- Chimera Shot
			{ spellID = 53209, size = 30, filter = "CD" },
		},
	},
	["MAGE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },
			
			-- Cultivated Power (Muradin's Spyglass)
			{ spellID = 71572, size = 37, unitId = "player", caster = "player", filter = "BUFF" },   
			-- Siphoned Power (Phylactery)
			{ spellID = 71636, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Surging Power
			{ spellID = 71643, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },
			
			-- Arcane Blast
			{ spellID = 36032, size = 37, unitId = "player", caster = "player", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Ignite
			{ spellID = 11119, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Living Bomb
			{ spellID = 44457, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Pyroblast!
			{ spellID = 92315, size = 37, unitId = "player", caster = "player", filter = "DEBUFF" },
			-- Critical Mass
			{ spellID = 22959, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Combustion
			{ spellID = 83853, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },
			
			-- Winter's Chill
			{ spellID = 28593, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Fingers of Frost
			{ spellID = 44544, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fireball!
			{ spellID = 57761, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hot Streak
			{ spellID = 44445, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Missile Barrage
			{ spellID = 54486, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 12536, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Impact
			{ spellID = 12358, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60234, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Arcane Missiles!
			{ spellID = 79683, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Polymorph
			{ spellID = 118, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },

			-- Blink
			{ spellID = 1953, size = 30, filter = "CD" },
			-- Frost Nova
			{ spellID = 11831, size = 30, filter = "CD" },
			-- Ice Barrier
			{ spellID = 11426, size = 30, filter = "CD" },
			-- Counterspell
			{ spellID = 2139, size = 30, filter = "CD" },
			-- Deep Freeze
			{ spellID = 44572, size = 30, filter = "CD" },
			-- Mage Ward
			{ spellID = 543, size = 30, filter = "CD" },
			-- Presence of Mind
			{ spellID = 12043, size = 30, filter = "CD" },
			-- Arcane Power
			{ spellID = 12042, size = 30, filter = "CD" },
			-- Blast Wave
			{ spellID = 11113, size = 30, filter = "CD" },
			-- Dragon's Breath
			{ spellID = 31661, size = 30, filter = "CD" },
			-- Cone of Cold
			{ spellID = 120, size = 30, filter = "CD" },
			-- Will of the forsaken (undead)
			{ spellID = 7744, size = 30, filter = "CD" },
			-- Cold Snap
			{ spellID = 11958, size = 30, filter = "CD" },
			-- Ice Block
			{ spellID = 45438, size = 30, filter = "CD" },
			-- Evocation
			{ spellID = 12051, size = 30, filter = "CD" },
			-- Icy Veins
			{ spellID = 12472, size = 30, filter = "CD" },
			-- Fire Blast
			{ spellID = 2136, size = 30, filter = "CD" },
			-- Mirror Image
			{ spellID = 55342, size = 30, filter = "CD" },
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- Blood Reserve
			{ spellID = 64568, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Last Stand
			{ spellID = 12975, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shield Wall
			{ spellID = 871, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Hamstring
			{ spellID = 1715, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Rend
			{ spellID = 94009, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sunder Armor
			{ spellID = 7386, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Thunder Clap
			{ spellID = 6343, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 48484, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Frost Fever
			{ spellID = 55095, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Demoralizing Shout
			{ spellID = 1160, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Demoralizing Roar
			{ spellID = 99, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 702, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Sudden Death
			{ spellID = 52437, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Slam!
			{ spellID = 46916, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Sword and Board
			{ spellID = 50227, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60229, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Strength of the Taunka
			{ spellID = 71561, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Speed of the Vrykul
			{ spellID = 71560, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Aim of the Iron Dwarves
			{ spellID = 71559, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Thunderstruck
			{ spellID = 80980, size = 37, unitId = "player", caster = "player", filter = "BUFF" }, 
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },
			
			-- Intervene
			{ spellID = 3411, size = 30, filter = "CD" },
			-- Shield Slam
			{ spellID = 23922, size = 30, filter = "CD" },
			-- Whirlwind
			{ spellID = 1680, size = 30, filter = "CD" },
			-- Mortal Strike
			{ spellID = 12294, size = 30, filter = "CD" },
			-- Thunder Clap
			{ spellID = 6343, size = 30, filter = "CD" },
			-- Revenge
			{ spellID = 6572, size = 30, filter = "CD" },
			-- Overpower
			{ spellID = 7384, size = 30, filter = "CD" },
			-- Pummel
			{ spellID = 6552, size = 30, filter = "CD" },
			-- Shield Bash
			{ spellID = 72, size = 30, filter = "CD" },
			-- Charge
			{ spellID = 100, size = 30, filter = "CD" },
			-- Intercept
			{ spellID = 20252, size = 30, filter = "CD" },
			-- Spell Reflection
			{ spellID = 23920, size = 30, filter = "CD" },
			-- Shield Block
			{ spellID = 2565, size = 30, filter = "CD" },
			-- Commanding Shout
			{ spellID = 469, size = 30, filter = "CD" }, 
		},
	},
	["SHAMAN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- Maelstorm Weapon
			{ spellID = 53817, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shamanistic rage
			{ spellID = 30823, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Lightning Shield
			{ spellID = 324, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Water Shield
			{ spellID = 52127, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Earth Shield
			{ spellID = 974, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Elemental mastery
			{ spellID = 64701, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Storm Strike
			{ spellID = 17364, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth Shock
			{ spellID = 8042, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Flame Shock
			{ spellID = 8050, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Hex
			{ spellID = 51514, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth grab
			{ spellID = 64695, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Clearcasting
			{ spellID = 16246, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tidal Waves
			{ spellID = 51562, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lava flows
			{ spellID = 65264, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "BOTTOMLEFT", SettingsCF["unitframe"].portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", SettingsCF["unitframe"].portrait_enable and 3 or 9, SettingsCF["unitframe"].portrait_enable and 0 or -41 },
			
			-- Earth Shield
			{ spellID = 974, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Riptide
			{ spellID = 61295, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Ancestral Fortitude
			{ spellID = 16236, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Hex
			{ spellID = 51514, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },
			
			-- Earth Shock
			{ spellID = 8042, size = 30, filter = "CD" },
			-- Riptide
			{ spellID = 61295, size = 30, filter = "CD" },
			-- Thunderstorm
			{ spellID = 51490, size = 30, filter = "CD" },
			-- Lava Burst
			{ spellID = 51505, size = 30, filter = "CD" },
			-- Lava Lash
			{ spellID = 60103, size = 30, filter = "CD" },
			-- Chain Lightning
			{ spellID = 421, size = 30, filter = "CD" },
			-- Wind Shear
			{ spellID = 57994, size = 30, filter = "CD" },
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- Innervate
			{ spellID = 29166, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Hammer of Justice
			{ spellID = 853, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Judgement of Light
			{ spellID = 20271, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Speed of Light
			{ spellID = 85499, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Conviction
			{ spellID = 20057, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Judgements of the Pure
			{ spellID = 53671, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Holy Shield
			{ spellID = 20925, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Infusion of Light
			{ spellID = 54149, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Divine Plea
			{ spellID = 54428, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Beacon of Light
			{ spellID = 53563, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Divine Illumination
			{ spellID = 31842, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },
			
			-- Repentance
			{ spellID = 20066, size = 30, filter = "CD" },
			-- Hand of Reckoning
			{ spellID = 62124, size = 30, filter = "CD" },
			-- Hand of Freedom
			{ spellID = 1044, size = 30, filter = "CD" },
			-- Judgement of Light
			{ spellID = 20271, size = 30, filter = "CD" },
			-- Righteous Defense
			{ spellID = 31789, size = 30, filter = "CD" },
			-- Exorcism
			{ spellID = 879, size = 30, filter = "CD" },
			-- Hammer of Justice
			{ spellID = 853, size = 30, filter = "CD" },
			-- Consecration
			{ spellID = 26573, size = 30, filter = "CD" },
			-- Hammer of Wrath
			{ spellID = 24275, size = 30, filter = "CD" },
			-- Holy Shock
			{ spellID = 20473, size = 30, filter = "CD" },
			-- Avenger's Shield
			{ spellID = 31935, size = 30, filter = "CD" },
			-- Divine Plea
			{ spellID = 54428, size = 30, filter = "CD" },
			-- Holy Wrath
			{ spellID = 2812, size = 30, filter = "CD" },
			-- Aura Mastery
			{ spellID = 31821, size = 30, filter = "CD" },
			-- Crusader Strike
			{ spellID = 35395, size = 30, filter = "CD" },
			-- Divine Favor
			{ spellID = 31842, size = 30, filter = "CD" },
			-- Divine Storm
			{ spellID = 53385, size = 30, filter = "CD" },
			-- Hammer of the Righteous
			{ spellID = 53595, size = 30, filter = "CD" },
			-- Light of Dawn
			{ spellID = 85222, size = 30, filter = "CD" },
		},
	},
	["PRIEST"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- Power Word: Shield
			{ spellID = 17, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Renew
			{ spellID = 139, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fade
			{ spellID = 586, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fear Ward
			{ spellID = 6346, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hand of Protection
            { spellID = 1022, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
            -- Dispersion
            { spellID = 47585, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
            -- Inner Fire
            { spellID = 588, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Borrowed Time
			{ spellID = 52795, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Surge of Light
			{ spellID = 33151, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Serendipity
			{ spellID = 63730, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60234, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Energized
            { spellID = 67696, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
            -- Eye of the Broodmother
            { spellID = 65007, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
            -- Frostforged Sage
            { spellID = 72416, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shadow Orb
			{ spellID = 77487, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Archangel
			{ spellID = 81700, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Evangelism
			{ spellID = 81661, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Chakra: Prayer of Healing
			{ spellID = 81206, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Chakra: Renew
			{ spellID = 81207, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Chakra: Heal
			{ spellID = 81208, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "BOTTOMLEFT", SettingsCF["unitframe"].portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", SettingsCF["unitframe"].portrait_enable and 3 or 9, SettingsCF["unitframe"].portrait_enable and 0 or -41 },
			
			-- Renew
			{ spellID = 139, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Prayer of Mending
			{ spellID = 41637, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Guardian spirit
			{ spellID = 47788, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Pain suspension
			{ spellID = 33206, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
			-- Shadow Word: Pain
			{ spellID = 589, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Devouring Plague
			{ spellID = 2944, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Vampiric Touch
            { spellID = 34914, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Shackle undead
			{ spellID = 9484, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },
			
			-- Penance
			{ spellID = 47540, size = 30, filter = "CD" },
			-- Pain Suppression
			{ spellID = 33206, size = 30, filter = "CD" },
			-- Power Infusion
			{ spellID = 10060, size = 30, filter = "CD" },
			-- Psychic Scream
			{ spellID = 8122, size = 30, filter = "CD" },
			-- Circle of Healing
			{ spellID = 34861, size = 30, filter = "CD" },
			-- Guardian Spirit
			{ spellID = 47788, size = 30, filter = "CD" },
			-- Prayer of Mending
			{ spellID = 33076, size = 30, filter = "CD" },
			-- Silence
			{ spellID = 15487, size = 30, filter = "CD" },
			-- Power Word: Shield
			{ spellID = 17, size = 30, filter = "CD" },
			-- Holy Fire
			{ spellID = 14914, size = 30, filter = "CD" },
			-- Shadow Word: Death
			{ spellID = 32379, size = 30, filter = "CD" },
			-- Berserking
            { spellID = 26297, size = 30, filter = "CD" },
            -- Hymn of Hope
            { spellID = 64901, size = 30, filter = "CD" },
            -- Divine Hymn
            { spellID = 64843, size = 30, filter = "CD" },
            -- Shadowfiend
            { spellID = 34433, size = 30, filter = "CD" },
            -- Dispersion
            { spellID = 47585, size = 30, filter = "CD" },
			-- Psychic Horror
            { spellID = 64044, size = 30, filter = "CD" },
			-- Holy Word: Chastise
			{ spellID = 88625, size = 30, filter = "CD" },
			-- Power Word: Barrier
			{ spellID = 62618, size = 30, filter = "CD" },
			-- Inner Focus
			{ spellID = 89485, size = 30, filter = "CD" },
			-- Archangel
			{ spellID = 87151, size = 30, filter = "CD" },
			-- Chakra
			{ spellID = 14751, size = 30, filter = "CD" },
			-- Desperate Prayer
			{ spellID = 19236, size = 30, filter = "CD" },
		},
	},
	["WARLOCK"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- Burning Soul
			{ spellID = 74434, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Phylactery of the Nameless Lich
			{ spellID = 71636, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Surge of Power
			{ spellID = 71644, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Devious Minds
			{ spellID = 70840, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Curse of the Elements
			{ spellID = 1490, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Ebon Plaguebringer
			{ spellID = 51099, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Earth and Moon
			{ spellID = 48506, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Tongues
			{ spellID = 1714, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 702, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shadow Embrace
			{ spellID = 32385, size = 37, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Essence of Life
			{ spellID = 60062, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Molten Core
			{ spellID = 47383, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Decimation
			{ spellID = 63158, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Backdraft
			{ spellID = 54277, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Backlash
			{ spellID = 34939, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nether Protection
			{ spellID = 30301, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60235, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60234, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nightfall
			{ spellID = 18095, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Eradication
			{ spellID = 47195, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Soul Fire
			{ spellID = 85113, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Empowered Imp
			{ spellID = 47283, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "BOTTOMLEFT", SettingsCF["unitframe"].portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", SettingsCF["unitframe"].portrait_enable and 3 or 9, SettingsCF["unitframe"].portrait_enable and 0 or -41 },
			
			-- Corruption
			{ spellID = 172, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Immolate
			{ spellID = 348, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Agony
			{ spellID = 980, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Doom
			{ spellID = 603, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unstable Affliction
			{ spellID = 30108, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Haunt
			{ spellID = 48181, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },	
			-- Seed of Corruption
			{ spellID = 27243, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 702, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Tongues
			{ spellID = 1714, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Fear
			{ spellID = 5782, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Enslave Demon
			{ spellID = 1098, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Demon Charge
			{ spellID = 54785, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Fear
			{ spellID = 5782, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },
			
			-- Cannibalize
			{ spellID = 20577, size = 30, filter = "CD" },
			-- Will of the Forsaken
			{ spellID = 7744, size = 30, filter = "CD" },
			-- Conflagrate
			{ spellID = 17962, size = 30, filter = "CD" },
			-- Ritual of Summoning
			{ spellID = 698, size = 30, filter = "CD" },
			-- Shadow Ward
			{ spellID = 6229, size = 30, filter = "CD" },
			-- Demonic Empowerment
			{ spellID = 47193, size = 30, filter = "CD" },
			-- Demon Charge
			{ spellID = 54785, size = 30, filter = "CD" },
			-- Soulshatter
			{ spellID = 29858, size = 30, filter = "CD" },
			-- Demonic Circle: Teleport
			{ spellID = 48020, size = 30, filter = "CD" },
			-- Howl of Terror
			{ spellID = 5484, size = 30, filter = "CD" },
			-- Death Coil
			{ spellID = 6789, size = 30, filter = "CD" },
			-- Haunt
			{ spellID = 48181, size = 30, filter = "CD" },
			-- Shadowburn
			{ spellID = 17877, size = 30, filter = "CD" },
			-- Shadowfury
			{ spellID = 30283, size = 30, filter = "CD" },
			-- Chaos Bolt
			{ spellID = 50796, size = 30, filter = "CD" },
			-- Shadowflame
			{ spellID = 47897, size = 30, filter = "CD" },
			-- Fel Domination
			{ spellID = 18708, size = 30, filter = "CD" },
			-- Sacrifice (Voidwalker)
			{ spellID = 7812, size = 30, filter = "CD" },
			-- Suffering (Voidwalker)
			{ spellID = 17735, size = 30, filter = "CD" },
			-- Spell Lock (Felhunter)
			{ spellID = 19647, size = 30, filter = "CD" },
			-- Devour Magic (Felhunter)
			{ spellID = 19505, size = 30, filter = "CD" },
			-- Soul Harvest
			{ spellID = 79268, size = 30, filter = "CD" },
			-- Felstorm
			{ spellID = 89751, size = 30, filter = "CD" },
			-- Soulburn
			{ spellID = 74434, size = 30, filter = "CD" },
		},
	},
	["ROGUE"] = {	
		{	
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },
			
			-- Sprint
			{ spellID = 2983, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Cloak of Shadows
			{ spellID = 31224, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Adrenaline Rush
			{ spellID = 13750, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Evasion
			{ spellID = 5277, size = 37, unitId = "player", caster = "player", filter = "BUFF" },	
			-- Envenom
			{ spellID = 32645, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Overkill
			{ spellID = 58426, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Slice and Dice
			{ spellID = 5171, size = 37, unitId = "player", caster = "player", filter = "BUFF" },		
			-- Tricks of the Trade
			{ spellID = 57934, size = 37, unitId = "player", caster = "player", filter = "BUFF" },		
			-- Turn the Tables
			{ spellID = 51627, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- NE race ability
			{ spellID = 58984, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },
			
			-- Rupture
			{ spellID = 1943, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Garrote
			{ spellID = 703, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Kidney shot
			{ spellID = 408, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Cheap shot
			{ spellID = 1833, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Expose Armor
			{ spellID = 8647, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Dismantle
			{ spellID = 51722, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Deadly Poison
			{ spellID = 2818, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Mind-numbing Poison
			{ spellID = 5760, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },		
			-- Crippling Poison
			{ spellID = 3409, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Wound Poison
			{ spellID = 13218, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Blind
			{ spellID = 2094, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },
			
			-- Kick
			{ spellID = 1766, size = 30, filter = "CD" }, 
			-- Gouge
			{ spellID = 1776, size = 30, filter = "CD" }, 
			-- Kidney shot
			{ spellID = 408, size = 30, filter = "CD" }, 
			-- Killing Spree
			{ spellID = 51690, size = 30, filter = "CD" }, 
			-- Adrenaline Rush
			{ spellID = 13750, size = 30, filter = "CD" }, 
			-- Stealth
			{ spellID = 1784, size = 30, filter = "CD" }, 
			-- Vanish
			{ spellID = 1856, size = 30, filter = "CD" }, 
			-- NE race ability
			{ spellID = 58984, size = 30, filter = "CD" },
		},
	},
	["DEATHKNIGHT"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },
			
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "BOTTOMLEFT", SettingsCF["unitframe"].portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", SettingsCF["unitframe"].portrait_enable and 3 or 9, SettingsCF["unitframe"].portrait_enable and 0 or -41 },
			
			-- Blood Plague
			{ spellID = 59879, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Fever
			{ spellID = 59921, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unholy Blight
			{ spellID = 49194, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Summon Gargoyle
			{ spellID = 49206, size = 25, barWidth = 187, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Greatness
			{ spellID = 60229, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Force
			{ spellID = 67383, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Strength
			{ spellID = 53365, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Pyrite Infusion
			{ spellID = 65014, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Might
			{ spellID = 67117, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dancing Rune Weapon
			{ spellID = 49028, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Killing machine 
			{ spellID = 51124, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Freezing fog 
			{ spellID = 59052, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, SettingsCF["unitframe"].plugins_swing == true and 29 or 17 },

			-- Summon Gargoyle
			{ spellID = 49206, size = 30, filter = "CD" },
			-- Gnaw
			{ spellID = 47481, size = 30, filter = "CD" },
			-- Strangulate
			{ spellID = 47476, size = 30, filter = "CD" },
			-- Mind Freeze
			{ spellID = 47528, size = 30, filter = "CD" },
		},
	},
	["ALL"] = {
		{
			Name = "PVE/PVP_DEBUFF",
			Direction = "UP",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 253 },
			
			-- Death Knight
			-- Gnaw (Ghoul)
			{ spellID = 47481, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Strangulate
			{ spellID = 47476, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chains of Ice
			{ spellID = 45524, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Desecration (no duration, lasts as long as you stand in it)
			{ spellID = 55741, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Heart Strike
			{ spellID = 58617, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hungering Cold
			{ spellID = 51209, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Druid
			-- Skull Bash (Bear Form)
			{ spellID = 80964, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Skull Bash (Cat Form)
			{ spellID = 80965, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Solar Beam
			{ spellID = 78675, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Fungal Growth
			{ spellID = 78788, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cyclone
			{ spellID = 33786, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Bash
			{ spellID = 5211, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Maim
			{ spellID = 22570, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pounce
			{ spellID = 9005, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots
			{ spellID = 339, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Feral Charge Effect
			{ spellID = 45334, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 58179, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Hunter
			-- Freezing Trap Effect
			{ spellID = 3355, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Scare Beast
			{ spellID = 1513, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Scatter Shot
			{ spellID = 19503, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Snatch (Bird of Prey)
			{ spellID = 50541, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intimidation
			{ spellID = 24394, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sonic Blast (Bat)
			{ spellID = 50519, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Ravage (Ravager)
			{ spellID = 50518, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Barrage
			{ spellID = 35101, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Shot
			{ spellID = 5116, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Trap Aura
			{ spellID = 13810, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Freezing Trap
			{ spellID = 61394, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Wing Clip
			{ spellID = 2974, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Counterattack
			{ spellID = 19306, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Entrapment
			{ spellID = 19185, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pin (Crab)
			{ spellID = 50245, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Venom Web Spray (Silithid)
			{ spellID = 54706, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Web (Spider)
			{ spellID = 4167, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Froststorm Breath (Chimera)
			{ spellID = 51209, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Tendon Rip (Hyena)
			{ spellID = 51209, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			--Serenity Dust (Moth)
			{ spellID = 50318, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Swoop (Moth)
			{ spellID = 52825, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Ankle Crack (Crocolisk)
			{ spellID = 50433, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pummel (Gorilla)
			{ spellID = 26090, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Clench (Scorpid)
			{ spellID = 50541, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Time Warp (Warp Stalker)
			{ spellID = 35346, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sting (Wasp)
			{ spellID = 56626, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Nether Shock (Nether Ray)
			{ spellID = 50479, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Mage
			-- Dragon's Breath
			{ spellID = 31661, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Polymorph
			{ spellID = 118, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			--Improved Polymorph
			{ spellID = 11210, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Counterspell
			{ spellID = 18469, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Deep Freeze
			{ spellID = 44572, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze (Water Elemental)
			{ spellID = 33395, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Nova
			{ spellID = 122, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shattered Barrier
			{ spellID = 55080, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chilled
			{ spellID = 6136, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cone of Cold
			{ spellID = 120, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Paladin
			-- Repentance
			{ spellID = 20066, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Turn Evil
			{ spellID = 10326, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shield of the Templar
			{ spellID = 63529, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hammer of Justice
			{ spellID = 853, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Holy Wrath
			{ spellID = 2812, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Stun (Seal of Justice proc)
			{ spellID = 20170, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Avenger's Shield
			{ spellID = 31935, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Priest
			-- Psychic Horror
			{ spellID = 64058, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Control
			{ spellID = 605, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Horror
			{ spellID = 64044, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silence
			{ spellID = 15487, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Flay
			{ spellID = 15407, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sin and Punishment
			{ spellID = 87099, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shackle Undead
			{ spellID = 9484, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Rogue
			-- Dismantle
			{ spellID = 51722, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Garrote - Silence
			{ spellID = 1330, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Kick
			{ spellID = 18425, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cheap Shot
			{ spellID = 1833, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Kidney Shot
			{ spellID = 408, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blade Twisting
			{ spellID = 31125, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Crippling Poison
			{ spellID = 3409, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Deadly Throw
			{ spellID = 26679, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Shaman
			-- Hex
			{ spellID = 51514, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthgrab
			{ spellID = 64695, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze
			{ spellID = 63685, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Stoneclaw Stun
			{ spellID = 39796, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthbind
			{ spellID = 3600, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Bind Elemental
			{ spellID = 76780, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Bash (Feral Spirit)
			{ spellID = 58861, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthquake
			{ spellID = 77505, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Warlock
			-- Aura of Foreboding
			{ spellID = 89604, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Axe Toss (Felguard)
			{ spellID = 89766, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Demon Leap
			{ spellID = 54785, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Fear
			{ spellID = 5782, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Seduction (Succubus)
			{ spellID = 6358, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Spell Lock (Felhunter)
			{ spellID = 24259, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shadowfury
			{ spellID = 30283, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept (Felguard)
			{ spellID = 30153, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Aftermath
			{ spellID = 18118, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Warrior
			-- Throwdown
			{ spellID = 85388, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intimidating Shout
			{ spellID = 20511, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Disarm
			{ spellID = 676, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced (Gag Order)
			{ spellID = 18498, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Charge Stun
			{ spellID = 7922, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussion Blow
			{ spellID = 12809, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept
			{ spellID = 20253, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shockwave
			{ spellID = 46968, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Hamstring
			{ spellID = 58373, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Improved Hamstring
			{ spellID = 23694, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hamstring
			{ spellID = 1715, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Piercing Howl
			{ spellID = 12323, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Racials
			-- War Stomp
			{ spellID = 20549, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Mark of the Fallen Champion
			{ spellID = 72293, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Inoculated (Festergut)
			{ spellID = 72103, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mutated Infection (Rotface)
			{ spellID = 71224, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Unbound Plague (Professor Putricide)
			{ spellID = 72856, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Gas Variable (Professor Putricide)
			{ spellID = 70353, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Ooze Variable (Professor Putricide)
			{ spellID = 70352, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pact of the Darkfallen (Bloodqueen Lana'thel)
			{ spellID = 71340, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Swarming Shadows (Bloodqueen Lana'thel)
			{ spellID = 71861, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Essence of the Blood Queen (Bloodqueen Lana'thel)
			{ spellID = 71473, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Bomb (Sindragosa)
			{ spellID = 71053, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Instability (Sindragosa)
			{ spellID = 69766, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Unchained Magic (Sindragosa)
			{ spellID = 69762, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mystic Buffet (Sindragosa)
			{ spellID = 70128, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Necrotic Plague (Arthas - The Lich King)
			{ spellID = 73912, size = 51, unitId = "player", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "UP",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 253 },
			
			-- Hunter
			-- Aspect of the Pack
			{ spellID = 13159, size = 51, unitId = "player", caster = "all", filter = "BUFF" },
			-- Deterrence
			{ spellID = 19263, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			
			--Druid
			-- Innervate
			{ spellID = 29166, size = 51, unitId = "target", caster = "all", filter = "BUFF"},
			-- Barskin
			{ spellID = 22812, size = 51, unitId = "target", caster = "all", filter = "BUFF"},
			
			-- Warrior
			-- Spell Reflection
			{ spellID = 23920, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Shield wall
			{ spellID = 871, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Berserker
			{ spellID = 18499, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Last stand
			{ spellID = 12976, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Paladin
			-- Aura Mastery
			{ spellID = 31821, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Hand of Freedom
			{ spellID = 1044, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Hand of Sacrifice
			{ spellID = 6940, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Hand of protection
			{ spellID = 1022, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Divine Shield
			{ spellID = 642, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Divine protection
			{ spellID = 498, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Divine sacrifice
			{ spellID = 64205, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Ardent defender
			{ spellID = 31850, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Mage
			-- Ice Block
			{ spellID = 45438, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Invisibility
			{ spellID = 66, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Evocation
			{ spellID = 12051, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Improved blink
			{ spellID = 46989, size = 51, unitId = "target", caster = "all", filter = "BUFF" },

			-- Rogue
			-- Cloak of Shadows
			{ spellID = 31224, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Evasion
			{ spellID = 5277, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Cheating death
			{ spellID = 45182, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Death knight
			-- Anti-Magic Shell
			{ spellID = 48707, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Lichborne
			{ spellID = 49039, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Bone shield
			{ spellID = 49222, size = 51, unitId = "target", caster = "all", filter = "BUFF" },

			-- Shaman
			-- Grounding Totem Effect
			{ spellID = 8178, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Stoneclaw totem
			{ spellID = 55277, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Shamanistic rage
			{ spellID = 30823, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Earth shield
			{ spellID = 974, size = 51, unitId = "target", caster = "all", filter = "BUFF" },

			-- Priest
			-- Dispersion
			{ spellID = 47585, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Pain supression
			{ spellID = 33206, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Warlock
			-- Banish
			{ spellID = 710, size = 51, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Soul harvest
			{ spellID = 79268, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Soulstone
			{ spellID = 20707, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- All
			-- Warsong flag
			{ spellID = 23333, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			{ spellID = 23335, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Netherstorm flag
			{ spellID = 34976, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Seaforium
			{ spellID = 52418, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
			-- Seaforium 2
			{ spellID = 66271, size = 51, unitId = "target", caster = "all", filter = "DEBUFF" },
			
			-- Drink
			{ spellID = 43183, size = 51, unitId = "target", caster = "all", filter = "BUFF" },
		},
	},
}