local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.RaidBuffs = {
	DRUID = {
															-- Abolish Poison (in all)
															-- Innervate
		{774, "TOPRIGHT", {0.8, 0.4, 0.8}},					-- Rejuvenation
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		-- {33763, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		-- {48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		-- {102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		-- {155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	PALADIN = {
															-- Lay on Hands (Armor Bonus)
		-- {53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		-- {114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},			-- Eternal Flame
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Blessing of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Blessing of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Blessing of Sacrifice
		-- {53601, "TOPLEFT", {0.4, 0.7, 0.2}, true},			-- Sacred Shield
	},
	PRIEST = {
															-- Abolish Disease (move to all?)
															-- Fear Ward
		-- {41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},			-- Power Word: Shield
		-- {33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{6788, "TOPRIGHT", {1, 0, 0}, true},				-- Weakened Soul
		{10060, "RIGHT", {0.89, 0.1, 0.1}},					-- Power Infusion
	},
	ROGUE = {
	},
	SHAMAN = {
		-- {974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},			-- Earth Shield
		{29203, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Healing Way (Change Color?)
		{16177, "TOPLEFT", {0.4, 0.7, 0.2}},				-- Ancestral Fortitude
	},
	WARLOCK = {
		{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},				-- Soulstone
	},
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true}, 					-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},					-- Warsong flag, Alliance
		{2893, "RIGHT", {0, 1, 0}, true}, 					-- Abolish Poison
		{26470, "RIGHT", {0.8, 0.2, 0}, true},				-- Persistent Shield [Scarab Brooch]
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
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to EsreverWoW.|r")
		return "Empty"
	end
end

T.RaidDebuffs = {
-----------------------------------------------------------------
-- Classic Raid
-----------------------------------------------------------------
-- World Bosses
	-- Azuregos
	-- Lord Kazzak
	-- Emeriss
	-- Lethon
	-- Ysondre
	-- Taerar

-- Molten Core (40)
	-- Trash
	-- Lucifron
	-- Magmadar
	-- Gehennas
	-- Garr
	-- Baron
	-- Geddon
	-- Shazzrah
	-- Sulfuron
	-- Golemagg
	-- Majordomo
	-- Ragnaros

-- Onyxia's Lair
	-- Onyxia

-- Blackwing Lair (40)
	-- Trash
	-- Razorgore
	-- Vaelastrasz
	-- Broodlord
	-- Firemaw
	-- Ebonroc
	-- Flamegor
	-- Chromaggus
	-- Nefarian

-- Zul'Gurub (20)
	-- Trash
	-- Jeklik
	-- Venoxis
	-- Mar'li
	-- Bloodlord
	-- Gahz'ranka
	-- Thekal
	-- Arlokk
	-- Jin'do
	-- Hakkar

-- Ruins of Ahn'Qiraj (20)
	-- Trash
	-- Kurinnaxx
	-- Rajaxx
	-- Moam
	-- Buru
	-- Ayamiss
	-- Ossirian

-- Temple of Ahn'Qiraj (40)
	-- Trash
	-- Skeram
	-- Royalty
	-- Sartura
	-- Fankriss
	-- Viscidus
	-- Huhuran
	-- Twin Emperors
	-- Ouro
	-- C'Thun

-- Naxxramas
	-- Trash
	-- Anub'Rekhan
	-- Faerlina
	-- Maexxna
	-- Patchwerk
	-- Grobbulus
	-- Gluth
	-- Thaddius
	-- Noth
	-- Heigan
	-- Loatheb
	-- Gothik
	-- Four Horsemen
	-- Sapphiron
	-- Kel'Thuzad

-----------------------------------------------------------------
-- Classic Dungeons
-----------------------------------------------------------------
-- Ragefire Chasm
-- Wailing Caverns
-- The Deadmines
-- Shadowfang Keep
-- Blackfathom Deeps
-- The Stockade
-- Gnomeregan
-- Razorfen Kraul
-- The Scarlet Monastery
-- Razorfen Downs
-- Uldaman
-- Zul'Farrak
-- Maraudon
-- Temple of Atal'Hakkar
-- Blackrock Depths
-- Lower Blackrock Spire
-- Upper Blackrock Spire
-- Dire Maul
-- Stratholme
-- Scholomance

-----------------------------------------------------------------
-- Other
-----------------------------------------------------------------

}

-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
if C.raidframe.plugins_pvp_debuffs == true then
	T.PvPDebuffs = {
		--[[
		-- Druid
		[SpellName(339)] = 2,		-- Entangling Roots
		[SpellName(5211)] = 3,		-- Bash
		[SpellName(22570)] = 3,		-- Mangle
		[SpellName(2637)] = 3,		-- Hibernate
		[SpellName(9005)] = 3,		-- Pounce
		[SpellName(19675)] = 2,		-- Feral Charge Effect
		[SpellName(16922)] = 3,		-- Celestial Focus
		[SpellName(19975)] = 2,		-- Entangling Roots (Nature's Grasp)
		-- Hunter
		[SpellName(3355)] = 3,		-- Freezing Trap
		[SpellName(19386)] = 3,		-- Wyvern Sting
		[SpellName(24394)] = 3,		-- Intimidation
		[SpellName(19503)] = 3,		-- Scatter Shot
		[SpellName(19185)] = 2,		-- Entrapment
		[SpellName(19410)] = 3,		-- Improved Concussive Shot
		[SpellName(2637)] = 3,		-- Hibernate
		[SpellName(19306)] = 2,		-- Counterattack
		[SpellName(19229)] = 2,		-- Improved Wing Clip
		-- Mage
		[SpellName(118)] = 3,		-- Polymorph
		[SpellName(122)] = 2,		-- Frost Nova
		[SpellName(12355)] = 3,		-- Impact
		[SpellName(18469)] = 3,		-- Silenced - Improved Counterspell
		[SpellName(28272)] = 3,		-- Polymorph (Pig)
		[SpellName(28271)] = 3,		-- Polymorph (Turtle)
		[SpellName(12494)] = 2,		-- Frostbite
		-- Paladin
		[SpellName(20066)] = 3,		-- Repentance
		[SpellName(853)] = 3,		-- Hammer of Justice
		[SpellName(20170)] = 3,		-- Stun (Seal of Justice Proc)
		[SpellName(2878)] = 3,		-- Turn Undead
		-- Priest
		[SpellName(605)] = 3,		-- Mind Control
		[SpellName(8122)] = 3,		-- Psychic Scream
		[SpellName(15487)] = 3,		-- Silence
		[SpellName(15269)] = 3,		-- Blackout
		[SpellName(9484)] = 3,		-- Shackle Undead
		-- Rogue
		[SpellName(6770)] = 3,		-- Sap
		[SpellName(2094)] = 3,		-- Blind
		[SpellName(1776)] = 3,		-- Gouge
		[SpellName(408)] = 3,		-- Kidney Shot
		[SpellName(1833)] = 3,		-- Cheap Shot
		[SpellName(18425)] = 3,		-- Silenced - Improved Kick
		[SpellName(14251)] = 3,		-- Riposte
		-- Warlock
		[SpellName(5782)] = 3,		-- Fear
		[SpellName(6789)] = 3,		-- Death Coil
		[SpellName(5484)] = 3,		-- Howl of Terror
		[SpellName(6358)] = 3,		-- Seduction (Succubus)
		[SpellName(24259)] = 3,		-- Spell Lock (Felhunter)
		[SpellName(18093)] = 3,		-- Pyroclasm
		-- Warrior
		[SpellName(5246)] = 3,		-- Intimidating Shout
		[SpellName(7922)] = 3,		-- Charge Stun
		[SpellName(12809)] = 3,		-- Concussion Blow
		[SpellName(20253)] = 3,		-- Intercept Stun
		[SpellName(23694)] = 2,		-- Improved Hamstring
		[SpellName(676)] = 3,		-- Disarm
		[SpellName(18498)] = 3,		-- Shield Bash - Silenced
		-- Racial
		[SpellName(20549)] = 3,		-- War Stomp
		-- Other
		[SpellName(5530)] = 3,		-- Mace Specialization
		--]]
	}
end

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- Spell name
}

T.RaidDebuffsIgnore = {
	--[spellID] = true,			-- Spell name
}