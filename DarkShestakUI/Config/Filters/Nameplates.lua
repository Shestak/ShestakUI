local T, C, L, _ = unpack(select(2, ...))
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Polymorph -> http://www.wowhead.com/spell=118
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	return name
end

T.DebuffWhiteList = {
	-- Death Knight
	[SpellName(115001)] = true,	-- Remorseless Winter
	[SpellName(108194)] = true,	-- Asphyxiate
	[SpellName(47476)] = true,	-- Strangulate
	[SpellName(59879)] = true,	-- Blood Plague
	[SpellName(59921)] = true,	-- Frost Fever
	-- Druid
	[SpellName(33786)] = true,	-- Cyclone
	[SpellName(2637)] = true,	-- Hibernate
	[SpellName(339)] = true,	-- Entangling Roots
	[SpellName(80964)] = true,	-- Skull Bash
	[SpellName(8921)] = true,	-- Moonfire
	[SpellName(93402)] = true,	-- Sunfire
	[SpellName(58180)] = true,	-- Infected Wounds
	[SpellName(33745)] = true,	-- Lacerate
	[SpellName(1822)] = true,	-- Rake
	[SpellName(1079)] = true,	-- Rip
	-- Hunter
	[SpellName(3355)] = true,	-- Freezing Trap
	[SpellName(1513)] = true,	-- Scare Beast
	[SpellName(19503)] = true,	-- Scatter Shot
	[SpellName(34490)] = true,	-- Silencing Shot
	-- Mage
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(31661)] = true,	-- Dragon's Breath
	[SpellName(55021)] = true,	-- Improved Counterspell
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(111340)] = true,	-- Ice Ward
	[SpellName(44457)] = true,	-- Living Bomb
	[SpellName(114923)] = true,	-- Nether Tempest
	[SpellName(112948)] = true,	-- Frost Bomb
	[SpellName(83853)] = true,	-- Combustion
	[SpellName(44572)] = true,	-- Deep Freeze
	[SpellName(120)] = true,	-- Cone of Cold
	[SpellName(102051)] = true,	-- Frostjaw
	-- Monk
	[SpellName(115078)] = true,	-- Paralysis
	-- Paladin
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(10326)] = true,	-- Turn Evil
	[SpellName(853)] = true,	-- Hammer of Justice
	[SpellName(105593)] = true,	-- Fist of Justice
	[SpellName(31803)] = true,	-- Censure
	-- Priest
	[SpellName(9484)] = true,	-- Shackle Undead
	[SpellName(8122)] = true,	-- Psychic Scream
	[SpellName(64044)] = true,	-- Psychic Horror
	[SpellName(15487)] = true,	-- Silence
	[SpellName(589)] = true,	-- Shadow Word: Pain
	[SpellName(34914)] = true,	-- Vampiric Touch
	-- Rogue
	[SpellName(6770)] = true,	-- Sap
	[SpellName(2094)] = true,	-- Blind
	[SpellName(1776)] = true,	-- Gouge
	-- Shaman
	[SpellName(51514)] = true,	-- Hex
	[SpellName(3600)] = true,	-- Earthbind
	[SpellName(8056)] = true,	-- Frost Shock
	[SpellName(8050)] = true,	-- Flame Shock
	[SpellName(63685)] = true,	-- Freeze
	-- Warlock
	[SpellName(710)] = true,	-- Banish
	[SpellName(6789)] = true,	-- Mortal Coil
	[SpellName(5782)] = true,	-- Fear
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(6358)] = true,	-- Seduction
	[SpellName(30283)] = true,	-- Shadowfury
	[SpellName(603)] = true,	-- Doom
	[SpellName(980)] = true,	-- Agony
	[SpellName(172)] = true,	-- Corruption
	[SpellName(48181)] = true,	-- Haunt
	[SpellName(348)] = true,	-- Immolate
	[SpellName(30108)] = true,	-- Unstable Affliction
	-- Warrior
	[SpellName(20511)] = true,	-- Intimidating Shout
	[SpellName(132168)] = true,	-- Shockwave
	[SpellName(115767)] = true,	-- Deep Wounds
	[SpellName(113746)] = true,	-- Weakened Armor
	-- Racial
	[SpellName(25046)] = true,	-- Arcane Torrent
	[SpellName(20549)] = true,	-- War Stomp
	[SpellName(107079)] = true,	-- Quaking Palm
}

T.PlateBlacklist = {
	-- Army of the Dead
	["Army of the Dead Ghoul"] = true,
	["Вурдалак из войска мертвых"] = true,
	-- Hunter Trap
	["Venomous Snake"] = true,
	["Ядовитая змея"] = true,
	["Viper"] = true,
	["Гадюка"] = true,
	-- Raid
	["Liquid Obsidian"] = true,
	["Жидкий обсидиан"] = true,
	["Lava Parasites"] = true,
	["Лавовый паразит"] = true,
	-- Gundrak
	["Fanged Pit Viper"] = true,
	["Клыкастая глубинная гадюка"] = true,
	-- Totems
	["Air Totem"] = true,
	["Тотем воздуха"] = true,
	["Water Totem"] = true,
	["Тотем воды"] = true,
	["Fire Totem"] = true,
	["Тотем огня"] = true,
	["Earth Totem"] = true,
	["Тотем земли"] = true,
}