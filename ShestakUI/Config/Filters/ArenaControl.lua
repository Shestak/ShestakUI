local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

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
	-- Demon Hunter
	[SpellName(217832)] = 5,	-- Imprison
	[SpellName(211881)] = 5,	-- Fel Eruption
	[SpellName(179057)] = 5,	-- Chaos Nova
	[SpellName(205630)] = 5,	-- Illidan's Grasp
	[SpellName(207685)] = 5,	-- Sigil of Misery
	-- Druid
	[SpellName(33786)] = 5,		-- Cyclone
	[SpellName(5211)] = 5,		-- Mighty Bash
	[SpellName(22570)] = 5,		-- Maim
	[SpellName(99)] = 5,		-- Incapacitating Roar
	-- Hunter
	[SpellName(3355)] = 5,		-- Freezing Trap
	[SpellName(24394)] = 5,		-- Intimidation
	[SpellName(213691)] = 5,	-- Scatter Shot
	-- Mage
	[SpellName(118)] = 5,		-- Polymorph
	[SpellName(82691)] = 5,		-- Ring of Frost
	[SpellName(31661)] = 5,		-- Dragon's Breath
	-- Monk
	[SpellName(115078)] = 5,	-- Paralysis
	[SpellName(119381)] = 5,	-- Leg Sweep
	[SpellName(120086)] = 5,	-- Fists of Fury
	[SpellName(198909)] = 5,	-- Song of Chi-Ji
	-- Paladin
	[SpellName(853)] = 5,		-- Hammer of Justice
	[SpellName(20066)] = 5,		-- Repentance
	[SpellName(105421)] = 5,	-- Blinding Light
	-- Priest
	[SpellName(605)] = 5,		-- Dominate Mind
	[SpellName(8122)] = 5,		-- Psychic Scream
	[SpellName(64044)] = 5,		-- Psychic Horror
	[SpellName(205369)] = 5,	-- Mind Bomb
	[SpellName(200196)] = 5,	-- Holy Word: Chastise
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
	[SpellName(305485)] = 5,	-- Lightning Lasso
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
	[SpellName(199085)] = 5,	-- Warpath
	-- Racial
	[SpellName(107079)] = 5,	-- Quaking Palm (Pandaren)
	[SpellName(20549)] = 5,		-- War Stomp (Tauren)
	[SpellName(287712)] = 5,	-- Haymaker (Kul Tiran)

	-- Silences
	[SpellName(47476)] = 4,		-- Strangulate
	[SpellName(204490)] = 4,	-- Sigil of Silence
	[SpellName(81261)] = 4,		-- Solar Beam
	[SpellName(31935)] = 4,		-- Avenger's Shield
	[SpellName(15487)] = 4,		-- Silence
	[SpellName(1330)] = 4,		-- Garrote - Silence

	-- Roots
	[SpellName(96294)] = 3,		-- Chains of Ice
	[SpellName(339)] = 3,		-- Entangling Roots
	[SpellName(102359)] = 3,	-- Mass Entanglement
	[SpellName(45334)] = 3,		-- Immobilized
	[SpellName(117526)] = 3,	-- Binding Shot
	[SpellName(212638)] = 3,	-- Tracker's Net
	[SpellName(190925)] = 3,	-- Harpoon
	[SpellName(122)] = 3,		-- Frost Nova
	[SpellName(198121)] = 3,	-- Frostbite
	[SpellName(33395)] = 3,		-- Freeze (Water Elemental)
	[SpellName(116706)] = 3,	-- Disable
	[SpellName(64695)] = 3,		-- Earthgrab
	[SpellName(233582)] = 3,	-- Entrenched in Flame

	-- Immunities
	[SpellName(186265)] = 2,	-- Aspect of the Turtle
	[SpellName(45438)] = 2,		-- Ice Block
	[SpellName(642)] = 2,		-- Divine Shield
	[SpellName(46924)] = 2,		-- Bladestorm

	-- Buffs
	[SpellName(1022)] = 1,		-- Blessing of Protection
	[SpellName(204018)] = 1,	-- Blessing of Spellwarding
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