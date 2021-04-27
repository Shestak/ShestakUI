local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		-- Battle resurrection
		{20484, 600},	-- Rebirth
		{61999, 600},	-- Raise Ally
		{20707, 600},	-- Soulstone
		{265116, 600},	-- Unstable Temporal Time Shifter
		-- Heroism
		{32182, 300},	-- Heroism
		{2825, 300},	-- Bloodlust
		{80353, 300},	-- Time Warp
		{264667, 300},	-- Primal Rage {Hunter's pet]
		-- Healing
		{633, 600},		-- Lay on Hands
		{740, 180},		-- Tranquility
		{115310, 180},	-- Revival
		{64843, 180},	-- Divine Hymn
		{108280, 180},	-- Healing Tide Totem
		{15286, 120},	-- Vampiric Embrace
		{108281, 120},	-- Ancestral Guidance
		-- Defense
		{207399, 300},	-- Ancestral Protection Totem
		{62618, 180},	-- Power Word: Barrier
		{33206, 180},	-- Pain Suppression
		{47788, 180},	-- Guardian Spirit
		{31821, 180},	-- Aura Mastery
		{98008, 180},	-- Spirit Link Totem
		{97462, 180},	-- Rallying Cry
		{196718, 180},	-- Darkness
		{51052, 120},	-- Anti-Magic Zone
		{116849, 120},	-- Life Cocoon
		{6940, 120},	-- Blessing of Sacrifice
		{102342, 90},	-- Ironbark
		-- Other
		{106898, 120},	-- Stampeding Roar
		{192077, 120},	-- Wind Rush Totem
	}

	if #C.raidcooldown.spells_list > 0 then
		T.raid_spells = C.raidcooldown.spells_list
	else
		if C.options.raidcooldown and C.options.raidcooldown.spells_list then
			C.options.raidcooldown.spells_list = nil
		end
	end
	T.RaidSpells = {}
	for _, spell in pairs(T.raid_spells) do
		T.RaidSpells[spell[1]] = spell[2]
	end
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {
		-- Interrupts and Silences
		{57994, 12},	-- Wind Shear
		{47528, 15},	-- Mind Freeze
		{183752, 15},	-- Disrupt
		{106839, 15},	-- Skull Bash
		{187707, 15},	-- Muzzle
		{116705, 15},	-- Spear Hand Strike
		{96231, 15},	-- Rebuke
		{1766, 15},		-- Kick
		{6552, 15},		-- Pummel
		{147362, 24},	-- Counter Shot
		{2139, 24},		-- Counterspell
		{19647, 24},	-- Spell Lock
		{115781, 24},	-- Optical Blast
		{15487, 45},	-- Silence
		{47476, 60},	-- Strangulate
		{78675, 60},	-- Solar Beam
		-- Crowd Controls
		{20066, 15},	-- Repentance
		{51514, 20},	-- Hex
		{187650, 25},	-- Freezing Trap
		{115078, 30},	-- Paralysis
		{8122, 30},		-- Psychic Scream
		{107570, 30},	-- Storm Bolt
		{5484, 40},		-- Howl of Terror
		{30283, 45},	-- Shadowfury
		{108194, 45},	-- Asphyxiate
		{113724, 45},	-- Ring of Frost
		{64044, 45},	-- Psychic Horror
		{6789, 45},		-- Mortal Coil
		{119381, 50},	-- Leg Sweep
		{853, 60},		-- Hammer of Justice
		-- Defense abilities
		{48707, 60},	-- Anti-Magic Shell
		{46924, 60},	-- Bladestorm
		{49039, 120},	-- Lichborne
		{31224, 120},	-- Cloak of Shadows
		{47585, 120},	-- Dispersion
		{1856, 120},	-- Vanish
		{7744, 120},	-- Will of the Forsaken (Racial)
		{186265, 180},	-- Aspect of the Turtle
		{33206, 180},	-- Pain Suppression
	}

	if #C.enemycooldown.spells_list > 0 then
		-- Sync spell list with new changes
		if not C.options.enemycooldown.spells_list_ver or C.options.enemycooldown.spells_list_ver < 2 then
			for i, spell in pairs(C.enemycooldown.spells_list) do
				if spell[1] == 51514 then
					spell[2] = 20
				elseif spell[1] == 187650 then
					spell[2] = 25
				elseif spell[1] == 115078 then
					spell[2] = 30
				elseif spell[1] == 49039 then
					spell[2] = 120
				elseif spell[1] == 31224 then
					spell[2] = 120
				elseif spell[1] == 213664 or spell[1] == 19386 then
					tremove(C.enemycooldown.spells_list, i)
				end
			end

			tinsert(C.enemycooldown.spells_list, {187707, 15})
			C.options.enemycooldown.spells_list_ver = 2
		end
		T.enemy_spells = C.enemycooldown.spells_list
	else
		if C.options.enemycooldown and C.options.enemycooldown.spells_list then
			C.options.enemycooldown.spells_list = nil
		end
	end
	T.EnemySpells = {}
	for _, spell in pairs(T.enemy_spells) do
		T.EnemySpells[spell[1]] = spell[2]
	end
end

if C.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {
		--GetSpellInfo(spellID),	-- Spell name
	}
end