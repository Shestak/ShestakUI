local T, C, L, _ = unpack(select(2, ...))
if C.combattext.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Cleave -> http://www.wowhead.com/spell=845
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
-- General filter outgoing healing
if C.combattext.healing then
	T.healfilter = {}
end

-- General merge outgoing damage
if C.combattext.merge_aoe_spam then
	T.aoespam = {}
	T.aoespam[6603] = 3				-- Auto Attack
	T.aoespam[148008] = 3			-- Essence of Yu'lon
	T.aoespam[148009] = 3			-- Spirit of Chi-Ji
	T.aoespam[149276] = 3			-- Flurry of Xuen
	T.aoespam[147891] = 3			-- Flurry of Xuen
end

-- Class config
if T.class == "DEATHKNIGHT" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[55095] = 3		-- Frost Fever
		T.aoespam[55078] = 3		-- Blood Plague
		T.aoespam[48721] = 0		-- Blood Boil
		T.aoespam[49184] = 0		-- Howling Blast
		T.aoespam[52212] = 3		-- Death and Decay
		T.aoespam[55050] = 0		-- Heart Strike
		T.aoespam[50401] = 3		-- Razor Frost
		T.aoespam[91776] = 3		-- Claw (Ghoul)
		T.aoespam[49020] = 0		-- Obliterate
		T.aoespam[49143] = 0		-- Frost Strike
		T.aoespam[45462] = 0		-- Plague Strike
		T.aoespam[49998] = 0		-- Death Strike
	end
	if C.combattext.healing then
		T.healfilter[119980] = true	-- Conversion
	end
elseif T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[774] = 3			-- Rejuvenation
		T.aoespam[48438] = 3		-- Wild Growth
		T.aoespam[8936] = 3			-- Regrowth
		T.aoespam[33763] = 3		-- Lifebloom
		T.aoespam[44203] = 3		-- Tranquility
		T.aoespam[81269] = 3		-- Efflorescence
		T.aoespam[142424] = 3		-- Efflorescence (Force of Nature)
		T.aoespam[102792] = 3		-- Wild Mushroom: Bloom
		T.aoespam[124988] = 3		-- Nature's Vigil
		T.aoespam[144876] = 3		-- Spark of Life (T16)
		-- Damaging spells
		T.aoespam[8921] = 3			-- Moonfire
		T.aoespam[93402] = 3		-- Sunfire
		T.aoespam[42231] = 3		-- Hurricane
		T.aoespam[106998] = 3		-- Astral Storm
		T.aoespam[50288] = 3		-- Starfall
		T.aoespam[78777] = 3		-- Wild Mushroom: Detonate
		T.aoespam[61391] = 0		-- Typhoon
		T.aoespam[1822] = 3			-- Rake
		T.aoespam[33876] = 0		-- Mangle (Cat Form)
		T.aoespam[33878] = 0		-- Mangle (Bear Form)
		T.aoespam[62078] = 0		-- Swipe (Cat Form)
		T.aoespam[779] = 0			-- Swipe (Bear Form)
		T.aoespam[33745] = 3		-- Lacerate
		T.aoespam[77758] = 3		-- Thrash (Bear Form)
		T.aoespam[106830] = 3		-- Thrash (Cat Form)
		T.aoespam[1079] = 3			-- Rip
		T.aoespam[124991] = 3		-- Nature's Vigil
	end
	if C.combattext.healing then
		T.healfilter[145109] = true	-- Ysera's Gift (Self)
		T.healfilter[145110] = true	-- Ysera's Gift
		T.healfilter[34299] = true	-- Leader of the Pack
	end
elseif T.class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[2643] = 0			-- Multi-Shot
		T.aoespam[83077] = 0		-- Improved Serpent Sting
		T.aoespam[118253] = 3		-- Serpent Sting
		T.aoespam[13812] = 3		-- Explosive Trap
		T.aoespam[53301] = 3		-- Explosive Shot
		T.aoespam[63468] = 3		-- Piercing Shots
		T.aoespam[118459] = 3		-- Beast Cleave
		T.aoespam[120699] = 3		-- Lynx Rush
		T.aoespam[120361] = 3		-- Barrage
		T.aoespam[131900] = 3		-- A Murder of Crows
		T.aoespam[34655] = 3		-- Deadly Poison (Trap)
		T.aoespam[93433] = 3		-- Burrow Attack (Worm)
		T.aoespam[92380] = 3		-- Froststorm Breath (Chimaera)
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[44457] = 3		-- Living Bomb
		T.aoespam[44461] = 3		-- Living Bomb (AoE)
		T.aoespam[2120] = 3			-- Flamestrike
		T.aoespam[12654] = 3		-- Ignite
		T.aoespam[11366] = 3		-- Pyroblast
		T.aoespam[31661] = 0		-- Dragon's Breath
		T.aoespam[42208] = 3		-- Blizzard
		T.aoespam[122] = 0			-- Frost Nova
		T.aoespam[1449] = 0			-- Arcane Explosion
		T.aoespam[83853] = 3		-- Combustion
		T.aoespam[120] = 0			-- Cone of Cold
		T.aoespam[114923] = 3		-- Nether Tempest
		T.aoespam[114954] = 3		-- Nether Tempest (AoE)
		T.aoespam[7268] = 3			-- Arcane Missiles
		T.aoespam[113092] = 0		-- Frost Bomb
		T.aoespam[44425] = 0		-- Arcane Barrage
		T.aoespam[84721] = 3		-- Frozen Orb
		T.aoespam[148022] = 3		-- Icicle (Mastery)
		T.aoespam[31707] = 3		-- Waterbolt
		T.aoespam[30455] = 0		-- Ice Lance
		T.aoespam[115611] = 6		-- Temporal Ripples
	end
