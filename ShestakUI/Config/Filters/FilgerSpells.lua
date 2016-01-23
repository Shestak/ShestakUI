local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.filger.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
C["filger_spells"] = {
	["DEATHKNIGHT"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Anti-Magic Shell
			{spellID = 48707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bone Shield
			{spellID = 49222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bone Wall (T16)
			{spellID = 144948, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dancing Rune Weapon
			{spellID = 81256, unitID = "player", caster = "player", filter = "BUFF"},
			-- Death's Advance
			{spellID = 96268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Icebound Fortitude
			{spellID = 48792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lichborne
			{spellID = 49039, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pillar of Frost
			{spellID = 51271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unholy Blight
			{spellID = 115989, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Blood
			{spellID = 55233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Summon Gargoyle
			{spellID = 49206, filter = "ICD", trigger = "NONE", duration = 40},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Blood Charge
			{spellID = 114851, unitID = "player", caster = "player", filter = "BUFF", count = 10},
			-- Crimson Scourge
			{spellID = 81141, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Transformation
			{spellID = 63560, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Freezing Fog
			{spellID = 59052, unitID = "player", caster = "player", filter = "BUFF"},
			-- Killing Machine
			{spellID = 51124, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scent of Blood
			{spellID = 50421, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Infusion
			{spellID = 91342, unitID = "pet", caster = "player", filter = "BUFF", count = 5},
			-- Sudden Doom
			{spellID = 81340, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unholy Strength
			{spellID = 53365, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Melee DPS (Crit, Proc)
			{spellID = 162915, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking (Crit, Proc)
			{spellID = 162917, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Strength
			{spellID = 60229, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Brawler's Statue (Bonus Armor, Use)
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coren's Cold Chromium (Attack Power, Proc)
			{spellID = 127926, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Strength] (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Strength] (Versatility, Proc)
			{spellID = 182063, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Gronntooth War Horn (Strength, Proc)
			{spellID = 201405, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Tanking
			-- Battering Talisman (Haste, Proc)
			{spellID = 177102, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blast Furnace Door (Mastery, Proc)
			{spellID = 177056, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evergaze Arcane Eidolon (Bonus Armor, Proc)
			{spellID = 177053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Relic of Blood (Haste, Proc)
			{spellID = 176937, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kyb's Foolish Perseverance (Health, Use)
			{spellID = 176460, unitID = "player", caster = "player", filter = "BUFF"},
			-- Petrified Flesh-Eating Spore (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pol's Blinded Eye (Mastery, Use)
			{spellID = 176876, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneheart Idol (Crit, Proc)
			{spellID = 176982, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tablet of Turnbuckle Teamwork (Bonus Armor, Use)
			{spellID = 176873, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Tanking
			-- Anzu's Cursed Plume (Mastery, Proc)
			{spellID = 183931, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enforcer's Stun Grenade (Versatility, Use)
			{spellID = 165534, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kyrak's Vileblood Serum (Mastery, Use)
			{spellID = 165535, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tyrant's Decree (Stamina, Proc)
			{spellID = 184770, unitID = "player", caster = "player", filter = "BUFF"},
			-- Xeri'tac's Unhatched Egg Sac (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.0: Melee DPS [Strength]
			-- Forgemaster's Insignia (Multistrike, Proc)
			{spellID = 177096, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Fang (Multistrike, Proc)
			{spellID = 176935, unitID = "player", caster = "player", filter = "BUFF"},
			-- Horn of the Screaming Spirits (Mastery, Proc)
			{spellID = 177042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mote of the Mountain (Versatility, Proc)
			{spellID = 176974, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scabbard of Kyanos (Strength, Use)
			{spellID = 177189, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tectus' Beating Heart (Crit, Proc)
			{spellID = 177040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Convulsive Shadows (Multistrike, Use)
			{spellID = 176874, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.1: Melee DPS [Strength]
			-- Bonemaw's Big Toe (Crit, Use)
			{spellID = 165532, unitID = "player", caster = "player", filter = "BUFF"},
			-- Emberscale Talisman (Versatility, Use)
			{spellID = 165543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spores of Alacrity (Haste, Proc)
			{spellID = 165822, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unending Hunger (Strength, Proc)
			{spellID = 183941, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Blackrock (Bonus Armor)
			{spellID = 159679, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
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
			Position = {unpack(C.position.filger.target_bar)},

			-- Blood Plague
			{spellID = 55078, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Fever
			{spellID = 55095, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
			-- Fel Burn [Empty Drinking Horn]
			{spellID = 184256, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Anti-Magic Shell
			{spellID = 48707, filter = "CD"},
			-- Anti-Magic Zone
			{spellID = 51052, filter = "CD"},
			-- Dancing Rune Weapon
			{spellID = 49028, filter = "CD"},
			-- Dark Simulacrum
			{spellID = 77606, filter = "CD"},
			-- Death and Decay
			{spellID = 43265, filter = "CD"},
			-- Death Grip
			{spellID = 49576, filter = "CD"},
			-- Death Pact
			{spellID = 48743, filter = "CD"},
			-- Death's Advance
			{spellID = 96268, filter = "CD"},
			-- Desecrated Ground
			{spellID = 108201, filter = "CD"},
			-- Gnaw (Ghoul)
			{spellID = 47481, filter = "CD"},
			-- Gorefiend's Grasp
			{spellID = 108199, filter = "CD"},
			-- Icebound Fortitude
			{spellID = 48792, filter = "CD"},
			-- Lichborne
			{spellID = 49039, filter = "CD"},
			-- Mind Freeze
			{spellID = 47528, filter = "CD"},
			-- Outbreak
			{spellID = 77575, filter = "CD"},
			-- Pillar of Frost
			{spellID = 51271, filter = "CD"},
			-- Plague Leech
			{spellID = 123693, filter = "CD"},
			-- Raise Dead
			{spellID = 46584, filter = "CD"},
			-- Remorseless Winter
			{spellID = 108200, filter = "CD"},
			-- Rune Tap
			{spellID = 48982, filter = "CD"},
			-- Soul Reaper
			{spellID = 130736, filter = "CD"},
			-- Strangulate
			{spellID = 47476, filter = "CD"},
			-- Summon Gargoyle
			{spellID = 49206, filter = "CD"},
			-- Unholy Blight
			{spellID = 115989, filter = "CD"},
			-- Vampiric Blood
			{spellID = 55233, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["DRUID"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Barkskin
			{spellID = 22812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserk
			{spellID = 50334, unitID = "player", caster = "player", filter = "BUFF"},
			-- Celestial Alignment
			{spellID = 112071, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cenarion Ward
			{spellID = 102351, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dash
			{spellID = 1850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Wild
			{spellID = 108294, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Chosen of Elune
			{spellID = 102560, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: King of the Jungle
			{spellID = 102543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Son of Ursoc
			{spellID = 102558, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lunar Empower
			{spellID = 164547, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 170856, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Vigil
			{spellID = 124974, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Defense
			{spellID = 132402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Roar
			{spellID = 52610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solar Empower
			{spellID = 164545, unitID = "player", caster = "player", filter = "BUFF"},
			-- Starfall
			{spellID = 48505, unitID = "player", caster = "player", filter = "BUFF"},
			-- Survival Instincts
			{spellID = 61336, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger's Fury
			{spellID = 5217, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Bloodtalons
			{spellID = 145152, unitID = "player", caster = "player", filter = "BUFF"},
			-- Clearcasting
			{spellID = 16870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lunar Peak
			{spellID = 171743, unitID = "player", caster = "player", filter = "BUFF"},
			-- Predatory Swiftness
			{spellID = 69369, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rejuvenation (Glyph)
			{spellID = 96206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solar Peak
			{spellID = 171744, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul of the Forest
			{spellID = 114108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tooth and Claw
			{spellID = 135286, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Caster DPS (Crit, Proc)
			{spellID = 162919, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing (Spirit, Proc)
			{spellID = 162913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS (Crit, Proc)
			{spellID = 162915, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking (Crit, Proc)
			{spellID = 162917, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Brawler's Statue (Bonus Armor, Use)
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coren's Cold Chromium (Attack Power, Proc)
			{spellID = 127926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mithril Wristwatch (Spell Power, Proc)
			{spellID = 127924, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thousand-Year Pickled Egg (Haste, Proc)
			{spellID = 127914, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Infallible Tracking Charm
			{spellID = 201408, unitID = "player", caster = "player", filter = "BUFF"},
			-- Orb Of Voidsight
			{spellID = 201410, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Proc)
			{spellID = 182058, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Agility] (Versatility, Proc)
			{spellID = 182060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Tanking
			-- Battering Talisman (Haste, Proc)
			{spellID = 177102, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blast Furnace Door (Mastery, Proc)
			{spellID = 177056, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evergaze Arcane Eidolon (Bonus Armor, Proc)
			{spellID = 177053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Relic of Blood (Haste, Proc)
			{spellID = 176937, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kyb's Foolish Perseverance (Health, Use)
			{spellID = 176460, unitID = "player", caster = "player", filter = "BUFF"},
			-- Petrified Flesh-Eating Spore (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pol's Blinded Eye (Mastery, Use)
			{spellID = 176876, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneheart Idol (Crit, Proc)
			{spellID = 176982, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tablet of Turnbuckle Teamwork (Bonus Armor, Use)
			{spellID = 176873, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Tanking
			-- Anzu's Cursed Plume (Mastery, Proc)
			{spellID = 183931, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enforcer's Stun Grenade (Versatility, Use)
			{spellID = 165534, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tyrant's Decree (Stamina, Proc)
			{spellID = 184770, unitID = "player", caster = "player", filter = "BUFF"},
			-- Xeri'tac's Unhatched Egg Sac (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.0: Melee DPS [Agility]
			-- Beating Heart of the Mountain (Multistrike, Use)
			{spellID = 176878, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blackheart Enforcer's Medallion (Multistrike, Proc)
			{spellID = 176984, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Jar of Doom (Mastery, Proc)
			{spellID = 176939, unitID = "player", caster = "player", filter = "BUFF"},
			-- Humming Blackiron Trigger (Crit, Proc)
			{spellID = 177067, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lucky Double-Sided Coin (Agility, Use)
			{spellID = 177597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meaty Dragonspine Trophy (Haste, Proc)
			{spellID = 177035, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scales of Doom (Multistrike, Proc)
			{spellID = 177038, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.1: Melee DPS [Agility]
			-- Gor'ashan's Lodestone Spike (Multistrike, Use)
			{spellID = 165542, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kihra's Adrenaline Injector (Mastery, Use)
			{spellID = 165485, unitID = "player", caster = "player", filter = "BUFF"},
			-- Malicious Censer (Agility, Proc)
			{spellID = 183926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of the Blademaster (Images, Proc)
			{spellID = 184270, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Capacitator (Damage, Proc)
			{spellID = 184293, unitID = "player", caster = "player", filter = "BUFF"},
			-- Witherbark's Branch (Haste, Proc)
			{spellID = 165822, unitID = "player", caster = "player", filter = "BUFF"},
			-- 5.0: Caster DPS
			-- Blackiron Micro Crucible (Multistrike, Proc)
			{spellID = 177081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Copeland's Clarity (Spellpower, Use)
			{spellID = 177594, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darmac's Unstable Talisman (Haste, Proc)
			{spellID = 177051, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Orb of Putrescence (Mastery, Proc)
			{spellID = 176941, unitID = "player", caster = "player", filter = "BUFF"},
			-- Furyheart Talisman (Haste, Proc)
			{spellID = 176980, unitID = "player", caster = "player", filter = "BUFF"},
			-- Goren Soul Repository (Crit, Proc)
			{spellID = 177046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shards of Nothing (Haste, Use)
			{spellID = 176875, unitID = "player", caster = "player", filter = "BUFF"},
			-- 5.1: Caster DPS
			-- Desecrated Shadowmoon Insignia (Intellect, Proc)
			{spellID = 183924, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coagulated Genesaur Blood (Multistrike, Proc)
			{spellID = 165832, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ragewing's Firefang (Versatility, Use)
			{spellID = 165543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fleshrender's Meathook (Haste, Use)
			{spellID = 165531, unitID = "player", caster = "player", filter = "BUFF"},
			-- 6.0: Healing
			-- Auto-Repairing Autoclave (Haste, Proc)
			{spellID = 177086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elementalist's Shielding Talisman (Multistrike, Proc)
			{spellID = 177063, unitID = "player", caster = "player", filter = "BUFF"},
			-- Emblem of Caustic Healing (Haste, Use)
			{spellID = 176879, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Censer of Faith (Haste, Proc)
			{spellID = 176943, unitID = "player", caster = "player", filter = "BUFF"},
			-- Immaculate Living Mushroom (Crit, Proc)
			{spellID = 176978, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ironspike Chew Toy (Spirit, Proc)
			{spellID = 177060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 6.1: Healing
			-- Intuition's Gift (Crit, Use)
			{spellID = 183929, unitID = "player", caster = "player", filter = "BUFF"},
			-- Leaf of the Ancient Protectors (Versatility, Proc)
			{spellID = 165833, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tharbek's Lucky Pebble (Mastery, Use)
			{spellID = 165535, unitID = "player", caster = "player", filter = "BUFF"},
			-- Voidmender's Shadowgem (Crit, Use)
			{spellID = 165532, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Blackrock (Bonus Armor)
			{spellID = 159679, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Shadowmoon (Spirit)
			{spellID = 159678, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Immobilized
			{spellID = 45334, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Lacerate
			{spellID = 33745, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Moonfire
			{spellID = 164812, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rake
			{spellID = 155722, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rip
			{spellID = 1079, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sunfire
			{spellID = 164815, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Thrash
			{spellID = 77758, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
			-- Mark of Doom [Prophecy of Fear]
			{spellID = 184073, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C.position.filger.target_bar)},

			-- Cenarion Ward
			{spellID = 102351, unitID = "target", caster = "player", filter = "BUFF"},
			-- Lifebloom
			{spellID = 33763, unitID = "target", caster = "player", filter = "BUFF"},
			-- Rejuvenation
			{spellID = 774, unitID = "target", caster = "player", filter = "BUFF"},
			-- Regrowth
			{spellID = 8936, unitID = "target", caster = "player", filter = "BUFF"},
			-- Wild Growth
			{spellID = 48438, unitID = "target", caster = "player", filter = "BUFF"},
			-- Stellar Flare
			{spellID = 152221, unitID = "target", caster = "player", filter = "BUFF"},
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
			Position = {unpack(C.position.filger.pve_cc)},

			-- Cyclone
			{spellID = 33786, unitID = "focus", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Barkskin
			{spellID = 22812, filter = "CD"},
			-- Berserk
			{spellID = 106952, filter = "CD"},
			-- Faerie Fire
			{spellID = 770, filter = "CD"},
			-- Force of Nature
			{spellID = 102693, filter = "CD"},
			-- Growl
			{spellID = 6795, filter = "CD"},
			-- Incapacitating Roar
			{spellID = 99, filter = "CD"},
			-- Incarnation: Chosen of Elune
			{spellID = 102560, filter = "CD"},
			-- Incarnation: King of the Jungle
			{spellID = 102543, filter = "CD"},
			-- Incarnation: Son of Ursoc
			{spellID = 102558, filter = "CD"},
			-- Incarnation: Tree of Life
			{spellID = 33891, filter = "CD"},
			-- Ironbark
			{spellID = 102342, filter = "CD"},
			-- Maim
			{spellID = 22570, filter = "CD"},
			-- Mangle
			{spellID = 33917, filter = "CD"},
			-- Mighty Bash
			{spellID = 5211, filter = "CD"},
			-- Nature's Cure
			{spellID = 88423, filter = "CD"},
			-- Nature's Swiftness
			{spellID = 132158, filter = "CD"},
			-- Nature's Vigil
			{spellID = 124974, filter = "CD"},
			-- Remove Corruption
			{spellID = 2782, filter = "CD"},
			-- Skull Bash
			{spellID = 106839, filter = "CD"},
			-- Solar Beam
			{spellID = 78675, filter = "CD"},
			-- Starsurge
			{spellID = 78674, filter = "CD"},
			-- Swiftmend
			{spellID = 18562, filter = "CD"},
			-- Tiger's Fury
			{spellID = 5217, filter = "CD"},
			-- Typhoon
			{spellID = 132469, filter = "CD"},
			-- Ursol's Vortex
			{spellID = 102793, filter = "CD"},
			-- Wild Charge
			{spellID = 102401, filter = "CD"},
			-- Wild Growth
			{spellID = 48438, filter = "CD"},

			-- Racial
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD", absID = true},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
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
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Beast Cleave
			{spellID = 118455, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Bestial Wrath
			{spellID = 19574, unitID = "player", caster = "player", filter = "BUFF"},
			-- Camouflage
			{spellID = 51755, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Deterrence
			{spellID = 19263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focus Fire
			{spellID = 82692, unitID = "player", caster = "player", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Fire
			{spellID = 3045, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sniper Training
			{spellID = 168811, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Mend
			{spellID = 90361, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Frenzy
			{spellID = 19615, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lock and Load
			{spellID = 168980, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mend Pet
			{spellID = 136, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Steady Focus
			{spellID = 177668, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thrill of the Hunt
			{spellID = 34720, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Ranged DPS (Crit, Proc)
			{spellID = 162915, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Coren's Cold Chromium (Attack Power, Proc)
			{spellID = 127926, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ranged DPS [Agility] (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ranged DPS [Agility] (Versatility, Proc)
			{spellID = 182060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Infallible Tracking Charm
			{spellID = 201408, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Ranged DPS [Agility]
			-- Beating Heart of the Mountain (Multistrike, Use)
			{spellID = 176878, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blackheart Enforcer's Medallion (Multistrike, Proc)
			{spellID = 176984, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Jar of Doom (Mastery, Proc)
			{spellID = 176939, unitID = "player", caster = "player", filter = "BUFF"},
			-- Humming Blackiron Trigger (Crit, Proc)
			{spellID = 177067, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lucky Double-Sided Coin (Agility, Use)
			{spellID = 177597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meaty Dragonspine Trophy (Haste, Proc)
			{spellID = 177035, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scales of Doom (Multistrike, Proc)
			{spellID = 177038, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Ranged DPS [Agility]
			-- Gor'ashan's Lodestone Spike (Multistrike, Use)
			{spellID = 165542, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kihra's Adrenaline Injector (Mastery, Use)
			{spellID = 165485, unitID = "player", caster = "player", filter = "BUFF"},
			-- Malicious Censer (Agility, Proc)
			{spellID = 183926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of the Blademaster (Images, Proc)
			{spellID = 184270, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Capacitator (Damage, Proc)
			{spellID = 184293, unitID = "player", caster = "player", filter = "BUFF"},
			-- Witherbark's Branch (Haste, Proc)
			{spellID = 165822, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Hemet's Heartseeker (Mastery)
			{spellID = 173288, unitID = "player", caster = "all", filter = "BUFF"},
			-- Megawatt Filament (Crit)
			{spellID = 156060, unitID = "player", caster = "all", filter = "BUFF"},
			-- Oglethorpe's Missile Splitter (Multistrike)
			{spellID = 156055, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Ankle Crack (Crocolisk)
			{spellID = 50433, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Black Arrow
			{spellID = 3674, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Concussive Shot
			{spellID = 5116, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 135373, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Explosive Shot
			{spellID = 53301, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freezing Trap
			{spellID = 3355, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freezing Trap (Glyph)
			{spellID = 61394, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Breath (Chimaera)
			{spellID = 54644, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frozen Ammo
			{spellID = 162546, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Ice Trap
			{spellID = 135299, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Narrow Escape
			{spellID = 136634, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Poisoned Ammo
			{spellID = 162543, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Serpent Sting
			{spellID = 87935, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Warp Time (Warp Stalker)
			{spellID = 35346, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C.position.filger.pve_cc)},

			-- Wyvern Sting
			{spellID = 19386, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- A Murder of Crows
			{spellID = 131894, filter = "CD"},
			-- Concussive Shot
			{spellID = 5116, filter = "CD"},
			-- Counter Shot
			{spellID = 147362, filter = "CD"},
			-- Chimera Shot
			{spellID = 53209, filter = "CD"},
			-- Barrage
			{spellID = 120360, filter = "CD"},
			-- Bestial Wrath
			{spellID = 19574, filter = "CD"},
			-- Binding Shot
			{spellID = 117526, filter = "CD"},
			-- Deterrence
			{spellID = 19263, filter = "CD"},
			-- Dire Beast
			{spellID = 120679, filter = "CD"},
			-- Disengage
			{spellID = 781, filter = "CD"},
			-- Exhilaration
			{spellID = 109304, filter = "CD"},
			-- Explosive Shot
			{spellID = 53301, filter = "CD"},
			-- Explosive Trap
			{spellID = 13813, filter = "CD"},
			-- Feign Death
			{spellID = 5384, filter = "CD"},
			-- Fervor
			{spellID = 82726, filter = "CD"},
			-- Glaive Toss
			{spellID = 117050, filter = "CD"},
			-- Ice Trap
			{spellID = 13809, filter = "CD"},
			-- Intimidation
			{spellID = 19577, filter = "CD"},
			-- Kill Command
			{spellID = 34026, filter = "CD"},
			-- Kill Shot
			{spellID = 53351, filter = "CD"},
			-- Lynx Rush
			{spellID = 120697, filter = "CD"},
			-- Master's Call
			{spellID = 53271, filter = "CD"},
			-- Misdirection
			{spellID = 34477, filter = "CD"},
			-- Powershot
			{spellID = 109259, filter = "CD"},
			-- Rapid Fire
			{spellID = 3045, filter = "CD"},
			-- Spirit Mend (Pet)
			{spellID = 90361, filter = "CD"},
			-- Wyvern Sting
			{spellID = 19386, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
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
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Alter Time
			{spellID = 110909, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Power
			{spellID = 12042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evanesce
			{spellID = 157913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Greater Invisibility
			{spellID = 110960, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Heating Up
			{spellID = 48107, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Barrier
			{spellID = 11426, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Block
			{spellID = 45438, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Floes
			{spellID = 108839, unitID = "player", caster = "player", filter = "BUFF"},
			-- Icy Veins
			{spellID = 12472, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incanter's Flow
			{spellID = 1463, unitID = "player", caster = "player", filter = "BUFF"},
			-- Invisibility
			{spellID = 32612, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Rune of Power
			{spellID = 116014, unitID = "player", caster = "player", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 115610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Prismatic Crystal
			{spellID = 152087, filter = "ICD", trigger = "NONE", duration = 12},
			-- Mirror Image
			{spellID = 55342, filter = "ICD", trigger = "NONE", duration = 40},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Arcane Missiles!
			{spellID = 79683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brain Freeze
			{spellID = 57761, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fingers of Frost
			{spellID = 44544, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pyroblast!
			{spellID = 48108, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Caster DPS (Crit, Proc)
			{spellID = 162919, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Mithril Wristwatch (Spell Power, Proc)
			{spellID = 127924, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Proc)
			{spellID = 182058, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Orb Of Voidsight
			{spellID = 201410, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Caster DPS
			-- Blackiron Micro Crucible (Multistrike, Proc)
			{spellID = 177081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Copeland's Clarity (Spellpower, Use)
			{spellID = 177594, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darmac's Unstable Talisman (Haste, Proc)
			{spellID = 177051, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Orb of Putrescence (Mastery, Proc)
			{spellID = 176941, unitID = "player", caster = "player", filter = "BUFF"},
			-- Furyheart Talisman (Haste, Proc)
			{spellID = 176980, unitID = "player", caster = "player", filter = "BUFF"},
			-- Goren Soul Repository (Crit, Proc)
			{spellID = 177046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shards of Nothing (Haste, Use)
			{spellID = 176875, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Caster DPS
			-- Desecrated Shadowmoon Insignia (Intellect, Proc)
			{spellID = 183924, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coagulated Genesaur Blood (Multistrike, Proc)
			{spellID = 165832, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ragewing's Firefang (Versatility, Use)
			{spellID = 165543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fleshrender's Meathook (Haste, Use)
			{spellID = 165531, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Arcane Charge
			{spellID = 36032, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Combustion
			{spellID = 83853, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freeze (Pet)
			{spellID = 33395, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frostfire Bolt
			{spellID = 44614, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Bomb
			{spellID = 112948, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ice Ward
			{spellID = 111340, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ignite
			{spellID = 12654, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Living Bomb
			{spellID = 44457, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Nether Tempest
			{spellID = 114923, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroblast
			{spellID = 11366, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Water Jet (Pet)
			{spellID = 135029, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
			-- Mark of Doom [Prophecy of Fear]
			{spellID = 184073, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C.position.filger.pve_cc)},

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
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Alter Time
			{spellID = 108978, filter = "CD"},
			-- Arcane Power
			{spellID = 12042, filter = "CD"},
			-- Cold Snap
			{spellID = 11958, filter = "CD"},
			-- Cone of Cold
			{spellID = 120, filter = "CD"},
			-- Counterspell
			{spellID = 2139, filter = "CD"},
			-- Blazing Speed
			{spellID = 108843, filter = "CD"},
			-- Blink
			{spellID = 1953, filter = "CD"},
			-- Combustion
			{spellID = 11129, filter = "CD"},
			-- Comet Storm
			{spellID = 153595, filter = "CD"},
			-- Deep Freeze
			{spellID = 44572, filter = "CD"},
			-- Evocation
			{spellID = 12051, filter = "CD"},
			-- Fire Blast
			{spellID = 2136, filter = "CD"},
			-- Flamestrike
			{spellID = 2120, filter = "CD"},
			-- Frostjaw
			{spellID = 102051, filter = "CD"},
			-- Frost Bomb
			{spellID = 112948, filter = "CD"},
			-- Frost Nova
			{spellID = 122, filter = "CD"},
			-- Frozen Orb
			{spellID = 84714, filter = "CD"},
			-- Ice Barrier
			{spellID = 11426, filter = "CD"},
			-- Ice Block
			{spellID = 45438, filter = "CD"},
			-- Ice Floes
			{spellID = 108839, filter = "CD"},
			-- Ice Ward
			{spellID = 111264, filter = "CD"},
			-- Icy Veins
			{spellID = 12472, filter = "CD"},
			-- Incanter's Ward
			{spellID = 1463, filter = "CD"},
			-- Invisibility
			{spellID = 66, filter = "CD"},
			-- Mirror Image
			{spellID = 55342, filter = "CD"},
			-- Presence of Mind
			{spellID = 12043, filter = "CD"},
			-- Prismatic Crystal
			{spellID = 152087, filter = "CD"},
			-- Remove Curse
			{spellID = 475, filter = "CD"},
			-- Ring of Frost
			{spellID = 113724, filter = "CD"},
			-- Temporal Shield
			{spellID = 115610, filter = "CD"},
			-- Water Jet (Pet)
			{spellID = 135029, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["MONK"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Dampen Harm
			{spellID = 122278, unitID = "player", caster = "player", filter = "BUFF"},
			-- Diffuse Magic
			{spellID = 122783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elusive Brew
			{spellID = 115308, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Energizing Brew
			{spellID = 115288, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fortifying Brew
			{spellID = 120954, unitID = "player", caster = "player", filter = "BUFF"},
			-- Guard
			{spellID = 115295, unitID = "player", caster = "player", filter = "BUFF"},
			-- Momentum
			{spellID = 119085, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thunder Focus Tea
			{spellID = 116680, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tigereye Brew
			{spellID = 116740, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Touch of Karma
			{spellID = 125174, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Breath of Fire
			{spellID = 123725, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Dizzying Haze
			{spellID = 116330, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Heavy Stagger
			{spellID = 124273, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Rising Sun Kick
			{spellID = 130320, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Combo Breaker: Blackout Kick
			{spellID = 116768, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combo Breaker: Tiger Palm
			{spellID = 118864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elusive Brew
			{spellID = 128939, unitID = "player", caster = "player", filter = "BUFF", absID = true, count = 12},
			-- Mana Tea
			{spellID = 115867, unitID = "player", caster = "player", filter = "BUFF", absID = true, count = 18},
			-- Serpent's Zeal
			{spellID = 127722, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shuffle
			{spellID = 115307, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tigereye Brew
			{spellID = 125195, unitID = "player", caster = "player", filter = "BUFF", absID = true, count = 10},
			-- Tiger Power
			{spellID = 125359, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger Strikes
			{spellID = 120273, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vital Mists
			{spellID = 118674, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Healing (Spirit, Proc)
			{spellID = 162913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS (Crit, Proc)
			{spellID = 162915, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking (Crit, Proc)
			{spellID = 162917, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Brawler's Statue (Bonus Armor, Use)
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coren's Cold Chromium (Attack Power, Proc)
			{spellID = 127926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thousand-Year Pickled Egg (Haste, Proc)
			{spellID = 127914, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Agility] (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Agility] (Versatility, Proc)
			{spellID = 182060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Infallible Tracking Charm
			{spellID = 201408, unitID = "player", caster = "player", filter = "BUFF"},
			-- Orb Of Voidsight
			{spellID = 201410, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Tanking
			-- Battering Talisman (Haste, Proc)
			{spellID = 177102, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blast Furnace Door (Mastery, Proc)
			{spellID = 177056, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evergaze Arcane Eidolon (Bonus Armor, Proc)
			{spellID = 177053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Relic of Blood (Haste, Proc)
			{spellID = 176937, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kyb's Foolish Perseverance (Health, Use)
			{spellID = 176460, unitID = "player", caster = "player", filter = "BUFF"},
			-- Petrified Flesh-Eating Spore (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pol's Blinded Eye (Mastery, Use)
			{spellID = 176876, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneheart Idol (Crit, Proc)
			{spellID = 176982, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tablet of Turnbuckle Teamwork (Bonus Armor, Use)
			{spellID = 176873, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Tanking
			-- Anzu's Cursed Plume (Mastery, Proc)
			{spellID = 183931, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enforcer's Stun Grenade (Versatility, Use)
			{spellID = 165534, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tyrant's Decree (Stamina, Proc)
			{spellID = 184770, unitID = "player", caster = "player", filter = "BUFF"},
			-- Xeri'tac's Unhatched Egg Sac (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.0: Melee DPS [Agility]
			-- Beating Heart of the Mountain (Multistrike, Use)
			{spellID = 176878, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blackheart Enforcer's Medallion (Multistrike, Proc)
			{spellID = 176984, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Jar of Doom (Mastery, Proc)
			{spellID = 176939, unitID = "player", caster = "player", filter = "BUFF"},
			-- Humming Blackiron Trigger (Crit, Proc)
			{spellID = 177067, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lucky Double-Sided Coin (Agility, Use)
			{spellID = 177597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meaty Dragonspine Trophy (Haste, Proc)
			{spellID = 177035, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scales of Doom (Multistrike, Proc)
			{spellID = 177038, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.1: Melee DPS [Agility]
			-- Gor'ashan's Lodestone Spike (Multistrike, Use)
			{spellID = 165542, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kihra's Adrenaline Injector (Mastery, Use)
			{spellID = 165485, unitID = "player", caster = "player", filter = "BUFF"},
			-- Malicious Censer (Agility, Proc)
			{spellID = 183926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of the Blademaster (Images, Proc)
			{spellID = 184270, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Capacitator (Damage, Proc)
			{spellID = 184293, unitID = "player", caster = "player", filter = "BUFF"},
			-- Witherbark's Branch (Haste, Proc)
			{spellID = 165822, unitID = "player", caster = "player", filter = "BUFF"},
			-- 5.0: Healing
			-- Auto-Repairing Autoclave (Haste, Proc)
			{spellID = 177086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elementalist's Shielding Talisman (Multistrike, Proc)
			{spellID = 177063, unitID = "player", caster = "player", filter = "BUFF"},
			-- Emblem of Caustic Healing (Haste, Use)
			{spellID = 176879, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Censer of Faith (Haste, Proc)
			{spellID = 176943, unitID = "player", caster = "player", filter = "BUFF"},
			-- Immaculate Living Mushroom (Crit, Proc)
			{spellID = 176978, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ironspike Chew Toy (Spirit, Proc)
			{spellID = 177060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 5.1: Healing
			-- Intuition's Gift (Crit, Use)
			{spellID = 183929, unitID = "player", caster = "player", filter = "BUFF"},
			-- Leaf of the Ancient Protectors (Versatility, Proc)
			{spellID = 165833, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tharbek's Lucky Pebble (Mastery, Use)
			{spellID = 165535, unitID = "player", caster = "player", filter = "BUFF"},
			-- Voidmender's Shadowgem (Crit, Use)
			{spellID = 165532, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Blackrock (Bonus Armor)
			{spellID = 159679, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Shadowmoon (Spirit)
			{spellID = 159678, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Charging Ox Wave
			{spellID = 119392, filter = "CD"},
			-- Chi Burst
			{spellID = 123986, filter = "CD"},
			-- Chi Wave
			{spellID = 115098, filter = "CD"},
			-- Dampen Harm
			{spellID = 122278, filter = "CD"},
			-- Detox
			{spellID = 115450, filter = "CD"},
			-- Energizing Brew
			{spellID = 115288, filter = "CD"},
			-- Expel Harm
			{spellID = 115072, filter = "CD"},
			-- Fists of Fury
			{spellID = 113656, filter = "CD"},
			-- Flying Serpent Kick
			{spellID = 101545, filter = "CD"},
			-- Guard
			{spellID = 115295, filter = "CD"},
			-- Invoke Xuen, the White Tiger
			{spellID = 123904, filter = "CD"},
			-- Life Cocoon
			{spellID = 116849, filter = "CD"},
			-- Nimble Brew
			{spellID = 137562, filter = "CD"},
			-- Paralysis
			{spellID = 115078, filter = "CD"},
			-- Provoke
			{spellID = 115546, filter = "CD"},
			-- Ring of Peace
			{spellID = 116844, filter = "CD"},
			-- Rising Sun Kick
			{spellID = 107428, filter = "CD"},
			-- Spear Hand Strike
			{spellID = 116705, filter = "CD"},
			-- Thunder Focus Tea
			{spellID = 116680, filter = "CD"},
			-- Touch of Karma
			{spellID = 122470, filter = "CD"},
			-- Touch of Death
			{spellID = 115080, filter = "CD"},
			-- Zen Sphere
			{spellID = 124081, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},

			-- Internal
			-- Tiger Power
			{spellID = 125359, unitID = "player", caster = "player", filter = "BUFF"},
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
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Ardent Defender
			{spellID = 31850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avenging Wrath
			{spellID = 31884, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Shield
			{spellID = 642, unitID = "player", caster = "player", filter = "BUFF"},
			-- Eternal Flame
			{spellID = 114163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Avenger
			{spellID = 105809, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sacred Shield
			{spellID = 20925, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Seraphim
			{spellID = 152262, unitID = "player", caster = "player", filter = "BUFF"},
			-- Speed of Light
			{spellID = 85499, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Bastion of Glory
			{spellID = 114637, unitID = "player", caster = "player", filter = "BUFF"},
			-- Final Verdict
			{spellID = 157048, unitID = "player", caster = "player", filter = "BUFF"},
			-- Daybreak
			{spellID = 88819, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Crusader
			{spellID = 144595, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Purpose
			{spellID = 90174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grand Crusader
			{spellID = 85416, unitID = "player", caster = "player", filter = "BUFF"},
			-- Infusion of Light
			{spellID = 54149, unitID = "player", caster = "player", filter = "BUFF"},
			-- Long Arm of the Law
			{spellID = 87173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Selfless Healer
			{spellID = 114250, unitID = "player", caster = "player", filter = "BUFF"},
			-- Supplication
			{spellID = 94686, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Healing (Spirit, Proc)
			{spellID = 162913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS (Crit, Proc)
			{spellID = 162915, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking (Crit, Proc)
			{spellID = 162917, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Strength
			{spellID = 60229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Brawler's Statue (Bonus Armor, Use)
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coren's Cold Chromium (Attack Power, Proc)
			{spellID = 127926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thousand-Year Pickled Egg (Haste, Proc)
			{spellID = 127914, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Strength] (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Strength] (Versatility, Proc)
			{spellID = 182063, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Gronntooth War Horn (Strength, Proc)
			{spellID = 201405, unitID = "player", caster = "player", filter = "BUFF"},
			-- Orb Of Voidsight
			{spellID = 201410, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Tanking
			-- Battering Talisman (Haste, Proc)
			{spellID = 177102, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blast Furnace Door (Mastery, Proc)
			{spellID = 177056, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evergaze Arcane Eidolon (Bonus Armor, Proc)
			{spellID = 177053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Relic of Blood (Haste, Proc)
			{spellID = 176937, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kyb's Foolish Perseverance (Health, Use)
			{spellID = 176460, unitID = "player", caster = "player", filter = "BUFF"},
			-- Petrified Flesh-Eating Spore (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pol's Blinded Eye (Mastery, Use)
			{spellID = 176876, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneheart Idol (Crit, Proc)
			{spellID = 176982, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tablet of Turnbuckle Teamwork (Bonus Armor, Use)
			{spellID = 176873, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Tanking
			-- Anzu's Cursed Plume (Mastery, Proc)
			{spellID = 183931, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enforcer's Stun Grenade (Versatility, Use)
			{spellID = 165534, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tyrant's Decree (Stamina, Proc)
			{spellID = 184770, unitID = "player", caster = "player", filter = "BUFF"},
			-- Xeri'tac's Unhatched Egg Sac (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.0: Melee DPS [Strength]
			-- Forgemaster's Insignia (Multistrike, Proc)
			{spellID = 177096, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Fang (Multistrike, Proc)
			{spellID = 176935, unitID = "player", caster = "player", filter = "BUFF"},
			-- Horn of the Screaming Spirits (Mastery, Proc)
			{spellID = 177042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mote of the Mountain (Versatility, Proc)
			{spellID = 176974, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scabbard of Kyanos (Strength, Use)
			{spellID = 177189, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tectus' Beating Heart (Crit, Proc)
			{spellID = 177040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Convulsive Shadows (Multistrike, Use)
			{spellID = 176874, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.1: Melee DPS [Strength]
			-- Bonemaw's Big Toe (Crit, Use)
			{spellID = 165532, unitID = "player", caster = "player", filter = "BUFF"},
			-- Emberscale Talisman (Versatility, Use)
			{spellID = 165543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spores of Alacrity (Haste, Proc)
			{spellID = 165822, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unending Hunger (Strength, Proc)
			{spellID = 183941, unitID = "player", caster = "player", filter = "BUFF"},
			-- 5.0: Healing
			-- Auto-Repairing Autoclave (Haste, Proc)
			{spellID = 177086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elementalist's Shielding Talisman (Multistrike, Proc)
			{spellID = 177063, unitID = "player", caster = "player", filter = "BUFF"},
			-- Emblem of Caustic Healing (Haste, Use)
			{spellID = 176879, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Censer of Faith (Haste, Proc)
			{spellID = 176943, unitID = "player", caster = "player", filter = "BUFF"},
			-- Immaculate Living Mushroom (Crit, Proc)
			{spellID = 176978, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ironspike Chew Toy (Spirit, Proc)
			{spellID = 177060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 6.1: Healing
			-- Intuition's Gift (Crit, Use)
			{spellID = 183929, unitID = "player", caster = "player", filter = "BUFF"},
			-- Leaf of the Ancient Protectors (Versatility, Proc)
			{spellID = 165833, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tharbek's Lucky Pebble (Mastery, Use)
			{spellID = 165535, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Blackrock (Bonus Armor)
			{spellID = 159679, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Shadowmoon (Spirit)
			{spellID = 159678, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Censure
			{spellID = 31803, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Dazing Shield (Glyph)
			{spellID = 63529, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Denounce
			{spellID = 2812, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Forbearance
			{spellID = 25771, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seal of Justice
			{spellID = 20170, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
			-- Fel Burn [Empty Drinking Horn]
			{spellID = 184256, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Ardent Defender
			{spellID = 31850, filter = "CD"},
			-- Avenger's Shield
			{spellID = 31935, filter = "CD"},
			-- Avenging Wrath
			{spellID = 31884, filter = "CD"},
			-- Blinding Light
			{spellID = 115750, filter = "CD"},
			-- Cleanse
			{spellID = 4987, filter = "CD"},
			-- Consecration
			{spellID = 26573, filter = "CD"},
			-- Devotion Aura
			{spellID = 31821, filter = "CD"},
			-- Divine Protection
			{spellID = 498, filter = "CD"},
			-- Execution Sentence
			{spellID = 114157, filter = "CD"},
			-- Exorcism
			{spellID = 879, filter = "CD"},
			-- Hammer of Justice
			{spellID = 853, filter = "CD"},
			-- Hand of Freedom
			{spellID = 1044, filter = "CD"},
			-- Hand of Protection
			{spellID = 1022, filter = "CD"},
			-- Hand of Purity
			{spellID = 114039, filter = "CD"},
			-- Hand of Sacrifice
			{spellID = 6940, filter = "CD"},
			-- Holy Avenger
			{spellID = 105809, filter = "CD"},
			-- Holy Prism
			{spellID = 114165, filter = "CD"},
			-- Holy Wrath
			{spellID = 119072, filter = "CD"},
			-- Judgment
			{spellID = 20271, filter = "CD"},
			-- Light's Hammer
			{spellID = 114158, filter = "CD"},
			-- Rebuke
			{spellID = 96231, filter = "CD"},
			-- Repentance
			{spellID = 20066, filter = "CD"},
			-- Speed of Light
			{spellID = 85499, filter = "CD"},
			-- Turn Evil
			{spellID = 10326, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
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
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Archangel
			{spellID = 81700, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dispersion
			{spellID = 47585, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fade
			{spellID = 586, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Will
			{spellID = 45242, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Infusion
			{spellID = 10060, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Word: Shield
			{spellID = 17, unitID = "player", caster = "all", filter = "BUFF"},
			-- Renew
			{spellID = 139, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spectral Guise
			{spellID = 112833, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Shell
			{spellID = 109964, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Vampiric Embrace
			{spellID = 15286, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Borrowed Time
			{spellID = 59889, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Insight
			{spellID = 123267, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evangelism
			{spellID = 81661, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mind Spike (Glyph)
			{spellID = 81292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Serendipity
			{spellID = 63735, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowy Insight
			{spellID = 124430, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Word: Insanity
			{spellID = 132573, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Darkness
			{spellID = 87160, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Light
			{spellID = 114255, unitID = "player", caster = "player", filter = "BUFF"},
			-- Twist of Fate
			{spellID = 123254, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Caster DPS (Crit, Proc)
			{spellID = 162919, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing (Spirit, Proc)
			{spellID = 162913, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Mithril Wristwatch (Spell Power, Proc)
			{spellID = 127924, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thousand-Year Pickled Egg (Haste, Proc)
			{spellID = 127914, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Proc)
			{spellID = 182058, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Orb Of Voidsight
			{spellID = 201410, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Caster DPS
			-- Blackiron Micro Crucible (Multistrike, Proc)
			{spellID = 177081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Copeland's Clarity (Spellpower, Use)
			{spellID = 177594, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darmac's Unstable Talisman (Haste, Proc)
			{spellID = 177051, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Orb of Putrescence (Mastery, Proc)
			{spellID = 176941, unitID = "player", caster = "player", filter = "BUFF"},
			-- Furyheart Talisman (Haste, Proc)
			{spellID = 176980, unitID = "player", caster = "player", filter = "BUFF"},
			-- Goren Soul Repository (Crit, Proc)
			{spellID = 177046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shards of Nothing (Haste, Use)
			{spellID = 176875, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Caster DPS
			-- Desecrated Shadowmoon Insignia (Intellect, Proc)
			{spellID = 183924, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coagulated Genesaur Blood (Multistrike, Proc)
			{spellID = 165832, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ragewing's Firefang (Versatility, Use)
			{spellID = 165543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fleshrender's Meathook (Haste, Use)
			{spellID = 165531, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.0: Healing
			-- Auto-Repairing Autoclave (Haste, Proc)
			{spellID = 177086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elementalist's Shielding Talisman (Multistrike, Proc)
			{spellID = 177063, unitID = "player", caster = "player", filter = "BUFF"},
			-- Emblem of Caustic Healing (Haste, Use)
			{spellID = 176879, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Censer of Faith (Haste, Proc)
			{spellID = 176943, unitID = "player", caster = "player", filter = "BUFF"},
			-- Immaculate Living Mushroom (Crit, Proc)
			{spellID = 176978, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ironspike Chew Toy (Spirit, Proc)
			{spellID = 177060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.1: Healing
			-- Intuition's Gift (Crit, Use)
			{spellID = 183929, unitID = "player", caster = "player", filter = "BUFF"},
			-- Leaf of the Ancient Protectors (Versatility, Proc)
			{spellID = 165833, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tharbek's Lucky Pebble (Mastery, Use)
			{spellID = 165535, unitID = "player", caster = "player", filter = "BUFF"},
			-- Voidmender's Shadowgem (Crit, Use)
			{spellID = 165532, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Shadowmoon (Spirit)
			{spellID = 159678, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Mind Blast (Glyph)
			{spellID = 87194, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Void Tendrils
			{spellID = 114404, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
			-- Mark of Doom [Prophecy of Fear]
			{spellID = 184073, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C.position.filger.target_bar)},

			-- Devouring Plague
			{spellID = 2944, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "player", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "player", filter = "BUFF"},
			-- Prayer of Mending
			{spellID = 41635, unitID = "target", caster = "player", filter = "BUFF"},
			-- Renew
			{spellID = 139, unitID = "target", caster = "player", filter = "BUFF"},
			-- Shadow Word: Pain
			{spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vampiric Touch
			{spellID = 34914, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Void Entropy
			{spellID = 155361, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C.position.filger.pve_cc)},

			-- Shackle Undead
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
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Archangel
			{spellID = 81700, filter = "CD"},
			-- Cascade
			{spellID = 121135, filter = "CD"},
			-- Circle of Healing
			{spellID = 34861, filter = "CD"},
			-- Desperate Prayer
			{spellID = 19236, filter = "CD"},
			-- Dispersion
			{spellID = 47585, filter = "CD"},
			-- Divine Star
			{spellID = 110744, filter = "CD"},
			-- Guardian Spirit
			{spellID = 47788, filter = "CD"},
			-- Halo
			{spellID = 120517, filter = "CD"},
			-- Holy Fire
			{spellID = 14914, filter = "CD"},
			-- Holy Word: Chastise
			{spellID = 88625, filter = "CD"},
			-- Leap of Faith
			{spellID = 73325, filter = "CD"},
			-- Mass Dispel
			{spellID = 32375, filter = "CD"},
			-- Mind Blast
			{spellID = 8092, filter = "CD"},
			-- Pain Suppression
			{spellID = 33206, filter = "CD"},
			-- Penance
			{spellID = 47540, filter = "CD"},
			-- Prayer of Mending
			{spellID = 33076, filter = "CD"},
			-- Psychic Horror
			{spellID = 64044, filter = "CD"},
			-- Psychic Scream
			{spellID = 8122, filter = "CD"},
			-- Purify
			{spellID = 527, filter = "CD"},
			-- Power Infusion
			{spellID = 10060, filter = "CD"},
			-- Power Word: Barrier
			{spellID = 62618, filter = "CD"},
			-- Shadow Word: Death
			{spellID = 32379, filter = "CD"},
			-- Silence
			{spellID = 15487, filter = "CD"},
			-- Void Tendrils
			{spellID = 108920, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
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
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Adrenaline Rush
			{spellID = 13750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blade Flurry
			{spellID = 13877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burst of Speed
			{spellID = 108212, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cloak of Shadows
			{spellID = 31224, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Readiness
			{spellID = 74001, unitID = "player", caster = "player", filter = "BUFF"},
			-- Envenom
			{spellID = 32645, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "player", caster = "player", filter = "BUFF"},
			-- Feint
			{spellID = 1966, unitID = "player", caster = "player", filter = "BUFF"},
			-- Master of Subtlety
			{spellID = 31665, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recuperate
			{spellID = 73651, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 51713, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Reflection
			{spellID = 152151, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slice and Dice
			{spellID = 5171, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sprint
			{spellID = 2983, unitID = "player", caster = "player", filter = "BUFF"},
			-- Subterfuge
			{spellID = 115192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vanish
			{spellID = 1856, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Anticipation
			{spellID = 115189, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blindside
			{spellID = 121153, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Insight
			{spellID = 84747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moderate Insight
			{spellID = 84746, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shallow Insight
			{spellID = 84745, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Deathly Shadows (T18)
			{spellID = 188700, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Melee DPS (Crit, Proc)
			{spellID = 162915, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Coren's Cold Chromium (Attack Power, Proc)
			{spellID = 127926, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Agility] (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Agility] (Versatility, Proc)
			{spellID = 182060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Infallible Tracking Charm
			{spellID = 201408, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Melee DPS [Agility]
			-- Beating Heart of the Mountain (Multistrike, Use)
			{spellID = 176878, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blackheart Enforcer's Medallion (Multistrike, Proc)
			{spellID = 176984, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Jar of Doom (Mastery, Proc)
			{spellID = 176939, unitID = "player", caster = "player", filter = "BUFF"},
			-- Humming Blackiron Trigger (Crit, Proc)
			{spellID = 177067, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lucky Double-Sided Coin (Agility, Use)
			{spellID = 177597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meaty Dragonspine Trophy (Haste, Proc)
			{spellID = 177035, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scales of Doom (Multistrike, Proc)
			{spellID = 177038, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Melee DPS [Agility]
			-- Gor'ashan's Lodestone Spike (Multistrike, Use)
			{spellID = 165542, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kihra's Adrenaline Injector (Mastery, Use)
			{spellID = 165485, unitID = "player", caster = "player", filter = "BUFF"},
			-- Malicious Censer (Agility, Proc)
			{spellID = 183926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of the Blademaster (Images, Proc)
			{spellID = 184270, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Capacitator (Damage, Proc)
			{spellID = 184293, unitID = "player", caster = "player", filter = "BUFF"},
			-- Witherbark's Branch (Haste, Proc)
			{spellID = 165822, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Crippling Poison
			{spellID = 3409, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Deadly Poison
			{spellID = 2818, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Find Weakness
			{spellID = 91021, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Garrote
			{spellID = 703, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hemorrhage
			{spellID = 16511, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Revealing Strike
			{spellID = 84617, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rupture
			{spellID = 1943, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vendetta
			{spellID = 79140, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Wound Poison
			{spellID = 8680, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C.position.filger.pve_cc)},

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
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Adrenaline Rush
			{spellID = 13750, filter = "CD"},
			-- Combat Readiness
			{spellID = 74001, filter = "CD"},
			-- Gouge
			{spellID = 1776, filter = "CD"},
			-- Kick
			{spellID = 1766, filter = "CD"},
			-- Kidney Shot
			{spellID = 408, filter = "CD"},
			-- Killing Spree
			{spellID = 51690, filter = "CD"},
			-- Premiditation
			{spellID = 14183, filter = "CD"},
			-- Shadow Dance
			{spellID = 51713, filter = "CD"},
			-- Shadow Reflection
			{spellID = 152151, filter = "CD"},
			-- Sprint
			{spellID = 2983, filter = "CD"},
			-- Stealth
			{spellID = 1784, filter = "CD"},
			-- Vanish
			{spellID = 1856, filter = "CD"},
			-- Vendetta
			{spellID = 79140, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
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
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Ancestral Guidance
			{spellID = 108281, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance
			{spellID = 114049, unitID = "player", caster = "player", filter = "BUFF"},
			-- Astral Shift
			{spellID = 108271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Mastery
			{spellID = 16166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Shield
			{spellID = 324, unitID = "player", caster = "player", filter = "BUFF", spec = 1, count = 6},
			-- Maelstorm Weapon
			{spellID = 53817, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature Guardian
			{spellID = 31616, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shamanistic Rage
			{spellID = 30823, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stone Bulwark
			{spellID = 114893, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Flame
			{spellID = 73683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Life
			{spellID = 73685, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Elemental Blast
			{spellID = 118522, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lava Surge
			{spellID = 77762, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tidal Waves
			{spellID = 53390, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Caster DPS (Crit, Proc)
			{spellID = 162919, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing (Spirit, Proc)
			{spellID = 162913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS (Crit, Proc)
			{spellID = 162915, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Coren's Cold Chromium (Attack Power, Proc)
			{spellID = 127926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mithril Wristwatch (Spell Power, Proc)
			{spellID = 127924, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thousand-Year Pickled Egg (Haste, Proc)
			{spellID = 127914, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Proc)
			{spellID = 182058, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Agility] (Versatility, Proc)
			{spellID = 182060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Infallible Tracking Charm
			{spellID = 201408, unitID = "player", caster = "player", filter = "BUFF"},
			-- Orb Of Voidsight
			{spellID = 201410, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Melee DPS [Agility]
			-- Beating Heart of the Mountain (Multistrike, Use)
			{spellID = 176878, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blackheart Enforcer's Medallion (Multistrike, Proc)
			{spellID = 176984, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Jar of Doom (Mastery, Proc)
			{spellID = 176939, unitID = "player", caster = "player", filter = "BUFF"},
			-- Humming Blackiron Trigger (Crit, Proc)
			{spellID = 177067, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lucky Double-Sided Coin (Agility, Use)
			{spellID = 177597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meaty Dragonspine Trophy (Haste, Proc)
			{spellID = 177035, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scales of Doom (Multistrike, Proc)
			{spellID = 177038, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Melee DPS [Agility]
			-- Gor'ashan's Lodestone Spike (Multistrike, Use)
			{spellID = 165542, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kihra's Adrenaline Injector (Mastery, Use)
			{spellID = 165485, unitID = "player", caster = "player", filter = "BUFF"},
			-- Malicious Censer (Agility, Proc)
			{spellID = 183926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror of the Blademaster (Images, Proc)
			{spellID = 184270, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Capacitator (Damage, Proc)
			{spellID = 184293, unitID = "player", caster = "player", filter = "BUFF"},
			-- Witherbark's Branch (Haste, Proc)
			{spellID = 165822, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.0: Caster DPS
			-- Blackiron Micro Crucible (Multistrike, Proc)
			{spellID = 177081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Copeland's Clarity (Spellpower, Use)
			{spellID = 177594, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darmac's Unstable Talisman (Haste, Proc)
			{spellID = 177051, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Orb of Putrescence (Mastery, Proc)
			{spellID = 176941, unitID = "player", caster = "player", filter = "BUFF"},
			-- Furyheart Talisman (Haste, Proc)
			{spellID = 176980, unitID = "player", caster = "player", filter = "BUFF"},
			-- Goren Soul Repository (Crit, Proc)
			{spellID = 177046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shards of Nothing (Haste, Use)
			{spellID = 176875, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.1: Caster DPS
			-- Desecrated Shadowmoon Insignia (Intellect, Proc)
			{spellID = 183924, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coagulated Genesaur Blood (Multistrike, Proc)
			{spellID = 165832, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ragewing's Firefang (Versatility, Use)
			{spellID = 165543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fleshrender's Meathook (Haste, Use)
			{spellID = 165531, unitID = "player", caster = "player", filter = "BUFF"},
			-- 5.0: Healing
			-- Auto-Repairing Autoclave (Haste, Proc)
			{spellID = 177086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elementalist's Shielding Talisman (Multistrike, Proc)
			{spellID = 177063, unitID = "player", caster = "player", filter = "BUFF"},
			-- Emblem of Caustic Healing (Haste, Use)
			{spellID = 176879, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Censer of Faith (Haste, Proc)
			{spellID = 176943, unitID = "player", caster = "player", filter = "BUFF"},
			-- Immaculate Living Mushroom (Crit, Proc)
			{spellID = 176978, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ironspike Chew Toy (Spirit, Proc)
			{spellID = 177060, unitID = "player", caster = "player", filter = "BUFF"},
			-- 5.1: Healing
			-- Intuition's Gift (Crit, Use)
			{spellID = 183929, unitID = "player", caster = "player", filter = "BUFF"},
			-- Leaf of the Ancient Protectors (Versatility, Proc)
			{spellID = 165833, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tharbek's Lucky Pebble (Mastery, Use)
			{spellID = 165535, unitID = "player", caster = "player", filter = "BUFF"},
			-- Voidmender's Shadowgem (Crit, Use)
			{spellID = 165532, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Shadowmoon (Spirit)
			{spellID = 159678, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Earthgrab
			{spellID = 64695, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Flame Shock
			{spellID = 8050, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Stormstrike
			{spellID = 17364, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
			-- Mark of Doom [Prophecy of Fear]
			{spellID = 184073, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C.position.filger.target_bar)},

			-- Earth Shield
			{spellID = 974, unitID = "target", caster = "player", filter = "BUFF"},
			-- Riptide
			{spellID = 61295, unitID = "target", caster = "player", filter = "BUFF"},
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
			Position = {unpack(C.position.filger.pve_cc)},

			-- Hex
			{spellID = 51514, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Ancestral Guidance
			{spellID = 108281, filter = "CD"},
			-- Ancestral Swiftness
			{spellID = 16188, filter = "CD"},
			-- Ascendance
			{spellID = 114049, filter = "CD"},
			-- Astral Shift
			{spellID = 108271, filter = "CD"},
			-- Cleanse Spirit
			{spellID = 51886, filter = "CD"},
			-- Earthbind Totem
			{spellID = 2484, filter = "CD"},
			-- Earth Shock
			{spellID = 8042, filter = "CD"},
			-- Elemental Blast
			{spellID = 117014, filter = "CD"},
			-- Feral Spirit
			{spellID = 51533, filter = "CD"},
			-- Healing Rain
			{spellID = 73920, filter = "CD"},
			-- Hex
			{spellID = 51514, filter = "CD"},
			-- Lava Burst
			{spellID = 51505, filter = "CD"},
			-- Lava Lash
			{spellID = 60103, filter = "CD"},
			-- Riptide
			{spellID = 61295, filter = "CD"},
			-- Shamanistic Rage
			{spellID = 30823, filter = "CD"},
			-- Spiritwalker's Grace
			{spellID = 79206, filter = "CD"},
			-- Stone Bulwark Totem
			{spellID = 108270, filter = "CD"},
			-- Stormstrike
			{spellID = 17364, filter = "CD"},
			-- Thunderstorm
			{spellID = 51490, filter = "CD"},
			-- Tremor Totem
			{spellID = 8143, filter = "CD"},
			-- Unleash Elements
			{spellID = 73680, filter = "CD"},
			-- Wind Shear
			{spellID = 57994, filter = "CD"},

			-- Racial
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
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
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Blood Horror
			{spellID = 111397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Rush
			{spellID = 111400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Bargain
			{spellID = 110913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Regeneration
			{spellID = 108359, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Knowledge
			{spellID = 113861, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Misery
			{spellID = 113860, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Instability
			{spellID = 113858, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire and Brimstone
			{spellID = 108683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healthstone
			{spellID = 6262, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kiljaeden's Cunning
			{spellID = 137587, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soulburn
			{spellID = 74434, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Swap
			{spellID = 86211, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Buffs
			-- Backdraft
			{spellID = 117828, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demonic Synergy
			{spellID = 171982, unitID = "player", caster = "player", filter = "BUFF"},
			-- Molten Core
			{spellID = 122355, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Caster DPS (Crit, Proc)
			{spellID = 162919, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Mithril Wristwatch (Spell Power, Proc)
			{spellID = 127924, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS (Versatility, Proc)
			{spellID = 182058, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Orb Of Voidsight
			{spellID = 201410, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Caster DPS
			-- Blackiron Micro Crucible (Multistrike, Proc)
			{spellID = 177081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Copeland's Clarity (Spellpower, Use)
			{spellID = 177594, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darmac's Unstable Talisman (Haste, Proc)
			{spellID = 177051, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Orb of Putrescence (Mastery, Proc)
			{spellID = 176941, unitID = "player", caster = "player", filter = "BUFF"},
			-- Furyheart Talisman (Haste, Proc)
			{spellID = 176980, unitID = "player", caster = "player", filter = "BUFF"},
			-- Goren Soul Repository (Crit, Proc)
			{spellID = 177046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shards of Nothing (Haste, Use)
			{spellID = 176875, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Caster DPS
			-- Desecrated Shadowmoon Insignia (Intellect, Proc)
			{spellID = 183924, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coagulated Genesaur Blood (Multistrike, Proc)
			{spellID = 165832, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ragewing's Firefang (Versatility, Use)
			{spellID = 165543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fleshrender's Meathook (Haste, Use)
			{spellID = 165531, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Self
			-- Enslave Demon
			{spellID = 1098, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
			-- Mark of Doom [Prophecy of Fear]
			{spellID = 184073, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C.position.filger.target_bar)},

			-- Agony
			{spellID = 980, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Corruption
			{spellID = 146739, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Doom
			{spellID = 603, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Haunt
			{spellID = 48181, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immolate
			{spellID = 348, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seed of Corruption
			{spellID = 27243, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 30108, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
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
			Position = {unpack(C.position.filger.pve_cc)},

			-- Banish
			{spellID = 710, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Demonic Circle: Teleport
			{spellID = 48020, filter = "CD"},
			-- Devour Magic (Felhunter)
			{spellID = 19505, filter = "CD"},
			-- Felstorm
			{spellID = 89751, filter = "CD"},
			-- Grimoire of Service
			{spellID = 108501, filter = "CD"},
			-- Hand of Gul'dan
			{spellID = 105174, filter = "CD"},
			-- Howl of Terror
			{spellID = 5484, filter = "CD"},
			-- Mortal Coil
			{spellID = 6789, filter = "CD"},
			-- Sacrifice (Voidwalker)
			{spellID = 7812, filter = "CD"},
			-- Shadowfury
			{spellID = 30283, filter = "CD"},
			-- Soulburn
			{spellID = 74434, filter = "CD"},
			-- Spell Lock (Felhunter)
			{spellID = 19647, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
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
			Position = {unpack(C.position.filger.player_buff_icon)},

			-- Avatar
			{spellID = 107574, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodbath
			{spellID = 12292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enraged Regeneration
			{spellID = 55694, unitID = "player", caster = "player", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recklesness
			{spellID = 1719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Barrier
			{spellID = 112048, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Block
			{spellID = 2565, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Charge
			{spellID = 169667, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "player", caster = "player", filter = "BUFF"},
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
			Position = {unpack(C.position.filger.player_proc_icon)},

			-- Bloodsurge
			{spellID = 46916, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 12880, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meat Cleaver
			{spellID = 85739, unitID = "player", caster = "player", filter = "BUFF"},
			-- Raging Blow
			{spellID = 131116, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rude Interruption
			{spellID = 86663, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sudden Death
			{spellID = 52437, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sword and Board
			{spellID = 50227, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ultimatum
			{spellID = 122510, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unyielding Strikes
			{spellID = 169686, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- 1.0: Darkmoon Cards
			-- Melee DPS (Crit, Proc)
			{spellID = 162915, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking (Crit, Proc)
			{spellID = 162917, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.1: Alchemy Stones
			-- Strength
			{spellID = 60229, unitID = "player", caster = "player", filter = "BUFF"},
			-- 1.2: Hallow's End
			-- Brawler's Statue (Bonus Armor, Use)
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coren's Cold Chromium (Attack Power, Proc)
			{spellID = 127926, unitID = "player", caster = "player", filter = "BUFF"},
			-- 2.0: PvP Trinkets
			-- Battlemaster (Health, Use)
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Strength] (Versatility, Use)
			{spellID = 182073, unitID = "player", caster = "player", filter = "BUFF"},
			-- Melee DPS [Strength] (Versatility, Proc)
			{spellID = 182063, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Heirlooms
			-- Gronntooth War Horn (Strength, Proc)
			{spellID = 201405, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.0: Tanking
			-- Battering Talisman (Haste, Proc)
			{spellID = 177102, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blast Furnace Door (Mastery, Proc)
			{spellID = 177056, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evergaze Arcane Eidolon (Bonus Armor, Proc)
			{spellID = 177053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Relic of Blood (Haste, Proc)
			{spellID = 176937, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kyb's Foolish Perseverance (Health, Use)
			{spellID = 176460, unitID = "player", caster = "player", filter = "BUFF"},
			-- Petrified Flesh-Eating Spore (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pol's Blinded Eye (Mastery, Use)
			{spellID = 176876, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneheart Idol (Crit, Proc)
			{spellID = 176982, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tablet of Turnbuckle Teamwork (Bonus Armor, Use)
			{spellID = 176873, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Tanking
			-- Anzu's Cursed Plume (Mastery, Proc)
			{spellID = 183931, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enforcer's Stun Grenade (Versatility, Use)
			{spellID = 165534, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kyrak's Vileblood Serum (Mastery, Use)
			{spellID = 165535, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tyrant's Decree (Stamina, Proc)
			{spellID = 184770, unitID = "player", caster = "player", filter = "BUFF"},
			-- Xeri'tac's Unhatched Egg Sac (Mastery, Proc)
			{spellID = 165824, unitID = "player", caster = "player", filter = "BUFF"},
			-- 4.0: Melee DPS [Strength]
			-- Forgemaster's Insignia (Multistrike, Proc)
			{spellID = 177096, unitID = "player", caster = "player", filter = "BUFF"},
			-- Formidable Fang (Multistrike, Proc)
			{spellID = 176935, unitID = "player", caster = "player", filter = "BUFF"},
			-- Horn of the Screaming Spirits (Mastery, Proc)
			{spellID = 177042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mote of the Mountain (Versatility, Proc)
			{spellID = 176974, unitID = "player", caster = "player", filter = "BUFF"},
			-- Scabbard of Kyanos (Strength, Use)
			{spellID = 177189, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tectus' Beating Heart (Crit, Proc)
			{spellID = 177040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Convulsive Shadows (Multistrike, Use)
			{spellID = 176874, unitID = "player", caster = "player", filter = "BUFF"},
			-- 3.1: Melee DPS [Strength]
			-- Bonemaw's Big Toe (Crit, Use)
			{spellID = 165532, unitID = "player", caster = "player", filter = "BUFF"},
			-- Emberscale Talisman (Versatility, Use)
			{spellID = 165543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spores of Alacrity (Haste, Proc)
			{spellID = 165822, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unending Hunger (Strength, Proc)
			{spellID = 183941, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of Blackrock (Bonus Armor)
			{spellID = 159679, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Bleeding Hollow (Mastery)
			{spellID = 173322, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Frostwolf (Multistrike)
			{spellID = 159676, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Thunderlord (Crit)
			{spellID = 159234, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of Warsong (Haste)
			{spellID = 159675, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C.position.filger.target_debuff_icon)},

			-- Colossus Smash
			{spellID = 86346, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Demoralizing Shout
			{spellID = 1160, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rend
			{spellID = 772, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
			-- Fel Burn [Empty Drinking Horn]
			{spellID = 184256, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C.position.filger.cooldown)},

			-- Self
			-- Berserker Rage
			{spellID = 18499, filter = "CD"},
			-- Charge
			{spellID = 100, filter = "CD"},
			-- Colossus Smash
			{spellID = 86346, filter = "CD"},
			-- Demoralizing Shout
			{spellID = 1160, filter = "CD"},
			-- Enraged Regeneration
			{spellID = 55694, filter = "CD"},
			-- Heroic Leap
			{spellID = 6544, filter = "CD"},
			-- Intervene
			{spellID = 3411, filter = "CD"},
			-- Last Stand
			{spellID = 12975, filter = "CD"},
			-- Pummel
			{spellID = 6552, filter = "CD"},
			-- Rallying Cry
			{spellID = 97462, filter = "CD"},
			-- Shield Slam
			{spellID = 23922, filter = "CD"},
			-- Shield Wall
			{spellID = 871, filter = "CD"},
			-- Shockwave
			{spellID = 46968, filter = "CD"},
			-- Spell Reflection
			{spellID = 23920, filter = "CD"},
			-- Storm Bolt
			{spellID = 107570, filter = "CD"},
			-- Taunt
			{spellID = 355, filter = "CD"},
			-- Thunder Clap
			{spellID = 6343, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 69179, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD"},
			-- Blood Fury (Orc)
			{spellID = 20572, filter = "CD"},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Every Man for Himself (Human)
			{spellID = 59752, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},
			-- Rocket Jump (Goblin)
			{spellID = 69070, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
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
			Position = {unpack(C.position.filger.special_proc_icon)},

			-- Ashran
			-- Ancient Artifact
			{spellID = 168506, unitID = "player", caster = "all", filter = "BUFF"},
			-- Boulder Shield
			{spellID = 169373, unitID = "player", caster = "all", filter = "BUFF"},
			-- Scroll of Speed
			{spellID = 171250, unitID = "player", caster = "all", filter = "BUFF"},
			-- Scroll of Protection
			{spellID = 171249, unitID = "player", caster = "all", filter = "BUFF"},
			-- Star Root Tuber
			{spellID = 161495, unitID = "player", caster = "all", filter = "BUFF"},
			-- Wand of Lightning Shield
			{spellID = 171725, unitID = "player", caster = "all", filter = "BUFF"},

			-- Potions: Draenor
			-- Draenic Agility Potion
			{spellID = 156423, unitID = "player", caster = "player", filter = "BUFF"},
			-- Draenic Intellect Potion
			{spellID = 156426, unitID = "player", caster = "player", filter = "BUFF"},
			-- Draenic Strength Potion
			{spellID = 156428, unitID = "player", caster = "player", filter = "BUFF"},
			-- Draenic Armor Potion
			{spellID = 156430, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potions: Pandaria
			-- Virmen's Bite (Agility)
			{spellID = 105697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potion of Mogu Power (Strength)
			{spellID = 105706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potion of the Jade Serpent (Intellect)
			{spellID = 105702, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kafa Press (Haste)
			{spellID = 125282, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potions: Miscellaneous
			-- Invisibility Potion
			{spellID = 11392, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Darkwater Potion
			{spellID = 105707, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Draenic Invisibility Potion
			{spellID = 175833, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Draenic Swiftness Potion
			{spellID = 175790, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Potion of Luck
			{spellID = 135855, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Potion of Treasure Finding
			{spellID = 80263, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Swiftness Potion
			{spellID = 2379, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Potions: Brawler's Guild
			-- Brawler's Draenic Agility Potion
			{spellID = 176107, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Brawler's Draenic Intellect Potion
			{spellID = 176108, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Brawler's Draenic Strength Potion
			{spellID = 176109, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Raid Amplifiers: General
			-- Ancient Hysteria
			{spellID = 90355, unitID = "player", caster = "all", filter = "BUFF"},
			-- Netherwinds
			{spellID = 160452, unitID = "player", caster = "all", filter = "BUFF"},
			-- Drums of Fury
			{spellID = 178207, unitID = "player", caster = "all", filter = "BUFF"},
			-- Drums of Rage
			{spellID = 146555, unitID = "player", caster = "all", filter = "BUFF"},
			-- Bloodlust
			{spellID = 2825, unitID = "player", caster = "all", filter = "BUFF"},
			-- Heroism
			{spellID = 32182, unitID = "player", caster = "all", filter = "BUFF"},
			-- Time Warp
			{spellID = 80353, unitID = "player", caster = "all", filter = "BUFF"},
			-- Raid Amplifiers: Draenor
			-- Maalus, the Blood Drinker
			{spellID = 187806, unitID = "player", caster = "all", filter = "BUFF"},
			-- Nithramus, the All-Seer
			{spellID = 187616, unitID = "player", caster = "all", filter = "BUFF"},
			-- Sanctus, Sigil of the Unbroken
			{spellID = 187617, unitID = "player", caster = "all", filter = "BUFF"},
			-- Thorasus, the Stone Heart of Draenor
			{spellID = 187619, unitID = "player", caster = "all", filter = "BUFF"},

			-- Professions
			-- Goblin Glider [Goblin Glider Kit]
			{spellID = 126389, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Nitro Boosts
			{spellID = 54861, unitID = "player", caster = "player", filter = "BUFF"},
			-- Parachute
			{spellID = 55001, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shieldtronic Shield
			{spellID = 173260, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Stealth Field [Stealthman 54]
			{spellID = 156136, unitID = "player", caster = "all", filter = "BUFF", absID = true},

			-- Racial
			-- Berserking (Troll)
			{spellID = 26297, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blood Fury (Orc)
			{spellID = 20572, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkflight (Worgen)
			{spellID = 68992, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, unitID = "player", caster = "all", filter = "BUFF"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneform (Dwarf)
			{spellID = 65116, unitID = "player", caster = "player", filter = "BUFF"},

			-- Zone Buffs
			-- Speed (Battlegrounds)
			{spellID = 23451, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Fel Sludge (Tanaan Jungle)
			{spellID = 188520, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Strange Feeling (Brawler's Guild)
			{spellID = 134851, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Other
			-- Angelic Feather
			{spellID = 121557, unitID = "player", caster = "all", filter = "BUFF"},
			-- Body and Soul
			{spellID = 65081, unitID = "player", caster = "all", filter = "BUFF"},
			-- Devotion Aura
			{spellID = 31821, unitID = "player", caster = "all", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "player", caster = "all", filter = "BUFF"},
			-- Grounding Totem
			{spellID = 8178, unitID = "player", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Freedom
			{spellID = 1044, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Protection
			{spellID = 1022, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Purity
			{spellID = 114039, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Sacrifice
			{spellID = 6940, unitID = "player", caster = "all", filter = "BUFF"},
			-- Ice Ward
			{spellID = 111264, unitID = "player", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "player", caster = "all", filter = "BUFF"},
			-- Levitate
			{spellID = 1706, unitID = "player", caster = "all", filter = "BUFF"},
			-- Life Cocoon
			{spellID = 116849, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightwell Renew
			{spellID = 7001, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "player", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "player", caster = "all", filter = "BUFF"},
			-- Rallying Cry
			{spellID = 97463, unitID = "player", caster = "all", filter = "BUFF"},
			-- Slow Fall
			{spellID = 130, unitID = "player", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "player", caster = "all", filter = "BUFF"},
			-- Tiger's Lust
			{spellID = 116841, unitID = "player", caster = "all", filter = "BUFF"},
			-- Tricks of the Trade
			{spellID = 57933, unitID = "player", caster = "all", filter = "BUFF"},
			-- Vigilance
			{spellID = 114030, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "PVE/PVP_DEBUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 60,
			Position = {unpack(C.position.filger.pve_debuff)},

			-- Death Knight
			-- Asphyxiate
			{spellID = 108194, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chains of Ice
			{spellID = 45524, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chilblains
			{spellID = 50435, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dark Simulacrum
			{spellID = 77606, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gnaw (Ghoul)
			{spellID = 91800, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Monstrous Blow (Mutated Ghoul)
			{spellID = 91797, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Remorseless Winter
			{spellID = 115001, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shroud of Purgatory
			{spellID = 116888, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Strangulate
			{spellID = 47476, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Druid
			-- Cyclone
			{spellID = 33786, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fae Silence
			{spellID = 114238, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Immobilized
			{spellID = 45334, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Incapacitating Roar
			{spellID = 99, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Infected Wounds
			{spellID = 58180, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Rake
			{spellID = 163505, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Solar Beam
			{spellID = 78675, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Typhoon
			{spellID = 61391, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Hunter
			-- Ankle Crack (Crocolisk)
			{spellID = 50433, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Aspect of the Cheetah
			{spellID = 5118, unitID = "player", caster = "all", filter = "BUFF"},
			-- Aspect of the Pack
			{spellID = 13159, unitID = "player", caster = "all", filter = "BUFF"},
			-- Binding Shot
			{spellID = 117526, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussive Shot
			{spellID = 5116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 135373, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Freezing Trap
			{spellID = 3355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Freezing Trap (Glyph)
			{spellID = 61394, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Breath (Chimaera)
			{spellID = 54644, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ice Trap
			{spellID = 135299, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Narrow Escape
			{spellID = 136634, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Warp Time (Warp Stalker)
			{spellID = 35346, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Cauterize
			{spellID = 87023, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Chilled
			{spellID = 7321, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Deep Freeze
			{spellID = 44572, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Freeze (Pet)
			{spellID = 33395, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostbolt
			{spellID = 116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostfire Bolt
			{spellID = 44614, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostjaw
			{spellID = 102051, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ice Ward
			{spellID = 111340, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Monk
			-- Charging Ox Wave
			{spellID = 119392, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Disable
			{spellID = 116706, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Fists of Fury
			{spellID = 120086, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Leg Sweep
			{spellID = 119381, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Paralysis
			{spellID = 115078, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Avenger's Shield
			{spellID = 31935, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blinding Light
			{spellID = 105421, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dazing Shield (Glyph)
			{spellID = 63529, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Denounce
			{spellID = 2812, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fist of Justice
			{spellID = 105593, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Repentance
			{spellID = 20066, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seal of Justice
			{spellID = 20170, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Turn Evil
			{spellID = 10326, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Priest
			-- Dominate Mind
			{spellID = 605, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind Blast (Glyph)
			{spellID = 87194, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind Flay
			{spellID = 15407, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sin and Punishment
			{spellID = 87204, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Void Tendrils
			{spellID = 114404, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Blind
			{spellID = 2094, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Crippling Poison
			{spellID = 3409, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Deadly Throw
			{spellID = 26679, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Garrote
			{spellID = 1330, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Earthbind
			{spellID = 3600, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthgrab
			{spellID = 64695, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthquake
			{spellID = 77505, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hex
			{spellID = 51514, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Thunderstorm
			{spellID = 51490, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blood Horror
			{spellID = 137143, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Conflagrate
			{spellID = 17962, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cripple (Doomguard)
			{spellID = 170995, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Debilitate (Terrorguard)
			{spellID = 170996, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Meteor Strike (Abyssal)
			{spellID = 171156, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowflame
			{spellID = 47960, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Warrior
			-- Colossus Smash
			{spellID = 86346, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidating Shout
			{spellID = 5246, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Piercing Howl
			{spellID = 12323, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shockwave
			{spellID = 132168, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Staggering Shout
			{spellID = 107566, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Storm Bolt
			{spellID = 132169, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Warbringer
			{spellID = 7922, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Racial
			-- Arcane Torrent
			{spellID = 28730, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Quaking Palm
			{spellID = 107079, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- War Stomp
			{spellID = 20549, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Raids: Pandaria
			-- Heart of Fear
			-- Corrosive Resin (Wind Lord Mel'jarak)
			{spellID = 122064, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Kor'thik Strike (Wind Lord Mel'jarak)
			{spellID = 123963, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Unseen Strike (Blade Lord Ta'yak)
			{spellID = 123017, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mogu'shan Vaults
			-- Arcane Resonance (Feng the Accursed)
			{spellID = 116417, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Voodoo Doll (Gara'jal the Spiritbinder)
			{spellID = 122151, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wildfire Spark (Feng the Accursed)
			{spellID = 116784, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Throne of Thunder
			-- Biting Cold (Council of Elders)
			{spellID = 136992, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cinder (Megaera)
			{spellID = 134391, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Focused Lightning (Jin'rokh the Breaker)
			{spellID = 137422, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostbite (Council of Elders)
			{spellID = 136922, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Marked Soul (Council of Elders)
			{spellID = 137359, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Static Shock (Lei Shen)
			{spellID = 135695, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Torrent of Ice (Megaera)
			{spellID = 139857, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Other
			-- Rocket Fuel Leak
			{spellID = 94794, unitID = "player", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "T_BUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 60,
			Position = {unpack(C.position.filger.target_buff_icon)},

			-- Death Knight
			-- Anti-Magic Shell
			{spellID = 48707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Death's Advance
			{spellID = 96268, unitID = "target", caster = "all", filter = "BUFF"},
			-- Desecrated Ground
			{spellID = 115018, unitID = "target", caster = "all", filter = "BUFF"},
			-- Lichborne
			{spellID = 49039, unitID = "target", caster = "all", filter = "BUFF"},
			-- Icebound Fortitude
			{spellID = 48792, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pillar of Frost
			{spellID = 51271, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Asphyxiate
			{spellID = 108194, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Gnaw (Ghoul)
			{spellID = 91800, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Monstrous Blow (Mutated Ghoul)
			{spellID = 91797, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Remorseless Winter
			{spellID = 115001, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Strangulate
			{spellID = 47476, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Druid
			-- Barkskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserk
			{spellID = 50334, unitID = "target", caster = "all", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 170856, unitID = "target", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "target", caster = "all", filter = "BUFF"},
			-- Survival Instincts
			{spellID = 61336, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cyclone
			{spellID = 33786, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fae Silence
			{spellID = 114238, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Incapacitating Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rake
			{spellID = 163505, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Solar Beam
			{spellID = 78675, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Hunter
			-- Aspect of the Cheetah
			{spellID = 5118, unitID = "target", caster = "all", filter = "BUFF"},
			-- Aspect of the Pack
			{spellID = 13159, unitID = "target", caster = "all", filter = "BUFF"},
			-- Deterrence
			{spellID = 19263, unitID = "target", caster = "all", filter = "BUFF"},
			-- Feign Death
			{spellID = 5384, unitID = "target", caster = "all", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Binding Shot
			{spellID = 117526, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Freezing Trap
			{spellID = 3355, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Alter Time
			{spellID = 110909, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evanesce
			{spellID = 157913, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ice Block
			{spellID = 45438, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ice Ward
			{spellID = 111264, unitID = "target", caster = "all", filter = "BUFF"},
			-- Invisibility
			{spellID = 66, unitID = "target", caster = "all", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 115610, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cauterize
			{spellID = 87023, unitID = "target", caster = "target", filter = "DEBUFF"},
			-- Deep Freeze
			{spellID = 44572, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frostjaw
			{spellID = 102051, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Monk
			-- Dampen Harm
			{spellID = 122278, unitID = "player", caster = "target", filter = "BUFF"},
			-- Diffuse Magic
			{spellID = 122783, unitID = "target", caster = "target", filter = "BUFF"},
			-- Ring of Peace
			{spellID = 116844, unitID = "target", caster = "target", filter = "BUFF"},
			-- Touch of Karma
			{spellID = 125174, unitID = "target", caster = "target", filter = "BUFF"},
			-- Debuffs
			-- Charging Ox Wave
			{spellID = 119392, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fists of Fury
			{spellID = 120086, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Leg Sweep
			{spellID = 119381, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Paralysis
			{spellID = 115078, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Ardent Defender
			{spellID = 31850, unitID = "target", caster = "all", filter = "BUFF"},
			-- Devotion Aura
			{spellID = 31821, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Shield
			{spellID = 642, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86659, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Freedom
			{spellID = 1044, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Protection
			{spellID = 1022, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Purity
			{spellID = 114039, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Sacrifice
			{spellID = 6940, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Avenger's Shield
			{spellID = 31935, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blinding Light
			{spellID = 105421, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fist of Justice
			{spellID = 105593, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Turn Evil
			{spellID = 10326, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Priest
			-- Dispersion
			{spellID = 47585, unitID = "target", caster = "all", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Phantasm
			{spellID = 114239, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Dominate Mind
			{spellID = 605, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Cheating Death
			{spellID = 45182, unitID = "target", caster = "all", filter = "BUFF"},
			-- Cloak of Shadows
			{spellID = 31224, unitID = "target", caster = "all", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 51713, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Blind
			{spellID = 2094, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote
			{spellID = 1330, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Grounding Totem
			{spellID = 8178, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shamanistic Rage
			{spellID = 30823, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Hex
			{spellID = 51514, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Blood Horror
			{spellID = 111397, unitID = "target", caster = "all", filter = "BUFF"},
			-- Dark Bargain
			{spellID = 110913, unitID = "target", caster = "all", filter = "BUFF"},
			-- Soulstone
			{spellID = 20707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Banish
			{spellID = 710, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blood Horror
			{spellID = 137143, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Debilitate (Terrorguard)
			{spellID = 170996, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Meteor Strike (Abyssal)
			{spellID = 171156, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

			-- Warrior
			-- Berserker Rage
			{spellID = 18499, unitID = "target", caster = "all", filter = "BUFF"},
			-- Bladestorm
			{spellID = 46924, unitID = "target", caster = "all", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "target", caster = "all", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Gag Order
			{spellID = 18498, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Intimidating Shout
			{spellID = 5246, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shockwave
			{spellID = 132168, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Storm Bolt
			{spellID = 132169, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

			-- Racial
			-- Arcane Torrent
			{spellID = 28730, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Quaking Palm
			{spellID = 107079, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- War Stomp
			{spellID = 20549, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Professions
			-- Shieldtronic Shield
			{spellID = 173260, unitID = "target", caster = "all", filter = "BUFF"},

			-- Player vs. Player
			-- Ashran
			-- Ancient Artifact
			{spellID = 168506, unitID = "target", caster = "all", filter = "BUFF"},
			-- Boulder Shield
			{spellID = 169373, unitID = "target", caster = "all", filter = "BUFF"},
			-- Scroll of Protection
			{spellID = 171249, unitID = "target", caster = "all", filter = "BUFF"},
			-- Star Root Tuber
			{spellID = 161495, unitID = "target", caster = "all", filter = "BUFF"},
			-- Battlegrounds
			-- Netherstorm Flag
			{spellID = 34976, unitID = "target", caster = "all", filter = "BUFF"},
			-- Orb of Power
			{spellID = 121175, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Warsong Flag
			{spellID = 23333, unitID = "target", caster = "all", filter = "BUFF"},
			{spellID = 23335, unitID = "target", caster = "all", filter = "BUFF"},
			-- Seaforium Bombs
			{spellID = 66271, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Drinking in Arena
			-- Ba'ruun's Bountiful Bloom
			{spellID = 167268, unitID = "target", caster = "all", filter = "BUFF"},
			-- Drinking
			{spellID = 80167, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mage Food
			{spellID = 167152, unitID = "target", caster = "all", filter = "BUFF"},
		},
	},
}