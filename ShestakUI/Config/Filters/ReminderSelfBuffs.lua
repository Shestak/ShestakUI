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
local T, C, L = unpack(select(2, ...))
if not C.reminder.solo_buffs_enable == true then return end

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