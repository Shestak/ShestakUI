local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.nameplate.enable ~= true then return end

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
	[SpellName(194279)] = true,	-- Caltrops
	[SpellName(13812)] = true,	-- Explosive Trap
	-- Mage
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(31661)] = true,	-- Dragon's Breath
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(44457)] = true,	-- Living Bomb
	[SpellName(114923)] = true,	-- Nether Tempest
	[SpellName(120)] = true,	-- Cone of Cold
	-- Monk
	[SpellName(115078)] = true,	-- Paralysis
	-- Paladin
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(853)] = true,	-- Hammer of Justice
	[SpellName(183218)] = true,	-- Hand of Hindrance
	-- Priest
	[SpellName(204213)] = true,	-- Purge the Wicked
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
	[SpellName(197209)] = true,	-- Lightning Rod
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
	[SpellName(20549)] = true,	-- War Stomp (Tauren)
	[SpellName(107079)] = true,	-- Quaking Palm (Pandaren)
}

T.DebuffBlackList = {
	-- [SpellName(spellID)] = true,	-- Spell Name
}

T.BuffWhiteList = {
	-- Demon Hunter
	[SpellName(203819)] = true,	-- Demon Spikes
	[SpellName(187827)] = true,	-- Metamorphosis (Vengeance)
	[SpellName(212800)] = true,	-- Blur
	[SpellName(196555)] = true,	-- Netherwalk
	[SpellName(209426)] = true,	-- Darkness
	-- Druid
	[SpellName(22842)] = true,	-- Frenzied Regeneration
	[SpellName(192081)] = true,	-- Ironfur
	[SpellName(61336)] = true,	-- Survival Instincts
	[SpellName(22812)] = true,	-- Barkskin
	[SpellName(213680)] = true,	-- Guardian of Elune
	[SpellName(774)] = true,	-- Rejuvenation
	[SpellName(8936)] = true,	-- Regrowth
	[SpellName(33763)] = true,	-- Lifebloom
	[SpellName(188550)] = true,	-- Lifebloom (Hfc 4-Set Bonus)
	[SpellName(48438)] = true,	-- Wild Growth
	[SpellName(102342)] = true,	-- Ironbark
	[SpellName(155777)] = true,	-- Rejuvenation (Germination)
	[SpellName(102351)] = true,	-- Cenarion Ward
	[SpellName(102352)] = true,	-- Cenarion Ward Proc
	[SpellName(77761)] = true,	-- Stampeding Roar
	-- Hunter
	[SpellName(190931)] = true,	-- Mongoose Fury
	[SpellName(186257)] = true,	-- Aspect of the Cheetah
	[SpellName(186258)] = true,	-- Aspect of the Cheetah
	[SpellName(186289)] = true,	-- Aspect of the Eagle
	[SpellName(186265)] = true,	-- Aspect of the Turtle
	[SpellName(34477)] = true,	-- Misdirection
	-- Mage
	[SpellName(108839)] = true,	-- Ice Floes
	[SpellName(108843)] = true,	-- Blazing Speed
	[SpellName(116014)] = true,	-- Rune of Power
	[SpellName(116267)] = true,	-- Incanter's Flow
	[SpellName(198924)] = true,	-- Quickening
	[SpellName(205766)] = true,	-- Bone Chilling
	[SpellName(130)] = true,	-- Slow Fall
	-- Monk
	[SpellName(116680)] = true,	-- Thunder Focus Tea
	[SpellName(116847)] = true,	-- Rushing Jade Wind
	[SpellName(119085)] = true,	-- Chi Torpedo
	[SpellName(120954)] = true,	-- Fortifying Brew
	[SpellName(122278)] = true,	-- Dampen Harm
	[SpellName(122783)] = true,	-- Diffuse Magic
	[SpellName(196725)] = true,	-- Refreshing Jade Wind
	[SpellName(215479)] = true,	-- Ironskin Brew
	[SpellName(116841)] = true,	-- Tiger's Lust
	[SpellName(116844)] = true,	-- Ring of Peace
	[SpellName(116849)] = true,	-- Life Cocoon
	[SpellName(119611)] = true,	-- Renewing Mist
	[SpellName(124081)] = true,	-- Zen Sphere
	[SpellName(124682)] = true,	-- Enveloping Mist
	[SpellName(191840)] = true,	-- Essence Font
	-- Paladin
	[SpellName(184662)] = true,	-- Shield of Vengeance
	[SpellName(53563)] = true,	-- Beacon of Light
	[SpellName(156910)] = true,	-- Beacon of Faith
	[SpellName(6940)] = true,	-- Blessing of Sacrifice
	[SpellName(1044)] = true,	-- Blessing of Freedom
	[SpellName(1022)] = true,	-- Blessing of Protection
	-- Priest
	[SpellName(17)] = true,		-- Power Word: Shield
	[SpellName(81782)] = true,	-- Power Word: Barrier
	[SpellName(139)] = true,	-- Renew
	[SpellName(33206)] = true,	-- Pain Suppression
	[SpellName(41635)] = true,	-- Prayer of Mending
	[SpellName(47788)] = true,	-- Guardian Spirit
	[SpellName(114908)] = true,	-- Spirit Shell Shield
	[SpellName(152118)] = true,	-- Clarity of Will
	[SpellName(121557)] = true,	-- Angelic Feather
	[SpellName(65081)] = true,	-- Body and Soul
	[SpellName(214121)] = true,	-- Body and Mind
	[SpellName(77489)] = true,	-- Echo of Light
	[SpellName(64901)] = true,	-- Symbol of Hope
	[SpellName(194384)] = true,	-- Attonement
	-- Rogue
	[SpellName(5171)] = true,	-- Slice and Dice
	[SpellName(185311)] = true,	-- Crimson Vial
	[SpellName(193538)] = true,	-- Alacrity
	[SpellName(193356)] = true,	-- Broadsides
	[SpellName(199600)] = true,	-- Buried Treasure
	[SpellName(193358)] = true,	-- Grand Melee
	[SpellName(199603)] = true,	-- Jolly Roger
	[SpellName(193357)] = true,	-- Shark Infested Waters
	[SpellName(193359)] = true,	-- True Bearing
	-- Shaman
	[SpellName(61295)] = true,	-- Riptide
	-- Warlock
	[SpellName(5697)] = true,	-- Unending Breath
	[SpellName(20707)] = true,	-- Soulstone
	-- Warrior
	[SpellName(871)] = true,	-- Shield Wall
	[SpellName(1719)] = true,	-- Battle Cry
	[SpellName(12975)] = true,	-- Last Stand
	[SpellName(18499)] = true,	-- Berserker Rage
	[SpellName(23920)] = true,	-- Spell Reflection
	[SpellName(107574)] = true,	-- Avatar
	[SpellName(114030)] = true,	-- Vigilance
	[SpellName(132404)] = true,	-- Shield Block
	[SpellName(184362)] = true,	-- Enrage
	[SpellName(184364)] = true,	-- Enraged Regeneration
	[SpellName(190456)] = true,	-- Ignore Pain
	[SpellName(202539)] = true,	-- Frenzy
	[SpellName(202602)] = true,	-- Into the Fray
	[SpellName(206333)] = true,	-- Taste for Blood
	[SpellName(227744)] = true,	-- Ravager
}

T.BuffBlackList = {
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