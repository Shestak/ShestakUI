local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true or C.unitframe.plugins_diminishing ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Sap -> http://www.wowhead.com/spell=6770
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.DiminishingSpells = {
	-- Control Stuns
	[108194] = {"ctrlstun"},	-- Asphyxiate
	[91800] = {"ctrlstun"},		-- Gnaw (Ghoul)
	[91797] = {"ctrlstun"},		-- Monstrous Blow (Mutated Ghoul)
	[115001] = {"ctrlstun"},	-- Remorseless Winter
	[22570] = {"ctrlstun"},		-- Maim
	[163505] = {"ctrlstun"},	-- Rake
	[5211] = {"ctrlstun"},		-- Mighty Bash
	[19577] = {"ctrlstun"},		-- Intimidation
	[117526] = {"ctrlstun"},	-- Binding Shot
	[44572] = {"ctrlstun"},		-- Deep Freeze
	[119392] = {"ctrlstun"},	-- Charging Ox Wave
	[119381] = {"ctrlstun"},	-- Leg Sweep
	[120086] = {"ctrlstun"},	-- Fists of Fury
	[853] = {"ctrlstun"},		-- Hammer of Justice
	[105593] = {"ctrlstun"},	-- Fist of Justice
	[119072] = {"ctrlstun"},	-- Holy Wrath
	[1833] = {"ctrlstun"},		-- Cheap Shot
	[408] = {"ctrlstun"},		-- Kidney Shot
	[118905] = {"ctrlstun"},	-- Static Charge
	[118345] = {"ctrlstun"},	-- Pulverize (Primal Earth Elemental)
	[30283] = {"ctrlstun"},		-- Shadowfury
	[89766] = {"ctrlstun"},		-- Axe Toss (Felguard)
	[132168] = {"ctrlstun"},	-- Shockwave
	[132169] = {"ctrlstun"},	-- Storm Bolt
	[20549] = {"ctrlstun"},		-- War Stomp (Racial)

	-- Control Roots
	[96294] = {"ctrlroot"},		-- Chains of Ice
	[339] = {"ctrlroot"},		-- Entangling Roots
	[170855] = {"ctrlroot"},	-- Entangling Roots (Nature's Grasp)
	[102359] = {"ctrlroot"},	-- Mass Entanglement
	[136634] = {"ctrlroot"},	-- Narrow Escape
	[122] = {"ctrlroot"},		-- Frost Nova
	[33395] = {"ctrlroot"},		-- Freeze (Water Elemental)
	[116706] = {"ctrlroot"},	-- Disable
	[114404] = {"ctrlroot"},	-- Void Tendril's Grasp
	[63685] = {"ctrlroot"},		-- Frozen Power
	[107566] = {"ctrlroot"},	-- Staggering Shout

	-- Disorients
	[3355] = {"disorient"},		-- Freezing Trap
	[19386] = {"disorient"},	-- Wyvern Sting
	[118] = {"disorient"},		-- Polymorph
	[28272] = {"disorient"},	-- Polymorph (Pig)
	[28271] = {"disorient"},	-- Polymorph (Turtle)
	[61305] = {"disorient"},	-- Polymorph (Black Cat)
	[61721] = {"disorient"},	-- Polymorph (Rabbit)
	[61780] = {"disorient"},	-- Polymorph (Turkey)
	[161355] = {"disorient"},	-- Polymorph (Penguin)
	[161354] = {"disorient"},	-- Polymorph (Monkey)
	[126819] = {"disorient"},	-- Polymorph (Porcupine)
	[161353] = {"disorient"},	-- Polymorph (Polar Bear Cub)
	[161372] = {"disorient"},	-- Polymorph (Peacock)
	[82691] = {"disorient"},	-- Ring of Frost
	[115078] = {"disorient"},	-- Paralysis
	[20066] = {"disorient"},	-- Repentance
	[9484] = {"disorient"},		-- Shackle Undead
	[1776] = {"disorient"},		-- Gouge
	[6770] = {"disorient"},		-- Sap
	[51514] = {"disorient"},	-- Hex
	[107079] = {"disorient"},	-- Quaking Palm (Racial)

	-- Fears
	[33786] = {"fear"},			-- Cyclone
	[105421] = {"fear"},		-- Blinding Light
	[10326] = {"fear"},			-- Turn Evil
	[145067] = {"fear"},		-- Turn Evil (Talent)
	[8122] = {"fear"},			-- Psychic Scream
	[2094] = {"fear"},			-- Blind
	[118699] = {"fear"},		-- Fear
	[5484] = {"fear"},			-- Howl of Terror
	[6358] = {"fear"},			-- Seduction (Succubus)
	[115268] = {"fear"},		-- Mesmerize (Shivarra)
	[5246] = {"fear"},			-- Intimidating Shout

	-- Horrors
	[64044] = {"horror"},		-- Psychic Horror
	[87204] = {"horror"},		-- Sin and Punishment
	[6789] = {"horror"},		-- Mortal Coil

	-- Random Stuns
	[77505] = {"rndstun"},		-- Earthquake
	[118895] = {"rndstun"},		-- Dragon Roar
	[7922] = {"rndstun"},		-- Warbringer

	-- Random Roots
	[135373] = {"rndroot"},		-- Entrapment
	[111340] = {"rndroot"},		-- Ice Ward
	[64695] = {"rndroot"},		-- Earthgrab

	-- Random Disorients
	[99] = {"rnddis"},			-- Incapacitating Roar
	[31661] = {"rnddis"},		-- Dragon's Breath
	[88625] = {"rnddis"},		-- Holy Word: Chastise

	-- Silences
	[47476] = {"silence"},		-- Strangulate
	[81261] = {"silence"},		-- Solar Beam
	[102051] = {"silence"},		-- Frostjaw
	[31935] = {"silence"},		-- Avenger's Shield
	[15487] = {"silence"},		-- Silence
	[1330] = {"silence"},		-- Garrote
	[25046] = {"silence"},		-- Arcane Torrent (Energy)
	[28730] = {"silence"},		-- Arcane Torrent (Mana)
	[50613] = {"silence"},		-- Arcane Torrent (Runic Power)
	[69179] = {"silence"},		-- Arcane Torrent (Rage)
	[80483] = {"silence"},		-- Arcane Torrent (Focus)
	[129597] = {"silence"},		-- Arcane Torrent (Chi)
	[155145] = {"silence"},		-- Arcane Torrent (Holy Power)

	-- Misc
	[605] = {"mind"},			-- Dominate Mind
}

local function GetIcon(id)
	local _, _, icon = GetSpellInfo(id)
	return icon
end

T.DiminishingIcons = {
	["ctrlstun"] = GetIcon(408),
	["ctrlroot"] = GetIcon(122),
	["disorient"] = GetIcon(118),
	["fear"] = GetIcon(8122),
	["horror"] = GetIcon(64044),
	["mind"] = GetIcon(605),
	["rndstun"] = GetIcon(118895),
	["rndroot"] = GetIcon(64695),
	["rnddis"] = GetIcon(31661),
	["silence"] = GetIcon(15487),
}