elseif T.class == "MONK" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[119611] = 3		-- Renewing Mist
		T.aoespam[132120] = 3		-- Enveloping Mist
		T.aoespam[115175] = 3		-- Soothing Mist
		T.aoespam[125953] = 3		-- Soothing Mist (Statue)
		T.aoespam[126890] = 3		-- Eminence
		T.aoespam[117640] = 3		-- Spinning Crane Kick
		T.aoespam[132463] = 3		-- Chi Wave
		T.aoespam[130654] = 3		-- Chi Burst
		T.aoespam[124081] = 3		-- Zen Sphere
		T.aoespam[124101] = 3		-- Zen Sphere: Detonate
		T.aoespam[116670] = 0		-- Uplift
		-- Damaging spells
		T.aoespam[117952] = 3		-- Crackling Jade Lightning
		T.aoespam[117418] = 3		-- Fists of Fury
		T.aoespam[120274] = 3		-- Tiger Strikes
		T.aoespam[128531] = 3		-- Blackout Kick (DoT)
		T.aoespam[121253] = 0		-- Keg Smash
		T.aoespam[115181] = 0		-- Breath of Fire
		T.aoespam[123725] = 3		-- Breath of Fire (DoT)
		T.aoespam[107270] = 3		-- Spinning Crane Kick
		T.aoespam[123586] = 3		-- Flying Serpent Kick
		T.aoespam[132467] = 3		-- Chi Wave
		T.aoespam[130651] = 3		-- Chi Burst
		T.aoespam[124098] = 3		-- Zen Sphere
		T.aoespam[125033] = 3		-- Zen Sphere: Detonate
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[20167] = 3		-- Seal of Insight
		T.aoespam[123530] = 3		-- Battle Insight
		T.aoespam[53652] = 3		-- Beacon of Light
		T.aoespam[85222] = 0		-- Light of Dawn
		T.aoespam[82327] = 0		-- Holy Radiance
		T.aoespam[121129] = 0		-- Daybreak
		T.aoespam[114163] = 3		-- Eternal Flame
		T.aoespam[114852] = 0		-- Holy Prism
		T.aoespam[119952] = 3		-- Arcing Light
		T.aoespam[114917] = 3		-- Stay of Execution
		T.aoespam[144581] = 3		-- Blessing of the Guardians (T16)
		-- Damaging spells
		T.aoespam[81297] = 3		-- Consecration
		T.aoespam[119072] = .5		-- Holy Wrath
		T.aoespam[53385] = 0		-- Divine Storm
		T.aoespam[122032] = 0		-- Exorcism (Glyph)
		T.aoespam[31803] = 3		-- Censure
		T.aoespam[42463] = 3		-- Seal of Truth
		T.aoespam[101423] = 3		-- Seal of Righteousness
		T.aoespam[88263] = 0		-- Hammer of the Righteous
		T.aoespam[96172] = 3		-- Hand of Light (Mastery)
		T.aoespam[31935] = .5		-- Avenger's Shield
		T.aoespam[114871] = 0		-- Holy Prism
		T.aoespam[114919] = 3		-- Arcing Light
		T.aoespam[114916] = 3		-- Execution Sentence
		T.aoespam[86704] = 0		-- Ancient Fury
	end
	if C.combattext.healing then
		T.healfilter[115547] = true	-- Glyph of Avenging Wrath
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[47750] = 3		-- Penance
		T.aoespam[23455] = 0		-- Holy Nova
		T.aoespam[139] = 3			-- Renew
		T.aoespam[596] = 0			-- Prayer of Healing
		T.aoespam[64844] = 3		-- Divine Hymn
		T.aoespam[32546] = 3		-- Binding Heal
		T.aoespam[77489] = 3		-- Echo of Light
		T.aoespam[34861] = 0		-- Circle of Healing
		T.aoespam[33110] = 3		-- Prayer of Mending
		T.aoespam[88686] = 3		-- Holy Word: Sanctuary
		T.aoespam[63544] = 3		-- Rapid Renewal
		T.aoespam[81751] = 3		-- Atonement
		T.aoespam[120692] = 3		-- Halo
		T.aoespam[121148] = 3		-- Cascade
		T.aoespam[110745] = 3		-- Divine Star
		-- Damaging spells
		T.aoespam[47666] = 3		-- Penance
		T.aoespam[132157] = 0		-- Holy Nova
		T.aoespam[589] = 3			-- Shadow Word: Pain
		T.aoespam[34914] = 3		-- Vampiric Touch
		T.aoespam[2944] = 3			-- Devouring Plague
		T.aoespam[15407] = 3		-- Mind Flay
		T.aoespam[49821] = 3		-- Mind Sear
		T.aoespam[14914] = 3		-- Holy Fire
		T.aoespam[129250] = 3		-- Power Word: Solace
		T.aoespam[120696] = 3		-- Halo
		T.aoespam[127628] = 3		-- Cascade
		T.aoespam[122128] = 3		-- Divine Star
	end
	if C.combattext.healing then
		T.healfilter[127626] = true	-- Devouring Plague
		T.healfilter[15290] = true	-- Vampiric Embrace
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[51723] = 0		-- Fan of Knives
		T.aoespam[121411] = 0		-- Crimson Tempest
		T.aoespam[122233] = 3		-- Crimson Tempest (DoT)
		T.aoespam[2818] = 3			-- Deadly Poison
		T.aoespam[8680] = 3			-- Wound Poison
		T.aoespam[22482] = 3		-- Blade Flurry
		T.aoespam[5374] = 0			-- Mutilate
	end
	if C.combattext.healing then
		T.healfilter[112974] = true	-- Leeching Poison
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[73921] = 3		-- Healing Rain
		T.aoespam[52042] = 3		-- Healing Stream Totem
		T.aoespam[1064] = 3			-- Chain Heal
		T.aoespam[51945] = 3		-- Earthliving
		T.aoespam[61295] = 3		-- Riptide
		T.aoespam[98021] = 3		-- Spirit Link
		T.aoespam[114911] = 3		-- Ancestral Guidance
		T.aoespam[114942] = 3		-- Healing Tide
		-- Damaging spells
		T.aoespam[421] = 1			-- Chain Lightning
		T.aoespam[45297] = 3		-- Chain Lightning (Mastery)
		T.aoespam[114738] = 3		-- Lava Beam (Mastery)
		T.aoespam[8349] = 0			-- Fire Nova
		T.aoespam[77478] = 3		-- Earhquake
		T.aoespam[51490] = 0		-- Thunderstorm
		T.aoespam[8187] = 3			-- Magma Totem
		T.aoespam[8050] = 3			-- Flame Shock
		T.aoespam[25504] = 3		-- Windfury
		T.aoespam[3606] = 3			-- Searing Bolt
	end
