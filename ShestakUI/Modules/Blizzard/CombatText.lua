local T, C, L = unpack(select(2, ...))
if not C.combattext.enable == true then return end

----------------------------------------------------------------------------------------
--	Combat Text(xCT by Affli)
----------------------------------------------------------------------------------------
-- Justify messages in frames
local ct = {
	["justify_1"] = "LEFT",			-- Incoming damage justify
	["justify_2"] = "RIGHT",		-- Incoming healing justify
	["justify_3"] = "CENTER",		-- Various messages justify
	["justify_4"] = "RIGHT",		-- Outgoing damage/healing justify
}

-- Outgoing healing filter
if C.combattext.healing then
	ct.healfilter = {}
end

if C.combattext.merge_aoe_spam then
	ct.aoespam = {}
end

-- Class config
if T.class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		ct.aoespam[27243] = true	-- Seed of Corruption (DoT)
		ct.aoespam[27285] = true	-- Seed of Corruption (Explosion)
		ct.aoespam[87385] = true	-- Seed of Corruption (Explosion Soulburned)
		ct.aoespam[172] = true		-- Corruption
		ct.aoespam[87389] = true	-- Corruption (Soulburn: Seed of Corruption)
		ct.aoespam[30108] = true	-- Unstable Affliction
		ct.aoespam[348] = true		-- Immolate
		ct.aoespam[980] = true		-- Bane of Agony
		ct.aoespam[85455] = true	-- Bane of Havoc
		ct.aoespam[85421] = true	-- Burning Embers
		ct.aoespam[42223] = true	-- Rain of Fire
		ct.aoespam[5857] = true		-- Hellfire Effect
		ct.aoespam[47897] = true	-- Shadowflame (Shadow direct damage)
		ct.aoespam[47960] = true	-- Shadowflame (Fire dot)
		ct.aoespam[50590] = true	-- Immolation Aura
		ct.aoespam[30213] = true	-- Legion Strike (Felguard)
		ct.aoespam[89753] = true	-- Felstorm (Felguard)
		ct.aoespam[20153] = true	-- Immolation (Infrenal)
		-- Item spells
		ct.aoespam[109851] = true	-- Blast of Corruption (LFR)
		ct.aoespam[107831] = true	-- Blast of Corruption (Normal)
		ct.aoespam[109854] = true	-- Blast of Corruption (Heroic)
		ct.aoespam[109798] = true	-- Shadowbolt Volley (LFR)
		ct.aoespam[108005] = true	-- Shadowbolt Volley (Normal)
		ct.aoespam[109800] = true	-- Shadowbolt Volley (Heroic)
	end
	if C.combattext.healing then
		ct.healfilter[28176] = true	-- Fel Armor
		ct.healfilter[96379] = true	-- Fel Armor
		ct.healfilter[63106] = true	-- Siphon Life
		ct.healfilter[54181] = true	-- Fel Synergy
		ct.healfilter[89653] = true	-- Drain Life
		ct.healfilter[79268] = true	-- Soul Harvest
		ct.healfilter[30294] = true	-- Soul Leech
	end
