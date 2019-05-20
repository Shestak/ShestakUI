local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Well Fed -> http://www.wowhead.com/spell=104280
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.reminder.raid_buffs_enable == true or C.announcements.flask_food == true then
	T.ReminderBuffs = {
		Flask = {
			17627,	-- Flask of Distilled Wisdom (+2000 Mana)
			17628,	-- Flask of Supreme Power (+150 Spell Damage)
			17629,	-- Flask of Chromatic Resistance (+25 Magic Resistance)
			17626,	-- Flask of the Titans (+400 Health)
		},
		BattleElixir = {
			11406,	-- Elixir of Demonslaying (+265 Attack Power to Demons)
			17539,	-- Greater Arcane Elixir (+35 Spell Damage)

		},
		GuardianElixir = {
			--spellID,	-- Spell name
		},
		Food = {
			15852,	-- Dragonbreath Chili (Special) [Dragonbreath Chili]
			22730,	-- Increased Intellect (+10 Intellect) [Runn Tum Tuber Surprise]
			24799,	-- Well Fed (+20 Strength) [Helboar Bacon / Smoked Desert Dumplings]
			25661,	-- Increased Stamina (+25 Stamina) [Dirge's Kickin' Chimaerok Chops]
		},
		PetFood = {
		},
		Kings = {
			20217,	-- Blessing of Kings
			25898,	-- Greater Blessing of Kings
		},
		Mark = {
			1126,	-- Mark of the Wild
			21849,	-- Gift of the Wild
		},
		Fortitude = {
			1243,	-- Power Word: Fortitude
			21562,	-- Prayer of Fortitude
		},
		Spirit = {
			14752,	-- Divine Spirit
			27681,	-- Prayer of Spirit
		},
		Sanctuary = {
			20911,	-- Blessing of Sanctuary
			25899,	-- Greater Blessing of Sanctuary
		},
		Salvation = {
			1038,	-- Blessing of Salvation
			25895,	-- Greater Blessing of Salvation
		},
		Might = {
			19740,	-- Blessing of Might
			25782,	-- Greater Blessing of Might
		},
		Intellect = {
			1459,	-- Arcane Intellect
			23028,	-- Arcane Brilliance
		},
		Wisdom = {
			19742,	-- Blessing of Wisdom
			25894,	-- Greater Blessing of Wisdom
		},
		Stamina = {
			-- 21562,	-- Power Word: Fortitude
			-- 264764,	-- War-Scroll of Fortitude
		},
		Custom = {
			-- spellID,	-- Spell name
		}
	}

	-- Caster buffs
	function T.ReminderCasterBuffs()
		Spell4Buff = {	-- Intellect
			-- 1459,	-- Arcane Intellect
			-- 264760,	-- War-Scroll of Intellect
		}
	end

	-- Physical buffs
	function T.ReminderPhysicalBuffs()
		Spell4Buff = {	-- Attack Power
			-- 6673,	-- Battle Shout
			-- 264761,	-- War-Scroll of Battle Shout
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
		--[[
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
		--]]
		DRUID = {
			[1] = {	-- Mark of the Wild group
				["spells"] = {
					1126,	-- Mark of the Wild
					21849,	-- Gift of the Wild
				},
				["combat"] = true,
				["instance"] = true,
			},
			[2] = {	-- Omen of Clarity group
				["spells"] = {
					16864,	-- Omen of Clarity
				},
				["combat"] = true,
				["instance"] = true,
			},
		},
		HUNTER = {
			[1] = {	-- Aspects group
				["spells"] = {
					13165,	-- Aspect of the Hawk
					13161,	-- Aspect of the Beast
					5118,	-- Aspect of the Cheetah
					13163,	-- Aspect of the Monkey
					13159,	-- Aspect of the Pack
					20043,	-- Aspect of the Wild
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				-- ["level"] = 10,
			},
			[2] = {	-- Trueshot group
				["spells"] = {
					19506,	-- Trueshot Aura
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		MAGE = {
			[1] = {	-- Armors group
				["spells"] = {
					168,	-- Frost Armor
					6117,	-- Mage Armor
					7302,	-- Ice Armor
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Intellect group
				["spells"] = {
					1459,	-- Arcane Intellect
					23028,	-- Arcane Brilliance
				},
				["combat"] = true,
				["instance"] = true,
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
				-- ["negate_reversecheck"] = 1,	-- Holy paladins use RF sometimes
				["negate_reversecheck"] = "Healer",	-- Holy paladins use RF sometimes
				-- ["level"] = 16,
			},
			[2] = {	-- Auras group
				["spells"] = {
					465,	-- Devotion Aura
					7294,	-- Retribution Aura
					20218,	-- Sanctity Aura
					19746,	-- Concentration Aura
					19891,	-- Fire Resistance Aura
					19888,	-- Frost Resistance Aura
					19876,	-- Shadow Resistance Aura
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--[[
			[3] = {	-- Seals group
				["spells"] = {
					21084,	-- Seal of Righteousness
					20735,	-- Seal of Command
					20164,	-- Seal of Justice
					20165,	-- Seal of Light
					20166,	-- Seal of Wisdom
					21082,	-- Seal of the Crusader
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--]]
		},
		PRIEST = {
			[1] = {	-- Inner Fire/Will group
				["spells"] = {
					588,	-- Inner Fire
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				-- ["level"] = 12,
			},
			[2] = {	-- Stamina Group
				["spells"] = {
					1243,	-- Power Word: Fortitude
					21562,	-- Prayer of Fortitude
				},
				["combat"] = true,
				["instance"] = true,
			},
			[3] = {	-- Spirit
				["spells"] = {
					14752,	-- Divine Spirit
					27681,	-- Prayer of Spirit
				},
				["combat"] = true,
				["instance"] = true,
				-- ["level"] = 30,
			},
			[4] = {	-- Shadow Resistance group
				["spells"] = {
					976,	-- Shadow Protection
					27683,	-- Prayer of Shadow Protection
				},
				["combat"] = true,
				["instance"] = true,
				-- ["level"] = 30,
			},
			--[[
			[5] = {	-- Shadowform group
				["spells"] = {
					15473,	-- Shadowform
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--]]
		},
		ROGUE = { 
			[1] = {	-- Weapon enchants group
				["weapon"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				-- ["level"] = 20,
			},
		},
		SHAMAN = {
			[1] = {	-- Weapons enchants group
				["weapon"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		WARLOCK = {
			[1] = {	-- Armors group
				["spells"] = {
					706,	-- Demon Armor
					687,	-- Demon Skin
				},
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
			--[[
			[2] = {	-- Stance group
				["spells"] = {
					2457,	-- Battle Stance
					2458,	-- Berserker Stance
					71,		-- Defensive Stance
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--]]
		},
	}
end