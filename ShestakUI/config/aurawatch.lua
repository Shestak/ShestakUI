----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Enemy cooldown tracker(icons)
----------------------------------------------------------------------------------------
-- aCooldowns [spell ID] = time
if SettingsCF["cooldown"].enemy_enable == true then
	SettingsDB.enemy_spells = {
		[1766] = 10,	-- Kick
		[6552] = 10,	-- Pummel
		[2139] = 24,	-- Counterspell
		[19647] = 24,	-- Spell Lock
		[8122] = 30,	-- Psychic Scream
		[47476] = 120,	-- Strangulate
		[47528] = 10,	-- Mind Freeze
		[29166] = 180,	-- Innervate
		[49039] = 120,	-- Lichborne
		[54428] = 120,	-- Divine Plea
		[1022] = 300,	-- Hand of Protection
		[16190] = 180,	-- Mana Tide Totem
		[51514] = 45,	-- Hex
		[15487] = 45,	-- Silence
		[2094] = 180,	-- Blind
		[72] = 12,		-- Shield Bash
		[33206] = 180,	-- Pain Suppression
		[34490] = 20,	-- Silencing Shot
		[1499] = 30,	-- Freezing Trap
		[16979] = 15,	-- Feral Charge - Bear
		[49376] = 30,	-- Feral Charge - Cat
		[85285] = 10,	-- Rebuke
	}
end

----------------------------------------------------------------------------------------
--	Raid cooldown tracker(bars)
----------------------------------------------------------------------------------------
-- aCooldowns [spell ID] = time
if SettingsCF["cooldown"].raid_enable == true then
	SettingsDB.raid_spells = {
		[20484] = 1800,	-- Rebirth
		[6203] = 1800,	-- Soulstone
		[6346] = 180,	-- Fear Ward
		[29166] = 180,	-- Innervate
		[32182] = 300,	-- Heroism
		[2825] = 300,	-- Bloodlust
	}
end

----------------------------------------------------------------------------------------
--	Player Buff reminder
----------------------------------------------------------------------------------------
if SettingsCF["reminder"].solo_buffs_enable == true then
	SettingsDB.buffs_reminder = {
		PRIEST = {
			588,	-- Inner Fire
			73413,	-- Inner Will
		},
		HUNTER = {
			13165,	-- Aspect of the Hawk
			20043,	-- Aspect of the Wild
			82661,	-- Aspect of the Fox
		},
		MAGE = {
			30482,	-- Molten Armor
			7302,	-- Frost Armor
			6117,	-- Mage Armor
		},
		WARLOCK = {
			28176,	-- Fel Armor
			687,	-- Demon Armor
		},
		PALADIN = {
			31801,	-- Seal of Truth
			20154,	-- Seal of Righteousness
			85126,	-- Seal of Command
			20164,	-- Seal of Justice
			20165,	-- Seal of Insight
		},
		SHAMAN = {
			52127,	-- Water Shield
			324,	-- Lightning Shield
			974,	-- Earth Shield
		},
		WARRIOR = {
			469,	-- Commanding Shout
			6673,	-- Battle Shout
		},
		DEATHKNIGHT = {
			57330,	-- Horn of Winter
			31634,	-- Shaman Strength of Earth Totem
		},
		DRUID = {
			1126,	-- Mark of the Wild
			20217,	-- Blessing of Kings
		},
	}
end