elseif T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healer spells
		ct.aoespam[774] = true		-- Rejuvenation (Normal)
		ct.aoespam[64801] = true	-- Rejuvenation (First tick)
		ct.aoespam[48438] = true	-- Wild Growth
		ct.aoespam[8936] = true		-- Regrowth
		ct.aoespam[33763] = true	-- Lifebloom
		ct.aoespam[44203] = true	-- Tranquility
		ct.aoespam[81269] = true	-- Efflorescence
		-- Damager spells
		ct.aoespam[8921] = true		-- Moonfire
		ct.aoespam[93402] = true	-- Sunfire
		ct.aoespam[5570] = true		-- Insect Swarm
		ct.aoespam[42231] = true	-- Hurricane
		ct.aoespam[50288] = true	-- Starfall
		ct.aoespam[78777] = true	-- Wild Mushroom
		ct.aoespam[61391] = true	-- Typhoon
		ct.aoespam[1822] = true		-- Rake
		ct.aoespam[33876] = true	-- Mangle (Cat Form)
		ct.aoespam[33878] = true	-- Mangle (Bear Form)
		ct.aoespam[62078] = true	-- Swipe (Cat Form)
		ct.aoespam[779] = true		-- Swipe (Bear Form)
		ct.aoespam[33745] = true	-- Lacerate
		ct.aoespam[1079] = true		-- Rip
		-- Item spells
		ct.aoespam[105996] = true	-- Essence of Dreams
		ct.aoespam[109847] = true	-- Cleansing Flames (LFR)
		ct.aoespam[107835] = true	-- Cleansing Flames (Normal)
		ct.aoespam[109849] = true	-- Cleansing Flames (Heroic)
		ct.aoespam[109851] = true	-- Blast of Corruption (LFR)
		ct.aoespam[107831] = true	-- Blast of Corruption (Normal)
		ct.aoespam[109854] = true	-- Blast of Corruption (Heroic)
		ct.aoespam[109798] = true	-- Shadowbolt Volley (LFR)
		ct.aoespam[108005] = true	-- Shadowbolt Volley (Normal)
		ct.aoespam[109800] = true	-- Shadowbolt Volley (Heroic)
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healer spells
		ct.aoespam[20167] = true	-- Seal of Insight (Heal Effect)
		ct.aoespam[94289] = true	-- Protector of the Innocent
		ct.aoespam[53652] = true	-- Beacon of Light
		ct.aoespam[85222] = true	-- Light of Dawn
		ct.aoespam[82327] = true	-- Holy Radiance
		ct.aoespam[86452] = true	-- Holy Radiance (Hot)
		-- Damager spells
		ct.aoespam[81297] = true	-- Consecration
		ct.aoespam[2812] = true		-- Holy Wrath
		ct.aoespam[53385] = true	-- Divine Storm
		ct.aoespam[31803] = true	-- Censure
		ct.aoespam[20424] = true	-- Seals of Command
		ct.aoespam[42463] = true	-- Seal of Truth
		ct.aoespam[101423] = true	-- Seal of Righteousness
		ct.aoespam[88263] = true	-- Hammer of the Righteous
		ct.aoespam[31935] = true	-- Avenger's Shield
		ct.aoespam[96172] = true	-- Hand of Light (Mastery)
		-- Item spells
		ct.aoespam[105996] = true	-- Essence of Dreams
		ct.aoespam[109847] = true	-- Cleansing Flames (LFR)
		ct.aoespam[107835] = true	-- Cleansing Flames (Normal)
		ct.aoespam[109849] = true	-- Cleansing Flames (Heroic)
		ct.aoespam[109752] = true	-- Whirling Maw (LFR)
		ct.aoespam[107997] = true	-- Whirling Maw (Normal)
		ct.aoespam[109754] = true	-- Whirling Maw (Heroic)
		ct.aoespam[52586] = true	-- Gurthalak, Voice of the Deeps
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healer spells
		ct.aoespam[47750] = true	-- Penance (Heal Effect)
		ct.aoespam[139] = true		-- Renew
		ct.aoespam[596] = true		-- Prayer of Healing
		ct.aoespam[56161] = true	-- Glyph of Prayer of Healing
		ct.aoespam[64844] = true	-- Divine Hymn
		ct.aoespam[32546] = true	-- Binding Heal
		ct.aoespam[77489] = true	-- Echo of Light
		ct.aoespam[34861] = true	-- Circle of Healing
		ct.aoespam[23455] = true	-- Holy Nova (Healing Effect)
		ct.aoespam[33110] = true	-- Prayer of Mending
		ct.aoespam[63544] = true	-- Divine Touch
		ct.aoespam[81751] = true	-- Atonement (Non-crit)
		ct.aoespam[94472] = true	-- Atonement (Crit)
		-- Damager spells
		ct.aoespam[47666] = true	-- Penance (Damage Effect)
		ct.aoespam[15237] = true	-- Holy Nova (Damage Effect)
		ct.aoespam[589] = true		-- Shadow Word: Pain
		ct.aoespam[34914] = true	-- Vampiric Touch
		ct.aoespam[2944] = true		-- Devouring Plague
		ct.aoespam[63675] = true	-- Improved Devouring Plague
		ct.aoespam[15407] = true	-- Mind Flay
		ct.aoespam[49821] = true	-- Mind Seer
		ct.aoespam[87532] = true	-- Shadowy Apparition
		ct.aoespam[14914] = true	-- Holy Fire
		-- Item spells
		ct.aoespam[105996] = true	-- Essence of Dreams
		ct.aoespam[109847] = true	-- Cleansing Flames (LFR)
		ct.aoespam[107835] = true	-- Cleansing Flames (Normal)
		ct.aoespam[109849] = true	-- Cleansing Flames (Heroic)
		ct.aoespam[109851] = true	-- Blast of Corruption (LFR)
		ct.aoespam[107831] = true	-- Blast of Corruption (Normal)
		ct.aoespam[109854] = true	-- Blast of Corruption (Heroic)
		ct.aoespam[109798] = true	-- Shadowbolt Volley (LFR)
		ct.aoespam[108005] = true	-- Shadowbolt Volley (Normal)
		ct.aoespam[109800] = true	-- Shadowbolt Volley (Heroic)
	end
	if C.combattext.healing then
		ct.healfilter[2944] = true	-- Devouring Plague (Healing)
		ct.healfilter[15290] = true	-- Vampiric Embrace
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healer spells
		ct.aoespam[73921] = true	-- Healing Rain
		ct.aoespam[52042] = true	-- Healing Stream Totem
		ct.aoespam[1064] = true		-- Chain Heal
		ct.aoespam[51945] = true	-- Earthliving
		ct.aoespam[61295] = true	-- Riptide (HoT and instant heal)
		-- Damager spells
		ct.aoespam[421] = true		-- Chain Lightning
		ct.aoespam[45297] = true	-- Chain Lightning (Mastery proc)
		ct.aoespam[8349] = true		-- Fire Nova
		ct.aoespam[77478] = true	-- Earhquake
		ct.aoespam[51490] = true	-- Thunderstorm
		ct.aoespam[8187] = true		-- Magma Totem
		ct.aoespam[8050] = true		-- Flame Shock
		ct.aoespam[25504] = true	-- Windfury
		-- Item spells
		ct.aoespam[105996] = true	-- Essence of Dreams
		ct.aoespam[109847] = true	-- Cleansing Flames (LFR)
		ct.aoespam[107835] = true	-- Cleansing Flames (Normal)
		ct.aoespam[109849] = true	-- Cleansing Flames (Heroic)
		ct.aoespam[109851] = true	-- Blast of Corruption (LFR)
		ct.aoespam[107831] = true	-- Blast of Corruption (Normal)
		ct.aoespam[109854] = true	-- Blast of Corruption (Heroic)
		ct.aoespam[109798] = true	-- Shadowbolt Volley (LFR)
		ct.aoespam[108005] = true	-- Shadowbolt Volley (Normal)
		ct.aoespam[109800] = true	-- Shadowbolt Volley (Heroic)
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		ct.aoespam[44461] = true	-- Living Bomb Explosion
		ct.aoespam[44457] = true	-- Living Bomb Dot
		ct.aoespam[2120] = true		-- Flamestrike
		ct.aoespam[12654] = true	-- Ignite
		ct.aoespam[11366] = true	-- Pyroblast
		ct.aoespam[31661] = true	-- Dragon's Breath
		ct.aoespam[42208] = true	-- Blizzard
		ct.aoespam[122] = true		-- Frost Nova
		ct.aoespam[1449] = true		-- Arcane Explosion
		ct.aoespam[92315] = true	-- Pyroblast
		ct.aoespam[83853] = true	-- Combustion
		ct.aoespam[11113] = true	-- Blast Wave
		ct.aoespam[88148] = true	-- Flamestrike void
		ct.aoespam[84721] = true	-- Frostfire Orb
		ct.aoespam[82739] = true	-- Flame Orb
		ct.aoespam[83619] = true	-- Fire Power
		ct.aoespam[120] = true		-- Cone of Cold
		-- Item spells
		ct.aoespam[109851] = true	-- Blast of Corruption (LFR)
		ct.aoespam[107831] = true	-- Blast of Corruption (Normal)
		ct.aoespam[109854] = true	-- Blast of Corruption (Heroic)
		ct.aoespam[109798] = true	-- Shadowbolt Volley (LFR)
		ct.aoespam[108005] = true	-- Shadowbolt Volley (Normal)
		ct.aoespam[109800] = true	-- Shadowbolt Volley (Heroic)
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		ct.aoespam[845] = true		-- Cleave
		ct.aoespam[46968] = true	-- Shockwave
		ct.aoespam[6343] = true		-- Thunder Clap
		ct.aoespam[1680] = true		-- Whirlwind
		ct.aoespam[94009] = true	-- Rend
		ct.aoespam[12721] = true	-- Deep Wounds
		ct.aoespam[50622] = true	-- Bladestorm
		ct.aoespam[52174] = true	-- Heroic Leap
		-- Item spells
		ct.aoespam[109752] = true	-- Whirling Maw (LFR)
		ct.aoespam[107997] = true	-- Whirling Maw (Normal)
		ct.aoespam[109754] = true	-- Whirling Maw (Heroic)
		ct.aoespam[52586] = true	-- Gurthalak, Voice of the Deeps
	end
	if C.combattext.healing then
		ct.healfilter[23880] = true	-- Bloodthirst
		ct.healfilter[55694] = true	-- Enraged Regeneration
	end
