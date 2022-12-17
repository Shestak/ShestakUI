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
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		{33763, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		{155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	EVOKER = {
		{355941, "TOPRIGHT", {0.20, 0.58, 0.50}},			-- Dream Breath
		{363502, "BOTTOMLEFT", {0.26, 0.73, 0.63}},			-- Dream Flight
		{366155, "RIGHT", {0.14, 1.00, 0.88}},				-- Reversion
		{364343, "TOP", {0.13, 0.87, 0.50}},				-- Echo
		{357170, "BOTTOM", {0.11, 0.57, 0.71}},				-- Time Dilation
	},
	MONK = {
		{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},				-- Renewing Mist
		{115175, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Soothing Mist
		{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}},			-- Enveloping Mist
		{191840, "TOPLEFT", {0.1, 0.4, 0.9}},				-- Essence Font
		{116849, "LEFT", {0.81, 0.85, 0.1}, true},			-- Life Cocoon
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		{156910, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Faith
		{200025, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Virtue
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Blessing of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Blessing of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Blessing of Sacrifice
		{204018, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},		-- Blessing of Spellwarding
		{287280, "BOTTOMLEFT", {0.9, 0.5, 0.1}},			-- Glimmer of Light
		{223306, "TOPLEFT", {0.8, 0.8, 0.1}},				-- Bestow Faith
	},
	PRIEST = {
		{194384, "TOPRIGHT", {0.8, 0.4, 0.2}},				-- Atonement
		{139, "TOPRIGHT", {0.4, 0.7, 0.2}},					-- Renew
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{6788, "BOTTOMLEFT", {1, 0, 0}},					-- Weakened Soul
		{17, "TOPLEFT", {0.81, 0.85, 0.1}},					-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{47788, "LEFT", {0.86, 0.52, 0}, true},				-- Guardian Spirit
	},
	SHAMAN = {
		{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Riptide
		{204288, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Earth Shield
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
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true},					-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},					-- Warsong flag, Alliance
		{34976, "LEFT", {1, 0, 0}, true},					-- Netherstorm Flag
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
-- Vault of the Incarnates
-----------------------------------------------------------------
	-- Eranog
	[SpellName(370648)] = 5,	-- Primal Flow
	[SpellName(390715)] = 6,	-- Primal Rifts
	[SpellName(370597)] = 6,	-- Kill Order
	-- Terros
	[SpellName(382776)] = 5,	-- Awakened Earth
	[SpellName(386352)] = 3,	-- Rock Blast
	[SpellName(382458)] = 6,	-- Resonant Aftermath
	-- The Primal Council
	[SpellName(371624)] = 5,	-- Conductive Mark
	[SpellName(372027)] = 4,	-- Slashing Blaze
	[SpellName(374039)] = 4,	-- Meteor Axe
	-- Sennarth, the Cold Breath
	[SpellName(371976)] = 4,	-- Chilling Blast
	[SpellName(372082)] = 5,	-- Enveloping Webs
	[SpellName(374659)] = 4,	-- Rush
	[SpellName(374104)] = 5,	-- Wrapped in Webs Slow
	[SpellName(374503)] = 6,	-- Wrapped in Webs Stun
	[SpellName(373048)] = 3,	-- Suffocating Webs
	-- Dathea, Ascended
	[SpellName(391686)] = 5,	-- Conductive Mark
	[SpellName(378277)] = 2,	-- Elemental Equilbrium
	[SpellName(388290)] = 4,	-- Cyclone
	-- Kurog Grimtotem
	[SpellName(377780)] = 5,	-- Skeletal Fractures
	[SpellName(372514)] = 5,	-- Frost Bite
	[SpellName(374554)] = 4,	-- Lava Pool
	[SpellName(374023)] = 6,	-- Searing Carnage
	[SpellName(374427)] = 6,	-- Ground Shatter
	[SpellName(390920)] = 5,	-- Shocking Burst
	[SpellName(372458)] = 6,	-- Below Zero
	-- Broodkeeper Diurna
	[SpellName(388920)] = 6,	-- Frozen Shroud
	[SpellName(378782)] = 5,	-- Mortal Wounds
	[SpellName(378787)] = 5,	-- Crushing Stoneclaws
	[SpellName(375620)] = 6,	-- Ionizing Charge
	[SpellName(375578)] = 4,	-- Flame Sentry
	-- Raszageth the Storm-Eater
		-- TODO: DF

-----------------------------------------------------------------
-- Dungeons
-----------------------------------------------------------------
	-- Mythic+ Affixes
	[SpellName(226512)] = 3,	-- Sanguine
	[SpellName(240559)] = 3,	-- Grievous
	[SpellName(240443)] = 3,	-- Bursting
	-- Dragonflight Season 1
	[SpellName(396369)] = 6,	-- Mark of Lightning
	[SpellName(396364)] = 6,	-- Mark of Wind

-----------------------------------------------------------------
-- Dragonflight (Season 1)
-----------------------------------------------------------------
	-- Court of Stars
	[SpellName(207278)] = 3,	-- Arcane Lockdown
	[SpellName(209516)] = 3,	-- Mana Fang
	[SpellName(209512)] = 3,	-- Disrupting Energy
	[SpellName(211473)] = 3,	-- Shadow Slash
	[SpellName(207979)] = 3,	-- Shockwave
	[SpellName(207981)] = 3,	-- Disintegration Beam
	[SpellName(211464)] = 3,	-- Fel Detonation
	[SpellName(208165)] = 3,	-- Withering Soul
	[SpellName(209413)] = 3,	-- Suppress
	[SpellName(209027)] = 3,	-- Quelling Strike
	-- Halls of Valor
	[SpellName(197964)] = 3,	-- Runic Brand
	[SpellName(193783)] = 3,	-- Aegis of Aggramar
	[SpellName(196838)] = 3,	-- Scent of Blood
	[SpellName(199674)] = 3,	-- Wicked Dagger
	[SpellName(193260)] = 3,	-- Static Field
	[SpellName(199652)] = 3,	-- Sever
	[SpellName(198944)] = 3,	-- Breach Armor
	[SpellName(215429)] = 3,	-- Thunderstrike
	[SpellName(203963)] = 3,	-- Eye of the Storm
	-- Shadowmoon Burial Grounds
	[SpellName(156776)] = 3,	-- Rending Voidlash
	[SpellName(153692)] = 3,	-- Necrotic Pitch
	[SpellName(153524)] = 3,	-- Plague Spit
	[SpellName(154469)] = 3,	-- Ritual of Bones
	[SpellName(162652)] = 3,	-- Lunar Purity
	[SpellName(164907)] = 3,	-- Void Cleave
	[SpellName(152979)] = 3,	-- Soul Shred
	[SpellName(158061)] = 3,	-- Blessed Waters of Purity
	[SpellName(154442)] = 3,	-- Malevolence
	[SpellName(153501)] = 3,	-- Void Blast
	-- Temple of the Jade Serpent
	[SpellName(396150)] = 3,	-- Feeling of Superiority
	[SpellName(397878)] = 3,	-- Tainted Ripple
	[SpellName(106113)] = 3,	-- Touch of Nothingness
	[SpellName(397914)] = 3,	-- Defiling Mist
	[SpellName(397904)] = 3,	-- Setting Sun Kick
	[SpellName(397911)] = 3,	-- Touch of Ruin
	[SpellName(395859)] = 3,	-- Haunting Scream
	[SpellName(374037)] = 3,	-- Overwhelming Rage
	[SpellName(396093)] = 3,	-- Savage Leap
	[SpellName(106823)] = 3,	-- Serpent Strike
	[SpellName(396152)] = 3,	-- Feeling of Inferiority
	[SpellName(110125)] = 3,	-- Shattered Resolve
	[SpellName(397797)] = 3,	-- Corrupted Vortex
	-- Ruby Life Pools
	[SpellName(392406)] = 3,	-- Thunderclap
	[SpellName(372820)] = 3,	-- Scorched Earth
	[SpellName(384823)] = 3,	-- Inferno
	[SpellName(381862)] = 3,	-- Infernocore
	[SpellName(372860)] = 3,	-- Searing Wounds
	[SpellName(373869)] = 3,	-- Burning Touch
	[SpellName(385536)] = 3,	-- Flame Dance
	[SpellName(381518)] = 3,	-- Winds of Change
	[SpellName(372858)] = 3,	-- Searing Blows
	[SpellName(373589)] = 3,	-- Primal Chill
	[SpellName(373693)] = 3,	-- Living Bomb
	[SpellName(392924)] = 3,	-- Shock Blast
	[SpellName(381515)] = 3,	-- Stormslam
	[SpellName(396411)] = 3,	-- Primal Overload
	[SpellName(384773)] = 3,	-- Flaming Embers
	[SpellName(392451)] = 3,	-- Flashfire
	[SpellName(372697)] = 3,	-- Jagged Earth
	[SpellName(372047)] = 3,	-- Flurry
	[SpellName(372963)] = 3,	-- Chillstorm
	-- The Nokhud Offensive
	[SpellName(382628)] = 3,	-- Surge of Power
	[SpellName(386025)] = 3,	-- Tempest
	[SpellName(381692)] = 3,	-- Swift Stab
	[SpellName(387615)] = 3,	-- Grasp of the Dead
	[SpellName(387629)] = 3,	-- Rotting Wind
	[SpellName(386912)] = 3,	-- Stormsurge Cloud
	[SpellName(395669)] = 3,	-- Aftershock
	[SpellName(384134)] = 3,	-- Pierce
	[SpellName(388451)] = 3,	-- Stormcaller's Fury
	[SpellName(395035)] = 3,	-- Shatter Soul
	[SpellName(376899)] = 3,	-- Crackling Cloud
	[SpellName(384492)] = 3,	-- Hunter's Mark
	[SpellName(376730)] = 3,	-- Stormwinds
	[SpellName(376894)] = 3,	-- Crackling Upheaval
	[SpellName(388801)] = 3,	-- Mortal Strike
	[SpellName(376827)] = 3,	-- Conductive Strike
	[SpellName(376864)] = 3,	-- Static Spear
	[SpellName(375937)] = 3,	-- Rending Strike
	[SpellName(376634)] = 3,	-- Iron Spear
	-- The Azure Vault
	[SpellName(388777)] = 3,	-- Oppressive Miasma
	[SpellName(386881)] = 3,	-- Frost Bomb
	[SpellName(387150)] = 3,	-- Frozen Ground
	[SpellName(387564)] = 3,	-- Mystic Vapors
	[SpellName(385267)] = 3,	-- Crackling Vortex
	[SpellName(386640)] = 3,	-- Tear Flesh
	[SpellName(374567)] = 3,	-- Explosive Brand
	[SpellName(374523)] = 3,	-- Arcane Roots
	[SpellName(375596)] = 3,	-- Erratic Growth Channel
	[SpellName(375602)] = 3,	-- Erratic Growth
	[SpellName(370764)] = 3,	-- Piercing Shards
	[SpellName(384978)] = 3,	-- Dragon Strike
	[SpellName(375649)] = 3,	-- Infused Ground
	[SpellName(387151)] = 3,	-- Icy Devastator
	[SpellName(377488)] = 3,	-- Icy Bindings
	[SpellName(374789)] = 3,	-- Infused Strike
	[SpellName(371007)] = 3,	-- Splintering Shards
	[SpellName(375591)] = 3,	-- Sappy Burst
	[SpellName(385409)] = 3,	-- Ouch, ouch, ouch!
	-- Algeth'ar Academy
	[SpellName(389033)] = 3,	-- Lasher Toxin
	[SpellName(391977)] = 3,	-- Oversurge
	[SpellName(386201)] = 3,	-- Corrupted Mana
	[SpellName(389011)] = 3,	-- Overwhelming Power
	[SpellName(387932)] = 3,	-- Astral Whirlwind
	[SpellName(396716)] = 3,	-- Splinterbark
	[SpellName(388866)] = 3,	-- Mana Void
	[SpellName(386181)] = 3,	-- Mana Bomb
	[SpellName(388912)] = 3,	-- Severing Slash
	[SpellName(377344)] = 3,	-- Peck
	[SpellName(376997)] = 3,	-- Savage Peck
	[SpellName(388984)] = 3,	-- Vicious Ambush
	[SpellName(388544)] = 3,	-- Barkbreaker
	[SpellName(377008)] = 3,	-- Deafening Screech

-----------------------------------------------------------------
-- Dragonflight (Season 2)
-----------------------------------------------------------------
	-- Brackenhide Hollow
	-- Halls of Infusion
	-- Neltharus
	-- Uldaman: Legacy of Tyr

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
		[SpellName(108194)] = 4,	-- Asphyxiate
		[SpellName(91797)] = 4,		-- Monstrous Blow (Mutated Ghoul)
		[SpellName(91800)] = 4,		-- Gnaw (Ghoul)
		[SpellName(287254)] = 4,	-- Dead of Winter
		[SpellName(47476)] = 3,		-- Strangulate
		-- Demon Hunter
		[SpellName(217832)] = 4,	-- Imprison
		[SpellName(211881)] = 4,	-- Fel Eruption
		[SpellName(179057)] = 4,	-- Chaos Nova
		[SpellName(205630)] = 4,	-- Illidan's Grasp
		[SpellName(207685)] = 4,	-- Sigil of Misery
		[SpellName(204490)] = 3,	-- Sigil of Silence
		-- Druid
		[SpellName(33786)] = 4,		-- Cyclone
		[SpellName(5211)] = 4,		-- Mighty Bash
		[SpellName(22570)] = 4,		-- Maim
		[SpellName(78675)] = 3,		-- Solar Beam
		[SpellName(339)] = 2,		-- Entangling Roots
		-- Hunter
		[SpellName(3355)] = 4,		-- Freezing Trap
		[SpellName(24394)] = 4,		-- Intimidation
		[SpellName(213691)] = 4,	-- Scatter Shot
		[SpellName(117526)] = 2,	-- Binding Shot
		-- Mage
		[SpellName(61305)] = 4,		-- Polymorph
		[SpellName(82691)] = 4,		-- Ring of Frost
		[SpellName(31661)] = 4,		-- Dragon's Breath
		[SpellName(122)] = 2,		-- Frost Nova
		-- Monk
		[SpellName(115078)] = 4,	-- Paralysis
		[SpellName(119381)] = 4,	-- Leg Sweep
		[SpellName(120086)] = 4,	-- Fists of Fury
		[SpellName(198898)] = 4,	-- Song of Chi-Ji
		-- Paladin
		[SpellName(20066)] = 4,		-- Repentance
		[SpellName(853)] = 4,		-- Hammer of Justice
		[SpellName(105421)] = 4,	-- Blinding Light
		-- Priest
		[SpellName(605)] = 4,		-- Dominate Mind
		[SpellName(8122)] = 4,		-- Psychic Scream
		[SpellName(64044)] = 4,		-- Psychic Horror
		[SpellName(205369)] = 4,	-- Mind Bomb
		[SpellName(87204)] = 4,		-- Sin and Punishment
		[SpellName(200196)] = 4,	-- Holy Word: Chastise
		[SpellName(15487)] = 3,		-- Silence
		-- Rogue
		[SpellName(6770)] = 4,		-- Sap
		[SpellName(2094)] = 4,		-- Blind
		[SpellName(1833)] = 4,		-- Cheap Shot
		[SpellName(408)] = 4,		-- Kidney Shot
		[SpellName(1776)] = 4,		-- Gouge
		[SpellName(1330)] = 3,		-- Garrote - Silence
		-- Shaman
		[SpellName(51514)] = 4,		-- Hex
		[SpellName(118905)] = 4,	-- Static Charge
		[SpellName(305485)] = 4,	-- Lightning Lasso
		-- Warlock
		[SpellName(118699)] = 4,	-- Fear
		[SpellName(6789)] = 4,		-- Mortal Coil
		[SpellName(5484)] = 4,		-- Howl of Terror
		[SpellName(6358)] = 4,		-- Seduction (Succubus)
		[SpellName(115268)] = 4,	-- Mesmerize (Shivarra)
		[SpellName(30283)] = 4,		-- Shadowfury
		-- Warrior
		[SpellName(46968)] = 4,		-- Shockwave
		[SpellName(132169)] = 4,	-- Storm Bolt
		[SpellName(194958)] = 4,	-- Intimidating Shout
	}

	tinsert(T.RaidBuffs["ALL"], {284402, "RIGHT", {1, 0, 0}, true})	-- Vampiric Touch (Don't dispel)
	tinsert(T.RaidBuffs["ALL"], {30108, "RIGHT", {1, 0, 0}, true})	-- Unstable Affliction (Don't dispel)

	for spell, prio in pairs(PvPDebuffs) do
		T.RaidDebuffs[spell] = prio
	end
end

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- Spell name
}

T.RaidDebuffsIgnore = {
	[980] = true,			-- Agony
	[1943] = true,			-- Rupture
}

for _, spell in pairs(C.raidframe.plugins_aura_watch_list) do
	T.RaidDebuffs[SpellName(spell)] = 3
end