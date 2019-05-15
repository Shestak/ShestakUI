local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.raidframe.plugins_aura_watch ~= true then return end

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
-- Crucible of Storms
-----------------------------------------------------------------
	-- The Restless Cabal
	[SpellName(282386)] = 3, -- Aphotic Blast
	[SpellName(282384)] = 3, -- Shear Mind
	[SpellName(282566)] = 3, -- Promises of Power
	[SpellName(282561)] = 3, -- Dark Herald
	[SpellName(282432)] = 3, -- Crushing Doubt
	[SpellName(282589)] = 3, -- Cerebral Assault
	[SpellName(292826)] = 3, -- Mind Scramble

	-- Uu'nat, Harbinger of the Void
	[SpellName(284851)] = 3, -- Touch of the End
	[SpellName(286459)] = 3, -- Feedback: Void
	[SpellName(286457)] = 3, -- Feedback: Ocean
	[SpellName(286458)] = 3, -- Feedback: Storm
	[SpellName(285367)] = 3, -- Piercing Gaze of N'Zoth
	[SpellName(284733)] = 3, -- Embrace of the Void
	[SpellName(284722)] = 3, -- Umbral Shell
	[SpellName(285345)] = 3, -- Maddening Eyes of N'Zoth
	[SpellName(285477)] = 3, -- Obscurity
	[SpellName(285652)] = 3, -- Insatiable Torment

-----------------------------------------------------------------
-- Battle of Dazar'alor
-----------------------------------------------------------------
	-- Champion of the Light
	[SpellName(283573)] = 3, -- Sacred Blade
	[SpellName(283617)] = 3, -- Wave of Light
	[SpellName(283651)] = 3, -- Blinding Faith
	[SpellName(284595)] = 3, -- Penance
	[SpellName(283582)] = 3, -- Consecration

	-- Grong
	[SpellName(285998)] = 3, -- Ferocious Roar
	[SpellName(283069)] = 3, -- Megatomic Fire
	[SpellName(285671)] = 3, -- Crushed
	[SpellName(285875)] = 3, -- Rending Bite

	-- Jadefire Masters
	[SpellName(282037)] = 3, -- Rising Flames
	[SpellName(284374)] = 3, -- Magma Trap
	[SpellName(285632)] = 3, -- Stalking
	[SpellName(288151)] = 3, -- Tested
	[SpellName(284089)] = 3, -- Successful Defense
	[SpellName(286988)] = 3, -- Searing Embers

	-- Opulence
	[SpellName(286501)] = 3, -- Creeping Blaze
	[SpellName(283610)] = 3, -- Crush
	[SpellName(289383)] = 3, -- Chaotic Displacement
	[SpellName(285479)] = 3, -- Flame Jet
	[SpellName(283063)] = 3, -- Flames of Punishment
	[SpellName(283507)] = 3, -- Volatile Charge

	-- Conclave of the Chosen
	[SpellName(284663)] = 3, -- Bwonsamdi's Wrath
	[SpellName(282444)] = 3, -- Lacerating Claws
	[SpellName(282592)] = 3, -- Bleeding Wounds
	[SpellName(282209)] = 3, -- Mark of Prey
	[SpellName(285879)] = 3, -- Mind Wipe
	[SpellName(282135)] = 3, -- Crawling Hex
	[SpellName(286060)] = 3, -- Cry of the Fallen
	[SpellName(282447)] = 3, -- Kimbul's Wrath
	[SpellName(282834)] = 3, -- Kimbul's Wrath
	[SpellName(286811)] = 3, -- Akunda's Wrath
	[SpellName(286838)] = 3, -- Static Orb

	-- King Rastakhan
	[SpellName(284995)] = 3, -- Zombie Dust
	[SpellName(285349)] = 3, -- Plague of Fire
	[SpellName(285044)] = 3, -- Toad Toxin
	[SpellName(284831)] = 3, -- Scorching Detonation
	[SpellName(289858)] = 3, -- Crushed
	[SpellName(284662)] = 3, -- Seal of Purification
	[SpellName(285178)] = 3, -- Serpent's Breath
	[SpellName(285010)] = 3, -- Poison Toad Slime

	-- Mekkatorque
	[SpellName(288806)] = 3, -- Gigavolt Blast
	[SpellName(289023)] = 3, -- Enormous
	[SpellName(286646)] = 3, -- Gigavolt Charge
	[SpellName(288939)] = 3, -- Gigavolt Radiation
	[SpellName(284168)] = 3, -- Shrunk
	[SpellName(286516)] = 3, -- Anti-Tampering Shock
	[SpellName(284214)] = 3, -- Trample

	-- Stormwall Blockade
	[SpellName(284369)] = 3, -- Sea Storm
	[SpellName(284410)] = 3, -- Tempting Song
	[SpellName(284405)] = 3, -- Tempting Song
	[SpellName(284121)] = 3, -- Thunderous Boom
	[SpellName(286680)] = 3, -- Roiling Tides
	[SpellName(285000)] = 5, -- Kelp-Wrapped

	-- Jaina
	[SpellName(285253)] = 3, -- Ice Shard
	[SpellName(287993)] = 3, -- Chilling Touch
	[SpellName(287365)] = 3, -- Searing Pitch
	[SpellName(288038)] = 3, -- Marked Target
	[SpellName(285254)] = 3, -- Avalanche
	[SpellName(287626)] = 3, -- Grasp of Frost
	[SpellName(287490)] = 3, -- Frozen Solid
	[SpellName(287199)] = 3, -- Ring of Ice
	[SpellName(288392)] = 3, -- Vengeful Seas