elseif T.class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		ct.aoespam[2643] = true		-- Multi-Shot
		ct.aoespam[83077] = true	-- Instant part of Serpent Sting
		ct.aoespam[88453] = true	-- Serpent Sting (Dot 1/2)
		ct.aoespam[88466] = true	-- Serpent Sting (Dot 2/2)
		ct.aoespam[1978] = true		-- Serpent Sting
		ct.aoespam[13812] = true	-- Explosive Trap
		ct.aoespam[53301] = true	-- Explosive Shot
		-- Item spells
		ct.aoespam[109856] = true	-- Speaking of Rage (LFR)
		ct.aoespam[107821] = true	-- Speaking of Rage (Normal)
		ct.aoespam[109859] = true	-- Speaking of Rage (Heroic)
	end
elseif T.class == "DEATHKNIGHT" then
	if C.combattext.merge_aoe_spam then
		ct.aoespam[55095] = true	-- Frost Fever
		ct.aoespam[55078] = true	-- Blood Plague
		ct.aoespam[55536] = true	-- Unholy Blight
		ct.aoespam[48721] = true	-- Blood Boil
		ct.aoespam[49184] = true	-- Howling Blast
		ct.aoespam[52212] = true	-- Death and Decay
		ct.aoespam[47541] = true	-- Death Coil
		ct.aoespam[55050] = true	-- Heart Strike
		ct.aoespam[98957] = true	-- Burning Blood (T13 x2)
		ct.aoespam[59754] = true	-- Rune Tap (AOE heal)
		-- Merging mh/oh strikes(by Bozo)
		ct.aoespam[49020] = true	-- Obliterate MH
		ct.aoespam[66198] = 49020	-- Obliterate OH
		ct.aoespam[49998] = true	-- Death Strike MH
		ct.aoespam[66188] = 49998	-- Death Strike OH
		ct.aoespam[45462] = true	-- Plague Strike MH
		ct.aoespam[66216] = 45462	-- Plague Strike OH
		ct.aoespam[49143] = true	-- Frost Strike MH
		ct.aoespam[66196] = 49143	-- Frost Strike OH
		ct.aoespam[56815] = true	-- Rune Strike MH
		ct.aoespam[66217] = 56815	-- Rune Strike OH
		ct.aoespam[45902] = true	-- Blood Strike MH
		ct.aoespam[66215] = 45902	-- Blood Strike OH
		-- Item spells
		ct.aoespam[109752] = true	-- Whirling Maw (LFR)
		ct.aoespam[107997] = true	-- Whirling Maw (Normal)
		ct.aoespam[109754] = true	-- Whirling Maw (Heroic)
		ct.aoespam[52586] = true	-- Gurthalak, Voice of the Deeps
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		ct.aoespam[51723] = true	-- Fan of Knives
		ct.aoespam[2818] = true		-- Deadly Poison
		ct.aoespam[8680] = true		-- Instant Poison
		-- Merging mh/oh strikes
		ct.aoespam[5374] = true		-- Mutilate
		ct.aoespam[27576] = 5374	-- Mutilate Off-Hand
	end
end

if C.combattext.merge_aoe_spam then
	-- Dragon Soul - The Madness of Deathwing
	ct.aoespam[109609] = true	-- Spellweave
	ct.aoespam[109610] = true	-- Spellweave
	ct.aoespam[106043] = true	-- Spellweave
	ct.aoespam[109611] = true	-- Spellweave
end

-- Do not edit below unless you know what you are doing
local numf
if C.combattext.damage or C.combattext.healing then
	numf = 4
else
	numf = 3
end

-- Detect vechile
local function SetUnit()
	if UnitHasVehicleUI("player") then
		ct.unit = "vehicle"
	else
		ct.unit = "player"
	end
	CombatTextSetActiveUnit(ct.unit)
end

-- Limit lines
local function LimitLines()
	for i = 1, #ct.frames do
		f = ct.frames[i]
		f:SetMaxLines(f:GetHeight() / C.font.combat_text_font_size)
	end
end

-- Scrollable frames
local function SetScroll()
	for i = 1, #ct.frames do
		ct.frames[i]:EnableMouseWheel(true)
		ct.frames[i]:SetScript("OnMouseWheel", function(self, delta)
			if delta > 0 then
				self:ScrollUp()
			elseif delta < 0 then
				self:ScrollDown()
			end
		end)
	end
end

-- Msg flow direction
local function ScrollDirection()
	if COMBAT_TEXT_FLOAT_MODE == "2" then
		ct.mode = "TOP"
	else
		ct.mode = "BOTTOM"
	end
	for i = 1, #ct.frames do
		ct.frames[i]:Clear()
		ct.frames[i]:SetInsertMode(ct.mode)
	end
end

-- Partial resists styler
local part = "-%s [%s %s]"
local r, g, b

