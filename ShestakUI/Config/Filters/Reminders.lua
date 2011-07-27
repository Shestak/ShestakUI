local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.reminder.raid_buffs_enable == true then
	T.ReminderRaidBuffs = {
		Flask = {
			79471,	-- Flask of the Winds
			79637,	-- Flask of Enhancement
			92679,	-- Flask of Battle
			79469,	-- Flask of Steelskin
			79470,	-- Flask of the Draconic Mind
			79472,	-- Flask of Titanic Strength
			94160,	-- Flask of Flowing Water
		},
		BattleElixir = {
			-- Scrolls
			89343,	-- Scroll of Agility IX
			89344,	-- Scroll of Protection IX
			89347,	-- Scroll of Intellect IX
			89342,	-- Scroll of Spirit IX
			89345,	-- Scroll of Stamina IX
			89346,	-- Scroll of Strength IX
			-- Elixirs
			79635,	-- Elixir of the Master
			79632,	-- Elixir of Mighty Speed
			79481,	-- Elixir of Impossible Accuracy
			79477,	-- Elixir of the Cobra
			79474,	-- Elixir of the Naga
			79468,	-- Ghost Elixir
		},
		GuardianElixir = {
			79631,	-- Prismatic Elixir
			79480,	-- Elixir of Deep Earth
		},
		Food = {
			87635,	-- Crocolisk Au Gratin
			87545,	-- Beer-Basted Crocolisk
			87546,	-- Skewered Eel
			87547,	-- Severed Sagefish Head
			87548,	-- Delicious Sagefish Tail
			87549,	-- Lavascale Minestrone
			87550,	-- Grilled Dragon
			87551,	-- Baked Rockfish
			87552,	-- Basilisk Liverdog
			87554,	-- Mushroom Sauce Mudfish
			87555,	-- Blackbelly Sushi
			87556,	-- Hearty Seafood Soup
			87634,	-- Lavascale Fillet
			87564,	-- Lurker Lunch
			87563,	-- Broiled Mountain Trout
			87562,	-- Lightly Fried Lurker
			87561,	-- Seasoned Crab
			87560,	-- Salted Eye
			87559,	-- Whitecrest Gumbo
			87558,	-- Pickled Guppy
			87557,	-- Tender Baked Turtle
		},
	}
end

----------------------------------------------------------------------------------------
--[[------------------------------------------------------------------------------------
	Spell Reminder Arguments
	
	Type of Check:
		spells - List of spells in a group, if you have anyone of these spells the icon will hide.
		weapon - Run a weapon enchant check instead of a spell check
	
	Spells only Requirements:
		negate_spells - List of spells in a group, if you have anyone of these spells the icon will immediately hide and stop running the spell check (these should be other peoples spells)
		reversecheck - only works if you provide a role or a tree, instead of hiding the frame when you have the buff, it shows the frame when you have the buff, doesn't work with weapons
		negate_reversecheck - if reversecheck is set you can set a talent tree to not follow the reverse check, doesn't work with weapons
	
	Requirements: (These work for both spell and weapon checks)
		role - you must be a certain role for it to display (Tank, Melee, Caster)
		tree - you must be active in a specific talent tree for it to display (1, 2, 3) note: tree order can be viewed from left to right when you open your talent pane
		level - the minimum level you must be (most of the time we don't need to use this because it will register the spell learned event if you don't know the spell, but in the case of weapon enchants this is useful)
		personal - aura must come from the player
		
	Additional Checks: (Note we always run a check when gaining/losing an aura)
		instance - check when entering a party/raid instance
		pvp - check when entering a bg/arena
		combat - check when entering combat
	
	For every group created a new frame is created, it's a lot easier this way.
]]-------------------------------------------------------------------------------------
if C.reminder.solo_buffs_enable == true then
	T.ReminderSelfBuffs = {
		PRIEST = {
			[1] = {	-- Inner Fire/Will group
				["spells"] = {
					588,	-- Inner Fire
					73413,	-- Inner Will
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true
			},
		},
		HUNTER = {
			[1] = {	-- Aspects group
				["spells"] = {
					13165,	-- Aspect of the Hawk
					20043,	-- Aspect of the Wild
					82661,	-- Aspect of the Fox
				},
				["instance"] = true,
				["personal"] = true,
			},
		},
		MAGE = {
			[1] = {	-- Armors group
				["spells"] = {
					30482,	-- Molten Armor
					7302,	-- Frost Armor
					6117,	-- Mage Armor
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Intellect group
				["spells"] = {
					1459,	-- Arcane Brilliance
					61316,	-- Dalaran Brilliance
				},
				["combat"] = true,
				["instance"] = true,
				["level"] = 58,
			},
		},
		WARLOCK = {
			[1] = {	-- Armors group
				["spells"] = {
					28176,	-- Fel Armor
					687,	-- Demon Armor
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = { -- Buffs group
				["spells"] = {
					85768,	-- Dark Intent
				},
				["instance"] = true,
				["level"] = 83,
			},
		},
		PALADIN = {
			[1] = {	-- Seals group
				["spells"] = {
					31801,	-- Seal of Truth
					20154,	-- Seal of Righteousness
					85126,	-- Seal of Command
					20164,	-- Seal of Justice
					20165,	-- Seal of Insight
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Righteous Fury group
				["spells"] = {
					25780,	-- Righteous Fury
				},
				["role"] = "Tank",
				["instance"] = true,
				["reversecheck"] = true,
				["negate_reversecheck"] = 1,	-- Holy paladins use RF sometimes
			},
			[3] = {	-- Auras group
				["spells"] = {
					465,	-- Devotion Aura
					7294,	-- Retribution Aura
					19746,	-- Concentration Aura
					19891,	-- Resistance Aura
				},
				["instance"] = true,
				["personal"] = true,
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
			[2] = {	-- Weapons enchants group
				["weapon"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				["level"] = 10,
			},
		},
		WARRIOR = {
			[1] = {	-- Commanding Shout group
				["spells"] = {
					469,	-- Commanding Shout
				},
				["negate_spells"] = {
					6307,	-- Blood Pact
					90364,	-- Qiraji Fortitude
					72590,	-- Drums of Fortitude
					21562,	-- Fortitude
					6673,	-- Battle Shout
				},
				["combat"] = true,
				["role"] = "Tank",
			},
			[2] = {	-- Battle Shout group
				["spells"] = {
					6673,	-- Battle Shout
				},
				["negate_spells"] = {
					8076,	-- Strength of Earth
					57330,	-- Horn of Winter
					93435,	-- Roar of Courage(hunter pet)
					469,	-- Commanding Shout
				},
				["combat"] = true,
				["role"] = "Melee",
			},
		},
		DEATHKNIGHT = {
			[1] = {	-- Horn of Winter group
				["spells"] = {
					57330,	-- Horn of Winter
				},
				["negate_spells"] = {
					8076,	-- Strength of Earth
					6673,	-- Battle Shout
					93435,	-- Roar of Courage(hunter pet)
				},
				["combat"] = true,
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
		ROGUE = { 
			[1] = {	-- Weapons enchants group
				["weapon"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				["level"] = 10,
			},
		},
		DRUID = {
			[1] = {	-- Horn of Winter group
				["spells"] = {
					1126,	-- Mark of the Wild
				},
				["negate_spells"] = {
					20217,	-- Blessing of Kings
				},
				["combat"] = true,
			},
		},
	}
end