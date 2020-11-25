local T, C, L, _ = unpack(select(2, ...))
if C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.RaidBuffs = {
	DRUID = {
		{774, "TOPRIGHT", {0.8, 0.4, 0.8}},					-- Rejuvenation
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		{33763, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		{102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		{155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	MONK = {
		{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},				-- Renewing Mist
		{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}},			-- Enveloping Mist
		{115175, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Soothing Mist
		{191840, "TOPLEFT", {0.1, 0.4, 0.9}},				-- Essence Font
		{116849, "LEFT", {0.81, 0.85, 0.1}, true},			-- Life Cocoon
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		{156910, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Faith
		{200025, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Virtue
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Blessing of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Blessing of Freedom
		{204013, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},		-- Blessing of Salvation
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Blessing of Sacrifice
		{204018, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},		-- Blessing of Spellwarding
		{287280, "BOTTOMLEFT", {0.9, 0.5, 0.1}},			-- Glimmer of Light
	},
	PRIEST = {
		{194384, "TOPRIGHT", {0.8, 0.4, 0.2}},				-- Atonement
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
		{6788, "BOTTOMLEFT", {1, 0, 0}, true}, 				-- Weakened Soul
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},			-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{47788, "LEFT", {0.86, 0.52, 0}, true},				-- Guardian Spirit
	},
	SHAMAN = {
		{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Riptide
		{204288, "BOTTOMRIGHT", {0.2, 0.7, 0.2}, true},		-- Earth Shield
	},
	HUNTER = {
		{35079, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
	},
	ROGUE = {
		{57934, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Tricks of the Trade
	},
	WARLOCK = {
		{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},				-- Soulstone
	},
	WARRIOR = {
		{114030, "TOPLEFT", {0.2, 0.2, 1}},					-- Vigilance
	},
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true}, 					-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},					-- Warsong flag, Alliance
		{34976, "LEFT", {1, 0, 0}, true}, 					-- Netherstorm Flag
	},
}

T.RaidBuffsIgnore = {
	--[spellID] = true,			-- Spell name
}

local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return "Empty"
	end
end

T.RaidDebuffs = {
-----------------------------------------------------------------
-- Dungeons
-----------------------------------------------------------------
	-- Mythic+ Affixes
	[SpellName(226489)] = 5,	-- Sanguine Ichor
	[SpellName(209858)] = 5,	-- Necrotic Wound
	[SpellName(240559)] = 5,	-- Grievous Wound
	[SpellName(240443)] = 5,	-- Burst

-----------------------------------------------------------------
-- Other
-----------------------------------------------------------------
	[SpellName(87023)] = 4,		-- Cauterize
	[SpellName(94794)] = 4,		-- Rocket Fuel Leak
	[SpellName(116888)] = 4,	-- Shroud of Purgatory
	[SpellName(121175)] = 2,	-- Orb of Power
}

-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
if C.raidframe.plugins_pvp_debuffs == true then
	local PvPDebuffs = {
		-- Death Knight
		[SpellName(108194)] = 3,	-- Asphyxiate
		[SpellName(91797)] = 3,		-- Monstrous Blow (Mutated Ghoul)
		[SpellName(91800)] = 3,		-- Gnaw (Ghoul)
		[SpellName(47476)] = 3,		-- Strangulate
		-- Demon Hunter
		[SpellName(217832)] = 3,	-- Imprison
		[SpellName(211881)] = 3,	-- Fel Eruption
		[SpellName(179057)] = 3,	-- Chaos Nova
		[SpellName(205630)] = 3,	-- Illidan's Grasp
		-- Druid
		[SpellName(33786)] = 3,		-- Cyclone
		[SpellName(78675)] = 3,		-- Solar Beam
		[SpellName(339)] = 2,		-- Entangling Roots
		-- Hunter
		[SpellName(3355)] = 3,		-- Freezing Trap
		[SpellName(19386)] = 3,		-- Wyvern Sting
		[SpellName(117526)] = 3,	-- Binding Shot
		[SpellName(24394)] = 3,		-- Intimidation
		-- Mage
		[SpellName(61305)] = 3,		-- Polymorph
		[SpellName(82691)] = 3,		-- Ring of Frost
		[SpellName(31661)] = 3,		-- Dragon's Breath
		[SpellName(122)] = 2,		-- Frost Nova
		-- Monk
		[SpellName(115078)] = 3,	-- Paralysis
		[SpellName(119381)] = 3,	-- Leg Sweep
		-- Paladin
		[SpellName(20066)] = 3,		-- Repentance
		[SpellName(853)] = 3,		-- Hammer of Justice
		[SpellName(105421)] = 3,	-- Blinding Light
		-- Priest
		[SpellName(605)] = 3,		-- Dominate Mind
		[SpellName(8122)] = 3,		-- Psychic Scream
		[SpellName(64044)] = 3,		-- Psychic Horror
		[SpellName(15487)] = 3,		-- Silence
		[SpellName(284402)] = 3,	-- Vampiric Touch (Don't dispel)
		-- Rogue
		[SpellName(6770)] = 3,		-- Sap
		[SpellName(2094)] = 3,		-- Blind
		[SpellName(1776)] = 3,		-- Gouge
		[SpellName(1330)] = 3,		-- Garrote - Silence
		-- Shaman
		[SpellName(51514)] = 3,		-- Hex
		[SpellName(118905)] = 3,	-- Static Charge
		-- Warlock
		[SpellName(118699)] = 3,	-- Fear
		[SpellName(6789)] = 3,		-- Mortal Coil
		[SpellName(5484)] = 3,		-- Howl of Terror
		[SpellName(6358)] = 3,		-- Seduction (Succubus)
		[SpellName(115268)] = 3,	-- Mesmerize (Shivarra)
		[SpellName(30283)] = 3,		-- Shadowfury
		[SpellName(30108)] = 3,		-- Unstable Affliction (Don't dispel)
		-- Warrior
		[SpellName(46968)] = 3,		-- Shockwave
		[SpellName(132169)] = 3,	-- Storm Bolt
		[SpellName(194958)] = 3,	-- Intimidating Shout
	}

	for spell, prio in pairs(PvPDebuffs) do
		T.RaidDebuffs[spell] = prio
	end
end

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- Spell name
}

T.RaidDebuffsIgnore = {
	--[spellID] = true,			-- Spell name
}

for _, spell in pairs(C.raidframe.plugins_aura_watch_list) do
	T.RaidDebuffs[SpellName(spell)] = 3
end