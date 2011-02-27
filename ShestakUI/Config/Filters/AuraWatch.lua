----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	AuraWatch
----------------------------------------------------------------------------------------
-- Healer Layout {spell ID, position, {r, g, b, a}, anyUnit}
if SettingsCF.raidframe.plugins_aura_watch == true then
	do
		-- Class buffs
		SettingsDB.buffids = {
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
		
		ORD.ShowDispelableDebuff = SettingsCF.raidframe.plugins_debuffhighlight_icon
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = false
		
		SettingsDB.debuffids = {
		-- Baradin Hold
			-- Argaloth
			95173, 88954,	-- Consuming Darkness
		-- Blackwing Descent
			-- Magmaw
			78941, 91913,	-- Parasitic Infection
			91912, 89773,	-- Mangle
			-- Omintron Defense System
			79889, 91438,	-- Lightning Conductor
			79504, 91535,	-- Flamethrower
			92035, 79501,	-- Acquiring Target
			79835, 91501,	-- Poison Soaked Shell		
			91555, 79629,	-- Power Generator
			80094,			-- Fixate
			-- Maloriak
			77699, 92978,	-- Flash Freeze
			92975, 77763,	-- Biting Chill
			77786, 92971,	-- Consuming Flames
			92989, 78034,	-- Rend
			78617,			-- Fixate
			-- Atramedes
			92421, 77982,	-- Searing Flame
			78023, 92483,	-- Roaring Flame
			92407, 78100,	-- Sonic Breath
			78092,			-- Tracking
			-- Chimaeron
			82881,			-- Break
			89084,			-- Low Health
			-- Nefarian
			81114, 94073,	-- Magma
			94128, 77827,	-- Tail Lash
		-- The Bastion of Twilight
			-- Halfus Wyrmbreaker
			83710, 86169,	-- Furious Roar
			-- Valiona & Theralion
			86505, 92907,	-- Fabulous Flames
			92872, 86844,	-- Devouring Flames
			92881, 92880, 92879, 92877, 92876, 86825, 86788,	-- Blackout
			86622, 86631, 95639, 95640, 95641,					-- Engulfing Magic
			92892, 92891, 92893, 92894, 93064, 92890, 92889, 86202, 88436,	-- Twilight Shift
			88518, 86014, 92860, 92861, 92863, 92864, 92865,	-- Twilight Meteorite
			-- Twilight Ascendant Council
			82660,			-- Burning Blood
			82665,			-- Heart of Ice
			82762,			-- Waterlogged
			83099,			-- Lightning Rod
			92486, 84948,	-- Gravity Crush
			83500,			-- Swirling Winds
			83581,			-- Grounded
			92505, 82772, 92503, 92504,	-- Frozen
			-- Cho'gall
			93187,			-- Corrupted Blood
			82125,			-- Corruption: Malformation
			82170,			-- Corruption: Absolute
			93200, 81831,	-- Corruption: Sickness
			82411, 93132,	-- Debilitating Beam
			91317, 93365, 93366, 93367,	-- Worshipping
		-- Throne of the Four Winds
			-- Conclave of Wind
			-- Nezir
			86111, 93129,	-- Ice Patch
			-- Anshal
			93120, 86282,	-- Toxic Spores
			-- Rohash
			93056, 86182,	-- Slicing Gale
			-- Al'Akir
			87873,			-- Static Shock
			91020, 93258,	-- Ice Storm
			87856, 93283,	-- Squall Line
			88427,			-- Electrocute
			89666, 89668, 93293,	-- Lightning Rod
		-- Other
			5782,			-- Fear
			84853,			-- Dark Pool
			91325,			-- Shadow Vortex
		}
		ORD:RegisterDebuffs(SettingsDB.debuffids)
	end
end