local T, C, L = unpack(ShestakUI)
if C.unitframe.enable ~= true then return end

if T.name == "Oz" and T.realm == "Runetotem" then
	Filger_Settings = {
	config_mode = false,
	max_test_icon = 5,
	player_buff_icon = {"BOTTOMRIGHT", UIParent, "BOTTOM", -173, 520},		-- "P_BUFF_ICON"
	player_proc_icon = {"BOTTOMRIGHT", UIParent, "BOTTOM", 210, 520},		-- "P_PROC_ICON"
	special_proc_icon = {"BOTTOMRIGHT", UIParent, "BOTTOM", -173, 480},		-- "SPECIAL_P_BUFF_ICON"
	target_debuff_icon = {"BOTTOMLEFT", UIParent, "BOTTOM", 173, 480},		-- "T_DEBUFF_ICON"
	target_buff_icon = {"BOTTOMLEFT", UIParent, "BOTTOM", 173, 560},		-- "T_BUFF"
	pve_debuff = {"BOTTOMRIGHT", UIParent, "BOTTOM", -173, 560},			-- "PVE/PVP_DEBUFF"
	pve_cc = {"BOTTOMRIGHT", UIParent, "BOTTOM", -364, 310},				-- "PVE/PVP_CC"
	cooldown = {"BOTTOMRIGHT", UIParent, "BOTTOM", -364, 386},				-- "COOLDOWN"
	target_bar = {"BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 3 or 5, C.unitframe.portrait_enable and 0 or -14},	-- "T_DE/BUFF_BAR"
	}
else
	Filger_Settings = {
	config_mode = false,
	max_test_icon = 5,
	player_buff_icon = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173},	-- "P_BUFF_ICON"
	player_proc_icon = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173},	-- "P_PROC_ICON"
	special_proc_icon = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 213},	-- "SPECIAL_P_BUFF_ICON"
	target_debuff_icon = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213},	-- "T_DEBUFF_ICON"
	target_buff_icon = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 253},	-- "T_BUFF"
	pve_debuff = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 253},			-- "PVE/PVP_DEBUFF"
	pve_cc = {"TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -49},				-- "PVE/PVP_CC"
	cooldown = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 59, C.unitframe.plugins_swing and 21 or 9},		-- "COOLDOWN"
	target_bar = {"BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 3 or 9, C.unitframe.portrait_enable and 0 or -41},	-- "T_DE/BUFF_BAR"
	}
end

