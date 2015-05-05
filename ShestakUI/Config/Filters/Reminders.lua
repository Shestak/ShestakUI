local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Flask of the Earth -> http://www.wowhead.com/spell=105694
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.reminder.raid_buffs_enable == true then
	-- General buffs
	T.ReminderBuffs = {
		[1] = {	--Flask
			176151,
			156071,	-- Draenic Strength Flask
			156077,	-- Draenic Stamina Flask
			156070,	-- Draenic Intellect Flask
			156073,	-- Draenic Agility Flask
			156080,	-- Greater Draenic Strength Flask
			156064,	-- Greater Draenic Agility Flask
			156084,	-- Greater Draenic Stamina Flask
			156079,	-- Greater Draenic Intellect Flask
			105694,	-- Flask of the Earth
			105691,	-- Flask of the Warm Sun
			105696,	-- Flask of Winter's Bite
			105693,	-- Flask of Falling Leaves
			105689,	-- Flask of Spring Blossoms
		},
		[2] = {	--Food
			104273, --250 Agility
			104274, --275 Agility
			104275, --300 Agility

			104267, -- 250 Strength
			104271, -- 275 Strength
			104272, -- 300 Strength

			104264, -- 250 Intellect
			104276, -- 275 Intellect
			104277, -- 300 Intellect

			104277, -- 250 Spirit
			104279, -- 275 Spirit
			104280, -- 300 Spirit

			104281, -- 375 Stamina
			104282, -- 415 Stamina
			104283, -- 450 Stamina
		},
		[3] = {	--Stat
			144053,	-- 试炼场
			1126,	-- Mark of the Wild
			159988,	-- Bark of the Wild (Dog)
			160017,	-- Blessing of Kongs (Gorilla)
			90363,	-- Embrace of the Shale Spider
			160077,	-- Strength of the Earth (Worm)
			115921,	-- Legacy of the Emperor
			116781,	-- Legacy of the White Tiger
			20217,	-- Blessing of Kings
			72586, -- 遗忘王者祝福：4%属性
			160206, -- 孤狼：巨猿之力
		},
		[4] = {	--Stamina
			144051,	-- 试炼场
			21562,	-- Power Word: Fortitude
			90364,	-- Qiraji Fortitude (Silithid)
			160003,	-- Savage Vigor (Rylak)
			160014,	-- Sturdiness (Goat)
			166928,	-- Blood Pact
			469,	-- Commanding Shout
			111922,	-- Runescroll of Fortitude III
			160199, -- 孤狼：巨熊之韧
		},
		[5] = {	--Crit
			144047,	-- 试炼场
			24932, -- 野德兽群领袖
			116781, -- 武僧白虎传承
			1459, -- 奥术光辉
			61316, -- 达拉然光辉
			126309, -- 水黾：净水
			24604, -- 狼：狂怒之嚎
			90309, -- 魔暴龙：惊人咆哮
			126373, -- 魁麟：无畏之嚎
			90363, -- 页岩蛛：页岩蛛之拥
			160052, -- 迅猛龙：兽群之力
			160200, -- 孤狼：迅猛龙之恶
		},
		[6] = {     -- Mastery 5%精通
			144048,	-- 试炼场
			 19740, -- 圣骑力量祝福
			155522, -- DKT幽冥之力
			 24907, -- 鸟德枭兽形态
			116956, -- 萨满风之优雅
			 93435, -- 豹：勇气咆哮
			128997, -- 灵魂兽：灵魂兽祝福
			160039, -- 九头蛇：敏锐感知
			160073, -- 陆行鸟：如履平地
			160198, -- 孤狼：猫之优雅
		},
		[7] = {     --Multistrike 5%溅射
			175651,	-- 试炼场
			166916,	-- 踏风风怒
			109773,	-- 术士黑暗意图
			113742, -- 盗贼迅刃之黠
			 49868, -- 暗牧思维加速
			159733, -- 蜥蜴：邪恶凝视
			 54644, -- 奇美拉：冰息
			 58604, -- 熔岩犬：双重撕咬
			 34889, -- 龙鹰：迅捷打击
			160011, -- 狐狸：灵敏反应
			 57386, -- 犀牛：狂野之力
			 24844, -- 风蛇：狂风呼啸
			172968, -- 孤狼：龙鹰之速
		},
		[8] = {     --Versatility 3%全能
			175649,	-- 试炼场
			167187, -- 惩戒圣洁光环
			 55610, -- DK邪恶光环
			  1126, -- 德鲁伊野性印记
			167188, -- 战士振奋风采
			159735, -- 猛禽：坚韧
			 35290, -- 野猪：不屈
			160045, -- 刺猬：防御鬃毛
			 50518, -- 掠夺者：角质护甲
			 57386, -- 犀牛：狂野之力
			160077, -- 虫：大地之力
			172967, -- 孤狼：掠食者之力
		},
		[9] = {     --Haste 5%急速
			144046,	-- 试炼场
			113742, -- 盗贼迅刃之黠
			 49868, -- 暗牧思维加速
			 55610, -- DK邪恶光环
			116956, -- 萨满风之优雅
			160003, -- 双头飞龙：野性活力
			128432, -- 土狼：厉声嚎叫
			135678, -- 孢子蝠：充能孢子
			160074, -- 蜂：虫群疾速
			160203, -- 孤狼：土狼之速
		},
		[10] = {	-- Attack Power
			144041,	-- 试炼场
			57330,	-- Horn of Winter
			19506,	-- Trueshot Aura
			6673,	-- Battle Shout
		},
		[11] = {	-- Spell Power
			144042, -- 试炼场
			1459,	-- Arcane Brilliance
			61316,	-- Dalaran Brilliance
			126309,	-- Still Water (Water Strider)
			128433,	-- Serpent's Cunning (Serpent)
			90364,	-- Qiraji Fortitude (Silithid)
			160205, -- 孤狼：神龙之智
			109773,	-- Dark Intent
		},
		[12] = {    -- 治疗石
		  5512, -- 治疗石
		},
		[13] = {	--for WOD Rune
			175457, -- Focus Augment Rune
			175456, -- Stout Augment Rune
			175439, -- Hyper Augment Rune
		},
	}