----------------------------------------------------------------------------------------
--	Raid Buff reminder
----------------------------------------------------------------------------------------
if SettingsCF["reminder"].raid_buffs_enable == true then
	SettingsDB.raid_buffs_reminder = {
		Flask = {
			67016,	-- Flask of the North-ING
			67017,	-- Flask of the North-AGI
			67018,	-- Flask of the North-STR
			53758,	-- Flask of Stoneblood
			53755,	-- Flask of the Frost Wyrm
			54212,	-- Flask of Pure Mojo
			53760,	-- Flask of Endless Rage
			17627,	-- Flask of Distilled Wisdom
		},
		BattleElixir = {
			33721,	-- Spellpower Elixir
			53746,	-- Wrath Elixir
			28497,	-- Elixir of Mighty Agility
			53748,	-- Elixir of Mighty Strength
			60346,	-- Elixir of Lightning Speed
			60344,	-- Elixir of Expertise
			60341,	-- Elixir of Deadly Strikes
			60345,	-- Elixir of Armor Piercing
			60340,	-- Elixir of Accuracy
			53749,	-- Guru's Elixir
		},
		GuardianElixir = {
			60343,	-- Elixir of Mighty Defense
			53751,	-- Elixir of Mighty Fortitude
			53764,	-- Elixir of Mighty Mageblood
			60347,	-- Elixir of Mighty Thoughts
			53763,	-- Elixir of Protection
			53747,	-- Elixir of Spirit
		},
		Food = {
			57325,	-- 80 AP
			57327,	-- 46 SP
			57329,	-- 40 CS
			57332,	-- 40 Haste
			57334,	-- 20 MP5
			57356,	-- 40 EXP
			57360,	-- 40 Hit
			57365,	-- 40 Spirit
			57367,	-- 40 AGI
			57371,	-- 40 STR
			59230,	-- 40 DODGE
			57399,	-- 80AP, 46SP (fish feast)
			57363,	-- Track Humanoids
			57373,	-- Track Beasts
			65247,	-- Pet 40 STR
		},
	}
end


