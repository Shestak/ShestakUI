local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		-- Battle resurrection
		[20484] = 1800,	-- Rebirth
		[27740] = 3600,	-- Reincarnation (3600sec base / -1200sec from talents / -600sec for Totem)
		-- Jumper Cables
		-- [8342] = 1800,	-- Goblin Jumper Cables
		-- [22999] = 1800,	-- Goblin Jumper Cables XL
		-- Healing
		[740] = 300,	-- Tranquility
		[724] = 600,	-- Lightwell
		-- Defense
		[1022] = 300,	-- Blessing of Protection (300sec base / -120sec from talents)
		[633] = 3600,	-- Lay on Hands (3600sec base / -1200sec from talents)
		[871] = 1800,	-- Shield Wall
		[12975] = 600,	-- Last Stand
		-- Taunts
		[5209] = 600,	-- Challenging Roar
		[1161] = 600,	-- Challenging Shout
		[694] = 120,	-- Mocking Blow
		-- Mana Regeneration
		[29166] = 360,	-- Innervate
		[16190] = 300,	-- Mana Tide Totem
		-- Other
		[6346] = 30,	-- Fear Ward
		[10060] = 180,	-- Power Infusion
	}
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {
		-- Interrupts and Silences
		[2139] = 30,	-- Counterspell
		[15487] = 45,	-- Silence
		[1766] = 10,	-- Kick
		[8042] = 5,		-- Earth Shock (5sec base / -1sec from talents)
		[19244] = 30,	-- Spell Lock (Felhunter)
		[6552] = 10,	-- Pummel
		-- Crowd Controls
		[1499] = 15,	-- Freezing Trap
		[19503] = 30,	-- Scatter Shot
		[19386] = 120,	-- Wyvern Sting
		[11113] = 45,	-- Blast Wave
		[853] = 50,		-- Hammer of Justice (60sec base / -15sec from talents)
		[20066] = 60,	-- Repentance
		[6789] = 120,	-- Death Coil (120sec base / -18sec from ZG Set)
		[8122] = 30,	-- Psychic Scream (30sec base / -4sec from talents)
		[2094] = 210,	-- Blind (300sec base / -90sec from talents)
		[5484] = 40,	-- Howl of Terror
		[12809] = 45,	-- Concussion Blow
		-- Defense abilities
		[22812] = 60,	-- Barkskin
		[19263] = 300,	-- Deterrence
		[11958] = 300,	-- Ice Block
		[1044] = 20,	-- Blessing of Freedom
		[1022] = 180,	-- Blessing of Protection (300sec base / -120sec from talents)
		[498] = 300,	-- Divine Protection
		[642] = 300,	-- Divine Shield
		[6346] = 30,	-- Fear Ward
		[5277] = 210,	-- Evasion (-90sec from talents)
		[1856] = 210,	-- Vanish (300sec base / -90sec from talents)
		-- [8178] = 13,	-- Grounding Totem (15sec base / -2sec from talents)
		[18499] = 30,	-- Berserker Rage
		[20600] = 180,	-- Perception
		[20594] = 180,	-- Stoneform
		[7744] = 120,	-- Will of the Forsaken
		-- Heals
		-- Disarms
		-- [14251] = 6,		-- Riposte
		[676] = 60,		-- Disarm
		-- Mana Regeneration
		[29166] = 360,	-- Innervate
		[16190] = 300,	-- Mana Tide Totem
		-- Trinket (TEMPORARY)
		[23277] = 300,	-- PvP Trinket (Druid)
		[5579] = 300,	-- PvP Trinket (Hunter/Shaman/Warrior)
		[23274] = 300,	-- PvP Trinket (Mage)
		[23276] = 300,	-- PvP Trinket (Paladin/Priest)
		[23273] = 300,	-- PvP Trinket (Rogue/Warlock)
	}
end

if C.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {
		--GetSpellInfo(spellID),	-- Spell name
	}
end