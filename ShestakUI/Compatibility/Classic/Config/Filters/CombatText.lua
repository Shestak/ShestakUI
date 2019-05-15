local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.combattext.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Blizzard -> http://www.wowhead.com/spell=42208
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
-- General filter outgoing healing
if C.combattext.healing then
	T.healfilter = {}
end

-- General merge outgoing damage
if C.combattext.merge_aoe_spam then
	T.merge = {}
	T.aoespam = {}
	T.aoespam[6603] = 3				-- Auto Attack
end

-- Class config
if T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[22842] = 3.5		-- Frenzied Regeneration
		T.aoespam[774] = 4			-- Rejuvenation
		T.aoespam[8936] = 4			-- Regrowth
		T.aoespam[740] = 3			-- Tranquility
		-- Damaging spells
		T.aoespam[779] = 0			-- Swipe
		T.aoespam[8921] = 3			-- Moonfire
		T.aoespam[16914] = 3		-- Hurricane
		T.aoespam[1822] = 3			-- Rake
		T.aoespam[22570] = 0		-- Mangle
		T.aoespam[1079] = 3			-- Rip
	end
	if C.combattext.healing then
	end
elseif T.class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[1978] = 3			-- Serpent Sting
		T.aoespam[2643] = 0			-- Multi-Shot
		T.aoespam[13812] = 3		-- Explosive Trap
		T.aoespam[1510] = 1			-- Volley
		-- Healing spells
		T.aoespam[136] = 9			-- Mend Pet
	end
	if C.combattext.healing then
		T.healfilter[19578] = true	-- Spirit Bond
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[2120] = 0			-- Flamestrike
		T.aoespam[12654] = 3		-- Ignite
		T.aoespam[10] = 3			-- Blizzard
		T.aoespam[122] = 0			-- Frost Nova
		T.aoespam[1449] = 0			-- Arcane Explosion
		T.aoespam[120] = 0			-- Cone of Cold
		T.aoespam[7268] = 1.6		-- Arcane Missiles
		T.aoespam[11113] = 0		-- Blast Wave
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[20267] = 6		-- Judgment of Light
		-- Damaging spells
		T.aoespam[26573] = 3		-- Consecration
		T.aoespam[20911] = 3		-- Ancient Fury
		T.aoespam[20925] = 3		-- Holy Shield
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[15290] = 4		-- Vampiric Embrace
		T.aoespam[23455] = 0		-- Holy Nova
		T.aoespam[139] = 3			-- Renew
		T.aoespam[596] = 0			-- Prayer of Healing
		-- Damaging spells
		T.aoespam[15237] = 0		-- Holy Nova
		T.aoespam[589] = 4			-- Shadow Word: Pain
		T.aoespam[15407] = 3		-- Mind Flay
		T.aoespam[14914] = 3		-- Holy Fire
	end
	if C.combattext.healing then
		T.healfilter[15290] = false	-- Vampiric Embrace
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[2818] = 5			-- Deadly Poison
		T.aoespam[703] = 5			-- Garrote
		T.aoespam[8680] = 3			-- Wound Poison
		T.aoespam[22482] = 3		-- Blade Flurry
		T.aoespam[16511] = 3		-- Hemorrhage
		T.aoespam[1943] = 5			-- Rupture
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[5672] = 5			-- Healing Stream Totem
		T.aoespam[1064] = 3			-- Chain Heal
		-- Damaging spells
		T.aoespam[26545] = 3		-- Lightning Shield
		T.aoespam[421] = 1			-- Chain Lightning
		T.aoespam[8349] = 0			-- Fire Nova
		T.aoespam[8187] = 3			-- Magma Totem
		T.aoespam[8050] = 4			-- Flame Shock
		T.aoespam[10444] = 3		-- Flametongue Attack
		T.aoespam[3606] = 3			-- Searing Bolt
	end
elseif T.class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[689] = 5			-- Drain Life
		T.aoespam[172] = 3			-- Corruption
		T.aoespam[348] = 3			-- Immolate
		T.aoespam[980] = 3			-- Agony
		T.aoespam[18265] = 3		-- Siphon Life
		T.aoespam[5740] = 3			-- Rain of Fire
		T.aoespam[1120] = 3			-- Drain Soul
		T.aoespam[20153] = 3		-- Immolation (Infrenal)
		T.aoespam[22703] = 0		-- Infernal Awakening
		T.aoespam[3110] = 3			-- Firebolt (Imp)
	end
	if C.combattext.healing then
		T.healfilter[689] = true	-- Drain Life
		T.healfilter[18265] = true	-- Siphon Life
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[845] = 0.5		-- Cleave
		T.aoespam[5308] = 0.5		-- Execute Arms (Sweeping Strikes)
		T.aoespam[7384] = 0.5		-- Overpower (Sweeping Strikes)
		T.aoespam[1464] = 0.5		-- Slam (Sweeping Strikes)
		T.aoespam[12294] = 0.5		-- Mortal Strike (Sweeping Strikes)
		T.aoespam[12162] = 3		-- Deep Wounds
		T.aoespam[15578] = 1.5		-- Whirlwind
		T.aoespam[6343] = 0			-- Thunder Clap
		T.aoespam[6572] = 0			-- Revenge
		T.aoespam[772] = 3			-- Rend
		T.aoespam[23881] = 0		-- Bloodthirst
	end
	if C.combattext.healing then
		T.healfilter[23889] = true	-- Bloodthirst Heal
	end
end
