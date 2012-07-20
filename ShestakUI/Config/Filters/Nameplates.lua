local T, C, L = unpack(select(2, ...))
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Polymorph -> http://www.wowhead.com/spell=118
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = select(1, GetSpellInfo(id))
	return name
end

-- Nameplates use these
T.DebuffWhiteList = {
	-- Death Knight
	--MOP[SpellName(49203)] = true,	-- Hungering Cold
	[SpellName(47476)] = true,	-- Strangulate
	[SpellName(108194)] = true,	-- Asphyxiate
	-- Druid
	[SpellName(33786)] = true,	-- Cyclone
	[SpellName(2637)] = true,	-- Hibernate
	[SpellName(339)] = true,	-- Entangling Roots
	[SpellName(80964)] = true,	-- Skull Bash
	[SpellName(78675)] = true,	-- Solar Beam
	[SpellName(8921)] = true,	-- Moonfire
	[SpellName(5570)] = true,	-- Insect Swarm
	[SpellName(93402)] = true,	-- Sunfire
	[SpellName(58180)] = true,	-- Infected Wounds
	[SpellName(33878)] = true,	-- Mangle
	[SpellName(33745)] = true,	-- Lacerate
	[SpellName(1822)] = true,	-- Rake
	[SpellName(1079)] = true,	-- Rip
	-- Hunter
	[SpellName(3355)] = true,	-- Freezing Trap Effect
	[SpellName(1513)] = true,	-- Scare Beast
	[SpellName(19503)] = true,	-- Scatter Shot
	[SpellName(34490)] = true,	-- Silencing Shot
	-- Mage
	[SpellName(31661)] = true,	-- Dragon's Breath
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(55021)] = true,	-- Improved Counterspell
	[SpellName(122)] = true,	-- Frost Nova
	--MOP[SpellName(55080)] = true,	-- Shattered Barrier
	-- Paladin
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(10326)] = true,	-- Turn Evil
	[SpellName(853)] = true,	-- Hammer of Justice
	[SpellName(105593)] = true,	-- Fist of Justice
	-- Priest
	[SpellName(605)] = true,	-- Mind Control
	[SpellName(64044)] = true,	-- Psychic Horror
	[SpellName(8122)] = true,	-- Psychic Scream
	[SpellName(9484)] = true,	-- Shackle Undead
	[SpellName(15487)] = true,	-- Silence
	-- Rogue
	[SpellName(2094)] = true,	-- Blind
	[SpellName(1776)] = true,	-- Gouge
	[SpellName(6770)] = true,	-- Sap
	-- Shaman
	[SpellName(51514)] = true,	-- Hex
	[SpellName(3600)] = true,	-- Earthbind
	[SpellName(8056)] = true,	-- Frost Shock
	[SpellName(8050)] = true,	-- Flame Shock
	[SpellName(63685)] = true,	-- Freeze
	--MOP[SpellName(39796)] = true,	-- Stoneclaw Stun
	-- Warlock
	[SpellName(710)] = true,	-- Banish
	[SpellName(6789)] = true,	-- Mortal Coil
	[SpellName(5782)] = true,	-- Fear
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(6358)] = true,	-- Seduction
	[SpellName(30283)] = true,	-- Shadowfury
	--MOP[SpellName(89605)] = true,	-- Aura of Foreboding
	[SpellName(603)] = true,	-- Doom
	[SpellName(980)] = true,	-- Agony
	[SpellName(172)] = true,	-- Corruption
	--MOP[SpellName(17800)] = true,	-- Shadow and Flame
	[SpellName(48181)] = true,	-- Haunt
	[SpellName(30108)] = true,	-- Unstable Affliction
	[SpellName(348)] = true,	-- Immolate
	--MOP[SpellName(86000)] = true,	-- Curse of Gul'dan
	-- Warrior
	[SpellName(20511)] = true,	-- Intimidating Shout
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
}