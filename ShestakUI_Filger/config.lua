local T, C, L = unpack(ShestakUI)

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
			-- Living Seed
			{ spellID = 48504, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nature's Bounty
			{ spellID = 96206, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tree of Life
			{ spellID = 33891, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Barkskin
			{ spellID = 22812, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nature's Grasp
			{ spellID = 16689, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Thorns
			{ spellID = 467, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Owlkin Frenzy
			{ spellID = 48391, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Starfall
			{ spellID = 48505, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Savage Roar
			{ spellID = 52610, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Survival Instincts
			{ spellID = 61336, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Berserk
			{ spellID = 50334, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dash
			{ spellID = 1850, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Enrage
			{ spellID = 5229, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Frenzied Regeneration
			{ spellID = 22842, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tiger's Fury
			{ spellID = 5217, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stampeding Roar
			{ spellID = 77764, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stampede
			{ spellID = 81017, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Buffs
			-- Eclipse (Lunar)
			{ spellID = 48518, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Eclipse (Solar)
			{ spellID = 48517, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shooting Stars
			{ spellID = 93400, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lunar Shower
			{ spellID = 81192, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nature's Grace
			{ spellID = 16886, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 16870, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Predator's Swiftness
			{ spellID = 69369, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Trinkets
			-- Soul Casket (Spell)
			{ spellID = 91019, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stump of Time (Spell)
			{ spellID = 91047, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jeweled Serpent (Spell)
			{ spellID = 73551, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Volcano (Intellect)
			{ spellID = 89091, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Tsunami (Spirit)
			{ spellID = 89182, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jar of Ancient Remedies (Spirit)
			{ spellID = 92329, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Spell)
			{ spellID = 92325, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Haste)
			{ spellID = 92328, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bell of Enraging Resonance (Spell)
			{ spellID = 92318, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fall of Mortality (Spirit)
			{ spellID = 91184, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Enchants
			-- Power Torrent (Intellect)
			{ spellID = 74241, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hurricane (Haste)
			{ spellID = 74221, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lightweave (Intellect)
			{ spellID = 75170, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heartsong (Spirit)
			{ spellID = 74224, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Moonfire
			{ spellID = 8921, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sunfire
			{ spellID = 93402, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth and Moon
			{ spellID = 48506, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Insect Swarm
			{ spellID = 5570, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Fungal Growth
			{ spellID = 81281, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Faerie Fire
			{ spellID = 770, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots
			{ spellID = 339, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
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
			-- Demoralizing Roar
			{ spellID = 99, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Skull Bash (Bear Form)
			{ spellID = 80964, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Feral Charge Effect
			{ spellID = 45334, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 58179, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			IconSide = "LEFT",
			setPoint = { "BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 3 or 9, C.unitframe.portrait_enable and 0 or -41 },
			
			-- Lifebloom
			{ spellID = 33763, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Rejuvenation
			{ spellID = 774, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Regrowth
			{ spellID = 8936, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Wild Growth
			{ spellID = 48438, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Living Seed
			{ spellID = 48504, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Entangling Roots
			{ spellID = 339, size = 25, barWidth = 191, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Cyclone
			{ spellID = 33786, size = 25, barWidth = 191, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 25, barWidth = 191, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },
			
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
			-- Starsurge
			{ spellID = 78674, size = 30, filter = "CD" },
			-- Typhoon
			{ spellID = 50516, size = 30, filter = "CD" },
			-- Solar beam
			{ spellID = 78675, size = 30, filter = "CD" },
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
			-- Skull Bash - Cat
			{ spellID = 80965, size = 30, filter = "CD" },
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
		},
	},
	["HUNTER"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },
			
			-- Spirit Mend
			{ spellID = 90361, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Deterrence
			{ spellID = 19263, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },
			
			-- Buffs
			-- Ready, Set, Aim...
			{ spellID = 82925, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lock and Load
			{ spellID = 56342, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Master Tactician
			{ spellID = 34837, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Rapid Fire
			{ spellID = 3045, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Call of the Wild
			{ spellID = 53434, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Steady Shot
			{ spellID = 53220, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fire!
			{ spellID = 82926, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Mend Pet
			{ spellID = 136, size = 37, unitId = "pet", caster = "player", filter = "BUFF" },
			-- Cobra Strikes
			{ spellID = 53257, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Focus Fire
			{ spellID = 82692, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Trinkets
			-- Prestor's Talisman of Machination (Haste)
			{ spellID = 92124, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fluid Death (Agility)
			{ spellID = 92104, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Essence of the Cyclone (Crit)
			{ spellID = 92126, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Landslide (AP)
			{ spellID = 74245, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },
			
			-- Hunter's Mark
			{ spellID = 1130, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Marked for Death
			{ spellID = 88691, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Piercing Shots
			{ spellID = 63468, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Serpent Sting
			{ spellID = 1978, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Black Arrow
			{ spellID = 3674, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Explosive Shot
			{ spellID = 53301, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		--[[{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			IconSide = "LEFT",
			setPoint = { "BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 3 or 9, C.unitframe.portrait_enable and 0 or -41 },
			
			-- Hunter's Mark
			{ spellID = 1130, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Marked for Death
			{ spellID = 88691, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Piercing shots
			{ spellID = 63468, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Serpent Sting
			{ spellID = 1978, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Black Arrow
			{ spellID = 3674, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Explosive Shot
			{ spellID = 53301, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },	
		},]]
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
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },
			
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
			-- Explosive Trap
			{ spellID = 13813, size = 30, filter = "CD" },
			-- Ice Trap
			{ spellID = 13809, size = 30, filter = "CD" },
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
			-- Spirit Mend
			{ spellID = 90361, size = 30, filter = "CD" },
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
		},
	},
	["MAGE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },
			
			-- Invisibility
			{ spellID = 32612, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Icy Veins
			{ spellID = 12472, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Pyromaniac
			{ spellID = 83582, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Mana Shield
			{ spellID = 1463, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Ice Barrier
			{ spellID = 11426, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Slow Fall
			{ spellID = 130, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Ice Block
			{ spellID = 45438, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Mage Ward
			{ spellID = 543, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Blink
			{ spellID = 46989, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Blazing Speed
			{ spellID = 31643, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },
			
			-- Buffs
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
			-- Arcane Missiles!
			{ spellID = 79683, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Trinkets
			-- Soul Casket (Spell)
			{ spellID = 91019, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stump of Time (Spell)
			{ spellID = 91047, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jeweled Serpent (Spell)
			{ spellID = 73551, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Volcano (Intellect)
			{ spellID = 89091, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Tsunami (Spirit)
			{ spellID = 89182, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jar of Ancient Remedies (Spirit)
			{ spellID = 92329, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Spell)
			{ spellID = 92325, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Haste)
			{ spellID = 92328, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bell of Enraging Resonance (Spell)
			{ spellID = 92318, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Enchants
			-- Power Torrent (Intellect)
			{ spellID = 74241, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hurricane (Haste)
			{ spellID = 74221, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lightweave (Intellect)
			{ spellID = 75170, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },
			
			-- Arcane Blast
			{ spellID = 36032, size = 37, unitId = "player", caster = "player", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Ignite
			{ spellID = 12654, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Living Bomb
			{ spellID = 44457, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Pyroblast!
			{ spellID = 92315, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Pyroblast!
			{ spellID = 11366, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Critical Mass
			{ spellID = 22959, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Combustion
			{ spellID = 83853, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Blast wave
			{ spellID = 11113, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Freeze (Water Elemental)
			{ spellID = 33395, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Nova
			{ spellID = 122, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Shattered Barrier
			{ spellID = 55080, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Cone of Cold
			{ spellID = 120, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Improved Cone of Cold
			{ spellID = 83302, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frostfite Bolt
			{ spellID = 44614, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Polymorph
			{ spellID = 118, size = 25, barWidth = 191, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },

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
			-- Will of the forsaken (Undead)
			{ spellID = 7744, size = 30, filter = "CD" },
			-- Escape Artist (Gnome Racial)
			{ spellID = 20589, size = 30, filter = "CD" },
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
			-- Ring of Frost
			{ spellID = 82676, size = 30, filter = "CD" },
			-- Flame Orb
			{ spellID = 82731, size = 30, filter = "CD" },
			-- Freeze (Elemental)
			{ spellID = 33395, size = 30, filter = "CD" },
			-- Combustion
			{ spellID = 11129, size = 30, filter = "CD" },
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
			-- Every Man for Himself (Human)
			{ spellID = 59752, size = 30, filter = "CD" },
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- Last Stand
			{ spellID = 12975, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shield Wall
			{ spellID = 871, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hysteria
			{ spellID = 49016, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Spell Reflection
			{ spellID = 23920, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Blood Reserve
			{ spellID = 64568, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Enrage
			{ spellID = 14202, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Death Wish
			{ spellID = 12292, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Meat Cleaver
			{ spellID = 85739, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Executioner
			{ spellID = 90806, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Rude Interruption
			{ spellID = 86663, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Recklesness
			{ spellID = 1719, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Berserker Rage
			{ spellID = 18499, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Slaughter
			{ spellID = 84586, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Sudden Death
			{ spellID = 52437, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Slam!
			{ spellID = 46916, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Sword and Board
			{ spellID = 50227, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Thunderstruck
			{ spellID = 80980, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Blood Drinker
			{ spellID = 70855, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Taste for Blood
			{ spellID = 56638, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tricks of the Trade
			{ spellID = 59628, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Chaos Bane
			{ spellID = 73422, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Battle trance
			{ spellID = 85742, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Incite
			{ spellID = 86627, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

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
			-- Mortal Strike
			{ spellID = 12294, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Judgements of the Just
			{ spellID = 68055, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Vindication
			{ spellID = 26017, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Colossus Smash
			{ spellID = 86346, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },
			
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
			-- Raging Blow
			{ spellID = 85288, size = 30, filter = "CD" },
			-- Bloodthirst
			{ spellID = 23881, size = 30, filter = "CD" },
			-- Taunt
			{ spellID = 355, size = 30, filter = "CD" },
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
			-- Every Man for Himself (Human)
			{ spellID = 59752, size = 30, filter = "CD" },
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
			-- Lightning Shield
			{ spellID = 324, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Water Shield
			{ spellID = 52127, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Earth Shield
			{ spellID = 974, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Elemental mastery
			{ spellID = 64701, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Spiritwalker's grace
			{ spellID = 79206, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unleash Flame
			{ spellID = 73683, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unleash Life
			{ spellID = 73685, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Wolf
			{ spellID = 2645, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Focused Insight
			{ spellID = 77800, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nature Guardian
			{ spellID = 31616, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Buffs
			-- Clearcasting
			{ spellID = 16246, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tidal Waves
			{ spellID = 51562, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lava flows
			{ spellID = 65264, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Grounding Totem
			{ spellID = 8178, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Stoneclaw Totem
			{ spellID = 55277, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Trinkets
			-- Soul Casket (Spell)
			{ spellID = 91019, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stump of Time (Spell)
			{ spellID = 91047, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jeweled Serpent (Spell)
			{ spellID = 73551, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Volcano (Intellect)
			{ spellID = 89091, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Tsunami (Spirit)
			{ spellID = 89182, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jar of Ancient Remedies (Spirit)
			{ spellID = 92329, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Spell)
			{ spellID = 92325, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Haste)
			{ spellID = 92328, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bell of Enraging Resonance (Spell)
			{ spellID = 92318, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fall of Mortality (Spirit)
			{ spellID = 91184, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Enchants
			-- Power Torrent (Intellect)
			{ spellID = 74241, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hurricane (Haste)
			{ spellID = 74221, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lightweave (Intellect)
			{ spellID = 75170, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Storm Strike
			{ spellID = 17364, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth Shock
			{ spellID = 8042, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Flame Shock
			{ spellID = 8050, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Searing Flames
			{ spellID = 77661, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earthgrab
			{ spellID = 64695, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bind Elemental
			{ spellID = 76780, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			IconSide = "LEFT",
			setPoint = { "BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 3 or 9, C.unitframe.portrait_enable and 0 or -41 },
			
			-- Earth Shield
			{ spellID = 974, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Riptide
			{ spellID = 61295, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Ancestral Fortitude
			{ spellID = 16236, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Earthliving
			{ spellID = 51945, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			Interval = 3,
			Mode = "BAR",
			setPoint = { "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -44 },
			
			-- Hex
			{ spellID = 51514, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
			-- Bind elemental 
			{ spellID = 76780, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },
			
			-- Self
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
			-- Earthbind Totem
			{ spellID = 2484, size = 30, filter = "CD" },
			-- Stoneclaw Totem
			{ spellID = 5730, size = 30, filter = "CD" },
			-- Tremor totem
			{ spellID = 8143, size = 30, filter = "CD" },
			-- Feral Spirit
			{ spellID = 51533, size = 30, filter = "CD" },
			-- Shamanistic Rage
			{ spellID = 30823, size = 30, filter = "CD" },
			-- Stormstrike
			{ spellID = 17364, size = 30, filter = "CD" },
			-- Spiritwalker's grace
			{ spellID = 79206, size = 30, filter = "CD" },
			-- Healing rain
			{ spellID = 73920, size = 30, filter = "CD" },
			-- Unleash weapon
			{ spellID = 73680, size = 30, filter = "CD" },
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
		},
	},
	["PALADIN"] = {
		--[[{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- 
			{ spellID = , size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},]]
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Buffs
			-- Holy Shield
			{ spellID = 20925, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Infusion of Light
			{ spellID = 54149, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Divine Plea
			{ spellID = 54428, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Beacon of Light
			{ spellID = 53563, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Divine Illumination
			{ spellID = 31842, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Avenging Wrath
			{ spellID = 31884, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Zealotry
			{ spellID = 85696, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Inquisition
			{ spellID = 84963, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Sacred Duty
			{ spellID = 85433, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Trinkets
			-- Soul Casket (Spell)
			{ spellID = 91019, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stump of Time (Spell)
			{ spellID = 91047, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jeweled Serpent (Spell)
			{ spellID = 73551, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Volcano (Intellect)
			{ spellID = 89091, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Tsunami (Spirit)
			{ spellID = 89182, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jar of Ancient Remedies (Spirit)
			{ spellID = 92329, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Spell)
			{ spellID = 92325, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Haste)
			{ spellID = 92328, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bell of Enraging Resonance (Spell)
			{ spellID = 92318, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fall of Mortality (Spirit)
			{ spellID = 91184, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Enchants
			-- Power Torrent (Intellect)
			{ spellID = 74241, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hurricane (Haste)
			{ spellID = 74221, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lightweave (Intellect)
			{ spellID = 75170, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Judgement of Light
			{ spellID = 20271, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Conviction
			{ spellID = 20057, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },
			
			-- Self
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
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
			-- Every Man for Himself (Human)
			{ spellID = 59752, size = 30, filter = "CD" },
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
			{ spellID = 17, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Renew
			{ spellID = 139, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dispersion
			{ spellID = 47585, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fade
			{ spellID = 586, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fear Ward
			{ spellID = 6346, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Borrowed Time
			{ spellID = 59887, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
            -- Inner Fire
            { spellID = 588, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Inner Will
			{ spellID = 73413, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Archangel
			{ spellID = 81700, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dark Archangel
			{ spellID = 87153, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Strength of Soul
			{ spellID = 96267, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Prayer of Mending
			{ spellID = 41635, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Pain Suspension
			{ spellID = 33206, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Power Infusion
			{ spellID = 10060, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Levitation
			{ spellID = 1706, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Holy Walk
			{ spellID = 96219, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Buffs
			-- Surge of Light
			{ spellID = 88688, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Serendipity
			{ spellID = 63731, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shadow Orb
			{ spellID = 77487, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Empowered Shadow
			{ spellID = 95799, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Evangelism
			{ spellID = 81661, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dark Evangelism
			{ spellID = 87117, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Mind melt
			{ spellID = 87160, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Mind spike
			{ spellID = 87178, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Chakra: Sanctuary
			{ spellID = 81206, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Chakra: Serenity
			{ spellID = 81208, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Chakra: Chastise
			{ spellID = 81209, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Trinkets
			-- Soul Casket (Spell)
			{ spellID = 91019, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stump of Time (Spell)
			{ spellID = 91047, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jeweled Serpent (Spell)
			{ spellID = 73551, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Volcano (Intellect)
			{ spellID = 89091, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Tsunami (Spirit)
			{ spellID = 89182, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jar of Ancient Remedies (Spirit)
			{ spellID = 92329, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Spell)
			{ spellID = 92325, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Haste)
			{ spellID = 92328, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bell of Enraging Resonance (Spell)
			{ spellID = 92318, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fall of Mortality (Spirit)
			{ spellID = 91184, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Enchants
			-- Power Torrent (Intellect)
			{ spellID = 74241, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hurricane (Haste)
			{ spellID = 74221, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lightweave (Intellect)
			{ spellID = 75170, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Indulgence of the Penitent (T11)
			{ spellID = 89913, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Sin and Punishment
			{ spellID = 87099, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			IconSide = "LEFT",
			setPoint = { "BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 3 or 9, C.unitframe.portrait_enable and 0 or -41 },
			
			-- Renew
			{ spellID = 139, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Prayer of Mending
			{ spellID = 41635, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Guardian spirit
			{ spellID = 47788, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Pain suspension
			{ spellID = 33206, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Grace
			{ spellID = 77613, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "BUFF" },
			-- Shadow Word: Pain
			{ spellID = 589, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Devouring Plague
			{ spellID = 2944, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Vampiric Touch
            { spellID = 34914, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
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
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },
			
			-- Self
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
			-- Leap of Faith
			{ spellID = 73325, size = 30, filter = "CD" },
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
			-- Every Man for Himself (Human)
			{ spellID = 59752, size = 30, filter = "CD" },
		},
	},
	["WARLOCK"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },

			-- Self
			-- Burning Soul
			{ spellID = 74434, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Demon Soul Succub
			{ spellID = 79463, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Demon Soul Imp
			{ spellID = 79459, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Demon Soul Void
			{ spellID = 79464, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Demon Soul Fel Hunter
			{ spellID = 79460, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Demon Soul Fel Guard
			{ spellID = 79462, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dark Intent
			{ spellID = 85768, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Shadow Ward
			{ spellID = 6229, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Soul Swap
			{ spellID = 86211, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Buffs
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
			-- Nightfall
			{ spellID = 18095, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Eradication
			{ spellID = 47195, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Soul Fire
			{ spellID = 85383, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Empowered Imp
			{ spellID = 47283, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fel Spark
			{ spellID = 89937, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Demonic Rebirth
			{ spellID = 88447, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shadow Trance
			{ spellID = 17941, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Trinkets
			-- Soul Casket (Spell)
			{ spellID = 91019, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stump of Time (Spell)
			{ spellID = 91047, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jeweled Serpent (Spell)
			{ spellID = 73551, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Volcano (Intellect)
			{ spellID = 89091, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkmoon Card: Tsunami (Spirit)
			{ spellID = 89182, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Jar of Ancient Remedies (Spirit)
			{ spellID = 92329, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Spell)
			{ spellID = 92325, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Heart of Ignacious (Haste)
			{ spellID = 92328, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bell of Enraging Resonance (Spell)
			{ spellID = 92318, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Enchants
			-- Power Torrent (Intellect)
			{ spellID = 74241, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hurricane (Haste)
			{ spellID = 74221, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lightweave (Intellect)
			{ spellID = 75170, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },

			-- Self
			-- Shadow Embrace
			{ spellID = 32385, size = 37, unitId = "target", caster = "player", filter = "BUFF" },
			-- Curse of Tongues
			{ spellID = 1714, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 702, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Enslave Demon
			{ spellID = 1098, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Dark Intent
			{ spellID = 85767, size = 37, unitId = "target", caster = "player", filter = "BUFF" },
			-- Shadowsnare
			{ spellID = 63311, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			
			-- Other
			-- Curse of the Elements (Warlock)
			{ spellID = 1490, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of the Elements: Jinx (Warlock)
			{ spellID = 86105, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Earth and Moon (Moonkin)
			{ spellID = 48506, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Ebon Plaguebringer (DK)
			{ spellID = 65142, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Master poisoner (Rogue)
			{ spellID = 93068, size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			IconSide = "LEFT",
			setPoint = { "BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 3 or 9, C.unitframe.portrait_enable and 0 or -41 },
			
			-- Corruption
			{ spellID = 172, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Immolate
			{ spellID = 348, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Agony
			{ spellID = 980, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Bane of Doom
			{ spellID = 603, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unstable Affliction
			{ spellID = 30108, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Haunt
			{ spellID = 48181, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },	
			-- Seed of Corruption
			{ spellID = 27243, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
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
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },
			
			-- Self
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
			-- Hand of Gul'dan
			{ spellID = 71521, size = 30, filter = "CD" },
			-- Immolation Aura
			{ spellID = 50589, size = 30, filter = "CD" },
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
			-- Every Man for Himself (Human)
			{ spellID = 59752, size = 30, filter = "CD" },
			-- Cannibalize
			{ spellID = 20577, size = 30, filter = "CD" },
			-- Will of the Forsaken
			{ spellID = 7744, size = 30, filter = "CD" },
		},
	},
	["ROGUE"] = {	
		{	
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },
			
			-- Self
			-- Sprint
			{ spellID = 2983, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Adrenaline Rush
			{ spellID = 13750, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Evasion
			{ spellID = 5277, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Envenom
			{ spellID = 32645, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Overkill
			{ spellID = 58426, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Slice and Dice
			{ spellID = 5171, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tricks of the Trade
			{ spellID = 57934, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shadow dance
			{ spellID = 51713, size = 37, unitId = "player", caster = "player", filter = "BUFF"},
			-- Recuperate
			{ spellID = 73651, size = 37, unitId = "player", caster = "player", filter = "BUFF"},
			-- Shadowstep
			{ spellID = 36563, size = 37, unitId = "player", caster = "player", filter = "BUFF"},
			-- Master of subtlety
			{ spellID = 31665, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Cloak of Shadows
			{ spellID = 31224, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Vanish
			{ spellID = 1856, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Cheating death
			{ spellID = 45182, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

			-- Buffs
			-- Combat Readiness
			{ spellID = 74001, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Combat Insight
			{ spellID = 74002, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Trinkets
			-- Prestor's Talisman of Machination (Haste)
			{ spellID = 92124, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fluid Death (Agility)
			{ spellID = 92104, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Essence of the Cyclone (Crit)
			{ spellID = 92126, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Landslide (AP)
			{ spellID = 74245, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },
			
			-- Rupture
			{ spellID = 1943, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Garrote
			{ spellID = 703, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Expose Armor
			{ spellID = 8647, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Dismantle
			{ spellID = 51722, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Revealing Strike
			{ spellID = 84617, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Vendetta
			{ spellID = 79140, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Waylay
			{ spellID = 51693, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Hemorrhage
			{ spellID = 16511, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Find Weakness
			{ spellID = 91021, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Smoke Bomb
			{ spellID = 88611, size = 37, unitId = "target", caster = "player", filter = "DEBUFF" },
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
			-- Sap
			{ spellID = 6770, size = 25, barWidth = 191, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },
			
			-- Self
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
			-- Shadow dance
			{ spellID = 51713, size = 30, filter = "CD"},
			-- Redirect
			{ spellID = 73981, size = 30, filter = "CD"},
			-- Combat Readiness
			{ spellID = 74001, size = 30, filter = "CD"},
			-- Vendetta
			{ spellID = 79140, size = 30, filter = "CD"},
			-- Feint
			{ spellID = 1966, size = 30, filter = "CD"},
			-- Premiditation
			{ spellID = 14183, size = 30, filter = "CD"},
			-- Sprint
			{ spellID = 2983, size = 30, filter = "CD"},
			
			-- Other
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
			-- Every Man for Himself (Human)
			{ spellID = 59752, size = 30, filter = "CD" }
		},
	},
	["DEATHKNIGHT"] = {
		--[[{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173 },
			
			-- 
			{ spellID = , size = 37, unitId = "player", caster = "player", filter = "BUFF" },
		},]]
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 173 },

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
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			Interval = 3,
			Mode = "BAR",
			IconSide = "LEFT",
			setPoint = { "BOTTOMLEFT", C.unitframe.portrait_enable and "oUF_Target_PortraitOverlay" or "oUF_Target", "BOTTOMRIGHT", C.unitframe.portrait_enable and 3 or 9, C.unitframe.portrait_enable and 0 or -41 },
			
			-- Blood Plague
			{ spellID = 59879, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Fever
			{ spellID = 59921, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unholy Blight
			{ spellID = 49194, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Summon Gargoyle
			{ spellID = 49206, size = 25, barWidth = 188, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, C.unitframe.plugins_swing == true and 29 or 17 },

			-- Summon Gargoyle
			{ spellID = 49206, size = 30, filter = "CD" },
			-- Gnaw
			{ spellID = 47481, size = 30, filter = "CD" },
			-- Strangulate
			{ spellID = 47476, size = 30, filter = "CD" },
			-- Mind Freeze
			{ spellID = 47528, size = 30, filter = "CD" },
			-- Gloves
			{ slotID = 10, size = 30, filter = "CD" },
			-- Belt
			{ slotID = 6, size = 30, filter = "CD" },
			-- Back
			{ slotID = 15, size = 30, filter = "CD" },
			-- Trinkets
			{ slotID = 13, size = 30, filter = "CD" },
			{ slotID = 14, size = 30, filter = "CD" },
		},
	},
	--[[["Caster"] = {
		{
			Name = "CASTER_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },
			
			-- 
			{ spellID = , size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
	},
	["Melee"] = {
		{
			Name = "MELEE_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },
			
			-- 
			{ spellID = , size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
	},
	["Tank"] = {
		{
			Name = "TANK_ICON",
			Direction = "RIGHT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 213 },
			
			-- 
			{ spellID = , size = 37, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
	},]]
	["ALL"] = {
		{
			Name = "SPECIAL_P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 213 },
			
			-- Potions
			-- Tol'vir Agility
			{ spellID = 79633, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Golem's Strength
			{ spellID = 79634, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Volcanic Power
			{ spellID = 79476, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Firelord's Draught
			{ spellID = 94826, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Speed
			{ spellID = 23451, size = 37, unitId = "player", caster = "player", filter = "BUFF" },

			-- Leeroy Jenkins
			-- Bloodlust
			{ spellID = 2825, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Time Warp
			{ spellID = 80353, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Ancient Hysteria
			{ spellID = 90355, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			
			-- Enchants
			-- Hyperspeed Accelerators
			{ spellID = 54758, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Synapse Springs
			{ spellID = 82175, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Nitro Boosts
			{ spellID = 54861, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Parachute
			{ spellID = 55001, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Racial
			-- Berserking
			{ spellID = 26297, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Stoneform
			{ spellID = 65116, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Blood Fury
			{ spellID = 33697, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Darkflight
			{ spellID = 68992, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shadowmeld
			{ spellID = 58984, size = 37, unitId = "player", caster = "player", filter = "BUFF" },
			
			-- Other
			-- Hand of Protection
			{ spellID = 1022, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, size = 37, unitId = "player", caster = "all", filter = "BUFF" },
		},
		{
			Name = "PVE/PVP_DEBUFF",
			Direction = "UP",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 253 },
			
			-- Death Knight
			-- Gnaw (Pet)
			{ spellID = 47481, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Gnaw (Pet - mutant)
			{ spellID = 91797, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Strangulate
			{ spellID = 47476, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chains of Ice
			{ spellID = 45524, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Desecration
			{ spellID = 55741, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Heart Strike
			{ spellID = 58617, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hungering Cold
			{ spellID = 51209, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Necrotic strike
			{ spellID = 73975, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Dark simulacrum
			{ spellID = 77606, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Druid
			-- Skull Bash (Bear Form)
			{ spellID = 80964, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Skull Bash (Cat Form)
			{ spellID = 80965, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Solar Beam
			{ spellID = 78675, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Fungal Growth
			{ spellID = 81281, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cyclone
			{ spellID = 33786, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Bash
			{ spellID = 5211, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Maim
			{ spellID = 22570, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pounce
			{ spellID = 9005, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots
			{ spellID = 339, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Feral Charge Effect
			{ spellID = 45334, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 58179, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Hunter
			-- Aspect of the Pack
			{ spellID = 13159, size = 60, unitId = "player", caster = "all", filter = "BUFF" },
			-- Freezing Trap Effect
			{ spellID = 3355, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Scare Beast
			{ spellID = 1513, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Scatter Shot
			{ spellID = 19503, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Wyvern sting 
			{ spellID = 19386, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intimidation
			{ spellID = 24394, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Barrage
			{ spellID = 35101, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Shot
			{ spellID = 5116, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Trap Aura
			{ spellID = 13810, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Wing Clip
			{ spellID = 2974, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Counterattack
			{ spellID = 19306, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Entrapment
			{ spellID = 19185, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pets
			-- Sonic Blast (Bat)
			{ spellID = 50519, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pin (Crab)
			{ spellID = 50245, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Venom Web Spray (Silithid)
			{ spellID = 54706, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Web (Spider)
			{ spellID = 4167, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Froststorm Breath (Chimera)
			{ spellID = 92380, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Swoop (Moth)
			{ spellID = 53148, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Ankle Crack (Crocolisk)
			{ spellID = 50433, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Clench (Scorpid)
			{ spellID = 50541, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Time Warp (Warp Stalker)
			{ spellID = 35346, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sting (Wasp)
			{ spellID = 56626, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Nether Shock (Nether Ray)
			{ spellID = 44957, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Mage
			-- Dragon's Breath
			{ spellID = 31661, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Polymorph
			{ spellID = 118, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Improved Polymorph
			{ spellID = 83047, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Counterspell
			{ spellID = 55021, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Deep Freeze
			{ spellID = 44572, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze (Water Elemental)
			{ spellID = 33395, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Nova
			{ spellID = 122, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shattered Barrier
			{ spellID = 55080, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chilled
			{ spellID = 6136, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cone of Cold
			{ spellID = 120, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Improved Cone of Cold
			{ spellID = 83302, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Ring of Frost
			{ spellID = 82691, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Impact
			{ spellID = 12355, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blast Wave
			{ spellID = 11113, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cauterize
			{ spellID = 87023, size = 60, unitId = "player", caster = "player", filter = "DEBUFF" },
			
			-- Paladin
			-- Repentance
			{ spellID = 20066, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Avenger's Shield
			{ spellID = 31935, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Avenger's Shield with Glyph
			{ spellID = 63529, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hammer of Justice
			{ spellID = 853, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Seal of Justice proc
			{ spellID = 20170, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Priest
			-- Psychic Horror
			{ spellID = 64044, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Control
			{ spellID = 605, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silence
			{ spellID = 15487, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Flay
			{ spellID = 15407, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sin and Punishment
			{ spellID = 87204, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Paralysis
			{ spellID = 87194, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shackle Undead
			{ spellID = 9484, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Rogue
			-- Dismantle
			{ spellID = 51722, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Garrote - Silence
			{ spellID = 1330, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Kick
			{ spellID = 18425, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cheap Shot
			{ spellID = 1833, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Kidney Shot
			{ spellID = 408, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blade Twisting
			{ spellID = 31125, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Deadly Throw
			{ spellID = 26679, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Vendetta
			{ spellID = 79140, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Waylay
			{ spellID = 51693, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Crippling Poison
			{ spellID = 3409, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind-numbing Poison
			{ spellID = 5760, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Shaman
			-- Hex
			{ spellID = 51514, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthgrab
			{ spellID = 64695, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze
			{ spellID = 63685, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Stoneclaw Stun
			{ spellID = 39796, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthbind
			{ spellID = 3600, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Bash (Feral Spirit)
			{ spellID = 58861, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthquake
			{ spellID = 77505, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Warlock
			-- Aura of Foreboding
			{ spellID = 93975, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Demon Leap
			{ spellID = 54785, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Fear
			{ spellID = 5782, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shadowfury
			{ spellID = 30283, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Aftermath
			{ spellID = 18118, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Unstable Affliction
			{ spellID = 31117, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Seduction (Succubus)
			{ spellID = 6358, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Spell Lock (Felhunter)
			{ spellID = 24259, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Axe Toss (Felguard)
			{ spellID = 89766, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shadowsnare
			{ spellID = 63311, size = 60, unitId = "target", caster = "player", filter = "DEBUFF" },
			
			-- Warrior
			-- Throwdown
			{ spellID = 85388, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intimidating Shout
			{ spellID = 20511, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Disarm
			{ spellID = 676, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced (Gag Order)
			{ spellID = 18498, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Charge Stun
			{ spellID = 7922, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussion Blow
			{ spellID = 12809, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept
			{ spellID = 20253, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shockwave
			{ spellID = 46968, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Hamstring
			{ spellID = 58373, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Improved Hamstring
			{ spellID = 23694, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hamstring
			{ spellID = 1715, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Piercing Howl
			{ spellID = 12323, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Colossus Smash
			{ spellID = 86346, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Racials
			-- War Stomp
			{ spellID = 20549, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Arcane Torrent
			{ spellID = 28730, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Other
			-- Rocket Fuel Leak
			{ spellID = 94794, size = 60, unitId = "player", caster = "player", filter = "DEBUFF" }, 
			
			-- Baradin Hold(PvP)
			-- Meteor Slash/Meteorschlag (Argaloth)
			{ spellID = 88942, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Throne of Four Winds
			-- Wind Chill (Conclave of Wind)
			{ spellID = 93123, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Slicing Gale (Conclave of Wind)
			{ spellID = 93058, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Static Shock (Al'Akir)
			{ spellID = 87873, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Acid Rain (Al'Akir)
			{ spellID = 93279, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Bastion of Twilight
			-- Blackout (Valiona & Theralion)
			{ spellID = 92879, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Engulfing Magic (Valiona & Theralion)
			{ spellID = 86631, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Waterlogged (Twilight Ascendant Council)
			{ spellID = 82762, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Burning Blood (Twilight Ascendant Council)
			{ spellID = 82662, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Heart of Ice (Twilight Ascendant Council)
			{ spellID = 82667, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frozen (Twilight Ascendant Council)
			{ spellID = 92503, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Swirling Winds (Twilight Ascendant Council)
			{ spellID = 83500, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Magnetic Pull (Twilight Ascendant Council)
			{ spellID = 83587, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Accelerated (Cho'gall)
			{ spellID = 81836, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Malformation (Cho'gall)
			{ spellID = 82125, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Absolute (Cho'gall)
			{ spellID = 82170, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Sickness (Cho'gall)
			{ spellID = 93200, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			
			-- Blackwing Descent
			-- Constricting Chains (Magmaw)
			{ spellID = 91911, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Parasitic Infection (Magmaw)
			{ spellID = 94679, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Infectious Vomit (Magmaw)
			{ spellID = 91923, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Lightning Conductor (Omnitron Defense System)
			{ spellID = 91433, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Flash Freeze (Maloriak)
			{ spellID = 77699, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Consuming Flames (Maloriak)
			{ spellID = 77786, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Finkle's Mixture (Chimaeron)
			{ spellID = 82705, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shadow Conductor (Nefarian)
			{ spellID = 92053, size = 60, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Unstable Shield (Omnotron Defense System)
			{ spellID = 79900, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "UP",
			Interval = 3,
			Mode = "ICON",
			setPoint = { "BOTTOMLEFT", "oUF_Target", "TOPLEFT", -2, 253 },

			-- Hunter
			-- Aspect of the Pack
			{ spellID = 13159, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Aspect of the Cheetah
			{ spellID = 5118, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Deterrence
			{ spellID = 19263, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Druid
			-- Innervate
			{ spellID = 29166, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Barskin
			{ spellID = 22812, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Nature's grasp 
			{ spellID = 16689, size = 60, unitId = "target", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{ spellID = 77764, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Survival Instincts
			{ spellID = 61336, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Frenzied Regeneration
			{ spellID = 22842, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Warrior
			-- Spell Reflection
			{ spellID = 23920, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Shield wall
			{ spellID = 871, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Berserker
			{ spellID = 18499, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Last stand
			{ spellID = 12976, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Paladin
			-- Aura Mastery
			{ spellID = 31821, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Hand of Freedom
			{ spellID = 1044, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Hand of Sacrifice
			{ spellID = 6940, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Hand of protection
			{ spellID = 1022, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Divine Shield
			{ spellID = 642, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Divine Protection
			{ spellID = 498, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Divine Sacrifice
			{ spellID = 64205, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Divine Guardian
			{ spellID = 70940, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Ardent Defender
			{ spellID = 31850, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Guardian of Ancient Kings
			{ spellID = 86698, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Mage
			-- Ice Block
			{ spellID = 45438, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Invisibility
			{ spellID = 66, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Evocation
			{ spellID = 12051, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Improved blink
			{ spellID = 46989, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Blazing Speed
			{ spellID = 31643, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Cauterize
			{ spellID = 87023, size = 60, unitId = "target", caster = "target", filter = "DEBUFF" },

			-- Rogue
			-- Cloak of Shadows
			{ spellID = 31224, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Evasion
			{ spellID = 5277, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Cheating Death
			{ spellID = 45182, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Combat Insight
			{ spellID = 74002, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Combat Readiness
			{ spellID = 74001, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Death knight
			-- Anti-Magic Shell
			{ spellID = 48707, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Lichborne
			{ spellID = 49039, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Bone shield
			{ spellID = 49222, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Icebound Fortitude
			{ spellID = 48792, size = 60, unitId = "target", caster = "all", filter = "BUFF" },

			-- Shaman
			-- Grounding Totem Effect
			{ spellID = 8178, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Stoneclaw Totem
			{ spellID = 55277, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Shamanistic Rage
			{ spellID = 30823, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Earth Shield
			{ spellID = 974, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Spiritwalker's Grace
			{ spellID = 79206, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Mana Tide
			{ spellID = 16191, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Priest
			-- Dispersion
			{ spellID = 47585, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Pain supression
			{ spellID = 33206, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Strength of Soul
			{ spellID = 96267, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Guardian Spirit
			{ spellID = 47788, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Fear Ward
			{ spellID = 6346, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Warlock
			-- Soul harvest
			{ spellID = 79268, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Soulstone
			{ spellID = 20707, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- All
			-- Warsong flag
			{ spellID = 23333, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			{ spellID = 23335, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Netherstorm flag
			{ spellID = 34976, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Seaforium
			{ spellID = 52418, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			-- Seaforium 2
			{ spellID = 66271, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			
			-- Drink
			{ spellID = 80167, size = 60, unitId = "target", caster = "all", filter = "BUFF" },
			
			-- Control block
			-- Immune
			-- Cyclone
			{ spellID = 33786, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Mind Control
			{ spellID = 605, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			
			-- Silence
			-- Strangulate (DK)
			{ spellID = 47476, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot (Hunter)
			{ spellID = 34490, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Nether Shock (Nether Ray)
			{ spellID = 44957, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Solar Beam (Druid)
			{ spellID = 78675, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Counterspell (Mage)
			{ spellID = 55021, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Avenger's Shield (Pally)
			{ spellID = 31935, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Silence (Priest)
			{ spellID = 15487, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Garrote - Silence (Rogue)
			{ spellID = 1330, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Kick (Rogue)
			{ spellID = 18425, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Spell Lock (Felhunter) (Warlock)
			{ spellID = 24259, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Silenced (Gag Order) (War)
			{ spellID = 18498, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Arcane torrent (BE) (Racial)
			{ spellID = 28730, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			
			-- Stun
			-- Gnaw (Pet)
			{ spellID = 47481, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Gnaw (Pet - mutant)
			{ spellID = 91797, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Bash
			{ spellID = 5211, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Maim
			{ spellID = 22570, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Pounce
			{ spellID = 9005, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Intimidation
			{ spellID = 24394, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Sonic Blast (Bat)
			{ spellID = 50519, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Sting (Wasp)
			{ spellID = 56626, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Impact
			{ spellID = 12355, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Improved Polymorph
			{ spellID = 83047, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Deep Freeze
			{ spellID = 44572, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Ring of frost
			{ spellID = 82691, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Hammer of Justice
			{ spellID = 853, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Psychic Horror
			{ spellID = 64044, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Cheap Shot
			{ spellID = 1833, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Kidney Shot
			{ spellID = 408, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Aura of Foreboding
			{ spellID = 93975, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Demon Leap
			{ spellID = 54786, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shadowfury
			{ spellID = 30283, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Axe Toss (Felguard)
			{ spellID = 89766, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Throwdown
			{ spellID = 85388, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Charge Stun
			{ spellID = 7922, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Concussion Blow
			{ spellID = 12809, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Intercept
			{ spellID = 20253, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shockwave
			{ spellID = 46968, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- War Stomp (Tauren)
			{ spellID = 20549, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			
			-- CC
			-- Hungering Cold
			{ spellID = 51209, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Freezing Trap Effect
			{ spellID = 3355, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Wyvern sting 
			{ spellID = 19386, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Scatter Shot
			{ spellID = 19503, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Polymorph
			{ spellID = 118, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Dragon's Breath
			{ spellID = 31661, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Repentance
			{ spellID = 20066, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shackle Undead
			{ spellID = 9484, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Hex
			{ spellID = 51514, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Fear
			{ spellID = 5782, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Seduction (Succubus)
			{ spellID = 6358, size = 60, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
	},
}