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
		--BETA {974, "BOTTOMRIGHT", {0.2, 0.7, 0.2}, true},		-- Earth Shield
	},
	HUNTER = {
		{35079, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
	},
	MAGE = {
		--BETA {111264, "TOPRIGHT", {0.2, 0.2, 1}},				-- Ice Ward
	},
	ROGUE = {
		--BETA {57933, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Tricks of the Trade
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
	-- [65148] = true,		-- Sacred Shield (Proc)
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
-- Draenor
-----------------------------------------------------------------
-- Hellfire Citadel
	-- Hellfire Assault
	[SpellName(184369)] = 7,	-- Howling Axe
	[SpellName(180079)] = 4,	-- Fellfire Munition
	-- Fel Reaver
	[SpellName(179897)] = 6,	-- Blitz
	[SpellName(185978)] = 7,	-- Firebomb Vulnerability
	[SpellName(182373)] = 4,	-- Flame Vulnerability
	[SpellName(182280)] = 8,	-- Artillery
	[SpellName(182074)] = 3,	-- Immolation
	[SpellName(182001)] = 3,	-- Unstable Orb
	-- Gorefiend
	[SpellName(179867)] = 3,	-- Gorefiend's Corruption
	[SpellName(181295)] = 4,	-- Digest
	[SpellName(179977)] = 8,	-- Touch of Doom
	[SpellName(179864)] = 6,	-- Shadow of Death
	[SpellName(179909)] = 9,	-- Shared Fate
	-- Kilrogg Deadeye
	[SpellName(180389)] = 4,	-- Heart Seeker
	[SpellName(181488)] = 3,	-- Vision of Death
	-- Socrethar
	[SpellName(182038)] = 3,	-- Shattered Defense
	[SpellName(188666)] = 7,	-- Eternal Hunger (Mythic - Fixate)
	[SpellName(189627)] = 7,	-- Volatile Fel Orb (Fixate)
	[SpellName(180415)] = 4,	-- Fel Prison
	[SpellName(184124)] = 3,	-- Gift of the Man'ari
	[SpellName(189540)] = 4,	-- Overwhelming Power
	-- Xhul'horac
	[SpellName(188208)] = 7,	-- Ablaze
	[SpellName(186073)] = 7,	-- Felsinged
	[SpellName(186407)] = 8,	-- Fel Surge
	[SpellName(186500)] = 9,	-- Chains of Fel
	[SpellName(186063)] = 7,	-- Wasting Void
	[SpellName(186333)] = 8,	-- Void Surge
	[SpellName(186785)] = 6,	-- Withering Gaze
	[SpellName(186448)] = 6,	-- Felblaze Flurry
	-- Fel Lord Zakuun
	[SpellName(181508)] = 9,	-- Seed of Destruction
	[SpellName(181653)] = 7,	-- Fel Crystals
	[SpellName(179428)] = 8,	-- Rumbling Fissure
	[SpellName(182008)] = 3,	-- Latent Energy
	[SpellName(179407)] = 6,	-- Disembodied
	[SpellName(189032)] = 5,	-- Befouled
	-- Kormrok
	[SpellName(187819)] = 7,	-- Crush
	[SpellName(181345)] = 7,	-- Foul Crush (Tank)
	-- Tyrant Velhari
	[SpellName(185237)] = 6,	-- Touch of Harm
	[SpellName(185241)] = 7,	-- Edict of Condemnation
	[SpellName(180526)] = 7,	-- Font of Corruption
	[SpellName(180000)] = 6,	-- Seal of Decay
	-- Shadow-Lord Iskar
	[SpellName(181957)] = 9,	-- Phantasmal Wind
	[SpellName(182200)] = 4,	-- Fel Chakram
	[SpellName(182325)] = 2,	-- Phantasmal Wounds
	[SpellName(185239)] = 1,	-- Radiance of Anzu
	[SpellName(185510)] = 3,	-- Dark Bindings
	[SpellName(182600)] = 2,	-- Fel Fire
	[SpellName(179219)] = 3,	-- Phantasmal Fel Bomb
	[SpellName(181753)] = 3,	-- Fel Bomb
	-- Mannoroth
	[SpellName(181275)] = 8,	-- Curse of Legion
	[SpellName(181099)] = 7,	-- Mark of Doom
	[SpellName(181597)] = 4,	-- Mannoroth's Gaze
	[SpellName(182006)] = 4,	-- Empowered Mannoroth's Gaze
	[SpellName(181841)] = 6,	-- Shadowforce
	[SpellName(182088)] = 6,	-- Empowered Shadowforce
	-- Hellfire Council
	[SpellName(184360)] = 7,	-- Fel Rage
	[SpellName(184449)] = 5,	-- Mark of Necromancer
	[SpellName(184652)] = 3,	-- Reap
	-- Archimonde
	[SpellName(184964)] = 7,	-- Shackled Torment
	[SpellName(186123)] = 6,	-- Focused Chaos
	[SpellName(185014)] = 6,	-- Wrought Chaos
	[SpellName(189891)] = 8,	-- Nether Tear
	[SpellName(186961)] = 8,	-- Nether Banish
	[SpellName(183634)] = 7,	-- Shadowfel Burst
	[SpellName(189895)] = 6,	-- Void Star Fixate
	[SpellName(190049)] = 4,	-- Nether Corruption
	[SpellName(189897)] = 4,	-- Doomfire
	[SpellName(187742)] = 4,	-- Shadow Blast
-- Blackrock Foundry
	-- Gruul
	[SpellName(155080)] = 4,	-- Inferno Slice
	[SpellName(155078)] = 3,	-- Overwhelming Blows
	[SpellName(162322)] = 5,	-- Inferno Strike
	[SpellName(155506)] = 2,	-- Petrified
	[SpellName(173192)] = 4,	-- Cave In
	[SpellName(155326)] = 3,	-- Petrifying Slam
	[SpellName(165298)] = 4,	-- Flare (Mythic)
	-- Oregorger
	[SpellName(156203)] = 5,	-- Retched Blackrock
	[SpellName(156374)] = 5,	-- Explosive Shard
	[SpellName(156297)] = 3,	-- Acid Torrent
	[SpellName(173471)] = 4,	-- Acid Maw
	[SpellName(155900)] = 2,	-- Rolling Fury
	-- Blast Furnace
	[SpellName(156934)] = 5,	-- Rupture
	[SpellName(155192)] = 4,	-- Bomb
	[SpellName(176121)] = 6,	-- Volatile Fire
	[SpellName(155743)] = 5,	-- Slag Pool
	[SpellName(155240)] = 3,	-- Tempered
	[SpellName(155242)] = 3,	-- Heat
	[SpellName(155225)] = 5,	-- Melt
	-- Hans'gar and Franzok
	[SpellName(157139)] = 3,	-- Shattered Vertebrae
	[SpellName(160838)] = 2,	-- Disrupting Roar
	[SpellName(155818)] = 4,	-- Scorching Burns
	[SpellName(161570)] = 4,	-- Searing Plates
	[SpellName(157853)] = 4,	-- Aftershock
	-- Flamebender Ka'graz
	[SpellName(155074)] = 1,	-- Charring Breath
	[SpellName(155049)] = 2,	-- Singe
	[SpellName(154932)] = 4,	-- Molten Torrent
	[SpellName(155277)] = 5,	-- Blazing Radiance
	[SpellName(155314)] = 1,	-- Lava Slash
	[SpellName(163284)] = 2,	-- Rising Flames
	[SpellName(162293)] = 3,	-- Empowered Armament
	[SpellName(155493)] = 3,	-- Firestorm
	[SpellName(163633)] = 4,	-- Magma Monsoon
	-- Kromog
	[SpellName(156766)] = 1,	-- Warped Armor
	[SpellName(161839)] = 3,	-- Rune of Crushing Earth
	[SpellName(156844)] = 3,	-- Stone Breath
	-- Beastlord Darmac
	[SpellName(155365)] = 4,	-- Pinned Down
	[SpellName(155061)] = 1,	-- Rend and Tear
	[SpellName(154989)] = 3,	-- Inferno Breath
	[SpellName(154981)] = 5,	-- Conflagration
	[SpellName(155030)] = 2,	-- Seared Flesh
	[SpellName(155236)] = 2,	-- Crush Armor
	[SpellName(155499)] = 3,	-- Superheated Shrapnel
	[SpellName(155657)] = 4,	-- Flame Infusion
	[SpellName(159044)] = 1,	-- Epicenter
	[SpellName(162276)] = 3,	-- Unsteady Mythic
	[SpellName(155222)] = 4,	-- Tantrum
	-- Operator Thogar
	[SpellName(155921)] = 2,	-- Enkindle
	[SpellName(165195)] = 4,	-- Prototype Pulse Grenade
	[SpellName(156310)] = 3,	-- Lava Shock
	[SpellName(159481)] = 3,	-- Delayed Siege Bomb
	[SpellName(164380)] = 2,	-- Burning
	[SpellName(164280)] = 2,	-- Heat Blast
	[SpellName(155701)] = 3,	-- Serrated Slash
	-- Iron Maidens
	[SpellName(156629)] = 2,	-- Rapid Fire
	[SpellName(164264)] = 3,	-- Penetrating Shot
	[SpellName(158602)] = 1,	-- Dominator Blast
	[SpellName(156112)] = 4,	-- Convulsive Shadows
	[SpellName(158315)] = 2,	-- Dark Hunt
	[SpellName(159724)] = 3,	-- Blood Ritual
	[SpellName(158010)] = 2,	-- Bloodsoaked Heartseeker
	[SpellName(158692)] = 1,	-- Deadly Throw
	[SpellName(156601)] = 3,	-- Sanguine Strikes
	[SpellName(170395)] = 3,	-- Sorka Sprey
	[SpellName(170405)] = 3,	-- Maraks Blood Calling
	[SpellName(158686)] = 4,	-- Expose Armor
	[SpellName(159585)] = 5,	-- Deploy Turret
	-- Blackhand
	[SpellName(156096)] = 5,	-- Marked for Death
	[SpellName(156743)] = 4,	-- Impaled
	[SpellName(156047)] = 3,	-- Slagged
	[SpellName(156401)] = 3,	-- Molten Slag
	[SpellName(156404)] = 3,	-- Burned
	[SpellName(158054)] = 3,	-- Shattering Smash
	[SpellName(156888)] = 3,	-- Overheated
	[SpellName(157000)] = 5,	-- Attach Slag Bombs
	[SpellName(156999)] = 5,	-- Throw Slag Bombs
-- Highmaul
	--Trash
	[SpellName(175601)] = 3,	-- Tainted Claws
	[SpellName(175599)] = 3,	-- Devour
	[SpellName(172066)] = 3,	-- Radiating Poison
	[SpellName(166779)] = 3,	-- Staggering Blow
	[SpellName(175636)] = 3,	-- Rune of Destruction
	[SpellName(175654)] = 3,	-- Rune of Disintegration
	[SpellName(166185)] = 3,	-- Rending Slash
	[SpellName(166175)] = 3,	-- Earth Devastating Slam
	[SpellName(174404)] = 3,	-- Frozen Core
	[SpellName(173763)] = 3,	-- Wild Flames
	[SpellName(174500)] = 3,	-- Rending Throw
	[SpellName(174939)] = 3,	-- Time Stop
	[SpellName(172115)] = 3,	-- Earthen Thrust
	[SpellName(166200)] = 3,	-- Arcane Volatility
	[SpellName(174473)] = 3,	-- Corrupted Blood
	-- Kargath Bladefist
	[SpellName(158986)] = 2,	-- Berserker Rush
	[SpellName(159178)] = 5,	-- Open Wounds
	[SpellName(162497)] = 3,	-- On the Hunt
	[SpellName(159113)] = 5,	-- Impale
	[SpellName(159213)] = 3,	-- Monsters Brawl
	[SpellName(159410)] = 4,	-- Mauling Brew
	[SpellName(160521)] = 2,	-- Vile Breath
	[SpellName(159386)] = 3,	-- Iron Bomb
	[SpellName(159188)] = 3,	-- Grapple
	[SpellName(159202)] = 4,	-- Flame jet
	-- The Butcher
	[SpellName(156151)] = 3,	-- The Tenderizer
	[SpellName(156147)] = 5,	-- The Cleaver
	[SpellName(156152)] = 3,	-- Gushing Wounds
	[SpellName(163046)] = 4,	-- Pale Vitriol
	-- Tectus
	[SpellName(162346)] = 4,	-- Crystalline Barrage
	[SpellName(162892)] = 4,	-- Petrification
	[SpellName(162475)] = 5,	-- Tectonic Upheaval
	-- Brackenspore
	[SpellName(163242)] = 5,	-- Infesting Spores
	[SpellName(159426)] = 5,	-- Rejuvenating Spores
	[SpellName(163241)] = 4,	-- Rot
	[SpellName(159220)] = 2,	-- Necrotic Breath
	[SpellName(160179)] = 2,	-- Mind Fungus
	[SpellName(165223)] = 6,	-- Burning Infusion
	[SpellName(163666)] = 3,	-- Pulsing Heat
	[SpellName(163590)] = 5,	-- Creeping Moss
	[SpellName(159972)] = 3,	-- Flesh Eater
	-- Twin Ogron
	[SpellName(155569)] = 3,	-- Injured
	[SpellName(158241)] = 4,	-- Blaze
	[SpellName(163374)] = 4,	-- Arcane Volatility
	[SpellName(167200)] = 3,	-- Arcane Wound
	[SpellName(163297)] = 3,	-- Arcane Twisted
	[SpellName(158026)] = 5,	-- Enfeebling Roar
	[SpellName(159709)] = 5,	-- Weakened Defenses
	[SpellName(158200)] = 4,	-- Quake
	-- Koragh
	[SpellName(172813)] = 5,	-- Expel Magic: Frost
	[SpellName(162185)] = 5,	-- Expel Magic: Fire
	[SpellName(162184)] = 3,	-- Expel Magic: Shadow
	[SpellName(162186)] = 2,	-- Expel Magic: Arcane
	[SpellName(161345)] = 2,	-- Suppression Field
	[SpellName(161242)] = 3,	-- Caustic Energy
	[SpellName(172886)] = 4,	-- Mark of Nullification
	[SpellName(172895)] = 4,	-- Expel Magic: Fel
	[SpellName(163472)] = 2,	-- Dominating Power
	[SpellName(161358)] = 4,	-- Suppression Field
	[SpellName(156803)] = 3,	-- Nullification Barrier
	-- Imperator Mar'gok
	[SpellName(157763)] = 3,	-- Fixate
	[SpellName(159515)] = 4,	-- Accelerated Assault
	[SpellName(156225)] = 4,	-- Branded
	[SpellName(164004)] = 4,	-- Branded: Displacement
	[SpellName(164006)] = 4,	-- Branded: Replication
	[SpellName(164005)] = 4,	-- Branded: Fortification
	[SpellName(158605)] = 2,	-- Mark of Chaos
	[SpellName(164176)] = 2,	-- Mark of Chaos: Displacement
	[SpellName(164178)] = 2,	-- Mark of Chaos: Fortification
	[SpellName(164191)] = 2,	-- Mark of Chaos: Replication
	[SpellName(158619)] = 3,	-- Fetter
	[SpellName(157349)] = 4,	-- Force Nova
	[SpellName(164232)] = 4,	-- Force Nova: Displacement
	[SpellName(164235)] = 4,	-- Force Nova: Fortification
	[SpellName(164240)] = 4,	-- Force Nova: Replication
	[SpellName(165102)] = 4,	-- Infinite Darkness
	[SpellName(157801)] = 3,	-- Slow
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
	[SpellName(143480)] = 3,	-- Assassin's Mark (Fixate)
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
	[SpellName(145065)] = 3,	-- Touch of Y'Shaarj
	[SpellName(145171)] = 3,	-- Empowered Touch of Y'Shaarj
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
	[SpellName(116888)] = 4,	-- Shroud of Purgatory
	[SpellName(121175)] = 2,	-- Orb of Power
}
-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
if C.raidframe.plugins_pvp_debuffs == true then
	T.PvPDebuffs = {
		-- Death Knight
		--BETA [SpellName(115001)] = 3,	-- Remorseless Winter
		[SpellName(108194)] = 3,	-- Asphyxiate
		[SpellName(91797)] = 3,		-- Monstrous Blow (Mutated Ghoul)
		[SpellName(91800)] = 3,		-- Gnaw (Ghoul)
		[SpellName(47476)] = 3,		-- Strangulate
		-- Druid
		[SpellName(33786)] = 3,		-- Cyclone
		[SpellName(78675)] = 3,		-- Solar Beam
		--BETA [SpellName(114238)] = 3,	-- Fae Silence
		[SpellName(339)] = 2,		-- Entangling Roots
		-- Hunter
		[SpellName(3355)] = 3,		-- Freezing Trap
		[SpellName(19386)] = 3,		-- Wyvern Sting
		[SpellName(117526)] = 3,	-- Binding Shot
		[SpellName(24394)] = 3,		-- Intimidation
		-- Mage
		[SpellName(61305)] = 3,		-- Polymorph
		[SpellName(82691)] = 3,		-- Ring of Frost
		--BETA [SpellName(44572)] = 3,		-- Deep Freeze
		[SpellName(31661)] = 3,		-- Dragon's Breath
		--BETA [SpellName(102051)] = 3,	-- Frostjaw
		[SpellName(122)] = 2,		-- Frost Nova
		--BETA [SpellName(111340)] = 2,	-- Ice Ward
		-- Monk
		[SpellName(115078)] = 3,	-- Paralysis
		[SpellName(119381)] = 3,	-- Leg Sweep
		-- Paladin
		[SpellName(20066)] = 3,		-- Repentance
		[SpellName(853)] = 3,		-- Hammer of Justice
		--BETA [SpellName(105593)] = 3,	-- Fist of Justice
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
		--BETA [SpellName(63685)] = 2,		-- Frozen Power
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
	[142862] = true,			-- Ancient Barrier
	[138309] = true,			-- Slimed
	[166057] = true,			-- Biting Cold
	[137619] = true,			-- Marked for Death
}