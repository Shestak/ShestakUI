local T, C, L, _ = unpack(select(2, ...))
if C.combattext.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Blizzard -> http://www.wowhead.com/spell=42208
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
-- General filter outgoing healing
if C.combattext.healing then
	T.healfilter = {}
	T.healfilter[143924] = true		-- Leech
end

-- General merge outgoing damage
if C.combattext.merge_aoe_spam then
	T.merge = {}
	T.aoespam = {}
	T.aoespam[6603] = 3				-- Auto Attack
	T.aoespam[195222] = 4			-- Stormlash
	T.aoespam[195256] = 4			-- Stormlash
	T.aoespam[222197] = 0			-- Volatile Ichor (Unstable Horrorslime Trinket)
	T.aoespam[214350] = 3			-- Nightmare Essence (Oakheart's Gnarled Root Trinket)
	T.aoespam[230261] = 0			-- Flame Wreath (Aran's Relaxing Ruby Trinket)
	T.aoespam[221812] = 5			-- Plague Swarm (Swarming Plaguehive Trinket)
	T.aoespam[222711] = 4			-- Poisoned Dreams (Bough of Corruption Trinket)
	T.aoespam[229737] = 0			-- Solar Collapse (Fury of the Burning Sky Trinket)
	T.aoespam[229700] = 0			-- Orb of Destruction (Pharamere's Forbidden Grimoire Trinket)
	T.aoespam[225764] = 1			-- Nether Meteor (Star Gate Trinket)
	T.aoespam[188091] = 4			-- Deadly Grace (Potion of Deadly Grace)
end

-- Class config
if T.class == "DEATHKNIGHT" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[55095] = 3		-- Frost Fever
		T.aoespam[55078] = 3		-- Blood Plague
		T.aoespam[50842] = 0		-- Blood Boil
		T.aoespam[49184] = 0		-- Howling Blast
		T.aoespam[52212] = 3		-- Death and Decay
		T.aoespam[50401] = 3		-- Razorice
		T.aoespam[91776] = 3		-- Claw (Ghoul)
		T.aoespam[49020] = 0		-- Obliterate
		T.aoespam[49143] = 0		-- Frost Strike
		T.aoespam[49998] = 0		-- Death Strike
		T.aoespam[156000] = 3		-- Defile
		T.aoespam[155166] = 3		-- Mark of Sindragosa
		T.aoespam[55090] = 0		-- Scourge Strike
		T.merge[66198] = 49020		-- Obliterate Off-Hand
		T.merge[66196] = 49143		-- Frost Strike Off-Hand
		T.merge[66188] = 49998		-- Death Strike Off-Hand
		T.merge[70890] = 55090		-- Scourge Strike (Shadow damage)
	end
	if C.combattext.healing then
		T.healfilter[53365] = true	-- Unholy Strength
		T.healfilter[119980] = true	-- Conversion
	end
elseif T.class == "DEMONHUNTER" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[187727] = 0		-- Immolation Aura
		T.aoespam[178741] = 6		-- Immolation Aura Tick
		T.aoespam[189112] = 0		-- Infernal Strike
		T.aoespam[228478] = 0		-- Soul Cleave
		T.aoespam[204598] = 7		-- Sigil of Flame
		T.aoespam[207771] = 7		-- Fiery Brand
		T.aoespam[207407] = 4		-- Soul Carver
		T.aoespam[204157] = 1		-- Throw Glaive Vengeance
		T.aoespam[218677] = 1		-- Spirit Bomb (Damage)
		T.aoespam[227255] = 4		-- Spirit Bomb (Heal)
		T.aoespam[212105] = 3		-- Fel Devastation (Damage)
		T.aoespam[212106] = 3		-- Fel Devastation (Heal)
		T.aoespam[213011] = 4		-- Charred Warblades (Heal)
		T.aoespam[225919] = 1		-- Fracture
		T.merge[225921] = 225919	-- Fracture Off-Hand
		T.aoespam[207693] = 6		-- Feast of Souls
		T.aoespam[217070] = 0.5		-- Rage of the Illidari
		T.aoespam[202388] = 1		-- Inner Demons
		T.aoespam[222031] = 1.5		-- Chaos Strike
		T.merge[199547] = 222031	-- Chaos Strike Off-Hand
		T.aoespam[199552] = 2		-- Blade Dance (AOE, Multi)
		T.merge[200685] = 199552	-- Blade Dance
		T.aoespam[201789] = 4		-- Fury of the Illidari
		T.merge[201628] = 201789	-- Fury of the Illidari	Off-Hand
		T.aoespam[203796] = 4		-- Demon Blades
		T.aoespam[192611] = 1		-- Fel Rush
		T.aoespam[198030] = 3		-- Eye Beam
		T.aoespam[198813] = 0		-- Vengeful Retreat
		T.aoespam[200166] = 0		-- Metamorphosis
		T.aoespam[179057] = 0		-- Chaos Nova
		T.aoespam[185123] = 1		-- Throw Glaive Havoc
		T.aoespam[207690] = 10		-- Bloodlet
		T.aoespam[202446] = 1		-- Anguish
		T.aoespam[211796] = 4		-- Chaos Blades
		T.merge[211797] = 211796	-- Chaos Blades	Off-Hand
		T.aoespam[227518] = 1.5		-- Annihilation
		T.merge[201428] = 227518	-- Annihilation	Off-Hand
		T.aoespam[210153] = 2		-- Death Sweep
		T.merge[210155] = 210153	-- Death Sweep	Off-Hand
		T.aoespam[236237] = 2		-- Chaos Cleave
		T.aoespam[211052] = 2		-- Fel Barrage
		T.aoespam[203794] = 2		-- Consume Soul
	end
elseif T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[774] = 3			-- Rejuvenation
		T.aoespam[48438] = 3		-- Wild Growth
		T.aoespam[8936] = 3			-- Regrowth
		T.aoespam[33763] = 3		-- Lifebloom
		T.aoespam[157982] = 3		-- Tranquility
		T.aoespam[81269] = 3		-- Wild Mushroom
		T.aoespam[124988] = 3		-- Nature's Vigil
		T.aoespam[144876] = 3		-- Spark of Life (T16)
		T.aoespam[155777] = 3		-- Rejuvenation (Germination)
		-- Damaging spells
		T.aoespam[164812] = 3		-- Moonfire
		T.aoespam[164815] = 3		-- Sunfire
		T.aoespam[191037] = 3		-- Starfall
		T.aoespam[61391] = 0		-- Typhoon
		T.aoespam[155722] = 3		-- Rake
		T.aoespam[33917] = 0		-- Mangle
		T.aoespam[106785] = 0		-- Swipe
		T.aoespam[77758] = 3		-- Thrash (Bear Form)
		T.aoespam[106830] = 3		-- Thrash (Cat Form)
		T.aoespam[1079] = 3			-- Rip
		T.aoespam[124991] = 3		-- Nature's Vigil
		T.aoespam[202347] = 3		-- Stellar Flare
		T.aoespam[155625] = 3		-- Moonfire (Cat Form)
	end
	if C.combattext.healing then
		T.healfilter[145109] = true	-- Ysera's Gift (Self)
		T.healfilter[145110] = true	-- Ysera's Gift
		T.healfilter[202636] = true	-- Leader of the Pack
	end
elseif T.class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[2643] = 0			-- Multi-Shot
		T.aoespam[118253] = 3		-- Serpent Sting
		T.aoespam[13812] = 3		-- Explosive Trap
		T.aoespam[212680] = 3		-- Explosive Shot
		T.aoespam[118459] = 3		-- Beast Cleave
		T.aoespam[120361] = 3		-- Barrage
		T.aoespam[131900] = 3		-- A Murder of Crows
		T.aoespam[194599] = 3		-- Black Arrow
		T.aoespam[162543] = 3		-- Poisoned Ammo
		T.aoespam[162541] = 3		-- Incendiary Ammo
		T.aoespam[34655] = 3		-- Deadly Poison (Trap)
		T.aoespam[93433] = 3		-- Burrow Attack (Worm)
		T.aoespam[92380] = 3		-- Froststorm Breath (Chimaera)
		T.aoespam[212436] = 0.5		-- Butchery
		T.aoespam[194859] = 9		-- Dragonsfire Conflagration
		T.aoespam[194858] = 9		-- Dragonsfire Grenade
		T.aoespam[162487] = 6		-- Steel Trap
		T.aoespam[200167] = 1.5		-- Throwing Axes
		T.aoespam[187708] = 0.5		-- Carve
		T.aoespam[203413] = 5		-- Fury of the Eagle
		T.aoespam[203525] = 2		-- Talon Strike
		T.aoespam[17253] = 6		-- Bite
		T.aoespam[185855] = 6		-- Lacerate
		T.aoespam[194279] = 6		-- Caltrops
		T.aoespam[19434] = 1		-- Trick Shot (Aimed Shot)
		T.aoespam[191070] = 1		-- Call of the Hunter (Marked Shot)
		T.aoespam[191043] = 1		-- Legacy of the Windrunners (Aimed Shot)
		T.aoespam[198670] = 1		-- Piercing Shot
		T.aoespam[201594] = 4		-- Stampede
		T.aoespam[194392] = 1		-- Volley
		T.aoespam[214581] = 2		-- Sidewinders
		T.aoespam[212621] = 2		-- Marked Shot
		T.aoespam[191413] = 6		-- Bestial Ferocity
		T.aoespam[16827] = 6		-- Claw
		T.aoespam[201754] = 1		-- Stomp
		T.aoespam[63900] = 1		-- Thunderstomp
		T.aoespam[197465] = 1		-- Surge of the Stormgod
		T.aoespam[207097] = 4		-- Titan's Thunder
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[217694] = 3.5		-- Living Bomb
		T.aoespam[44461] = 3		-- Living Bomb (AoE)
		T.aoespam[2120] = 0			-- Flamestrike
		T.aoespam[194432] = 0		-- Aftershocks
		T.aoespam[12654] = 3		-- Ignite
		T.aoespam[31661] = 0		-- Dragon's Breath
		T.aoespam[190357] = 3		-- Blizzard
		T.aoespam[122] = 0			-- Frost Nova
		T.aoespam[1449] = 0			-- Arcane Explosion
		T.aoespam[120] = 0			-- Cone of Cold
		T.aoespam[114923] = 3		-- Nether Tempest
		T.aoespam[114954] = 3		-- Nether Tempest (AoE)
		T.aoespam[7268] = 1.6		-- Arcane Missiles
		T.aoespam[113092] = 0		-- Frost Bomb
		T.aoespam[84721] = 3		-- Frozen Orb
		T.aoespam[228354] = 1.5		-- Flurry
		T.aoespam[228600] = 0		-- Glacial Spike
		T.aoespam[205021] = 2		-- Ray of Frost
		T.aoespam[148022] = 3		-- Icicle (Mastery)
		T.aoespam[31707] = 3		-- Waterbolt (Pet)
		T.aoespam[228598] = 0.5		-- Ice Lance
		T.aoespam[157981] = 0		-- Blast Wave
		T.aoespam[157997] = 1		-- Ice Nova
		T.aoespam[157980] = 1		-- Supernova
		T.aoespam[135029] = 3		-- Water Jet (Pet)
		T.aoespam[155152] = 3		-- Prismatic Crystal
		T.aoespam[153596] = 3		-- Comet Storm
		T.aoespam[153640] = 3		-- Arcane Orb
		T.aoespam[157977] = 0		-- Unstable Magic (Fire)
		T.aoespam[157978] = 0		-- Unstable Magic (Frost)
		T.aoespam[157979] = 0		-- Unstable Magic (Arcane)
		T.aoespam[153564] = 0		-- Meteor
		T.aoespam[155158] = 4		-- Meteor Burn
		T.aoespam[224637] = 1.6		-- Phoenix's Flames
		T.aoespam[205345] = 4		-- Conflagration Flare Up
		T.aoespam[226757] = 4		-- Conflagration
		T.aoespam[198928] = 1.2		-- Cinderstorm
		T.aoespam[194522] = 3		-- Blast Furnace
		T.aoespam[194316] = 3		-- Cauterizing Blink
		T.aoespam[235314] = 3		-- Blazing Barrier
		T.aoespam[205472] = 4		-- Flame Patch
		T.aoespam[88084] = 3		-- Arcane Blast (Mirror Image)
		T.aoespam[59638] = 3		-- Frostbolt (Mirror Image)
		T.aoespam[88082] = 3		-- Fireball (Mirror Image)
		T.merge[211088] = 211076	-- Mark of Aluneth
		T.aoespam[211076] = 3		-- Mark of Aluneth
		T.merge[210817] = 44425		-- Arcane Rebound
		T.aoespam[44425] = 1.2		-- Arcane Barrage
	end
elseif T.class == "MONK" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[119611] = 3		-- Renewing Mist
		T.aoespam[124682] = 3		-- Enveloping Mist
		T.aoespam[115175] = 3		-- Soothing Mist
		T.aoespam[107270] = 3		-- Spinning Crane Kick
		T.aoespam[132463] = 3		-- Chi Wave
		T.aoespam[130654] = 3		-- Chi Burst
		T.aoespam[124081] = 3		-- Zen Pulse
		T.aoespam[116670] = 0		-- Uplift
		T.aoespam[178173] = 3		-- Gift of the Ox
		-- Damaging spells
		T.aoespam[117952] = 3		-- Crackling Jade Lightning
		T.aoespam[117418] = 3		-- Fists of Fury
		T.aoespam[121253] = 0		-- Keg Smash
		T.aoespam[115181] = 0		-- Breath of Fire
		T.aoespam[123725] = 3		-- Breath of Fire (DoT)
		T.aoespam[107270] = 3		-- Spinning Crane Kick
		T.aoespam[123586] = 3		-- Flying Serpent Kick
		T.aoespam[132467] = 3		-- Chi Wave
		T.aoespam[148135] = 3		-- Chi Burst
		T.aoespam[158221] = 3		-- Hurricane Strike
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[53652] = 3		-- Beacon of Light
		T.aoespam[85222] = 0		-- Light of Dawn
		T.aoespam[114163] = 3		-- Eternal Flame
		T.aoespam[114852] = 0		-- Holy Prism
		T.aoespam[119952] = 3		-- Arcing Light
		T.aoespam[144581] = 3		-- Blessing of the Guardians (T16)
		T.aoespam[210291] = 6		-- Aura of Mercy
		T.aoespam[183811] = 6		-- Judgment of Light
		T.aoespam[225311] = 1		-- Light of Dawn
		-- Damaging spells
		T.aoespam[81297] = 3		-- Consecration
		T.aoespam[53385] = 0		-- Divine Storm
		T.aoespam[88263] = 0		-- Hammer of the Righteous
		T.aoespam[31935] = .5		-- Avenger's Shield
		T.aoespam[114871] = 0		-- Holy Prism
		T.aoespam[114919] = 3		-- Arcing Light
		T.aoespam[213757] = 3		-- Execution Sentence
		T.aoespam[86704] = 0		-- Ancient Fury
		T.aoespam[157122] = 3		-- Holy Shield
		T.merge[53595] = 88263		-- Hammer of the Righteous
		T.aoespam[209478] = 1		-- Tyr's Enforcer
		T.aoespam[209202] = 1		-- Eye of Tyr
		T.aoespam[105421] = 1		-- Blinding Light
		T.aoespam[204301] = 8		-- Blessed Hammer
		T.aoespam[224239] = 1		-- Divine Storm
		T.aoespam[20271] = 1		-- Judgment
		T.merge[228288] = 20271		-- Judgment Retribution
		T.aoespam[217020] = 1		-- Zeal
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[47750] = 3		-- Penance
		T.aoespam[132157] = 0		-- Holy Nova
		T.aoespam[139] = 3			-- Renew
		T.aoespam[596] = 0			-- Prayer of Healing
		T.aoespam[64844] = 3		-- Divine Hymn
		T.aoespam[32546] = 3		-- Binding Heal
		T.aoespam[77489] = 3		-- Echo of Light
		T.aoespam[33110] = 3		-- Prayer of Mending
		T.aoespam[34861] = 3		-- Holy Word: Sanctify
		T.aoespam[81751] = 3		-- Atonement
		T.aoespam[120692] = 3		-- Halo
		T.aoespam[110745] = 3		-- Divine Star
		T.merge[94472] = 81751		-- Atonement
		-- Damaging spells
		T.aoespam[186723] = 3		-- Penance
		T.merge[47666] = 186723		-- Penance
		T.aoespam[132157] = 0		-- Holy Nova
		T.aoespam[589] = 3			-- Shadow Word: Pain
		T.aoespam[34914] = 3		-- Vampiric Touch
		T.aoespam[15407] = 3		-- Mind Flay
		T.aoespam[14914] = 3		-- Holy Fire
		T.aoespam[129250] = 3		-- Power Word: Solace
		T.aoespam[120696] = 3		-- Halo
		T.aoespam[122128] = 3		-- Divine Star
		T.aoespam[148859] = 3		-- Shadowy Apparition
	end
	if C.combattext.healing then
		T.healfilter[15290] = true	-- Vampiric Embrace
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[51723] = 0		-- Fan of Knives
		T.aoespam[2818] = 3			-- Deadly Poison
		T.aoespam[8680] = 3			-- Wound Poison
		T.aoespam[22482] = 3		-- Blade Flurry
		T.aoespam[16511] = 3		-- Hemorrhage
		T.aoespam[5374] = 0			-- Mutilate
		T.aoespam[86392] = 3		-- Main Gauche
		T.aoespam[57841] = 3		-- Killing Spree
		T.aoespam[1943] = 3			-- Rupture
		T.aoespam[152150] = 3		-- Death from Above
		T.aoespam[114014] = 3		-- Shuriken Toss
		T.aoespam[114014] = 3		-- Shuriken Toss
		T.merge[27576] = 5374		-- Mutilate Off-Hand
		T.merge[113780] = 2818		-- Deadly Poison
		T.merge[57842] = 57841		-- Killing Spree Off-Hand
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[73921] = 3		-- Healing Rain
		T.aoespam[52042] = 3		-- Healing Stream Totem
		T.aoespam[1064] = 3			-- Chain Heal
		T.aoespam[61295] = 3		-- Riptide
		T.aoespam[98021] = 3		-- Spirit Link
		T.aoespam[114911] = 3		-- Ancestral Guidance
		T.aoespam[114942] = 3		-- Healing Tide
		T.aoespam[114083] = 3		-- Restorative Mists
		T.aoespam[157503] = 1		-- Cloudburst
		T.aoespam[209069] = 6		-- Tidal Totem
		T.aoespam[208899] = 6		-- Queen's Decree
		T.aoespam[207778] = 1		-- Gift of the Queen
		-- Damaging spells
		T.aoespam[421] = 1			-- Chain Lightning
		T.merge[45297] = 421		-- Chain Lightning Overload
		T.aoespam[8349] = 0			-- Fire Nova
		T.aoespam[77478] = 3		-- Earhquake
		T.aoespam[51490] = 0		-- Thunderstorm
		T.aoespam[8187] = 3			-- Magma Totem
		T.aoespam[188389] = 3		-- Flame Shock
		T.aoespam[25504] = 3		-- Windfury Attack
		T.aoespam[10444] = 3		-- Flametongue Attack
		T.aoespam[3606] = 3			-- Searing Bolt
		T.aoespam[170379] = 3		-- Molten Earth
		T.aoespam[114074] = 1		-- Lava Beam
		T.aoespam[32175] = 0		-- Stormstrike
		T.merge[32176] = 32175		-- Stormstrike Off-Hand
		T.aoespam[114089] = 3		-- Windlash
		T.merge[114093] = 114089	-- Windlash Off-Hand
		T.aoespam[115357] = 0		-- Windstrike
		T.merge[115360] = 115357	-- Windstrike Off-Hand
		T.aoespam[192231] = 3		-- Liquid Magma
		T.aoespam[157331] = 3		-- Wind Gust
		T.aoespam[197385] = 6		-- Fury of Air
		T.aoespam[210801] = 6		-- Crashing Storm
		T.aoespam[210854] = 4		-- Hailstorm
		T.aoespam[187874] = 1		-- Crash Lightning
		T.aoespam[195592] = 1		-- Crash Lightning
	end
elseif T.class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[27243] = 3		-- Seed of Corruption
		T.aoespam[27285] = 3		-- Seed of Corruption (AoE)
		T.aoespam[146739] = 3		-- Corruption
		T.aoespam[30108] = 3		-- Unstable Affliction
		T.aoespam[348] = 3			-- Immolate
		T.aoespam[980] = 3			-- Agony
		T.aoespam[63106] = 3		-- Siphon Life
		T.aoespam[205246] = 3		-- Phantom Singularity
		T.aoespam[80240] = 3		-- Havoc
		T.aoespam[42223] = 3		-- Rain of Fire
		T.aoespam[198590] = 3		-- Drain Soul
		T.aoespam[86040] = 3		-- Hand of Gul'dan
		T.aoespam[205181] = 3		-- Shadowflame
		T.aoespam[30213] = 3		-- Legion Strike (Felguard)
		T.aoespam[89753] = 3		-- Felstorm (Felguard)
		T.aoespam[20153] = 3		-- Immolation (Infrenal)
		T.aoespam[22703] = 0		-- Infernal Awakening
		T.aoespam[171017] = 0		-- Meteor Strike (Infrenal)
		T.aoespam[104318] = 3		-- Fel Firebolt
		T.aoespam[3110] = 3			-- Firebolt (Imp)
		T.aoespam[152108] = 1		-- Cataclysm
		T.aoespam[171018] = 1		-- Meteor Strike
		T.aoespam[85692] = 3		-- Doom Bolt (Doomguard)
		T.aoespam[54049] = 3		-- Shadow Bite (Felhunter)
		T.aoespam[6262] = 3			-- Healthstone
		T.aoespam[3716] = 3			-- Torment (Voidwalker)
		T.merge[157736] = 348		-- Immolate (DoT)
	end
	if C.combattext.healing then
		T.healfilter[63106] = true	-- Siphon Life
		T.healfilter[108359] = true	-- Dark Regeneration
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[46968] = 0		-- Shockwave
		T.aoespam[6343] = 0			-- Thunder Clap
		T.aoespam[1680] = 0			-- Whirlwind
		T.aoespam[115767] = 3		-- Deep Wounds
		T.aoespam[50622] = 3		-- Bladestorm
		T.aoespam[52174] = 0		-- Heroic Leap
		T.aoespam[118000] = 0		-- Dragon Roar
		T.aoespam[203178] = 3		-- Opportunity Strike
		T.aoespam[113344] = 3		-- Bloodbath
		T.aoespam[96103] = 0		-- Raging Blow
		T.aoespam[6572] = 0			-- Revenge
		T.aoespam[5308] = 0			-- Execute
		T.aoespam[772] = 3			-- Rend
		T.aoespam[156287] = 3		-- Ravager
		T.merge[44949] = 1680		-- Whirlwind Off-Hand
		T.merge[85384] = 96103		-- Raging Blow Off-Hand
		T.merge[95738] = 50622		-- Bladestorm Off-Hand
		T.merge[163558] = 5308		-- Execute Off-Hand
	end
	if C.combattext.healing then
		T.healfilter[117313] = true	-- Bloodthirst Heal
	end
end