end

----------------------------------------------------------------------------------------
--[[------------------------------------------------------------------------------------
	Spell Reminder Arguments

	Type of Check:
		spells - List of spells in a group, if you have anyone of these spells the icon will hide.

	Spells only Requirements:
		negate_spells - List of spells in a group, if you have anyone of these spells the icon will immediately hide and stop running the spell check (these should be other peoples spells)
		personal - like a negate_spells but only for your spells
		reversecheck - only works if you provide a role or a spec, instead of hiding the frame when you have the buff, it shows the frame when you have the buff
		negate_reversecheck - if reversecheck is set you can set a spec to not follow the reverse check

	Requirements:
		role - you must be a certain role for it to display (Tank, Melee, Caster)
		spec - you must be active in a specific spec for it to display (1, 2, 3) note: spec order can be viewed from top to bottom when you open your talent pane
		level - the minimum level you must be (most of the time we don't need to use this because it will register the spell learned event if you don't know the spell, but in some cases it may be useful)

	Additional Checks: (Note we always run a check when gaining/losing an aura)
		instance - check when entering a party/raid instance
		pvp - check when entering a bg/arena
		combat - check when entering combat

	For every group created a new frame is created, it's a lot easier this way.
]]--------------------------------------------------------------------------------------
if C.reminder.solo_buffs_enable == true then
	T.ReminderSelfBuffs = {
		DEATHKNIGHT = {
			[1] = {	-- Horn of Winter group
				["spells"] = {
					57330,	-- Horn of Winter
				},
				["negate_spells"] = {
					6673,	-- Battle Shout
					19506,	-- Trueshot Aura
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Blood Presence group
				["spells"] = {
					48263,	-- Blood Presence
				},
				["role"] = "Tank",
				["instance"] = true,
				["reversecheck"] = true,
			},
		},
		DRUID = {
			[1] = {	-- Mark of the Wild group
				["spells"] = {
					1126,	-- Mark of the Wild
				},
				["negate_spells"] = {
					159988,	-- Bark of the Wild (Dog)
					160017,	-- Blessing of Kongs (Gorilla)
					90363,	-- Embrace of the Shale Spider
					160077,	-- Strength of the Earth (Worm)
					115921,	-- Legacy of the Emperor
					116781,	-- Legacy of the White Tiger
					20217,	-- Blessing of Kings
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		MAGE = {
			[1] = {	-- Brilliance group
				["spells"] = {
					1459,	-- Arcane Brilliance
					61316,	-- Dalaran Brilliance
				},
				["negate_spells"] = {
					126309,	-- Still Water (Water Strider)
					128433,	-- Serpent's Cunning (Serpent)
					90364,	-- Qiraji Fortitude (Silithid)
					109773,	-- Dark Intent
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		MONK = {
			[1] = {	-- Legacy of the Emperor group
				["spells"] = {
					115921,	-- Legacy of the Emperor
				},
				["negate_spells"] = {
					1126,	-- Mark of the Wild
					159988,	-- Bark of the Wild (Dog)
					160017,	-- Blessing of Kongs (Gorilla)
					90363,	-- Embrace of the Shale Spider
					160077,	-- Strength of the Earth (Worm)
					116781,	-- Legacy of the White Tiger
					20217,	-- Blessing of Kings
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Legacy of the White Tiger group
				["spells"] = {
					116781,	-- Legacy of the White Tiger
				},
				["negate_spells"] = {
					91126,	-- Mark of the Wild
					159988,	-- Bark of the Wild (Dog)
					160017,	-- Blessing of Kongs (Gorilla)
					90363,	-- Embrace of the Shale Spider
					160077,	-- Strength of the Earth (Worm)
					115921,	-- Legacy of the Emperor
					20217,	-- Blessing of Kings
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		PALADIN = {
			[1] = {	-- Righteous Fury group
				["spells"] = {
					25780,	-- Righteous Fury
				},
				["role"] = "Tank",
				["instance"] = true,
				["reversecheck"] = true,
				["negate_reversecheck"] = 1,	-- Holy paladins use RF sometimes
			},
			[2] = {	-- Blessing of Kings group
				["spells"] = {
					20217,	-- Blessing of Kings
				},
				["negate_spells"] = {
					1126,	-- Mark of the Wild
					160017,	-- Blessing of Kongs (Gorilla)
					90363,	-- Embrace of the Shale Spider
					160077,	-- Strength of the Earth (Worm)
					115921,	-- Legacy of the Emperor
					116781,	-- Legacy of the White Tiger
				},
				["personal"] = {
					19740,	-- Blessing of Might
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[3] = {	-- Blessing of Might group
				["spells"] = {
					19740,	-- Blessing of Might
				},
				["negate_spells"] = {
					155522,	-- Power of the Grave
					24907,	-- Moonkin Aura
					93435,	-- Roar of Courage (Cat)
					160039,	-- Keen Senses (Hydra)
					160073,	-- Plainswalking (Tallstrider)
					128997,	-- Spirit Beast Blessing
					116956,	-- Grace of Air
				},
				["personal"] = {
					20217,	-- Blessing of Kings
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		PRIEST = {
			[1] = {	-- Stamina group
				["spells"] = {
					21562,	-- Power Word: Fortitude
				},
				["negate_spells"] = {
					90364,	-- Qiraji Fortitude (Silithid)
					160003,	-- Savage Vigor (Rylak)
					160014,	-- Sturdiness (Goat)
					166928,	-- Blood Pact
					469,	-- Commanding Shout
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true
			},
		},
		ROGUE = {
			[1] = {	-- Lethal Poisons group
				["spells"] = {
					2823,	-- Deadly Poison
					8679,	-- Wound Poison
					157584,	-- Instant Poison
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Non-Lethal Poisons group
				["spells"] = {
					3408,	-- Crippling Poison
					108211,	-- Leeching Poison
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		SHAMAN = {
			[1] = {	-- Shields group
				["spells"] = {
					52127,	-- Water Shield
					324,	-- Lightning Shield
					974,	-- Earth Shield
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		WARLOCK = {
			[1] = {	-- Dark Intent group
				["spells"] = {
					109773,	-- Dark Intent
				},
				["negate_spells"] = {
					1459,	-- Arcane Brilliance
					61316,	-- Dalaran Brilliance
					126309,	-- Still Water (Water Strider)
					128433,	-- Serpent's Cunning (Serpent)
					90364,	-- Qiraji Fortitude (Silithid)
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		WARRIOR = {
			[1] = {	-- Commanding Shout group
				["spells"] = {
					469,	-- Commanding Shout
				},
				["negate_spells"] = {
					90364,	-- Qiraji Fortitude (Silithid)
					160003,	-- Savage Vigor (Rylak)
					160014,	-- Sturdiness (Goat)
					21562,	-- Power Word: Fortitude
					166928,	-- Blood Pact
				},
				["personal"] = {
					6673,	-- Battle Shout
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Battle Shout group
				["spells"] = {
					6673,	-- Battle Shout
				},
				["negate_spells"] = {
					19506,	-- Trueshot Aura
					57330,	-- Horn of Winter
				},
				["personal"] = {
					469,	-- Commanding Shout
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
	}
end
