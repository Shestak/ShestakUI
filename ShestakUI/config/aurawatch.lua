----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Enemy cooldown tracker(icons)
----------------------------------------------------------------------------------------
-- aCooldowns [spell ID] = time
if SettingsCF.cooldown.enemy_enable == true then
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
if SettingsCF.cooldown.raid_enable == true then
	SettingsDB.raid_spells = {
		[20484] = 600,	-- Rebirth
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
if SettingsCF.reminder.solo_buffs_enable == true then
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
			6673,	-- Battle Shout
			93435,	-- Roar of Courage
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
if SettingsCF.reminder.raid_buffs_enable == true then
	SettingsDB.raid_buffs_reminder = {
		Flask = {
			79637,	-- Flask of Enhancement
			92679,	-- Flask of Battle
			79469,	-- Flask of Steelskin
			79470,	-- Flask of the Draconic Mind
			79471,	-- Flask of the Winds
			79472,	-- Flask of Titanic Strength
			94160,	-- Flask of Flowing Water
		},
		BattleElixir = {
			-- Scrolls
			89343,	-- Scroll of Agility IX
			89344,	-- Scroll of Protection IX
			89347,	-- Scroll of Intellect IX
			89342,	-- Scroll of Spirit IX
			89345,	-- Scroll of Stamina IX
			89346,	-- Scroll of Strength IX
			-- Elixirs
			79635,	-- Elixir of the Master
			79632,	-- Elixir of Mighty Speed
			79481,	-- Elixir of Impossible Accuracy
			79477,	-- Elixir of the Cobra
			79474,	-- Elixir of the Naga
			79468,	-- Ghost Elixir
		},
		GuardianElixir = {
			79631,	-- Prismatic Elixir
			79480,	-- Elixir of Deep Earth
		},
		Food = {
			87635,	-- Crocolisk Au Gratin
			87545,	-- Beer-Basted Crocolisk
			87546,	-- Skewered Eel
			87547,	-- Severed Sagefish Head
			87548,	-- Delicious Sagefish Tail
			87549,	-- Lavascale Minestrone
			87550,	-- Grilled Dragon
			87551,	-- Baked Rockfish
			87552,	-- Basilisk Liverdog
			87554,	-- Mushroom Sauce Mudfish
			87555,	-- Blackbelly Sushi
			87556,	-- Hearty Seafood Soup
			87634,	-- Lavascale Fillet
			87564,	-- Lurker Lunch
			87563,	-- Broiled Mountain Trout
			87562,	-- Lightly Fried Lurker
			87561,	-- Seasoned Crab
			87560,	-- Salted Eye
			87559,	-- Whitecrest Gumbo
			87558,	-- Pickled Guppy
			87557,	-- Tender Baked Turtle
		},
	}
end

----------------------------------------------------------------------------------------
--	AuraWatch
----------------------------------------------------------------------------------------
-- Healer Layout {spell ID, position, {r, g, b, a}, anyUnit}
if SettingsCF.raidframe.plugins_aura_watch == true then
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
			HUNTER = {
				{34477, "TOPRIGHT", {0.2, 0.2, 1}},				-- Misdirection
			},
			WARLOCK = {
				{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},			-- Soulstone Resurrection
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
		
		ORD.ShowDispelableDebuff = SettingsCF.raidframe.plugins_debuffhighlight_icon
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = false
		
		SettingsDB.debuffids = {
		-- Baradin Hold
			-- Argaloth
			95173, 88954,	-- Consuming Darkness
		-- Blackwing Descent
			-- Magmaw
			78941, 91913,	-- Parasitic Infection
			91912, 89773,	-- Mangle
			-- Omintron Defense System
			79889, 91438,	-- Lightning Conductor
			79504, 91535,	-- Flamethrower
			92035, 79501,	-- Acquiring Target
			79835, 91501,	-- Poison Soaked Shell		
			91555, 79629,	-- Power Generator
			80094,			-- Fixate
			-- Maloriak
			77699, 92978,	-- Flash Freeze
			92975, 77763,	-- Biting Chill
			77786, 92971,	-- Consuming Flames
			92989, 78034,	-- Rend
			78617,			-- Fixate
			-- Atramedes
			92421, 77982,	-- Searing Flame
			78023, 92483,	-- Roaring Flame
			92407, 78100,	-- Sonic Breath
			78092,			-- Tracking
			-- Chimaeron
			82881,			-- Break
			89084,			-- Low Health
			-- Nefarian
			81114, 94073,	-- Magma
			94128, 77827,	-- Tail Lash
		-- The Bastion of Twilight
			-- Halfus Wyrmbreaker
			83710, 86169,	-- Furious Roar
			-- Valiona & Theralion
			86505, 92907,	-- Fabulous Flames
			92872, 86844,	-- Devouring Flames
			92881, 92880, 92879, 92877, 92876, 86825, 86788,	-- Blackout
			86622, 86631, 95639, 95640, 95641,					-- Engulfing Magic
			92892, 92891, 92893, 92894, 93064, 92890, 92889, 86202, 88436,	-- Twilight Shift
			88518, 86014, 92860, 92861, 92863, 92864, 92865,	-- Twilight Meteorite
			-- Twilight Ascendant Council
			82660,			-- Burning Blood
			82665,			-- Heart of Ice
			82762,			-- Waterlogged
			83099,			-- Lightning Rod
			92486, 84948,	-- Gravity Crush
			83500,			-- Swirling Winds
			83581,			-- Grounded
			92505, 82772, 92503, 92504,	-- Frozen
			-- Cho'gall
			93187,			-- Corrupted Blood
			82125,			-- Corruption: Malformation
			82170,			-- Corruption: Absolute
			93200, 81831,	-- Corruption: Sickness
			82411, 93132,	-- Debilitating Beam
			91317, 93365, 93366, 93367,	-- Worshipping
		-- Throne of the Four Winds
			-- Conclave of Wind
			-- Nezir
			86111, 93129,	-- Ice Patch
			-- Anshal
			93120, 86282,	-- Toxic Spores
			-- Rohash
			93056, 86182,	-- Slicing Gale
			-- Al'Akir
			87873,			-- Static Shock
			91020, 93258,	-- Ice Storm
			87856, 93283,	-- Squall Line
			88427,			-- Electrocute
			89666, 89668, 93293,	-- Lightning Rod
		-- Other
			5782,			-- Fear
			84853,			-- Dark Pool
			91325,			-- Shadow Vortex
		}
		ORD:RegisterDebuffs(SettingsDB.debuffids)
	end
end