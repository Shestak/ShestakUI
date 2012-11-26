local T, C, L, _ = unpack(select(2, ...))
if C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Weakened Soul -> http://www.wowhead.com/spell=6788
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
-- Class buffs
T.RaidBuffs = {
	DRUID = {
		{774, "TOPRIGHT", {0.8, 0.4, 0.8}},					-- Rejuvenation
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		{94447, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		{102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		{102351, "RIGHT", {0.4, 0.9, 0.4}},					-- Cenarion Ward
	},
	MONK = {
		{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},				-- Renewing Mist
		{132120, "BOTTOMLEFT", {0.4, 0.8, 0.2}},			-- Enveloping Mist
		{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Zen Sphere
		{116849, "LEFT", {0.81, 0.85, 0.1}, true},			-- Life Cocoon
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		{20925, "BOTTOMLEFT", {0.9, 0.9, 0.1}},				-- Sacred Shield
		{114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},			-- Eternal Flame
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Hand of Freedom
		{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},		-- Hand of Salvation
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Hand of Sacrifice
		{114039, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},		-- Hand of Purity
	},
	PRIEST = {
		{6788, "TOPRIGHT", {1, 0, 0}, true},				-- Weakened Soul
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},			-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppress
		{47788, "LEFT", {0.86, 0.52, 0}, true},				-- Guardian Spirit
	},
	SHAMAN = {
		{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Riptide
		{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},			-- Earth Shield
		{51945, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Earthliving
	},
	DEATHKNIGHT = {
		{49016, "TOPRIGHT", {0.89, 0.89, 0.1}},				-- Unholy Frenzy
	},
	HUNTER = {
		{35079, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
	},
	MAGE = {
		{111264, "TOPRIGHT", {0.2, 0.2, 1}},				-- Ice Ward
	},
	ROGUE = {
		{57933, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Tricks of the Trade
	},
	WARLOCK = {
		{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},				-- Soulstone
	},
	WARRIOR = {
		{114030, "TOPLEFT", {0.2, 0.2, 1}},					-- Vigilance
		{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Intervene
	},
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true}, 					-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},					-- Warsong flag, Alliance
		{34976, "LEFT", {1, 0, 0}, true}, 					-- Netherstorm Flag
	},
}

T.RaidBuffsBlack = {
	[65148] = true,		-- Sacred Shield Proc
}

local function SpellName(id)
	local name = select(1, GetSpellInfo(id))
	return name
end

T.RaidDebuffs = {
-----------------------------------------------------------------
-- Pandaria
-----------------------------------------------------------------
-- Terrace of Endless Spring
	-- Protectors of the Endless
	[SpellName(117519)] = 3,	-- Touch of Sha
	[SpellName(117436)] = 3,	-- Lightning Prison
	-- Tsulong
	[SpellName(122752)] = 3,	-- Shadow Breath
	[SpellName(123011)] = 3,	-- Terrorize
	[SpellName(122777)] = 3,	-- Nightmares
	[SpellName(123036)] = 3,	-- Fright
	-- Lei Shi
	[SpellName(123121)] = 3,	-- Spray
	[SpellName(123705)] = 3,	-- Scary Fog
	-- Sha of Fear
	[SpellName(119985)] = 3,	-- Dread Spray
	[SpellName(119086)] = 3,	-- Penetrating Bolt
	[SpellName(120669)] = 3,	-- Naked and Afraid
	[SpellName(120629)] = 3,	-- Huddle in Terror
-- Heart of Fear
	-- Imperial Vizier Zor'lok
	[SpellName(122761)] = 3,	-- Exhale
	[SpellName(122740)] = 3,	-- Convert
	-- Blade Lord Ta'yak
	[SpellName(123180)] = 3,	-- Wind Step
	[SpellName(123474)] = 3,	-- Overwhelming Assault
	-- Garalon
	[SpellName(122835)] = 3,	-- Pheromones
	[SpellName(123081)] = 3,	-- Pungency
	-- Wind Lord Mel'jarak
	[SpellName(129078)] = 4,	-- Amber Prison
	[SpellName(122055)] = 3,	-- Residue
	[SpellName(122064)] = 3,	-- Corrosive Resin
	-- Amber-Shaper Un'sok
	[SpellName(121949)] = 3,	-- Parasitic Growth
	[SpellName(122370)] = 3,	-- Reshape Life
	-- Grand Empress Shek'zeer
	[SpellName(123707)] = 3,	-- Eyes of the Empress
	[SpellName(123713)] = 3,	-- Servant of the Empress
	[SpellName(123788)] = 3,	-- Cry of Terror
	[SpellName(124849)] = 3,	-- Consuming Terror
	[SpellName(124863)] = 3,	-- Visions of Demise
-- Mogu'shan Vaults
	-- The Stone Guard
	[SpellName(125206)] = 3,	-- Rend Flesh
	[SpellName(130395)] = 3,	-- Jasper Chains
	[SpellName(116281)] = 3,	-- Cobalt Mine Blast
	-- Feng the Accursed
	[SpellName(131788)] = 3,	-- Lightning Lash
	[SpellName(116942)] = 3,	-- Flaming Spear
	[SpellName(131790)] = 3,	-- Arcane Shock
	[SpellName(116784)] = 3,	-- Wildfire Spark
	[SpellName(116417)] = 3,	-- Arcane Resonance
	[SpellName(131792)] = 3,	-- Shadowburn
	-- Gara'jal the Spiritbinder
	[SpellName(122151)] = 4,	-- Voodoo Doll
	[SpellName(116161)] = 3,	-- Crossed Over
	[SpellName(117723)] = 3,	-- Frail Soul
	-- The Spirit Kings
	[SpellName(117708)] = 3,	-- Maddening Shout
	[SpellName(118303)] = 3,	-- Fixate
	[SpellName(118048)] = 3,	-- Pillaged
	[SpellName(118135)] = 3,	-- Pinned Down
	[SpellName(118163)] = 3,	-- Robbed Blind
	-- Elegon
	[SpellName(117878)] = 3,	-- Overcharged
	[SpellName(117949)] = 3,	-- Closed Circuit
	[SpellName(132222)] = 3,	-- Destabilizing Energies
	-- Will of the Emperor
	[SpellName(116835)] = 3,	-- Devastating Arc
	[SpellName(116778)] = 3,	-- Focused Defense
	[SpellName(116525)] = 3,	-- Focused Assault
-- Sha of Anger
	[SpellName(119622)] = 3,	-- Growing Anger
	[SpellName(119626)] = 3,	-- Aggressive Behavior
-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
	-- Death Knight
	--[[[SpellName(115001)] = 3,	-- Remorseless Winter
	[SpellName(108194)] = 3,	-- Asphyxiate
	[SpellName(47476)] = 3,		-- Strangulate
	[SpellName(47481)] = 3,		-- Gnaw (Ghoul)
	[SpellName(91797)] = 3,		-- Monstrous Blow (Mutated Ghoul)
	-- Druid
	[SpellName(33786)] = 3,		-- Cyclone
	[SpellName(2637)] = 3,		-- Hibernate
	[SpellName(339)] = 3,		-- Entangling Roots
	[SpellName(78675)] = 3,		-- Solar Beam
	-- Hunter
	[SpellName(3355)] = 3,		-- Freezing Trap
	[SpellName(117526)] = 3,	-- Binding Shot
	[SpellName(1513)] = 3,		-- Scare Beast
	[SpellName(19503)] = 3,		-- Scatter Shot
	[SpellName(34490)] = 3,		-- Silence Shot
	[SpellName(19386)] = 3,		-- Wyvern Sting
	-- Mage
	[SpellName(31661)] = 3,		-- Dragon's Breath
	[SpellName(82691)] = 3,		-- Ring of Frost
	[SpellName(61305)] = 3,		-- Polymorph
	[SpellName(102051)] = 3,	-- Frostjaw
	[SpellName(55021)] = 3,		-- Improved Counterspell
	[SpellName(122)] = 3,		-- Frost Nova
	[SpellName(111340)] = 3,	-- Ice Ward
	-- Monk
	[SpellName(115078)] = 3,	-- Paralysis
	-- Paladin
	[SpellName(20066)] = 3,		-- Repentance
	[SpellName(853)] = 3,		-- Hammer of Justice
	[SpellName(105593)] = 3,	-- Fist of Justice
	[SpellName(105421)] = 3,	-- Blinding Light
	-- Priest
	[SpellName(605)] = 3,		-- Dominate Mind
	[SpellName(8122)] = 3,		-- Psychic Scream
	[SpellName(113792)] = 3,		-- Psychic Terror
	[SpellName(64044)] = 3,		-- Psychic Horror
	[SpellName(15487)] = 3,		-- Silence
	-- Rogue
	[SpellName(2094)] = 3,		-- Blind
	[SpellName(1776)] = 3,		-- Gouge
	[SpellName(6770)] = 3,		-- Sap
	-- Shaman
	[SpellName(51514)] = 3,		-- Hex
	[SpellName(118905)] = 3,	-- Static Charge
	[SpellName(3600)] = 3,		-- Earthbind
	[SpellName(8056)] = 3,		-- Frost Shock
	[SpellName(63685)] = 3,		-- Freeze
	-- Warlock
	[SpellName(118699)] = 3,	-- Fear
	[SpellName(104045)] = 3,	-- Sleep
	[SpellName(6789)] = 3,		-- Mortal Coil
	[SpellName(5484)] = 3,		-- Howl of Terror
	[SpellName(6358)] = 3,		-- Seduction (Succubus)
	[SpellName(115268)] = 3,	-- Mesmerize (Shivarra)
	[SpellName(30283)] = 3,		-- Shadowfury
	-- Warrior
	[SpellName(46968)] = 3,		-- Shockwave
	[SpellName(20511)] = 3,		-- Intimidating Shout]]
}

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- 
}

T.RaidDebuffsBlack = {
	--[spellID] = true,			-- 
}