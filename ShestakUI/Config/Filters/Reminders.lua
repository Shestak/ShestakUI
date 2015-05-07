local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Flask of the Earth -> http://www.wowhead.com/spell=105694
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.reminder.raid_buffs_enable == true then
	T.ReminderBuffs = {
		[1] = {1, 144053},	-- RAID_BUFF_1 Stats, 试炼场属性buff
		[2] = {2, 144051},	-- RAID_BUFF_2 Stamina, 试炼场耐力buff
		[3] = {4, 144046},	-- RAID_BUFF_4 Haste, 试炼场急速buff
		[4] = {6, 144047},	-- RAID_BUFF_6 Critical Strike, 试炼场暴击buff
		[5] = {7, 144048},	-- RAID_BUFF_7 Mastery, 试炼场精通buff
		[6] = {8, 175651},	-- RAID_BUFF_8 Multistrike, 试炼场溅射buff
		[7] = {9, 175649},	-- RAID_BUFF_9 Versatility, 试炼场全能buff
		[8] = {3, 144041},	-- RAID_BUFF_3 Attack Power, 试炼场攻强buff
		[9] = {5, 144042},	-- RAID_BUFF_5 Spell Power, 试炼场法强buff
		[10] = {	--Flask
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
		[11] = {	--Food
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
		[12] = {	--for WOD Rune
			175457, -- Focus Augment Rune
			175456, -- Stout Augment Rune
			175439, -- Hyper Augment Rune
		},
		[13] = 5512, -- 治疗石
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
