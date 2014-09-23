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
			--WoD 117666,	-- Legacy of the Emperor
			90363,	-- Embrace of the Shale Spider
			1126,	-- Mark of the Wild
		},
		Stamina = {
			109773,	-- Dark Intent
			469,	-- Commanding Shout
			90364,	-- Qiraji Fortitude
			111922,	-- Runescroll of Fortitude III
			21562,	-- Power Word: Fortitude
		}
	}

	-- Caster buffs
	function T.ReminderCasterBuffs()
		Spell5Buff = {	-- Spell Power
			--WoD 77747,	-- Burning Wrath
			109773,	-- Dark Intent
			126309,	-- Still Water
			61316,	-- Dalaran Brilliance
			1459,	-- Arcane Brilliance
		}
		Spell6Buff = {	-- Spell Haste
			24907,	-- Moonkin Aura
			49868,	-- Mind Quickening
			135678,	-- Energizing Spores
			--WoD 51470,	-- Elemental Oath
		}
	end

	-- Physical buffs
	function T.ReminderPhysicalBuffs()
		Spell5Buff = {	-- Attack Power
			6673,	-- Battle Shout
			19506,	-- Trueshot Aura
			57330,	-- Horn of Winter
		}
		Spell6Buff = {	-- Melee and Ranged Haste
			--WoD 30809,	-- Unleashed Rage
			113742,	-- Swiftblade's Cunning
			128432,	-- Cackling Howl
			128433,	-- Serpent's Swiftness
			55610,	-- Unholy Aura
		}
	end
end

----------------------------------------------------------------------------------------
--[[------------------------------------------------------------------------------------
	Spell Reminder Arguments

	Type of Check:
		spells - List of spells in a group, if you have anyone of these spells the icon will hide.
		weapon - Run a weapon enchant check instead of a spell check

	Spells only Requirements:
		negate_spells - List of spells in a group, if you have anyone of these spells the icon will immediately hide and stop running the spell check (these should be other peoples spells)
		reversecheck - only works if you provide a role or a spec, instead of hiding the frame when you have the buff, it shows the frame when you have the buff, doesn't work with weapons
		negate_reversecheck - if reversecheck is set you can set a spec to not follow the reverse check, doesn't work with weapons

	Requirements: (These work for both spell and weapon checks)
		role - you must be a certain role for it to display (Tank, Melee, Caster)
		spec - you must be active in a specific spec for it to display (1, 2, 3) note: spec order can be viewed from top to bottom when you open your talent pane
		level - the minimum level you must be (most of the time we don't need to use this because it will register the spell learned event if you don't know the spell, but in the case of weapon enchants this is useful)
		personal - aura must come from the player

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
				["negate_spells"] = {
					20217,	-- Blessing of Kings
					--WoD 117666,	-- Legacy of the Emperor
					90363,	-- Embrace of the Shale Spider
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		HUNTER = {
			[1] = {	-- Aspects group
				["spells"] = {
					--WoD 13165,	-- Aspect of the Hawk
					109260,	-- Aspect of the Iron Hawk
				},
				["instance"] = true,
				["personal"] = true,
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
					--WoD 117666,	-- Legacy of the Emperor
				},
				["negate_spells"] = {
					1126,	-- Mark of the Wild
					20217,	-- Blessing of Kings
					90363,	-- Embrace of the Shale Spider
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
					1459,	-- Arcane Brilliance
					61316,	-- Dalaran Brilliance
					24932,	-- Leader of the Pack
					90309,	-- Terrifying Roar
					24604,	-- Furious Howl
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
					--WoD 117666,	-- Legacy of the Emperor
					90363,	-- Embrace of the Shale Spider
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
					127830,	-- Spirit Beast Blessing
					20217,	-- Blessing of Kings
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		--WoD PRIEST = {
			-- [1] = {	-- Inner Fire/Will group
				-- ["spells"] = {
					-- 588,	-- Inner Fire
					-- 73413,	-- Inner Will
				-- },
				-- ["combat"] = true,
				-- ["instance"] = true,
				-- ["pvp"] = true
			-- },
		-- },
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
					--WoD 5761,	-- Mind-numbing Poison
				-- WoD	3408,	-- Crippling Poison
					108211,	-- Leeching Poison
					--WoD 108215,	-- Paralytic Poison
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
			--WoD [2] = {	-- Weapons enchants group
				-- ["weapon"] = true,
				-- ["combat"] = true,
				-- ["instance"] = true,
				-- ["pvp"] = true,
				-- ["level"] = 10,
			-- },
		},
		WARLOCK = {
			[1] = {	-- Dark Intent group
				["spells"] = {
					109773,	-- Dark Intent
				},
				["negate_spells"] = {
					1459,	-- Arcane Brilliance
					61316,	-- Dalaran Brilliance
					--WoD 77747,	-- Burning Wrath
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
					109773,	-- Dark Intent
					90364,	-- Qiraji Fortitude
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
					469,	-- Commanding Shout
				},
				["combat"] = true,
				["role"] = "Melee",
			},
		},
	}
end