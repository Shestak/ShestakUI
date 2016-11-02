local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.filger.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
P_BUFF_ICON_Anchor = CreateFrame("Frame", "P_BUFF_ICON_Anchor", UIParent)
P_PROC_ICON_Anchor = CreateFrame("Frame", "P_PROC_ICON_Anchor", UIParent)
SPECIAL_P_BUFF_ICON_Anchor = CreateFrame("Frame", "SPECIAL_P_BUFF_ICON_Anchor", UIParent)
T_DEBUFF_ICON_Anchor = CreateFrame("Frame", "T_DEBUFF_ICON_Anchor", UIParent)
T_BUFF_Anchor = CreateFrame("Frame", "T_BUFF_Anchor", UIParent)
PVE_PVP_DEBUFF_Anchor = CreateFrame("Frame", "PVE_PVP_DEBUFF_Anchor", UIParent)
PVE_PVP_CC_Anchor = CreateFrame("Frame", "PVE_PVP_CC_Anchor", UIParent)
COOLDOWN_Anchor = CreateFrame("Frame", "COOLDOWN_Anchor", UIParent)
T_DE_BUFF_BAR_Anchor = CreateFrame("Frame", "T_DE_BUFF_BAR_Anchor", UIParent)

C["filger_spells"] = {
	["DEATHKNIGHT"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Bone Shield
			{spellID = 195181, unitID = "player", caster = "player", filter = "BUFF"},
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
			-- Desecrated Ground
			{spellID = 115018, unitID = "player", caster = "player", filter = "BUFF"},
			-- Death's Advance
			--BETA {spellID = 96268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unholy Blight
			{spellID = 115989, unitID = "player", caster = "player", filter = "BUFF"},
			-- Summon Gargoyle
			{spellID = 49206, filter = "ICD", trigger = "NONE", duration = 40},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Scent of Blood
			--BETA {spellID = 50421, unitID = "player", caster = "player", filter = "BUFF"},
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
			-- Shadow Infusion
			--BETA {spellID = 91342, unitID = "pet", caster = "player", filter = "BUFF", count = 5},
			-- Blood Charge
			--BETA {spellID = 114851, unitID = "player", caster = "player", filter = "BUFF", count = 10},

			-- Trinkets
			-- Alchemy Stones
			-- Strength
			{spellID = 60229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Drunken Evasiveness (Bonus Armor, Use) [Brawler's Statue]
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Victory (Strength, Proc)
			{spellID = 190025, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking
			-- Living Carapace (Damage Reduction, Use) [Animated Exoskeleton]
			{spellID = 225033, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Aura (Leech, Use) [Fang of Tichcondrius]
			{spellID = 225130, unitID = "player", caster = "player", filter = "BUFF"},
			-- Infernal Contract (Damage Reduction, Use) [Infernal Contract]
			{spellID = 225140, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sands of Time (DoT, Proc) [Royal Dagger Haft]
			{spellID = 225720, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowy Reflection (Damage Reduction, Proc) [Phantasmal Echo]
			{spellID = 222479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightmarish Ichor (Versatility, Proc) [Goblet of Nightmarish Ichor]
			{spellID = 222027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wild God's Fury (Health, Use) [Unbridled Fury]
			{spellID = 221695, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkening Soul (Damage Reduction, Proc) [Grotesque Statuette]
			{spellID = 222209, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crystalline Body (Damage Reduction, Use) [Shard of Rokmora]
			{spellID = 214366, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stance of the Mountain (Damage Reduction, Use) [Talisman of the Cragshaper]
			{spellID = 214423, unitID = "player", caster = "player", filter = "BUFF"},
			-- Warlord's Fortitude (Health and Mastery, Proc) [Parjesh's Medallion]
			{spellID = 214622, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nerubian Chitin (Armor, Proc) [Impenetrable Nerubian Husk]
			{spellID = 214494, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Strength]
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Heavy Hide (Armor)
			{spellID = 228399, unitID = "player", caster = "all", filter = "BUFF"},
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
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

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
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Mind Freeze
			{spellID = 47528, filter = "CD"},
			-- Strangulate
			{spellID = 47476, filter = "CD"},
			-- Gnaw (Ghoul)
			{spellID = 47481, filter = "CD"},
			-- Remorseless Winter
			{spellID = 196770, filter = "CD"},
			-- Dark Simulacrum
			{spellID = 77606, filter = "CD"},
			-- Soul Reaper
			{spellID = 130736, filter = "CD"},
			-- Death Grip
			{spellID = 49576, filter = "CD"},
			-- Plague Leech
			{spellID = 123693, filter = "CD"},
			-- Death and Decay
			{spellID = 43265, filter = "CD"},
			-- Death's Advance
			--BETA {spellID = 96268, filter = "CD"},
			-- Rune Tap
			--BETA {spellID = 48982, filter = "CD"},
			-- Anti-Magic Shell
			{spellID = 48707, filter = "CD"},
			-- Vampiric Blood
			{spellID = 55233, filter = "CD"},
			-- Pillar of Frost
			{spellID = 51271, filter = "CD"},
			-- Outbreak
			{spellID = 77575, filter = "CD"},
			-- Gorefiend's Grasp
			{spellID = 108199, filter = "CD"},
			-- Raise Dead
			{spellID = 46584, filter = "CD"},
			-- Dancing Rune Weapon
			{spellID = 49028, filter = "CD"},
			-- Unholy Blight
			{spellID = 115989, filter = "CD"},
			-- Breath of Sindragosa
			{spellID = 152279, filter = "CD"},
			-- Lichborne
			{spellID = 49039, filter = "CD"},
			-- Desecrated Ground
			{spellID = 108201, filter = "CD"},
			-- Death Pact
			{spellID = 48743, filter = "CD"},
			-- Anti-Magic Zone
			{spellID = 51052, filter = "CD"},
			-- Icebound Fortitude
			{spellID = 48792, filter = "CD"},
			-- Summon Gargoyle
			{spellID = 49206, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
	["DEMONHUNTER"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Metamorphosis
			{spellID = 187827, unitID = "player", caster = "player", filter = "BUFF"},
			-- Empower Wards
			{spellID = 218256, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkness
			{spellID = 196718, unitID = "player", caster = "player", filter = "BUFF"},
			-- Immolation Aura
			{spellID = 178740, unitID = "player", caster = "player", filter = "BUFF"},
			-- Demon Spikes
			{spellID = 203720, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Barrier
			{spellID = 227225, unitID = "player", caster = "player", filter = "BUFF"},
			-- Netherwalk
			{spellID = 196555, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nether Bond
			{spellID = 207810, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Soul Fragments
			{spellID = 203981, unitID = "player", caster = "player", filter = "BUFF"},
			-- Painbringer (Vengeance Artifact)
			{spellID = 212988, unitID = "player", caster = "player", filter = "BUFF"},
			-- Momentum
			{spellID = 208628, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Drunken Evasiveness (Bonus Armor, Use) [Brawler's Statue]
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Conquest (Agility, Proc)
			{spellID = 190026, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking
			-- Living Carapace (Damage Reduction, Use) [Animated Exoskeleton]
			{spellID = 225033, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Aura (Leech, Use) [Fang of Tichcondrius]
			{spellID = 225130, unitID = "player", caster = "player", filter = "BUFF"},
			-- Infernal Contract (Damage Reduction, Use) [Infernal Contract]
			{spellID = 225140, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sands of Time (DoT, Proc) [Royal Dagger Haft]
			{spellID = 225720, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowy Reflection (Damage Reduction, Proc) [Phantasmal Echo]
			{spellID = 222479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightmarish Ichor (Versatility, Proc) [Goblet of Nightmarish Ichor]
			{spellID = 222027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wild God's Fury (Health, Use) [Unbridled Fury]
			{spellID = 221695, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkening Soul (Damage Reduction, Proc) [Grotesque Statuette]
			{spellID = 222209, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Agility]
			-- Blood Frenzy (Haste, Proc) [Bloodthirsty Instinct]
			{spellID = 221796, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Heavy Hide (Armor)
			{spellID = 228399, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Nemesis
			{spellID = 206491, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sigil of Flame
			{spellID = 204598, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sigil of Silence
			{spellID = 204490, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sigil of Misery
			{spellID = 207685, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sigil of Grasp
			{spellID = 204843, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Fiery Brand
			{spellID = 207744, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frailty
			{spellID = 224509, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Darkness
			{spellID = 209426, unitID = "target", caster = "player", filter = "BUFF"},
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
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Imprison
			{spellID = 217832, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Consume Magic
			{spellID = 183752, filter = "CD"},
			-- Fel Rush
			{spellID = 195072, filter = "CD", absID = true},
			-- Infernal Strike
			{spellID = 189110, filter = "CD"},
			-- Torment
			{spellID = 185245, filter = "CD"},
			-- Demon Spikes
			{spellID = 203720, filter = "CD"},
			-- Immolation Aura
			{spellID = 178740, filter = "CD"},
			-- Felblade
			{spellID = 213241, filter = "CD"},
			-- Throw Glaive
			{spellID = 185123, filter = "CD"},
			-- Soul Barrier
			{spellID = 227225, filter = "CD"},
			-- Blade Dance
			{spellID = 188499, filter = "CD"},
			-- Fel Barrage
			{spellID = 211053, filter = "CD"},
			-- Vengeful Retreat
			{spellID = 198793, filter = "CD", absID = true},
			-- Soul Carver (Artifact)
			{spellID = 207407, filter = "CD"},
			-- Sigil of Silence
			{spellID = 202137, filter = "CD"},
			-- Sigil of Misery
			{spellID = 207684, filter = "CD"},
			-- Empower Wards
			{spellID = 218256, filter = "CD"},
			-- Spectral Sight
			{spellID = 188501, filter = "CD"},
			-- Fiery Brand
			{spellID = 204021, filter = "CD"},
			-- Eye Beam
			{spellID = 198013, filter = "CD", absID = true},
			-- Chaos Nova
			{spellID = 179057, filter = "CD", absID = true},
			-- Sigil of Chains
			{spellID = 202138, filter = "CD"},
			-- Fel Eruption
			{spellID = 211881, filter = "CD"},
			-- Fel Devastation
			{spellID = 212084, filter = "CD"},
			-- Nether Bond
			{spellID = 207810, filter = "CD"},
			-- Fury of the Illidari (Artifact)
			{spellID = 201467, filter = "CD"},
			-- Netherwalk
			{spellID = 196555, filter = "CD"},
			-- Chaos Blades
			{spellID = 211048, filter = "CD"},
			-- Nemesis
			{spellID = 206491, filter = "CD"},
			-- Metamorphosis
			{spellID = 187827, filter = "CD"},
			-- Darkness
			{spellID = 196718, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Blood Elf)
			{spellID = 202719, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 58984, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Incarnation: Chosen of Elune
			{spellID = 102560, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: King of the Jungle
			{spellID = 102543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Son of Ursoc
			{spellID = 102558, unitID = "player", caster = "player", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "player", caster = "player", filter = "BUFF"},
			-- Survival Instincts
			{spellID = 61336, unitID = "player", caster = "player", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Defense
			--BETA {spellID = 132402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Savage Roar
			{spellID = 52610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Wild
			--BETA {spellID = 108294, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserk
			--BETA {spellID = 50334, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tiger's Fury
			{spellID = 5217, unitID = "player", caster = "player", filter = "BUFF"},
			-- Celestial Alignment
			--BETA {spellID = 112071, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Vigil
			{spellID = 124974, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lunar Empowerment
			{spellID = 164547, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solar Empowerment
			{spellID = 164545, unitID = "player", caster = "player", filter = "BUFF"},
			-- Starfall
			--BETA {spellID = 184989, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 170856, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dash
			{spellID = 1850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cenarion Ward
			{spellID = 102351, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Bloodtalons
			{spellID = 145152, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lunar Peak
			--BETA {spellID = 171743, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solar Peak
			--BETA {spellID = 171744, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rejuvenation (Glyph)
			--BETA {spellID = 96206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Clearcasting
			{spellID = 16870, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul of the Forest
			{spellID = 114108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tooth and Claw
			--BETA {spellID = 135286, unitID = "player", caster = "player", filter = "BUFF"},
			-- Predatory Swiftness
			{spellID = 69369, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Drunken Evasiveness (Bonus Armor, Use) [Brawler's Statue]
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- Now is the time! (Spell Power, Proc) [Mithril Wristwatch]
			{spellID = 127923, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Life (Haste, Proc) [Thousand-Year Pickled Egg]
			{spellID = 127915, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Dominance (Intellect, Proc)
			{spellID = 190027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Conquest (Agility, Proc)
			{spellID = 190026, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking
			-- Living Carapace (Damage Reduction, Use) [Animated Exoskeleton]
			{spellID = 225033, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Aura (Leech, Use) [Fang of Tichcondrius]
			{spellID = 225130, unitID = "player", caster = "player", filter = "BUFF"},
			-- Infernal Contract (Damage Reduction, Use) [Infernal Contract]
			{spellID = 225140, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sands of Time (DoT, Proc) [Royal Dagger Haft]
			{spellID = 225720, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowy Reflection (Damage Reduction, Proc) [Phantasmal Echo]
			{spellID = 222479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightmarish Ichor (Versatility, Proc) [Goblet of Nightmarish Ichor]
			{spellID = 222027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wild God's Fury (Health, Use) [Unbridled Fury]
			{spellID = 221695, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkening Soul (Damage Reduction, Proc) [Grotesque Statuette]
			{spellID = 222209, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crystalline Body (Damage Reduction, Use) [Shard of Rokmora]
			{spellID = 214366, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stance of the Mountain (Damage Reduction, Use) [Talisman of the Cragshaper]
			{spellID = 214423, unitID = "player", caster = "player", filter = "BUFF"},
			-- Warlord's Fortitude (Health and Mastery, Proc) [Parjesh's Medallion]
			{spellID = 214622, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nerubian Chitin (Armor, Proc) [Impenetrable Nerubian Husk]
			{spellID = 214494, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Agility]
			-- Blood Frenzy (Haste, Proc) [Bloodthirsty Instinct]
			{spellID = 221796, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Intellect]
			-- Accelerando (Haste, Proc) [Erratic Metronome]
			{spellID = 225719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nefarious Pact (Cast speed, Proc) [Whispers in the Dark]
			{spellID = 225774, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Lightning (Mastery, Proc) [Stormsinger Fulmination Charge]
			{spellID = 215632, unitID = "player", caster = "player", filter = "BUFF"},
			-- Collapsing Shadow (Agility, Use) [Obelisk of the Void]
			{spellID = 215476, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elune's Light (Agility, Use) [Moonlit Prism]
			{spellID = 215648, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Intensity (Crit, Proc) [Infernal Writ]
			{spellID = 215816, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing
			-- Constellations (Mastery, Haste, or Critical Strike, Proc) [Etraeus' Celestial Map]
			{spellID = 225136, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heightened Senses (Haste and Intellect, Proc) [Heightened Senses]
			{spellID = 221752, unitID = "player", caster = "player", filter = "BUFF"},
			-- Phased Webbing (Mastery, Proc) [Thrumming Gossamer]
			{spellID = 215198, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solemnity (Haste, Proc) [Flask of the Solemn Night]
			{spellID = 224347, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Heavy Hide (Armor)
			{spellID = 228399, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Moonfire
			{spellID = 164812, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sunfire
			{spellID = 164815, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Stellar Flare
			--BETA {spellID = 152221, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rake
			{spellID = 155722, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rip
			{spellID = 1079, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Lacerate
			--BETA {spellID = 33745, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Thrash
			{spellID = 77758, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immobilized
			{spellID = 45334, unitID = "target", caster = "player", filter = "DEBUFF"},

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
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

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
			Position = {"LEFT", PVE_PVP_CC_Anchor},

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
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Nature's Cure
			{spellID = 88423, filter = "CD"},
			-- Remove Corruption
			{spellID = 2782, filter = "CD"},
			-- Skull Bash
			{spellID = 106839, filter = "CD"},
			-- Mangle
			{spellID = 33917, filter = "CD"},
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
			-- Force of Nature
			--BETA {spellID = 102693, filter = "CD"},
			-- Faerie Fire
			--BETA {spellID = 770, filter = "CD"},
			-- Tiger's Fury
			{spellID = 5217, filter = "CD"},
			-- Incapacitating Roar
			{spellID = 99, filter = "CD"},
			-- Bristling Fur
			{spellID = 155835, filter = "CD"},
			-- Mass Entanglement
			{spellID = 102359, filter = "CD"},
			-- Typhoon
			{spellID = 132469, filter = "CD"},
			-- Mighty Bash
			{spellID = 5211, filter = "CD"},
			-- Solar Beam
			{spellID = 78675, filter = "CD"},
			-- Barkskin
			{spellID = 22812, filter = "CD"},
			-- Ironbark
			{spellID = 102342, filter = "CD"},
			-- Nature's Swiftness
			--BETA {spellID = 132158, filter = "CD"},
			-- Ursol's Vortex
			{spellID = 102793, filter = "CD"},
			-- Nature's Vigil
			{spellID = 124974, filter = "CD"},
			-- Berserk
			--BETA {spellID = 106952, filter = "CD", absID = true},
			-- Incarnation: Chosen of Elune
			{spellID = 102560, filter = "CD"},
			-- Incarnation: King of the Jungle
			{spellID = 102543, filter = "CD"},
			-- Incarnation: Son of Ursoc
			{spellID = 102558, filter = "CD"},
			-- Incarnation: Tree of Life
			{spellID = 33891, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Deterrence
			{spellID = 19263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Fire
			{spellID = 3045, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bestial Wrath
			{spellID = 19574, unitID = "player", caster = "player", filter = "BUFF"},
			-- Beast Cleave
			{spellID = 118455, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Trueshot
			{spellID = 193526, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Turtle
			{spellID = 186265, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Cheetah
			{spellID = 186257, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dire Beast
			{spellID = 120694, unitID = "player", caster = "player", filter = "BUFF"},
			-- Camouflage
			{spellID = 199483, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spirit Mend
			{spellID = 90361, unitID = "player", caster = "player", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "player", caster = "player", filter = "BUFF"},
			-- Volley
			{spellID = 194386, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Steady Focus
			--BETA {spellID = 177668, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lock and Load
			--BETA {spellID = 168980, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thrill of the Hunt
			--BETA {spellID = 34720, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzy
			{spellID = 19615, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mend Pet
			{spellID = 136, unitID = "pet", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Conquest (Agility, Proc)
			{spellID = 190026, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Agility]
			-- Blood Frenzy (Haste, Proc) [Bloodthirsty Instinct]
			{spellID = 221796, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Lightning (Mastery, Proc) [Stormsinger Fulmination Charge]
			{spellID = 215632, unitID = "player", caster = "player", filter = "BUFF"},
			-- Collapsing Shadow (Agility, Use) [Obelisk of the Void]
			{spellID = 215476, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elune's Light (Agility, Use) [Moonlit Prism]
			{spellID = 215648, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Black Arrow
			--BETA {spellID = 3674, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Explosive Shot
			--BETA {spellID = 53301, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Serpent Sting
			{spellID = 87935, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Narrow Escape
			{spellID = 136634, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 135373, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frozen Wake
			--BETA {spellID = 61394, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Warp Time (Warp Stalker)
			{spellID = 35346, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Ankle Crack (Crocolisk)
			{spellID = 50433, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Breath (Chimaera)
			{spellID = 54644, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Concussive Shot
			{spellID = 5116, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Ice Trap
			{spellID = 135299, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Poisoned Ammo
			{spellID = 162543, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frozen Ammo
			{spellID = 162546, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- True Aim
			{spellID = 199803, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Wyvern Sting
			{spellID = 19386, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Concussive Shot
			{spellID = 5116, filter = "CD"},
			-- Counter Shot
			{spellID = 147362, filter = "CD"},
			-- Kill Command
			{spellID = 34026, filter = "CD"},
			-- Explosive Shot
			--BETA {spellID = 53301, filter = "CD"},
			-- Chimera Shot
			{spellID = 53209, filter = "CD"},
			-- Kill Shot
			--BETA {spellID = 53351, filter = "CD"},
			-- Glaive Toss
			--BETA {spellID = 117050, filter = "CD"},
			-- Barrage
			{spellID = 120360, filter = "CD"},
			-- Disengage
			{spellID = 781, filter = "CD"},
			-- Dire Beast
			{spellID = 120679, filter = "CD"},
			-- Fervor
			{spellID = 82726, filter = "CD"},
			-- Misdirection
			{spellID = 34477, filter = "CD"},
			-- Feign Death
			{spellID = 5384, filter = "CD"},
			-- Explosive Trap
			{spellID = 13813, filter = "CD"},
			-- Ice Trap
			{spellID = 13809, filter = "CD"},
			-- Binding Shot
			{spellID = 117526, filter = "CD"},
			-- Master's Call
			{spellID = 53271, filter = "CD"},
			-- Powershot
			--BETA {spellID = 109259, filter = "CD"},
			-- Wyvern Sting
			{spellID = 19386, filter = "CD"},
			-- Intimidation
			{spellID = 19577, filter = "CD"},
			-- Bestial Wrath
			{spellID = 19574, filter = "CD"},
			-- A Murder of Crows
			{spellID = 131894, filter = "CD"},
			-- Lynx Rush
			--BETA {spellID = 120697, filter = "CD"},
			-- Exhilaration
			{spellID = 109304, filter = "CD"},
			-- Rapid Fire
			{spellID = 3045, filter = "CD"},
			-- Deterrence
			{spellID = 19263, filter = "CD"},
			-- Spirit Mend (Pet)
			{spellID = 90361, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Ice Block
			{spellID = 45438, unitID = "player", caster = "player", filter = "BUFF"},
			-- Invisibility
			{spellID = 66, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Invisibility
			{spellID = 32612, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Invisibility
			{spellID = 110960, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Icy Veins
			{spellID = 12472, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Power
			{spellID = 12042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combustion
			{spellID = 190319, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rune of Power
			{spellID = 116014, filter = "ICD", trigger = "NONE", duration = 10},
			-- Ice Barrier
			{spellID = 11426, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heating Up
			{spellID = 48107, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ice Floes
			{spellID = 108839, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evanesce
			{spellID = 157913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Alter Time
			{spellID = 110909, unitID = "player", caster = "player", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 115610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mirror Image
			{spellID = 55342, filter = "ICD", trigger = "NONE", duration = 40},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Fingers of Frost
			{spellID = 44544, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brain Freeze
			--BETA {spellID = 57761, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Missiles!
			{spellID = 79683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pyroblast!
			{spellID = 48108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chain Reaction (Ebonchill)
			{spellID = 195418, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Now is the time! (Spell Power, Proc) [Mithril Wristwatch]
			{spellID = 127923, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Dominance (Intellect, Proc)
			{spellID = 190027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Intellect]
			-- Accelerando (Haste, Proc) [Erratic Metronome]
			{spellID = 225719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nefarious Pact (Cast speed, Proc) [Whispers in the Dark]
			{spellID = 225774, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Lightning (Mastery, Proc) [Stormsinger Fulmination Charge]
			{spellID = 215632, unitID = "player", caster = "player", filter = "BUFF"},
			-- Collapsing Shadow (Agility, Use) [Obelisk of the Void]
			{spellID = 215476, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elune's Light (Agility, Use) [Moonlit Prism]
			{spellID = 215648, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Intensity (Crit, Proc) [Infernal Writ]
			{spellID = 215816, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Arcane Charge
			{spellID = 36032, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Living Bomb
			{spellID = 44457, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Nether Tempest
			{spellID = 114923, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Bomb
			{spellID = 112948, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroblast
			{spellID = 11366, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Combustion
			--BETA {spellID = 83853, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freeze (Pet)
			{spellID = 33395, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Water Jet (Pet)
			{spellID = 135029, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frostbite
			{spellID = 198121, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Flurry
			{spellID = 228354, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Ice Nova
			{spellID = 157997, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "target", caster = "player", filter = "DEBUFF"},

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
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Polymorph
			{spellID = 118, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Frostjaw
			--BETA {spellID = 102051, filter = "CD"},
			-- Counterspell
			{spellID = 2139, filter = "CD"},
			-- Living Bomb
			{spellID = 44457, filter = "CD"},
			-- Blink
			{spellID = 1953, filter = "CD"},
			-- Blazing Speed
			{spellID = 108843, filter = "CD"},
			-- Deep Freeze
			--BETA {spellID = 44572, filter = "CD"},
			-- Frost Nova
			{spellID = 122, filter = "CD"},
			-- Ring of Frost
			{spellID = 113724, filter = "CD"},
			-- Ice Barrier
			{spellID = 11426, filter = "CD"},
			-- Temporal Shield
			{spellID = 115610, filter = "CD"},
			-- Fire Blast
			--BETA {spellID = 2136, filter = "CD"},
			-- Frost Bomb
			{spellID = 112948, filter = "CD"},
			-- Flamestrike
			{spellID = 2120, filter = "CD"},
			-- Cone of Cold
			{spellID = 120, filter = "CD"},
			-- Water Jet (Pet)
			{spellID = 135029, filter = "CD"},
			-- Comet Storm
			{spellID = 153595, filter = "CD"},
			-- Ice Floes
			{spellID = 108839, filter = "CD"},
			-- Flame On
			{spellID = 205029, filter = "CD"},
			-- Combustion
			--BETA {spellID = 11129, filter = "CD"},
			-- Frozen Orb
			{spellID = 84714, filter = "CD"},
			-- Arcane Power
			{spellID = 12042, filter = "CD"},
			-- Presence of Mind
			--BETA {spellID = 12043, filter = "CD"},
			-- Alter Time
			{spellID = 108978, filter = "CD"},
			-- Evocation
			{spellID = 12051, filter = "CD"},
			-- Icy Veins
			{spellID = 12472, filter = "CD"},
			-- Mirror Image
			{spellID = 55342, filter = "CD"},
			-- Combustion
			{spellID = 190319, filter = "CD"},
			-- Cold Snap
			{spellID = 11958, filter = "CD"},
			-- Ice Block
			{spellID = 45438, filter = "CD"},
			-- Invisibility
			{spellID = 66, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Guard
			--BETA {spellID = 115295, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fortifying Brew
			{spellID = 120954, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elusive Brew
			{spellID = 115308, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tigereye Brew
			{spellID = 116740, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Touch of Karma
			{spellID = 125174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Diffuse Magic
			{spellID = 122783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dampen Harm
			{spellID = 122278, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nimble Brew
			--BETA {spellID = 137562, unitID = "player", caster = "player", filter = "BUFF"},
			-- Serenity
			{spellID = 152173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Energizing Brew
			{spellID = 115288, unitID = "player", caster = "player", filter = "BUFF"},
			-- Thunder Focus Tea
			{spellID = 116680, unitID = "player", caster = "player", filter = "BUFF"},
			-- Momentum
			{spellID = 119085, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Elusive Brew
			{spellID = 128939, unitID = "player", caster = "player", filter = "BUFF", absID = true, count = 12},
			-- Mana Tea
			--BETA {spellID = 115867, unitID = "player", caster = "player", filter = "BUFF", absID = true, count = 18},
			-- Tigereye Brew
			--BETA {spellID = 125195, unitID = "player", caster = "player", filter = "BUFF", absID = true, count = 10},
			-- Tiger Power
			--BETA {spellID = 125359, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combo Breaker: Blackout Kick
			{spellID = 116768, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combo Breaker: Chi Explosion
			{spellID = 159407, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combo Breaker: Tiger Palm
			--BETA {spellID = 118864, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shuffle
			--BETA {spellID = 115307, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vital Mists
			--BETA {spellID = 118674, unitID = "player", caster = "player", filter = "BUFF"},
			-- Serpent's Zeal
			--BETA {spellID = 127722, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger Strikes
			--BETA {spellID = 120273, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Drunken Evasiveness (Bonus Armor, Use) [Brawler's Statue]
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Life (Haste, Proc) [Thousand-Year Pickled Egg]
			{spellID = 127915, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Conquest (Agility, Proc)
			{spellID = 190026, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Dominance (Intellect, Proc)
			{spellID = 190027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking
			-- Living Carapace (Damage Reduction, Use) [Animated Exoskeleton]
			{spellID = 225033, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Aura (Leech, Use) [Fang of Tichcondrius]
			{spellID = 225130, unitID = "player", caster = "player", filter = "BUFF"},
			-- Infernal Contract (Damage Reduction, Use) [Infernal Contract]
			{spellID = 225140, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sands of Time (DoT, Proc) [Royal Dagger Haft]
			{spellID = 225720, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowy Reflection (Damage Reduction, Proc) [Phantasmal Echo]
			{spellID = 222479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightmarish Ichor (Versatility, Proc) [Goblet of Nightmarish Ichor]
			{spellID = 222027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wild God's Fury (Health, Use) [Unbridled Fury]
			{spellID = 221695, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkening Soul (Damage Reduction, Proc) [Grotesque Statuette]
			{spellID = 222209, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crystalline Body (Damage Reduction, Use) [Shard of Rokmora]
			{spellID = 214366, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stance of the Mountain (Damage Reduction, Use) [Talisman of the Cragshaper]
			{spellID = 214423, unitID = "player", caster = "player", filter = "BUFF"},
			-- Warlord's Fortitude (Health and Mastery, Proc) [Parjesh's Medallion]
			{spellID = 214622, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nerubian Chitin (Armor, Proc) [Impenetrable Nerubian Husk]
			{spellID = 214494, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Agility]
			-- Blood Frenzy (Haste, Proc) [Bloodthirsty Instinct]
			{spellID = 221796, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing
			-- Constellations (Mastery, Haste, or Critical Strike, Proc) [Etraeus' Celestial Map]
			{spellID = 225136, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heightened Senses (Haste and Intellect, Proc) [Heightened Senses]
			{spellID = 221752, unitID = "player", caster = "player", filter = "BUFF"},
			-- Phased Webbing (Mastery, Proc) [Thrumming Gossamer]
			{spellID = 215198, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solemnity (Haste, Proc) [Flask of the Solemn Night]
			{spellID = 224347, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Heavy Hide (Armor)
			{spellID = 228399, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Heavy Stagger
			{spellID = 124273, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Dizzying Haze
			--BETA {spellID = 116330, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Breath of Fire
			{spellID = 123725, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rising Sun Kick
			--BETA {spellID = 130320, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

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
			--BETA {spellID = 115295, filter = "CD"},
			-- Charging Ox Wave
			--BETA {spellID = 119392, filter = "CD"},
			-- Hurricane Strike
			{spellID = 152175, filter = "CD"},
			-- Ring of Peace
			{spellID = 116844, filter = "CD"},
			-- Thunder Focus Tea
			{spellID = 116680, filter = "CD"},
			-- Dampen Harm
			{spellID = 122278, filter = "CD"},
			-- Flying Serpent Kick
			{spellID = 101545, filter = "CD"},
			-- Energizing Brew
			{spellID = 115288, filter = "CD"},
			-- Diffuse Magic
			{spellID = 122783, filter = "CD"},
			-- Breath of the Serpent
			--BETA {spellID = 157535, filter = "CD"},
			-- Serenity
			{spellID = 152173, filter = "CD"},
			-- Touch of Karma
			{spellID = 122470, filter = "CD"},
			-- Touch of Death
			{spellID = 115080, filter = "CD"},
			-- Nimble Brew
			--BETA {spellID = 137562, filter = "CD"},
			-- Life Cocoon
			{spellID = 116849, filter = "CD"},
			-- Invoke Xuen, the White Tiger
			{spellID = 123904, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Divine Shield
			{spellID = 642, unitID = "player", caster = "player", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86659, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Avenger
			{spellID = 105809, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avenging Wrath
			{spellID = 31884, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seraphim
			{spellID = 152262, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ardent Defender
			{spellID = 31850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "player", caster = "player", filter = "BUFF"},
			-- Speed of Light
			{spellID = 85499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Eternal Flame
			{spellID = 114163, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Infusion of Light
			{spellID = 54149, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bastion of Glory
			--BETA {spellID = 114637, unitID = "player", caster = "player", filter = "BUFF"},
			-- Selfless Healer
			{spellID = 114250, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Purpose
			--BETA {spellID = 90174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grand Crusader
			{spellID = 85416, unitID = "player", caster = "player", filter = "BUFF"},
			-- Daybreak
			--BETA {spellID = 88819, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Crusader
			--BETA {spellID = 144595, unitID = "player", caster = "player", filter = "BUFF"},
			-- Final Verdict
			{spellID = 157048, unitID = "player", caster = "player", filter = "BUFF"},
			-- Long Arm of the Law
			--BETA {spellID = 87173, unitID = "player", caster = "player", filter = "BUFF"},
			-- Supplication
			--BETA {spellID = 94686, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Strength
			{spellID = 60229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Drunken Evasiveness (Bonus Armor, Use) [Brawler's Statue]
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Life (Haste, Proc) [Thousand-Year Pickled Egg]
			{spellID = 127915, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Victory (Strength, Proc)
			{spellID = 190025, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Dominance (Intellect, Proc)
			{spellID = 190027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking
			-- Living Carapace (Damage Reduction, Use) [Animated Exoskeleton]
			{spellID = 225033, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Aura (Leech, Use) [Fang of Tichcondrius]
			{spellID = 225130, unitID = "player", caster = "player", filter = "BUFF"},
			-- Infernal Contract (Damage Reduction, Use) [Infernal Contract]
			{spellID = 225140, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sands of Time (DoT, Proc) [Royal Dagger Haft]
			{spellID = 225720, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowy Reflection (Damage Reduction, Proc) [Phantasmal Echo]
			{spellID = 222479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightmarish Ichor (Versatility, Proc) [Goblet of Nightmarish Ichor]
			{spellID = 222027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wild God's Fury (Health, Use) [Unbridled Fury]
			{spellID = 221695, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkening Soul (Damage Reduction, Proc) [Grotesque Statuette]
			{spellID = 222209, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crystalline Body (Damage Reduction, Use) [Shard of Rokmora]
			{spellID = 214366, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stance of the Mountain (Damage Reduction, Use) [Talisman of the Cragshaper]
			{spellID = 214423, unitID = "player", caster = "player", filter = "BUFF"},
			-- Warlord's Fortitude (Health and Mastery, Proc) [Parjesh's Medallion]
			{spellID = 214622, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nerubian Chitin (Armor, Proc) [Impenetrable Nerubian Husk]
			{spellID = 214494, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Strength]
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing
			-- Constellations (Mastery, Haste, or Critical Strike, Proc) [Etraeus' Celestial Map]
			{spellID = 225136, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heightened Senses (Haste and Intellect, Proc) [Heightened Senses]
			{spellID = 221752, unitID = "player", caster = "player", filter = "BUFF"},
			-- Phased Webbing (Mastery, Proc) [Thrumming Gossamer]
			{spellID = 215198, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solemnity (Haste, Proc) [Flask of the Solemn Night]
			{spellID = 224347, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Heavy Hide (Armor)
			{spellID = 228399, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Forbearance
			{spellID = 25771, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Censure
			--BETA {spellID = 31803, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Dazing Shield (Glyph)
			--BETA {spellID = 63529, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seal of Justice
			--BETA {spellID = 20170, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Denounce
			--BETA {spellID = 2812, unitID = "target", caster = "player", filter = "DEBUFF"},

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
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Cleanse
			{spellID = 4987, filter = "CD"},
			-- Rebuke
			{spellID = 96231, filter = "CD"},
			-- Repentance
			{spellID = 20066, filter = "CD"},
			-- Hammer of Justice
			{spellID = 853, filter = "CD"},
			-- Judgment
			{spellID = 20271, filter = "CD"},
			-- Consecration
			{spellID = 26573, filter = "CD"},
			-- Holy Wrath
			--BETA {spellID = 119072, filter = "CD"},
			-- Avenger's Shield
			{spellID = 31935, filter = "CD"},
			-- Exorcism
			--BETA {spellID = 879, filter = "CD"},
			-- Beacon of Insight
			--BETA {spellID = 157007, filter = "CD"},
			-- Holy Prism
			{spellID = 114165, filter = "CD"},
			-- Blessing of Freedom
			{spellID = 1044, filter = "CD"},
			-- Seraphim
			{spellID = 152262, filter = "CD"},
			-- Speed of Light
			{spellID = 85499, filter = "CD"},
			-- Divine Protection
			{spellID = 498, filter = "CD", absID = true},
			-- Execution Sentence
			--BETA {spellID = 114157, filter = "CD"},
			-- Light's Hammer
			{spellID = 114158, filter = "CD"},
			-- Blinding Light
			{spellID = 115750, filter = "CD"},
			-- Holy Avenger
			{spellID = 105809, filter = "CD"},
			-- Aura Mastery
			{spellID = 31821, filter = "CD"},
			-- Blessing of Sacrifice
			{spellID = 6940, filter = "CD"},
			-- Avenging Wrath
			{spellID = 31884, filter = "CD"},
			-- Ardent Defender
			{spellID = 31850, filter = "CD", absID = true},
			-- Blessing of Protection
			{spellID = 1022, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Dispersion
			{spellID = 47585, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Infusion
			{spellID = 10060, unitID = "player", caster = "player", filter = "BUFF"},
			-- Apotheosis
			{spellID = 200183, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit of Redemption
			{spellID = 20711, unitID = "player", caster = "all", filter = "BUFF"},
			-- Divinity
			{spellID = 197030, unitID = "player", caster = "player", filter = "BUFF"},
			-- Archangel
			--BETA {spellID = 81700, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Embrace
			{spellID = 15286, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Will
			{spellID = 45242, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spectral Guise
			{spellID = 112833, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fade
			{spellID = 586, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Shell
			{spellID = 109964, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Power Word: Shield
			{spellID = 17, unitID = "player", caster = "all", filter = "BUFF"},
			-- Renew
			{spellID = 139, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Divine Insight
			--BETA {spellID = 123267, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowy Insight
			{spellID = 124430, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Light
			{spellID = 114255, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Darkness
			{spellID = 87160, unitID = "player", caster = "player", filter = "BUFF"},
			-- Serendipity
			--BETA {spellID = 63735, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mending
			--BETA {spellID = 155363, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mind Spike (Glyph)
			--BETA {spellID = 81292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Borrowed Time
			--BETA {spellID = 59889, unitID = "player", caster = "player", filter = "BUFF"},
			-- Twist of Fate
			{spellID = 123254, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evangelism
			--BETA {spellID = 81661, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Word: Insanity
			--BETA {spellID = 132573, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Now is the time! (Spell Power, Proc) [Mithril Wristwatch]
			{spellID = 127923, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Life (Haste, Proc) [Thousand-Year Pickled Egg]
			{spellID = 127915, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Dominance (Intellect, Proc)
			{spellID = 190027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Intellect]
			-- Accelerando (Haste, Proc) [Erratic Metronome]
			{spellID = 225719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nefarious Pact (Cast speed, Proc) [Whispers in the Dark]
			{spellID = 225774, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Lightning (Mastery, Proc) [Stormsinger Fulmination Charge]
			{spellID = 215632, unitID = "player", caster = "player", filter = "BUFF"},
			-- Collapsing Shadow (Agility, Use) [Obelisk of the Void]
			{spellID = 215476, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elune's Light (Agility, Use) [Moonlit Prism]
			{spellID = 215648, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Intensity (Crit, Proc) [Infernal Writ]
			{spellID = 215816, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing
			-- Constellations (Mastery, Haste, or Critical Strike, Proc) [Etraeus' Celestial Map]
			{spellID = 225136, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heightened Senses (Haste and Intellect, Proc) [Heightened Senses]
			{spellID = 221752, unitID = "player", caster = "player", filter = "BUFF"},
			-- Phased Webbing (Mastery, Proc) [Thrumming Gossamer]
			{spellID = 215198, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solemnity (Haste, Proc) [Flask of the Solemn Night]
			{spellID = 224347, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Void Tendrils
			{spellID = 114404, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind Blast (Glyph)
			--BETA {spellID = 87194, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Saving Grace
			--BETA {spellID = 155274, unitID = "player", caster = "player", filter = "DEBUFF"},

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
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Renew
			{spellID = 139, unitID = "target", caster = "player", filter = "BUFF"},
			-- Prayer of Mending
			{spellID = 41635, unitID = "target", caster = "player", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "player", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "player", filter = "BUFF"},
			-- Void Entropy
			{spellID = 155361, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vampiric Touch
			{spellID = 34914, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shadow Word: Pain
			{spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Devouring Plague
			--BETA {spellID = 2944, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {"LEFT", PVE_PVP_CC_Anchor},

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
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Purify
			{spellID = 527, filter = "CD"},
			-- Mass Dispel
			{spellID = 32375, filter = "CD"},
			-- Penance
			{spellID = 47540, filter = "CD"},
			-- Mind Blast
			{spellID = 8092, filter = "CD"},
			-- Power Word: Shield
			{spellID = 17, filter = "CD"},
			-- Holy Fire
			{spellID = 14914, filter = "CD"},
			-- Shadow Word: Death
			{spellID = 32379, filter = "CD"},
			-- Circle of Healing
			{spellID = 204883, filter = "CD"},
			-- Angelic Feather
			{spellID = 121536, filter = "CD"},
			-- Prayer of Mending
			{spellID = 33076, filter = "CD"},
			-- Divine Star
			{spellID = 110744, filter = "CD"},
			-- Cascade
			--BETA {spellID = 121135, filter = "CD"},
			-- Archangel
			--BETA {spellID = 81700, filter = "CD"},
			-- Holy Word: Sanctify
			{spellID = 34861, filter = "CD"},
			-- Holy Word: Chastise
			{spellID = 88625, filter = "CD"},
			-- Holy Word: Serenity
			{spellID = 2050, filter = "CD"},
			-- Spectral Guise
			{spellID = 112833, filter = "CD"},
			-- Fade
			{spellID = 586, filter = "CD"},
			-- Void Tendrils
			--BETA {spellID = 108920, filter = "CD"},
			-- Halo
			{spellID = 120517, filter = "CD"},
			-- Psychic Scream
			{spellID = 8122, filter = "CD"},
			-- Psychic Horror
			{spellID = 64044, filter = "CD"},
			-- Silence
			{spellID = 15487, filter = "CD"},
			-- Leap of Faith
			{spellID = 73325, filter = "CD"},
			-- Power Infusion
			{spellID = 10060, filter = "CD"},
			-- Dispersion
			{spellID = 47585, filter = "CD"},
			-- Desperate Prayer
			{spellID = 19236, filter = "CD"},
			-- Shining Force
			{spellID = 204263, filter = "CD"},
			-- Pain Suppression
			{spellID = 33206, filter = "CD"},
			-- Guardian Spirit
			{spellID = 47788, filter = "CD"},
			-- Power Word: Barrier
			{spellID = 62618, filter = "CD"},
			-- Apotheosis
			{spellID = 200183, filter = "CD"},
			-- Shadowfiend
			{spellID = 34433, filter = "CD"},
			-- Void Eruption
			{spellID = 228260, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Slice and Dice
			{spellID = 5171, unitID = "player", caster = "player", filter = "BUFF"},
			-- Adrenaline Rush
			{spellID = 13750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "player", caster = "player", filter = "BUFF"},
			-- Envenom
			{spellID = 32645, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 185313, unitID = "player", caster = "player", filter = "BUFF"},
			-- Symbols of Death
			{spellID = 212283, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Blades
			{spellID = 121471, unitID = "player", caster = "player", filter = "BUFF"},
			-- Curse of the Dreadblades
			{spellID = 208245, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Alacrity
			{spellID = 193539, unitID = "player", caster = "player", filter = "BUFF"},
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
			-- Shadow Reflection
			{spellID = 152151, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blade Flurry
			{spellID = 13877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burst of Speed
			{spellID = 108212, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sprint
			{spellID = 2983, unitID = "player", caster = "player", filter = "BUFF"},
			-- Feint
			{spellID = 1966, unitID = "player", caster = "player", filter = "BUFF"},
			-- Subterfuge
			{spellID = 115192, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Anticipation
			--BETA {spellID = 115189, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shallow Insight
			--BETA {spellID = 84745, unitID = "player", caster = "player", filter = "BUFF"},
			-- Moderate Insight
			--BETA {spellID = 84746, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Insight
			--BETA {spellID = 84747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blindside
			--BETA {spellID = 121153, unitID = "player", caster = "player", filter = "BUFF"},

			-- Jolly Roger
			{spellID = 199603, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grand Melee
			{spellID = 193358, unitID = "player", caster = "player", filter = "BUFF"},
			-- True Bearing
			{spellID = 193359, unitID = "player", caster = "player", filter = "BUFF"},
			-- Buried Treasure
			{spellID = 199600, unitID = "player", caster = "player", filter = "BUFF"},
			-- Broadsides
			{spellID = 193356, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shark Infested Waters
			{spellID = 193357, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Deathly Shadows (T18)
			{spellID = 188700, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Conquest (Agility, Proc)
			{spellID = 190026, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Agility]
			-- Blood Frenzy (Haste, Proc) [Bloodthirsty Instinct]
			{spellID = 221796, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Rupture
			{spellID = 1943, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Garrote
			{spellID = 703, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hemorrhage
			{spellID = 16511, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Find Weakness
			{spellID = 91021, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Vendetta
			{spellID = 79140, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Nightblade
			{spellID = 195452, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Ghostly Strike
			{spellID = 196937, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Deadly Poison
			{spellID = 2818, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {"LEFT", PVE_PVP_CC_Anchor},

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
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

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
			--BETA {spellID = 14183, filter = "CD"},
			-- Death from Above
			{spellID = 152150, filter = "CD"},
			-- Sprint
			{spellID = 2983, filter = "CD"},
			-- Shadow Dance
			{spellID = 185313, filter = "CD"},
			-- Marked for Death
			{spellID = 137619, filter = "CD"},
			-- Killing Spree
			{spellID = 51690, filter = "CD"},
			-- Vendetta
			{spellID = 79140, filter = "CD"},
			-- Shadow Reflection
			{spellID = 152151, filter = "CD"},
			-- Combat Readiness
			{spellID = 74001, filter = "CD"},
			-- Vanish
			{spellID = 1856, filter = "CD"},
			-- Adrenaline Rush
			{spellID = 13750, filter = "CD"},
			-- Between the Eyes
			{spellID = 199804, filter = "CD"},
			-- Riposte
			{spellID = 199754, filter = "CD"},
			-- Cloak of Shadows
			{spellID = 31224, filter = "CD"},
			-- Grappling Hook
			{spellID = 195457, filter = "CD"},
			-- Crimson Vial
			{spellID = 185311, filter = "CD"},
			-- Cannonball Barrage
			{spellID = 185767, filter = "CD"},
			-- Garrote
			{spellID = 703, filter = "CD"},
			-- Exsanguinate
			{spellID = 200806, filter = "CD"},
			-- Shadowstep
			{spellID = 36554, filter = "CD"},
			-- Evasion
			{spellID = 5277, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Maelstorm Weapon
			--BETA {spellID = 53817, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Shield
			--BETA {spellID = 324, unitID = "player", caster = "player", filter = "BUFF", spec = 1, count = 10},
			-- Shamanistic Rage
			--BETA {spellID = 30823, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Mastery
			{spellID = 16166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance
			{spellID = 114049, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Flame
			--BETA {spellID = 73683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unleash Life
			{spellID = 73685, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature Guardian
			--BETA {spellID = 31616, unitID = "player", caster = "player", filter = "BUFF"},
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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Lava Surge
			{spellID = 77762, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Blast
			{spellID = 118522, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tidal Waves
			{spellID = 53390, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Fusion
			--BETA {spellID = 157174, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Agility
			{spellID = 60233, unitID = "player", caster = "player", filter = "BUFF"},
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- Now is the time! (Spell Power, Proc) [Mithril Wristwatch]
			{spellID = 127923, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Life (Haste, Proc) [Thousand-Year Pickled Egg]
			{spellID = 127915, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Dominance (Intellect, Proc)
			{spellID = 190027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Conquest (Agility, Proc)
			{spellID = 190026, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Agility]
			-- Blood Frenzy (Haste, Proc) [Bloodthirsty Instinct]
			{spellID = 221796, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Intellect]
			-- Accelerando (Haste, Proc) [Erratic Metronome]
			{spellID = 225719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nefarious Pact (Cast speed, Proc) [Whispers in the Dark]
			{spellID = 225774, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Lightning (Mastery, Proc) [Stormsinger Fulmination Charge]
			{spellID = 215632, unitID = "player", caster = "player", filter = "BUFF"},
			-- Collapsing Shadow (Agility, Use) [Obelisk of the Void]
			{spellID = 215476, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elune's Light (Agility, Use) [Moonlit Prism]
			{spellID = 215648, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Intensity (Crit, Proc) [Infernal Writ]
			{spellID = 215816, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing
			-- Constellations (Mastery, Haste, or Critical Strike, Proc) [Etraeus' Celestial Map]
			{spellID = 225136, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heightened Senses (Haste and Intellect, Proc) [Heightened Senses]
			{spellID = 221752, unitID = "player", caster = "player", filter = "BUFF"},
			-- Phased Webbing (Mastery, Proc) [Thrumming Gossamer]
			{spellID = 215198, unitID = "player", caster = "player", filter = "BUFF"},
			-- Solemnity (Haste, Proc) [Flask of the Solemn Night]
			{spellID = 224347, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Stormstrike
			{spellID = 17364, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Flame Shock
			{spellID = 188389, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 196840, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Earthgrab
			{spellID = 64695, unitID = "target", caster = "player", filter = "DEBUFF"},

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
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Earth Shield
			--BETA {spellID = 974, unitID = "target", caster = "player", filter = "BUFF"},
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
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Hex
			{spellID = 51514, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Cleanse Spirit
			{spellID = 51886, filter = "CD"},
			-- Wind Shear
			{spellID = 57994, filter = "CD"},
			-- Hex
			{spellID = 51514, filter = "CD"},
			-- Riptide
			{spellID = 61295, filter = "CD"},
			-- Lava Burst
			{spellID = 51505, filter = "CD"},
			-- Healing Rain
			{spellID = 73920, filter = "CD"},
			-- Elemental Blast
			{spellID = 117014, filter = "CD"},
			-- Stormstrike
			{spellID = 17364, filter = "CD"},
			-- Cloudburst Totem
			{spellID = 157153, filter = "CD"},
			-- Thunderstorm
			{spellID = 51490, filter = "CD"},
			-- Earthbind Totem
			{spellID = 2484, filter = "CD"},
			-- Tremor Totem
			--BETA {spellID = 8143, filter = "CD"},
			-- Shamanistic Rage
			--BETA {spellID = 30823, filter = "CD"},
			-- Stone Bulwark Totem
			{spellID = 108270, filter = "CD"},
			-- Astral Shift
			{spellID = 108271, filter = "CD"},
			-- Ancestral Swiftness
			--BETA {spellID = 16188, filter = "CD"},
			-- Feral Spirit
			{spellID = 51533, filter = "CD"},
			-- Spiritwalker's Grace
			{spellID = 79206, filter = "CD"},
			-- Ancestral Guidance
			{spellID = 108281, filter = "CD"},
			-- Ascendance
			{spellID = 114049, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Dark Bargain
			--BETA {spellID = 110913, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Knowledge
			--BETA {spellID = 113861, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Misery
			--BETA {spellID = 113860, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Soul: Instability
			--BETA {spellID = 113858, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Harvest
			{spellID = 196098, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mana Tap
			{spellID = 196104, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Swap
			{spellID = 86211, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kiljaeden's Cunning
			--BETA {spellID = 137587, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Regeneration
			{spellID = 108359, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blood Horror
			--BETA {spellID = 111397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire and Brimstone
			--BETA {spellID = 108683, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Rush
			{spellID = 111400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sacrificial Pact
			{spellID = 108416, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healthstone
			{spellID = 6262, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Molten Core
			--BETA {spellID = 122355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Backdraft
			{spellID = 117828, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grimore of Synergy
			{spellID = 171982, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Intellect
			{spellID = 60234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Now is the time! (Spell Power, Proc) [Mithril Wristwatch]
			{spellID = 127923, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Dominance (Intellect, Proc)
			{spellID = 190027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Intellect]
			-- Accelerando (Haste, Proc) [Erratic Metronome]
			{spellID = 225719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nefarious Pact (Cast speed, Proc) [Whispers in the Dark]
			{spellID = 225774, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Lightning (Mastery, Proc) [Stormsinger Fulmination Charge]
			{spellID = 215632, unitID = "player", caster = "player", filter = "BUFF"},
			-- Collapsing Shadow (Agility, Use) [Obelisk of the Void]
			{spellID = 215476, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elune's Light (Agility, Use) [Moonlit Prism]
			{spellID = 215648, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Intensity (Crit, Proc) [Infernal Writ]
			{spellID = 215816, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

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
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Havoc
			{spellID = 80240, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Doom
			{spellID = 603, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Agony
			{spellID = 980, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Corruption
			{spellID = 146739, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seed of Corruption
			{spellID = 27243, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immolate
			{spellID = 348, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 30108, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Siphon Life
			{spellID = 63106, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Soul Effigy
			{spellID = 205178, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Phantom Singularity
			{spellID = 205179, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Haunt
			{spellID = 48181, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shadowflame
			{spellID = 205181, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Eradication
			{spellID = 196414, unitID = "target", caster = "player", filter = "DEBUFF"},
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
			Position = {"LEFT", PVE_PVP_CC_Anchor},

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
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Devour Magic (Felhunter)
			--BETA {spellID = 19505, filter = "CD"},
			-- Spell Lock (Felhunter)
			{spellID = 19647, filter = "CD"},
			-- Shadowfury
			{spellID = 30283, filter = "CD"},
			-- Howl of Terror
			{spellID = 5484, filter = "CD"},
			-- Mortal Coil
			{spellID = 6789, filter = "CD"},
			-- Demonic Circle
			{spellID = 48018, filter = "CD"},
			-- Felstorm
			{spellID = 89751, filter = "CD"},
			-- Cataclysm
			{spellID = 152108, filter = "CD"},
			-- Soul Harvest
			{spellID = 196098, filter = "CD"},
			-- Grimoire of Service
			{spellID = 108501, filter = "CD"},
			-- Shadowflame
			{spellID = 205181, filter = "CD"},
			-- Summon Darkglare
			{spellID = 205180, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Shield Wall
			{spellID = 871, unitID = "player", caster = "player", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enraged Regeneration
			--BETA {spellID = 55694, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Block
			{spellID = 2565, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Barrier
			--BETA {spellID = 112048, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ravager
			{spellID = 152277, unitID = "player", caster = "player", filter = "BUFF", spec = 3},
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
			-- Shield Charge
			--BETA {spellID = 169667, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sweeping Strikes
			--BETA {spellID = 12328, unitID = "player", caster = "player", filter = "BUFF"},
			-- Victorious
			{spellID = 32216, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Sudden Death
			{spellID = 52437, unitID = "player", caster = "player", filter = "BUFF"},
			-- Raging Blow!
			{spellID = 131116, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodsurge
			--BETA {spellID = 46916, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sword and Board
			--BETA {spellID = 50227, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ultimatum
			{spellID = 122510, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meat Cleaver
			{spellID = 85739, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unyielding Strikes
			{spellID = 169686, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			--BETA {spellID = 12880, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rude Interruption
			--BETA {spellID = 86663, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Alchemy Stones
			-- Strength
			{spellID = 60229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hallow's End
			-- Drunken Evasiveness (Bonus Armor, Use) [Brawler's Statue]
			{spellID = 127967, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reflection of Torment (Attack Power, Proc) [Coren's Cold Chromium]
			{spellID = 127928, unitID = "player", caster = "player", filter = "BUFF"},
			-- PvP Trinkets
			-- Savage Fortitude (Health, Use) [Battlemaster]
			{spellID = 181706, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Victory (Strength, Proc)
			{spellID = 190025, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Adaptation (Versatility, Use)
			{spellID = 170397, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tanking
			-- Living Carapace (Damage Reduction, Use) [Animated Exoskeleton]
			{spellID = 225033, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Aura (Leech, Use) [Fang of Tichcondrius]
			{spellID = 225130, unitID = "player", caster = "player", filter = "BUFF"},
			-- Infernal Contract (Damage Reduction, Use) [Infernal Contract]
			{spellID = 225140, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sands of Time (DoT, Proc) [Royal Dagger Haft]
			{spellID = 225720, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowy Reflection (Damage Reduction, Proc) [Phantasmal Echo]
			{spellID = 222479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightmarish Ichor (Versatility, Proc) [Goblet of Nightmarish Ichor]
			{spellID = 222027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wild God's Fury (Health, Use) [Unbridled Fury]
			{spellID = 221695, unitID = "player", caster = "player", filter = "BUFF"},
			-- Darkening Soul (Damage Reduction, Proc) [Grotesque Statuette]
			{spellID = 222209, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crystalline Body (Damage Reduction, Use) [Shard of Rokmora]
			{spellID = 214366, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stance of the Mountain (Damage Reduction, Use) [Talisman of the Cragshaper]
			{spellID = 214423, unitID = "player", caster = "player", filter = "BUFF"},
			-- Warlord's Fortitude (Health and Mastery, Proc) [Parjesh's Medallion]
			{spellID = 214622, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nerubian Chitin (Armor, Proc) [Impenetrable Nerubian Husk]
			{spellID = 214494, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage [Strength]
			-- Fiery Enchant (Crit, Proc) [Entwined Elemental Foci]
			{spellID = 225726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frost Enchant (Mastery, Proc) [Entwined Elemental Foci]
			{spellID = 225729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Enchant (Haste, Proc) [Entwined Elemental Foci]
			{spellID = 225730, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Ancient's Blessing (Crit, Proc) [Nature's Call]
			{spellID = 222517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Wisp's Blessing (Mastery, Proc) [Nature's Call]
			{spellID = 222518, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cleansed Sister's Blessing (Haste, Proc) [Nature's Call]
			{spellID = 222519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Howl of Ingvar (Crit, Proc) [Memento of Angerboda]
			{spellID = 214802, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wail of Svala (Haste, Proc) [Memento of Angerboda]
			{spellID = 214803, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dirge of Angerboda (Mastery, Proc) [Memento of Angerboda]
			{spellID = 214807, unitID = "player", caster = "player", filter = "BUFF"},
			-- Down Draft (Haste, Proc) [Nightmare Egg Shell]
			{spellID = 214342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valarjar's Path (Primary stat, Use) [Horn of Valor]
			{spellID = 215956, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Mark of the Claw (Crit and Haste)
			{spellID = 190909, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mark of the Heavy Hide (Armor)
			{spellID = 228399, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Rend
			{spellID = 772, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Colossus Smash
			--BETA {spellID = 86346, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Demoralizing Shout
			{spellID = 1160, unitID = "target", caster = "all", filter = "DEBUFF"},

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
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

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
			--BETA {spellID = 86346, filter = "CD"},
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
			-- Enraged Regeneration
			--BETA {spellID = 55694, filter = "CD"},
			-- Ravager
			{spellID = 152277, filter = "CD"},
			-- Intimidating Shout
			{spellID = 5246, filter = "CD"},
			-- Last Stand
			{spellID = 12975, filter = "CD"},
			-- Rallying Cry
			{spellID = 97462, filter = "CD"},
			-- Shield Wall
			{spellID = 871, filter = "CD"},
			-- Honorable Medallion
			{spellID = 195710, filter = "CD"},

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
			IconSize = C.filger.buffs_size,
			Position = {"TOP", SPECIAL_P_BUFF_ICON_Anchor},

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

			-- Potions: Legion
			-- Potion of Prolonged Power
			{spellID = 229206, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potion of the Old War
			{spellID = 188028, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potion of Deadly Grace
			{spellID = 188027, unitID = "player", caster = "player", filter = "BUFF"},
			-- Leytorrent Potion
			{spellID = 188030, unitID = "player", caster = "player", filter = "BUFF"},
			-- Skaggldrynk
			{spellID = 188023, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unbending Potion
			{spellID = 188029, unitID = "player", caster = "player", filter = "BUFF"},
			-- Potions: Miscellaneous
			-- Skystep Potion
			{spellID = 188024, unitID = "player", caster = "player", filter = "BUFF"},
			-- Invisibility Potion
			{spellID = 11392, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Darkwater Potion
			{spellID = 105707, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Draenic Invisibility Potion
			{spellID = 175833, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Draenic Swiftness Potion
			{spellID = 175790, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Speed [Swiftness Potion]
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

			-- Legendary Rings
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

			-- Damage Reduction
			-- Life Cocoon
			{spellID = 116849, unitID = "player", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "player", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "player", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "player", caster = "all", filter = "BUFF"},
			-- Aura Mastery
			{spellID = 31821, unitID = "player", caster = "all", filter = "BUFF"},
			-- Blessing of Protection
			{spellID = 1022, unitID = "player", caster = "all", filter = "BUFF"},
			-- Blessing of Sacrifice
			{spellID = 6940, unitID = "player", caster = "all", filter = "BUFF"},
			-- Blessing of Spellwarding
			{spellID = 204018, unitID = "player", caster = "all", filter = "BUFF"},
			-- Vigilance
			{spellID = 114030, unitID = "player", caster = "all", filter = "BUFF"},
			-- Rallying Cry
			{spellID = 97463, unitID = "player", caster = "all", filter = "BUFF"},

			-- Other
			-- Symbol of Hope
			{spellID = 64901, unitID = "player", caster = "all", filter = "BUFF"},
			-- Fear Ward
			--BETA {spellID = 6346, unitID = "player", caster = "all", filter = "BUFF"},
			-- Grounding Totem
			{spellID = 8178, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "player", caster = "all", filter = "BUFF"},
			-- Tiger's Lust
			{spellID = 116841, unitID = "player", caster = "all", filter = "BUFF"},
			-- Body and Soul
			{spellID = 65081, unitID = "player", caster = "all", filter = "BUFF"},
			-- Angelic Feather
			{spellID = 121557, unitID = "player", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "player", caster = "all", filter = "BUFF"},
			-- Blessing of Freedom
			{spellID = 1044, unitID = "player", caster = "all", filter = "BUFF"},
			-- Tricks of the Trade
			{spellID = 57934, unitID = "player", caster = "all", filter = "BUFF"},
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
			IconSize = C.filger.pvp_size,
			Position = {"TOP", PVE_PVP_DEBUFF_Anchor},

			-- Crowd Controls
			-- Death Knight
			-- Asphyxiate
			{spellID = 108194, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Monstrous Blow (Mutated Ghoul)
			{spellID = 91797, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gnaw (Ghoul)
			{spellID = 91800, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Druid
			-- Cyclone
			{spellID = 33786, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Incapacitating Roar
			{spellID = 99, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Rake
			{spellID = 163505, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Hunter
			-- Freezing Trap
			{spellID = 3355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Binding Shot
			{spellID = 117526, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Polymorph
			{spellID = 118, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Deep Freeze
			--BETA {spellID = 44572, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Monk
			-- Paralysis
			{spellID = 115078, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Leg Sweep
			{spellID = 119381, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Charging Ox Wave
			--BETA {spellID = 119392, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fists of Fury
			{spellID = 120086, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Repentance
			{spellID = 20066, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blinding Light
			{spellID = 105421, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Priest
			-- Dominate Mind
			{spellID = 605, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Sin and Punishment
			{spellID = 87204, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Sap
			{spellID = 6770, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Between the Eyes
			{spellID = 199804, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Hex
			{spellID = 51514, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Fear
			{spellID = 118699, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blood Horror
			--BETA {spellID = 137143, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Meteor Strike (Abyssal)
			{spellID = 171156, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Warrior
			-- Intimidating Shout
			{spellID = 5246, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Storm Bolt
			{spellID = 132169, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Shockwave
			{spellID = 132168, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Racial
			-- Quaking Palm
			{spellID = 107079, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- War Stomp
			{spellID = 20549, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Silences
			-- Strangulate
			{spellID = 47476, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Solar Beam
			{spellID = 78675, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Fae Silence
			--BETA {spellID = 114238, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostjaw
			--BETA {spellID = 102051, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield
			{spellID = 31935, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Garrote
			{spellID = 1330, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Arcane Torrent
			{spellID = 28730, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Roots
			-- Chains of Ice
			{spellID = 45524, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mass Entanglement
			{spellID = 102359, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Immobilized
			{spellID = 45334, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 135373, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Narrow Escape
			{spellID = 136634, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostbite
			{spellID = 198121, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Nova
			{spellID = 122, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ice Nova
			{spellID = 157997, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Freeze (Water Elemental)
			{spellID = 33395, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Disable
			{spellID = 116706, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Blast (Glyph)
			--BETA {spellID = 87194, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Void Tendril's Grasp
			{spellID = 114404, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frozen Power
			--BETA {spellID = 63685, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthgrab
			{spellID = 64695, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Debilitate (Terrorguard)
			{spellID = 170996, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Staggering Shout
			{spellID = 107566, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Slows
			-- Chilblains
			--BETA {spellID = 50435, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Infected Wounds
			{spellID = 58180, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Typhoon
			{spellID = 61391, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Freezing Trap (Glyph)
			--BETA {spellID = 61394, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussive Shot
			{spellID = 5116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Breath (Chimaera)
			{spellID = 54644, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ice Trap
			{spellID = 135299, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frozen Ammo
			{spellID = 162546, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Warp Time (Warp Stalker)
			{spellID = 35346, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ankle Crack (Crocolisk)
			{spellID = 50433, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Blast Wave
			{spellID = 157981, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cone of Cold
			{spellID = 120, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Flurry
			{spellID = 228354, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostbolt
			{spellID = 116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frostfire Bolt
			{spellID = 44614, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chilled
			{spellID = 7321, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dazing Shield (Glyph)
			--BETA {spellID = 63529, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seal of Justice
			--BETA {spellID = 20170, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind Flay
			{spellID = 15407, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Deadly Throw
			{spellID = 26679, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Crippling Poison
			{spellID = 3409, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthbind
			{spellID = 3600, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthquake
			{spellID = 77505, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 196840, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Thunderstorm
			{spellID = 51490, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cripple (Doomguard)
			{spellID = 170995, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Conflagrate
			{spellID = 17962, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hamstring
			{spellID = 1715, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Piercing Howl
			{spellID = 12323, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Warbringer
			{spellID = 7922, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Other
			-- Dark Simulacrum
			{spellID = 77606, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shroud of Purgatory
			{spellID = 116888, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Cauterize
			{spellID = 87023, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Touch of Karma
			{spellID = 125174, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Denounce
			--BETA {spellID = 2812, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Colossus Smash
			--BETA {spellID = 86346, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Rocket Fuel Leak
			{spellID = 94794, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Uncontained Fel (Demon Hunter Last Resort Talent)
			{spellID = 209261, unitID = "player", caster = "player", filter = "DEBUFF"},

			-- Raids: Legion
			-- The Emerald Nightmare
			-- Nythendra
			-- Infested (dot, stacks)
			{spellID = 204504, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Rot (AoE people around you)
			{spellID = 203096, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Il'gynoth, Heart of Corruption
			-- Fixate (fixate)
			{spellID = 210099, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Spew Corruption (dot, drops pools)
			{spellID = 208929, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cursed Blood (dot, weak bomb)
			{spellID = 215128, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Erethe Renferal
			-- Raking Talons (tank debuff, stacks)
			{spellID = 215582, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wind Burn (debuff, stacks)
			{spellID = 218519, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Web of Pain (linked with another player)
			{spellID = 215307, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Necrotic Venom (dot)
			{spellID = 215449, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Necrotic Venom (dot, drops pools)
			{spellID = 215460, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Twisting Shadows (dot)
			{spellID = 210850, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shimmering Feather (buff)
			{spellID = 212993, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Ursoc
			-- Focused Gaze (fixate)
			{spellID = 198006, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Momentum (debuff)
			{spellID = 198108, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dragons of Nightmare
			-- Nightmare Bloom (standing in, should be at least 1 player)
			{spellID = 207681, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Defiled Vines (root, magic)
			{spellID = 203770, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Volatile Infection (AoE dot)
			{spellID = 203787, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Shadow Burst (dot, stacks)
			{spellID = 204044, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cenarius
			-- Creeping Nightmares (dot, stacks)
			{spellID = 210279, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Nightmare Javelin (dot)
			{spellID = 211507, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Nightmare Brambles (dot, root, magic)
			{spellID = 210315, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Scorned Touch (spreading dot, slow)
			{spellID = 211471, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Replenishing Roots
			{spellID = 211612, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Xavius
			-- Nightmare Blades (fixate)
			{spellID = 211802, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Dream Simulacrum (buff)
			{spellID = 206005, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Tormenting Fixation
			{spellID = 205771, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Corruption Meteor
			{spellID = 224508, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Bonds of Terror (linked with another player)
			{spellID = 210451, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Corruption: Descent into Madness (buff before mind control)
			{spellID = 208431, unitID = "player", caster = "all", filter = "DEBUFF"},

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
		},
		{
			Name = "T_BUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.pvp_size,
			Position = {"TOP", T_BUFF_Anchor},

			-- Death Knight
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
			-- Death's Advance
			--BETA {spellID = 96268, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Asphyxiate
			{spellID = 108194, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Gnaw (Ghoul)
			{spellID = 91800, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Monstrous Blow (Mutated Ghoul)
			{spellID = 91797, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Strangulate
			{spellID = 47476, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Demon Hunter
			-- Metamorphosis
			{spellID = 162264, unitID = "target", caster = "all", filter = "BUFF", absID = true},
			-- Spectral Sight
			{spellID = 188501, unitID = "target", caster = "all", filter = "BUFF"},
			-- Netherwalk
			{spellID = 196555, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nether Bond
			{spellID = 207810, unitID = "target", caster = "all", filter = "BUFF"},
			-- Soul Barrier
			{spellID = 227225, unitID = "target", caster = "all", filter = "BUFF"},

			-- Druid
			-- Survival Instincts
			{spellID = 61336, unitID = "target", caster = "all", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 170856, unitID = "target", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "target", caster = "all", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserk
			--BETA {spellID = 50334, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cyclone
			{spellID = 33786, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rake
			{spellID = 163505, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Maim
			{spellID = 22570, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Incapacitating Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Solar Beam
			{spellID = 78675, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fae Silence
			--BETA {spellID = 114238, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Hunter
			-- Aspect of the Turtle
			{spellID = 186265, unitID = "target", caster = "all", filter = "BUFF"},
			-- Deterrence
			{spellID = 19263, unitID = "target", caster = "all", filter = "BUFF"},
			-- Feign Death
			{spellID = 5384, unitID = "target", caster = "all", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Freezing Trap
			{spellID = 3355, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Binding Shot
			{spellID = 117526, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Ice Block
			{spellID = 45438, unitID = "target", caster = "all", filter = "BUFF"},
			-- Invisibility
			{spellID = 66, unitID = "target", caster = "all", filter = "BUFF"},
			-- Greater Invisibility
			{spellID = 113862, unitID = "target", caster = "all", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 115610, unitID = "target", caster = "all", filter = "BUFF"},
			-- Alter Time
			{spellID = 110909, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evanesce
			{spellID = 157913, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cauterize
			{spellID = 87023, unitID = "target", caster = "target", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Deep Freeze
			--BETA {spellID = 44572, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frostjaw
			--BETA {spellID = 102051, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Monk
			-- Diffuse Magic
			{spellID = 122783, unitID = "target", caster = "all", filter = "BUFF"},
			-- Touch of Karma
			{spellID = 125174, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ring of Peace
			{spellID = 116844, unitID = "target", caster = "all", filter = "BUFF"},
			-- Dampen Harm
			{spellID = 122278, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nimble Brew
			--BETA {spellID = 137562, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Paralysis
			{spellID = 115078, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Leg Sweep
			{spellID = 119381, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fists of Fury
			{spellID = 120086, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Charging Ox Wave
			--BETA {spellID = 119392, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Divine Shield
			{spellID = 642, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86659, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Protection
			{spellID = 1022, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ardent Defender
			{spellID = 31850, unitID = "target", caster = "all", filter = "BUFF"},
			-- Aura Mastery
			{spellID = 31821, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Spellwarding
			{spellID = 204018, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Sacrifice
			{spellID = 6940, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Freedom
			{spellID = 1044, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF"},
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
			-- Spectral Guise
			{spellID = 119030, unitID = "target", caster = "all", filter = "BUFF"},
			-- Phantasm
			{spellID = 114239, unitID = "target", caster = "all", filter = "BUFF"},
			-- Fear Ward
			--BETA {spellID = 6346, unitID = "target", caster = "all", filter = "BUFF"},
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
			-- Cloak of Shadows
			{spellID = 31224, unitID = "target", caster = "all", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "target", caster = "all", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 185313, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Sap
			{spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Between the Eyes
			{spellID = 199804, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote
			{spellID = 1330, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Grounding Totem
			{spellID = 8178, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shamanistic Rage
			--BETA {spellID = 30823, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Hex
			{spellID = 51514, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Blood Horror
			--BETA {spellID = 111397, unitID = "target", caster = "all", filter = "BUFF"},
			-- Dark Bargain
			--BETA {spellID = 110913, unitID = "target", caster = "all", filter = "BUFF"},
			-- Soulstone
			{spellID = 20707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Banish
			{spellID = 710, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blood Horror
			--BETA {spellID = 137143, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Meteor Strike (Abyssal)
			{spellID = 171156, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Debilitate (Terrorguard)
			{spellID = 170996, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

			-- Warrior
			-- Bladestorm
			{spellID = 46924, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "target", caster = "all", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "target", caster = "all", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Intimidating Shout
			{spellID = 5246, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Storm Bolt
			{spellID = 132169, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shockwave
			{spellID = 132168, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Gag Order
			--BETA {spellID = 18498, unitID = "target", caster = "all", filter = "DEBUFF"},

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
