local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Well Fed -> http://www.wowhead.com/spell=104280
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.reminder.raid_buffs_enable == true or C.announcements.flask_food == true then
	T.ReminderBuffs = {
		Flask = {
			251836,	-- Flask of the Currents (Agility)
			251839,	-- Flask of the Undertow (Strenght)
			251838,	-- Flask of the Vast Horizon (Stamina)
			251837,	-- Flask of Endless Fathoms (Intellect)
		},
		BattleElixir = {
			--spellID,	-- Spell name

		},
		GuardianElixir = {
			--spellID,	-- Spell name
		},
		Food = {
			104280,	-- Well Fed
		},
		Stamina = {
			21562,	-- Power Word: Fortitude
			264764,	-- War-Scroll of Fortitude
		},
		Custom = {
			-- spellID,	-- Spell name
		}
	}

	-- Caster buffs
	function T.ReminderCasterBuffs()
		Spell4Buff = {	-- Intellect
			1459,	-- Arcane Intellect
			264760,	-- War-Scroll of Intellect
		}
	end

	-- Physical buffs
	function T.ReminderPhysicalBuffs()
		Spell4Buff = {	-- Attack Power
			6673,	-- Battle Shout
			264761,	-- War-Scroll of Battle Shout
		}
	end
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
		combat - check when entering combat
		instance - check when entering a party/raid instance
		pvp - check when entering a bg/arena

	For every group created a new frame is created, it's a lot easier this way.
]]--------------------------------------------------------------------------------------
if C.reminder.solo_buffs_enable == true then
	T.ReminderSelfBuffs = {
		MAGE = {
			[1] = {	-- Intellect group
				["spells"] = {
					1459,	-- Arcane Intellect
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
				["spec"] = 1,		-- Only Assassination have poisen now
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Non-Lethal Poisons group
				["spells"] = {
					3408,	-- Crippling Poison
					108211,	-- Leeching Poison
				},
				["spec"] = 1,		-- Only Assassination have poisen now
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		WARRIOR = {
			[1] = {	-- Battle Shout group
				["spells"] = {
					6673,	-- Battle Shout
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
	}
end