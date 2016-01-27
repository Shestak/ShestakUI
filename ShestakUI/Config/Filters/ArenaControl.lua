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
	[GetSpellInfo(91800)] = 5,	-- Gnaw (Ghoul)
	[GetSpellInfo(91797)] = 5,	-- Monstrous Blow (Mutated Ghoul)
	[GetSpellInfo(108194)] = 5,	-- Asphyxiate
	[GetSpellInfo(115001)] = 5,	-- Remorseless Winter
	-- Druid
	[GetSpellInfo(33786)] = 5,	-- Cyclone
	[GetSpellInfo(5211)] = 5,	-- Mighty Bash
	[GetSpellInfo(22570)] = 5,	-- Maim
	[GetSpellInfo(99)] = 5,		-- Incapacitating Roar
	-- Hunter
	[GetSpellInfo(3355)] = 5,	-- Freezing Trap
	[GetSpellInfo(19386)] = 5,	-- Wyvern Sting
	[GetSpellInfo(117526)] = 5,	-- Binding Shot
	[GetSpellInfo(24394)] = 5,	-- Intimidation
	-- Mage
	[GetSpellInfo(118)] = 5,	-- Polymorph
	[GetSpellInfo(44572)] = 5,	-- Deep Freeze
	[GetSpellInfo(82691)] = 5,	-- Ring of Frost
	[GetSpellInfo(31661)] = 5,	-- Dragon's Breath
	-- Monk
	[GetSpellInfo(115078)] = 5,	-- Paralysis
	[GetSpellInfo(119381)] = 5,	-- Leg Sweep
	[GetSpellInfo(120086)] = 5,	-- Fists of Fury
	[GetSpellInfo(119392)] = 5,	-- Charging Ox Wave
	-- Paladin
	[GetSpellInfo(853)] = 5,	-- Hammer of Justice
	[GetSpellInfo(105593)] = 5,	-- Fist of Justice
	[GetSpellInfo(20066)] = 5,	-- Repentance
	[GetSpellInfo(105421)] = 5,	-- Blinding Light
	[GetSpellInfo(145067)] = 5,	-- Turn Evil
	-- Priest
	[GetSpellInfo(605)] = 5,	-- Dominate Mind
	[GetSpellInfo(8122)] = 5,	-- Psychic Scream
	[GetSpellInfo(64044)] = 5,	-- Psychic Horror
	[GetSpellInfo(87204)] = 5,	-- Sin and Punishment
	-- Rogue
	[GetSpellInfo(6770)] = 5,	-- Sap
	[GetSpellInfo(2094)] = 5,	-- Blind
	[GetSpellInfo(408)] = 5,	-- Kidney Shot
	[GetSpellInfo(1833)] = 5,	-- Cheap Shot
	[GetSpellInfo(1776)] = 5,	-- Gouge
	-- Shaman
	[GetSpellInfo(51514)] = 5,	-- Hex
	[GetSpellInfo(118905)] = 5,	-- Static Charge
	[GetSpellInfo(118345)] = 5,	-- Pulverize (Earth Elemental)
	-- Warlock
	[GetSpellInfo(118699)] = 5,	-- Fear
	[GetSpellInfo(30283)] = 5,	-- Shadowfury
	[GetSpellInfo(137143)] = 5,	-- Blood Horror
	[GetSpellInfo(89766)] = 5,	-- Axe Toss (Felguard)
	[GetSpellInfo(5484)] = 5,	-- Howl of Terror
	[GetSpellInfo(6789)] = 5,	-- Mortal Coil
	[GetSpellInfo(6358)] = 5,	-- Seduction (Succubus)
	[GetSpellInfo(115268)] = 5,	-- Mesmerize (Shivarra)
	[GetSpellInfo(171156)] = 5,	-- Meteor Strike (Abyssal)
	-- Warrior
	[GetSpellInfo(132169)] = 5,	-- Storm Bolt
	[GetSpellInfo(132168)] = 5,	-- Shockwave
	[GetSpellInfo(5246)] = 5,	-- Intimidating Shout
	-- Racial
	[GetSpellInfo(107079)] = 5,	-- Quaking Palm
	[GetSpellInfo(20549)] = 5,	-- War Stomp

	-- Silences
	[GetSpellInfo(47476)] = 4,	-- Strangulate
	[GetSpellInfo(81261)] = 4,	-- Solar Beam
	[GetSpellInfo(114238)] = 4,	-- Fae Silence
	[GetSpellInfo(102051)] = 4,	-- Frostjaw
	[GetSpellInfo(31935)] = 4,	-- Avenger's Shield
	[GetSpellInfo(15487)] = 4,	-- Silence
	[GetSpellInfo(1330)] = 4,	-- Garrote - Silence
	[GetSpellInfo(28730)] = 4,	-- Arcane Torrent

	-- Roots
	[GetSpellInfo(96294)] = 3,	-- Chains of Ice
	[GetSpellInfo(339)] = 3,	-- Entangling Roots
	[GetSpellInfo(102359)] = 3,	-- Mass Entanglement
	[GetSpellInfo(45334)] = 3,	-- Immobilized
	[GetSpellInfo(135373)] = 3,	-- Entrapment
	[GetSpellInfo(136634)] = 3,	-- Narrow Escape
	[GetSpellInfo(122)] = 3,	-- Frost Nova
	[GetSpellInfo(33395)] = 3,	-- Freeze (Water Elemental)
	[GetSpellInfo(111340)] = 3,	-- Ice Ward
	[GetSpellInfo(116706)] = 3,	-- Disable
	[GetSpellInfo(87194)] = 3,	-- Glyph of Mind Blast
	[GetSpellInfo(114404)] = 3,	-- Void Tendril's Grasp
	[GetSpellInfo(63685)] = 3,	-- Frozen Power
	[GetSpellInfo(64695)] = 3,	-- Earthgrab
	[GetSpellInfo(170996)] = 3,	-- Debilitate (Terrorguard)
	[GetSpellInfo(107566)] = 3,	-- Staggering Shout

	-- Immunities
	[GetSpellInfo(19263)] = 2,	-- Deterrence
	[GetSpellInfo(45438)] = 2,	-- Ice Block
	[GetSpellInfo(642)] = 2,	-- Divine Shield
	[GetSpellInfo(46924)] = 2,	-- Bladestorm

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
	[GetSpellInfo(118038)] = 1,	-- Die by the Sword
}