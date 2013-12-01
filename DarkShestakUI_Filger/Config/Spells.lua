local T, C, L, _ = unpack(ShestakUI)
if C.unitframe.enable ~= true then return end

C["filger_spells"] = {
	["DEATHKNIGHT"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Bone Shield
			{spellID = 49222, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bone Wall (T16)
			{spellID = 144948, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Blood
			{spellID = 55233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Icebound Fortitude
			{spellID = 48792, unitID = "player", caster = "player", filter = "BUFF"},
			-- Anti-Magic Shell
			{spellID = 48707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dancing Rune Weapon
			{spellID = 81256, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lichborne
			{spellID = 49039, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pillar of Frost
			{spellID = 51271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Death's Advance
			{spellID = 96268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unholy Blight
			{spellID = 115989, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Scent of Blood
			{spellID = 50421, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crimson Scourge
			{spellID = 81141, unitID = "player", caster = "player", filter = "BUFF"},
			-- Freezing Fog
			{spellID = 59052, unitID = "player", caster = "player", filter = "BUFF"},
			-- Killing Machine
			{spellID = 51124, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sudden Doom
			{spellID = 81340, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unholy Strength
			{spellID = 53365, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Transformation
			{spellID = 63560, unitID = "pet", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Strength DPS
			-- Evil Eye of Galakras (Strength, Proc)
			{spellID = 146245, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Tail Tip (Strength, Proc)
			{spellID = 146250, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Skeer's Bloodsoaked Talisman (Strength, Proc)
			{spellID = 146285, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fusion-Fire Core (Strength, Proc)
			{spellID = 148899, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Alacrity of Xuen (Haste, Proc)
			{spellID = 146296, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brutal Talisman of the Shado-Pan Assault (Strength, Proc)
			{spellID = 138702, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fabled Feather of Ji-Kun (Strength, Proc)
			{spellID = 138759, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spark of Zandalar (Strength, Proc)
			{spellID = 138958, unitID = "player", caster = "player", filter = "BUFF"},
			-- Primordius' Talisman of Rage (Strength, Proc)
			{spellID = 138870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gaze of the Twins (Crit, Proc)
			{spellID = 139170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Helmbreaker Medallion (Crit, Use)
			{spellID = 136084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmist Vortex (Haste, Proc)
			{spellID = 126657, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lei Shin's Final Orders (Strength, Proc)
			{spellID = 126582, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Charioteer Figurine (Strength, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Iron Belly Wok (Haste, Use)
			{spellID = 129812, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Use)
			{spellID = 126679, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Proc)
			{spellID = 126700, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (Attack Power)
			{spellID = 125489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Dancing Steel (Strength)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},

			-- Legendary Meta Gems
			-- Indomitable Primal Diamond (Tank)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
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
			Position = {unpack(C["filger_position"].target_bar)},

			-- Blood Plague
			{spellID = 59879, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Fever
			{spellID = 59921, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Mind Freeze
			{spellID = 47528, filter = "CD"},
			-- Strangulate
			{spellID = 47476, filter = "CD"},
			-- Gnaw (Ghoul)
			{spellID = 47481, filter = "CD"},
			-- Remorseless Winter
			{spellID = 108200, filter = "CD"},
			-- Soul Reaper
			{spellID = 130736, filter = "CD"},
			-- Death Grip
			{spellID = 49576, filter = "CD"},
			-- Plague Leech
			{spellID = 123693, filter = "CD"},
			-- Rune Tap
			{spellID = 48982, filter = "CD"},
			-- Death and Decay
			{spellID = 43265, filter = "CD"},
			-- Death's Advance
			{spellID = 96268, filter = "CD"},
			-- Anti-Magic Shell
			{spellID = 48707, filter = "CD"},
			-- Vampiric Blood
			{spellID = 55233, filter = "CD"},
			-- Outbreak
			{spellID = 77575, filter = "CD"},
			-- Pillar of Frost
			{spellID = 51271, filter = "CD"},
			-- Gorefiend's Grasp
			{spellID = 108199, filter = "CD"},
			-- Dancing Rune Weapon
			{spellID = 49028, filter = "CD"},
			-- Unholy Blight
			{spellID = 115989, filter = "CD"},
			-- Lichborne
			{spellID = 49039, filter = "CD"},
			-- Desecrated Ground
			{spellID = 108201, filter = "CD"},
			-- Death Pact
			{spellID = 48743, filter = "CD"},
			-- Raise Dead
			{spellID = 46584, filter = "CD"},
			-- Anti-Magic Zone
			{spellID = 51052, filter = "CD"},
			-- Icebound Fortitude
			{spellID = 48792, filter = "CD"},
			-- Unholy Frenzy
			{spellID = 49016, filter = "CD"},
			-- Summon Gargoyle
			{spellID = 49206, filter = "CD"},

			-- Racial
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

			-- Items
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
			-- Shroud of Purgatory
			{spellID = 116888, filter = "ICD", trigger = "BUFF", duration = 180},
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Chosen of Elunee
			{spellID = 102560, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: King of the Jungle
			{spellID = 102543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Son of Ursoc
			{spellID = 102558, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Vigil
			{spellID = 124974, unitID = "player", caster = "player", filter = "BUFF"},
			-- Survival Instincts
			{spellID = 61336, unitID = "player", caster = "player", filter = "BUFF"},
			-- Might of Ursoc
			{spellID = 106922, unitID = "player", caster = "player", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Defense
			{spellID = 132402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Glyph of Frenzied Regeneration
			{spellID = 124769, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Roar
			{spellID = 52610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserk
			{spellID = 50334, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger's Fury
			{spellID = 5217, unitID = "player", caster = "player", filter = "BUFF"},
			-- Celestial Alignment
			{spellID = 112071, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Wild
			{spellID = 108294, unitID = "player", caster = "player", filter = "BUFF"},
			-- Starfall
			{spellID = 48505, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 16689, unitID = "player", caster = "player", filter = "BUFF"},
			-- Owlkin Frenzy
			{spellID = 48391, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dash
			{spellID = 1850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 5229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cenarion Ward
			{spellID = 102351, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Shooting Stars
			{spellID = 93400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lunar Shower
			{spellID = 81192, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grace
			{spellID = 16886, unitID = "player", caster = "player", filter = "BUFF"},
			-- Glyph of Rejuvenation
			{spellID = 96206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Clearcasting
			{spellID = 16870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul of the Forest
			{spellID = 114108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tooth and Claw
			{spellID = 135286, unitID = "player", caster = "player", filter = "BUFF"},
			-- Predatory Swiftness
			{spellID = 69369, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item sets
			-- Sage Mender (T16)
			{spellID = 144871, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unerring Vision of Lei-Shen (Crit, Proc)
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (Attack Power)
			{spellID = 125489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Dancing Steel (Agility)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- Legendary Meta Gems
			-- Indomitable Primal Diamond (Tank)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Sinister Primal Diamond (Caster DPS)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
			-- Courageous Primal Diamond (Caster Heal)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- Legendary Cloak
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Moonfire
			{spellID = 8921, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sunfire
			{spellID = 93402, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rake
			{spellID = 1822, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rip
			{spellID = 1079, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pounce Bleed
			{spellID = 9007, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Lacerate
			{spellID = 33745, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Thrash
			{spellID = 77758, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Skull Bash
			{spellID = 82365, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immobilized
			{spellID = 45334, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].target_bar)},

			-- Lifebloom
			{spellID = 33763, unitID = "target", caster = "player", filter = "BUFF"},
			-- Rejuvenation
			{spellID = 774, unitID = "target", caster = "player", filter = "BUFF"},
			-- Regrowth
			{spellID = 8936, unitID = "target", caster = "player", filter = "BUFF"},
			-- Wild Growth
			{spellID = 48438, unitID = "target", caster = "player", filter = "BUFF"},
			-- Cenarion Ward
			{spellID = 102351, unitID = "target", caster = "player", filter = "BUFF"},
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
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Cyclone
			{spellID = 33786, unitID = "focus", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "focus", caster = "all", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Nature's Cure
			{spellID = 88423, filter = "CD"},
			-- Remove Corruption
			{spellID = 2782, filter = "CD"},
			-- Skull Bash
			{spellID = 106839, filter = "CD"},
			-- Mangle
			{spellID = 33878, filter = "CD"},
			-- Wild Growth
			{spellID = 48438, filter = "CD"},
			-- Swiftmend
			{spellID = 18562, filter = "CD"},
			-- Growl
			{spellID = 6795, filter = "CD"},
			-- Maim
			{spellID = 22570, filter = "CD"},
			-- Starsurge
			{spellID = 78674, filter = "CD"},
			-- Wild Charge
			{spellID = 102401, filter = "CD"},
			-- Faerie Fire
			{spellID = 770, filter = "CD"},
			-- Tiger's Fury
			{spellID = 5217, filter = "CD"},
			-- Disorienting Roar
			{spellID = 99, filter = "CD"},
			-- Mass Entanglement
			{spellID = 102359, filter = "CD"},
			-- Typhoon
			{spellID = 132469, filter = "CD"},
			-- Mighty Bash
			{spellID = 5211, filter = "CD"},
			-- Bear Hug
			{spellID = 102795, filter = "CD"},
			-- Solar Beam
			{spellID = 78675, filter = "CD"},
			-- Barkskin
			{spellID = 22812, filter = "CD"},
			-- Ironbark
			{spellID = 102342, filter = "CD"},
			-- Nature's Swiftness
			{spellID = 132158, filter = "CD"},
			-- Ursol's Vortex
			{spellID = 102793, filter = "CD"},
			-- Enrage
			{spellID = 5229, filter = "CD"},
			-- Force of Nature
			{spellID = 106737, filter = "CD"},
			-- Nature's Vigil
			{spellID = 124974, filter = "CD"},
			-- Might of Ursoc
			{spellID = 106922, filter = "CD"},
			-- Nature's Grasp
			{spellID = 16689, filter = "CD"},
			-- Incarnation
			{spellID = 106731, filter = "CD"},
			-- Berserk
			{spellID = 106952, filter = "CD"},

			-- Racial
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},
			-- Darkflight (Worgen)
			{spellID = 68992, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD"},
			-- Berserking (Troll)
			{spellID = 26297, filter = "CD", absID = true},

			-- Items
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
			{spellID = 125487, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, filter = "ICD", trigger = "BUFF", duration = 115},
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Deterrence
			{spellID = 19263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Fire
			{spellID = 3045, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Beast Within
			{spellID = 34471, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focus Fire
			{spellID = 82692, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Mend
			{spellID = 90361, unitID = "player", caster = "player", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Ready, Set, Aim...
			{spellID = 82925, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire!
			{spellID = 82926, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steady Focus
			{spellID = 53220, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lock and Load
			{spellID = 56453, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thrill of the Hunt
			{spellID = 34720, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzy
			{spellID = 19615, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mend Pet
			{spellID = 136, unitID = "pet", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Physical General
			-- Swordguard Embroidery (Attack Power)
			{spellID = 125489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Ranged
			-- Mirror Scope (Crit)
			{spellID = 109092, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lord Blastington's Scope of Doom (Agility)
			{spellID = 109085, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Serpent Sting
			{spellID = 1978, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Black Arrow
			{spellID = 3674, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Explosive Shot
			{spellID = 53301, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Narrow Escape
			{spellID = 136634, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Web (Spider)
			{spellID = 4167, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Venom Web Spray (Silithid)
			{spellID = 54706, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pin (Crab)
			{spellID = 50245, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].pve_cc)},

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
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Concussive Shot
			{spellID = 5116, filter = "CD"},
			-- Counter Shot
			{spellID = 147362, filter = "CD"},
			-- Scatter Shot
			{spellID = 19503, filter = "CD"},
			-- Binding Shot
			{spellID = 117526, filter = "CD"},
			-- Kill Command
			{spellID = 34026, filter = "CD"},
			-- Explosive Shot
			{spellID = 53301, filter = "CD"},
			-- Chimera Shot
			{spellID = 53209, filter = "CD"},
			-- Kill Shot
			{spellID = 53351, filter = "CD"},
			-- Glaive Toss
			{spellID = 117050, filter = "CD"},
			-- Disengage
			{spellID = 781, filter = "CD"},
			-- Dire Beast
			{spellID = 120679, filter = "CD"},
			-- Fervor
			{spellID = 82726, filter = "CD"},
			-- Barrage
			{spellID = 120360, filter = "CD"},
			-- Misdirection
			{spellID = 34477, filter = "CD"},
			-- Feign Death
			{spellID = 5384, filter = "CD"},
			-- Snake Trap
			{spellID = 34600, filter = "CD"},
			-- Explosive Trap
			{spellID = 13813, filter = "CD"},
			-- Ice Trap
			{spellID = 13809, filter = "CD"},
			-- Master's Call
			{spellID = 53271, filter = "CD"},
			-- Powershot
			{spellID = 109259, filter = "CD"},
			-- Wyvern Sting
			{spellID = 19386, filter = "CD"},
			-- Intimidation
			{spellID = 19577, filter = "CD"},
			-- Bestial Wrath
			{spellID = 19574, filter = "CD"},
			-- Lynx Rush
			{spellID = 120697, filter = "CD"},
			-- A Murder of Crows
			{spellID = 131894, filter = "CD"},
			-- Exhilaration
			{spellID = 109304, filter = "CD"},
			-- Rapid Fire
			{spellID = 3045, filter = "CD"},
			-- Deterrence
			{spellID = 19263, filter = "CD"},
			-- Spirit Mend (Pet)
			{spellID = 90361, filter = "CD"},
			-- Web (Pet)
			{spellID = 4167, filter = "CD"},
			-- Venom Web Spray (Pet)
			{spellID = 54706, filter = "CD"},
			-- Web Wrap (Pet)
			{spellID = 96201, filter = "CD"},
			-- Bad Manner (Pet)
			{spellID = 90337, filter = "CD"},
			-- Lullaby (Pet)
			{spellID = 126246, filter = "CD"},

			-- Racial
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
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},

			-- Items
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Ice Block
			{spellID = 45438, unitID = "player", caster = "player", filter = "BUFF"},
			-- Invisibility
			{spellID = 32612, unitID = "player", caster = "player", filter = "BUFF"},
			-- Greater Invisibility
			{spellID = 110960, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Invoker's Energy
			{spellID = 116257, unitID = "player", caster = "player", filter = "BUFF"},
			-- Icy Veins
			{spellID = 12472, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Power
			{spellID = 12042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incanter's Absorption
			{spellID = 116267, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Barrier
			{spellID = 11426, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Ward
			{spellID = 111264, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heating Up
			{spellID = 48107, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Floes
			{spellID = 108839, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incanter's Ward
			{spellID = 1463, unitID = "player", caster = "player", filter = "BUFF"},
			-- Alter Time
			{spellID = 110909, unitID = "player", caster = "player", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 115610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Power
			{spellID = 116014, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Fingers of Frost
			{spellID = 44544, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brain Freeze
			{spellID = 57761, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Missiles!
			{spellID = 79683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pyroblast!
			{spellID = 48108, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unerring Vision of Lei-Shen (Crit, Proc)
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},

			-- Legendary Meta Gems
			-- Sinister Primal Diamond (Caster DPS)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Arcane Charge
			{spellID = 36032, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Ignite
			{spellID = 12654, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Living Bomb
			{spellID = 44457, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Nether Tempest
			{spellID = 114923, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Bomb
			{spellID = 112948, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroblast
			{spellID = 11366, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Combustion
			{spellID = 83853, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freeze (Pet)
			{spellID = 33395, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ice Ward
			{spellID = 111340, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].pve_cc)},

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
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Remove Curse
			{spellID = 475, filter = "CD"},
			-- Frostjaw
			{spellID = 102051, filter = "CD"},
			-- Counterspell
			{spellID = 2139, filter = "CD"},
			-- Blink
			{spellID = 1953, filter = "CD"},
			-- Blazing Speed
			{spellID = 108843, filter = "CD"},
			-- Dragon's Breath
			{spellID = 31661, filter = "CD"},
			-- Deep Freeze
			{spellID = 44572, filter = "CD"},
			-- Frost Nova
			{spellID = 122, filter = "CD"},
			-- Ice Ward
			{spellID = 111264, filter = "CD"},
			-- Ring of Frost
			{spellID = 113724, filter = "CD"},
			-- Ice Barrier
			{spellID = 11426, filter = "CD"},
			-- Temporal Shield
			{spellID = 115610, filter = "CD"},
			-- Incanter's Ward
			{spellID = 1463, filter = "CD"},
			-- Fire Blast
			{spellID = 2136, filter = "CD"},
			-- Frost Bomb
			{spellID = 112948, filter = "CD"},
			-- Flamestrike
			{spellID = 2120, filter = "CD"},
			-- Cone of Cold
			{spellID = 120, filter = "CD"},
			-- Freeze (Pet)
			{spellID = 33395, filter = "CD"},
			-- Ice Floes
			{spellID = 108839, filter = "CD"},
			-- Combustion
			{spellID = 11129, filter = "CD"},
			-- Frozen Orb
			{spellID = 84714, filter = "CD"},
			-- Arcane Power
			{spellID = 12042, filter = "CD"},
			-- Presence of Mind
			{spellID = 12043, filter = "CD"},
			-- Evocation
			{spellID = 12051, filter = "CD"},
			-- Icy Veins
			{spellID = 12472, filter = "CD"},
			-- Cold Snap
			{spellID = 11958, filter = "CD"},
			-- Mirror Image
			{spellID = 55342, filter = "CD"},
			-- Alter Time
			{spellID = 108978, filter = "CD"},
			-- Ice Block
			{spellID = 45438, filter = "CD"},
			-- Invisibility
			{spellID = 66, filter = "CD"},

			-- Racial
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
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},

			-- Items
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
			{spellID = 125487, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, filter = "ICD", trigger = "BUFF", duration = 115},
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Guard
			{spellID = 115295, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fortifying Brew
			{spellID = 120954, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elusive Brew
			{spellID = 115308, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tigereye Brew
			{spellID = 116740, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Touch of Karma
			{spellID = 125174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avert Harm
			{spellID = 115213, unitID = "player", caster = "player", filter = "BUFF"},
			-- Diffuse Magic
			{spellID = 122783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Energizing Brew
			{spellID = 115288, unitID = "player", caster = "player", filter = "BUFF"},
			-- Momentum
			{spellID = 119085, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Tiger Power
			{spellID = 125359, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combo Breaker: Blackout Kick
			{spellID = 116768, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combo Breaker: Tiger Palm
			{spellID = 118864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Guard
			{spellID = 118636, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shuffle
			{spellID = 115307, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vital Mists
			{spellID = 118674, unitID = "player", caster = "player", filter = "BUFF"},
			-- Serpent's Zeal
			{spellID = 127722, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (Attack Power)
			{spellID = 125489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Dancing Steel (Agility)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- Legendary Meta Gems
			-- Indomitable Primal Diamond (Tank)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Courageous Primal Diamond (Caster Heal)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- Legendary Cloak
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Heavy Stagger
			{spellID = 124273, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Dizzying Haze
			{spellID = 116330, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Breath of Fire
			{spellID = 123725, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Detox
			{spellID = 115450, filter = "CD"},
			-- Spear Hand Strike
			{spellID = 116705, filter = "CD"},
			-- Paralysis
			{spellID = 115078, filter = "CD"},
			-- Expel Harm
			{spellID = 115072, filter = "CD"},
			-- Rising Sun Kick
			{spellID = 107428, filter = "CD"},
			-- Provoke
			{spellID = 115546, filter = "CD"},
			-- Zen Sphere
			{spellID = 124081, filter = "CD"},
			-- Chi Wave
			{spellID = 115098, filter = "CD"},
			-- Fists of Fury
			{spellID = 113656, filter = "CD"},
			-- Chi Burst
			{spellID = 123986, filter = "CD"},
			-- Guard
			{spellID = 115295, filter = "CD"},
			-- Charging Ox Wave
			{spellID = 119392, filter = "CD"},
			-- Clash
			{spellID = 122057, filter = "CD"},
			-- Ring of Peace
			{spellID = 116844, filter = "CD"},
			-- Dampen Harm
			{spellID = 122278, filter = "CD"},
			-- Flying Serpent Kick
			{spellID = 101545, filter = "CD"},
			-- Energizing Brew
			{spellID = 115288, filter = "CD"},
			-- Touch of Karma
			{spellID = 122470, filter = "CD"},
			-- Touch of Death
			{spellID = 115080, filter = "CD"},
			-- Nimble Brew
			{spellID = 137562, filter = "CD"},
			-- Life Cocoon
			{spellID = 116849, filter = "CD"},
			-- Invoke Xuen, the White Tiger
			{spellID = 123904, filter = "CD"},

			-- Racial
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
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},

			-- Items
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Divine Shield
			{spellID = 642, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inquisition
			{spellID = 84963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86698, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Avenger
			{spellID = 105809, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avenging Wrath
			{spellID = 31884, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Favor
			{spellID = 31842, unitID = "player", caster = "player", filter = "BUFF"},
			-- Argent Defender
			{spellID = 31850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Plea
			{spellID = 54428, unitID = "player", caster = "player", filter = "BUFF"},
			-- Speed of Light
			{spellID = 85499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Eternal Flame
			{spellID = 114163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sacred Shield
			{spellID = 20925, unitID = "player", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Infusion of Light
			{spellID = 54149, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ancient Power
			{spellID = 86700, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bastion of Glory
			{spellID = 114637, unitID = "player", caster = "player", filter = "BUFF"},
			-- Selfless Healer
			{spellID = 114250, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Purpose
			{spellID = 90174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grand Crusader
			{spellID = 85416, unitID = "player", caster = "player", filter = "BUFF"},
			-- Daybreak
			{spellID = 88819, unitID = "player", caster = "player", filter = "BUFF"},
			-- Long Arm of the Law
			{spellID = 87173, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item sets
			-- Divine Crusader (T16)
			{spellID = 144595, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Strength DPS
			-- Evil Eye of Galakras (Strength, Proc)
			{spellID = 146245, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Tail Tip (Strength, Proc)
			{spellID = 146250, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Skeer's Bloodsoaked Talisman (Strength, Proc)
			{spellID = 146285, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fusion-Fire Core (Strength, Proc)
			{spellID = 148899, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Alacrity of Xuen (Haste, Proc)
			{spellID = 146296, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brutal Talisman of the Shado-Pan Assault (Strength, Proc)
			{spellID = 138702, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fabled Feather of Ji-Kun (Strength, Proc)
			{spellID = 138759, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spark of Zandalar (Strength, Proc)
			{spellID = 138958, unitID = "player", caster = "player", filter = "BUFF"},
			-- Primordius' Talisman of Rage (Strength, Proc)
			{spellID = 138870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gaze of the Twins (Crit, Proc)
			{spellID = 139170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Helmbreaker Medallion (Crit, Use)
			{spellID = 136084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmist Vortex (Haste, Proc)
			{spellID = 126657, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lei Shin's Final Orders (Strength, Proc)
			{spellID = 126582, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Charioteer Figurine (Strength, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Iron Belly Wok (Haste, Use)
			{spellID = 129812, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Use)
			{spellID = 126679, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Proc)
			{spellID = 126700, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (Attack Power)
			{spellID = 125489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Dancing Steel (Strength)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- Legendary Meta Gems
			-- Indomitable Primal Diamond (Tank)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Courageous Primal Diamond (Caster Heal)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- Legendary Cloak
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Forbearance
			{spellID = 25771, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Censure
			{spellID = 31803, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Glyph of Dazing Shield
			{spellID = 63529, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seal of Justice
			{spellID = 20170, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Denounce
			{spellID = 2812, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Cleanse
			{spellID = 4987, filter = "CD"},
			-- Rebuke
			{spellID = 96231, filter = "CD"},
			-- Repentance
			{spellID = 20066, filter = "CD"},
			-- Turn Evil
			{spellID = 10326, filter = "CD"},
			-- Hammer of Justice
			{spellID = 853, filter = "CD"},
			-- Judgment
			{spellID = 20271, filter = "CD"},
			-- Consecration
			{spellID = 26573, filter = "CD"},
			-- Holy Wrath
			{spellID = 119072, filter = "CD"},
			-- Avenger's Shield
			{spellID = 31935, filter = "CD"},
			-- Exorcism
			{spellID = 879, filter = "CD"},
			-- Holy Prism
			{spellID = 114165, filter = "CD"},
			-- Hand of Freedom
			{spellID = 1044, filter = "CD"},
			-- Hand of Purity
			{spellID = 114039, filter = "CD"},
			-- Speed of Light
			{spellID = 85499, filter = "CD"},
			-- Divine Protection
			{spellID = 498, filter = "CD"},
			-- Execution Sentence
			{spellID = 114157, filter = "CD"},
			-- Light's Hammer
			{spellID = 114158, filter = "CD"},
			-- Blinding Light
			{spellID = 115750, filter = "CD"},
			-- Holy Avenger
			{spellID = 105809, filter = "CD"},
			-- Devotion Aura
			{spellID = 31821, filter = "CD"},
			-- Hand of Sacrifice
			{spellID = 6940, filter = "CD"},
			-- Divine Plea
			{spellID = 54428, filter = "CD"},
			-- Avenging Wrath
			{spellID = 31884, filter = "CD"},
			-- Ardent Defender
			{spellID = 31850, filter = "CD"},
			-- Hand of Protection
			{spellID = 1022, filter = "CD"},

			-- Racial
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

			-- Items
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Dispersion
			{spellID = 47585, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Infusion
			{spellID = 10060, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Shell
			{spellID = 109964, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Archangel
			{spellID = 81700, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Embrace
			{spellID = 15286, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inner Focus
			{spellID = 96267, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Word: Shield
			{spellID = 17, unitID = "player", caster = "all", filter = "BUFF"},
			-- Renew
			{spellID = 139, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fade
			{spellID = 586, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Will
			{spellID = 45242, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Divine Insight
			{spellID = 124430, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Light
			{spellID = 114255, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Darkness
			{spellID = 87160, unitID = "player", caster = "player", filter = "BUFF"},
			-- Serendipity
			{spellID = 63735, unitID = "player", caster = "player", filter = "BUFF"},
			-- Glyph of Mind Spike
			{spellID = 81292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Borrowed Time
			{spellID = 59889, unitID = "player", caster = "player", filter = "BUFF"},
			-- Twist of Fate
			{spellID = 123254, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evangelism
			{spellID = 81661, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unerring Vision of Lei-Shen (Crit, Proc)
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- Legendary Meta Gems
			-- Sinister Primal Diamond (Caster DPS)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
			-- Courageous Primal Diamond (Caster Heal)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- Legendary Cloak
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Void Tendril's Grasp
			{spellID = 114404, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Glyph of Mind Blast
			{spellID = 87194, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].target_bar)},

			-- Renew
			{spellID = 139, unitID = "target", caster = "player", filter = "BUFF"},
			-- Prayer of Mending
			{spellID = 41635, unitID = "target", caster = "player", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "player", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "player", filter = "BUFF"},
			-- Grace
			{spellID = 77613, unitID = "target", caster = "player", filter = "BUFF"},
			-- Shadow Word: Pain
			{spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vampiric Touch
			{spellID = 34914, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Devouring Plague
			{spellID = 2944, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].pve_cc)},

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
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Purify
			{spellID = 527, filter = "CD"},
			-- Mass Dispel
			{spellID = 32375, filter = "CD"},
			-- Penance
			{spellID = 47540, filter = "CD"},
			-- Mind Blast
			{spellID = 8092, filter = "CD"},
			-- Holy Fire
			{spellID = 14914, filter = "CD"},
			-- Circle of Healing
			{spellID = 34861, filter = "CD"},
			-- Prayer of Mending
			{spellID = 33076, filter = "CD"},
			-- Divine Star
			{spellID = 110744, filter = "CD"},
			-- Cascade
			{spellID = 121135, filter = "CD"},
			-- Archangel
			{spellID = 81700, filter = "CD"},
			-- Holy Word: Chastise
			{spellID = 88625, filter = "CD"},
			-- Halo
			{spellID = 120517, filter = "CD"},
			-- Inner Focus
			{spellID = 89485, filter = "CD"},
			-- Shadow Word: Death
			{spellID = 32379, filter = "CD"},
			-- Psychic Scream
			{spellID = 8122, filter = "CD"},
			-- Psychic Horror
			{spellID = 64044, filter = "CD"},
			-- Silence
			{spellID = 15487, filter = "CD"},
			-- Power Infusion
			{spellID = 10060, filter = "CD"},
			-- Dispersion
			{spellID = 47585, filter = "CD"},
			-- Pain Suppression
			{spellID = 33206, filter = "CD"},
			-- Guardian Spirit
			{spellID = 47788, filter = "CD"},
			-- Power Word: Barrier
			{spellID = 62618, filter = "CD"},
			-- Desperate Prayer
			{spellID = 19236, filter = "CD"},
			-- Leap of Faith
			{spellID = 73325, filter = "CD"},
			-- Void Tendrils
			{spellID = 108920, filter = "CD"},

			-- Racial
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
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},

			-- Items
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
			{spellID = 125487, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, filter = "ICD", trigger = "BUFF", duration = 115},
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Slice and Dice
			{spellID = 5171, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recuperate
			{spellID = 73651, unitID = "player", caster = "player", filter = "BUFF"},
			-- Adrenaline Rush
			{spellID = 13750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Blades
			{spellID = 121471, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "player", caster = "player", filter = "BUFF"},
			-- Envenom
			{spellID = 32645, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 51713, unitID = "player", caster = "player", filter = "BUFF"},
			-- Master of Subtlety
			{spellID = 31665, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cloak of Shadows
			{spellID = 31224, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vanish
			{spellID = 1856, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Readiness
			{spellID = 74001, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blade Flurry
			{spellID = 13877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sprint
			{spellID = 2983, unitID = "player", caster = "player", filter = "BUFF"},
			-- Feint
			{spellID = 1966, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Walk
			{spellID = 114842, unitID = "player", caster = "player", filter = "BUFF"},
			-- Subterfuge
			{spellID = 115192, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Anticipation
			{spellID = 115189, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shallow Insight
			{spellID = 84745, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moderate Insight
			{spellID = 84746, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Insight
			{spellID = 84747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blindside
			{spellID = 121153, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Physical General
			-- Swordguard Embroidery (Attack Power)
			{spellID = 125489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Dancing Steel (Agility)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Rupture
			{spellID = 1943, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Garrote
			{spellID = 703, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Weakened Armor
			{spellID = 113746, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Dismantle
			{spellID = 51722, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Revealing Strike
			{spellID = 84617, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vendetta
			{spellID = 79140, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hemorrhage
			{spellID = 16511, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Find Weakness
			{spellID = 91021, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Deadly Poison
			{spellID = 2818, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind-numbing Poison
			{spellID = 5760, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Crippling Poison
			{spellID = 3409, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].pve_cc)},

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
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Stealth
			{spellID = 1784, filter = "CD"},
			-- Kick
			{spellID = 1766, filter = "CD"},
			-- Gouge
			{spellID = 1776, filter = "CD"},
			-- Kidney Shot
			{spellID = 408, filter = "CD"},
			-- Premiditation
			{spellID = 14183, filter = "CD"},
			-- Redirect
			{spellID = 73981, filter = "CD"},
			-- Dismantle
			{spellID = 51722, filter = "CD"},
			-- Sprint
			{spellID = 2983, filter = "CD"},
			-- Killing Spree
			{spellID = 51690, filter = "CD"},
			-- Adrenaline Rush
			{spellID = 13750, filter = "CD"},
			-- Shadow Blades
			{spellID = 121471, filter = "CD"},
			-- Vendetta
			{spellID = 79140, filter = "CD"},
			-- Shadow Dance
			{spellID = 51713, filter = "CD"},
			-- Combat Readiness
			{spellID = 74001, filter = "CD"},
			-- Vanish
			{spellID = 1856, filter = "CD"},

			-- Racial
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
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},

			-- Items
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Maelstorm Weapon
			{spellID = 53817, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Shield
			{spellID = 324, unitID = "player", caster = "player", filter = "BUFF", spec = 1},
			-- Shamanistic Rage
			{spellID = 30823, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Mastery
			{spellID = 16166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance
			{spellID = 114049, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Flame
			{spellID = 73683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Life
			{spellID = 73685, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature Guardian
			{spellID = 31616, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stone Bulwark
			{spellID = 114893, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ancestral Guidance
			{spellID = 108281, unitID = "player", caster = "player", filter = "BUFF"},
			-- Astral Shift
			{spellID = 108271, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Clearcasting
			{spellID = 16246, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lava Surge
			{spellID = 77762, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Blast
			{spellID = 118522, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tidal Waves
			{spellID = 53390, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Agility DPS
			-- Assurance of Consequence (Agility, Proc)
			{spellID = 146308, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haromm's Talisman (Agility, Proc)
			{spellID = 148903, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sigil of Rampage (Agility, Proc)
			{spellID = 148896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ticking Ebon Detonator (Agility, Proc)
			{spellID = 146310, unitID = "player", caster = "player", filter = "BUFF"},
			-- Discipline of Xuen (Crit, Proc)
			{spellID = 146312, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vicious Talisman of the Shado-Pan Assault (Agility, Proc)
			{spellID = 138699, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bad Juju (Agility, Proc)
			{spellID = 138938, unitID = "player", caster = "player", filter = "BUFF"},
			-- Talisman of Bloodlust (Haste, Proc)
			{spellID = 138895, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Re-Origination (Convert, Proc)
			{spellID = 139120, unitID = "player", caster = "player", filter = "BUFF"},
			-- Renataki's Soul Charm (Agility, Proc)
			{spellID = 138756, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arrowflight Medallion (Crit, Use)
			{spellID = 136086, unitID = "player", caster = "player", filter = "BUFF"},
			-- Terror in the Mists (Crit, Proc)
			{spellID = 126649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Bandit Figurine (Haste, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bottle of Infinite Stars (Agility, Proc)
			{spellID = 126554, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Use)
			{spellID = 126690, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Agility, Proc)
			{spellID = 126707, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unerring Vision of Lei-Shen (Crit, Proc)
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal
			-- Prismatic Prison of Pride (Intellect, Proc)
			{spellID = 146314, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nazgrim's Burnished Insignia (Intellect, Proc)
			{spellID = 148908, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Acid-Grooved Tooth (Intellect, Proc)
			{spellID = 148911, unitID = "player", caster = "player", filter = "BUFF"},
			-- Qin-xi's Polarizing Seal (Intellect, Proc)
			{spellID = 126588, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Physical General
			-- Swordguard Embroidery (Attack Power)
			{spellID = 125489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Dancing Steel (Agility)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster Heal

			-- Legendary Meta Gems
			-- Sinister Primal Diamond (Caster DPS)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
			-- Courageous Primal Diamond (Caster Heal)
			{spellID = 137288, unitID = "player", caster = "all", filter = "BUFF"},

			-- Legendary Cloak
			-- Spirit of Chi-Ji
			{spellID = 146200, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Stormstrike
			{spellID = 17364, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Flame Shock
			{spellID = 8050, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Searing Flames
			{spellID = 77661, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Earthgrab
			{spellID = 64695, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].target_bar)},

			-- Earth Shield
			{spellID = 974, unitID = "target", caster = "player", filter = "BUFF"},
			-- Riptide
			{spellID = 61295, unitID = "target", caster = "player", filter = "BUFF"},
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
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Hex
			{spellID = 51514, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Bind Elemental
			{spellID = 76780, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Cleanse Spirit
			{spellID = 51886, filter = "CD"},
			-- Wind Shear
			{spellID = 57994, filter = "CD"},
			-- Hex
			{spellID = 51514, filter = "CD"},
			-- Earth Shock
			{spellID = 8042, filter = "CD"},
			-- Lava Burst
			{spellID = 51505, filter = "CD"},
			-- Riptide
			{spellID = 61295, filter = "CD"},
			-- Stormstrike
			{spellID = 17364, filter = "CD"},
			-- Lava Lash
			{spellID = 60103, filter = "CD"},
			-- Healing Rain
			{spellID = 73920, filter = "CD"},
			-- Elemental Blast
			{spellID = 117014, filter = "CD"},
			-- Unleash Elements
			{spellID = 73680, filter = "CD"},
			-- Thunderstorm
			{spellID = 51490, filter = "CD"},
			-- Earthbind Totem
			{spellID = 2484, filter = "CD"},
			-- Tremor Totem
			{spellID = 8143, filter = "CD"},
			-- Shamanistic Rage
			{spellID = 30823, filter = "CD"},
			-- Stone Bulwark Totem
			{spellID = 108270, filter = "CD"},
			-- Astral Shift
			{spellID = 108271, filter = "CD"},
			-- Ancestral Swiftness
			{spellID = 16188, filter = "CD"},
			-- Feral Spirit
			{spellID = 51533, filter = "CD"},
			-- Spiritwalker's Grace
			{spellID = 79206, filter = "CD"},
			-- Ancestral Guidance
			{spellID = 108281, filter = "CD"},
			-- Ascendance
			{spellID = 114049, filter = "CD"},

			-- Racial
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
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},

			-- Items
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
			{spellID = 125487, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, filter = "ICD", trigger = "BUFF", duration = 115},
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Dark Bargain
			{spellID = 110913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Knowledge
			{spellID = 113861, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Misery
			{spellID = 113860, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Instability
			{spellID = 113858, unitID = "player", caster = "player", filter = "BUFF"},
			-- Twilight Ward
			{spellID = 6229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soulburn
			{spellID = 74434, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Swap
			{spellID = 86211, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Rush
			{spellID = 111400, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Buffs
			-- Molten Core
			{spellID = 122355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Backdraft
			{spellID = 117828, unitID = "player", caster = "player", filter = "BUFF"},
			-- Backlash
			{spellID = 34936, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demonic Rebirth
			{spellID = 108559, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster General
			-- Shock-Charger Medallion Figurine (Intellect, Use)
			{spellID = 136082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Magistrate Figurine (Crit, Use)
			{spellID = 126605, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Use)
			{spellID = 126683, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Spell Power, Proc)
			{spellID = 126705, unitID = "player", caster = "player", filter = "BUFF"},
			-- Caster DPS
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kardris' Toxic Totem (Intellect, Proc)
			{spellID = 148906, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzied Crystal of Rage (Intellect, Proc)
			{spellID = 148897, unitID = "player", caster = "player", filter = "BUFF"},
			-- Black Blood of Y'Shaarj (Intellect, Proc)
			{spellID = 146184, unitID = "player", caster = "player", filter = "BUFF"},
			-- Yu'lon's Bite (Crit, Proc)
			{spellID = 146218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unerring Vision of Lei-Shen (Crit, Proc)
			{spellID = 138963, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volatile Talisman of the Shado-Pan Assault (Haste, Proc)
			{spellID = 138703, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cha-Ye's Essence of Brilliance (Intellect, Proc)
			{spellID = 139133, unitID = "player", caster = "player", filter = "BUFF"},
			-- Breath of the Hydra (Intellect, Proc)
			{spellID = 138898, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wushoolay's Final Choice (Intellect, Proc)
			{spellID = 138786, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Terror (Haste, Proc)
			{spellID = 126659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light of the Cosmos (Intellect, Proc)
			{spellID = 126577, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Caster General
			-- Jade Spirit (Intellect + Spirit)
			{spellID = 104993, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightweave (Intellect)
			{spellID = 125487, unitID = "player", caster = "player", filter = "BUFF"},

			-- Legendary Meta Gems
			-- Sinister Primal Diamond (Caster DPS)
			{spellID = 137590, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Self
			-- Curse of the Elements
			{spellID = 1490, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Exhaustion
			{spellID = 18223, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Enfeeblement
			{spellID = 109466, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Enslave Demon
			{spellID = 1098, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- CoE group
			-- Master Poisoner (Rogue)
			{spellID = 93068, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Lightning Breath (Wind Serpent)
			{spellID = 24844, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fire Breath (Dragonhawk)
			{spellID = 34889, unitID = "target", caster = "all", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].target_bar)},

			-- Doom
			{spellID = 603, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Agony
			{spellID = 980, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Corruption
			{spellID = 172, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seed of Corruption
			{spellID = 27243, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immolate
			{spellID = 348, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 30108, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Haunt
			{spellID = 48181, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].pve_cc)},

			-- Fear
			{spellID = 118699, unitID = "focus", caster = "player", filter = "DEBUFF"},
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
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Devour Magic (Felhunter)
			{spellID = 19505, filter = "CD"},
			-- Spell Lock (Felhunter)
			{spellID = 19647, filter = "CD"},
			-- Shadowfury
			{spellID = 30283, filter = "CD"},
			-- Howl of Terror
			{spellID = 5484, filter = "CD"},
			-- Mortal Coil
			{spellID = 6789, filter = "CD"},
			-- Twilight Ward
			{spellID = 6229, filter = "CD"},
			-- Sacrifice (Voidwalker)
			{spellID = 7812, filter = "CD"},
			-- Hand of Gul'dan
			{spellID = 105174, filter = "CD"},
			-- Demonic Circle: Teleport
			{spellID = 48020, filter = "CD"},
			-- Felstorm
			{spellID = 89751, filter = "CD"},
			-- Soulburn
			{spellID = 74434, filter = "CD"},
			-- Grimoire of Service
			{spellID = 108501, filter = "CD"},

			-- Racial
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

			-- Items
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
			{spellID = 125487, filter = "ICD", trigger = "BUFF", duration = 60},
			-- Purified Bindings of Immerseus (Intellect, Proc)
			{spellID = 146046, filter = "ICD", trigger = "BUFF", duration = 115},
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
			Position = {unpack(C["filger_position"].player_buff_icon)},

			-- Shield Wall
			{spellID = 871, unitID = "player", caster = "player", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enraged Regeneration
			{spellID = 55694, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Block
			{spellID = 2565, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Barrier
			{spellID = 112048, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "player", caster = "player", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avatar
			{spellID = 107574, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodbath
			{spellID = 12292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recklesness
			{spellID = 1719, unitID = "player", caster = "player", filter = "BUFF"},
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
			Position = {unpack(C["filger_position"].player_proc_icon)},

			-- Bloodsurge
			{spellID = 46916, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sword and Board
			{spellID = 50227, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ultimatum
			{spellID = 122510, unitID = "player", caster = "player", filter = "BUFF"},
			-- Taste for Blood
			{spellID = 60503, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meat Cleaver
			{spellID = 85739, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 12880, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rude Interruption
			{spellID = 86663, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- General
			-- Darkmoon Cards (Proc)
			{spellID = 128985, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Health, Use)
			{spellID = 126697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tank
			-- Rook's Unlucky Talisman (Reduces damage, Use)
			{spellID = 146343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resolve of Niuzao (Dodge, Use)
			{spellID = 146344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Steadfast Talisman of the Shado-Pan Assault (Dodge, Use)
			{spellID = 138728, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delicate Vial of the Sanguinaire (Mastery, Proc)
			{spellID = 138864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stuff of Nightmares (Dodge, Proc)
			{spellID = 126646, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vial of Dragon's Blood (Dodge, Proc)
			{spellID = 126533, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Warlord Figurine (Mastery, Use)
			{spellID = 126597, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Strength DPS
			-- Evil Eye of Galakras (Strength, Proc)
			{spellID = 146245, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thok's Tail Tip (Strength, Proc)
			{spellID = 146250, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Skeer's Bloodsoaked Talisman (Strength, Proc)
			{spellID = 146285, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fusion-Fire Core (Strength, Proc)
			{spellID = 148899, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Alacrity of Xuen (Haste, Proc)
			{spellID = 146296, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brutal Talisman of the Shado-Pan Assault (Strength, Proc)
			{spellID = 138702, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fabled Feather of Ji-Kun (Strength, Proc)
			{spellID = 138759, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spark of Zandalar (Strength, Proc)
			{spellID = 138958, unitID = "player", caster = "player", filter = "BUFF"},
			-- Primordius' Talisman of Rage (Strength, Proc)
			{spellID = 138870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gaze of the Twins (Crit, Proc)
			{spellID = 139170, unitID = "player", caster = "player", filter = "BUFF"},
			-- Helmbreaker Medallion (Crit, Use)
			{spellID = 136084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkmist Vortex (Haste, Proc)
			{spellID = 126657, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lei Shin's Final Orders (Strength, Proc)
			{spellID = 126582, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jade Charioteer Figurine (Strength, Use)
			{spellID = 126599, unitID = "player", caster = "player", filter = "BUFF"},
			-- Iron Belly Wok (Haste, Use)
			{spellID = 129812, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Use)
			{spellID = 126679, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets (Strength, Proc)
			{spellID = 126700, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- General
			-- Tank
			-- River's Song (Dodge)
			{spellID = 116660, unitID = "player", caster = "all", filter = "BUFF"},
			-- Physical General
			-- Swordguard Embroidery (Attack Power)
			{spellID = 125489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Physical Melee
			-- Dancing Steel (Strength)
			{spellID = 120032, unitID = "player", caster = "all", filter = "BUFF"},

			-- Legendary Meta Gems
			-- Indomitable Primal Diamond (Tank)
			{spellID = 137593, unitID = "player", caster = "all", filter = "BUFF", absID = true},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 37,
			Position = {unpack(C["filger_position"].target_debuff_icon)},

			-- Colossus Smash
			{spellID = 86346, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Demoralizing Shout
			{spellID = 1160, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Weakened Armor
			{spellID = 113746, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Weakened Blows
			{spellID = 115798, unitID = "target", caster = "all", filter = "DEBUFF", spec = 3},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 30,
			Position = {unpack(C["filger_position"].cooldown)},

			-- Self
			-- Pummel
			{spellID = 6552, filter = "CD"},
			-- Shield Slam
			{spellID = 23922, filter = "CD"},
			-- Shockwave
			{spellID = 46968, filter = "CD"},
			-- Storm Bolt
			{spellID = 107570, filter = "CD"},
			-- Thunder Clap
			{spellID = 6343, filter = "CD"},
			-- Taunt
			{spellID = 355, filter = "CD"},
			-- Colossus Smash
			{spellID = 86346, filter = "CD"},
			-- Charge
			{spellID = 100, filter = "CD"},
			-- Spell Reflection
			{spellID = 23920, filter = "CD"},
			-- Intervene
			{spellID = 3411, filter = "CD"},
			-- Berserker Rage
			{spellID = 18499, filter = "CD"},
			-- Heroic Leap
			{spellID = 6544, filter = "CD"},
			-- Demoralizing Shout
			{spellID = 1160, filter = "CD"},
			-- Disarm
			{spellID = 676, filter = "CD"},
			-- Enraged Regeneration
			{spellID = 55694, filter = "CD"},
			-- Commanding Shout
			{spellID = 469, filter = "CD"},
			-- Shield Wall
			{spellID = 871, filter = "CD"},
			-- Last Stand
			{spellID = 12975, filter = "CD"},
			-- Rallying Cry
			{spellID = 97462, filter = "CD"},

			-- Racial
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
			-- Quaking Palm (Pandaren)
			{spellID = 107079, filter = "CD"},

			-- Items
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
			Position = {unpack(C["filger_position"].special_proc_icon)},

			-- Potions
			-- Virmen's Bite
			{spellID = 105697, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potion of Mogu Power
			{spellID = 105706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potion of the Jade Serpent
			{spellID = 105702, unitID = "player", caster = "player", filter = "BUFF"},
			-- Speed (Potion)
			{spellID = 2379, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Speed (BG)
			{spellID = 23451, unitID = "player", caster = "all", filter = "BUFF", absID = true},

			-- Leeroy Jenkins
			-- Bloodlust
			{spellID = 2825, unitID = "player", caster = "all", filter = "BUFF"},
			-- Heroism
			{spellID = 32182, unitID = "player", caster = "all", filter = "BUFF"},
			-- Time Warp
			{spellID = 80353, unitID = "player", caster = "all", filter = "BUFF"},
			-- Ancient Hysteria
			{spellID = 90355, unitID = "player", caster = "all", filter = "BUFF"},
			-- Drums of Rage
			{spellID = 146555, unitID = "player", caster = "all", filter = "BUFF"},

			-- Professions
			-- Synapse Springs
			{spellID = 126734, unitID = "player", caster = "player", filter = "BUFF"},
			-- Phase Fingers
			{spellID = 108788, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nitro Boosts
			{spellID = 54861, unitID = "player", caster = "player", filter = "BUFF"},
			-- Parachute
			{spellID = 55001, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lifeblood
			{spellID = 74497, unitID = "player", caster = "player", filter = "BUFF"},

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
			-- Hand of Protection
			{spellID = 1022, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Freedom
			{spellID = 1044, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Sacrifice
			{spellID = 6940, unitID = "player", caster = "all", filter = "BUFF"},
			-- Hand of Purity
			{spellID = 114039, unitID = "player", caster = "all", filter = "BUFF"},
			-- Life Cocoon
			{spellID = 116849, unitID = "player", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "player", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "player", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "player", caster = "all", filter = "BUFF"},
			-- Devotion Aura
			{spellID = 31821, unitID = "player", caster = "all", filter = "BUFF"},
			-- Rallying Cry
			{spellID = 97463, unitID = "player", caster = "all", filter = "BUFF"},
			-- Unholy Frenzy
			{spellID = 49016, unitID = "player", caster = "all", filter = "BUFF"},
			-- Tricks of the Trade
			{spellID = 57933, unitID = "player", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "player", caster = "all", filter = "BUFF"},
			-- Innervate
			{spellID = 29166, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "player", caster = "all", filter = "BUFF"},
			-- Grounding Totem
			{spellID = 8178, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lightwell Renew
			{spellID = 7001, unitID = "player", caster = "all", filter = "BUFF"},
			-- Slow Fall
			{spellID = 130, unitID = "player", caster = "all", filter = "BUFF"},
			-- Levitate
			{spellID = 1706, unitID = "player", caster = "all", filter = "BUFF"},
			-- Tiger's Lust
			{spellID = 116841, unitID = "player", caster = "all", filter = "BUFF"},
			-- Body and Soul
			{spellID = 65081, unitID = "player", caster = "all", filter = "BUFF"},
			-- Angelic Feather
			{spellID = 121557, unitID = "player", caster = "all", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "PVE/PVP_DEBUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = 60,
			Position = {unpack(C["filger_position"].pve_debuff)},

			-- Death Knight
			-- Shroud of Purgatory
			{spellID = 116888, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Gnaw (Ghoul)
			{spellID = 91800, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Monstrous Blow (Mutated Ghoul)
			{spellID = 91797, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Asphyxiate
			{spellID = 108194, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Remorseless Winter
			{spellID = 115001, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Strangulate
			{spellID = 47476, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dark Simulacrum
			{spellID = 77606, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Necrotic Strike
			{spellID = 73975, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chains of Ice
			{spellID = 45524, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chilblains
			{spellID = 50435, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Druid
			-- Cyclone
			{spellID = 33786, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidating Roar (Symbiosis)
			{spellID = 113004, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Bear Hug
			{spellID = 102795, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pounce
			{spellID = 9005, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Disorienting Roar
			{spellID = 99, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Solar Beam
			{spellID = 78675, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fae Silence
			{spellID = 114238, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Immobilized
			{spellID = 45334, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Infected Wounds
			{spellID = 58180, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Typhoon
			{spellID = 61391, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Hunter
			-- Aspect of the Pack
			{spellID = 13159, unitID = "player", caster = "all", filter = "BUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Binding Shot
			{spellID = 117526, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Freezing Trap
			{spellID = 3355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Scare Beast
			{spellID = 1513, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Scatter Shot
			{spellID = 19503, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silencing Shot
			{spellID = 34490, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Narrow Escape
			{spellID = 136634, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 19185, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussive Shot
			{spellID = 5116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussive Barrage
			{spellID = 35101, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Glyph of Freezing Trap
			{spellID = 61394, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ice Trap
			{spellID = 135382, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Bad Manner (Monkey)
			{spellID = 90337, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Lullaby (Crane)
			{spellID = 126246, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Web Wrap (Shale Spider)
			{spellID = 96201, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Venom Web Spray (Silithid)
			{spellID = 54706, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Web (Spider)
			{spellID = 4167, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pin (Crab)
			{spellID = 50245, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Nether Shock (Nether Ray)
			{spellID = 44957, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Clench (Scorpid)
			{spellID = 50541, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Breath (Chimaera)
			{spellID = 54644, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ankle Crack (Crocolisk)
			{spellID = 50433, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Time Warp (Warp Stalker)
			{spellID = 35346, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sting (Wasp)
			{spellID = 56626, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sonic Blast (Bat)
			{spellID = 50519, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Paralyzing Quill (Porcupine)
			{spellID = 126355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Petrifying Gaze (Basilisk)
			{spellID = 126423, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Cauterize
			{spellID = 87023, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Deep Freeze
			{spellID = 44572, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Combustion Impact
			{spellID = 118271, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostjaw
			{spellID = 102051, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silenced - Improved Counterspell
			{spellID = 55021, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Freeze (Pet)
			{spellID = 33395, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ice Ward
			{spellID = 111340, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostbolt
			{spellID = 116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostfire Bolt
			{spellID = 44614, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chilled
			{spellID = 7321, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Monk
			-- Paralysis
			{spellID = 115078, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Leg Sweep
			{spellID = 119381, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fists of Fury
			{spellID = 120086, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Clash
			{spellID = 122242, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Charging Ox Wave
			{spellID = 119392, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Disable
			{spellID = 116706, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Spear Hand Strike
			{spellID = 116709, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Grapple Weapon
			{spellID = 117368, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Hammer of Justice
			{spellID = 853, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fist of Justice
			{spellID = 105593, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Repentance
			{spellID = 20066, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Turn Evil
			{spellID = 10326, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blinding Light
			{spellID = 105421, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield
			{spellID = 31935, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Glyph of Dazing Shield
			{spellID = 63529, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seal of Justice
			{spellID = 20170, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Denounce
			{spellID = 2812, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Priest
			-- Dominate Mind
			{spellID = 605, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Psychic Terror
			{spellID = 113792, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sin and Punishment
			{spellID = 87204, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Void Tendril's Grasp
			{spellID = 114404, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Glyph of Mind Blast
			{spellID = 87194, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind Flay
			{spellID = 15407, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Kidney Shot
			{spellID = 408, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Garrote - Silence
			{spellID = 1330, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dismantle
			{spellID = 51722, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Deadly Throw
			{spellID = 26679, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Crippling Poison
			{spellID = 3409, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind-numbing Poison
			{spellID = 5760, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Hex
			{spellID = 51514, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthquake
			{spellID = 77505, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthgrab
			{spellID = 64695, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthbind
			{spellID = 3600, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostbrand Attack
			{spellID = 8034, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Thunderstorm
			{spellID = 51490, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Shadowfury
			{spellID = 30283, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blood Horror
			{spellID = 137143, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sleep
			{spellID = 104045, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Spell Lock (Felhunter)
			{spellID = 24259, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Optical Blast (Observer)
			{spellID = 115782, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Curse of Exhaustion
			{spellID = 18223, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Conflagrate
			{spellID = 17962, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowflame
			{spellID = 47960, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Warrior
			-- Storm Bolt
			{spellID = 132169, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Shockwave
			{spellID = 132168, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidating Shout
			{spellID = 20511, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Disarm
			{spellID = 676, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Staggering Shout
			{spellID = 107566, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Warbringer
			{spellID = 105771, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Piercing Howl
			{spellID = 12323, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Colossus Smash
			{spellID = 86346, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Charge Stun
			{spellID = 7922, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Racial
			-- War Stomp
			{spellID = 20549, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Quaking Palm
			{spellID = 107079, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Arcane Torrent
			{spellID = 28730, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Throne of Thunder
			-- Focused Lightning (Jin'rokh the Breaker)
			{spellID = 137422, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Marked Soul (Council of Elders)
			{spellID = 137359, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostbite (Council of Elders)
			{spellID = 136922, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Biting Cold (Council of Elders)
			{spellID = 136992, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Torrent of Ice (Megaera)
			{spellID = 139857, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cinder (Megaera)
			{spellID = 134391, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Static Shock (Lei Shen)
			{spellID = 135695, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Heart of Fear
			-- Unseen Strike (Blade Lord Ta'yak)
			{spellID = 123017, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Kor'thik Strike (Wind Lord Mel'jarak)
			{spellID = 123963, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Corrosive Resin (Wind Lord Mel'jarak)
			{spellID = 122064, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mogu'shan Vaults
			-- Wildfire Spark (Feng the Accursed)
			{spellID = 116784, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Arcane Resonance (Feng the Accursed)
			{spellID = 116417, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Voodoo Doll (Gara'jal the Spiritbinder)
			{spellID = 122151, unitID = "player", caster = "all", filter = "DEBUFF"},

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
			Position = {unpack(C["filger_position"].target_buff_icon)},

			-- Death knight
			-- Anti-Magic Shell
			{spellID = 48707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Desecrated Ground
			{spellID = 115018, unitID = "target", caster = "all", filter = "BUFF"},
			-- Lichborne
			{spellID = 49039, unitID = "target", caster = "all", filter = "BUFF"},
			-- Icebound Fortitude
			{spellID = 48792, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pillar of Frost
			{spellID = 51271, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unholy Frenzy
			{spellID = 49016, unitID = "target", caster = "all", filter = "BUFF"},
			-- Death's Advance
			{spellID = 96268, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Remorseless Winter
			{spellID = 115001, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Asphyxiate
			{spellID = 108194, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Gnaw (Ghoul)
			{spellID = 91800, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Monstrous Blow (Mutated Ghoul)
			{spellID = 91797, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Strangulate
			{spellID = 47476, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Druid
			-- Survival Instincts
			{spellID = 61336, unitID = "target", caster = "all", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "target", caster = "all", filter = "BUFF"},
			-- Innervate
			{spellID = 29166, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 16689, unitID = "target", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "target", caster = "all", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserk
			{spellID = 50334, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cyclone
			{spellID = 33786, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Intimidating Roar (Symbiosis)
			{spellID = 113004, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Bear Hug
			{spellID = 102795, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Pounce
			{spellID = 9005, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Disorienting Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Solar Beam
			{spellID = 78675, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fae Silence
			{spellID = 114238, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Hunter
			-- Aspect of the Pack
			{spellID = 13159, unitID = "target", caster = "all", filter = "BUFF"},
			-- Aspect of the Cheetah
			{spellID = 5118, unitID = "target", caster = "all", filter = "BUFF"},
			-- Deterrence
			{spellID = 19263, unitID = "target", caster = "all", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Freezing Trap
			{spellID = 3355, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Scare Beast
			{spellID = 1513, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Binding Shot
			{spellID = 117526, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Scatter Shot
			{spellID = 19503, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silencing Shot
			{spellID = 34490, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Bad Manner (Monkey)
			{spellID = 90337, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Lullaby (Crane)
			{spellID = 126246, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Nether Shock (Nether Ray)
			{spellID = 44957, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Ice Block
			{spellID = 45438, unitID = "target", caster = "all", filter = "BUFF"},
			-- Invisibility
			{spellID = 66, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "target", caster = "all", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 115610, unitID = "target", caster = "all", filter = "BUFF"},
			-- Alter Time
			{spellID = 110909, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cauterize
			{spellID = 87023, unitID = "target", caster = "target", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Deep Freeze
			{spellID = 44572, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Combustion Impact
			{spellID = 118271, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frostjaw
			{spellID = 102051, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silenced - Improved Counterspell
			{spellID = 55021, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Monk
			-- Touch of Karma
			{spellID = 125174, unitID = "target", caster = "target", filter = "BUFF"},
			-- Ring of Peace
			{spellID = 116844, unitID = "target", caster = "target", filter = "BUFF"},
			-- Diffuse Magic
			{spellID = 122783, unitID = "target", caster = "target", filter = "BUFF"},
			-- Dematerialize
			{spellID = 122465, unitID = "target", caster = "target", filter = "BUFF"},
			-- Debuffs
			-- Paralysis
			{spellID = 115078, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Leg Sweep
			{spellID = 119381, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fists of Fury
			{spellID = 120086, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Clash
			{spellID = 122242, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Charging Ox Wave
			{spellID = 119392, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Spear Hand Strike
			{spellID = 116709, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Divine Shield
			{spellID = 642, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Protection
			{spellID = 1022, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Sacrifice
			{spellID = 6940, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Freedom
			{spellID = 1044, unitID = "target", caster = "all", filter = "BUFF"},
			-- Hand of Purity
			{spellID = 114039, unitID = "target", caster = "all", filter = "BUFF"},
			-- Devotion Aura
			{spellID = 31821, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ardent Defender
			{spellID = 31850, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86698, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fist of Justice
			{spellID = 105593, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Turn Evil
			{spellID = 10326, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blinding Light
			{spellID = 105421, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield
			{spellID = 31935, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Priest
			-- Dispersion
			{spellID = 47585, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "all", filter = "BUFF"},
			-- Inner Focus
			{spellID = 96267, unitID = "target", caster = "all", filter = "BUFF", absID = true},
			-- Phantasm
			{spellID = 114239, unitID = "target", caster = "all", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Dominate Mind
			{spellID = 605, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Terror
			{spellID = 113792, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "target", caster = "all", filter = "DEBUFF"},

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
			-- Debuffs
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote - Silence
			{spellID = 1330, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Grounding Totem Effect
			{spellID = 8178, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shamanistic Rage
			{spellID = 30823, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Hex
			{spellID = 51514, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Bind Elemental
			{spellID = 76780, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Dark Bargain
			{spellID = 110913, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "target", caster = "all", filter = "BUFF"},
			-- Soulstone
			{spellID = 20707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Banish
			{spellID = 710, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blood Horror
			{spellID = 137143, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Sleep
			{spellID = 104045, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Spell Lock (Felhunter)
			{spellID = 24259, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Optical Blast (Observer)
			{spellID = 115782, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Warrior
			-- Spell Reflection
			{spellID = 23920, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "target", caster = "all", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "target", caster = "all", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "target", caster = "all", filter = "BUFF"},
			-- Bladestorm
			{spellID = 46924, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Storm Bolt
			{spellID = 132169, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shockwave
			{spellID = 132168, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Intimidating Shout
			{spellID = 20511, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silenced (Gag Order)
			{spellID = 18498, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Racial
			-- War Stomp
			{spellID = 20549, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Quaking Palm
			{spellID = 107079, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Arcane Torrent
			{spellID = 28730, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Heart of Fear
			-- Impaling Spear (Wind Lord Mel'jarak)
			{spellID = 122224, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- All
			-- Warsong Flag
			{spellID = 23333, unitID = "target", caster = "all", filter = "BUFF"},
			{spellID = 23335, unitID = "target", caster = "all", filter = "BUFF"},
			-- Netherstorm Flag
			{spellID = 34976, unitID = "target", caster = "all", filter = "BUFF"},
			-- Orb of Power
			{spellID = 121175, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Seaforium
			{spellID = 66271, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Drink
			{spellID = 80167, unitID = "target", caster = "all", filter = "BUFF"},
		},
	},
}