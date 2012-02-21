local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		[20484] = 600,	-- Rebirth
		[61999] = 600,	-- Raise Ally
		[6203] = 900,	-- Soulstone
		[95750] = 900,	-- Soulstone Resurrection
		[20707] = 900,	-- Soulstone Resurrection
		[6346] = 180,	-- Fear Ward
		[29166] = 180,	-- Innervate
		[32182] = 300,	-- Heroism
		[2825] = 300,	-- Bloodlust
		[80353] = 300,	-- Time Warp
		[90355] = 300,	-- Ancient Hysteria
		[16190] = 180,	-- Mana Tide Totem
	}
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {
		-- Interrupts and Silences
		[6552] = 10,	-- Pummel
		[1766] = 10,	-- Kick
		[47528] = 10,	-- Mind Freeze
		[96231] = 10,	-- Rebuke
		[80965] = 10,	-- Skull Bash
		[57994] = 15,	-- Wind Shear
		[34490] = 20,	-- Silencing Shot
		[2139] = 24,	-- Counterspell
		[19647] = 24,	-- Spell Lock
		[15487] = 45,	-- Silence
		[78675] = 60,	-- Solar Bream
		[47476] = 120,	-- Strangulate
		-- Crowd Control
		[8122] = 30,	-- Psychic Scream
		[19503] = 30,	-- Scatter Shot
		[1499] = 30,	-- Freezing Trap
		[5484] = 32,	-- Howl of Terror
		[51514] = 45,	-- Hex
		[85388] = 45,	-- Throwdown
		[44572] = 30,	-- Deep Freeze
		[20066] = 60,	-- Repentance
		[853] = 60,		-- Hammer of Justice
		[49203] = 60,	-- Hungering Cold
		[6789] = 90,	-- Death Coil
		[64044] = 90,	-- Psychic Horror
		[2094] = 120,	-- Blind
		-- Defense abilities
		[48707] = 45,	-- Anti-Magic Shell
		[8143] = 60,	-- Tremor Totem
		[22812] = 60,	-- Barkskin
		[47585] = 75,	-- Dispersion
		[31224] = 90,	-- Cloak of Shadows
		[1856] = 120,	-- Vanish
		[49039] = 120,	-- Lichborne
		[33206] = 180,	-- Pain Suppression
		[45438] = 240,	-- Ice Block
		[1022] = 300,	-- Hand of Protection
		-- Other
		[51722] = 60,	-- Dismantle
		[676] = 60,		-- Disarm
		[46924] = 75,	-- Bladestorm
		[54428] = 120,	-- Divine Plea
		[29166] = 180,	-- Innervate
		[16190] = 180,	-- Mana Tide Totem
	}
end

if C.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {
		--"Spell name",	-- Example
	}
end