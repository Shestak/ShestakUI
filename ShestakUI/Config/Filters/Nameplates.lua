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
	-- Harmful
	[SpellName(47476)] = true, -- Strangulate
	[SpellName(43265)] = true, -- death and decay
	[SpellName(55095)] = true, -- frost fever
	[SpellName(55078)] = true, -- blood plague
	[SpellName(194310)] = true, -- festering wound
	[SpellName(196782)] = true, -- outbreak
	[SpellName(130736)] = true, -- soul reaper
	[SpellName(191587)] = true, -- virulent plague
	-- Control
	[SpellName(56222)] = true, -- dark command
	[SpellName(45524)] = true, -- chains of ice
	[SpellName(108194)] = true, -- asphyxiate stun

	-- Demon Hunter
	-- Harmful
	[SpellName(207744)] = true, -- fiery brand
	[SpellName(207771)] = true, -- fiery brand 2
	[SpellName(204598)] = true, -- sigil of flame
	[SpellName(204490)] = true, -- sigil of silence
	[SpellName(207407)] = true, -- soul carver
	[SpellName(224509)] = true, -- frail
	[SpellName(206491)] = true, -- nemesis
	[SpellName(207690)] = true, -- bloodlet
	[SpellName(213405)] = true, -- master of the glaive snare
	-- Control
	[SpellName(185245)] = true, -- torment taunt
	[SpellName(204843)] = true, -- sigil of chains
	[SpellName(207685)] = true, -- sigil of misery
	[SpellName(179057)] = true, -- chaos nova
	[SpellName(211881)] = true, -- fel eruption
	[SpellName(200166)] = true, -- metamorphosis stun
	[SpellName(198813)] = true, -- vengeful retreat
	[SpellName(217932)] = true, -- imprison
	-- self
	[SpellName(218256)] = true, -- empower wards
    [SpellName(203819)] = true, -- demon spikes
    [SpellName(187827)] = true, -- metamorphosis (vengeance)
    [SpellName(212800)] = true, -- blur
    [SpellName(196555)] = true, -- net
    -- Helpful
    [SpellName(209426)] = true, -- darkness
    [SpellName(208628)] = true, -- darkness

	-- Druid
	-- Harmful
	[SpellName(164812)] = true,	-- Moonfire
	[SpellName(164815)] = true,	-- Sunfire
	[SpellName(58180)] = true,	-- Infected Wounds
	[SpellName(155722)] = true,	-- Rake
	[SpellName(1079)] = true,	-- Rip
	[SpellName(1822)] = true, -- rake
	[SpellName(8921)] = true, -- moonfire
	[SpellName(77758)] = true, -- bear thrash
	[SpellName(192090)] = true, -- bear thrash 7.0
	[SpellName(106830)] = true, -- cat thrash
	[SpellName(93402)] = true, -- sunfire
	[SpellName(202347)] = true, -- stellar flare
	-- Control
	[SpellName(339)] = true, -- entangling roots
	[SpellName(6795)] = true, -- growl
	[SpellName(22570)] = true, -- maim
	[SpellName(33786)] = true, -- cyclone
	[SpellName(78675)] = true, -- solar beam silence
	[SpellName(102359)] = true, -- mass entanglement
	[SpellName(99)] = true, -- disorienting roar
	[SpellName(5211)] = true, -- mighty bash
	[SpellName(61391)] = true, -- typhoon daze

	-- Hunter
	-- Harmful
	[SpellName(3355)] = true, -- Freezing Trap
	[SpellName(1130)] = true, -- hunter's arrow
	[SpellName(118253)] = true, -- serpent sting
	[SpellName(131894)] = true, -- murder by way of crow
	[SpellName(13812)] = true, -- explosive trap
	[SpellName(117405)] = true, -- binding shot
	[SpellName(187131)] = true, -- Vulnerable
	[SpellName(185855)] = true, -- lacerate
	-- Control
	[SpellName(5116)] = true, -- concussive shot
	[SpellName(20736)] = true, -- distracting shot
	[SpellName(24394)] = true, -- intimidation
	[SpellName(64803)] = true, -- entrapment
	[SpellName(3355)] = true, -- freezing trap
	[SpellName(135299)] = true, -- ice trap
	[SpellName(136634)] = true, -- narrow escape
	[SpellName(19386)] = true, -- wyvern sting
	[SpellName(117526)] = true, -- binding shot stun
	[SpellName(120761)] = true, -- glaive toss slow
	[SpellName(121414)] = true, -- glaive toss slow 2
	[SpellName(190927)] = true, -- harpoon root
	[SpellName(195645)] = true, -- wing clip

	-- Mage
	-- Harmful
	[SpellName(2120)] = true, -- flamestrike
	[SpellName(11366)] = true, -- pyroblast
	[SpellName(12654)] = true, -- ignite
	[SpellName(44457)] = true, -- living bomb
	[SpellName(112948)] = true, -- frost bomb
	[SpellName(114923)] = true, -- nether tempest
	[SpellName(157981)] = true, -- blast wave
	[SpellName(155158)] = true, -- meteor burn
	[SpellName(210134)] = true, -- erosion
	[SpellName(217694)] = true, -- living bomb
	[SpellName(226757)] = true, -- conflagration
	-- Control
	[SpellName(116)] = true, -- frostbolt debuff
	[SpellName(120)] = true, -- cone of cold
	[SpellName(122)] = true, -- frost nova
	[SpellName(31589)] = true, -- slow
	[SpellName(31661)] = true, -- dragon's breath
	[SpellName(82691)] = true, -- ring of frost
	[SpellName(157997)] = true, -- ice nova
	[SpellName(205708)] = true, -- chilled
	[SpellName(228354)] = true, -- flurry slow
	[SpellName(228600)] = true, -- glacial spike freeze
	-- Morphs
	[SpellName(118)] = true, -- polymorph
	[SpellName(28271)] = true, -- polymorph: turtle
	[SpellName(28272)] = true, -- polymorph: pig
	[SpellName(61305)] = true, -- polymorph: cat
	[SpellName(61721)] = true, -- polymorph: rabbit
	[SpellName(61780)] = true, -- polymorph: turkey
	[SpellName(126819)] = true, -- polymorph: pig
	[SpellName(161353)] = true, -- polymorph: bear cub
	[SpellName(161354)] = true, -- polymorph: monkey
	[SpellName(161355)] = true, -- polymorph: penguin
	[SpellName(161372)] = true, -- polymorph: turtle

	-- Monk
	-- Harmful
	[SpellName(123725)] = true, -- breath of fire dot
	[SpellName(138130)] = true, -- storm, earth and fire 1
	[SpellName(196608)] = true, -- eye of the tiger
	[SpellName(115804)] = true, -- mortal wounds
	[SpellName(115080)] = true, -- touch of death
	-- Control
	[SpellName(116095)] = true, -- disable
	[SpellName(115078)] = true, -- paralysis
	[SpellName(116189)] = true, -- provoke taunt
	[SpellName(119381)] = true, -- leg sweep
	[SpellName(120086)] = true, -- fists of fury stun
	[SpellName(121253)] = true, -- keg smash slow
	[SpellName(122470)] = true, -- touch of karma
	[SpellName(198909)] = true, -- song of chi-ji

	-- Paladin
	-- Harmful
	[SpellName(26573)] = true, -- consecration
	[SpellName(197277)] = true, -- judgement
	[SpellName(183218)] = true, -- hand of hindrance
	-- Control
	[SpellName(853)] = true, -- hammer of justice
	[SpellName(20066)] = true, -- repentance
	[SpellName(31935)] = true, -- avenger's shield silence
	[SpellName(62124)] = true, -- reckoning taunt
	[SpellName(105421)] = true, -- blinding light

	-- Priest
	-- Harmful
	[SpellName(2096)] = true, -- mind vision
	[SpellName(589)] = true, -- shadow word: pain
	[SpellName(14914)] = true, -- holy fire
	[SpellName(34914)] = true, -- vampiric touch
	[SpellName(129250)] = true, -- power word: solace
	[SpellName(155361)] = true, -- void entropy
	[SpellName(204213)] = true, -- purge the wicked
	[SpellName(214621)] = true, -- schism
	[SpellName(217673)] = true, -- mind spike
	-- Control
	[SpellName(15487)] = true,	-- Silence
	[SpellName(605)] = true, -- dominate mind
	[SpellName(8122)] = true, -- psychic scream
	[SpellName(64044)] = true, -- psychic horror
	[SpellName(88625)] = true, -- holy word: chastise
	[SpellName(200200)] = true, -- holy word: chastise
	[SpellName(9484)] = true, -- shackle undead
	[SpellName(114404)] = true, -- void tendril root
	[SpellName(204263)] = true, -- shining force

	-- Rogue
	-- Harmful
	[SpellName(703)] = true, -- garrote
	[SpellName(1943)] = true, -- rupture
	[SpellName(16511)] = true, -- hemorrhage
	[SpellName(79140)] = true, -- vendetta
	[SpellName(2818)] = true, -- deadly poison
	[SpellName(8680)] = true, -- wound poison
	[SpellName(137619)] = true, -- marked for death
	[SpellName(195452)] = true, -- nightblade
	[SpellName(192759)] = true, -- kingsbane
	[SpellName(196937)] = true, -- ghostly strike
	-- Control
	[SpellName(408)] = true, -- kidney shot
	[SpellName(1330)] = true, -- garrote silence
	[SpellName(1776)] = true, -- gouge
	[SpellName(1833)] = true, -- cheap shot
	[SpellName(2094)] = true, -- blind
	[SpellName(6770)] = true, -- sap
	[SpellName(26679)] = true, -- deadly throw
	[SpellName(88611)] = true, -- smoke bomb
	[SpellName(3409)] = true, -- crippling poison
	[SpellName(115196)] = true, -- debilitating poison
	[SpellName(197395)] = true, -- finality: nightblade (snare)
	[SpellName(185763)] = true, -- pistol shot snare
	[SpellName(185778)] = true, -- cannonball barrage snare
	[SpellName(199804)] = true, -- between the eyes stun
	[SpellName(199740)] = true, -- bribe
	[SpellName(199743)] = true, -- parley

	-- Shaman
	-- Harmful
	[SpellName(196840)] = true,	-- Frost Shock
	[SpellName(188389)] = true,	-- Flame Shock
	[SpellName(17364)] = true, -- stormstrike
	[SpellName(61882)] = true, -- earthquake
	-- Control
	[SpellName(3600)] = true, -- earthbind totem slow
	[SpellName(116947)] = true, -- earthbind totem slow again
	[SpellName(64695)] = true, -- earthgrab totem root
	[SpellName(51514)] = true, -- hex
	[SpellName(77505)] = true, -- earthquake stun
	[SpellName(51490)] = true, -- thunderstorm slow

	-- Warlock
	-- Harmful
	[SpellName(6789)] = true,	-- Mortal Coil
	[SpellName(6358)] = true,	-- Seduction
	[SpellName(980)] = true, -- agony
	[SpellName(603)] = true, -- doom
	[SpellName(172)] = true, -- corruption (demo version)
	[SpellName(146739)] = true, -- corruption
	[SpellName(348)] = true, -- immolate
	[SpellName(157736)] = true, -- immolate (green?)
	[SpellName(27243)] = true, -- immolate (green?)
	[SpellName(27243)] = true, -- seed of corruption
	[SpellName(30108)] = true, -- unstable affliction
	[SpellName(48181)] = true, -- haunt
	[SpellName(80240)] = true, -- havoc
	[SpellName(63106)] = true, -- siphon life
	-- Control
	[SpellName(710)] = true, -- banish
	[SpellName(1098)] = true, -- enslave demon
	[SpellName(5484)] = true, -- howl of terror
	[SpellName(5782)] = true, -- fear
	[SpellName(30283)] = true, -- shadowfury
	[SpellName(118699)] = true, -- fear (again)
	[SpellName(171018)] = true, -- meteor strike (abyssal stun)

	-- Warrior
	-- Harmful
	[SpellName(167105)] = true, -- colossus smash again
	[SpellName(1160)] = true, -- demoralizing shout
	[SpellName(772)] = true, -- rend
	[SpellName(115767)] = true, -- deep wounds
	[SpellName(113344)] = true, -- bloodbath debuff
	-- Control
	[SpellName(355)] = true, -- taunt
	[SpellName(1715)] = true, -- hamstring
	[SpellName(5246)] = true, -- intimidating shout
	[SpellName(7922)] = true, -- charge stun
	[SpellName(12323)] = true, -- piercing howl
	[SpellName(107566)] = true, -- staggering shout
	[SpellName(132168)] = true, -- shockwave stun
	[SpellName(132169)] = true, -- storm bolt stun

	-- Global
	-- Control
	[SpellName(28730)] = true, -- arcane torrent/s
	[SpellName(25046)] = true,
	[SpellName(50613)] = true,
	[SpellName(69179)] = true,
	[SpellName(80483)] = true,
	[SpellName(129597)] = true,
	[SpellName(155145)] = true,
	[SpellName(20549)] = true, -- war stomp
	[SpellName(107079)] = true, -- quaking palm
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