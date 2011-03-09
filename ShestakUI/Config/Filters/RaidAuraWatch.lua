local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidframe.plugins_aura_watch == true then
	do
		-- Class buffs
		T.buffids = {
			PRIEST = {
				{6788, "TOPRIGHT", {1, 0, 0}, true},			-- Weakened Soul
				{33076, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},		-- Prayer of Mending
				{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 			-- Renew
				{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},		-- Power Word: Shield
				{10060, "RIGHT", {0.89, 0.1, 0.1}},				-- Power Infusion
				{33206, "LEFT", {0.89, 0.1, 0.1}, true},		-- Pain Suppress
				{47788, "LEFT", {0.86, 0.52, 0}, true},			-- Hand of Freedom
			},
			DRUID = {
				{774, "TOPRIGHT", {0.8, 0.4, 0.8}},				-- Rejuvenation
				{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},			-- Regrowth
				{94447, "TOPLEFT", {0.4, 0.8, 0.2}},			-- Lifebloom
				{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},			-- Wild Growth
			},
			PALADIN = {
				{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},			-- Beacon of Light
				{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},		-- Hand of Protection
				{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	-- Hand of Freedom
				{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},	-- Hand of Salvation
			},
			SHAMAN = {
				{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},			-- Riptide 
				{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},		-- Earth Shield
				{16236, "TOPLEFT", {0.4, 0.7, 0.2}},			-- Ancestral Fortitude
				{51945, "BOTTOMRIGHT", {0.7, 0.4, 0}},			-- Earthliving
			},
			ROGUE = {
				{57933, "TOPRIGHT", {0.89, 0.1, 0.1}},			-- Tricks of the Trade
			},
			DEATHKNIGHT = {
				{49016, "TOPRIGHT", {0.89, 0.89, 0.1}},			-- Unholy Frenzy
			},
			MAGE = {
				{54646, "TOPRIGHT", {0.2, 0.2, 1}},				-- Focus Magic
			},
			WARRIOR = {
				{59665, "TOPLEFT", {0.2, 0.2, 1}},				-- Vigilance
				{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},			-- Intervene
			},
			HUNTER = {
				{34477, "TOPRIGHT", {0.2, 0.2, 1}},				-- Misdirection
			},
			WARLOCK = {
				{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},			-- Soulstone Resurrection
			},
			ALL = {
				{23333, "LEFT", {1, 0, 0}, true}, 				-- Warsong flag
				{34976, "LEFT", {1, 0, 0}, true}, 				-- Netherstorm Flag
				{64413, "RIGHT", {0.8, 0.2, 0}, true},			-- Protection of Ancient Kings
			},
		}
	end
	
	-- Raid debuffs
	do
		local _, ns = ...
		local ORD = ns.oUF_RaidDebuffs or oUF_RaidDebuffs

		if not ORD then return end
		
		ORD.ShowDispelableDebuff = C.raidframe.plugins_debuffhighlight_icon
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = true
		
		local function SpellName(id)
			local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id) 	
			return name	
		end
		
		T.debuffids = {
		-- Baradin Hold
			-- Argaloth
			SpellName(95173),	-- Consuming Darkness
		-- Blackwing Descent
			-- Magmaw
			SpellName(94679),	-- Parasitic Infection
			SpellName(94617),	-- Mangle
			SpellName(91911),	-- Constricting Chains
			-- Omintron Defense System
			SpellName(91433),	-- Lightning Conductor
			SpellName(91535),	-- Flamethrower
			SpellName(80161),	-- Chemical Cloud
			SpellName(92035),	-- Acquiring Target
			SpellName(79835),	-- Poison Soaked Shell		
			SpellName(91555),	-- Power Generator
			SpellName(80094),	-- Fixate
			SpellName(91521),	-- Incineration Security Measure
			-- Maloriak
			SpellName(77699),	-- Flash Freeze
			SpellName(77760),	-- Biting Chill
			SpellName(92971),	-- Consuming Flames
			SpellName(92989),	-- Rend
			SpellName(78617),	-- Fixate
			-- Atramedes
			SpellName(92423),	-- Searing Flame
			SpellName(92485),	-- Roaring Flame
			SpellName(92407),	-- Sonic Breath
			SpellName(78092),	-- Tracking
			-- Chimaeron
			SpellName(82881),	-- Break
			SpellName(89084),	-- Low Health
			-- Nefarian
			SpellName(81114),	-- Magma
			SpellName(94128),	-- Tail Lash
			-- Sinestra
			SpellName(92956),	-- Wrack
		-- The Bastion of Twilight
			-- Halfus Wyrmbreaker
			SpellName(83710),	-- Furious Roar
			SpellName(39171),	-- Malevolent Strikes
			-- Valiona & Theralion
			SpellName(86505),	-- Fabulous Flames
			SpellName(86840),	-- Devouring Flames
			SpellName(92878),	-- Blackout
			SpellName(95639),	-- Engulfing Magic
			SpellName(93051),	-- Twilight Shift
			SpellName(92886),	-- Twilight Zone
			SpellName(88518),	-- Twilight Meteorite
			-- Twilight Ascendant Council
			SpellName(82660),	-- Burning Blood
			SpellName(82665),	-- Heart of Ice
			SpellName(82762),	-- Waterlogged
			SpellName(83099),	-- Lightning Rod
			SpellName(92488),	-- Gravity Crush
			SpellName(83500),	-- Swirling Winds
			SpellName(83581),	-- Grounded
			SpellName(92505),	-- Frozen
			SpellName(92511),	-- Hydro Lance
			SpellName(92518),	-- Flame Torrent
			SpellName(92075),	-- Gravity Core
			-- Cho'gall
			SpellName(93187),	-- Corrupted Blood
			SpellName(82125),	-- Corruption: Malformation
			SpellName(82170),	-- Corruption: Absolute
			SpellName(93200),	-- Corruption: Sickness
			SpellName(82411),	-- Debilitating Beam
			SpellName(91317),	-- Worshipping
			SpellName(86028),	-- Cho's Blast
			SpellName(86029),	-- Gall's Blast
		-- Throne of the Four Winds
			-- Conclave of Wind
			-- Nezir
			SpellName(93131),	-- Ice Patch
			-- Anshal
			SpellName(86206),	-- Soothing Breeze
			SpellName(93122),	-- Toxic Spores
			-- Rohash
			SpellName(93058),	-- Slicing Gale
			-- Al'Akir
			SpellName(87873),	-- Static Shock
			SpellName(93260),	-- Ice Storm
			SpellName(87856),	-- Squall Line
			SpellName(88427),	-- Electrocute
			SpellName(93295),	-- Lightning Rod
		-- Other
			SpellName(67479),	-- Impale
			SpellName(5782),	-- Fear
			SpellName(84853),	-- Dark Pool
			SpellName(91325),	-- Shadow Vortex
		}
		
		T.ReverseTimer = {
		-- Sinestra
			[92956] = true,		-- Wrack
		}
		
		ORD:RegisterDebuffs(T.debuffids)
	end
end