elseif T.class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[27243] = 3		-- Seed of Corruption
		T.aoespam[27285] = 3		-- Seed of Corruption (AoE)
		T.aoespam[87385] = 3		-- Seed of Corruption (Soulburn)
		T.aoespam[172] = 3			-- Corruption
		T.aoespam[30108] = 3		-- Unstable Affliction
		T.aoespam[348] = 3			-- Immolate
		T.aoespam[980] = 3			-- Agony
		T.aoespam[80240] = 3		-- Havoc
		T.aoespam[42223] = 3		-- Rain of Fire
		T.aoespam[689] = 3			-- Drain Life
		T.aoespam[89420] = 3		-- Drain Life (Soulburn)
		T.aoespam[5857] = 3			-- Hellfire
		T.aoespam[129476] = 3		-- Immolation Aura
		T.aoespam[103103] = 3		-- Malefic Grasp
		T.aoespam[86040] = 3		-- Hand of Gul'dan
		T.aoespam[124915] = 3		-- Chaos Wave
		T.aoespam[47960] = 3		-- Shadowflame
		T.aoespam[50590] = 3		-- Immolation Aura
		T.aoespam[30213] = 3		-- Legion Strike (Felguard)
		T.aoespam[89753] = 3		-- Felstorm (Felguard)
		T.aoespam[20153] = 3		-- Immolation (Infrenal)
	end
	if C.combattext.healing then
		T.healfilter[63106] = true	-- Siphon Life
		T.healfilter[89653] = true	-- Drain Life
		T.healfilter[108359] = true	-- Dark Regeneration
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[845] = 0			-- Cleave
		T.aoespam[46968] = 0		-- Shockwave
		T.aoespam[6343] = 0			-- Thunder Clap
		T.aoespam[1680] = 0			-- Whirlwind
		T.aoespam[115767] = 3		-- Deep Wounds
		T.aoespam[50622] = 3		-- Bladestorm
		T.aoespam[52174] = 0		-- Heroic Leap
		T.aoespam[118000] = 0		-- Dragon Roar
		T.aoespam[76858] = 3		-- Opportunity Strike
		T.aoespam[113344] = 3		-- Bloodbath
		T.aoespam[96103] = 0		-- Raging Blow
		T.aoespam[6572] = 0			-- Revenge
	end
	if C.combattext.healing then
		T.healfilter[117313] = true	-- Bloodthirst Heal
		T.healfilter[55694] = true	-- Enraged Regeneration
	end
end