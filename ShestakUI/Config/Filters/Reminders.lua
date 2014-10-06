local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Flask of the Earth -> http://www.wowhead.com/spell=105694
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.reminder.raid_buffs_enable == true then
	-- General buffs
	T.ReminderBuffs = {
		Flask = {
			105691,	-- Flask of the Warm Sun
			105696,	-- Flask of Winter's Bite
			105693,	-- Flask of Falling Leaves
			105689,	-- Flask of Spring Blossoms
			105694,	-- Flask of the Earth
		},
		BattleElixir = {
			105688,	-- Monk's Elixir
			105685,	-- Elixir of Peace
			105682,	-- Mad Hozen Elixir
			105683,	-- Elixir of Weaponry
			105684,	-- Elixir of the Rapids
			105686,	-- Elixir of Perfection
		},
		GuardianElixir = {
			105681,	-- Mantid Elixir
			105687,	-- Elixir of Mirrors
		},
		Food = {
			104280,	-- Well Fed
		},
		Stat = {
			20217,	-- Blessing of Kings
			115921,	-- Legacy of the Emperor
			116781,	-- Legacy of the White Tiger
			90363,	-- Embrace of the Shale Spider
			1126,	-- Mark of the Wild
		},
		Stamina = {
			469,	-- Commanding Shout
			90364,	-- Qiraji Fortitude
			111922,	-- Runescroll of Fortitude III
			21562,	-- Power Word: Fortitude
		}
	}

	-- Caster buffs
	function T.ReminderCasterBuffs()
		Spell5Buff = {	-- Spell Power
			109773,	-- Dark Intent
			126309,	-- Still Water
			128433,	-- Serpent's Swiftness
			61316,	-- Dalaran Brilliance
			1459,	-- Arcane Brilliance
		}
	end

	-- Physical buffs
	function T.ReminderPhysicalBuffs()
		Spell5Buff = {	-- Attack Power
			6673,	-- Battle Shout
			19506,	-- Trueshot Aura
			57330,	-- Horn of Winter
		}
	end

	Spell6Buff = {	-- Haste
		49868,	-- Mind Quickening
		135678,	-- Energizing Spores
		113742,	-- Swiftblade's Cunning
		128432,	-- Cackling Howl
		55610,	-- Unholy Aura
		116956,	-- Grace of Air
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
		level - the minimum level you must be (most of the time we don't need to use this because it will register the spell learned event if you don't know the spell, but in the case of weapon enchants this is useful)

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
					20217,	-- Blessing of Kings
					90363,	-- Embrace of the Shale Spider
					116781,	-- Legacy of the White Tiger
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
					90363,	-- Embrace of the Shale Spider
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
					115921,	-- Legacy of the Emperor
					116781,	-- Legacy of the White Tiger
					90363,	-- Embrace of the Shale Spider
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
					116956,	-- Grace of Air
					93435,	-- Roar of Courage
					128997,	-- Spirit Beast Blessing
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
					469,	-- Commanding Shout
					90364,	-- Qiraji Fortitude
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
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	--  Non-Lethal Poisons group
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
					21562,	-- Power Word: Fortitude
					90364,	-- Qiraji Fortitude
				},
				["personal"] = {
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
					19506,	-- Trueshot Aura
					57330,	-- Horn of Winter
				},
				["personal"] = {
					469,	-- Commanding Shout
				},
				["combat"] = true,
				["role"] = "Melee",
			},
		},
	}
end