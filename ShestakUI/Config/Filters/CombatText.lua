local T, C, L = unpack(select(2, ...))
if C.combattext.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Cleave -> http://www.wowhead.com/spell=845
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
-- Outgoing healing filter
if C.combattext.healing then
	T.healfilter = {}
end

if C.combattext.merge_aoe_spam then
	T.aoespam = {}
end

-- Class config
if T.class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[27243] = true		-- Seed of Corruption (DoT)
		T.aoespam[27285] = true		-- Seed of Corruption (Explosion)
		T.aoespam[87385] = true		-- Seed of Corruption (Explosion Soulburned)
		T.aoespam[172] = true		-- Corruption
		T.aoespam[87389] = true		-- Corruption (Soulburn: Seed of Corruption)
		T.aoespam[30108] = true		-- Unstable Affliction
		T.aoespam[348] = true		-- Immolate
		T.aoespam[980] = true		-- Agony
		T.aoespam[85455] = true		-- Bane of Havoc
		T.aoespam[104233] = true	-- Rain of Fire
		T.aoespam[5857] = true		-- Hellfire Effect
		T.aoespam[86040] = true		-- Hand of Gul'dan
		T.aoespam[103103] = true	-- Malefic Grasp
		T.aoespam[47897] = true		-- Shadowflame (Shadow direct damage)
		T.aoespam[47960] = true		-- Shadowflame (Fire dot)
		T.aoespam[50590] = true		-- Immolation Aura
		T.aoespam[30213] = true		-- Legion Strike (Felguard)
		T.aoespam[89753] = true		-- Felstorm (Felguard)
		T.aoespam[20153] = true		-- Immolation (Infrenal)
	end
	if C.combattext.healing then
		T.healfilter[63106] = true	-- Siphon Life
		T.healfilter[54181] = true	-- Fel Synergy
		T.healfilter[89653] = true	-- Drain Life
		T.healfilter[79268] = true	-- Soul Harvest
		T.healfilter[30294] = true	-- Soul Leech
	end
elseif T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[774] = true		-- Rejuvenation (Normal)
		T.aoespam[64801] = true		-- Rejuvenation (First tick)
		T.aoespam[48438] = true		-- Wild Growth
		T.aoespam[8936] = true		-- Regrowth
		T.aoespam[33763] = true		-- Lifebloom
		T.aoespam[44203] = true		-- Tranquility
		T.aoespam[81269] = true		-- Efflorescence
		-- Damaging spells
		T.aoespam[8921] = true		-- Moonfire
		T.aoespam[93402] = true		-- Sunfire
		T.aoespam[5570] = true		-- Insect Swarm
		T.aoespam[42231] = true		-- Hurricane
		T.aoespam[50288] = true		-- Starfall
		T.aoespam[78777] = true		-- Wild Mushroom
		T.aoespam[61391] = true		-- Typhoon
		T.aoespam[1822] = true		-- Rake
		T.aoespam[33876] = true		-- Mangle (Cat Form)
		T.aoespam[33878] = true		-- Mangle (Bear Form)
		T.aoespam[62078] = true		-- Swipe (Cat Form)
		T.aoespam[779] = true		-- Swipe (Bear Form)
		T.aoespam[33745] = true		-- Lacerate
		T.aoespam[1079] = true		-- Rip
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[20167] = true		-- Seal of Insight (Heal Effect)
		T.aoespam[53652] = true		-- Beacon of Light
		T.aoespam[85222] = true		-- Light of Dawn
		T.aoespam[82327] = true		-- Holy Radiance
		T.aoespam[121129] = true	-- Daybreak
		-- Damaging spells
		T.aoespam[81297] = true		-- Consecration
		T.aoespam[119072] = true	-- Holy Wrath
		T.aoespam[53385] = true		-- Divine Storm
		T.aoespam[31803] = true		-- Censure
		T.aoespam[42463] = true		-- Seal of Truth
		T.aoespam[101423] = true	-- Seal of Righteousness
		T.aoespam[88263] = true		-- Hammer of the Righteous
		T.aoespam[31935] = true		-- Avenger's Shield
		T.aoespam[96172] = true		-- Hand of Light (Mastery)
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[47750] = true		-- Penance (Heal Effect)
		T.aoespam[139] = true		-- Renew
		T.aoespam[596] = true		-- Prayer of Healing
		T.aoespam[56161] = true		-- Glyph of Prayer of Healing
		T.aoespam[64844] = true		-- Divine Hymn
		T.aoespam[32546] = true		-- Binding Heal
		T.aoespam[77489] = true		-- Echo of Light
		T.aoespam[34861] = true		-- Circle of Healing
		T.aoespam[23455] = true		-- Holy Nova (Healing Effect)
		T.aoespam[33110] = true		-- Prayer of Mending
		T.aoespam[63544] = true		-- Divine Touch
		T.aoespam[81751] = true		-- Atonement (Non-crit)
		T.aoespam[94472] = true		-- Atonement (Crit)
		-- Damaging spells
		T.aoespam[47666] = true		-- Penance (Damage Effect)
		T.aoespam[15237] = true		-- Holy Nova (Damage Effect)
		T.aoespam[589] = true		-- Shadow Word: Pain
		T.aoespam[34914] = true		-- Vampiric Touch
		T.aoespam[2944] = true		-- Devouring Plague
		T.aoespam[63675] = true		-- Improved Devouring Plague
		T.aoespam[15407] = true		-- Mind Flay
		T.aoespam[49821] = true		-- Mind Seer
		T.aoespam[87532] = true		-- Shadowy Apparition
		T.aoespam[14914] = true		-- Holy Fire
	end
	if C.combattext.healing then
		T.healfilter[2944] = true	-- Devouring Plague (Healing)
		T.healfilter[15290] = true	-- Vampiric Embrace
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[73921] = true		-- Healing Rain
		T.aoespam[52042] = true		-- Healing Stream Totem
		T.aoespam[1064] = true		-- Chain Heal
		T.aoespam[51945] = true		-- Earthliving
		T.aoespam[61295] = true		-- Riptide (HoT and instant heal)
		-- Damaging spells
		T.aoespam[421] = true		-- Chain Lightning
		T.aoespam[45297] = true		-- Chain Lightning (Mastery proc)
		T.aoespam[8349] = true		-- Fire Nova
		T.aoespam[77478] = true		-- Earhquake
		T.aoespam[51490] = true		-- Thunderstorm
		T.aoespam[8187] = true		-- Magma Totem
		T.aoespam[8050] = true		-- Flame Shock
		T.aoespam[25504] = true		-- Windfury
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[44461] = true		-- Living Bomb Explosion
		T.aoespam[44457] = true		-- Living Bomb Dot
		T.aoespam[2120] = true		-- Flamestrike
		T.aoespam[12654] = true		-- Ignite
		T.aoespam[11366] = true		-- Pyroblast
		T.aoespam[31661] = true		-- Dragon's Breath
		T.aoespam[42208] = true		-- Blizzard
		T.aoespam[122] = true		-- Frost Nova
		T.aoespam[1449] = true		-- Arcane Explosion
		T.aoespam[92315] = true		-- Pyroblast
		T.aoespam[83853] = true		-- Combustion
		T.aoespam[11113] = true		-- Blast Wave
		T.aoespam[88148] = true		-- Flamestrike void
		T.aoespam[84721] = true		-- Frostfire Orb
		T.aoespam[82739] = true		-- Flame Orb
		T.aoespam[83619] = true		-- Fire Power
		T.aoespam[120] = true		-- Cone of Cold
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[845] = true		-- Cleave
		T.aoespam[46968] = true		-- Shockwave
		T.aoespam[6343] = true		-- Thunder Clap
		T.aoespam[1680] = true		-- Whirlwind
		T.aoespam[115767] = true	-- Deep Wounds
		T.aoespam[50622] = true		-- Bladestorm
		T.aoespam[52174] = true		-- Heroic Leap
		T.aoespam[118000] = true	-- Dragon Roar
		T.aoespam[76858] = true		-- Opportunity Strike
	end
	if C.combattext.healing then
		T.healfilter[117313] = true	-- Bloodthirst Heal
		T.healfilter[55694] = true	-- Enraged Regeneration
	end
