local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Well Fed -> http://www.wowhead.com/spell=104280
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name, _, icon = GetSpellInfo(id)
	if name then
		return {name, icon}
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return {"Empty", ""}
	end
end

if C.reminder.raid_buffs_enable == true or C.announcements.flask_food == true then
	T.ReminderBuffs = {
		Flask = {
			SpellName(371354),	-- Phial of the Eye in the Storm
			SpellName(373257),	-- Phial of Glacial Fury
			SpellName(374000),	-- Iced Phial of Corrupting Rage
			SpellName(370652),	-- Phial of Static Empowerment
		},
		BattleElixir = {
			-- SpellName(spellID),	-- Spell name

		},
		GuardianElixir = {
			-- SpellName(spellID),	-- Spell name
		},
		Food = {
			SpellName(104280),	-- Well Fed
		},
		Stamina = {
			SpellName(21562),	-- Power Word: Fortitude
		},
		Vers = {
			SpellName(1126),	-- Mark of the Wild
		},
		Custom = {
			-- SpellName(spellID),	-- Spell name
		}
	}

	-- Caster buffs
	function T.ReminderCasterBuffs()
		Spell4Buff = {	-- Intellect
			SpellName(1459),	-- Arcane Intellect
		}
	end

	-- Physical buffs
	function T.ReminderPhysicalBuffs()
		Spell4Buff = {	-- Attack Power
			SpellName(6673),	-- Battle Shout
		}
	end
end

----------------------------------------------------------------------------------------
--[[------------------------------------------------------------------------------------
	Spell Reminder Arguments

	Type of Check:
		spells - List of spells in a group, if you have anyone of these spells the icon will hide.

	Spells only Requirements:
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
		DRUID = {
			[1] = {	-- Mark of the Wild group
				["spells"] = {
					SpellName(1126),	-- Mark of the Wild
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		EVOKER = {
			[1] = {	-- Blessing of the Bronze
				["spells"] = {
					SpellName(381748),	-- Blessing of the Bronze
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		MAGE = {
			[1] = {	-- Intellect group
				["spells"] = {
					SpellName(1459),	-- Arcane Intellect
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		PALADIN = {
			[1] = {	-- Auras group
				["spells"] = {
					SpellName(465),		-- Devotion Aura
					SpellName(183435),	-- Retribution Aura
					SpellName(317920),	-- Concentration Aura
				},
				["instance"] = true
			},
		},
		PRIEST = {
			[1] = {	-- Stamina group
				["spells"] = {
					SpellName(21562),	-- Power Word: Fortitude
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true
			},
		},
		ROGUE = {
			[1] = {	-- Lethal Poisons group
				["spells"] = {
					SpellName(2823),	-- Deadly Poison
					SpellName(315584),	-- Instant Poison
					SpellName(8679),	-- Wound Poison
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Non-Lethal Poisons group
				["spells"] = {
					SpellName(3408),	-- Crippling Poison
					SpellName(5761),	-- Numbing Poison
					SpellName(108211),	-- Leeching Poison
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		SHAMAN = {
			[1] = {	-- Water/Earth Shield
				["spells"] = {
					SpellName(52127),	-- Water Shield
					SpellName(974),	-- Earth Shield
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Windfury Weapon group
				["spells"] = {
					SpellName(33757),	-- Windfury Weapon
				},
				["mainhand"] = true,
				["spec"] = 2,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				["level"] = 10,
			},
			[3] = {	-- Flametongue Weapon group
				["spells"] = {
					SpellName(318038),	-- Flametongue Weapon
				},
				["offhand"] = true,
				["spec"] = 2,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				["level"] = 10,
			},
		},
		WARRIOR = {
			[1] = {	-- Battle Shout group
				["spells"] = {
					SpellName(6673),	-- Battle Shout
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
	}
end