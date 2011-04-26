local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		[20484] = 600,	-- Rebirth
		[6203] = 900,	-- Soulstone
		[6346] = 180,	-- Fear Ward
		[29166] = 180,	-- Innervate
		[32182] = 300,	-- Heroism
		[2825] = 300,	-- Bloodlust
		[80353] = 300,	-- Time Warp
		[90355] = 300,	-- Ancient Hysteria
	}
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {
		[1766] = 10,	-- Kick
		[6552] = 10,	-- Pummel
		[2139] = 24,	-- Counterspell
		[19647] = 24,	-- Spell Lock
		[8122] = 30,	-- Psychic Scream
		[47476] = 120,	-- Strangulate
		[47528] = 10,	-- Mind Freeze
		[29166] = 180,	-- Innervate
		[49039] = 120,	-- Lichborne
		[54428] = 120,	-- Divine Plea
		[1022] = 300,	-- Hand of Protection
		[16190] = 180,	-- Mana Tide Totem
		[51514] = 45,	-- Hex
		[15487] = 45,	-- Silence
		[2094] = 120,	-- Blind
		[33206] = 180,	-- Pain Suppression
		[34490] = 20,	-- Silencing Shot
		[1499] = 30,	-- Freezing Trap
		[16979] = 15,	-- Feral Charge - Bear
		[49376] = 30,	-- Feral Charge - Cat
		[96231] = 10,	-- Rebuke
		[44572] = 30,	-- Deep Freeze
		[31224] = 90,	-- Cloak of Shadows
		[47585] = 75,	-- Dispersion
		[46924] = 75,	-- Bladestorm
		[48707] = 45,	-- Anti-Magic Shell
		[19503] = 30,	-- Scatter Shot
		[51722] = 60,	-- Dismantle
		[676] = 60,		-- Disarm
		[1856] = 120,	-- Vanish
		[22812] = 60,	-- Barkskin
		[80965] = 10,	-- Skull Bash
		[78675] = 60,	-- Solar Bream
		[6789] = 90,	-- Death Coil
		[64044] = 90,	-- Psychic Horror
		[20066] = 60,	-- Repentance
		[45438] = 240,	-- Ice Block
		[8143] = 60,	-- Tremor Totem
	}
end

if C.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {
		--"Spell name",	-- Example
	}
end