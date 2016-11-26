local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		-- Battle resurrection
		[20484] = 600,	-- Rebirth
		[61999] = 600,	-- Raise Ally
		[20707] = 600,	-- Soulstone
		[126393] = 600,	-- Eternal Guardian (Quilen)
		[159956] = 600,	-- Dust of Life (Moth)
		[159931] = 600,	-- Gift of Chi-Ji (Crane)
		-- Heroism
		[32182] = 300,	-- Heroism
		[2825] = 300,	-- Bloodlust
		[80353] = 300,	-- Time Warp
		[90355] = 300,	-- Ancient Hysteria (Core Hound)
		[160452] = 300,	-- Netherwinds (Nether Ray)
		-- Healing
		[633] = 600,	-- Lay on Hands
		[740] = 180,	-- Tranquility
		[115310] = 180,	-- Revival
		[64843] = 180,	-- Divine Hymn
		[108280] = 180,	-- Healing Tide Totem
		[15286] = 180,	-- Vampiric Embrace
		[108281] = 120,	-- Ancestral Guidance
		-- Defense
		[62618] = 180,	-- Power Word: Barrier
		[33206] = 180,	-- Pain Suppression
		[47788] = 180,	-- Guardian Spirit
		[31821] = 180,	-- Aura Mastery
		[98008] = 180,	-- Spirit Link Totem
		[97462] = 180,	-- Rallying Cry
		[88611] = 180,	-- Smoke Bomb
		[51052] = 120,	-- Anti-Magic Zone
		[116849] = 120,	-- Life Cocoon
		[6940] = 120,	-- Blessing of Sacrifice
		[114030] = 120,	-- Vigilance
		[102342] = 60,	-- Ironbark
		-- Other
		[106898] = 120,	-- Stampeding Roar
	}
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {
		-- Interrupts and Silences
		[57994] = 12,	-- Wind Shear
		[47528] = 15,	-- Mind Freeze
		[106839] = 15,	-- Skull Bash
		[116705] = 15,	-- Spear Hand Strike
		[96231] = 15,	-- Rebuke
		[1766] = 15,	-- Kick
		[6552] = 15,	-- Pummel
		[147362] = 24,	-- Counter Shot
		[2139] = 24,	-- Counterspell
		[19647] = 24,	-- Spell Lock
		[115781] = 24,	-- Optical Blast
		[15487] = 45,	-- Silence
		[47476] = 60,	-- Strangulate
		[78675] = 60,	-- Solar Beam
		-- Crowd Controls
		[115078] = 15,	-- Paralysis
		[20066] = 15,	-- Repentance
		[108194] = 30,	-- Asphyxiate
		[187650] = 30,	-- Freezing Trap
		[8122] = 30,	-- Psychic Scream
		[30283] = 30,	-- Shadowfury
		[107570] = 30,	-- Storm Bolt
		[51514] = 30,	-- Hex
		[5484] = 40,	-- Howl of Terror
		[19386] = 45,	-- Wyvern Sting
		[113724] = 45,	-- Ring of Frost
		[119381] = 45,	-- Leg Sweep
		[64044] = 45,	-- Psychic Horror
		[6789] = 45,	-- Mortal Coil
		[853] = 60,		-- Hammer of Justice
		-- Defense abilities
		[48707] = 45,	-- Anti-Magic Shell
		[31224] = 60,	-- Cloak of Shadows
		[46924] = 60,	-- Bladestorm
		[108978] = 90,	-- Alter Time
		[49039] = 120,	-- Lichborne
		[213664] = 120,	-- Nimble Brew
		[47585] = 120,	-- Dispersion
		[1856] = 120,	-- Vanish
		[7744] = 120,	-- Will of the Forsaken (Racial)
		[186265] = 180,	-- Aspect of the Turtle
		[33206] = 180,	-- Pain Suppression
	}
end

if C.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {
		--GetSpellInfo(6807),	-- Maul
		--GetSpellInfo(35395),	-- Crusader Strike
	}
end