-----------------------------------------------------------------
-- Uldir
-----------------------------------------------------------------
	-- Taloc
	[SpellName(270290)] = 5,	-- Blood Storm
	[SpellName(271296)] = 5,	-- Cudgel of Gore
	[SpellName(275270)] = 5,	-- Fixate
	[SpellName(271225)] = 4,	-- Plasma Discharge

	-- MOTHER
	[SpellName(268277)] = 3,	-- Purifying Flame
	[SpellName(268253)] = 3,	-- Surgical Beam
	[SpellName(268095)] = 3,	-- Cleansing Purge
	[SpellName(267787)] = 3,	-- Sundering Scalpel
	[SpellName(268198)] = 3,	-- Clinging Corruption
	[SpellName(267821)] = 3,	-- Defense Grid
	[SpellName(267787)] = 5,	-- Sanitizing Strike

	-- Fetid Devourer
	[SpellName(262313)] = 5,	-- Malodorous Miasma
	[SpellName(262292)] = 4,	-- Rotting Regurgitation
	[SpellName(262314)] = 3,	-- Putrid Paroxysm

	-- Zek'voz, Herald of N'zoth
	[SpellName(265237)] = 6,	-- Shatter
	[SpellName(265264)] = 5,	-- Void Lash
	[SpellName(265360)] = 5,	-- Roiling Deceit
	[SpellName(265662)] = 4,	-- Corruptor's Pact
	[SpellName(265646)] = 5,	-- Will of the Corruptor

	-- Vectis
	[SpellName(265127)] = 4,	-- Lingering Infection
	[SpellName(265178)] = 3,	-- Evolving Affliction
	[SpellName(265206)] = 5,	-- Immunosuppression
	[SpellName(265212)] = 5,	-- Gestate
	[SpellName(265129)] = 4,	-- Omega Vector

	-- Zul, Reborn
	[SpellName(273365)] = 4,	-- Dark Revelation
	[SpellName(273434)] = 5,	-- Pit of Despair
	[SpellName(274195)] = 3,	-- Corrupted Blood
	[SpellName(272018)] = 4,	-- Absorbed in Darkness

	-- Mythrax
	[SpellName(272336)] = 3,	-- Annihilation
	[SpellName(272536)] = 5,	-- Imminent Ruin
	[SpellName(274693)] = 4,	-- Essence Shear
	[SpellName(272407)] = 3,	-- Oblivion Sphere

	-- G'huun
	[SpellName(263436)] = 5,	-- Imperfect Physiology
	[SpellName(263227)] = 5,	-- Putrid Blood
	[SpellName(263372)] = 4,	-- Power Matrix
	[SpellName(272506)] = 4,	-- Explosive Corruption
	[SpellName(267409)] = 4,	-- Dark Bargain
	[SpellName(267430)] = 3,	-- Torment
	[SpellName(263235)] = 5,	-- Blood Feast
	[SpellName(270287)] = 3,	-- Blighted Ground

