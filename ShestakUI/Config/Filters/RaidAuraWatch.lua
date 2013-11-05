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
		{94447, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		{102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		{102351, "RIGHT", {0.4, 0.9, 0.4}},					-- Cenarion Ward
	},
	MONK = {
		{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},				-- Renewing Mist
		{132120, "BOTTOMLEFT", {0.4, 0.8, 0.2}},			-- Enveloping Mist
		{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Zen Sphere
		{116849, "LEFT", {0.81, 0.85, 0.1}, true},			-- Life Cocoon
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		{20925, "BOTTOMLEFT", {0.9, 0.9, 0.1}},				-- Sacred Shield
		{114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},			-- Eternal Flame
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Hand of Freedom
		{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},		-- Hand of Salvation
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Hand of Sacrifice
		{114039, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},		-- Hand of Purity
	},
	PRIEST = {
		{6788, "TOPRIGHT", {1, 0, 0}, true},				-- Weakened Soul
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},			-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{47788, "LEFT", {0.86, 0.52, 0}, true},				-- Guardian Spirit
	},
	SHAMAN = {
		{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Riptide
		{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},			-- Earth Shield
		{51945, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Earthliving
	},
	DEATHKNIGHT = {
		{49016, "TOPRIGHT", {0.89, 0.89, 0.1}},				-- Unholy Frenzy
	},
	HUNTER = {
		{35079, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
	},
	MAGE = {
		{111264, "TOPRIGHT", {0.2, 0.2, 1}},				-- Ice Ward
	},
	ROGUE = {
		{57933, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Tricks of the Trade
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
	[65148] = true,		-- Sacred Shield (Proc)
}

local function SpellName(id)
	local name = GetSpellInfo(id)
	return name
end

T.RaidDebuffs = {
-----------------------------------------------------------------
-- Pandaria
-----------------------------------------------------------------
-- Siege of Orgrimmar
	-- Immerseus
	[SpellName(143436)] = 3,	-- Corrosive Blast (Tank switch)
	-- The Fallen Protectors
	[SpellName(143434)] = 4,	-- Shadow Word: Bane (Dispel)
	[SpellName(143198)] = 3,	-- Garrote (DoT)
	[SpellName(143842)] = 5,	-- Mark of Anguish
	[SpellName(147383)] = 3,	-- Debilitation
	-- Norushen
	[SpellName(146124)] = 4,	-- Self Doubt (Tank switch)
	[SpellName(144514)] = 3,	-- Lingering Corruption (Dispel)
	-- Sha of Pride
	[SpellName(144358)] = 4,	-- Wounded Pride (Tank switch)
	[SpellName(144351)] = 3,	-- Mark of Arrogance (Dispel)
	[SpellName(146594)] = 3,	-- Gift of the Titans
	[SpellName(147207)] = 3,	-- Weakened Resolve (Heroic)
	-- Galakras
	[SpellName(147029)] = 3,	-- Flames of Galakrond (DoT)
	[SpellName(146902)] = 3,	-- Poison-Tipped Blades (Poison stacks)
	-- Iron Juggernaut
	[SpellName(144467)] = 4,	-- Ignite Armor (Tank stacks)
	[SpellName(144459)] = 3,	-- Laser Burn (DoT)
	-- Kor'kron Dark Shaman
	[SpellName(144215)] = 3,	-- Froststorm Strike (Tank stacks)
	[SpellName(144089)] = 3,	-- Toxic Mist (DoT)
	[SpellName(144330)] = 3,	-- Iron Prison (Heroic)
	-- General Nazgrim
	[SpellName(143494)] = 3,	-- Sundering Blow (Tank stacks)
	[SpellName(143638)] = 3,	-- Bonecracker (DoT)
	[SpellName(143431)] = 3,	-- Magistrike (Dispel)
	-- Malkorok
	[SpellName(142990)] = 4,	-- Fatal Strike (Tank stacks)
	[SpellName(142864)] = 3,	-- Ancient Barrier
	[SpellName(142865)] = 3,	-- Strong Ancient Barrier
	[SpellName(142913)] = 4,	-- Displaced Energy (Dispel)
	-- Spoils of Pandaria
	[SpellName(145218)] = 3,	-- Harden Flesh (Dispel)
	[SpellName(146235)] = 3,	-- Breath of Fire (Dispel)
	-- Thok the Bloodthirsty
	[SpellName(143766)] = 3,	-- Panic (Tank stacks)
	[SpellName(143780)] = 3,	-- Acid Breath (Tank stacks)
	[SpellName(143773)] = 3,	-- Freezing Breath (Tank Stacks)
	[SpellName(143800)] = 3,	-- Icy Blood (Random Stacks)
	[SpellName(143767)] = 3,	-- Scorching Breath (Tank Stacks)
	[SpellName(143791)] = 3,	-- Corrosive Blood (Dispel)
	-- Siegecrafter Blackfuse
	[SpellName(143385)] = 3,	-- Electrostatic Charge (Tank stacks)
	[SpellName(144236)] = 3,	-- Pattern Recognition
	-- Paragons of the Klaxxi
	[SpellName(143974)] = 4,	-- Shield Bash (Tank stun)
	[SpellName(142315)] = 4,	-- Caustic Blood (Tank stacks)
	[SpellName(143701)] = 3,	-- Whirling (DoT)
	[SpellName(142948)] = 3,	-- Aim
	-- Garrosh Hellscream
	[SpellName(145183)] = 3,	-- Gripping Despair (Tank stacks)
	[SpellName(145195)] = 3,	-- Empowered Gripping Despair (Tank stacks)
-- Throne of Thunder
	-- Jin'rokh the Breaker
	[SpellName(137162)] = 4,	-- Static Burst (Tank switch)
	[SpellName(138349)] = 3,	-- Static Wound (Tank stacks)
	[SpellName(137371)] = 4,	-- Thundering Throw (Tank stun)
	[SpellName(138732)] = 3,	-- Ionization (Heroic - Dispel)
	[SpellName(137422)] = 3,	-- Focused Lightning (Fixated - Kiting)
	-- Horridon
	[SpellName(136767)] = 3,	-- Triple Puncture (Tank stacks)
	[SpellName(136708)] = 4,	-- Stone Gaze (Stun - Dispel)
	[SpellName(136654)] = 3,	-- Rending Charge (DoT)
	[SpellName(136719)] = 3,	-- Blazing Sunlight (Dispel)
	[SpellName(136587)] = 3,	-- Venom Bolt Volley (Dispel)
	[SpellName(136710)] = 3,	-- Deadly Plague (Dispel)
	[SpellName(136512)] = 3,	-- Hex of Confusion (Dispel)
	-- Council of Elders
	[SpellName(136903)] = 3,	-- Frigid Assault (Tank stacks)
	[SpellName(136922)] = 3,	-- Frostbite (DoT)
	[SpellName(136992)] = 3,	-- Biting Cold (DoT)
	[SpellName(136857)] = 4,	-- Entrapped (Dispel)
	[SpellName(137359)] = 3,	-- Marked Soul (Fixated - Kiting)
	[SpellName(137641)] = 3,	-- Soul Fragment (Heroic)
	-- Tortos
	[SpellName(136753)] = 3,	-- Slashing Talons (Tank DoT)
	[SpellName(137633)] = 3,	-- Crystal Shell (Heroic)
	[SpellName(140701)] = 4,	-- Crystal Shell: Full Capacity! (Heroic)
	-- Megaera
	[SpellName(137731)] = 3,	-- Ignite Flesh (Tank stacks)
	[SpellName(139843)] = 3,	-- Arctic Freeze (Tank stacks)
	[SpellName(139840)] = 3,	-- Rot Armor (Tank stacks)
	[SpellName(134391)] = 4,	-- Cinder (DoT - Dispell)
	[SpellName(139857)] = 4,	-- Torrent of Ice (Fixated - Kiting)
	[SpellName(140179)] = 4,	-- Suppression (Heroic - Dispell)
	-- Ji-Kun
	[SpellName(134366)] = 4,	-- Talon Rake (Tank stacks)
	[SpellName(140092)] = 3,	-- Infected Talons (Tank DoT)
	[SpellName(134256)] = 3,	-- Slimed (DoT)
	-- Durumu the Forgotten
	[SpellName(133768)] = 4,	-- Arterial Cut (Tank DoT)
	[SpellName(133767)] = 3,	-- Serious Wound (Tank stacks)
	[SpellName(133798)] = 3,	-- Life Drain (Stun)
	[SpellName(133597)] = 3,	-- Dark Parasite (Heroic - Dispel)
	-- Primordius
	[SpellName(136050)] = 3,	-- Malformed Blood (Tank stacks)
	[SpellName(136228)] = 4,	-- Volatile Pathogen (DoT)
	-- Dark Animus
	[SpellName(138569)] = 4,	-- Explosive Slam (Tank stacks)
	[SpellName(138609)] = 4,	-- Matter Swap (Dispel)
	[SpellName(138659)] = 3,	-- Touch of the Animus (DoT)
	-- Iron Qon
	[SpellName(134691)] = 3,	-- Impale (Tank stacks)
	[SpellName(136192)] = 4,	-- Lightning Storm (Stun)
	[SpellName(136193)] = 3,	-- Arcing Lightning
	-- Twin Consorts
	[SpellName(137408)] = 3,	-- Fan of Flames (Tank stacks)
	[SpellName(136722)] = 3,	-- Slumber Spores (Dispel)
	[SpellName(137341)] = 3,	-- Beast of Nightmares (Fixate)
	[SpellName(137360)] = 3,	-- Corrupted Healing (Healer stacks)
	-- Lei Shen
	[SpellName(135000)] = 3,	-- Decapitate (Tank only)
	[SpellName(136478)] = 3,	-- Fusion Slash (Tank only)
	[SpellName(136914)] = 3,	-- Electrical Shock (Tank staks)
	[SpellName(135695)] = 3,	-- Static Shock (Damage Split)
	[SpellName(136295)] = 3,	-- Overcharged
	[SpellName(139011)] = 3,	-- Helm of Command (Heroic)
	-- Ra-den
	[SpellName(138297)] = 3,	-- Unstable Vita
	[SpellName(138329)] = 3,	-- Unleashed Anima
	[SpellName(138372)] = 4,	-- Vita Sensitivity
-- Terrace of Endless Spring
	-- Protectors of the Endless
	[SpellName(117519)] = 3,	-- Touch of Sha
	[SpellName(117436)] = 4,	-- Lightning Prison
	-- Tsulong
	[SpellName(122752)] = 3,	-- Shadow Breath
	[SpellName(123011)] = 3,	-- Terrorize
	[SpellName(122777)] = 3,	-- Nightmares
	[SpellName(123036)] = 3,	-- Fright
	-- Lei Shi
	[SpellName(123121)] = 3,	-- Spray
	[SpellName(123705)] = 3,	-- Scary Fog
	-- Sha of Fear
	[SpellName(119086)] = 3,	-- Penetrating Bolt
	[SpellName(120669)] = 3,	-- Naked and Afraid
	[SpellName(120629)] = 3,	-- Huddle in Terror
-- Heart of Fear
	-- Imperial Vizier Zor'lok
	[SpellName(122761)] = 3,	-- Exhale
	[SpellName(122740)] = 3,	-- Convert
	-- Blade Lord Ta'yak
	[SpellName(123180)] = 3,	-- Wind Step
	[SpellName(123474)] = 3,	-- Overwhelming Assault
	-- Garalon
	[SpellName(122835)] = 3,	-- Pheromones
	[SpellName(123081)] = 4,	-- Pungency
	-- Wind Lord Mel'jarak
	[SpellName(129078)] = 4,	-- Amber Prison
	[SpellName(122055)] = 3,	-- Residue
	[SpellName(122064)] = 3,	-- Corrosive Resin
	[SpellName(123963)] = 4,	-- Kor'thik Strike
	-- Amber-Shaper Un'sok
	[SpellName(121949)] = 3,	-- Parasitic Growth
	[SpellName(122370)] = 3,	-- Reshape Life
	-- Grand Empress Shek'zeer
	[SpellName(123707)] = 3,	-- Eyes of the Empress
	[SpellName(123713)] = 3,	-- Servant of the Empress
	[SpellName(123788)] = 3,	-- Cry of Terror
	[SpellName(124849)] = 3,	-- Consuming Terror
	[SpellName(124863)] = 3,	-- Visions of Demise
-- Mogu'shan Vaults
	-- The Stone Guard
	[SpellName(125206)] = 3,	-- Rend Flesh
	[SpellName(130395)] = 3,	-- Jasper Chains
	[SpellName(116281)] = 3,	-- Cobalt Mine Blast
	-- Feng the Accursed
	[SpellName(131788)] = 3,	-- Lightning Lash
	[SpellName(116942)] = 3,	-- Flaming Spear
	[SpellName(131790)] = 3,	-- Arcane Shock
	[SpellName(131792)] = 3,	-- Shadowburn
	[SpellName(116374)] = 4,	-- Lightning Charge
	[SpellName(116784)] = 3,	-- Wildfire Spark
	[SpellName(116417)] = 3,	-- Arcane Resonance
	-- Gara'jal the Spiritbinder
	[SpellName(122151)] = 4,	-- Voodoo Doll
	[SpellName(116161)] = 3,	-- Crossed Over
	[SpellName(117723)] = 3,	-- Frail Soul
	-- The Spirit Kings
	[SpellName(117708)] = 3,	-- Maddening Shout
	[SpellName(118303)] = 3,	-- Fixate
	[SpellName(118048)] = 3,	-- Pillaged
	[SpellName(118135)] = 3,	-- Pinned Down
	[SpellName(118163)] = 3,	-- Robbed Blind
	-- Elegon
	[SpellName(117878)] = 3,	-- Overcharged
	[SpellName(117949)] = 3,	-- Closed Circuit
	[SpellName(132222)] = 3,	-- Destabilizing Energies
	-- Will of the Emperor
	[SpellName(116835)] = 3,	-- Devastating Arc
	[SpellName(116778)] = 3,	-- Focused Defense
	[SpellName(116525)] = 3,	-- Focused Assault
-- Sha of Anger
	[SpellName(119626)] = 3,	-- Aggressive Behavior
-- Other
	[SpellName(87023)] = 4,		-- Cauterize
	[SpellName(94794)] = 4,		-- Rocket Fuel Leak
	[SpellName(121175)] = 2,	-- Orb of Power
-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
	-- Death Knight
	--[[[SpellName(115001)] = 3,	-- Remorseless Winter
	[SpellName(108194)] = 3,	-- Asphyxiate
	[SpellName(91797)] = 3,		-- Monstrous Blow (Mutated Ghoul)
	[SpellName(91800)] = 3,		-- Gnaw (Ghoul)
	[SpellName(47476)] = 3,		-- Strangulate
	-- Druid
	[SpellName(33786)] = 3,		-- Cyclone
	[SpellName(2637)] = 3,		-- Hibernate
	[SpellName(339)] = 2,		-- Entangling Roots
	[SpellName(78675)] = 3,		-- Solar Beam
	-- Hunter
	[SpellName(3355)] = 3,		-- Freezing Trap
	[SpellName(19386)] = 3,		-- Wyvern Sting
	[SpellName(117526)] = 3,	-- Binding Shot
	[SpellName(24394)] = 3,		-- Intimidation
	[SpellName(1513)] = 3,		-- Scare Beast
	[SpellName(19503)] = 3,		-- Scatter Shot
	[SpellName(34490)] = 3,		-- Silence Shot
	-- Mage
	[SpellName(61305)] = 3,		-- Polymorph
	[SpellName(82691)] = 3,		-- Ring of Frost
	[SpellName(44572)] = 3,		-- Deep Freeze
	[SpellName(31661)] = 3,		-- Dragon's Breath
	[SpellName(102051)] = 3,	-- Frostjaw
	[SpellName(55021)] = 3,		-- Improved Counterspell
	[SpellName(122)] = 2,		-- Frost Nova
	[SpellName(111340)] = 2,	-- Ice Ward
	-- Monk
	[SpellName(115078)] = 3,	-- Paralysis
	[SpellName(119381)] = 3,	-- Leg Sweep
	-- Paladin
	[SpellName(20066)] = 3,		-- Repentance
	[SpellName(853)] = 3,		-- Hammer of Justice
	[SpellName(105593)] = 3,	-- Fist of Justice
	[SpellName(105421)] = 3,	-- Blinding Light
	-- Priest
	[SpellName(605)] = 3,		-- Dominate Mind
	[SpellName(8122)] = 3,		-- Psychic Scream
	[SpellName(113792)] = 3,	-- Psychic Terror
	[SpellName(64044)] = 3,		-- Psychic Horror
	[SpellName(15487)] = 3,		-- Silence
	-- Rogue
	[SpellName(6770)] = 3,		-- Sap
	[SpellName(2094)] = 3,		-- Blind
	[SpellName(1776)] = 3,		-- Gouge
	-- Shaman
	[SpellName(51514)] = 3,		-- Hex
	[SpellName(118905)] = 3,	-- Static Charge
	[SpellName(63685)] = 2,		-- Freeze
	-- Warlock
	[SpellName(118699)] = 3,	-- Fear
	[SpellName(104045)] = 3,	-- Sleep
	[SpellName(6789)] = 3,		-- Mortal Coil
	[SpellName(5484)] = 3,		-- Howl of Terror
	[SpellName(6358)] = 3,		-- Seduction (Succubus)
	[SpellName(115268)] = 3,	-- Mesmerize (Shivarra)
	[SpellName(30283)] = 3,		-- Shadowfury
	-- Warrior
	[SpellName(46968)] = 3,		-- Shockwave
	[SpellName(132169)] = 3,	-- Storm Bolt
	[SpellName(20511)] = 3,		-- Intimidating Shout]]
}

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- Spell name
}

T.RaidDebuffsIgnore = {
	[142862] = true,			-- Ancient Barrier
	[138309] = true,			-- Slimed
}