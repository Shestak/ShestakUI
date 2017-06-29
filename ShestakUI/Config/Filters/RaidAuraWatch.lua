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
		{114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},			-- Eternal Flame
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Blessing of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Blessing of Freedom
		{204013, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},		-- Blessing of Salvation
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Blessing of Sacrifice
		{204018, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},		-- Blessing of Spellwarding
	},
	PRIEST = {
		{194384, "TOPRIGHT", {0.8, 0.4, 0.2}},				-- Atonement
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
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
		{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Intervene
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
-- Legion Raid
-----------------------------------------------------------------
-- Tomb of Sargeras
	-- Goroth
	[SpellName(231363)] = 3,	-- Burning Armor
	[SpellName(233279)] = 3,	-- Shattering Star
	[SpellName(230345)] = 3,	-- Crashing Comet
	[SpellName(234346)] = 4,	-- Fel Eruption
	-- Demonic Inquisition
	[SpellName(233983)] = 3,	-- Echoing Anguish
	[SpellName(233895)] = 3,	-- Suffocating Dark
	-- Harjatan
	[SpellName(231998)] = 3,	-- Jagged Abrasion
	[SpellName(231770)] = 4,	-- Drenched
	[SpellName(231729)] = 3,	-- Aqueous Burst
	[SpellName(231768)] = 3,	-- Drenching Waters
	-- Sisters of the Moon
	[SpellName(236516)] = 3,	-- Twilight Volley
	[SpellName(236519)] = 3,	-- Moon Burn
	[SpellName(239264)] = 3,	-- Lunar Fire
	[SpellName(236712)] = 3,	-- Lunar Beacon
	-- Mistress Sassz'ine
	[SpellName(230201)] = 3,	-- Burden of Pain
	[SpellName(230139)] = 3,	-- Hydra Shot
	[SpellName(230358)] = 3,	-- Thundering Shock
	[SpellName(232913)] = 3,	-- Befouling Ink
	-- The Desolate Host
	[SpellName(235907)] = 3,	-- Collapsing Fissure
	[SpellName(235989)] = 3,	-- Tormented Cries
	[SpellName(235933)] = 3,	-- Spear of Anguish
	[SpellName(235968)] = 3,	-- Grasping Darkness
	[SpellName(236340)] = 3,	-- Crush Mind
	[SpellName(236449)] = 3,	-- Soulbind
	[SpellName(236515)] = 3,	-- Shattering Scream
	[SpellName(236241)] = 3,	-- Soul Rot
	-- Maiden of Vigilance
	[SpellName(235213)] = 4,	-- Light Infusion
	[SpellName(235240)] = 4,	-- Fel Infusion
	[SpellName(240209)] = 3,	-- Unstable Soul
	-- Fallen Avatar
	[SpellName(236494)] = 3,	-- Desolate
	[SpellName(236604)] = 3,	-- Shadowy Blades
	[SpellName(234059)] = 3,	-- Unbound Chaos
	[SpellName(239058)] = 3,	-- Touch of Sargeras
	[SpellName(239739)] = 3,	-- Dark Mark
	[SpellName(242017)] = 3,	-- Black Winds
	-- Kil'Jaeden
	[SpellName(236710)] = 3,	-- Shadow Reflection: Erupting
	[SpellName(236378)] = 3,	-- Shadow Reflection: Wailing
	[SpellName(238429)] = 3,	-- Bursting Dreadflame
	[SpellName(238505)] = 3,	-- Focused Dreadflame
	[SpellName(239155)] = 3,	-- Gravity Squeeze
	[SpellName(239253)] = 3,	-- Flaming Orb
	[SpellName(239130)] = 3,	-- Tear Rift
-- The Nighthold
	-- Skorpyron
	[SpellName(211659)] = 3,	-- Arcane Tether
	[SpellName(204483)] = 3,	-- Focused Blast
	-- Chronomatic Anomaly
	[SpellName(206609)] = 3,	-- Time Release
	[SpellName(206607)] = 3,	-- Chronometric Particles
	-- Trilliax
	[SpellName(206788)] = 3,	-- Toxic Slice
	[SpellName(206641)] = 3,	-- Arcane Slash
	-- Spellblade Aluriel
	[SpellName(212492)] = 3,	-- Annihilate
	[SpellName(212494)] = 3,	-- Annihilated
	[SpellName(212587)] = 3,	-- Mark of Frost
	-- Tichondrius
	[SpellName(206480)] = 3,	-- Carrion Plague
	[SpellName(216040)] = 3,	-- Burning Soul
	[SpellName(208230)] = 3,	-- Feast of Blood
	-- Krosus
	[SpellName(206677)] = 3,	-- Searing Brand
	-- High Botanist Tel'arn
	[SpellName(218304)] = 3,	-- Parasitic Fetter
	[SpellName(218503)] = 3,	-- Recursive Strikes
	-- Star Augur Etraeus
	[SpellName(206936)] = 3,	-- Icy Ejection
	-- Gul'dan
	[SpellName(206222)] = 3,	-- Bonds of Fel
	[SpellName(212568)] = 3,	-- Drain
	[SpellName(206875)] = 3,	-- Fel Obelisk
-- Trial of Valor
	-- Odyn
	[SpellName(198088)] = 3,	-- Glowing Fragment
	[SpellName(228915)] = 3,	-- Stormforged Spear
	[SpellName(227959)] = 3,	-- Storm of Justice
	[SpellName(227475)] = 3,	-- Cleansing Flame
	-- Guarm
	[SpellName(227570)] = 3,	-- Dark Discharge
	[SpellName(227566)] = 3,	-- Salty Spittle
	[SpellName(227539)] = 3,	-- Fiery Phlegm
	[SpellName(228250)] = 4,	-- Shadow Lick
	[SpellName(228246)] = 4,	-- Frost Lick
	[SpellName(228226)] = 4,	-- Flame Lick
	-- Helya
	[SpellName(228054)] = 3,	-- Taint of the Sea
	[SpellName(227982)] = 3,	-- Bilewater Redox
	[SpellName(193367)] = 3,	-- Fetid Rot
	[SpellName(227903)] = 3,	-- Orb of Corruption
	[SpellName(228058)] = 3,	-- Orb of Corrosion
	[SpellName(228519)] = 3,	-- Anchor Slam
	[SpellName(202476)] = 3,	-- Rabid
	[SpellName(232450)] = 3,	-- Corrupted Axion
-- The Emerald Nightmare
	-- Nythendra
	[SpellName(204504)] = 5,	-- Infested
	[SpellName(203096)] = 3,	-- Rot
	[SpellName(204463)] = 3,	-- Volatile Rot
	[SpellName(203646)] = 4,	-- Burst of Corruption
	-- Il'gynoth, Heart of Corruption
	[SpellName(215845)] = 3,	-- Dispersed Spores
	[SpellName(210099)] = 6,	-- Fixate
	[SpellName(209469)] = 5,	-- Touch of Corruption
	[SpellName(210984)] = 3,	-- Eye of Fate
	[SpellName(208697)] = 4,	-- Mind Flay
	[SpellName(208929)] = 3,	-- Spew Corruption
	[SpellName(215128)] = 3,	-- Cursed Blood
	-- Erethe Renferal
	[SpellName(215582)] = 4,	-- Raking Talons
	[SpellName(218519)] = 4,	-- Wind Burn
	[SpellName(215307)] = 4,	-- Web of Pain
	[SpellName(215449)] = 3,	-- Necrotic Venom
	[SpellName(215460)] = 3,	-- Necrotic Venom
	[SpellName(210850)] = 4,	-- Twisting Shadows
	-- Ursoc
	[SpellName(197943)] = 3,	-- Overwhelm
	[SpellName(204859)] = 4,	-- Rend Flesh
	[SpellName(198006)] = 3,	-- Focused Gaze
	[SpellName(198108)] = 3,	-- Momentum
	-- Dragons of Nightmare
	[SpellName(207681)] = 4,	-- Nightmare Bloom
	[SpellName(203770)] = 3,	-- Defiled Vines
	[SpellName(203787)] = 3,	-- Volatile Infection
	[SpellName(204044)] = 3,	-- Shadow Burst
	[SpellName(205341)] = 3,	-- Seeping Fog
	[SpellName(204078)] = 3,	-- Bellowing Roar
	-- Cenarius
	[SpellName(210315)] = 3,	-- Nightmare Brambles
	[SpellName(226821)] = 3,	-- Desiccating Stomp
	[SpellName(211507)] = 3,	-- Nightmare Javelin
	[SpellName(211471)] = 3,	-- Scorned Touch
	[SpellName(214529)] = 3,	-- Spear of Nightmares
	[SpellName(210279)] = 3,	-- Creeping Nightmare
	-- Xavius
	[SpellName(208431)] = 3,	-- Descent into Madness
	[SpellName(206651)] = 3,	-- Darkening Soul
	[SpellName(209158)] = 3,	-- Blackening Soul
	[SpellName(211802)] = 3,	-- Nightmare Blades
	[SpellName(205771)] = 3,	-- Tormenting Fixation
	[SpellName(210451)] = 3,	-- Bonds of Terror
	[SpellName(224508)] = 3,	-- Corruption Meteor
-----------------------------------------------------------------
-- Legion Dungeon
-----------------------------------------------------------------
-- Mythic+ Affixes
	[SpellName(221772)] = 5,	-- Overflowing
	[SpellName(209858)] = 5,	-- Necrotic
	[SpellName(226512)] = 5,	-- Sanguine
-- Black Rook Hold
	-- Trash Mobs
	[SpellName(194969)] = 3,	-- Soul Echoes
	[SpellName(225962)] = 3,	-- Bloodthirsty Leap
	[SpellName(200261)] = 3,	-- Bonebreaking Strike
	[SpellName(222397)] = 3,	-- Boulder Crush
	[SpellName(214001)] = 3,	-- Raven's Dive
	-- Illysanna Ravencrest
	[SpellName(197546)] = 3,	-- Brutal Glaive
	[SpellName(197484)] = 3,	-- Dark Rush
	[SpellName(197687)] = 4,	-- Eye Beams
	-- Smashspite
	[SpellName(198446)] = 3,	-- Fel Vomit
	[SpellName(198245)] = 3,	-- Brutal Haymaker
	-- Lord Ravencrest
	[SpellName(201733)] = 3,	-- Stinging Swarm
-- Court of Stars
	-- Trash Mobs
	[SpellName(209413)] = 3,	-- Suppress
	[SpellName(209512)] = 3,	-- Disrupting Energy
	[SpellName(211473)] = 3,	-- Shadow Slash
	[SpellName(211464)] = 3,	-- Fel Detonation
	[SpellName(207980)] = 3,	-- Disintegration Beam
	[SpellName(207979)] = 3,	-- Shockwave
	-- Advisor Melandrus
	[SpellName(209602)] = 3,	-- Blade Surge
	[SpellName(224333)] = 4,	-- Enveloping Winds
-- Darkheart Thicket
	-- Trash Mobs
	[SpellName(200620)] = 3,	-- Frantic Rip
	[SpellName(225484)] = 3,	-- Grievous Rip
	[SpellName(200631)] = 4,	-- Unnerving Screech
	[SpellName(201400)] = 3,	-- Dread Inferno
	[SpellName(201361)] = 4,	-- Darksoul Bite
	-- Archdruid Glaidalis
	[SpellName(198408)] = 4,	-- Nightfall
	[SpellName(196376)] = 3,	-- Grievous Tear
	-- Shade of Xavius
	[SpellName(200289)] = 4,	-- Growing Paranoia
	[SpellName(200329)] = 4,	-- Overwhelming Terror
	[SpellName(200238)] = 3,	-- Feed on the Weak
-- Eye of Azshara
	-- Trash Mobs
	[SpellName(196111)] = 4,	-- Jagged Claws
	[SpellName(195561)] = 3,	-- Blinding Peck
	-- Warlord Parjesh
	[SpellName(192094)] = 3,	-- Impaling Spear
	-- Serpentrix
	[SpellName(191855)] = 3,	-- Toxic Wound
	[SpellName(191858)] = 4,	-- Toxic Puddle
	-- King Deepbeard
	[SpellName(193018)] = 3,	-- Gaseous Bubbles
-- Halls of Valor
	-- Trash Mobs
	[SpellName(198605)] = 3,	-- Thunderstrike
	[SpellName(199805)] = 3,	-- Crackle
	[SpellName(199050)] = 3,	-- Mortal Hew
	[SpellName(199341)] = 3,	-- Bear Trap
	[SpellName(196194)] = 3,	-- Raven's Dive
	[SpellName(199674)] = 3,	-- Wicked Dagger
	-- Hymdall
	[SpellName(193092)] = 3,	-- Bloodletting Sweep
	-- Hyrja
	[SpellName(192048)] = 3,	-- Expel Light
	-- Fenryr
	[SpellName(197556)] = 4,	-- Ravenous Leap
	[SpellName(196838)] = 3,	-- Scent of Blood
	[SpellName(196497)] = 4,	-- Ravenous Leap
	-- Odyn
	[SpellName(198088)] = 4,	-- Glowing Fragment
-- Maw of Souls
	-- Trash Mobs
	[SpellName(201566)] = 3,	-- Swirling Muck
	[SpellName(191960)] = 5,	-- Barbed Spear
	[SpellName(199061)] = 4,	-- Hew Soul
	[SpellName(222397)] = 4,	-- Breach Armor
	[SpellName(201397)] = 4,	-- Brackwater Blast
	[SpellName(194102)] = 4,	-- Poisonous Sludge
	-- Harbaron
	[SpellName(194325)] = 3,	-- Fragment
	[SpellName(194235)] = 4,	-- Nether Rip
	-- Helya
	[SpellName(185539)] = 3,	-- Rapid Rupture
-- Neltharion's Lair
	-- Trash Mobs
	[SpellName(226296)] = 3,	-- Piercing Shards
	[SpellName(193639)] = 4,	-- Bone Chomp
	[SpellName(202181)] = 3,	-- Stone Gaze
	[SpellName(186616)] = 3,	-- Petrified
	[SpellName(202231)] = 3,	-- Leech
	[SpellName(200154)] = 4,	-- Burning Hatred
	[SpellName(193585)] = 3,	-- Bound
	-- Rokmora
	[SpellName(192799)] = 3,	-- Choking Dust
	-- Naraxas
	[SpellName(205549)] = 3,	-- Rancid Maw
-- The Arcway
	-- Trash Mobs
	[SpellName(202156)] = 4,	-- Corrosion
	[SpellName(210688)] = 3,	-- Collapsing Rift
	[SpellName(226269)] = 3,	-- Torment
	[SpellName(211756)] = 3,	-- Searing Wound
	[SpellName(211217)] = 3,	-- Arcane Slicer
	[SpellName(211543)] = 3,	-- Devour
	-- Corstilax
	[SpellName(195791)] = 3,	-- Quarantine
	-- Ivanyr
	[SpellName(196804)] = 3,	-- Nether Link
	[SpellName(196562)] = 3,	-- Volatile Magic
	-- Nal'tira
	[SpellName(200040)] = 4,	-- Nether Venom
	[SpellName(200227)] = 3,	-- Tangled Web
	-- Advisor Vandros
	[SpellName(220871)] = 3,	-- Unstable Mana
-- Vault of the Wardens
	-- Trash Mobs
	[SpellName(191735)] = 3,	-- Deafening Screech
	[SpellName(210202)] = 4,	-- Foul Stench
	[SpellName(202658)] = 3,	-- Drain
	[SpellName(193164)] = 3,	-- Gift of the Doomsayer
	[SpellName(202615)] = 3,	-- Torment
	[SpellName(193969)] = 3,	-- Razors
	-- Inquisitor Tormentorum
	[SpellName(201488)] = 3,	-- Frightening Shout
	[SpellName(225416)] = 3,	-- Intercept
	[SpellName(214804)] = 3,	-- Seed of Corruption
	[SpellName(201488)] = 3,	-- Frightening Shout
	-- Glazer
	[SpellName(194945)] = 3,	-- Lingering Gaze
	-- Ash'Golm
	[SpellName(192519)] = 3,	-- Lava
	-- Cordana Felsong
	[SpellName(197541)] = 3,	-- Detonation
	[SpellName(213583)] = 4,	-- Deepening Shadows
-- Violet Hold
	-- Trash Mobs
	[SpellName(204608)] = 3,	-- Fel Prison
	[SpellName(204901)] = 3,	-- Carrion Swarm
	[SpellName(205097)] = 3,	-- Fel Blind
	[SpellName(205096)] = 3,	-- Fel Poison
	-- Anub'esset
	[SpellName(202217)] = 3,	-- Mandible Strike
	-- Blood-Princess Thal'ena
	[SpellName(202779)] = 3,	-- Essence of the Blood Princess
	-- Millificent Manastorm
	[SpellName(201159)] = 3,	-- Delta Finger Laser X-treme
	-- Mindflayer Kaahrj
	[SpellName(197783)] = 3,	-- Shadow Crash
	-- Shivermaw
	[SpellName(201960)] = 3,	-- Ice Bomb
	[SpellName(202062)] = 3,	-- Frigid Winds
	-- Lord Malgath
	[SpellName(204962)] = 3,	-- Shadow Bomb
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
	T.PvPDebuffs = {
		-- Death Knight
		[SpellName(108194)] = 3,	-- Asphyxiate
		[SpellName(91797)] = 3,		-- Monstrous Blow (Mutated Ghoul)
		[SpellName(91800)] = 3,		-- Gnaw (Ghoul)
		[SpellName(47476)] = 3,		-- Strangulate
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
		-- Warrior
		[SpellName(46968)] = 3,		-- Shockwave
		[SpellName(132169)] = 3,	-- Storm Bolt
		[SpellName(194958)] = 3,	-- Intimidating Shout
	}
end

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- Spell name
}

T.RaidDebuffsIgnore = {
	--[spellID] = true,			-- Spell name
}