----------------------------------------------------------------------------------------
--	AuraWatch
----------------------------------------------------------------------------------------
-- Healer Layout {spell ID, position, {r, g, b, a}, anyUnit}
if SettingsCF["unitframe"].plugins_aura_watch == true then
	do
		-- Class buffs
		SettingsDB.buffids = {
			PRIEST = {
				{6788, "TOPRIGHT", {1, 0, 0}, true},			-- Weakened Soul
				{33076, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},		-- Prayer of Mending
				{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 			-- Renew
				{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},		-- Power Word: Shield
				{10060, "RIGHT", {0.89, 0.1, 0.1}},				-- Power Infusion
				{33206, "LEFT", {0.89, 0.1, 0.1}, true},		-- Pain Suppress
				{47788, "LEFT", {0.86, 0.52, 0}, true},			-- Hand of Freedom
			},
			DRUID = {
				{774, "TOPRIGHT", {0.8, 0.4, 0.8}},				-- Rejuvenation
				{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},			-- Regrowth
				{94447, "TOPLEFT", {0.4, 0.8, 0.2}},			-- Lifebloom
				{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},			-- Wild Growth
			},
			PALADIN = {
				{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},			-- Beacon of Light
				{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},		-- Hand of Protection
				{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	-- Hand of Freedom
				{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},	-- Hand of Salvation
			},
			SHAMAN = {
				{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},			-- Riptide 
				{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},		-- Earth Shield
				{16236, "TOPLEFT", {0.4, 0.7, 0.2}},			-- Ancestral Fortitude
				{51945, "BOTTOMRIGHT", {0.7, 0.4, 0}},			-- Earthliving
			},
			ROGUE = {
				{57933, "TOPRIGHT", {0.89, 0.1, 0.1}},			-- Tricks of the Trade
			},
			DEATHKNIGHT = {
				{49016, "TOPRIGHT", {0.89, 0.89, 0.1}},			-- Unholy Frenzy
			},
			MAGE = {
				{54646, "TOPRIGHT", {0.2, 0.2, 1}},				-- Focus Magic
			},
			WARRIOR = {
				{59665, "TOPLEFT", {0.2, 0.2, 1}},				-- Vigilance
				{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},			-- Intervene
			},
			ALL = {
				{23333, "LEFT", {1, 0, 0}, true}, 				-- Warsong flag
				{34976, "LEFT", {1, 0, 0}, true}, 				-- Netherstorm Flag
				{64413, "RIGHT", {0.8, 0.2, 0}, true},			-- Protection of Ancient Kings
			},
		}
	end
	
	-- Raid debuffs
	do
		local _, ns = ...
		local ORD = ns.oUF_RaidDebuffs or oUF_RaidDebuffs

		if not ORD then return end
		
		ORD.ShowDispelableDebuff = SettingsCF["unitframe"].plugins_debuffhighlight_icon
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = false
		
		SettingsDB.debuffids = {
		-- Vault of Archavon
			-- Koralon
				67332,	-- Flaming Cinder (10)
				66684,	-- Flaming Cinder (25)
			-- Toravon the Ice Watcher
				72004,72098,72120,72121,	-- Frostbite
			-- Toravon the Ice Watcher
				72004,72098,72120,72121,	-- Frostbite
		-- Naxxramas
			-- Trash
				55314,	-- Strangulate
			-- Anub'Rekhan
				28786, 54022,	-- Locust Swarm (N, H)
			-- Grand Widow Faerlina
				28796, 54098,	-- Poison Bolt Volley (N, H)
				28794, 54099,	-- Rain of Fire (N, H)
			-- Maexxna
				28622,	-- Web Wrap (NH)
				54121, 28776,	-- Necrotic Poison (N, H)
			-- Noth the Plaguebringer
				29213, 54835,	-- Curse of the Plaguebringer (N, H)
				29214, 54836,	-- Wrath of the Plaguebringer (N, H)
				29212,	-- Cripple (NH)
			-- Heigan the Unclean
				29998, 55011,	-- Decrepit Fever (N, H)
				29310,	-- Spell Disruption (NH)
			-- Grobbulus
				28169,	-- Mutating Injection (NH)
			-- Gluth
				54378,	-- Mortal Wound (NH)
				29306,	-- Infected Wound (NH)
			-- Thaddius
				28084, 28085,	-- Negative Charge (N, H)
				28059, 28062,	-- Positive Charge (N, H)
			-- Instructor Razuvious
				55550,	-- Jagged Knife (NH)
			-- Sapphiron
				28522,	-- Icebolt (NH)
				28542, 55665,	-- Life Drain (N, H)
			-- Kel'Thuzad
				28410,	-- Chains of Kel'Thuzad (H)
				27819,	-- Detonate Mana (NH)
				27808,	-- Frost Blast (NH)
		-- The Eye of Eternity
			-- Malygos
				56272, 60072,	-- Arcane Breath (N, H)
				57407, 60936,	-- Surge of Power (N, H)
		-- The Obsidian Sanctum
			-- Trash
				39647,	-- Curse of Mending
				58936,	-- Rain of Fire
			-- Sartharion
				60708,	-- Fade Armor (N, H)
				57491,	-- Flame Tsunami (N, H)
		-- Ulduar
			-- Trash
				62310, 62928,	-- Impale (N, H)
				63612, 63673,	-- Lightning Brand (N, H)
				63615,			-- Ravage Armor (NH)
				62283, 62438,	-- Iron Roots (N, H)
				63169, 63549,	-- Petrify Joints (N, H)
			-- Razorscale
				64771,	--Fuse Armor (NH)
			-- Ignis the Furnace Master
				62548, 63476,	-- Scorch (N, H)
				62680, 63472,	-- Flame Jet (N, H)
				62717, 63477,	-- Slag Pot (N, H)
			-- XT-002
				63024, 64234,	-- Gravity Bomb (N, H)
				63018, 65121,	-- Light Bomb (N, H)
			-- The Assembly of Iron
				61888, 64637,	-- Overwhelming Power (N, H)
				62269, 63490,	-- Rune of Death (N, H)
				61903, 63493,	-- Fusion Punch (N, H)
				61912, 63494,	-- Static Disruption(N, H)
			-- Kologarn
				64290, 64292,	-- Stone Grip (N, H)
				63355, 64002,	-- Crunch Armor (N, H)
				62055,	-- Brittle Skin (NH)
			-- Hodir
				62469,	-- Freeze (NH)
				61969, 61990,	-- Flash Freeze (N, H)
				62188,	-- Biting Cold (NH)
			-- Thorim
				62042,	-- Stormhammer (NH)
				62130,	-- Unbalancing Strike (NH)
				62526,	-- Rune Detonation (NH)
				62470,	-- Deafening Thunder (NH)
				62331, 62418,	-- Impale (N, H)
			-- Freya
				62532,	-- Conservator's Grip (NH)
				62589, 63571,	-- Nature's Fury (N, H)
				62861, 62930,	-- Iron Roots (N, H)
			-- Mimiron
				63666,	-- Napalm Shell (N)
				65026,	-- Napalm Shell (H)
				62997,	-- Plasma Blast (N)
				64529,	-- Plasma Blast (H)
				64668,	-- Magnetic Field (NH)
			-- General Vezax
				63276,	-- Mark of the Faceless (NH)
				63322,	-- Saronite Vapors (NH)
			-- Yogg-Saron
				63147,	-- Sara's Anger(NH)
				63134,	-- Sara's Blessing(NH)
				63138,	-- Sara's Fervor(NH)
				63830,	-- Malady of the Mind (H)
				63802,	-- Brain Link(H)
				63042,	-- Dominate Mind (H)
				64152,	-- Draining Poison (H)
				64153,	-- Black Plague (H)
				64125, 64126,	-- Squeeze (N, H)
				64156,	-- Apathy (H)
				64157,	-- Curse of Doom (H)
			-- Algalon
				64412,	-- Phase Punch
		-- Trial of the Crusader
			--Gormok the Impaler
				66331, 67477, 67478, 67479,	-- Impale(10, 25, 10H, 25H)
				66406,	-- Snobolled!
			-- Acidmaw --Dreadscale
				66819, 67609, 67610, 67611,	-- Acidic Spew (10, 25, 10H, 25H)
				66821, 67635, 67636, 67637,	-- Molten Spew (10, 25, 10H, 25H)
				66823, 67618, 67619, 67620,	-- Paralytic Toxin (10, 25, 10H, 25H)
				66869,	--Burning Bile
			-- Icehowl
				66770, 67654, 67655, 67656,	-- Ferocious Butt(10, 25, 10H, 25H)
				66689, 67650, 67651, 67652,	-- Arctic Breathe(10, 25, 10H, 25H)
				66683,	-- Massive Crash
			-- Lord Jaraxxus
				66532, 66963, 66964, 66965,	-- Fel Fireball (10, 25, 10H, 25H)
				66237, 67049, 67050, 67051,	-- Incinerate Flesh (10, 25, 10H, 25H)
				66242, 67059, 67060, 67061,	-- Burning Inferno (10, 25, 10H, 25H)
				66197, 68123, 68124, 68125,	-- Legion Flame (10, 25, 10H, 25H)
				66199, 68126, 68127, 68128,	-- Legion Flame (Patch?: 10, 25, 10H, 25H)
				66877, 67070, 67071, 67072,	-- Legion Flame (Patch Icon?: 10, 25, 10H, 25H)
				66283,	-- Spinning Pain Spike
				66209,	-- Touch of Jaraxxus(H)
				66211,	-- Curse of the Nether(H)
				66333, 66334, 66335, 66336, 68156,	-- Mistress' Kiss (10H, 25H)
			-- Faction Champions
				65812, 68154, 68155, 68156,	-- Unstable Affliction (10, 25, 10H, 25H)
				65801,	-- Polymorph
				65543,	-- Psychic Scream
				66054,	-- Hex
				65809,	-- Fear
			-- The Twin Val'kyr
				67176,	-- Dark Essence
				67223,	-- Light Essence
				67282, 67283,	-- Dark Touch
				67297, 67298,	-- Light Touch
				67309, 67310, 67311, 67312,	-- Twin Spike (10, 25, 10H, 25H)
			-- Anub'arak
				67574,	-- Pursued by Anub'arak
				66013, 67700, 68509, 68510,	-- Penetrating Cold (10, 25, 10H, 25H)
				67847, 67721,	-- Expose Weakness
				66012,	-- Freezing Slash
				67863,	-- Acid-Drenched Mandibles(25H)
		-- Icecrown Citadel
			-- Trash 
				70980,	-- Web Wrap
				69969,	-- Curse of Doom
				71089,71090,	-- Bubbling Pus
				69483,	-- Dark Reckoning
				71163,	-- Devour Humanoid
				71127,	-- Mortal Wound
				70435,71154,	-- Rend Flesh
				71103,	-- Combobulating Spray	
				70645,	-- Chains of Shadow
				70671,	-- Leeching Rot
				70432,	-- Blood Sap	
				71252,	-- Volley
				71327,	-- Web
				36922,	-- Bellowing Roar	
			-- Lord Marrowgar
				70823,	-- Coldflame
				69065,	-- Impaled
				70835,	-- Bone Storm
			-- Lady Deathwhisper
				72109,	-- Death and Decay
				71289,	-- Dominate Mind
				71204,	-- Touch of Insignificance
				67934,	-- Frost Fever
				71237,	-- Curse of Torpor
				72491, 71951, 72490, 72491, 72492,	-- Necrotic Strike
			-- Gunship Battle
				69651,	-- Wounding Strike
			-- Deathbringer Saurfang
				72293, -- Mark of the Fallen Champion
				72442, 72385, 50207, 38027, 72443, 72441,	-- Boiling Blood
				72449, 72447, 72409, 72448, 72410, 72408,	-- Rune of Blood
				72769,	-- Scent of Blood (heroic)
			-- Rotface
				69674, 71224, 73022, 73023,	-- Mutated Infection
				30494, 69774, 69776, 69778, 71208,	-- Sticky Ooze
				69508,	-- Slime Spray				
			-- Festergut
				69248, 72274,	-- Vile Gas
				71218, 72272, 72273, 73020, 73019, 69240,	-- Vile Gas
				72219, 72551, 72552, 72553,	-- Gastric Bloat
				69278, 69279, 71221,	-- Gas Spore
				69290, 71222, 73033, 73034,	-- Blighted Spore
			-- Professor Putricide
				70672,72455,72832,72833, -- Gaseous Bloat
				72549,70852,72550,72548,72297,72296,74281,72295, -- Malleable Goo
				72874,72458,72615,70853,74280,72873, -- Malleable Goo
				72454,72464,72747,72745,72746,72671,72748,72507,72506,72463,72451,72672, -- Mutated Plague
				70341, -- Slime Puddle (Spray)
				70342,70346,72869,72868, -- Slime Puddle
				70911,72854,72855,72856, -- Unbound Plague
				69774,72836,72837,72838,70447, -- Volatile Ooze Adhesive				
			-- Blood Prince Council
				71807, 72796, 72797, 72798, -- Glittering Sparks
				71911, 71822, -- Shadow Resonance
				72999, -- Shadow Prison
			-- Blood-Queen Lana'thel
				71623,71624,71625,71626,72264,72265,72266,72267, -- Delirious Slash
				70949, --Essence of the Blood Queen
				70867,70871,70872,70879,70950,71473,71525,71530,71531,71532,71533, -- Essence of the Blood Queen
				72151,72648,72650,72649, -- Frenzied Bloodthirst
				71474, 70877, -- Frenzied Bloodthirst
				71340, 71341, -- Pact of the Darkfallen
				72985, -- Swarming Shadows
				71267,71268,72635,72636,72637, -- Swarming Shadows
				71264,71265,71266,71277,72638,72639,72640,72890, -- Swarming Shadows
				70923,70924,73015, -- Uncontrollable Frenzy
				70838,71510,70837,70451,70450,70445,70821, -- Blood Mirror
			-- Valithria Dreamwalker
				70873, -- Emerald Vigor
				71941, 71940, -- Twisted Nightmares
				70744, 71733, 72017, 72018, -- Acid Burst
				70751, 71738, 72021, 72022,	-- Corrosion
				70633, 71283, 72025, 72026,	-- Gut Spray
			-- Sindragosa
				69762,	-- Unchained Magic
				70126,	-- Frost Beacon
				71665,	-- Asphyxiation
				70157,	-- Ice Tomb
				70106,	-- Chilled to the Bone
				69766,	-- Instability
				70127, 72528, 72529, 72530, -- Mystic Buffet
			-- The Lich King
				70541, 73779, 73780, 73781, -- Infest
				70337, 70338, 73785, 73786, 73787,73912,73913,73914, -- Necrotic Plague
				72133, 73788, 73789, 73790, -- Pain and Suffering
				69242, 73802, 73800, 73801, -- Soul Shriek
				73799, 69409, 69410, 73798, 73797, -- Soul Reaper
				74326, 74325, 68984, 68985, 74327,68986,68980,74296,74295,74297,73823,73654, -- Harvest Soul
				68981,	-- Remorseless Winter
		-- Ruby Sanctum
			-- Baltharus the Warborn
				74502,	-- Enervating Brand
			-- General Zarithrian
				74367,	-- Cleave Armor
			-- Saviana Ragefire
				74452,	-- Conflagration
			-- Halion
				74562,	-- Fiery Combustion
				74567,	-- Mark of Combustion (Fire)
				74792,	-- Soul Consumption
				74795,	-- Mark Of Consumption (Soul)
			-- 
				75887,	-- Blazing Aura
				74453,	-- Flame Beacon
		-- Other debuff
				5782,	-- Fear
		}
		ORD:RegisterDebuffs(SettingsDB.debuffids)
	end
end