local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Weakened Soul -> http://www.wowhead.com/spell=6788
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidframe.plugins_aura_watch == true then
	do
		-- Class buffs
		T.buffids = {
			DRUID = {
				{774, "TOPRIGHT", {0.8, 0.4, 0.8}},						-- Rejuvenation
				{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},					-- Regrowth
				{94447, "TOPLEFT", {0.4, 0.8, 0.2}},					-- Lifebloom
				{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},					-- Wild Growth
				{102342, "LEFT", {0.45, 0.3, 0.2}, true},				-- Ironbark
				{102351, "RIGHT", {0.4, 0.9, 0.4}},						-- Cenarion Ward
			},
			MONK = {
				{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},					-- Renewing Mist
				{132120, "BOTTOMLEFT", {0.4, 0.8, 0.2}},				-- Enveloping Mist
				{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},					-- Zen Sphere
				{116849, "LEFT", {0.81, 0.85, 0.1}, true},				-- Life Cocoon
			},
			PALADIN = {
				{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},					-- Beacon of Light
				{20925, "BOTTOMLEFT", {0.9, 0.9, 0.1}, false, true},	-- Sacred Shield
				{114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},				-- Eternal Flame
				{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},				-- Hand of Protection
				{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},			-- Hand of Freedom
				{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},			-- Hand of Salvation
				{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},			-- Hand of Sacrifice
				{114039, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},			-- Hand of Purity
			},
			PRIEST = {
				{6788, "TOPRIGHT", {1, 0, 0}, true},					-- Weakened Soul
				{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},				-- Prayer of Mending
				{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 					-- Renew
				{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},				-- Power Word: Shield
				{33206, "LEFT", {0.89, 0.1, 0.1}, true},				-- Pain Suppress
				{47788, "LEFT", {0.86, 0.52, 0}, true},					-- Guardian Spirit
			},
			SHAMAN = {
				{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},					-- Riptide
				{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},				-- Earth Shield
				{51945, "BOTTOMRIGHT", {0.7, 0.4, 0}},					-- Earthliving
			},
			DEATHKNIGHT = {
				{49016, "TOPRIGHT", {0.89, 0.89, 0.1}},					-- Unholy Frenzy
			},
			HUNTER = {
				{35079, "TOPRIGHT", {0.2, 0.2, 1}},						-- Misdirection
			},
			MAGE = {
				{111264, "TOPRIGHT", {0.2, 0.2, 1}},					-- Ice Ward
			},
			ROGUE = {
				{57933, "TOPRIGHT", {0.89, 0.1, 0.1}},					-- Tricks of the Trade
			},
			WARLOCK = {
				{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},					-- Soulstone
			},
			WARRIOR = {
				{114030, "TOPLEFT", {0.2, 0.2, 1}},						-- Vigilance
				{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},					-- Intervene
			},
			ALL = {
				{23333, "LEFT", {1, 0, 0}, true}, 						-- Warsong flag, Horde
				{23335, "LEFT", {0, 0, 1}, true},						-- Warsong flag, Alliance
				{34976, "LEFT", {1, 0, 0}, true}, 						-- Netherstorm Flag
			},
		}
	end

	do
		-- Raid debuffs
		local _, ns = ...
		local ORD = ns.oUF_RaidDebuffs or oUF_RaidDebuffs

		if not ORD then return end

		local function SpellName(id)
			local name = select(1, GetSpellInfo(id))
			return name
		end

		T.debuffids = {
		-----------------------------------------------------------------
		-- Pandaria
		-----------------------------------------------------------------
		-- Terrace of Endless Spring
			-- Protectors of the Endless
			SpellName(117519),	-- Touch of Sha
			SpellName(117436),	-- Lightning Prison
			-- Tsulong
			SpellName(122752),	-- Shadow Breath
			SpellName(123011),	-- Terrorize
			-- Lei Shi
			SpellName(123121),	-- Spray
			-- Sha of Fear
			SpellName(119985),	-- Dread Spray
			SpellName(119086),	-- Penetrating Bolt
		-- Heart of Fear
			-- Imperial Vizier Zor'lok
			SpellName(122761),	-- Exhale
			SpellName(122740),	-- Convert
			SpellName(123812),	-- Pheromones of Zeal
			-- Blade Lord Ta'yak
			SpellName(123180),	-- Wind Step
			SpellName(123474),	-- Overwhelming Assault
			-- Garalon
			SpellName(122835),	-- Pheromones
			SpellName(123081),	-- Pungency
			-- Wind Lord Mel'jarak
			SpellName(122125),	-- Corrosive Resin Pool
			-- Amber-Shaper Un'sok
			SpellName(121949),	-- Parasitic Growth
			-- Grand Empress Shek'zeer
			SpellName(123788),	-- Cry of Terror
			SpellName(124849),	-- Consuming Terror
		-- Mogu'shan Vaults
			-- The Stone Guard
			SpellName(125206),	-- Rend Flesh
			SpellName(130395),	-- Jasper Chains
			SpellName(116281),	-- Cobalt Mine Blast
			-- Feng the Accursed
			SpellName(131788),	-- Lightning Lash
			SpellName(116942),	-- Flaming Spear
			SpellName(131790),	-- Arcane Shock
			SpellName(116784),	-- Wildfire Spark
			SpellName(116417),	-- Arcane Resonance
			-- Gara'jal the Spiritbinder
			SpellName(116161),	-- Crossed Over
			SpellName(122151),	-- Voodoo Dolls
			-- The Spirit Kings
			SpellName(117708),	-- Maddening Shout
			SpellName(118303),	-- Fixate
			SpellName(118048),	-- Pillaged
			SpellName(118135),	-- Pinned Down
			-- Elegon
			SpellName(117878),	-- Overcharged
			SpellName(117949),	-- Closed Circuit
			SpellName(132222),	-- Destabilizing Energies
			-- Will of the Emperor
			SpellName(116835),	-- Devastating Arc
			SpellName(116778),	-- Focused Defense
			SpellName(116525),	-- Focused Assault
		-- Kun-Lai Summit
			-- Sha of Anger
			SpellName(119622),	-- Growing Anger
			SpellName(119626),	-- Aggressive Behavior
			SpellName(119488),	-- Unleashed Wrath
		-----------------------------------------------------------------
		-- PvP
		-----------------------------------------------------------------
			-- Death Knight
			--[[SpellName(115001),	-- Remorseless Winter
			SpellName(108194),	-- Asphyxiate
			SpellName(47476),	-- Strangulate
			SpellName(47481),	-- Gnaw (Pet)
			SpellName(91797),	-- Monstrous Blow (Pet - mutant)
			-- Druid
			SpellName(33786),	-- Cyclone
			SpellName(2637),	-- Hibernate
			SpellName(339),		-- Entangling Roots
			SpellName(78675),	-- Solar Beam
			-- Hunter
			SpellName(3355),	-- Freezing Trap
			SpellName(117526),	-- Binding Shot
			SpellName(1513),	-- Scare Beast
			SpellName(19503),	-- Scatter Shot
			SpellName(34490),	-- Silence Shot
			SpellName(19386),	-- Wyvern Sting
			-- Mage
			SpellName(31661),	-- Dragon's Breath
			SpellName(82691),	-- Ring of Frost
			SpellName(61305),	-- Polymorph
			SpellName(102051),	-- Frostjaw
			SpellName(55021),	-- Improved Counterspell
			SpellName(122),		-- Frost Nova
			SpellName(111340),	-- Ice Ward
			-- Monk
			SpellName(115078),	-- Paralysis
			-- Paladin
			SpellName(20066),	-- Repentance
			SpellName(853),		-- Hammer of Justice
			SpellName(105593),	-- Fist of Justice
			SpellName(105421),	-- Blinding Light
			-- Priest
			SpellName(605),		-- Dominate Mind
			SpellName(8122),	-- Psychic Scream
			SpellName(113792),	-- Psychic Terror
			SpellName(64044),	-- Psychic Horror
			SpellName(15487),	-- Silence
			-- Rogue
			SpellName(2094),	-- Blind
			SpellName(1776),	-- Gouge
			SpellName(6770),	-- Sap
			-- Shaman
			SpellName(51514),	-- Hex
			SpellName(118905),	-- Static Charge
			SpellName(3600),	-- Earthbind
			SpellName(8056),	-- Frost Shock
			SpellName(63685),	-- Freeze
			-- Warlock
			SpellName(118699),	-- Fear
			SpellName(6789),	-- Mortal Coil
			SpellName(5484),	-- Howl of Terror
			SpellName(6358),	-- Seduction
			SpellName(115268),	-- Mesmerize
			SpellName(30283),	-- Shadowfury
			-- Warrior
			SpellName(46968),	-- Shockwave
			SpellName(20511),	-- Intimidating Shout]]
		}

		T.ReverseTimer = {

		}

		ORD:RegisterDebuffs(T.debuffids)
	end
end