Filger_Spells = {
	["DRUID"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Lifebloom
			{spellID = 33763, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rejuvenation
			{spellID = 774, unitID = "player", caster = "player", filter = "BUFF"},
			-- Regrowth
			{spellID = 8936, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Seed
			{spellID = 48504, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Bounty
			{spellID = 96206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tree of Life
			{spellID = 33891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 16689, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thorns
			{spellID = 467, unitID = "player", caster = "player", filter = "BUFF"},
			-- Owlkin Frenzy
			{spellID = 48391, unitID = "player", caster = "player", filter = "BUFF"},
			-- Starfall
			{spellID = 48505, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Roar
			{spellID = 52610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Survival Instincts
			{spellID = 61336, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserk
			{spellID = 50334, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dash
			{spellID = 1850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 5229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Regeneration
			{spellID = 22842, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger's Fury
			{spellID = 5217, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stampede
			{spellID = 81017, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Eclipse (Lunar)
			{spellID = 48518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Eclipse (Solar)
			{spellID = 48517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shooting Stars
			{spellID = 93400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lunar Shower
			{spellID = 81192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grace
			{spellID = 16886, unitID = "player", caster = "player", filter = "BUFF"},
			-- Clearcasting
			{spellID = 16870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Predator's Swiftness
			{spellID = 69369, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pulverize
			{spellID = 80313, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Physical Agility
			-- Kiril, Fury of Beasts (Agility, Proc)
			{spellID = 108011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Ti'tahk, the Steps of Time (Haste, Proc)
			{spellID = 107804, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Bedrock Talisman (Dodge, Proc)
			{spellID = 92233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Earthquake (Health, Use)
			{spellID = 89181, unitID = "player", caster = "player", filter = "BUFF"},
			-- Symbiotic Worm (Mastery, Proc)
			{spellID = 92235, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Stolen Memories (Dodge, Use)
			{spellID = 92213, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Phial (Dodge, Use)
			{spellID = 101156, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spidersilk Spindle (Absorb, Proc)
			{spellID = 96945, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stay of Execution (Absorb, Use)
			{spellID = 96988, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stay of Execution (Drawback)
			{spellID = 96993, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Soulshifter Vortex (Mastery, Proc)
			{spellID = 109776, unitID = "player", caster = "player", filter = "BUFF"},
			-- Indomitable Pride (Absorb, Proc)
			{spellID = 109786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire of the Deep (Dodge, Use)
			{spellID = 109779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Veil of Lies (Dodge, Proc)
			{spellID = 102667, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Essence of the Cyclone (Crit, Proc)
			{spellID = 92126, unitID = "player", caster = "player", filter = "BUFF"},
			-- Prestor's Talisman of Machination (Haste, Proc)
			{spellID = 92124, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unsolvable Riddle (Agility, Use)
			{spellID = 92123, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unheeded Warning (Weapon Damage, Proc)
			{spellID = 92108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Conquest (Agility, Use)
			{spellID = 92226, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Conquest (Agility, Proc)
			{spellID = 92220, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ricket's Magnetic Fireball (Crit, Use)
			{spellID = 101515, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ancient Petrified Seed (Agility, Use)
			{spellID = 97009, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Hungerer (Haste, Proc)
			{spellID = 96911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Matrix Restabilizer (Highest Stat, Proc)
			{spellID = 96979, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kiroptyric Sigil (Agility, Use)
			{spellID = 109715, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrow of Time (Haste, Proc)
			{spellID = 102659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Soul Casket (Spell Power, Use)
			{spellID = 91019, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shard of Woe (Haste, Use)
			{spellID = 91173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Dominance (Spell Power, Use)
			{spellID = 92225, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Dominance (Spell Power, Proc)
			{spellID = 92218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Chalice (Mastery, Use)
			{spellID = 100403, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Zeth (Intellect, Use)
			{spellID = 97007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottled Wishes (Spell Power, Use)
			{spellID = 109792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Foul Gift of the Demon Lord (Mastery, Proc)
			{spellID = 102663, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Bell of Enraging Resonance (Spell Power, Proc)
			{spellID = 91007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Volcano (Intellect, Proc)
			{spellID = 89091, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Spell Power, Proc)
			{spellID = 91027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Haste, Use)
			{spellID = 91041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stump of Time (Spell Power, Proc)
			{spellID = 91047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Theralion's Mirror (Mastery, Proc)
			{spellID = 91024, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Core of Ripeness (Spirit, Use)
			{spellID = 91155, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fall of Mortality (Spirit, Proc)
			{spellID = 91184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jar of Ancient Remedies (Debuff)
			{spellID = 91322, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Mandala of Stirring Patterns (Intellect, Proc)
			{spellID = 91192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Quintessence (Intellect, Use)
			{spellID = 97008, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jaws of Defeat (Manacost, Use)
			{spellID = 96908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Universal Trinket (Haste, Proc)
			--{spellID = 109789, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Windwalk (Dodge and Movement)
			{spellID = 74243, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (AP)
			{spellID = 75176, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Landslide (AP)
			{spellID = 74245, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Lightweave (Intellect)
			{spellID = 75170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Torrent (Intellect)
			{spellID = 74241, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Darkglow (Spirit)
			{spellID = 75173, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Moonfire
			{spellID = 8921, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sunfire
			{spellID = 93402, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Earth and Moon
			{spellID = 48506, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Insect Swarm
			{spellID = 5570, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Fungal Growth
			{spellID = 81281, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Faerie Fire
			{spellID = 770, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rake
			{spellID = 1822, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rip
			{spellID = 1079, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Lacerate
			{spellID = 33745, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pounce Bleed
			{spellID = 9007, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mangle
			{spellID = 33876, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Demoralizing Roar
			{spellID = 99, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Skull Bash (Bear Form)
			{spellID = 80964, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Feral Charge Effect
			{spellID = 45334, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Infected Wounds
			{spellID = 58179, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(Filger_Settings.target_bar)},

			-- Lifebloom
			{spellID = 33763, unitID = "target", caster = "player", filter = "BUFF"},
			-- Rejuvenation
			{spellID = 774, unitID = "target", caster = "player", filter = "BUFF"},
			-- Regrowth
			{spellID = 8936, unitID = "target", caster = "player", filter = "BUFF"},
			-- Wild Growth
			{spellID = 48438, unitID = "target", caster = "player", filter = "BUFF"},
			-- Living Seed
			{spellID = 48504, unitID = "target", caster = "player", filter = "BUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(Filger_Settings.pve_cc)},

			-- Entangling Roots
			{spellID = 339, unitID = "focus", caster = "all", filter = "DEBUFF"},
			-- Cyclone
			{spellID = 33786, unitID = "focus", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Wild Growth
			{spellID = 48438, filter = "CD"},
			-- Swiftmend
			{spellID = 18562, filter = "CD"},
			-- Barkskin
			{spellID = 22812, filter = "CD"},
			-- Mangle(Bear)
			{spellID = 33878, filter = "CD"},
			-- Nature's Grasp
			{spellID = 16689, filter = "CD"},
			-- Starfall
			{spellID = 48505, filter = "CD"},
			-- Starsurge
			{spellID = 78674, filter = "CD"},
			-- Typhoon
			{spellID = 50516, filter = "CD"},
			-- Solar beam
			{spellID = 78675, filter = "CD"},
			-- Growl
			{spellID = 6795, filter = "CD"},
			-- Enrage
			{spellID = 5229, filter = "CD"},
			-- Faerie Fire(Feral)
			{spellID = 16857, filter = "CD"},
			-- Feral Charge - Bear
			{spellID = 16979, filter = "CD", absID = true},
			-- Feral Charge - Cat
			{spellID = 49376, filter = "CD", absID = true},
			-- Bash
			{spellID = 5211, filter = "CD"},
			-- Maim
			{spellID = 22570, filter = "CD"},
			-- Cower
			{spellID = 8998, filter = "CD"},
			-- Thorns
			{spellID = 467, filter = "CD"},
			-- Tree of Life
			{spellID = 33891, filter = "CD"},
			-- Skull Bash - Cat
			{spellID = 80965, filter = "CD"},
			-- Tiger's Fury
			{spellID = 5217, filter = "CD"},

			-- Racials
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD", absID = true},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Nature's Grace
			{spellID = 16886, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Lightweave
			{spellID = 75170, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Power Torrent
			{spellID = 74241, slotID = 16, filter = "ICD", trigger = "BUFF", duration = 45},
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["HUNTER"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Self
			-- Spirit Mend
			{spellID = 90361, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deterrence
			{spellID = 19263, unitID = "player", caster = "player", filter = "BUFF"},

			-- Other
			-- Burning Adrenaline (T12 x4)
			{spellID = 99060, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Ready, Set, Aim...
			{spellID = 82925, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lock and Load
			{spellID = 56453, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Fire
			{spellID = 3045, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Wild
			{spellID = 53434, unitID = "player", caster = "player", filter = "BUFF"},
			-- Improved Steady Shot
			{spellID = 53220, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire!
			{spellID = 82926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mend Pet
			{spellID = 136, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Cobra Strikes
			{spellID = 53257, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focus Fire
			{spellID = 82692, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Physical Agility
			-- Kiril, Fury of Beasts (Agility, Proc)
			{spellID = 108011, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Essence of the Cyclone (Crit, Proc)
			{spellID = 92126, unitID = "player", caster = "player", filter = "BUFF"},
			-- Prestor's Talisman of Machination (Haste, Proc)
			{spellID = 92124, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unsolvable Riddle (Agility, Use)
			{spellID = 92123, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unheeded Warning (Weapon Damage, Proc)
			{spellID = 92108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Conquest (Agility, Use)
			{spellID = 92226, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Conquest (Agility, Proc)
			{spellID = 92220, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ricket's Magnetic Fireball (Crit, Use)
			{spellID = 101515, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ancient Petrified Seed (Agility, Use)
			{spellID = 97009, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Hungerer (Haste, Proc)
			{spellID = 96911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Matrix Restabilizer (Highest Stat, Proc)
			{spellID = 96979, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kiroptyric Sigil (Agility, Use)
			{spellID = 109715, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrow of Time (Haste, Proc)
			{spellID = 102659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Universal Trinket (Haste, Proc)
			--{spellID = 109789, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Physical General
			-- Swordguard Embroidery (AP)
			{spellID = 75176, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Ranged
			-- X-Ray Targeting (RAP)
			{spellID = 95712, unitID = "player", caster = "player", filter = "BUFF"},
			-- Flintlocke's Woodchucker (Agility)
			{spellID = 99621, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Hunter's Mark
			{spellID = 1130, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Marked for Death
			{spellID = 88691, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Piercing Shots
			{spellID = 63468, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Serpent Sting
			{spellID = 1978, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Black Arrow
			{spellID = 3674, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Explosive Shot
			{spellID = 53301, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		--[[{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(Filger_Settings.target_bar)},

			-- Hunter's Mark
			{spellID = 1130, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Marked for Death
			{spellID = 88691, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Piercing shots
			{spellID = 63468, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Serpent Sting
			{spellID = 1978, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Black Arrow
			{spellID = 3674, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Explosive Shot
			{spellID = 53301, unitID = "target", caster = "player", filter = "DEBUFF"},
		},]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(Filger_Settings.pve_cc)},

			-- Wyvern Sting
			{spellID = 19386, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Silencing Shot
			{spellID = 34490, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Silencing Shot
			{spellID = 34490, filter = "CD"},
			-- Explosive Shot
			{spellID = 53301, filter = "CD"},
			-- Kill Shot
			{spellID = 53351, filter = "CD"},
			-- Disengage
			{spellID = 781, filter = "CD"},
			-- Misdirection
			{spellID = 34477, filter = "CD"},
			-- Kill Command
			{spellID = 34026, filter = "CD"},
			-- Feign Death
			{spellID = 28728, filter = "CD"},
			-- Snake Trap
			{spellID = 34600, filter = "CD"},
			-- Explosive Trap
			{spellID = 13813, filter = "CD"},
			-- Ice Trap
			{spellID = 13809, filter = "CD"},
			-- Wyvern Sting
			{spellID = 19386, filter = "CD"},
			-- Master's Call
			{spellID = 53271, filter = "CD"},
			-- Deterrence
			{spellID = 19263, filter = "CD"},
			-- Concussive Shot
			{spellID = 5116, filter = "CD"},
			-- Counterattack
			{spellID = 19306, filter = "CD"},
			-- Intimidation
			{spellID = 19577, filter = "CD"},
			-- Rapid Fire
			{spellID = 3045, filter = "CD"},
			-- Fervor
			{spellID = 82726, filter = "CD"},
			-- Readiness
			{spellID = 23989, filter = "CD"},
			-- Chimera Shot
			{spellID = 53209, filter = "CD"},
			-- Spirit Mend (exotic)
			{spellID = 90361, filter = "CD"},
			-- Web
			{spellID = 4167, filter = "CD"},
			-- Venom Web spray (exotic)
			{spellID = 54706, filter = "CD"},
			-- Web Wrap (exotic)
			{spellID = 96201, filter = "CD"},

			-- Racials
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["MAGE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Invisibility
			{spellID = 32612, unitID = "player", caster = "player", filter = "BUFF"},
			-- Icy Veins
			{spellID = 12472, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pyromaniac
			{spellID = 83582, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mana Shield
			{spellID = 1463, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Barrier
			{spellID = 11426, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Block
			{spellID = 45438, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mage Ward
			{spellID = 543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Improved Blink
			{spellID = 46989, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blazing Speed
			{spellID = 31643, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Power
			{spellID = 12042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Improved Mana Gem
			{spellID = 83098, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Fingers of Frost
			{spellID = 44544, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brain Freeze
			{spellID = 57761, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hot Streak
			{spellID = 44445, unitID = "player", caster = "player", filter = "BUFF"},
			-- Clearcasting
			{spellID = 12536, unitID = "player", caster = "player", filter = "BUFF"},
			-- Impact
			{spellID = 64343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Missiles!
			{spellID = 79683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Invocation
			{spellID = 87098, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incanter's Absorption
			{spellID = 44413, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Caster General
			-- Ti'tahk, the Steps of Time (Haste, Proc)
			{spellID = 107804, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Soul Casket (Spell Power, Use)
			{spellID = 91019, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shard of Woe (Haste, Use)
			{spellID = 91173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Dominance (Spell Power, Use)
			{spellID = 92225, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Dominance (Spell Power, Proc)
			{spellID = 92218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Chalice (Mastery, Use)
			{spellID = 100403, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Zeth (Intellect, Use)
			{spellID = 97007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottled Wishes (Spell Power, Use)
			{spellID = 109792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Foul Gift of the Demon Lord (Mastery, Proc)
			{spellID = 102663, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Bell of Enraging Resonance (Spell Power, Proc)
			{spellID = 91007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Volcano (Intellect, Proc)
			{spellID = 89091, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Spell Power, Proc)
			{spellID = 91027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Haste, Use)
			{spellID = 91041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stump of Time (Spell Power, Proc)
			{spellID = 91047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Theralion's Mirror (Mastery, Proc)
			{spellID = 91024, unitID = "player", caster = "player", filter = "BUFF"},
			-- Universal Trinket (Haste, Proc)
			--{spellID = 109789, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Lightweave (Intellect)
			{spellID = 75170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Torrent (Intellect)
			{spellID = 74241, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Time Lord's Regalia (Haste, Proc)
			{spellID = 105785, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Arcane Blast
			{spellID = 36032, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Ignite
			{spellID = 12654, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Living Bomb
			{spellID = 44457, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroblast!
			{spellID = 92315, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroblast
			{spellID = 11366, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Critical Mass
			{spellID = 22959, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Combustion
			{spellID = 83853, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Blast Wave
			{spellID = 11113, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freeze (Water Elemental)
			{spellID = 33395, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shattered Barrier
			{spellID = 55080, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Improved Cone of Cold
			{spellID = 83302, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frostfire Bolt
			{spellID = 44614, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(Filger_Settings.pve_cc)},

			-- Polymorph
			{spellID = 118, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Blink
			{spellID = 1953, filter = "CD"},
			-- Frost Nova
			{spellID = 11831, filter = "CD"},
			-- Ice Barrier
			{spellID = 11426, filter = "CD"},
			-- Counterspell
			{spellID = 2139, filter = "CD"},
			-- Deep Freeze
			{spellID = 44572, filter = "CD"},
			-- Mage Ward
			{spellID = 543, filter = "CD"},
			-- Presence of Mind
			{spellID = 12043, filter = "CD"},
			-- Arcane Power
			{spellID = 12042, filter = "CD"},
			-- Blast Wave
			{spellID = 11113, filter = "CD"},
			-- Dragon's Breath
			{spellID = 31661, filter = "CD"},
			-- Cone of Cold
			{spellID = 120, filter = "CD"},
			-- Cold Snap
			{spellID = 11958, filter = "CD"},
			-- Ice Block
			{spellID = 45438, filter = "CD"},
			-- Evocation
			{spellID = 12051, filter = "CD"},
			-- Icy Veins
			{spellID = 12472, filter = "CD"},
			-- Fire Blast
			{spellID = 2136, filter = "CD"},
			-- Mirror Image
			{spellID = 55342, filter = "CD"},
			-- Ring of Frost
			{spellID = 82676, filter = "CD"},
			-- Flame Orb
			{spellID = 82731, filter = "CD"},
			-- Freeze (Elemental)
			{spellID = 33395, filter = "CD"},
			-- Combustion
			{spellID = 11129, filter = "CD"},
			-- Mana Shield
			{spellID = 1463, filter = "CD"},
			-- Invisibility
			{spellID = 66, filter = "CD"},

			-- Racials
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Cauterize
			{spellID = 87023, filter = "ICD", trigger = "DEBUFF", duration = 60},
			-- Lightweave
			{spellID = 75170, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Power Torrent
			{spellID = 74241, slotID = 16, filter = "ICD", trigger = "BUFF", duration = 45},
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Shield Wall
			{spellID = 871, unitID = "player", caster = "player", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enraged Regeneration
			{spellID = 55694, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Block
			{spellID = 2565, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Death Wish
			{spellID = 12292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recklesness
			{spellID = 1719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deadly Calm
			{spellID = 85730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inner Rage
			{spellID = 1134, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sweeping Strikes
			{spellID = 12328, unitID = "player", caster = "player", filter = "BUFF"},
			-- Victorious
			{spellID = 32216, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Bloodsurge
			{spellID = 46916, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sword and Board
			{spellID = 50227, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thunderstruck
			{spellID = 87096, unitID = "player", caster = "player", filter = "BUFF"},
			-- Taste for Blood
			{spellID = 60503, unitID = "player", caster = "player", filter = "BUFF"},
			-- Battle trance
			{spellID = 12964, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incite
			{spellID = 86627, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 14202, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meat Cleaver
			{spellID = 85739, unitID = "player", caster = "player", filter = "BUFF"},
			-- Executioner
			{spellID = 90806, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rude Interruption
			{spellID = 86663, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slaughter
			{spellID = 84586, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Bedrock Talisman (Dodge, Proc)
			{spellID = 92233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Earthquake (Health, Use)
			{spellID = 89181, unitID = "player", caster = "player", filter = "BUFF"},
			-- Symbiotic Worm (Mastery, Proc)
			{spellID = 92235, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Stolen Memories (Dodge, Use)
			{spellID = 92213, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Phial (Dodge, Use)
			{spellID = 101156, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spidersilk Spindle (Absorb, Proc)
			{spellID = 96945, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stay of Execution (Absorb, Use)
			{spellID = 96988, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stay of Execution (Drawback)
			{spellID = 96993, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Soulshifter Vortex (Mastery, Proc)
			{spellID = 109776, unitID = "player", caster = "player", filter = "BUFF"},
			-- Indomitable Pride (Absorb, Proc)
			{spellID = 109786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire of the Deep (Dodge, Use)
			{spellID = 109779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Veil of Lies (Dodge, Proc)
			{spellID = 102667, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Strength DPS
			-- Crushing Weight (Haste, Proc)
			{spellID = 91821, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of Angerforge (Raw Fury, Proc)
			{spellID = 91832, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of Angerforge (Strength, Use)
			{spellID = 91836, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Rage (Strength, Proc)
			{spellID = 91816, unitID = "player", caster = "player", filter = "BUFF"},
			-- Impatience of Youth (Strength, Use)
			{spellID = 91828, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Victory (Strength, Use)
			{spellID = 92224, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Victory (Strength, Proc)
			{spellID = 92216, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dwyer's Caber (Crit, Use)
			{spellID = 100322, unitID = "player", caster = "player", filter = "BUFF"},
			-- Apparatus of Khaz'goroth (Titanic Power, Proc)
			{spellID = 96923, unitID = "player", caster = "player", filter = "BUFF"},
			-- Apparatus of Khaz'goroth (Highest Stat, Use)
			{spellID = 96929, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of the Eternal Flame (Strength, Use)
			{spellID = 97010, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rotting Skull (Strength, Use)
			{spellID = 107949, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Creche of the Final Dragon (Crit, Proc)
			{spellID = 109744, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rosary of Light (Crit, Proc)
			{spellID = 102660, unitID = "player", caster = "player", filter = "BUFF"},
			-- Varo'then's Brooch (Mastery, Proc)
			{spellID = 102664, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Windwalk (Dodge and Movement)
			{spellID = 74243, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (AP)
			{spellID = 75176, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Landslide (AP)
			{spellID = 74245, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Colossus Smash
			{spellID = 86346, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rend
			{spellID = 94009, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sunder Armor
			{spellID = 7386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Thunder Clap
			{spellID = 6343, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Infected Wounds
			{spellID = 48484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frost Fever
			{spellID = 55095, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Demoralizing Shout
			{spellID = 1160, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Demoralizing Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Weakness
			{spellID = 702, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Judgements of the Just
			{spellID = 68055, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Vindication
			{spellID = 26017, unitID = "target", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Pummel
			{spellID = 6552, filter = "CD"},
			-- Shield Slam
			{spellID = 23922, filter = "CD"},
			-- Shockwave
			{spellID = 46968, filter = "CD"},
			-- Thunder Clap
			{spellID = 6343, filter = "CD"},
			-- Charge
			{spellID = 100, filter = "CD"},
			-- Intervene
			{spellID = 3411, filter = "CD"},
			-- Intercept
			{spellID = 20252, filter = "CD"},
			-- Spell Reflection
			{spellID = 23920, filter = "CD"},
			-- Concussion Blow
			{spellID = 12809, filter = "CD"},
			-- Shield Block
			{spellID = 2565, filter = "CD"},
			-- Enraged Regeneration
			{spellID = 55694, filter = "CD"},
			-- Colossus Smash
			{spellID = 86346, filter = "CD"},
			-- Commanding Shout
			{spellID = 469, filter = "CD"},
			-- Raging Blow
			{spellID = 85288, filter = "CD"},
			-- Whirlwind
			{spellID = 1680, filter = "CD"},
			-- Taunt
			{spellID = 355, filter = "CD"},
			-- Berserker Rage
			{spellID = 18499, filter = "CD"},
			-- Inner Rage
			{spellID = 1134, filter = "CD"},
			-- Heroic Leap
			{spellID = 6544, filter = "CD"},
			-- Rallying Cry
			{spellID = 97462, filter = "CD"},
			-- Disarm
			{spellID = 676, filter = "CD"},
			-- Throwdown
			{spellID = 85388, filter = "CD"},

			-- Racials
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},

			-- Other
			-- Gloves
			{ slotID = 10, filter = "CD"},
			-- Belt
			{ slotID = 6, filter = "CD"},
			-- Back
			{ slotID = 15, filter = "CD"},
			-- Trinkets
			{ slotID = 13, filter = "CD"},
			{ slotID = 14, filter = "CD"},

			-- Internal
			-- Find Weakness (Creche of the Final Dragon)
			{spellID = 109744, filter = "ICD", trigger = "BUFF", duration = 115},
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["SHAMAN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Maelstorm Weapon
			{spellID = 53817, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shamanistic rage
			{spellID = 30823, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Shield
			{spellID = 324, unitID = "player", caster = "player", filter = "BUFF"},
			-- Water Shield
			{spellID = 52127, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental mastery
			{spellID = 64701, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spiritwalker's grace
			{spellID = 79206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Flame
			{spellID = 73683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Life
			{spellID = 73685, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Insight
			{spellID = 77800, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature Guardian
			{spellID = 31616, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Clearcasting
			{spellID = 16246, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tidal Waves
			{spellID = 51562, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lava flows
			{spellID = 65264, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneclaw Totem
			{spellID = 55277, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Caster General
			-- Ti'tahk, the Steps of Time (Haste, Proc)
			{spellID = 107804, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Essence of the Cyclone (Crit, Proc)
			{spellID = 92126, unitID = "player", caster = "player", filter = "BUFF"},
			-- Prestor's Talisman of Machination (Haste, Proc)
			{spellID = 92124, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unsolvable Riddle (Agility, Use)
			{spellID = 92123, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unheeded Warning (Weapon Damage, Proc)
			{spellID = 92108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Conquest (Agility, Use)
			{spellID = 92226, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Conquest (Agility, Proc)
			{spellID = 92220, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ricket's Magnetic Fireball (Crit, Use)
			{spellID = 101515, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ancient Petrified Seed (Agility, Use)
			{spellID = 97009, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Hungerer (Haste, Proc)
			{spellID = 96911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Matrix Restabilizer (Highest Stat, Proc)
			{spellID = 96979, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kiroptyric Sigil (Agility, Use)
			{spellID = 109715, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrow of Time (Haste, Proc)
			{spellID = 102659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Soul Casket (Spell Power, Use)
			{spellID = 91019, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shard of Woe (Haste, Use)
			{spellID = 91173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Dominance (Spell Power, Use)
			{spellID = 92225, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Dominance (Spell Power, Proc)
			{spellID = 92218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Chalice (Mastery, Use)
			{spellID = 100403, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Zeth (Intellect, Use)
			{spellID = 97007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottled Wishes (Spell Power, Use)
			{spellID = 109792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Foul Gift of the Demon Lord (Mastery, Proc)
			{spellID = 102663, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Bell of Enraging Resonance (Spell Power, Proc)
			{spellID = 91007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Volcano (Intellect, Proc)
			{spellID = 89091, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Spell Power, Proc)
			{spellID = 91027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Haste, Use)
			{spellID = 91041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stump of Time (Spell Power, Proc)
			{spellID = 91047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Theralion's Mirror (Mastery, Proc)
			{spellID = 91024, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Core of Ripeness (Spirit, Use)
			{spellID = 91155, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fall of Mortality (Spirit, Proc)
			{spellID = 91184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jar of Ancient Remedies (Debuff)
			{spellID = 91322, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Mandala of Stirring Patterns (Intellect, Proc)
			{spellID = 91192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Quintessence (Intellect, Use)
			{spellID = 97008, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jaws of Defeat (Manacost, Use)
			{spellID = 96908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Universal Trinket (Haste, Proc)
			--{spellID = 109789, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (AP)
			{spellID = 75176, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Landslide (AP)
			{spellID = 74245, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Lightweave (Intellect)
			{spellID = 75170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Torrent (Intellect)
			{spellID = 74241, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Darkglow (Spirit)
			{spellID = 75173, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Storm Strike
			{spellID = 17364, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Earth Shock
			{spellID = 8042, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Flame Shock
			{spellID = 8050, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Searing Flames
			{spellID = 77661, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Earthgrab
			{spellID = 64695, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Bind Elemental
			{spellID = 76780, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(Filger_Settings.target_bar)},

			-- Earth Shield
			{spellID = 974, unitID = "target", caster = "player", filter = "BUFF"},
			-- Riptide
			{spellID = 61295, unitID = "target", caster = "player", filter = "BUFF"},
			-- Ancestral Fortitude
			{spellID = 16236, unitID = "target", caster = "player", filter = "BUFF"},
			-- Earthliving
			{spellID = 51945, unitID = "target", caster = "player", filter = "BUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(Filger_Settings.pve_cc)},

			-- Hex
			{spellID = 51514, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Bind elemental 
			{spellID = 76780, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Earth Shock
			{spellID = 8042, filter = "CD"},
			-- Riptide
			{spellID = 61295, filter = "CD"},
			-- Thunderstorm
			{spellID = 51490, filter = "CD"},
			-- Lava Burst
			{spellID = 51505, filter = "CD"},
			-- Lava Lash
			{spellID = 60103, filter = "CD"},
			-- Wind Shear
			{spellID = 57994, filter = "CD"},
			-- Earthbind Totem
			{spellID = 2484, filter = "CD"},
			-- Stoneclaw Totem
			{spellID = 5730, filter = "CD"},
			-- Tremor totem
			{spellID = 8143, filter = "CD"},
			-- Feral Spirit
			{spellID = 51533, filter = "CD"},
			-- Shamanistic Rage
			{spellID = 30823, filter = "CD"},
			-- Stormstrike
			{spellID = 17364, filter = "CD"},
			-- Spiritwalker's grace
			{spellID = 79206, filter = "CD"},
			-- Healing rain
			{spellID = 73920, filter = "CD"},
			-- Unleash weapon
			{spellID = 73680, filter = "CD"},

			-- Racials
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Lightweave
			{spellID = 75170, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Power Torrent
			{spellID = 74241, slotID = 16, filter = "ICD", trigger = "BUFF", duration = 45},
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Self
			-- Divine Shield
			{spellID = 642, unitID = "player", caster = "player", filter = "BUFF"},
			-- Judgements of the Pure
			{spellID = 53671, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inquisition
			{spellID = 84963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86698, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avenging Wrath
			{spellID = 31884, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Plea
			{spellID = 54428, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Favor
			{spellID = 31842, unitID = "player", caster = "player", filter = "BUFF"},
			-- Speed of Light
			{spellID = 85497, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "player", caster = "player", filter = "BUFF"},
			-- Argent Defender
			{spellID = 31850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Zealotry
			{spellID = 85696, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Shield
			{spellID = 20925, unitID = "player", caster = "player", filter = "BUFF"},

			-- Other
			-- Saint's Vigor (T13 Holy 2P Bonus)
			{spellID = 105742, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Infusion of Light
			{spellID = 54149, unitID = "player", caster = "player", filter = "BUFF"},
			-- Daybreak
			{spellID = 88819, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grand Crusader
			{spellID = 85416, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sacred Duty
			{spellID = 85433, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Art of War
			{spellID = 59578, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Purpose
			{spellID = 90174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Long Arm of the Law
			{spellID = 87173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sacred Shield
			{spellID = 96263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Guardian of Ancient Kings Ret PROC
			{spellID = 86700, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Bedrock Talisman (Dodge, Proc)
			{spellID = 92233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Earthquake (Health, Use)
			{spellID = 89181, unitID = "player", caster = "player", filter = "BUFF"},
			-- Symbiotic Worm (Mastery, Proc)
			{spellID = 92235, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Stolen Memories (Dodge, Use)
			{spellID = 92213, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Phial (Dodge, Use)
			{spellID = 101156, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spidersilk Spindle (Absorb, Proc)
			{spellID = 96945, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stay of Execution (Absorb, Use)
			{spellID = 96988, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stay of Execution (Drawback)
			{spellID = 96993, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Soulshifter Vortex (Mastery, Proc)
			{spellID = 109776, unitID = "player", caster = "player", filter = "BUFF"},
			-- Indomitable Pride (Absorb, Proc)
			{spellID = 109786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire of the Deep (Dodge, Use)
			{spellID = 109779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Veil of Lies (Dodge, Proc)
			{spellID = 102667, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Strength DPS
			-- Crushing Weight (Haste, Proc)
			{spellID = 91821, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of Angerforge (Raw Fury, Proc)
			{spellID = 91832, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of Angerforge (Strength, Use)
			{spellID = 91836, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Rage (Strength, Proc)
			{spellID = 91816, unitID = "player", caster = "player", filter = "BUFF"},
			-- Impatience of Youth (Strength, Use)
			{spellID = 91828, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Victory (Strength, Use)
			{spellID = 92224, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Victory (Strength, Proc)
			{spellID = 92216, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dwyer's Caber (Crit, Use)
			{spellID = 100322, unitID = "player", caster = "player", filter = "BUFF"},
			-- Apparatus of Khaz'goroth (Titanic Power, Proc)
			{spellID = 96923, unitID = "player", caster = "player", filter = "BUFF"},
			-- Apparatus of Khaz'goroth (Highest Stat, Use)
			{spellID = 96929, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of the Eternal Flame (Strength, Use)
			{spellID = 97010, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rotting Skull (Strength, Use)
			{spellID = 107949, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Creche of the Final Dragon (Crit, Proc)
			{spellID = 109744, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rosary of Light (Crit, Proc)
			{spellID = 102660, unitID = "player", caster = "player", filter = "BUFF"},
			-- Varo'then's Brooch (Mastery, Proc)
			{spellID = 102664, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Soul Casket (Spell Power, Use)
			{spellID = 91019, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shard of Woe (Haste, Use)
			{spellID = 91173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Dominance (Spell Power, Use)
			{spellID = 92225, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Dominance (Spell Power, Proc)
			{spellID = 92218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Chalice (Mastery, Use)
			{spellID = 100403, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Zeth (Intellect, Use)
			{spellID = 97007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Core of Ripeness (Spirit, Use)
			{spellID = 91155, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fall of Mortality (Spirit, Proc)
			{spellID = 91184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jar of Ancient Remedies (Debuff)
			{spellID = 91322, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Mandala of Stirring Patterns (Intellect, Proc)
			{spellID = 91192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Quintessence (Intellect, Use)
			{spellID = 97008, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jaws of Defeat (Manacost, Use)
			{spellID = 96908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reflection of the Light (Spell Power, Use)
			{spellID = 109792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Universal Trinket (Haste, Proc)
			--{spellID = 109789, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Windwalk (Dodge and Movement)
			{spellID = 74243, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (AP)
			{spellID = 75176, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Landslide (AP)
			{spellID = 74245, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Lightweave (Intellect)
			{spellID = 75170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Torrent (Intellect)
			{spellID = 74241, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Darkglow (Spirit)
			{spellID = 75173, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Forbearance
			{spellID = 25771, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Censure
			{spellID = 31803, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seal of Justice
			{spellID = 20170, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Denounce
			{spellID = 85509, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Dazed - Avenger's Shield
			{spellID = 63529, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Rebuke
			{spellID = 96231, filter = "CD"},
			-- Hammer of Justice
			{spellID = 853, filter = "CD"},
			-- Repentance
			{spellID = 20066, filter = "CD"},
			-- Judgement
			{spellID = 20271, filter = "CD"},
			-- Hand of Freedom
			{spellID = 1044, filter = "CD"},
			-- Avenger's Shield
			{spellID = 31935, filter = "CD"},
			-- Holy Wrath
			{spellID = 2812, filter = "CD"},
			-- Word of Glory
			{spellID = 85673, filter = "CD"},
			-- Consecration
			{spellID = 26573, filter = "CD"},
			-- Divine Protection
			{spellID = 498, filter = "CD"},
			-- Avenging Wrath
			{spellID = 31884, filter = "CD"},
			-- Divine Plea
			{spellID = 54428, filter = "CD"},
			-- Hand of Sacrifice
			{spellID = 6940, filter = "CD"},
			-- Hand of Salvation
			{spellID = 1038, filter = "CD"},
			-- Aura Mastery
			{spellID = 31821, filter = "CD"},
			-- Divine Favor
			{spellID = 31842, filter = "CD"},
			-- Zealotry
			{spellID = 85696, filter = "CD"},
			-- Ardent Defender
			{spellID = 31850, filter = "CD"},
			-- Hand of Protection
			{spellID = 1022, filter = "CD"},
			-- Holy Shield
			{spellID = 20925, filter = "CD"},

			-- Racials
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Find Weakness (Creche of the Final Dragon)
			{spellID = 109744, filter = "ICD", trigger = "BUFF", duration = 115},
			-- Lightweave
			{spellID = 75170, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Power Torrent
			{spellID = 74241, slotID = 16, filter = "ICD", trigger = "BUFF", duration = 45},
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["PRIEST"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Power Word: Shield
			{spellID = 17, unitID = "player", caster = "all", filter = "BUFF"},
			-- Renew
			{spellID = 139, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dispersion
			{spellID = 47585, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fade
			{spellID = 586, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "player", caster = "player", filter = "BUFF"},
			-- Borrowed Time
			{spellID = 59887, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inner Fire
			--{spellID = 588, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inner Will
			--{spellID = 73413, unitID = "player", caster = "player", filter = "BUFF"},
			-- Archangel
			{spellID = 81700, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Archangel
			{spellID = 87153, unitID = "player", caster = "player", filter = "BUFF"},
			-- Strength of Soul
			{spellID = 96267, unitID = "player", caster = "player", filter = "BUFF"},
			-- Prayer of Mending
			{spellID = 41635, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Walk
			{spellID = 96219, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Surge of Light
			{spellID = 88688, unitID = "player", caster = "player", filter = "BUFF"},
			-- Serendipity
			{spellID = 63731, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Orb
			{spellID = 77487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Empowered Shadow
			{spellID = 95799, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evangelism
			{spellID = 81661, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Evangelism
			{spellID = 87117, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mind melt
			{spellID = 87160, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chakra: Sanctuary
			{spellID = 81206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chakra: Serenity
			{spellID = 81208, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chakra: Chastise
			{spellID = 81209, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Caster General
			-- Ti'tahk, the Steps of Time (Haste, Proc)
			{spellID = 107804, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Soul Casket (Spell Power, Use)
			{spellID = 91019, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shard of Woe (Haste, Use)
			{spellID = 91173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Dominance (Spell Power, Use)
			{spellID = 92225, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Dominance (Spell Power, Proc)
			{spellID = 92218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Chalice (Mastery, Use)
			{spellID = 100403, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Zeth (Intellect, Use)
			{spellID = 97007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottled Wishes (Spell Power, Use)
			{spellID = 109792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Foul Gift of the Demon Lord (Mastery, Proc)
			{spellID = 102663, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Bell of Enraging Resonance (Spell Power, Proc)
			{spellID = 91007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Volcano (Intellect, Proc)
			{spellID = 89091, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Spell Power, Proc)
			{spellID = 91027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Haste, Use)
			{spellID = 91041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stump of Time (Spell Power, Proc)
			{spellID = 91047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Theralion's Mirror (Mastery, Proc)
			{spellID = 91024, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Core of Ripeness (Spirit, Use)
			{spellID = 91155, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fall of Mortality (Spirit, Proc)
			{spellID = 91184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jar of Ancient Remedies (Debuff)
			{spellID = 91322, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Mandala of Stirring Patterns (Intellect, Proc)
			{spellID = 91192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Quintessence (Intellect, Use)
			{spellID = 97008, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jaws of Defeat (Manacost, Use)
			{spellID = 96908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Universal Trinket (Haste, Proc)
			--{spellID = 109789, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Lightweave (Intellect)
			{spellID = 75170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Torrent (Intellect)
			{spellID = 74241, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Darkglow (Spirit)
			{spellID = 75173, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Mind spike
			{spellID = 87178, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(Filger_Settings.target_bar)},

			-- Renew
			{spellID = 139, unitID = "target", caster = "player", filter = "BUFF"},
			-- Prayer of Mending
			{spellID = 41635, unitID = "target", caster = "player", filter = "BUFF"},
			-- Guardian spirit
			{spellID = 47788, unitID = "target", caster = "player", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "player", filter = "BUFF"},
			-- Grace
			{spellID = 77613, unitID = "target", caster = "player", filter = "BUFF"},
			-- Shadow Word: Pain
			{spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Devouring Plague
			{spellID = 2944, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vampiric Touch
			{spellID = 34914, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(Filger_Settings.pve_cc)},

			-- Shackle undead
			{spellID = 9484, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Penance
			{spellID = 47540, filter = "CD"},
			-- Pain Suppression
			{spellID = 33206, filter = "CD"},
			-- Power Infusion
			{spellID = 10060, filter = "CD"},
			-- Psychic Scream
			{spellID = 8122, filter = "CD"},
			-- Circle of Healing
			{spellID = 34861, filter = "CD"},
			-- Guardian Spirit
			{spellID = 47788, filter = "CD"},
			-- Prayer of Mending
			{spellID = 33076, filter = "CD"},
			-- Silence
			{spellID = 15487, filter = "CD"},
			-- Holy Fire
			{spellID = 14914, filter = "CD"},
			-- Shadow Word: Death
			{spellID = 32379, filter = "CD"},
			-- Dispersion
			{spellID = 47585, filter = "CD"},
			-- Psychic Horror
			{spellID = 64044, filter = "CD"},
			-- Holy Word: Chastise
			{spellID = 88625, filter = "CD"},
			-- Power Word: Barrier
			{spellID = 62618, filter = "CD"},
			-- Inner Focus
			{spellID = 89485, filter = "CD"},
			-- Archangel
			{spellID = 87151, filter = "CD"},
			-- Chakra
			{spellID = 14751, filter = "CD"},
			-- Desperate Prayer
			{spellID = 19236, filter = "CD"},
			-- Leap of Faith
			{spellID = 73325, filter = "CD"},

			-- Racials
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Lightweave
			{spellID = 75170, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Power Torrent
			{spellID = 74241, slotID = 16, filter = "ICD", trigger = "BUFF", duration = 45},
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["WARLOCK"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Self
			-- Burning Soul
			{spellID = 74434, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demon Soul Succub
			{spellID = 79463, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demon Soul Imp
			{spellID = 79459, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demon Soul Void
			{spellID = 79464, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demon Soul Fel Hunter
			{spellID = 79460, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demon Soul Fel Guard
			{spellID = 79462, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Intent
			{spellID = 85768, unitID = "player", caster = "all", filter = "BUFF"},
			-- Shadow Ward
			{spellID = 6229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Swap
			{spellID = 86211, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Molten Core
			{spellID = 47383, unitID = "player", caster = "player", filter = "BUFF"},
			-- Decimation
			{spellID = 63158, unitID = "player", caster = "player", filter = "BUFF"},
			-- Backdraft
			{spellID = 54277, unitID = "player", caster = "player", filter = "BUFF"},
			-- Backlash
			{spellID = 34939, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nether Protection
			{spellID = 30301, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightfall
			{spellID = 18095, unitID = "player", caster = "player", filter = "BUFF"},
			-- Eradication
			{spellID = 47195, unitID = "player", caster = "player", filter = "BUFF"},
			-- Improved Soul Fire
			{spellID = 85383, unitID = "player", caster = "player", filter = "BUFF"},
			-- Empowered Imp
			{spellID = 47283, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fel Spark
			{spellID = 89937, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demonic Rebirth
			{spellID = 88447, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Trance
			{spellID = 17941, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Caster General
			-- Ti'tahk, the Steps of Time (Haste, Proc)
			{spellID = 107804, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Soul Casket (Spell Power, Use)
			{spellID = 91019, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shard of Woe (Haste, Use)
			{spellID = 91173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Dominance (Spell Power, Use)
			{spellID = 92225, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Dominance (Spell Power, Proc)
			{spellID = 92218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Chalice (Mastery, Use)
			{spellID = 100403, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Zeth (Intellect, Use)
			{spellID = 97007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottled Wishes (Spell Power, Use)
			{spellID = 109792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Foul Gift of the Demon Lord (Mastery, Proc)
			{spellID = 102663, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Bell of Enraging Resonance (Spell Power, Proc)
			{spellID = 91007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Volcano (Intellect, Proc)
			{spellID = 89091, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Spell Power, Proc)
			{spellID = 91027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Ignacious (Haste, Use)
			{spellID = 91041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stump of Time (Spell Power, Proc)
			{spellID = 91047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Theralion's Mirror (Mastery, Proc)
			{spellID = 91024, unitID = "player", caster = "player", filter = "BUFF"},
			-- Universal Trinket (Haste, Proc)
			--{spellID = 109789, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Lightweave (Intellect)
			{spellID = 75170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Torrent (Intellect)
			{spellID = 74241, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Self
			-- Shadow Embrace
			{spellID = 32389, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Curse of Tongues
			{spellID = 1714, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Exhaustion
			{spellID = 18223, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Weakness
			{spellID = 702, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Death Coil
			{spellID = 6789, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Enslave Demon
			{spellID = 1098, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shadowsnare
			{spellID = 63311, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Other
			-- Curse of the Elements (Warlock)
			{spellID = 1490, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of the Elements: Jinx (Warlock)
			{spellID = 86105, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Earth and Moon (Moonkin)
			{spellID = 48506, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ebon Plaguebringer (DK)
			{spellID = 65142, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Master poisoner (Rogue)
			{spellID = 93068, unitID = "target", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(Filger_Settings.target_bar)},

			-- Corruption
			{spellID = 172, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immolate
			{spellID = 348, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Bane of Agony
			{spellID = 980, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Bane of Doom
			{spellID = 603, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 30108, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Haunt
			{spellID = 48181, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seed of Corruption
			{spellID = 27243, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(Filger_Settings.pve_cc)},

			-- Fear
			{spellID = 5782, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Banish
			{spellID = 710, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Conflagrate
			{spellID = 17962, filter = "CD"},
			-- Ritual of Summoning
			{spellID = 698, filter = "CD"},
			-- Shadow Ward
			{spellID = 6229, filter = "CD"},
			-- Demonic Empowerment
			{spellID = 47193, filter = "CD"},
			-- Demon Leap
			{spellID = 54785, filter = "CD"},
			-- Soulshatter
			{spellID = 29858, filter = "CD"},
			-- Demonic Circle: Teleport
			{spellID = 48020, filter = "CD"},
			-- Howl of Terror
			{spellID = 5484, filter = "CD"},
			-- Death Coil
			{spellID = 6789, filter = "CD"},
			-- Haunt
			{spellID = 48181, filter = "CD"},
			-- Shadowburn
			{spellID = 17877, filter = "CD"},
			-- Shadowfury
			{spellID = 30283, filter = "CD"},
			-- Chaos Bolt
			{spellID = 50796, filter = "CD"},
			-- Shadowflame
			{spellID = 47897, filter = "CD"},
			-- Fel Domination
			{spellID = 18708, filter = "CD"},
			-- Sacrifice (Voidwalker)
			{spellID = 7812, filter = "CD"},
			-- Suffering (Voidwalker)
			{spellID = 17735, filter = "CD"},
			-- Spell Lock (Felhunter)
			{spellID = 19647, filter = "CD"},
			-- Devour Magic (Felhunter)
			{spellID = 19505, filter = "CD"},
			-- Soul Harvest
			{spellID = 79268, filter = "CD"},
			-- Felstorm
			{spellID = 89751, filter = "CD"},
			-- Soulburn
			{spellID = 74434, filter = "CD"},
			-- Hand of Gul'dan
			{spellID = 71521, filter = "CD"},
			-- Immolation Aura
			{spellID = 50589, filter = "CD"},

			-- Racials
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Lightweave
			{spellID = 75170, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Power Torrent
			{spellID = 74241, slotID = 16, filter = "ICD", trigger = "BUFF", duration = 45},
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["ROGUE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Self
			-- Sprint
			{spellID = 2983, unitID = "player", caster = "player", filter = "BUFF"},
			-- Adrenaline Rush
			{spellID = 13750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "player", caster = "player", filter = "BUFF"},
			-- Envenom
			{spellID = 32645, unitID = "player", caster = "player", filter = "BUFF"},
			-- Overkill
			{spellID = 58426, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slice and Dice
			{spellID = 5171, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow dance
			{spellID = 51713, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recuperate
			{spellID = 73651, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowstep
			{spellID = 36563, unitID = "player", caster = "player", filter = "BUFF"},
			-- Master of subtlety
			{spellID = 31665, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cloak of Shadows
			{spellID = 31224, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vanish
			{spellID = 1856, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cheating death
			{spellID = 45182, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blade Flurry
			{spellID = 13877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shallow Insight
			{spellID = 84745, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moderate Insight
			{spellID = 84746, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Insight
			{spellID = 84747, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Combat Readiness
			{spellID = 74001, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Essence of the Cyclone (Crit, Proc)
			{spellID = 92126, unitID = "player", caster = "player", filter = "BUFF"},
			-- Prestor's Talisman of Machination (Haste, Proc)
			{spellID = 92124, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unsolvable Riddle (Agility, Use)
			{spellID = 92123, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unheeded Warning (Weapon Damage, Proc)
			{spellID = 92108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Conquest (Agility, Use)
			{spellID = 92226, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Conquest (Agility, Proc)
			{spellID = 92220, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ricket's Magnetic Fireball (Crit, Use)
			{spellID = 101515, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ancient Petrified Seed (Agility, Use)
			{spellID = 97009, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Hungerer (Haste, Proc)
			{spellID = 96911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Matrix Restabilizer (Highest Stat, Proc)
			{spellID = 96979, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kiroptyric Sigil (Agility, Use)
			{spellID = 109715, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrow of Time (Haste, Proc)
			{spellID = 102659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Universal Trinket (Haste, Proc)
			--{spellID = 109789, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (AP)
			{spellID = 75176, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Landslide (AP)
			{spellID = 74245, unitID = "player", caster = "player", filter = "BUFF"},

			-- Other
			-- Future on Fire (T12 x4)
			{spellID = 99186, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Devastation (T12 x4)
			{spellID = 99187, unitID = "player", caster = "player", filter = "BUFF"},
			-- Master of Flames (T12 x4)
			{spellID = 99188, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadows of the Destroyer
			{spellID = 109941, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of the Destroyer
			{spellID = 109949, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.target_debuff_icon)},

			-- Rupture
			{spellID = 1943, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Garrote
			{spellID = 703, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Expose Armor
			{spellID = 8647, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Dismantle
			{spellID = 51722, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Revealing Strike
			{spellID = 84617, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vendetta
			{spellID = 79140, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Waylay
			{spellID = 51693, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hemorrhage
			{spellID = 16511, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Glyph of Hemorrhage 
			{spellID = 89775, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Find Weakness
			{spellID = 91021, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 88611, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Deadly Poison
			{spellID = 2818, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind-numbing Poison
			{spellID = 5760, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Crippling Poison
			{spellID = 3409, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Wound Poison
			{spellID = 13218, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {unpack(Filger_Settings.pve_cc)},

			-- Blind
			{spellID = 2094, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Kick
			{spellID = 1766, filter = "CD"},
			-- Gouge
			{spellID = 1776, filter = "CD"},
			-- Kidney shot
			{spellID = 408, filter = "CD"},
			-- Killing Spree
			{spellID = 51690, filter = "CD"},
			-- Adrenaline Rush
			{spellID = 13750, filter = "CD"},
			-- Stealth
			{spellID = 1784, filter = "CD"},
			-- Vanish
			{spellID = 1856, filter = "CD"},
			-- Shadow dance
			{spellID = 51713, filter = "CD"},
			-- Redirect
			{spellID = 73981, filter = "CD"},
			-- Combat Readiness
			{spellID = 74001, filter = "CD"},
			-- Vendetta
			{spellID = 79140, filter = "CD"},
			-- Feint
			{spellID = 1966, filter = "CD"},
			-- Premiditation
			{spellID = 14183, filter = "CD"},
			-- Sprint
			{spellID = 2983, filter = "CD"},
			-- Dismantle
			{spellID = 51722, filter = "CD"},

			-- Racials
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["DEATHKNIGHT"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_buff_icon)},

			-- Self
			-- Bone Shield
			{spellID = 49222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Blood
			{spellID = 55233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Icebound Fortitude
			{spellID = 48792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Anti-Magic Shell
			{spellID = 48707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dancing Rune Weapon
			{spellID = 49028, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lichborne
			{spellID = 49039, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pillar of Frost
			{spellID = 51271, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.player_proc_icon)},

			-- Buffs
			-- Freezing Fog
			{spellID = 59052, unitID = "player", caster = "player", filter = "BUFF"},
			-- Killing Machine
			{spellID = 51124, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sudden Doom
			{spellID = 81340, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crimson Scourge
			{spellID = 81141, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unholy Strength
			{spellID = 53365, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Battlemaster Trinket (Health, Use)
			{spellID = 92223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of Broken Images (Resistance, Use)
			{spellID = 92222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Bedrock Talisman (Dodge, Proc)
			{spellID = 92233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmoon Card: Earthquake (Health, Use)
			{spellID = 89181, unitID = "player", caster = "player", filter = "BUFF"},
			-- Symbiotic Worm (Mastery, Proc)
			{spellID = 92235, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Stolen Memories (Dodge, Use)
			{spellID = 92213, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moonwell Phial (Dodge, Use)
			{spellID = 101156, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spidersilk Spindle (Absorb, Proc)
			{spellID = 96945, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stay of Execution (Absorb, Use)
			{spellID = 96988, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stay of Execution (Drawback)
			{spellID = 96993, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Soulshifter Vortex (Mastery, Proc)
			{spellID = 109776, unitID = "player", caster = "player", filter = "BUFF"},
			-- Indomitable Pride (Absorb, Proc)
			{spellID = 109786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire of the Deep (Dodge, Use)
			{spellID = 109779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Veil of Lies (Dodge, Proc)
			{spellID = 102667, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Strength DPS
			-- Crushing Weight (Haste, Proc)
			{spellID = 91821, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of Angerforge (Raw Fury, Proc)
			{spellID = 91832, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of Angerforge (Strength, Use)
			{spellID = 91836, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of Rage (Strength, Proc)
			{spellID = 91816, unitID = "player", caster = "player", filter = "BUFF"},
			-- Impatience of Youth (Strength, Use)
			{spellID = 91828, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Badge of Victory (Strength, Use)
			{spellID = 92224, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gladiator's Insignia of Victory (Strength, Proc)
			{spellID = 92216, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dwyer's Caber (Crit, Use)
			{spellID = 100322, unitID = "player", caster = "player", filter = "BUFF"},
			-- Apparatus of Khaz'goroth (Titanic Power, Proc)
			{spellID = 96923, unitID = "player", caster = "player", filter = "BUFF"},
			-- Apparatus of Khaz'goroth (Highest Stat, Use)
			{spellID = 96929, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of the Eternal Flame (Strength, Use)
			{spellID = 97010, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rotting Skull (Strength, Use)
			{spellID = 107949, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Creche of the Final Dragon (Crit, Proc)
			{spellID = 109744, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rosary of Light (Crit, Proc)
			{spellID = 102660, unitID = "player", caster = "player", filter = "BUFF"},
			-- Varo'then's Brooch (Mastery, Proc)
			{spellID = 102664, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Hurricane (Haste)
			{spellID = 74221, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Windwalk (Dodge and Movement)
			{spellID = 74243, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (AP)
			{spellID = 75176, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Landslide (AP)
			{spellID = 74245, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {unpack(Filger_Settings.target_bar)},

			-- Blood Plague
			{spellID = 59879, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Fever
			{spellID = 59921, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unholy Blight
			{spellID = 49194, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Summon Gargoyle
			{spellID = 49206, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(Filger_Settings.cooldown)},

			-- Self
			-- Death Grip
			{spellID = 49576, filter = "CD"},
			-- Anti-Magic Shell
			{spellID = 48707, filter = "CD"},
			-- Horn of Winter
			{spellID = 57330, filter = "CD"},
			-- Blood Tap
			{spellID = 45529, filter = "CD"},
			-- Death Pact
			{spellID = 48743, filter = "CD"},
			-- Icebound Fortitude
			{spellID = 48792, filter = "CD"},
			-- Death and Decay
			{spellID = 43265, filter = "CD"},
			-- Raise Dead
			{spellID = 46584, filter = "CD"},
			-- Summon Gargoyle
			{spellID = 49206, filter = "CD"},
			-- Gnaw
			{spellID = 47481, filter = "CD"},
			-- Strangulate
			{spellID = 47476, filter = "CD"},
			-- Mind Freeze
			{spellID = 47528, filter = "CD"},
			-- Rune Tap
			{spellID = 48982, filter = "CD"},
			-- Vampiric Blood
			{spellID = 55233, filter = "CD"},
			-- Lichborne
			{spellID = 49039, filter = "CD"},
			-- Dancing Rune Weapon
			{spellID = 49028, filter = "CD"},
			-- Pillar of Frost
			{spellID = 51271, filter = "CD"},
			-- Hungering Cold
			{spellID = 49203, filter = "CD"},
			-- Unholy Frenzy
			{spellID = 49016, filter = "CD"},
			-- Anti-Magic Zone
			{spellID = 51052, filter = "CD"},

			-- Racials
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},

			-- Other
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Back
			{slotID = 15, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Find Weakness (Creche of the Final Dragon)
			{spellID = 109744, filter = "ICD", trigger = "BUFF", duration = 115},
			-- Velocity (Starcatcher Compass, Insignia of the Corrupted Mind, Seal of the Seven Signs)
			--{spellID = 109789, filter = "ICD", trigger = "BUFF", duration = 115},
		},
	},
	["ALL"] = {
		{
			Name = "SPECIAL_P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(Filger_Settings.special_proc_icon)},

			-- Potions
			-- Tol'vir Agility
			{spellID = 79633, unitID = "player", caster = "player", filter = "BUFF"},
			-- Golem's Strength
			{spellID = 79634, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volcanic Power
			{spellID = 79476, unitID = "player", caster = "player", filter = "BUFF"},
			-- Speed from BG
			--{spellID = 23451, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			{spellID = 23451, unitID = "player", caster = "all", filter = "BUFF"},
			-- Speed from Potion
			--{spellID = 2379, unitID = "player", caster = "all", filter = "BUFF", absID = true},

			-- Leeroy Jenkins
			-- Bloodlust
			{spellID = 2825, unitID = "player", caster = "all", filter = "BUFF"},
			-- Heroism
			{spellID = 32182, unitID = "player", caster = "all", filter = "BUFF"},
			-- Time Warp
			{spellID = 80353, unitID = "player", caster = "all", filter = "BUFF"},
			-- Ancient Hysteria
			{spellID = 90355, unitID = "player", caster = "all", filter = "BUFF"},

			-- Enchants
			-- Hyperspeed Accelerators
			{spellID = 54758, unitID = "player", caster = "player", filter = "BUFF"},
			-- Synapse Springs
			{spellID = 82175, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nitro Boosts
			{spellID = 54861, unitID = "player", caster = "player", filter = "BUFF"},
			-- Parachute
			{spellID = 55001, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grounded Plasma Shield
			{spellID = 82627, unitID = "player", caster = "player", filter = "BUFF"},

			-- Racial
			-- Berserking (Troll)
			{spellID = 26297, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Stoneform (Dwarf)
			{spellID = 65116, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blood Fury (Orc)
			{spellID = 20572, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkflight (Worgen)
			{spellID = 68992, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, unitID = "player", caster = "all", filter = "BUFF"},

			-- Other
			-- Lifeblood
			{spellID = 74497, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightwell
			{spellID = 7001, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Protection
			{spellID = 1022, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Freedom
			{spellID = 1044, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Salvation
			{spellID = 1038, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Sacrifice
			{spellID = 6940, unitID = "player", caster = "all", filter = "BUFF"},
			-- Aura Mastery
			{spellID = 31821, unitID = "player", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "player", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "player", caster = "all", filter = "BUFF"},
			-- Power Infusion
			{spellID = 10060, unitID = "player", caster = "all", filter = "BUFF"},
			-- Unholy Frenzy
			{spellID = 49016, unitID = "player", caster = "all", filter = "BUFF"},
			-- Tricks of the Trade
			{spellID = 57933, unitID = "player", caster = "all", filter = "BUFF"},
			-- Divine Guardian
			{spellID = 70940, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mass Regeneration
			{spellID = 105737, unitID = "player", caster = "all", filter = "BUFF"},
			-- Vampiric Brood
			{spellID = 105588, unitID = "player", caster = "all", filter = "BUFF"},
			-- Shield Fortress
			{spellID = 105914, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Rallying Cry
			{spellID = 97462, unitID = "player", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "player", caster = "all", filter = "BUFF"},
			-- Grounding Totem
			{spellID = 8178, unitID = "player", caster = "all", filter = "BUFF"},
			-- Innervate
			{spellID = 29166, unitID = "player", caster = "all", filter = "BUFF"},
			-- Slow Fall
			{spellID = 130, unitID = "player", caster = "all", filter = "BUFF"},
			-- Levitate
			{spellID = 1706, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "PVE/PVP_DEBUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 60,
			Position = {unpack(Filger_Settings.pve_debuff)},

			-- Death Knight
			-- Gnaw (Pet)
			{spellID = 47481, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gnaw (Pet - mutant)
			{spellID = 91797, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Strangulate
			{spellID = 47476, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chains of Ice
			{spellID = 45524, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Desecration
			{spellID = 55741, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hungering Cold
			{spellID = 49203, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Necrotic strike
			{spellID = 73975, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dark simulacrum
			{spellID = 77606, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chilblains
			{spellID = 50435, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Druid
			-- Skull Bash
			{spellID = 80965, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Solar Beam
			{spellID = 78675, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fungal Growth
			{spellID = 81281, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cyclone
			{spellID = 33786, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Bash
			{spellID = 5211, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pounce
			{spellID = 9005, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Feral Charge Effect
			{spellID = 45334, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Infected Wounds
			{spellID = 58179, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Typhoon
			{spellID = 61391, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Hunter
			-- Aspect of the Pack
			{spellID = 13159, unitID = "player", caster = "all", filter = "BUFF"},
			-- Freezing Trap Effect
			{spellID = 3355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Glyph of Freezing Trap
			{spellID = 61394, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Scare Beast
			{spellID = 1513, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Scatter Shot
			{spellID = 19503, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silencing Shot
			{spellID = 34490, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wyvern sting 
			{spellID = 19386, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussive Barrage
			{spellID = 35101, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussive Shot
			{spellID = 5116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Trap Aura
			{spellID = 13810, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wing Clip
			{spellID = 2974, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Counterattack
			{spellID = 19306, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 19185, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pets
			-- Sonic Blast (Bat)
			{spellID = 50519, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pin (Crab)
			{spellID = 50245, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Venom Web Spray (Silithid)
			{spellID = 54706, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Bad Manner (Monkey)
			{spellID = 90337, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Web (Spider)
			{spellID = 4167, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Froststorm Breath (Chimera)
			{spellID = 54644, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Swoop (Moth)
			{spellID = 53148, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ankle Crack (Crocolisk)
			{spellID = 50433, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Clench (Scorpid)
			{spellID = 50541, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Time Warp (Warp Stalker)
			{spellID = 35346, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sting (Wasp)
			{spellID = 56626, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Nether Shock (Nether Ray)
			{spellID = 44957, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Dragon's Breath
			{spellID = 31661, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Improved Polymorph
			{spellID = 83047, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silenced - Improved Counterspell
			{spellID = 55021, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Deep Freeze
			{spellID = 44572, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Freeze (Water Elemental)
			{spellID = 33395, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shattered Barrier
			{spellID = 55080, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chilled
			{spellID = 6136, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Improved Cone of Cold
			{spellID = 83302, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Impact
			{spellID = 12355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blast Wave
			{spellID = 11113, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cauterize
			{spellID = 87023, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Frostbolt
			{spellID = 116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostfire Bolt
			{spellID = 44614, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Repentance
			{spellID = 20066, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield
			{spellID = 31935, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield with Glyph
			{spellID = 63529, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seal of Justice proc
			{spellID = 20170, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Denounce
			{spellID = 85509, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Priest
			-- Psychic Horror
			{spellID = 64044, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind Control
			{spellID = 605, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind Flay
			{spellID = 15407, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sin and Punishment
			{spellID = 87204, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Paralysis
			{spellID = 87194, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Dismantle
			{spellID = 51722, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Garrote - Silence
			{spellID = 1330, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silenced - Improved Kick
			{spellID = 18425, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blade Twisting
			{spellID = 31125, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Deadly Throw
			{spellID = 26679, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Waylay
			{spellID = 51693, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Crippling Poison
			{spellID = 3409, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind-numbing Poison
			{spellID = 5760, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 88611, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Hex
			{spellID = 51514, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthgrab
			{spellID = 64695, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Stoneclaw Stun
			{spellID = 39796, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthbind
			{spellID = 3600, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthquake
			{spellID = 77505, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostbrand Attack
			{spellID = 8034, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Thunderstorm
			{spellID = 100955, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Aura of Foreboding
			{spellID = 93975, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Demon Leap
			{spellID = 54785, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Death Coil
			{spellID = 6789, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 5782, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Aftermath
			{spellID = 18118, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Curse of Exhaustion
			{spellID = 18223, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Spell Lock (Felhunter)
			{spellID = 24259, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowsnare
			{spellID = 63311, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Warrior
			-- Throwdown
			{spellID = 85388, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidating Shout
			{spellID = 20511, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Disarm
			{spellID = 676, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silenced (Gag Order)
			{spellID = 18498, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Charge Stun
			{spellID = 7922, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussion Blow
			{spellID = 12809, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intercept
			{spellID = 20253, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shockwave
			{spellID = 46968, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Improved Hamstring
			{spellID = 23694, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Piercing Howl
			{spellID = 12323, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Colossus Smash
			{spellID = 86346, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Racials
			-- War Stomp
			{spellID = 20549, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Arcane Torrent
			{spellID = 28730, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Other
			-- Rocket Fuel Leak
			{spellID = 94794, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Reversed Shield
			{spellID = 82406, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Plasma Misfire!
			{spellID = 94549, unitID = "player", caster = "player", filter = "DEBUFF"},

			-- Baradin Hold(PvP)
			-- Meteor Slash/Meteorschlag (Argaloth)
			{spellID = 88942, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Throne of Four Winds
			-- Wind Chill (Conclave of Wind)
			{spellID = 93123, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Slicing Gale (Conclave of Wind)
			{spellID = 93058, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Static Shock (Al'Akir)
			{spellID = 87873, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Acid Rain (Al'Akir)
			{spellID = 93279, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Bastion of Twilight
			-- Blackout (Valiona & Theralion)
			{spellID = 92879, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Engulfing Magic (Valiona & Theralion)
			{spellID = 86631, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Waterlogged (Ascendant Council)
			{spellID = 82762, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frozen (Ascendant Council)
			{spellID = 92503, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Burning Blood (Ascendant Council)
			{spellID = 82660, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Flame Imbued (Ascendant Council)
			{spellID = 82663, unitID = "player", caster = "all", filter = "BUFF"},
			-- Heart of Ice (Ascendant Council)
			{spellID = 82665, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Imbued (Ascendant Council)
			{spellID = 82666, unitID = "player", caster = "all", filter = "BUFF"},
			-- Gravity Core (Ascendant Council)
			{spellID = 92075, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Static Overload (Ascendant Council)
			{spellID = 92067, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Swirling Winds (Ascendant Council)
			{spellID = 83500, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Grounded (Ascendant Council)
			{spellID = 83581, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Magnetic Pull (Ascendant Council)
			{spellID = 83587, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Beacon (Ascendant Council)
			{spellID = 92307, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Lightning Rod (Ascendant Council)
			{spellID = 83099, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Corruption: Accelerated (Cho'gall)
			{spellID = 81836, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Corruption: Malformation (Cho'gall)
			{spellID = 82125, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Corruption: Absolute (Cho'gall)
			{spellID = 82170, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Corruption: Sickness (Cho'gall)
			{spellID = 93200, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fiery Barrier (Sinestra)
			{spellID = 87231, unitID = "player", caster = "all", filter = "BUFF"},
			-- Essence of the Red (Sinestra)
			{spellID = 87946, unitID = "player", caster = "all", filter = "BUFF"},

			-- Blackwing Descent
			-- Constricting Chains (Magmaw)
			{spellID = 91911, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Parasitic Infection (Magmaw)
			{spellID = 94679, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Infectious Vomit (Magmaw)
			{spellID = 91923, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Lightning Conductor (Omnitron Defense System)
			{spellID = 91433, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Flash Freeze (Maloriak)
			{spellID = 77699, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Consuming Flames (Maloriak)
			{spellID = 77786, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Finkle's Mixture (Chimaeron)
			{spellID = 82705, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadow Conductor (Nefarian)
			{spellID = 92053, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Stolen Power (Nefarian)
			{spellID = 80627, unitID = "player", caster = "all", filter = "BUFF"},
			-- Explosive Cinders (Nefarian)
			{spellID = 79339, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Unstable Shield (Omnotron Defense System)
			{spellID = 79900, unitID = "target", caster = "all", filter = "BUFF"},

			-- Firelands
			-- Widows Kiss (Beth'tilac)
			{spellID = 99506, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blazing Power (Alysrazor)
			{spellID = 99461, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Alysra's Razor (Alysrazor)
			{spellID = 100029, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wings of Flame (Alysrazor)
			{spellID = 98619, unitID = "player", caster = "all", filter = "BUFF"},
			-- Jagged Tear (Shannox)
			{spellID = 99937, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Torment (Baleroc)
			{spellID = 100230, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Tormented (Baleroc)
			{spellID = 99403, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Vital Flame (Baleroc)
			{spellID = 99263, unitID = "player", caster = "all", filter = "BUFF"},
			-- Searing Seeds (Majordomo Staghelm)
			{spellID = 98450, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Burning Orb (Majordomo Staghelm)
			{spellID = 100209, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Burning Wound (Ragnaros)
			{spellID = 101240, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blazing Heat (Ragnaros)
			{spellID = 100460, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Dragon Soul
			-- Frostflake (Hagara the Stormbinder)
			{spellID = 109325, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Disrupting Shadows (Zon'ozz)
			{spellID = 103434, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fading Light (Ultraxion)
			{spellID = 109075, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shrapnel (Madness of Deathwing)
			{spellID = 106794, unitID = "player", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "T_BUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 60,
			Position = {unpack(Filger_Settings.target_buff_icon)},

			-- Hunter
			-- Aspect of the Pack
			{spellID = 13159, unitID = "target", caster = "all", filter = "BUFF"},
			-- Aspect of the Cheetah
			{spellID = 5118, unitID = "target", caster = "all", filter = "BUFF"},
			-- Deterrence
			{spellID = 19263, unitID = "target", caster = "all", filter = "BUFF"},

			-- Druid
			-- Innervate
			{spellID = 29166, unitID = "target", caster = "all", filter = "BUFF"},
			-- Barskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nature's grasp 
			{spellID = 16689, unitID = "target", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "target", caster = "all", filter = "BUFF"},
			-- Survival Instincts
			{spellID = 61336, unitID = "target", caster = "all", filter = "BUFF"},
			-- Frenzied Regeneration
			{spellID = 22842, unitID = "target", caster = "all", filter = "BUFF"},
			-- Tree of life
			{spellID = 33891, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserk
			{spellID = 50334, unitID = "target", caster = "all", filter = "BUFF"},

			-- Warrior
			-- Spell Reflection
			{spellID = 23920, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shield wall
			{spellID = 871, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserker
			{spellID = 18499, unitID = "target", caster = "all", filter = "BUFF"},
			-- Last stand
			{spellID = 12976, unitID = "target", caster = "all", filter = "BUFF"},
			-- Bladestorm
			{spellID = 46924, unitID = "target", caster = "all", filter = "BUFF"},

			-- Paladin
			-- Divine Shield
			{spellID = 642, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Protection
			{spellID = 1022, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Sacrifice
			{spellID = 6940, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Freedom
			{spellID = 1044, unitID = "target", caster = "all", filter = "BUFF"},
			-- Aura Mastery
			{spellID = 31821, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ardent Defender
			{spellID = 31850, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86698, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Guardian
			{spellID = 70940, unitID = "target", caster = "all", filter = "BUFF"},

			-- Mage
			-- Ice Block
			{spellID = 45438, unitID = "target", caster = "all", filter = "BUFF"},
			-- Invisibility
			{spellID = 66, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "target", caster = "all", filter = "BUFF"},
			-- Improved blink
			{spellID = 46989, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blazing Speed
			{spellID = 31643, unitID = "target", caster = "all", filter = "BUFF"},
			-- Cauterize
			{spellID = 87023, unitID = "target", caster = "target", filter = "DEBUFF"},

			-- Rogue
			-- Cloak of Shadows
			{spellID = 31224, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "target", caster = "all", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "target", caster = "all", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 51713, unitID = "target", caster = "all", filter = "BUFF"},
			-- Smoke Bomb
			{spellID = 88611, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Death knight
			-- Anti-Magic Shell
			{spellID = 48707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Lichborne
			{spellID = 49039, unitID = "target", caster = "all", filter = "BUFF"},
			-- Bone shield
			{spellID = 49222, unitID = "target", caster = "all", filter = "BUFF"},
			-- Icebound Fortitude
			{spellID = 48792, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pillar of Frost
			{spellID = 51271, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unholy Frenzy
			{spellID = 49016, unitID = "target", caster = "all", filter = "BUFF"},

			-- Shaman
			-- Grounding Totem Effect
			{spellID = 8178, unitID = "target", caster = "all", filter = "BUFF"},
			-- Stoneclaw Totem
			{spellID = 55277, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shamanistic Rage
			{spellID = 30823, unitID = "target", caster = "all", filter = "BUFF"},
			-- Earth Shield
			{spellID = 974, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mana Tide
			--{spellID = 16191, unitID = "target", caster = "all", filter = "BUFF"},

			-- Priest
			-- Dispersion
			{spellID = 47585, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pain supression
			{spellID = 33206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Strength of Soul
			{spellID = 96267, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "all", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "target", caster = "all", filter = "BUFF"},

			-- Warlock
			-- Soul harvest
			{spellID = 79268, unitID = "target", caster = "all", filter = "BUFF"},
			-- Soulstone
			{spellID = 20707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

			-- All
			-- Warsong flag
			{spellID = 23333, unitID = "target", caster = "all", filter = "BUFF"},
			{spellID = 23335, unitID = "target", caster = "all", filter = "BUFF"},
			-- Netherstorm flag
			{spellID = 34976, unitID = "target", caster = "all", filter = "BUFF"},
			-- Seaforium
			{spellID = 52418, unitID = "target", caster = "all", filter = "BUFF"},
			-- Seaforium 2
			{spellID = 66271, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Drink
			{spellID = 80167, unitID = "target", caster = "all", filter = "BUFF"},

			-- Control block
			-- Immune
			-- Cyclone
			{spellID = 33786, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Banish
			{spellID = 710, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mind Control
			{spellID = 605, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Silence
			-- Strangulate (DK)
			{spellID = 47476, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silencing Shot (Hunter)
			{spellID = 34490, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Nether Shock (Nether Ray)
			{spellID = 44957, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Solar Beam (Druid)
			{spellID = 78675, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silenced - Improved Counterspell (Mage)
			{spellID = 55021, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield (Pally)
			{spellID = 31935, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silence (Priest)
			{spellID = 15487, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote - Silence (Rogue)
			{spellID = 1330, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silenced - Improved Kick (Rogue)
			{spellID = 18425, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Spell Lock (Felhunter) (Warlock)
			{spellID = 24259, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silenced (Gag Order) (War)
			{spellID = 18498, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Arcane torrent (BE) (Racial)
			{spellID = 28730, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Stun
			-- Gnaw (Pet)
			{spellID = 47481, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Gnaw (Pet - mutant)
			{spellID = 91797, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Bash
			{spellID = 5211, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Pounce
			{spellID = 9005, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Sonic Blast (Bat)
			{spellID = 50519, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Sting (Wasp)
			{spellID = 56626, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Impact
			{spellID = 12355, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Improved Polymorph
			{spellID = 83047, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Deep Freeze
			{spellID = 44572, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Aura of Foreboding
			{spellID = 93975, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Demon Leap
			{spellID = 54786, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Throwdown
			{spellID = 85388, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Charge Stun
			{spellID = 7922, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Concussion Blow
			{spellID = 12809, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Intercept
			{spellID = 20253, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shockwave
			{spellID = 46968, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- War Stomp (Tauren)
			{spellID = 20549, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- CC
			-- Hungering Cold
			{spellID = 49203, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Freezing Trap Effect
			{spellID = 3355, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Wyvern sting 
			{spellID = 19386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Scatter Shot
			{spellID = 19503, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ring of frost
			{spellID = 82691, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Bad Manner (Monkey)
			{spellID = 90337, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shackle Undead
			{spellID = 9484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hex
			{spellID = 51514, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 5782, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Sin and Punishment
			{spellID = 87204, unitID = "target", caster = "all", filter = "DEBUFF"},
		},
	},
}

-- edit by Oz of shestak. org --