elseif T.class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[2643] = true		-- Multi-Shot
		T.aoespam[83077] = true		-- Instant part of Serpent Sting
		T.aoespam[88453] = true		-- Serpent Sting (Dot 1/2)
		T.aoespam[88466] = true		-- Serpent Sting (Dot 2/2)
		T.aoespam[1978] = true		-- Serpent Sting
		T.aoespam[13812] = true		-- Explosive Trap
		T.aoespam[53301] = true		-- Explosive Shot
	end
elseif T.class == "DEATHKNIGHT" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[55095] = true		-- Frost Fever
		T.aoespam[55078] = true		-- Blood Plague
		T.aoespam[48721] = true		-- Blood Boil
		T.aoespam[49184] = true		-- Howling Blast
		T.aoespam[52212] = true		-- Death and Decay
		T.aoespam[55050] = true		-- Heart Strike
		T.aoespam[119980] = true	-- Conversion
		-- Merging mh/oh strikes(by Bozo)
		T.aoespam[49020] = true		-- Obliterate MH
		T.aoespam[66198] = 49020	-- Obliterate OH
		T.aoespam[49998] = true		-- Death Strike MH
		T.aoespam[66188] = 49998	-- Death Strike OH
		T.aoespam[45462] = true		-- Plague Strike MH
		T.aoespam[66216] = 45462	-- Plague Strike OH
		T.aoespam[49143] = true		-- Frost Strike MH
		T.aoespam[66196] = 49143	-- Frost Strike OH
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[51723] = true		-- Fan of Knives
		T.aoespam[2818] = true		-- Deadly Poison
		T.aoespam[8680] = true		-- Instant Poison
		-- Merging mh/oh strikes
		T.aoespam[5374] = true		-- Mutilate
		T.aoespam[27576] = 5374		-- Mutilate Off-Hand
	end
elseif T.class == "MONK" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[115175] = true	-- Soothing Mist
		T.aoespam[126890] = true	-- Eminence
		-- Damaging spells
		T.aoespam[117952] = true	-- Crackling Jade Lightning
		T.aoespam[107270] = true	-- Spinning Crane Kick
		T.aoespam[117418] = true	-- Fists of Fury
	end
end