-- Function, handles everything
local function OnEvent(self, event, subevent, ...)
	if event == "COMBAT_TEXT_UPDATE" then
		local arg2, arg3 = ...
		if SHOW_COMBAT_TEXT == "0" then
			return
		else
			if subevent == "DAMAGE" then
				xCT1:AddMessage("-"..arg2, 0.75, 0.1, 0.1)
			elseif subevent == "DAMAGE_CRIT" then
				xCT1:AddMessage("|cffFF0000"..C.combattext.crit_prefix.."|r".."-"..arg2.."|cffFF0000"..C.combattext.crit_postfix.."|r", 1, 0.1, 0.1)
			elseif subevent == "SPELL_DAMAGE" then
				xCT1:AddMessage("-"..arg2, 0.75, 0.3, 0.85)
			elseif subevent == "SPELL_DAMAGE_CRIT" then
				xCT1:AddMessage("|cffFF0000"..C.combattext.crit_prefix.."|r".."-"..arg2.."|cffFF0000"..C.combattext.crit_postfix.."|r", 1, 0.3, 0.5)
			elseif subevent == "HEAL" then
				if arg3 >= C.combattext.heal_treshold then
					if arg2 then
						if COMBAT_TEXT_SHOW_FRIENDLY_NAMES == "1" then
							xCT2:AddMessage(arg2.." +"..arg3, 0.1, 0.75, 0.1)
						else
							xCT2:AddMessage("+"..arg3, 0.1, 0.75, 0.1)
						end
					end
				end
			elseif subevent == "HEAL_CRIT" then
				if arg3 >= C.combattext.heal_treshold then
					if arg2 then
						if COMBAT_TEXT_SHOW_FRIENDLY_NAMES == "1" then
							xCT2:AddMessage(arg2.." +"..arg3, 0.1, 1, 0.1)
						else
							xCT2:AddMessage("+"..arg3, 0.1, 1, 0.1)
						end
					end
				end
			elseif subevent == "PERIODIC_HEAL" then
				if arg3 >= C.combattext.heal_treshold then
					xCT2:AddMessage("+"..arg3, 0.1, 0.5, 0.1)
				end
			elseif subevent == "SPELL_CAST" then
				xCT3:AddMessage(arg2, 1, 0.82, 0)
			elseif subevent == "MISS" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(MISS, 0.5, 0.5, 0.5)
			elseif subevent == "DODGE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(DODGE, 0.5, 0.5, 0.5)
			elseif subevent == "PARRY" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(PARRY, 0.5, 0.5, 0.5)
			elseif subevent == "EVADE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(EVADE, 0.5, 0.5, 0.5)
			elseif subevent == "IMMUNE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(IMMUNE, 0.5, 0.5, 0.5)
			elseif subevent == "DEFLECT" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(DEFLECT, 0.5, 0.5, 0.5)
			elseif subevent == "REFLECT" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(REFLECT, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_MISS" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(MISS, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_DODGE"and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(DODGE, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_PARRY" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(PARRY, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_EVADE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(EVADE, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_IMMUNE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(IMMUNE, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_DEFLECT" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(DEFLECT, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_REFLECT" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(REFLECT, 0.5, 0.5, 0.5)
			elseif subevent == "RESIST" then
				if arg3 then
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, RESIST, arg3), 0.75, 0.5, 0.5)
					else
						xCT1:AddMessage(arg2, 0.75, 0.1, 0.1)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(RESIST, 0.5, 0.5, 0.5)
				end
			elseif subevent == "BLOCK" then
				if arg3 then
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, BLOCK, arg3), 0.75, 0.5, 0.5)
					else
						xCT1:AddMessage(arg2, 0.75, 0.1, 0.1)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(BLOCK, 0.5, 0.5, 0.5)
				end
			elseif subevent == "ABSORB" then
				if arg3 then
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, ABSORB, arg3), 0.75, 0.5, 0.5)
					else
						xCT1:AddMessage(arg2, 0.75, 0.1, 0.1)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(ABSORB, 0.5, 0.5, 0.5)
				end
			elseif subevent == "SPELL_RESIST" then
				if arg3 then
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, RESIST, arg3), 0.5, 0.3, 0.5)
					else
						xCT1:AddMessage(arg2, 0.75, 0.3, 0.85)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(RESIST, 0.5, 0.5, 0.5)
				end
			elseif subevent == "SPELL_BLOCK" then
				if arg3 then
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, BLOCK, arg3), 0.5, 0.3, 0.5)
					else
						xCT1:AddMessage("-"..arg2, 0.75, 0.3, 0.85)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(BLOCK, 0.5, 0.5, 0.5)
				end
			elseif subevent == "SPELL_ABSORB" then
				if arg3 then
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, ABSORB, arg3), 0.5, 0.3, 0.5)
					else
						xCT1:AddMessage(arg2, 0.75, 0.3, 0.85)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(ABSORB, 0.5, 0.5, 0.5)
				end
			elseif subevent == "ENERGIZE" and COMBAT_TEXT_SHOW_ENERGIZE == "1" then
				if tonumber(arg2) > 0 then
					if arg3 and arg3 == "MANA" or arg3 == "RAGE" or arg3 == "FOCUS" or arg3 == "ENERGY" or arg3 == "RUNIC_POWER" or arg3 == "SOUL_SHARDS" or arg3 == "HOLY_POWER" then
						xCT3:AddMessage("+"..arg2.." ".._G[arg3], PowerBarColor[arg3].r, PowerBarColor[arg3].g, PowerBarColor[arg3].b)
					end
				end
			elseif subevent == "PERIODIC_ENERGIZE" and COMBAT_TEXT_SHOW_PERIODIC_ENERGIZE == "1" then
				if tonumber(arg2) > 0 then
					if arg3 and arg3 == "MANA" or arg3 == "RAGE" or arg3 == "FOCUS" or arg3 == "ENERGY" or arg3 == "RUNIC_POWER" or arg3 == "SOUL_SHARDS" or arg3 == "HOLY_POWER" then
						xCT3:AddMessage("+"..arg2.." ".._G[arg3], PowerBarColor[arg3].r, PowerBarColor[arg3].g, PowerBarColor[arg3].b)
					end
				end
			elseif subevent == "SPELL_AURA_START" and COMBAT_TEXT_SHOW_AURAS == "1" then
				xCT3:AddMessage("+"..arg2, 1, 0.5, 0.5)
			elseif subevent == "SPELL_AURA_END" and COMBAT_TEXT_SHOW_AURAS == "1" then
				xCT3:AddMessage("-"..arg2, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_AURA_START_HARMFUL" and COMBAT_TEXT_SHOW_AURAS == "1" then
				xCT3:AddMessage("+"..arg2, 1, 0.1, 0.1)
			elseif subevent == "SPELL_AURA_END_HARMFUL" and COMBAT_TEXT_SHOW_AURAS == "1" then
				xCT3:AddMessage("-"..arg2, 0.1, 1, 0.1)
			elseif subevent == "HONOR_GAINED" and COMBAT_TEXT_SHOW_HONOR_GAINED == "1" then
				arg2 = tonumber(arg2)
				if arg2 and abs(arg2) > 1 then
					arg2 = floor(arg2)
					if arg2 > 0 then
						xCT3:AddMessage(HONOR.." +"..arg2, 0.1, 0.1, 1)
					end
				end
			elseif subevent == "FACTION" and COMBAT_TEXT_SHOW_REPUTATION == "1" then
				xCT3:AddMessage(arg2.." +"..arg3, 0.1, 0.1, 1)
			elseif subevent == "SPELL_ACTIVE" and COMBAT_TEXT_SHOW_REACTIVES == "1" then
				xCT3:AddMessage(arg2, 1, 0.82, 0)
			end
		end
	elseif event == "UNIT_HEALTH" and COMBAT_TEXT_SHOW_LOW_HEALTH_MANA == "1" then
		if subevent == ct.unit then
			if UnitHealth(ct.unit) / UnitHealthMax(ct.unit) <= COMBAT_TEXT_LOW_HEALTH_THRESHOLD then
				if not lowHealth then
					xCT3:AddMessage(HEALTH_LOW, 1, 0.1, 0.1)
					lowHealth = true
				end
			else
				lowHealth = nil
			end
		end
	elseif event == "UNIT_MANA" and COMBAT_TEXT_SHOW_LOW_HEALTH_MANA == "1" then
		if subevent == ct.unit then
			local _, powerToken = UnitPowerType(ct.unit)
			if powerToken == "MANA" and (UnitPower(ct.unit) / UnitPowerMax(ct.unit)) <= COMBAT_TEXT_LOW_MANA_THRESHOLD then
				if not lowMana then
					xCT3:AddMessage(MANA_LOW, 1, 0.1, 0.1)
					lowMana = true
				end
			else
				lowMana = nil
			end
		end
	elseif event == "PLAYER_REGEN_ENABLED" and COMBAT_TEXT_SHOW_COMBAT_STATE == "1" then
			xCT3:AddMessage("-"..LEAVING_COMBAT, 0.1, 1, 0.1)
	elseif event == "PLAYER_REGEN_DISABLED" and COMBAT_TEXT_SHOW_COMBAT_STATE == "1" then
			xCT3:AddMessage("+"..ENTERING_COMBAT, 1, 0.1, 0.1)
	elseif event == "UNIT_COMBO_POINTS" and COMBAT_TEXT_SHOW_COMBO_POINTS == "1" then
		if subevent == ct.unit then
			local cp = GetComboPoints(ct.unit, "target")
			if cp > 0 then
				r, g, b = 1, 0.82, 0
				if cp == MAX_COMBO_POINTS then
					r, g, b = 0, 0.82, 1
				end
				xCT3:AddMessage(format(COMBAT_TEXT_COMBO_POINTS, cp), r, g, b)
			end
		end
	elseif event == "RUNE_POWER_UPDATE" then
		local arg1, arg2 = subevent, ...
		if arg2 then
			local rune = GetRuneType(arg1)
			local msg = COMBAT_TEXT_RUNE[rune]
			if rune == 1 then
				r, g, b = 0.75, 0, 0
			elseif rune == 2 then
				r, g, b = 0.75, 1, 0
			elseif rune == 3 then
				r, g, b = 0, 1, 1
			end
			if rune and rune < 4 then
				xCT3:AddMessage("+"..msg, r, g, b)
			end
		end
	elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITING_VEHICLE" then
		if arg1 == "player" then
			SetUnit()
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		SetUnit()
		if C.combattext.scrollable then
			SetScroll()
		else
			LimitLines()
		end
		if C.combattext.damage or C.combattext.healing then
			ct.pguid = UnitGUID("player")
		end
	end
end

-- Change damage font
if C.combattext.damage_style then
	DAMAGE_TEXT_FONT = C.font.combat_text_font
end

-- Frames
ct.locked = true
ct.frames = {}
for i = 1, numf do
	local f = CreateFrame("ScrollingMessageFrame", "xCT"..i, UIParent)
	f:SetFont(C.font.combat_text_font, C.font.combat_text_font_size, C.font.combat_text_font_style)
	f:SetShadowColor(0, 0, 0, C.font.combat_text_font_shadow and 1 or 0)
	f:SetShadowOffset(C.font.combat_text_font_shadow and 1 or 0, C.font.combat_text_font_shadow and -1 or 0)
	f:SetTimeVisible(C.combattext.time_visible)
	f:SetMaxLines(C.combattext.max_lines)
	f:SetSpacing(2)
	f:SetWidth(128)
	f:SetHeight(128)
	f:SetPoint("CENTER", 0, 0)
	f:SetMovable(true)
	f:SetResizable(true)
	f:SetMinResize(128, 128)
	f:SetMaxResize(768, 768)
	f:SetClampedToScreen(true)
	f:SetClampRectInsets(0, 0, C.font.combat_text_font_size, 0)
	if i == 1 then
		f:SetJustifyH(ct.justify_1)
		if C.unitframe.enable == true and _G.oUF_Player then
			f:SetPoint("BOTTOMLEFT", "oUF_Player", "TOPLEFT", -3, 60)
		else
			f:SetPoint("CENTER", -192, -32)
		end
	elseif i == 2 then
		f:SetJustifyH(ct.justify_2)
		if C.unitframe.enable == true and _G.oUF_Player then
			f:SetPoint("BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 5, 60)
		else
			f:SetPoint("CENTER", 192, -32)
		end
	elseif i == 3 then
		f:SetJustifyH(ct.justify_3)
		f:SetWidth(256)
		f:SetPoint("CENTER", 0, 205)
	else
		f:SetJustifyH(ct.justify_4)
		f:SetWidth(200)
		if C.unitframe.enable == true and _G.oUF_Target then
			f:SetPoint("BOTTOMRIGHT", "oUF_Target", "TOPRIGHT", 2, 278)
		else
			f:SetPoint("CENTER", 330, 205)
		end
		local a, _, c = f:GetFont()
		if C.font.combat_text_font_size == "auto" then
			if C.combattext.icons then
				f:SetFont(a, C.combattext.icon_size / 2, c)
			end
		elseif type(C.font.combat_text_font_size) == "number" then
			f:SetFont(a, C.font.combat_text_font_size, c)
		end
	end
	ct.frames[i] = f
end

-- Register events
local xCT = CreateFrame("Frame")
xCT:RegisterEvent("COMBAT_TEXT_UPDATE")
xCT:RegisterEvent("UNIT_HEALTH")
xCT:RegisterEvent("UNIT_MANA")
xCT:RegisterEvent("PLAYER_REGEN_DISABLED")
xCT:RegisterEvent("PLAYER_REGEN_ENABLED")
xCT:RegisterEvent("UNIT_COMBO_POINTS")
if C.combattext.dk_runes and T.class == "DEATHKNIGHT" then
	xCT:RegisterEvent("RUNE_POWER_UPDATE")
end
xCT:RegisterEvent("UNIT_ENTERED_VEHICLE")
xCT:RegisterEvent("UNIT_EXITING_VEHICLE")
xCT:RegisterEvent("PLAYER_ENTERING_WORLD")
xCT:SetScript("OnEvent", OnEvent)

-- Turn off Blizzard CT
CombatText:UnregisterAllEvents()
CombatText:SetScript("OnLoad", nil)
CombatText:SetScript("OnEvent", nil)
CombatText:SetScript("OnUpdate", nil)

-- Steal external messages sent by other addons using CombatText_AddMessage
Blizzard_CombatText_AddMessage = CombatText_AddMessage
function CombatText_AddMessage(message, scrollFunction, r, g, b, displayType, isStaggered)
	xCT3:AddMessage(message, r, g, b)
end

-- Color printer
local pr = function(msg)
	print(tostring(msg))
end

-- Configmode and testmode
local StartConfigmode = function()
	if not InCombatLockdown()then
		for i = 1, #ct.frames do
			f = ct.frames[i]
			f:SetTemplate("Transparent")
			f:SetBackdropBorderColor(1, 0, 0, 1)

			f.fs = f:CreateFontString(nil, "OVERLAY")
			f.fs:SetFont(C.font.combat_text_font, C.font.combat_text_font_size, C.font.combat_text_font_style)
			f.fs:SetPoint("BOTTOM", f, "TOP", 0, 0)
			if i == 1 then
				f.fs:SetText(DAMAGE)
				f.fs:SetTextColor(1, 0.1, 0.1, 0.9)
			elseif i == 2 then
				f.fs:SetText(SHOW_COMBAT_HEALING)
				f.fs:SetTextColor(0.1, 1, 0.1, 0.9)
			elseif i == 3 then
				f.fs:SetText(COMBAT_TEXT_LABEL)
				f.fs:SetTextColor(0.1, 0.1, 1, 0.9)
			else
				f.fs:SetText(SCORE_DAMAGE_DONE.." / "..SCORE_HEALING_DONE)
				f.fs:SetTextColor(1, 1, 0, 0.9)
			end

			f.t = f:CreateTexture("ARTWORK")
			f.t:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
			f.t:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -19)
			f.t:SetHeight(20)
			f.t:SetTexture(0.5, 0.5, 0.5)
			f.t:SetAlpha(0.3)

			f.d = f:CreateTexture("ARTWORK")
			f.d:SetHeight(16)
			f.d:SetWidth(16)
			f.d:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
			f.d:SetTexture(0.5, 0.5, 0.5)
			f.d:SetAlpha(0.3)

			f.tr = f:CreateTitleRegion()
			f.tr:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
			f.tr:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
			f.tr:SetHeight(20)

			f:EnableMouse(true)
			f:RegisterForDrag("LeftButton")
			f:SetScript("OnDragStart", f.StartSizing)
			if not C.combattext.scrollable then
				f:SetScript("OnSizeChanged", function(self)
					self:SetMaxLines(self:GetHeight() / C.font.combat_text_font_size)
					self:Clear()
				end)
			end

			f:SetScript("OnDragStop", f.StopMovingOrSizing)
			ct.locked = false
		end
		pr("|cffffff00"..L_COMBATTEXT_UNLOCKED.."|r")
	else
		pr("|cffffff00"..ERR_NOT_IN_COMBAT.."|r")
	end
end

local function EndConfigmode()
	for i = 1, #ct.frames do
		f = ct.frames[i]
		f:SetBackdrop(nil)
		f.iborder:Hide()
		f.oborder:Hide()
		f.fs:Hide()
		f.fs = nil
		f.t:Hide()
		f.t = nil
		f.d:Hide()
		f.d = nil
		f.tr = nil
		f:EnableMouse(false)
		f:SetScript("OnDragStart", nil)
		f:SetScript("OnDragStop", nil)
	end
	ct.locked = true
	pr("|cffffff00"..L_COMBATTEXT_UNSAVED.."|r")
end

local function StartTestMode()
	-- Init random number generator
	local random = math.random
	random(time()); random(); random(time())

	local TimeSinceLastUpdate = 0
	local UpdateInterval
	if C.combattext.damage_color then
		ct.dmindex = {}
		ct.dmindex[1] = 1
		ct.dmindex[2] = 2
		ct.dmindex[3] = 4
		ct.dmindex[4] = 8
		ct.dmindex[5] = 16
		ct.dmindex[6] = 32
		ct.dmindex[7] = 64
	end

	for i = 1, #ct.frames do
		ct.frames[i]:SetScript("OnUpdate", function(self, elapsed)
			UpdateInterval = random(65, 1000) / 250
			TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
			if TimeSinceLastUpdate > UpdateInterval then
				if i == 1 then
					ct.frames[i]:AddMessage("-"..random(100000), 1, random(255) / 255, random(255) / 255)
				elseif i == 2 then
					ct.frames[i]:AddMessage("+"..random(50000), 0.1, random(128, 255) / 255, 0.1)
				elseif i == 3 then
					ct.frames[i]:AddMessage(COMBAT_TEXT_LABEL, random(255) / 255, random(255) / 255, random(255) / 255)
				elseif i == 4 then
					local msg
					local icon
					local color = {}
					msg = random(40000)
					if C.combattext.icons then
						_, _, icon = GetSpellInfo(msg)
					end
					if icon then
						msg = msg.." \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
						if C.combattext.damage_color then
							color = ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
						else
							color = {1, 1, 0}
						end
					elseif C.combattext.damage_color and not C.combattext.icons then
						color = ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
					elseif not C.combattext.damage_color then
						color = {1, 1, random(0, 1)}
					end
					ct.frames[i]:AddMessage(msg, unpack(color))
				end
				TimeSinceLastUpdate = 0
			end
		end)
		ct.testmode = true
	end
end

local function EndTestMode()
	for i = 1, #ct.frames do
		ct.frames[i]:SetScript("OnUpdate", nil)
		ct.frames[i]:Clear()
	end
	if C.combattext.damage_color then
		ct.dmindex = nil
	end
	ct.testmode = false
end

-- Popup dialog
StaticPopupDialogs.XCT_LOCK = {
	text = L_COMBATTEXT_POPUP,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() if not InCombatLockdown() then ReloadUI() else EndConfigmode() end end,
	OnCancel = EndConfigmode,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	showAlert = true,
	preferredIndex = 3,
}

-- Slash commands
SlashCmdList.XCT = function(input)
	input = string.lower(input)
	if input == "unlock" then
		if ct.locked then
			StartConfigmode()
		else
			pr("|cffffff00"..L_COMBATTEXT_ALREADY_UNLOCKED.."|r")
		end
	elseif input == "lock" then
		if ct.locked then
			pr("|cffffff00"..L_COMBATTEXT_ALREADY_LOCKED.."|r")
		else
			StaticPopup_Show("XCT_LOCK")
		end
	elseif input == "test" then
		if ct.testmode then
			EndTestMode()
			pr("|cffffff00"..L_COMBATTEXT_TEST_DISABLED.."|r")
		else
			StartTestMode()
			pr("|cffffff00"..L_COMBATTEXT_TEST_ENABLED.."|r")
		end
	else
		pr("|cffffff00"..L_COMBATTEXT_TEST_USE_UNLOCK.."|r")
		pr("|cffffff00"..L_COMBATTEXT_TEST_USE_LOCK.."|r")
		pr("|cffffff00"..L_COMBATTEXT_TEST_USE_TEST.."|r")
	end
end
SLASH_XCT1 = "/xct"
SLASH_XCT2 = "/чсе"

-- Shadow priest helper
if C.combattext.stop_ve_spam and T.class == "PRIEST" then
	local sp = CreateFrame("Frame")
	sp:SetScript("OnEvent", function(...)
		if GetShapeshiftForm() == 1 then
			if C.combattext.blizz_head_numbers then
				SetCVar("CombatHealing", 0)
			end
		else
			if C.combattext.blizz_head_numbers then
				SetCVar("CombatHealing", 1)
			end
		end
	end)
	sp:RegisterEvent("PLAYER_ENTERING_WORLD")
	sp:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	sp:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
end

-- Spam merger
local SQ
if C.combattext.merge_aoe_spam then
	if C.combattext.damage or C.combattext.healing then
		if not C.combattext.merge_aoe_spam_time or C.combattext.merge_aoe_spam_time < 1 then
			C.combattext.merge_aoe_spam_time = 1
		end
		local pairs = pairs
		SQ = {}
		for k, v in pairs(ct.aoespam) do
			SQ[k] = {queue = 0, msg = "", color = {}, count = 0, utime = 0, locked = false}
		end
		ct.SpamQueue = function(spellId, add)
			local amount
			local spam = SQ[spellId]["queue"]
			if spam and type(spam) == "number" then
				amount = spam + add
			else
				amount = add
			end
			return amount
		end
		local tslu = 0
		local xCTspam = CreateFrame("Frame")
		xCTspam:SetScript("OnUpdate", function(self, elapsed)
			local count
			tslu = tslu + elapsed
			if tslu > 0.5 then
				tslu = 0
				local utime = time()
				for k, v in pairs(SQ) do
					if not SQ[k]["locked"] and SQ[k]["queue"] > 0 and SQ[k]["utime"] + C.combattext.merge_aoe_spam_time <= utime then
						if SQ[k]["count"] > 1 then
							count = " |cffFFFFFF x "..SQ[k]["count"].."|r"
						else
							count = ""
						end
						xCT4:AddMessage(SQ[k]["queue"]..count..SQ[k]["msg"], unpack(SQ[k]["color"]))
						SQ[k]["queue"] = 0
						SQ[k]["count"] = 0
					end
				end
			end
		end)
	end
end

-- Damage
if C.combattext.damage then
	local unpack, select, time = unpack, select, time
	local gflags = bit.bor(COMBATLOG_OBJECT_AFFILIATION_MINE,
 		COMBATLOG_OBJECT_REACTION_FRIENDLY,
 		COMBATLOG_OBJECT_CONTROL_PLAYER,
 		COMBATLOG_OBJECT_TYPE_GUARDIAN
 	)
	local xCTd = CreateFrame("Frame")
	if C.combattext.damage_color then
		ct.dmgcolor = {}
		ct.dmgcolor[1] = {1, 1, 0}		-- Physical
		ct.dmgcolor[2] = {1, 0.9, 0.5}	-- Holy
		ct.dmgcolor[4] = {1, 0.5, 0}	-- Fire
		ct.dmgcolor[8] = {0.3, 1, 0.3}	-- Nature
		ct.dmgcolor[16] = {0.5, 1, 1}	-- Frost
		ct.dmgcolor[32] = {0.5, 0.5, 1}	-- Shadow
		ct.dmgcolor[64] = {1, 0.5, 1}	-- Arcane
	end
	if C.combattext.icons then
		ct.blank = "Interface\\AddOns\\ShestakUI\\Media\\Textures\\Blank.tga"
	end
	local misstypes = {ABSORB = ABSORB, BLOCK = BLOCK, DODGE = DODGE, EVADE = EVADE, IMMUNE = IMMUNE, MISS = MISS, PARRY = PARRY, REFLECT = REFLECT, RESIST = RESIST, DEFLECT = DEFLECT}
	local dmg = function(self, event, ...)
		local msg, icon
		local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, srcFlags2, destGUID, destName, destFlags, destFlags2 = select(1, ...)
		if (sourceGUID == ct.pguid and destGUID ~= ct.pguid) or (sourceGUID == UnitGUID("pet") and C.combattext.pet_damage) or (sourceFlags == gflags) then
			if eventType == "SWING_DAMAGE" then
				local amount, _, _, _, _, _, critical = select(12, ...)
				if amount >= C.combattext.treshold then
					msg = amount
					if critical then
						msg = "|cffFF0000"..C.combattext.crit_prefix.."|r"..msg.."|cffFF0000"..C.combattext.crit_postfix.."|r"
					end
					if C.combattext.icons then
						if (sourceGUID == UnitGUID("pet")) or (sourceFlags == gflags) then
							icon = PET_ATTACK_TEXTURE
						else
							icon = GetSpellTexture(6603)
						end
						msg = msg.." \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
					end
					xCT4:AddMessage(msg)
				end
			elseif eventType == "RANGE_DAMAGE" then
				local spellId, _, _, amount, _, _, _, _, _, critical = select(12, ...)
				if amount >= C.combattext.treshold then
					msg = amount
					if critical then
						msg = "|cffFF0000"..C.combattext.crit_prefix.."|r"..msg.."|cffFF0000"..C.combattext.crit_postfix.."|r"
					end
					if C.combattext.icons then
						icon = GetSpellTexture(spellId)
						msg = msg.." \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
					end
					xCT4:AddMessage(msg)
				end
			elseif eventType == "SPELL_DAMAGE" or (eventType == "SPELL_PERIODIC_DAMAGE" and C.combattext.dot_damage) then
				local spellId, _, spellSchool, amount, _, _, _, _, _, critical = select(12, ...)
				if amount >= C.combattext.treshold then
					local color = {}
					local rawamount = amount
					if critical then
						amount = "|cffFF0000"..C.combattext.crit_prefix.."|r"..amount.."|cffFF0000"..C.combattext.crit_postfix.."|r"
					end
					if C.combattext.icons then
						icon = GetSpellTexture(spellId)
					end
					if C.combattext.damage_color then
						if ct.dmgcolor[spellSchool] then
							color = ct.dmgcolor[spellSchool]
						else
							color = ct.dmgcolor[1]
						end
					else
						color = {1, 1, 0}
					end
					if icon then
						msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
					elseif C.combattext.icons then
						msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
					else
						msg = ""
					end
					if C.combattext.merge_aoe_spam and ct.aoespam[spellId] then
						SQ[spellId]["locked"] = true
						SQ[spellId]["queue"] = ct.SpamQueue(spellId, rawamount)
						SQ[spellId]["msg"] = msg
						SQ[spellId]["color"] = color
						SQ[spellId]["count"] = SQ[spellId]["count"] + 1
						if SQ[spellId]["count"] == 1 then
							SQ[spellId]["utime"] = time()
						end
						SQ[spellId]["locked"] = false
						return
					end
					xCT4:AddMessage(amount..""..msg, unpack(color))
				end
			elseif eventType == "SWING_MISSED" then
				local missType, _ = select(12, ...)
				if C.combattext.icons then
					if sourceGUID == UnitGUID("pet") or sourceFlags == gflags then
						icon = PET_ATTACK_TEXTURE
					else
						icon = GetSpellTexture(6603)
					end
					missType = misstypes[missType].." \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					missType = misstypes[missType]
				end
				xCT4:AddMessage(missType)
			elseif eventType == "SPELL_MISSED" or eventType == "RANGE_MISSED" then
				local spellId, _, _, missType, _ = select(12, ...)
				if C.combattext.icons then
					icon = GetSpellTexture(spellId)
					missType = misstypes[missType].." \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					missType = misstypes[missType]
				end 
				xCT4:AddMessage(missType)
			elseif eventType == "SPELL_DISPEL" and C.combattext.dispel then
				local target, _, _, id, effect, _, etype = select(12, ...)
				local color
				if C.combattext.icons then
					icon = GetSpellTexture(id)
				end
				if icon then
					msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				elseif C.combattext.icons then
					msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					msg = ""
				end
				if etype == "BUFF" then
					color = {0, 1, 0.5}
				else
					color = {1, 0, 0.5}
				end
				xCT3:AddMessage(ACTION_SPELL_DISPEL..": "..effect..msg, unpack(color))
			elseif eventType == "SPELL_STOLEN" and C.combattext.dispel then
				local target, _, _, id, effect = select(12, ...)
				local color = {1, 0.5, 0}
				if C.combattext.icons then
					icon = GetSpellTexture(id)
				end
				if icon then
					msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				elseif C.combattext.icons then
					msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					msg = ""
				end
				xCT3:AddMessage(ACTION_SPELL_STOLEN..": "..effect..msg, unpack(color))
			elseif eventType == "SPELL_INTERRUPT" and C.combattext.interrupt then
				local target, _, _, id, effect = select(12, ...)
				local color = {1, 0.5, 0}
				if C.combattext.icons then
					icon = GetSpellTexture(id)
				end
				if icon then
					msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				elseif C.combattext.icons then
					msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					msg = ""
				end
				xCT3:AddMessage(ACTION_SPELL_INTERRUPT..": "..effect..msg, unpack(color))
			elseif eventType == "PARTY_KILL" and C.combattext.killingblow then
				local tname = select(9, ...)
				xCT3:AddMessage(ACTION_PARTY_KILL..": "..tname, 0.2, 1, 0.2)
			end
		end
	end

	xCTd:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	xCTd:SetScript("OnEvent", dmg)
end

-- Healing
if C.combattext.healing then
	local unpack, select, time = unpack, select, time
	local xCTh = CreateFrame("Frame")
	if C.combattext.icons then
		ct.blank = "Interface\\AddOns\\ShestakUI\\Media\\Textures\\Blank.tga"
	end
	local heal = function(self, event, ...)
		local msg, icon
		local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2 = select(1, ...)
		if sourceGUID == ct.pguid or sourceFlags == gflags then
			if eventType == "SPELL_HEAL" or (eventType == "SPELL_PERIODIC_HEAL" and C.combattext.show_hots) then
				if C.combattext.healing then
					local spellId, spellName, spellSchool, amount, overhealing, absorbed, critical = select(12, ...)
					if ct.healfilter[spellId] then
						return
					end
					if amount >= C.combattext.heal_treshold then
						local color = {}
						local rawamount = amount
						if C.combattext.show_overhealing and abs(overhealing) > 0 then
							amount = math.floor(amount-overhealing).." ["..floor(overhealing).."]"
						end
						if critical then
							amount = "|cffFF0000"..C.combattext.crit_prefix.."|r"..amount.."|cffFF0000"..C.combattext.crit_postfix.."|r"
							color = {0.1, 1, 0.1}
						else
							color = {0.1, 0.65, 0.1}
						end 
						if C.combattext.icons then
							icon = GetSpellTexture(spellId)
						else
							msg = ""
						end
						if icon then
							msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
						elseif(C.combattext.icons)then
							msg=" \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
						end
						if C.combattext.merge_aoe_spam and ct.aoespam[spellId] then
							SQ[spellId]["locked"] = true
							SQ[spellId]["queue"] = ct.SpamQueue(spellId, rawamount)
							SQ[spellId]["msg"] = msg
							SQ[spellId]["color"] = color
							SQ[spellId]["count"] = SQ[spellId]["count"] + 1
							if SQ[spellId]["count"] == 1 then
								SQ[spellId]["utime"] = time()
							end
							SQ[spellId]["locked"] = false
							return
						end 
						xCT4:AddMessage(amount..""..msg, unpack(color))
					end
				end
			end
		end
	end

	xCTh:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	xCTh:SetScript("OnEvent", heal)
end