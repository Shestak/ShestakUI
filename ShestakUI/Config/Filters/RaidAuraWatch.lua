local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidframe.plugins_aura_watch == true then
	do
		-- Class buffs
		T.buffids = {
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
				{23333, "LEFT", {1, 0, 0}, true}, 				-- Warsong flag, Horde
				{23335, 'LEFT', {0, 0, 1}, true},				-- Warsong flag, Alliance
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
		
		ORD.ShowDispelableDebuff = C.raidframe.plugins_debuffhighlight_icon
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = true
		
		local function SpellName(id)
			local name = select(1, GetSpellInfo(id))
			return name
		end
		
		T.debuffids = {
		-- Baradin Hold
			-- Argaloth
			SpellName(95173),	-- Consuming Darkness
		-- Blackwing Descent
			-- Magmaw
			SpellName(94679),	-- Parasitic Infection
			SpellName(94617),	-- Mangle
			SpellName(91911),	-- Constricting Chains
			-- Omintron Defense System
			SpellName(91433),	-- Lightning Conductor
			SpellName(91535),	-- Flamethrower
			SpellName(80161),	-- Chemical Cloud
			SpellName(92035),	-- Acquiring Target
			SpellName(79835),	-- Poison Soaked Shell
			SpellName(91555),	-- Power Generator
			SpellName(80094),	-- Fixate
			SpellName(91521),	-- Incineration Security Measure
			SpellName(92048),	-- Shadow Infusion
			SpellName(92053),	-- Shadow Conductor
			-- Maloriak
			SpellName(92754),	-- Engulfing Darkness
			SpellName(77699),	-- Flash Freeze
			SpellName(77760),	-- Biting Chill
			SpellName(92971),	-- Consuming Flames
			SpellName(92989),	-- Rend
			SpellName(78617),	-- Fixate
			-- Atramedes
			SpellName(92423),	-- Searing Flame
			SpellName(92485),	-- Roaring Flame
			SpellName(92407),	-- Sonic Breath
			SpellName(78092),	-- Tracking
			-- Chimaeron
			SpellName(82881),	-- Break
			SpellName(89084),	-- Low Health
			-- Nefarian
			SpellName(81114),	-- Magma
			SpellName(94128),	-- Tail Lash
			SpellName(79339),	-- Explosive Cinders
			SpellName(79318),	-- Dominion
		-- The Bastion of Twilight
			-- Halfus Wyrmbreaker
			SpellName(83710),	-- Furious Roar
			SpellName(39171),	-- Malevolent Strikes
			-- Valiona & Theralion
			SpellName(86505),	-- Fabulous Flames
			SpellName(86840),	-- Devouring Flames
			SpellName(92878),	-- Blackout
			SpellName(95639),	-- Engulfing Magic
			SpellName(93051),	-- Twilight Shift
			SpellName(92886),	-- Twilight Zone
			SpellName(88518),	-- Twilight Meteorite
			-- Twilight Ascendant Council
			SpellName(82660),	-- Burning Blood
			SpellName(82665),	-- Heart of Ice
			SpellName(82762),	-- Waterlogged
			SpellName(83099),	-- Lightning Rod
			SpellName(92488),	-- Gravity Crush
			SpellName(83500),	-- Swirling Winds
			SpellName(83581),	-- Grounded
			SpellName(92505),	-- Frozen
			SpellName(92511),	-- Hydro Lance
			SpellName(92518),	-- Flame Torrent
			SpellName(92075),	-- Gravity Core
			-- Cho'gall
			SpellName(93187),	-- Corrupted Blood
			SpellName(82125),	-- Corruption: Malformation
			SpellName(82170),	-- Corruption: Absolute
			SpellName(93200),	-- Corruption: Sickness
			SpellName(82411),	-- Debilitating Beam
			SpellName(91317),	-- Worshipping
			SpellName(86028),	-- Cho's Blast
			SpellName(86029),	-- Gall's Blast
			-- Sinestra
			SpellName(92956),	-- Wrack
		-- Throne of the Four Winds
			-- Conclave of Wind
			-- Nezir
			SpellName(93131),	-- Ice Patch
			-- Anshal
			SpellName(86206),	-- Soothing Breeze
			SpellName(93122),	-- Toxic Spores
			-- Rohash
			SpellName(93058),	-- Slicing Gale
			-- Al'Akir
			SpellName(87873),	-- Static Shock
			SpellName(93260),	-- Ice Storm
			SpellName(87856),	-- Squall Line
			SpellName(88427),	-- Electrocute
			SpellName(93295),	-- Lightning Rod
		-- Firelands
			-- Beth'tilac
			SpellName(99506),	-- Widows Kiss
			SpellName(97202),	-- Fiery Web Spin
			SpellName(49026),	-- Fixate
			SpellName(97079),	-- Seeping Venom
			-- Lord Rhyolith
			SpellName(98492),	-- Eruption
			-- Alysrazor
			SpellName(101296),	-- Fieroblast
			SpellName(100723),	-- Gushing Wound
			SpellName(99389),	-- Imprinted
			SpellName(101729),	-- Blazing Claw
			SpellName(100640),	-- Harsh Winds
			SpellName(100555),	-- Smouldering Roots
			-- Shannox
			SpellName(99837),	-- Crystal Prison
			SpellName(99937),	-- Jagged Tear
			-- Baleroc
			SpellName(99403),	-- Tormented
			SpellName(99256),	-- Torment
			SpellName(99252),	-- Blaze of Glory
			SpellName(99516),	-- Countdown
			-- Majordomo Staghelm
			SpellName(98450),	-- Searing Seeds
			-- Ragnaros
			SpellName(99399),	-- Burning Wound
			SpellName(100293),	-- Lava Wave
			SpellName(98313),	-- Magma Blast
			SpellName(100675),	-- Dreadflame
			SpellName(99145),	-- Blazing Heat
			SpellName(100249),	-- Combustion
			SpellName(99613),	-- Molten Blast
			-- Trash
			SpellName(99532),	-- Melt Armor
		-- Other
			SpellName(67479),	-- Impale
			SpellName(5782),	-- Fear
			SpellName(84853),	-- Dark Pool
			SpellName(91325),	-- Shadow Vortex
			-- Death Knight
			--[[SpellName(51209),	-- Hungering Cold
			SpellName(47476),	-- Strangulate
			-- Druid
			SpellName(33786),	-- Cyclone
			SpellName(2637),	-- Hibernate
			SpellName(339),		-- Entangling Roots
			SpellName(80964),	-- Skull Bash
			SpellName(78675),	-- Solar Beam
			-- Hunter
			SpellName(3355),	-- Freezing Trap Effect
			SpellName(1513),	-- Scare Beast
			SpellName(19503),	-- Scatter Shot
			SpellName(34490),	-- Silence Shot
			-- Mage
			SpellName(31661),	-- Dragon's Breath
			SpellName(61305),	-- Polymorph
			SpellName(18469),	-- Improved Counterspell
			SpellName(122),		-- Frost Nova
			SpellName(55080),	-- Shattered Barrier
			-- Paladin
			SpellName(20066),	-- Repentance
			SpellName(10326),	-- Turn Evil
			SpellName(853),		-- Hammer of Justice
			-- Priest
			SpellName(605),		-- Mind Control
			SpellName(64044),	-- Psychic Horror
			SpellName(8122),	-- Psychic Scream
			SpellName(9484),	-- Shackle Undead
			SpellName(15487),	-- Silence
			-- Rogue
			SpellName(2094),	-- Blind
			SpellName(1776),	-- Gouge
			SpellName(6770),	-- Sap
			SpellName(18425),	-- Improved Kick
			-- Shaman
			SpellName(51514),	-- Hex
			SpellName(3600),	-- Earthbind
			SpellName(8056),	-- Frost Shock
			SpellName(63685),	-- Freeze
			SpellName(39796),	-- Stoneclaw Stun
			-- Warlock
			SpellName(710),		-- Banish
			SpellName(6789),	-- Death Coil
			SpellName(5484),	-- Howl of Terror
			SpellName(6358),	-- Seduction
			SpellName(30283),	-- Shadowfury
			SpellName(89605),	-- Aura of Foreboding
			-- Warrior
			SpellName(20511),	-- Intimidating Shout]]
		}
		
		T.ReverseTimer = {
		-- Sinestra
			[92956] = true,		-- Wrack
			[89435] = true,		-- Wrack
			[92955] = true,		-- Wrack
			[89421] = true,		-- Wrack
		}
		
		ORD:RegisterDebuffs(T.debuffids)
	end
end