local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true or C.unitframe.plugins_diminishing ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Fear -> http://www.wowhead.com/spell=5782
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.DiminishingSpells = function()
	return {
		-- Control Roots
		[96294] = {"ctrlroot"},		-- Chains of Ice
		[339] = {"ctrlroot"},		-- Entangling Roots
		[19975] = {"ctrlroot"},		-- Nature's Grasp
		[102359] = {"ctrlroot"},	-- Mass Entanglement
		[50245] = {"ctrlroot"},		-- Pin (Crab)
		[4167] = {"ctrlroot"},		-- Web (Spider)
		[54706] = {"ctrlroot"},		-- Venom Web Spray (Silithid)
		[90327] = {"ctrlroot"},		-- Lock Jaw (Dog)
		[128405] = {"ctrlroot"},	-- Narrow Escape
		[122] = {"ctrlroot"},		-- Frost Nova
		[33395] = {"ctrlroot"},		-- Freeze (Water Elemental)
		[116706] = {"ctrlroot"},	-- Disable
		[114404] = {"ctrlroot"},	-- Void Tendril's Grasp
		[64695] = {"ctrlroot"},		-- Earthgrab
		[63685] = {"ctrlroot"},		-- Freeze
		[107566] = {"ctrlroot"},	-- Staggering Shout

		-- Control Stuns
		[108194] = {"ctrlstun"},	-- Asphyxiate
		[47481] = {"ctrlstun"},		-- Gnaw (Ghoul)
		[91797] = {"ctrlstun"},		-- Monstrous Blow (Mutated Ghoul)
		[115001] = {"ctrlstun"},	-- Remorseless Winter
		[22570] = {"ctrlstun"},		-- Maim
		[9005] = {"ctrlstun"},		-- Pounce
		[5211] = {"ctrlstun"},		-- Mighty Bash
		[102795] = {"ctrlstun"},	-- Bear Hug
		[19577] = {"ctrlstun"},		-- Intimidation
		[90337] = {"disorient"},	-- Bad Manner (Monkey)
		[50519] = {"ctrlstun"},		-- Sonic Blast (Bat)
		--[56626] = {"ctrlstun"},		-- Sting (Wasp)
		[117526] = {"ctrlstun"},	-- Binding Shot
		[44572] = {"ctrlstun"},		-- Deep Freeze
		[118271] = {"ctrlstun"},	-- Combustion Impact
		[119392] = {"ctrlstun"},	-- Charging Ox Wave
		[119381] = {"ctrlstun"},	-- Leg Sweep
		[122242] = {"ctrlstun"},	-- Clash
		[120086] = {"ctrlstun"},	-- Fists of Fury
		[853] = {"ctrlstun"},		-- Hammer of Justice
		[105593] = {"ctrlstun"},	-- Fist of Justice
		[115752] = {"ctrlstun"},	-- Blinding Light
		[119072] = {"ctrlstun"},	-- Holy Wrath
		--[88625] = {"ctrlstun"},		-- Holy Word: Chastise
		[1833] = {"ctrlstun"},		-- Cheap Shot
		[408] = {"ctrlstun"},		-- Kidney Shot
		[118905] = {"ctrlstun"},	-- Static Charge
		[30283] = {"ctrlstun"},		-- Shadowfury
		[89766] = {"ctrlstun"},		-- Axe Toss (Felguard)
		[132168] = {"ctrlstun"},	-- Shockwave
		[132169] = {"ctrlstun"},	-- Storm Bolt
		[105771] = {"ctrlstun"},	-- Warbringer
		[20549] = {"ctrlstun"},		-- War Stomp

		-- Disarms
		[50541] = {"disarm"},		-- Clench (Scorpid)
		[91644] = {"disarm"},		-- Snatch (Bird of Prey)
		[117368] = {"disarm"},		-- Grapple Weapon
		[64058] = {"disarm"},		-- Psychic Horror
		[51722] = {"disarm"},		-- Dismantle
		[118093] = {"disarm"},		-- Disarm (Voidwalker/Voidlord)
		[676] = {"disarm"},			-- Disarm

		-- Disorients
		[2637] = {"disorient"},		-- Hibernate
		[99] = {"disorient"},		-- Disorienting Roar
		[3355] = {"disorient"},		-- Freezing Trap
		[19386] = {"disorient"},	-- Wyvern Sting
		[118] = {"disorient"},		-- Polymorph
		[28272] = {"disorient"},	-- Polymorph (Pig)
		[28271] = {"disorient"},	-- Polymorph (Turtle)
		[61305] = {"disorient"},	-- Polymorph (Black Cat)
		[61025] = {"disorient"},	-- Polymorph (Serpent)
		[61721] = {"disorient"},	-- Polymorph (Rabbit)
		[61780] = {"disorient"},	-- Polymorph (Turkey)
		[82691] = {"disorient"},	-- Ring of Frost
		[115078] = {"disorient"},	-- Paralysis
		[20066] = {"disorient"},	-- Repentance
		[9484] = {"disorient"},		-- Shackle Undead
		[1776] = {"disorient"},		-- Gouge
		[6770] = {"disorient"},		-- Sap
		[51514] = {"disorient"},	-- Hex
		[107079] = {"disorient"},	-- Quaking Palm

		-- Fears
		[1513] = {"fear"},			-- Scare Beast
		[10326] = {"fear"},			-- Turn Evil
		[105421] = {"fear"},		-- Blinding Light
		[8122] = {"fear"},			-- Psychic Scream
		[113792] = {"fear"},		-- Psychic Terror
		[2094] = {"fear"},			-- Blind
		[118699] = {"fear"},		-- Fear
		[5484] = {"fear"},			-- Howl of Terror
		[6358] = {"fear"},			-- Seduction (Succubus)
		[115268] = {"fear"},		-- Mesmerize (Shivarra)
		[5246] = {"fear"},			-- Intimidating Shout (Main target)
		[20511] = {"fear"},			-- Intimidating Shout (Secondary targets)

		-- Horrors
		[64044] = {"horror"},		-- Psychic Horror
		[87204] = {"horror"},		-- Sin and Punishment
		[6789] = {"horror"},		-- Mortal Coil

		-- Random Stuns
		[113953] = {"rndstun"},		-- Paralysis (Poison)
		[77505] = {"rndstun"},		-- Earthquake
		[85387] = {"rndstun"},		-- Aftermath
		[118895] = {"rndstun"},		-- Dragon Roar

		-- Silences
		[47476] = {"silence"},		-- Strangulate
		[81261] = {"silence"},		-- Solar Beam
		[34490] = {"silence"},		-- Silencing Shot
		[50479] = {"silence"},		-- Nether Shock (Nether Ray)
		[55021] = {"silence"},		-- Improved Counterspell
		[102051] = {"silence"},		-- Frostjaw
		[116709] = {"silence"},		-- Spear Hand Strike
		[31935] = {"silence"},		-- Avenger's Shield
		[15487] = {"silence"},		-- Silence
		[1330] = {"silence"},		-- Garrote
		[24259] = {"silence"},		-- Spell Lock (Felhunter)
		[115782] = {"silence"},		-- Optical Blast (Observer)
		[18498] = {"silence"},		-- Gag Order (Warrior glyph)
		[25046] = {"silence"},		-- Arcane Torrent (Energy version)
		[28730] = {"silence"},		-- Arcane Torrent (Mana version)
		[50613] = {"silence"},		-- Arcane Torrent (Runic power version)
		[69179] = {"silence"},		-- Arcane Torrent (Rage version)
		[80483] = {"silence"},		-- Arcane Torrent (Focus version)

		-- Misc
		[33786] = {"cyclone"},		-- Cyclone
		[19185] = {"entrapment"},	-- Entrapment
		[31661] = {"ds"},			-- Dragon's Breath
		[19503] = {"ds"},			-- Scatter Shot
		[605] = {"mind"},			-- Dominate Mind
	}
end

T.DiminishingIcons = function()
	return {
		["ctrlstun"] = select(3, GetSpellInfo(408)),
		["ctrlroot"] = select(3, GetSpellInfo(122)),
		["cyclone"] = select(3, GetSpellInfo(33786)),
		["disarm"] = select(3, GetSpellInfo(676)),
		["disorient"] = select(3, GetSpellInfo(118)),
		["ds"] = select(3, GetSpellInfo(31661)),
		["entrapment"] = select(3, GetSpellInfo(19185)),
		["fear"] = select(3, GetSpellInfo(8122)),
		["horror"] = select(3, GetSpellInfo(64044)),
		["mind"] = select(3, GetSpellInfo(605)),
		["rndstun"] = select(3, GetSpellInfo(118895)),
		["silence"] = select(3, GetSpellInfo(55021)),
	}
end