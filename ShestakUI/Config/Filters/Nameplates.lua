local T, C, L, _ = unpack(select(2, ...))
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Polymorph -> http://www.wowhead.com/spell=118
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return "Empty"
	end
end

T.DebuffWhiteList = {
	-- Death Knight
	[SpellName(108194)] = true,	-- Asphyxiate
	[SpellName(47476)] = true,	-- Strangulate
	[SpellName(55078)] = true,	-- Blood Plague
	[SpellName(55095)] = true,	-- Frost Fever
	-- Druid
	[SpellName(33786)] = true,	-- Cyclone
	[SpellName(339)] = true,	-- Entangling Roots
	[SpellName(164812)] = true,	-- Moonfire
	[SpellName(164815)] = true,	-- Sunfire
	[SpellName(58180)] = true,	-- Infected Wounds
	[SpellName(155722)] = true,	-- Rake
	[SpellName(1079)] = true,	-- Rip
	-- Hunter
	[SpellName(3355)] = true,	-- Freezing Trap
	-- Mage
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(31661)] = true,	-- Dragon's Breath
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(44457)] = true,	-- Living Bomb
	[SpellName(114923)] = true,	-- Nether Tempest
	[SpellName(112948)] = true,	-- Frost Bomb
	[SpellName(120)] = true,	-- Cone of Cold
	-- Monk
	[SpellName(115078)] = true,	-- Paralysis
	-- Paladin
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(853)] = true,	-- Hammer of Justice
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
	[SpellName(196840)] = true,	-- Frost Shock
	[SpellName(188389)] = true,	-- Flame Shock
	-- Warlock
	[SpellName(710)] = true,	-- Banish
	[SpellName(6789)] = true,	-- Mortal Coil
	[SpellName(5782)] = true,	-- Fear
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(6358)] = true,	-- Seduction
	[SpellName(30283)] = true,	-- Shadowfury
	[SpellName(603)] = true,	-- Doom
	[SpellName(980)] = true,	-- Agony
	[SpellName(146739)] = true,	-- Corruption
	[SpellName(48181)] = true,	-- Haunt
	[SpellName(348)] = true,	-- Immolate
	[SpellName(30108)] = true,	-- Unstable Affliction
	-- Warrior
	[SpellName(5246)] = true,	-- Intimidating Shout
	[SpellName(132168)] = true,	-- Shockwave
	[SpellName(115767)] = true,	-- Deep Wounds
	-- Racial
	[SpellName(25046)] = true,	-- Arcane Torrent
	[SpellName(20549)] = true,	-- War Stomp
	[SpellName(107079)] = true,	-- Quaking Palm
}

T.DebuffBlackList = {
	-- [SpellName(spellID)] = true,	-- Spell Name
}

T.PlateBlacklist = {
	-- Army of the Dead
	["Army of the Dead"] = true,
	["Войско мертвых"] = true,
	-- Wild Imp
	["Wild Imp"] = true,
	["Дикий бес"] = true,
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
}