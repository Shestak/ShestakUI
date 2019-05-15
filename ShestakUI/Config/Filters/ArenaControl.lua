local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Cyclone -> http://www.wowhead.com/spell=33786
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return "Empty"
	end
end

T.ArenaControl = {
	-- Crowd Controls
	-- Death Knight
	[SpellName(91800)] = 5,		-- Gnaw (Ghoul)
	[SpellName(91797)] = 5,		-- Monstrous Blow (Mutated Ghoul)
	[SpellName(108194)] = 5,	-- Asphyxiate
	-- Druid
	[SpellName(33786)] = 5,		-- Cyclone
	[SpellName(5211)] = 5,		-- Mighty Bash
	[SpellName(22570)] = 5,		-- Maim
	[SpellName(99)] = 5,		-- Incapacitating Roar
	-- Hunter
	[SpellName(3355)] = 5,		-- Freezing Trap
	[SpellName(19386)] = 5,		-- Wyvern Sting
	[SpellName(117526)] = 5,	-- Binding Shot
	[SpellName(24394)] = 5,		-- Intimidation
	-- Mage
	[SpellName(118)] = 5,		-- Polymorph
	[SpellName(82691)] = 5,		-- Ring of Frost
	[SpellName(31661)] = 5,		-- Dragon's Breath
	-- Monk
	[SpellName(115078)] = 5,	-- Paralysis
	[SpellName(119381)] = 5,	-- Leg Sweep
	[SpellName(120086)] = 5,	-- Fists of Fury
	-- Paladin
	[SpellName(853)] = 5,		-- Hammer of Justice
	[SpellName(20066)] = 5,		-- Repentance
	[SpellName(105421)] = 5,	-- Blinding Light
	-- Priest
	[SpellName(605)] = 5,		-- Dominate Mind
	[SpellName(8122)] = 5,		-- Psychic Scream
	[SpellName(64044)] = 5,		-- Psychic Horror
	[SpellName(87204)] = 5,		-- Sin and Punishment
	-- Rogue
	[SpellName(6770)] = 5,		-- Sap
	[SpellName(2094)] = 5,		-- Blind
	[SpellName(408)] = 5,		-- Kidney Shot
	[SpellName(1833)] = 5,		-- Cheap Shot
	[SpellName(1776)] = 5,		-- Gouge
	-- Shaman
	[SpellName(51514)] = 5,		-- Hex
	[SpellName(118905)] = 5,	-- Static Charge
	[SpellName(118345)] = 5,	-- Pulverize (Earth Elemental)
	-- Warlock
	[SpellName(118699)] = 5,	-- Fear
	[SpellName(30283)] = 5,		-- Shadowfury
	[SpellName(89766)] = 5,		-- Axe Toss (Felguard)
	[SpellName(5484)] = 5,		-- Howl of Terror
	[SpellName(6789)] = 5,		-- Mortal Coil
	[SpellName(6358)] = 5,		-- Seduction (Succubus)
	[SpellName(115268)] = 5,	-- Mesmerize (Shivarra)
	[SpellName(171156)] = 5,	-- Meteor Strike (Abyssal)
	-- Warrior
	[SpellName(132169)] = 5,	-- Storm Bolt
	[SpellName(132168)] = 5,	-- Shockwave
	[SpellName(5246)] = 5,		-- Intimidating Shout
	-- Racial
	[SpellName(107079)] = 5,	-- Quaking Palm (Pandaren)
	[SpellName(20549)] = 5,		-- War Stomp (Tauren)

	-- Silences
	[SpellName(47476)] = 4,		-- Strangulate
	[SpellName(81261)] = 4,		-- Solar Beam
	[SpellName(31935)] = 4,		-- Avenger's Shield
	[SpellName(15487)] = 4,		-- Silence
	[SpellName(1330)] = 4,		-- Garrote - Silence

	-- Roots
	[SpellName(96294)] = 3,		-- Chains of Ice
	[SpellName(339)] = 3,		-- Entangling Roots
	[SpellName(102359)] = 3,	-- Mass Entanglement
	[SpellName(45334)] = 3,		-- Immobilized
	[SpellName(135373)] = 3,	-- Entrapment
	[SpellName(136634)] = 3,	-- Narrow Escape
	[SpellName(122)] = 3,		-- Frost Nova
	[SpellName(33395)] = 3,		-- Freeze (Water Elemental)
	[SpellName(116706)] = 3,	-- Disable
	[SpellName(114404)] = 3,	-- Void Tendril's Grasp
	[SpellName(64695)] = 3,		-- Earthgrab
	[SpellName(170996)] = 3,	-- Debilitate (Terrorguard)

	-- Immunities
	[SpellName(186265)] = 2,	-- Aspect of the Turtle
	[SpellName(45438)] = 2,		-- Ice Block
	[SpellName(642)] = 2,		-- Divine Shield
	[SpellName(46924)] = 2,		-- Bladestorm

	-- Buffs
	[SpellName(1022)] = 1,		-- Blessing of Protection
	[SpellName(6940)] = 1,		-- Blessing of Sacrifice
	[SpellName(1044)] = 1,		-- Blessing of Freedom
	[SpellName(31821)] = 1,		-- Aura Mastery
	[SpellName(33206)] = 1,		-- Pain Suppression
	[SpellName(8178)] = 1,		-- Grounding Totem

	-- Defense abilities
	[SpellName(48707)] = 1,		-- Anti-Magic Shell
	[SpellName(48792)] = 1,		-- Icebound Fortitude
	[SpellName(31224)] = 1,		-- Cloak of Shadows
	[SpellName(871)] = 1,		-- Shield Wall
	[SpellName(118038)] = 1,	-- Die by the Sword
}