-----------------------------------------------------------------
-- Dungeons
-----------------------------------------------------------------
	-- Mythic+ Affixes
	[SpellName(226489)] = 5,	-- Sanguine Ichor
	[SpellName(209858)] = 5,	-- Necrotic Wound
	[SpellName(240559)] = 5,	-- Grievous Wound
	[SpellName(240443)] = 5,	-- Burst

	-- Freehold
	[SpellName(258323)] = 3,	-- Infected Wound
	[SpellName(257775)] = 3,	-- Plague Step
	[SpellName(257908)] = 4,	-- Oiled Blade
	[SpellName(257436)] = 3,	-- Poisoning Strike
	[SpellName(274389)] = 3,	-- Rat Traps
	[SpellName(274555)] = 4,	-- Scabrous Bites
	[SpellName(258875)] = 4,	-- Blackout Barrel
	[SpellName(256363)] = 3,	-- Ripper Punch

	-- Shrine of the Storm
	[SpellName(264560)] = 3,	-- Choking Brine
	[SpellName(268233)] = 4,	-- Electrifying Shock
	[SpellName(268322)] = 3,	-- Touch of the Drowned
	[SpellName(268896)] = 3,	-- Mind Rend
	[SpellName(268104)] = 3,	-- Explosive Void
	[SpellName(267034)] = 5,	-- Whispers of Power
	[SpellName(276268)] = 3,	-- Heaving Blow
	[SpellName(264166)] = 3,	-- Undertow
	[SpellName(264526)] = 3,	-- Grasp of the Depths
	[SpellName(274633)] = 4,	-- Sundering Blow
	[SpellName(268214)] = 5,	-- Carving Flesh
	[SpellName(267818)] = 4,	-- Slicing Blast
	[SpellName(268309)] = 4,	-- Unending Darkness
	[SpellName(268317)] = 4,	-- Rip Mind
	[SpellName(268391)] = 3,	-- Mental Assault
	[SpellName(274720)] = 3,	-- Abyssal Strike
	[SpellName(269131)] = 4,	-- Ancient Mindbender

	-- Siege of Boralus
	[SpellName(257168)] = 4,	-- Cursed Slash
	[SpellName(272588)] = 4,	-- Rotting Wounds
	[SpellName(272571)] = 4,	-- Choking Waters
	[SpellName(274991)] = 3,	-- Putrid Waters
	[SpellName(275835)] = 4,	-- Stinging Venom Coating
	[SpellName(273930)] = 3,	-- Hindering Cut
	[SpellName(257292)] = 3,	-- Heavy Slash
	[SpellName(261428)] = 3,	-- Hangman's Noose
	[SpellName(256897)] = 3,	-- Clamping Jaws
	[SpellName(272874)] = 3,	-- Trample
	[SpellName(273470)] = 3,	-- Gut Shot
	[SpellName(272834)] = 3,	-- Viscous Slobber
	[SpellName(257169)] = 4,	-- Terrifying Roar
	[SpellName(272713)] = 3,	-- Crushing Slam

	-- Tol Dagor
	[SpellName(258128)] = 4,	-- Debilitating Shout
	[SpellName(265889)] = 3,	-- Torch Strike
	[SpellName(257791)] = 4,	-- Howling Fear
	[SpellName(258864)] = 3,	-- Suppression Fire
	[SpellName(257028)] = 4,	-- Fuselighter
	[SpellName(258917)] = 3,	-- Righteous Flames
	[SpellName(257777)] = 3,	-- Crippling Shiv
	[SpellName(258079)] = 4,	-- Massive Chomp
	[SpellName(258058)] = 4,	-- Squeeze
	[SpellName(260016)] = 4,	-- Itchy Bite
	[SpellName(257119)] = 5,	-- Sand Trap
	[SpellName(260067)] = 3,	-- Vicious Mauling
	[SpellName(258313)] = 3,	-- Handcuff
	[SpellName(259711)] = 3,	-- Lockdown
	[SpellName(256198)] = 3,	-- Azerite Rounds: Incendiary
	[SpellName(256101)] = 4,	-- Explosive Burst
	[SpellName(256044)] = 6,	-- Deadeye
	[SpellName(256474)] = 4,	-- Heartstopper Venom

	-- Waycrest Manor
	[SpellName(260703)] = 3,	-- Unstable Runic Mark
	[SpellName(263905)] = 3,	-- Marking Cleave
	[SpellName(265880)] = 4,	-- Dread Mark
	[SpellName(265882)] = 3,	-- Lingering Dread
	[SpellName(264105)] = 3,	-- Runic Mark
	[SpellName(264050)] = 4,	-- Infected Thorn
	[SpellName(261440)] = 4,	-- Virulent Pathogen
	[SpellName(263891)] = 4,	-- Grasping Thorns
	[SpellName(264378)] = 4,	-- Fragment Soul
	[SpellName(266035)] = 3,	-- Bone Splinter
	[SpellName(266036)] = 4,	-- Drain Essence
	[SpellName(260907)] = 5,	-- Soul Manipulation
	[SpellName(260741)] = 5,	-- Jagged Nettles
	[SpellName(264556)] = 3,	-- Tearing Strike
	[SpellName(265760)] = 5,	-- Thorned Barrage
	[SpellName(260551)] = 3,	-- Soul Thorns
	[SpellName(263943)] = 4,	-- Etch
	[SpellName(265881)] = 4,	-- Decaying Touch
	[SpellName(261438)] = 4,	-- Wasting Strike
	[SpellName(268202)] = 5,	-- Death Lens
	[SpellName(278456)] = 4,	-- Infest

	-- Atal'Dazar
	[SpellName(252781)] = 5,	-- Unstable Hex
	[SpellName(250096)] = 5,	-- Wracking Pain
	[SpellName(250371)] = 5,	-- Lingering Nausea
	[SpellName(253562)] = 3,	-- Wildfire
	[SpellName(255582)] = 4,	-- Molten Gold
	[SpellName(255041)] = 4,	-- Terrifying Screech
	[SpellName(255371)] = 4,	-- Terrifying Visage
	[SpellName(252687)] = 4,	-- Venomfang Strike
	[SpellName(254959)] = 5,	-- Soulburn
	[SpellName(255814)] = 5,	-- Rending Maul
	[SpellName(255421)] = 5,	-- Devour
	[SpellName(255434)] = 4,	-- Serrated Teeth
	[SpellName(256577)] = 5,	-- Soulfeast

	-- King's Rest
	[SpellName(270492)] = 4,	-- Hex
	[SpellName(267763)] = 4,	-- Wretched Discharge
	[SpellName(276031)] = 4,	-- Pit of Despair
	[SpellName(265773)] = 5,	-- Spit Gold
	[SpellName(270920)] = 5,	-- Seduction
	[SpellName(270865)] = 4,	-- Hidden Blade
	[SpellName(271564)] = 4,	-- Embalming Fluid
	[SpellName(270507)] = 4,	-- Poison Barrage
	[SpellName(267273)] = 4,	-- Poison Nova
	[SpellName(270003)] = 4,	-- Suppression Slam
	[SpellName(270084)] = 3,	-- Axe Barrage
	[SpellName(267618)] = 3,	-- Drain Fluids
	[SpellName(267626)] = 5,	-- Dessication
	[SpellName(270487)] = 4,	-- Severing Blade
	[SpellName(266238)] = 5,	-- Shattered Defenses
	[SpellName(266231)] = 4,	-- Severing Axe
	[SpellName(266191)] = 5,	-- Whirling Axes
	[SpellName(272388)] = 4,	-- Shadow Barrage
	[SpellName(271640)] = 4,	-- Dark Revelation
	[SpellName(268796)] = 5,	-- Impaling Spear

	-- Motherlode
	[SpellName(263074)] = 4,	-- Festering Bite
	[SpellName(280605)] = 4,	-- Brain Freeze
	[SpellName(257337)] = 4,	-- Shocking Claw
	[SpellName(270882)] = 5,	-- Blazing Azerite
	[SpellName(268797)] = 4,	-- Transmute: Enemy to Goo
	[SpellName(259856)] = 4,	-- Chemical Burn
	[SpellName(269302)] = 3,	-- Toxic Blades
	[SpellName(280604)] = 3,	-- Iced Spritzer
	[SpellName(257371)] = 4,	-- Tear Gas
	[SpellName(257544)] = 4,	-- Jagged Cut
	[SpellName(268846)] = 4,	-- Echo Blade
	[SpellName(262794)] = 5,	-- Energy Lash
	[SpellName(262513)] = 5,	-- Azerite Heartseeker
	[SpellName(260838)] = 5,	-- Homing Missle
	[SpellName(263637)] = 4,	-- Clothesline

	-- Temple of Sethraliss
	[SpellName(269686)] = 4,	-- Plague
	[SpellName(268013)] = 3,	-- Flame Shock
	[SpellName(268008)] = 4,	-- Snake Charm
	[SpellName(273563)] = 4,	-- Neurotoxin
	[SpellName(272657)] = 3,	-- Noxious Breath
	[SpellName(267027)] = 3,	-- Cytotoxin
	[SpellName(272699)] = 3,	-- Venomous Spit
	[SpellName(263371)] = 4,	-- Conduction
	[SpellName(272655)] = 4,	-- Scouring Sand
	[SpellName(263914)] = 4,	-- Blinding Sand
	[SpellName(263958)] = 5,	-- A Knot of Snakes
	[SpellName(266923)] = 4,	-- Galvanize
	[SpellName(268007)] = 4,	-- Heart Attack

	-- Underrot
	[SpellName(265468)] = 4,	-- Withering Curse
	[SpellName(278961)] = 4,	-- Decaying Mind
	[SpellName(259714)] = 4,	-- Decaying Spores
	[SpellName(272180)] = 4,	-- Death Bolt
	[SpellName(272609)] = 4,	-- Maddening Gaze
	[SpellName(269301)] = 4,	-- Putrid Blood
	[SpellName(265533)] = 4,	-- Blood Maw
	[SpellName(265019)] = 5,	-- Savage Cleave
	[SpellName(265377)] = 4,	-- Hooked Snare
	[SpellName(265625)] = 5,	-- Dark Omen
	[SpellName(260685)] = 3,	-- Taint of G'huun
	[SpellName(266107)] = 5,	-- Thirst for Blood
	[SpellName(260455)] = 3,	-- Serrated Fangs

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
