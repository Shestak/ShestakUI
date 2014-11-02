local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Cyclone -> http://www.wowhead.com/spell=33786
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ArenaControl = {
	-- Crowd Controls
	-- Death Knight
	[GetSpellInfo(91800)] = 4,	-- Gnaw (Ghoul)
	[GetSpellInfo(91797)] = 4,	-- Monstrous Blow (Mutated Ghoul)
	[GetSpellInfo(108194)] = 4,	-- Asphyxiate
	[GetSpellInfo(115001)] = 4,	-- Remorseless Winter
	-- Druid
	[GetSpellInfo(33786)] = 4,	-- Cyclone
	[GetSpellInfo(5211)] = 4,	-- Mighty Bash
	[GetSpellInfo(22570)] = 4,	-- Maim
	[GetSpellInfo(99)] = 4,		-- Incapacitating Roar
	-- Hunter
	[GetSpellInfo(3355)] = 4,	-- Freezing Trap
	[GetSpellInfo(19386)] = 4,	-- Wyvern Sting
	[GetSpellInfo(117526)] = 4,	-- Binding Shot
	[GetSpellInfo(24394)] = 4,	-- Intimidation
	-- Mage
	[GetSpellInfo(118)] = 4,	-- Polymorph
	[GetSpellInfo(44572)] = 4,	-- Deep Freeze
	[GetSpellInfo(82691)] = 4,	-- Ring of Frost
	[GetSpellInfo(31661)] = 4,	-- Dragon's Breath
	-- Monk
	[GetSpellInfo(115078)] = 4,	-- Paralysis
	[GetSpellInfo(119381)] = 4,	-- Leg Sweep
	[GetSpellInfo(120086)] = 4,	-- Fists of Fury
	[GetSpellInfo(119392)] = 4,	-- Charging Ox Wave
	-- Paladin
	[GetSpellInfo(853)] = 4,	-- Hammer of Justice
	[GetSpellInfo(105593)] = 4,	-- Fist of Justice
	[GetSpellInfo(20066)] = 4,	-- Repentance
	[GetSpellInfo(105421)] = 4,	-- Blinding Light
	-- Priest
	[GetSpellInfo(605)] = 4,	-- Dominate Mind
	[GetSpellInfo(8122)] = 4,	-- Psychic Scream
	[GetSpellInfo(64044)] = 4,	-- Psychic Horror
	-- Rogue
	[GetSpellInfo(6770)] = 4,	-- Sap
	[GetSpellInfo(2094)] = 4,	-- Blind
	[GetSpellInfo(408)] = 4,	-- Kidney Shot
	[GetSpellInfo(1833)] = 4,	-- Cheap Shot
	[GetSpellInfo(1776)] = 4,	-- Gouge
	-- Shaman
	[GetSpellInfo(51514)] = 4,	-- Hex
	[GetSpellInfo(118905)] = 4,	-- Static Charge
	-- Warlock
	[GetSpellInfo(118699)] = 4,	-- Fear
	[GetSpellInfo(30283)] = 4,	-- Shadowfury
	[GetSpellInfo(89766)] = 4,	-- Axe Toss (Felguard)
	[GetSpellInfo(5484)] = 4,	-- Howl of Terror
	[GetSpellInfo(6789)] = 4,	-- Mortal Coil
	[GetSpellInfo(6358)] = 4,	-- Seduction (Succubus)
	[GetSpellInfo(115268)] = 4,	-- Mesmerize (Shivarra)
	-- Warrior
	[GetSpellInfo(132169)] = 4,	-- Storm Bolt
	[GetSpellInfo(132168)] = 4,	-- Shockwave
	[GetSpellInfo(5246)] = 4,	-- Intimidating Shout

	-- Silences
	[GetSpellInfo(47476)] = 4,	-- Strangulate
	[GetSpellInfo(81261)] = 4,	-- Solar Beam
	[GetSpellInfo(102051)] = 4,	-- Frostjaw
	[GetSpellInfo(31935)] = 4,	-- Avenger's Shield
	[GetSpellInfo(15487)] = 4,	-- Silence
	[GetSpellInfo(1330)] = 4,	-- Garrote - Silence

	-- Roots
	[GetSpellInfo(96294)] = 3,	-- Chains of Ice
	[GetSpellInfo(339)] = 3,	-- Entangling Roots
	[GetSpellInfo(102359)] = 3,	-- Mass Entanglement
	[GetSpellInfo(45334)] = 3,	-- Immobilized
	[GetSpellInfo(135373)] = 3,	-- Entrapment
	[GetSpellInfo(136634)] = 3,	-- Narrow Escape
	[GetSpellInfo(122)] = 3,	-- Frost Nova
	[GetSpellInfo(33395)] = 3,	-- Freeze (Pet)
	[GetSpellInfo(111340)] = 3,	-- Ice Ward
	[GetSpellInfo(116706)] = 3,	-- Disable
	[GetSpellInfo(87194)] = 3,	-- Glyph of Mind Blast
	[GetSpellInfo(114404)] = 3,	-- Void Tendril's Grasp
	[GetSpellInfo(63685)] = 3,	-- Frozen Power
	[GetSpellInfo(64695)] = 3,	-- Earthgrab
	[GetSpellInfo(107566)] = 3,	-- Staggering Shout

	-- Immunities
	[GetSpellInfo(19263)] = 2,	-- Deterrence
	[GetSpellInfo(45438)] = 2,	-- Ice Block
	[GetSpellInfo(642)] = 2,	-- Divine Shield
	[GetSpellInfo(46924)] = 2,	-- Bladestorm
	[GetSpellInfo(118038)] = 2,	-- Die by the Sword

	-- Buffs
	[GetSpellInfo(1022)] = 1,	-- Hand of Protection
	[GetSpellInfo(6940)] = 1,	-- Hand of Sacrifice
	[GetSpellInfo(1044)] = 1,	-- Hand of Freedom
	[GetSpellInfo(31821)] = 1,	-- Devotion Aura
	[GetSpellInfo(33206)] = 1,	-- Pain Suppression
	[GetSpellInfo(8178)] = 1,	-- Grounding Totem

	-- Defense abilities
	[GetSpellInfo(48707)] = 1,	-- Anti-Magic Shell
	[GetSpellInfo(48792)] = 1,	-- Icebound Fortitude
	[GetSpellInfo(31224)] = 1,	-- Cloak of Shadows
	[GetSpellInfo(871)] = 1,	-- Shield Wall
}