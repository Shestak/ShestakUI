local T, C, L = unpack(select(2, ...))
if C.nameplate.enable ~= true then return end

local function SpellName(id)
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id)
	return name
end

-- Nameplates use these
T.DebuffWhiteList = {
	-- Death Knight
	[SpellName(51209)] = true,	-- Hungering cold
	[SpellName(47476)] = true,	-- Atrangulate
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
	[SpellName(61305)] = true,	-- Polymorph
	[SpellName(18469)] = true,	-- Silenced - Improved Counterspell
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(55080)] = true,	-- Shattered Barrier
	-- Paladin
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(10326)] = true,	-- Turn Evil
	[SpellName(853)] = true,	-- Hammer of Justice
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
	[SpellName(18425)] = true,	-- Silenced - Improved Kick
	-- Shaman
	[SpellName(51514)] = true,	-- Hex
	[SpellName(3600)] = true,	-- Earthbind
	[SpellName(8056)] = true,	-- Frost Shock
	[SpellName(63685)] = true,	-- Freeze
	[SpellName(39796)] = true,	-- Stoneclaw Stun
	-- Warlock
	[SpellName(710)] = true,	-- Banish
	[SpellName(6789)] = true,	-- Death Coil
	[SpellName(5782)] = true,	-- Fear
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(6358)] = true,	-- Seduction
	[SpellName(30283)] = true,	-- Shadowfury
	[SpellName(89605)] = true,	-- Aura of Foreboding
	[SpellName(603)] = true,	-- Bane of Doom
	[SpellName(980)] = true,	-- Bane of Agony
	[SpellName(172)] = true,	-- Corruption
	[SpellName(17800)] = true,	-- Shadow and Flame
	[SpellName(48181)] = true,	-- Haunt
	[SpellName(30108)] = true,	-- Unstable Affliction
	[SpellName(348)] = true,	-- Immolate
	[SpellName(86000)] = true,	-- Curse of Gul'dan
	-- Warrior
	[SpellName(20511)] = true,	-- Intimidating Shout
	-- Racial
	[SpellName(25046)] = true,	-- Arcane Torrent
	[SpellName(20549)] = true,	-- War Stomp
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
}