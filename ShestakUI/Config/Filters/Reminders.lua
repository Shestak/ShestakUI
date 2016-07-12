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
			127849,	-- Flask of the Countless Armies // Strenght
			127850,	-- Flask of Ten Thousand Scars // Stamina
			127847,	-- Flask of the Whispered Pact // Intellect
			127848,	-- Flask of the Seventh Demon // Agility
		},
		--BETA - Not any viable Battle/Guardian Elixir to replace Flask
		BattleElixir = {
			--105686,	-- Elixir of Perfection
			--105688,	-- Monk's Elixir
			--105685,	-- Elixir of Peace
			--105682,	-- Mad Hozen Elixir
			--105683,	-- Elixir of Weaponry
			--105684,	-- Elixir of the Rapids
		},
		GuardianElixir = {
			--105687,	-- Elixir of Mirrors
			--105681,	-- Mantid Elixir
		},
		Food = {
			104280,	-- Well Fed
		},
		Stat = {
			--BETA 1126,	-- Mark of the Wild
			--BETA 160206,	-- Lone Wolf: Power of the Primates
			--BETA 159988,	-- Bark of the Wild (Dog)
			--BETA 160017,	-- Blessing of Kongs (Gorilla)
			--BETA 90363,	-- Embrace of the Shale Spider
			--BETA 160077,	-- Strength of the Earth (Worm)
			--BETA 115921,	-- Legacy of the Emperor
			--BETA 116781,	-- Legacy of the White Tiger
			--BETA 20217,	-- Blessing of Kings
		},
		Stamina = {
			--BETA 21562,	-- Power Word: Fortitude
			--BETA 160199,	-- Lone Wolf: Fortitude of the Bear
			--BETA 50256,	-- Invigorating Roar (Bear)
			--BETA 90364,	-- Qiraji Fortitude (Silithid)
			--BETA 160003,	-- Savage Vigor (Rylak)
			--BETA 160014,	-- Sturdiness (Goat)
			--BETA 166928,	-- Blood Pact
			--BETA 469,	-- Commanding Shout
			--BETA 111922,	-- Runescroll of Fortitude III
		}
	}

	-- Caster buffs
	function T.ReminderCasterBuffs()
		Spell5Buff = {	-- Spell Power
			--BETA 1459,	-- Arcane Brilliance
			--BETA 61316,	-- Dalaran Brilliance
			--BETA 160205,	-- Lone Wolf: Wisdom of the Serpent
			--BETA 126309,	-- Still Water (Water Strider)
			--BETA 128433,	-- Serpent's Cunning (Serpent)
			--BETA 90364,	-- Qiraji Fortitude (Silithid)
			--BETA 109773,	-- Dark Intent
		}
	end

	-- Physical buffs
	function T.ReminderPhysicalBuffs()
		Spell5Buff = {	-- Attack Power
			--BETA 57330,	-- Horn of Winter
			--BETA 19506,	-- Trueshot Aura
			--BETA 6673,	-- Battle Shout
		}
	end

	Spell6Buff = {	-- Haste
		--BETA 116956,	-- Grace of Air
		--BETA 55610,	-- Unholy Aura
		--BETA 160203,	-- Lone Wolf: Haste of the Hyena
		--BETA 128432,	-- Cackling Howl (Hyena)
		--BETA 135678,	-- Energizing Spores (Sporebat)
		--BETA 160003,	-- Savage Vigor (Rylak)
		--BETA 49868,	-- Mind Quickening
		--BETA 113742,	-- Swiftblade's Cunning
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
		--BETA DEATHKNIGHT = {
			--[1] = {	-- Horn of Winter group
				--["spells"] = {
					--57330,	-- Horn of Winter
				--},
				--["negate_spells"] = {
					--6673,	-- Battle Shout
					--19506,	-- Trueshot Aura
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
			--[2] = {	-- Blood Presence group
				--["spells"] = {
					--48263,	-- Blood Presence
				--},
				--["role"] = "Tank",
				--["instance"] = true,
				--["reversecheck"] = true,
			--},
		--},
		--BETA DRUID = {
			--[1] = {	-- Mark of the Wild group
				--["spells"] = {
					--1126,	-- Mark of the Wild
				--},
				--["negate_spells"] = {
					--160206,	-- Lone Wolf: Power of the Primates
					--159988,	-- Bark of the Wild (Dog)
					--160017,	-- Blessing of Kongs (Gorilla)
					--90363,	-- Embrace of the Shale Spider
					--160077,	-- Strength of the Earth (Worm)
					--115921,	-- Legacy of the Emperor
					--116781,	-- Legacy of the White Tiger
					--20217,	-- Blessing of Kings
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
		--},
		--BETA MAGE = {
			--[1] = {	-- Brilliance group
				--["spells"] = {
					--1459,	-- Arcane Brilliance
					--61316,	-- Dalaran Brilliance
				--},
				--["negate_spells"] = {
					--160205,	-- Lone Wolf: Wisdom of the Serpent
					--126309,	-- Still Water (Water Strider)
					--128433,	-- Serpent's Cunning (Serpent)
					--90364,	-- Qiraji Fortitude (Silithid)
					--109773,	-- Dark Intent
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
		--},
		--BETA MONK = {
			--[1] = {	-- Legacy of the Emperor group
				--["spells"] = {
					--115921,	-- Legacy of the Emperor
				--},
				--["negate_spells"] = {
					--1126,	-- Mark of the Wild
					--160206,	-- Lone Wolf: Power of the Primates
					--159988,	-- Bark of the Wild (Dog)
					--160017,	-- Blessing of Kongs (Gorilla)
					--90363,	-- Embrace of the Shale Spider
					--160077,	-- Strength of the Earth (Worm)
					--116781,	-- Legacy of the White Tiger
					--20217,	-- Blessing of Kings
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
			--[2] = {	-- Legacy of the White Tiger group
				--["spells"] = {
					--116781,	-- Legacy of the White Tiger
				--},
				--["negate_spells"] = {
					--91126,	-- Mark of the Wild
					--160206,	-- Lone Wolf: Power of the Primates
					--159988,	-- Bark of the Wild (Dog)
					--160017,	-- Blessing of Kongs (Gorilla)
					--90363,	-- Embrace of the Shale Spider
					--160077,	-- Strength of the Earth (Worm)
					--115921,	-- Legacy of the Emperor
					--20217,	-- Blessing of Kings
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
		--},
		PALADIN = {
			[1] = {	-- Greater Blessing of Kings
				["spells"] = {
					203538,	-- Greater Blessing of Kings
				},
				["negate_spells"] = {

				},
				["personal"] = {

				},
				["spec"] = 3,		-- Only Ret paladin can buff
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Greater Blessing of Might
				["spells"] = {
					203528,	-- Blessing of Might
				},
				["negate_spells"] = {

				},
				["personal"] = {

				},
				["spec"] = 3,		-- Only Ret paladin can buff
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[3] = {	-- Greater Blessing of Wisdom
				["spells"] = {
					203539,	-- Blessing of Wisdom
				},
				["negate_spells"] = {

				},
				["personal"] = {

				},
				["spec"] = 3,		-- Only Ret paladin can buff
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		--BETA PRIEST = {
			--[1] = {	-- Stamina group
				--["spells"] = {
					--21562,	-- Power Word: Fortitude
				--},
				--["negate_spells"] = {
					--160199,	-- Lone Wolf: Fortitude of the Bear
					--50256,	-- Invigorating Roar (Bear)
					--90364,	-- Qiraji Fortitude (Silithid)
					--160003,	-- Savage Vigor (Rylak)
					--160014,	-- Sturdiness (Goat)
					--166928,	-- Blood Pact
					--469,	-- Commanding Shout
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true
			--},
		--},
		ROGUE = {
			[1] = {	-- Lethal Poisons group
				["spells"] = {
					2823,	-- Deadly Poison
					8679,	-- Wound Poison
				},
				["spec"] = 1,		-- Only Assassination have poisen now
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Non-Lethal Poisons group
				["spells"] = {
					3408,	-- Crippling Poison
				},
				["spec"] = 1,		-- Only Assassination have poisen now
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		--BETA SHAMAN = {
			--[1] = {	-- Shields group
				--["spells"] = {
					--52127,	-- Water Shield
					--324,	-- Lightning Shield
					--974,	-- Earth Shield
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
		--},
		--BETA WARLOCK = {
			--[1] = {	-- Dark Intent group
				--["spells"] = {
					--109773,	-- Dark Intent
				--},
				--["negate_spells"] = {
					--160205,	-- Lone Wolf: Wisdom of the Serpent
					--126309,	-- Still Water (Water Strider)
					--128433,	-- Serpent's Cunning (Serpent)
					--90364,	-- Qiraji Fortitude (Silithid)
					--1459,	-- Arcane Brilliance
					--61316,	-- Dalaran Brilliance
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
		--},
		--BETA WARRIOR = {
			--[1] = {	-- Commanding Shout group
				--["spells"] = {
					--469,	-- Commanding Shout
				--},
				--["negate_spells"] = {
					--160199,	-- Lone Wolf: Fortitude of the Bear
					--50256,	-- Invigorating Roar (Bear)
					--90364,	-- Qiraji Fortitude (Silithid)
					--160003,	-- Savage Vigor (Rylak)
					--160014,	-- Sturdiness (Goat)
					--21562,	-- Power Word: Fortitude
					--166928,	-- Blood Pact
				--},
				--["personal"] = {
					--6673,	-- Battle Shout
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
			--[2] = {	-- Battle Shout group
				--["spells"] = {
					--6673,	-- Battle Shout
				--},
				--["negate_spells"] = {
					--19506,	-- Trueshot Aura
					--57330,	-- Horn of Winter
				--},
				--["personal"] = {
					--469,	-- Commanding Shout
				--},
				--["combat"] = true,
				--["instance"] = true,
				--["pvp"] = true,
			--},
		--},
	}
end
