local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true or C.unitframe.plugins_diminishing ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Sap -> http://www.wowhead.com/spell=6770
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.DiminishingSpells = {
	-- Stuns
	[108194] = {"stun"},			-- Asphyxiate
	[91800] = {"stun"},				-- Gnaw (Ghoul)
	[91797] = {"stun"},				-- Monstrous Blow (Mutated Ghoul)
	[22570] = {"stun"},				-- Maim
	[163505] = {"stun"},			-- Rake
	[5211] = {"stun"},				-- Mighty Bash
	[19577] = {"stun"},				-- Intimidation
	[117526] = {"stun"},			-- Binding Shot
	[119381] = {"stun"},			-- Leg Sweep
	[120086] = {"stun"},			-- Fists of Fury
	[853] = {"stun"},				-- Hammer of Justice
	[1833] = {"stun"},				-- Cheap Shot
	[408] = {"stun"},				-- Kidney Shot
	[118905] = {"stun"},			-- Static Charge
	[118345] = {"stun"},			-- Pulverize (Primal Earth Elemental)
	[30283] = {"stun"},				-- Shadowfury
	[89766] = {"stun"},				-- Axe Toss (Felguard)
	[22703] = {"stun"},				-- Infernal Awakening
	[132168] = {"stun"},			-- Shockwave
	[132169] = {"stun"},			-- Storm Bolt
	[20549] = {"stun"},				-- War Stomp (Racial)

	-- Roots
	[96294] = {"root"},				-- Chains of Ice
	[339] = {"root"},				-- Entangling Roots
	[170855] = {"root"},			-- Entangling Roots (Nature's Grasp)
	[135373] = {"root"},			-- Entrapment
	[102359] = {"root"},			-- Mass Entanglement
	[136634] = {"root"},			-- Narrow Escape
	[45334] = {"root"},				-- Immobilized
	[122] = {"root"},				-- Frost Nova
	[33395] = {"root"},				-- Freeze (Water Elemental)
	[116706] = {"root"},			-- Disable
	[114404] = {"root"},			-- Void Tendril's Grasp
	[64695] = {"root"},				-- Earthgrab
	[170996] = {"root"},			-- Debilitate (Terrorguard)
	[107566] = {"root"},			-- Staggering Shout

	-- Incapacitates
	[99] = {"incapacitate"},		-- Incapacitating Roar
	[3355] = {"incapacitate"},		-- Freezing Trap
	[19386] = {"incapacitate"},		-- Wyvern Sting
	[118] = {"incapacitate"},		-- Polymorph
	[28272] = {"incapacitate"},		-- Polymorph (Pig)
	[28271] = {"incapacitate"},		-- Polymorph (Turtle)
	[61305] = {"incapacitate"},		-- Polymorph (Black Cat)
	[61721] = {"incapacitate"},		-- Polymorph (Rabbit)
	[61780] = {"incapacitate"},		-- Polymorph (Turkey)
	[161355] = {"incapacitate"},	-- Polymorph (Penguin)
	[161354] = {"incapacitate"},	-- Polymorph (Monkey)
	[126819] = {"incapacitate"},	-- Polymorph (Porcupine)
	[161353] = {"incapacitate"},	-- Polymorph (Polar Bear Cub)
	[161372] = {"incapacitate"},	-- Polymorph (Peacock)
	[82691] = {"incapacitate"},		-- Ring of Frost
	[115078] = {"incapacitate"},	-- Paralysis
	[202272] = {"incapacitate"},	-- Incendiary Brew
	[20066] = {"incapacitate"},		-- Repentance
	[9484] = {"incapacitate"},		-- Shackle Undead
	[88625] = {"incapacitate"},		-- Holy Word: Chastise
	[605] = {"incapacitate"},		-- Dominate Mind
	[64044] = {"incapacitate"},		-- Psychic Horror
	[87204] = {"incapacitate"},		-- Sin and Punishment
	[1776] = {"incapacitate"},		-- Gouge
	[6770] = {"incapacitate"},		-- Sap
	[51514] = {"incapacitate"},		-- Hex
	[6789] = {"incapacitate"},		-- Mortal Coil
	[107079] = {"incapacitate"},	-- Quaking Palm (Racial)

	-- Disorients
	[33786] = {"disorient"},		-- Cyclone
	[31661] = {"disorient"},		-- Dragon's Breath
	[105421] = {"disorient"},		-- Blinding Light
	[8122] = {"disorient"},			-- Psychic Scream
	[2094] = {"disorient"},			-- Blind
	[118699] = {"disorient"},		-- Fear
	[130616] = {"disorient"},		-- Fear (Glyph)
	[5484] = {"disorient"},			-- Howl of Terror
	[6358] = {"disorient"},			-- Seduction (Succubus)
	[115268] = {"disorient"},		-- Mesmerize (Shivarra)
	[5246] = {"disorient"},			-- Intimidating Shout

	-- Silences
	[47476] = {"silence"},			-- Strangulate
	[81261] = {"silence"},			-- Solar Beam
	[31935] = {"silence"},			-- Avenger's Shield
	[15487] = {"silence"},			-- Silence
	[1330] = {"silence"},			-- Garrote
	[25046] = {"silence"},			-- Arcane Torrent (Energy)
	[28730] = {"silence"},			-- Arcane Torrent (Mana)
	[50613] = {"silence"},			-- Arcane Torrent (Runic Power)
	[69179] = {"silence"},			-- Arcane Torrent (Rage)
	[80483] = {"silence"},			-- Arcane Torrent (Focus)
	[129597] = {"silence"},			-- Arcane Torrent (Chi)
	[155145] = {"silence"},			-- Arcane Torrent (Holy Power)
}

local function GetIcon(id)
	local _, _, icon = GetSpellInfo(id)
	return icon
end

T.DiminishingIcons = {
	["stun"] = GetIcon(408),
	["root"] = GetIcon(122),
	["incapacitate"] = GetIcon(118),
	["disorient"] = GetIcon(8122),
	["silence"] = GetIcon(15487),
}