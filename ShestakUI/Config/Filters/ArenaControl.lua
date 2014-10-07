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
	--WoD [GetSpellInfo(2637)] = 4,	-- Hibernate
	[GetSpellInfo(5211)] = 4,	-- Mighty Bash
	--WoD [GetSpellInfo(102795)] = 4,	-- Bear Hug
	[GetSpellInfo(22570)] = 4,	-- Maim
	--WoD [GetSpellInfo(9005)] = 4,	-- Pounce
	[GetSpellInfo(99)] = 4,		-- Disorienting Roar
	--WoD [GetSpellInfo(113004)] = 4,	-- Intimidating Roar
	-- Hunter
	[GetSpellInfo(3355)] = 4,	-- Freezing Trap
	[GetSpellInfo(19386)] = 4,	-- Wyvern Sting
	[GetSpellInfo(117526)] = 4,	-- Binding Shot
	[GetSpellInfo(24394)] = 4,	-- Intimidation
	--WoD [GetSpellInfo(19503)] = 4,	-- Scatter Shot
	--WoD [GetSpellInfo(90337)] = 4,	-- Bad Manner (Monkey)
	--WoD [GetSpellInfo(126246)] = 4,	-- Lullaby (Crane)
	--WoD [GetSpellInfo(96201)] = 4,	-- Web Wrap (Shale Spider)
	-- Mage
	[GetSpellInfo(118)] = 4,	-- Polymorph
	[GetSpellInfo(44572)] = 4,	-- Deep Freeze
	[GetSpellInfo(82691)] = 4,	-- Ring of Frost
	[GetSpellInfo(31661)] = 4,	-- Dragon's Breath
	--WoD [GetSpellInfo(118271)] = 4,	-- Combustion Impact
	-- Monk
	[GetSpellInfo(115078)] = 4,	-- Paralysis
	[GetSpellInfo(119381)] = 4,	-- Leg Sweep
	[GetSpellInfo(120086)] = 4,	-- Fists of Fury
	--WoD [GetSpellInfo(122242)] = 4,	-- Clash
	[GetSpellInfo(119392)] = 4,	-- Charging Ox Wave
	-- Paladin
	[GetSpellInfo(853)] = 4,	-- Hammer of Justice
	[GetSpellInfo(105593)] = 4,	-- Fist of Justice
	[GetSpellInfo(20066)] = 4,	-- Repentance
	[GetSpellInfo(105421)] = 4,	-- Blinding Light
	-- Priest
	[GetSpellInfo(605)] = 4,	-- Dominate Mind
	[GetSpellInfo(8122)] = 4,	-- Psychic Scream
	--WoD [GetSpellInfo(113792)] = 4,	-- Psychic Terror
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
	--WoD [GetSpellInfo(104045)] = 4,	-- Sleep
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
	[GetSpellInfo(44957)] = 4,	-- Nether Shock (Nether Ray)
	[GetSpellInfo(102051)] = 4,	-- Frostjaw
	--WoD [GetSpellInfo(55021)] = 4,	-- Improved Counterspell
	[GetSpellInfo(31935)] = 4,	-- Avenger's Shield
	[GetSpellInfo(15487)] = 4,	-- Silence
	[GetSpellInfo(1330)] = 4,	-- Garrote - Silence
	--WoD [GetSpellInfo(24259)] = 4,	-- Spell Lock (Felhunter)
	--WoD [GetSpellInfo(115782)] = 4,	-- Optical Blast (Observer)

	-- Roots
	[GetSpellInfo(96294)] = 3,	-- Chains of Ice
	[GetSpellInfo(339)] = 3,	-- Entangling Roots
	[GetSpellInfo(102359)] = 3,	-- Mass Entanglement
	[GetSpellInfo(45334)] = 3,	-- Immobilized
	--WoD [GetSpellInfo(19185)] = 3,	-- Entrapment
	[GetSpellInfo(136634)] = 3,	-- Narrow Escape
	--WoD [GetSpellInfo(50245)] = 3,	-- Pin (Crab)
	--WoD [GetSpellInfo(4167)] = 3,	-- Web (Spider)
	--WoD [GetSpellInfo(54706)] = 3,	-- Venom Web Spray (Silithid)
	--WoD [GetSpellInfo(90327)] = 3,	-- Lock Jaw (Dog)
	[GetSpellInfo(122)] = 3,	-- Frost Nova
	[GetSpellInfo(33395)] = 3,	-- Freeze (Pet)
	[GetSpellInfo(111340)] = 3,	-- Ice Ward
	[GetSpellInfo(116706)] = 3,	-- Disable
	[GetSpellInfo(87194)] = 3,	-- Glyph of Mind Blast
	[GetSpellInfo(114404)] = 3,	-- Void Tendril's Grasp
	[GetSpellInfo(63685)] = 3,	-- Freeze (Frozen Power)
	[GetSpellInfo(64695)] = 3,	-- Earthgrab
	[GetSpellInfo(107566)] = 3,	-- Staggering Shout

	-- Immunities
	[GetSpellInfo(19263)] = 2,	-- Deterrence
	[GetSpellInfo(45438)] = 2,	-- Ice Block
	[GetSpellInfo(642)] = 2,	-- Divine Shield
	[GetSpellInfo(46924)] = 2,	-- Bladestorm
	[GetSpellInfo(118038)] = 2,	-- Die by the Sword

	-- Disarms
	--WoD [GetSpellInfo(50541)] = 1,	-- Clench (Scorpid)
	--WoD [GetSpellInfo(91644)] = 1,	-- Snatch (Bird of Prey)
	--WoD [GetSpellInfo(117368)] = 1,	-- Grapple Weapon
	--WoD [GetSpellInfo(64058)] = 1,	-- Psychic Horror
	--WoD [GetSpellInfo(51722)] = 1,	-- Dismantle
	--WoD [GetSpellInfo(676)] = 1,	-- Disarm

	-- Buffs
	[GetSpellInfo(1022)] = 1,	-- Hand of Protection
	[GetSpellInfo(6940)] = 1,	-- Hand of Sacrifice
	[GetSpellInfo(1044)] = 1,	-- Hand of Freedom
	[GetSpellInfo(31821)] = 1,	-- Devotion Aura
	[GetSpellInfo(33206)] = 1,	-- Pain Suppression
	--WoD [GetSpellInfo(96267)] = 1,	-- Inner Focus
	[GetSpellInfo(8178)] = 1,	-- Grounding Totem

	-- Defense abilities
	[GetSpellInfo(48707)] = 1,	-- Anti-Magic Shell
	[GetSpellInfo(48792)] = 1,	-- Icebound Fortitude
	[GetSpellInfo(31224)] = 1,	-- Cloak of Shadows
	[GetSpellInfo(871)] = 1,	-- Shield Wall
}