local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	NOOP / Pass Functions not found in Classic
----------------------------------------------------------------------------------------
GetCurrencyInfo = _G.GetCurrencyInfo or T.dummy
GetCurrencyListInfo = _G.GetCurrencyListInfo or T.dummy
GetCurrencyListSize = _G.GetCurrencyListSize or function()
	return 0
end

GetContainerItemEquipmentSetInfo = _G.GetContainerItemEquipmentSetInfo or T.dummy
GetContainerItemQuestInfo = _G.GetContainerItemQuestInfo or T.dummy
IsContainerItemAnUpgrade = _G.IsContainerItemAnUpgrade or T.dummy

GetProfessions = _G.GetProfessions or T.dummy

GetFriendshipReputation = _G.GetFriendshipReputation or T.dummy
IsXPUserDisabled = _G.IsXPUserDisabled or T.dummy
IsWatchingHonorAsXP = _G.IsWatchingHonorAsXP or T.dummy
IsInActiveWorldPVP = _G.IsInActiveWorldPVP or T.dummy

UnitInVehicle = _G.UnitInVehicle or T.dummy
UnitHasVehicleUI = _G.UnitHasVehicleUI or T.dummy
UnitIsWildBattlePet = _G.UnitIsWildBattlePet or T.dummy
UnitIsBattlePetCompanion = _G.UnitIsBattlePetCompanion or T.dummy

PlayerTalentFrame_Toggle = _G.PlayerTalentFrame_Toggle or T.dummy

GetFriendInfo = _G.GetFriendInfo or function(name)
	return C_FriendList.GetFriendInfo(name)
end

GetNumFriends = _G.GetNumFriends or function()
	return C_FriendList.GetNumFriends()
end

ShowFriends = _G.ShowFriends or function()
	return C_FriendList.ShowFriends()
end

----------------------------------------------------------------------------------------
--	Classic Bugs
----------------------------------------------------------------------------------------
-- https://git.tukui.org/Tukz/Tukui/commit/ca387b55e84bc6cb13719c648ae6d34d7d3c7493#15effd8cfb7a22a107bef69a493f44fe34236102
-- BUG TO REPORT AT BLIZZARD

-- Message: Interface\FrameXML\SecureGroupHeaders.lua:303: attempt to call global 'UnitGroupRolesAssigned' (a nil value)
-- Cause: UnitGroupRolesAssigned still exist in SecureGroupHeaders, it should not
-- UnitGroupRolesAssigned = function() return "" end

-- Message: Interface\FrameXML\SecureTemplates.lua:219: attempt to call global 'UnitIsOtherPlayersBattlePet' (a nil value)
-- Cause: UnitIsOtherPlayersBattlePet still exist in SecureTemplates, it should not
UnitIsOtherPlayersBattlePet = function(unit) return false end

----------------------------------------------------------------------------------------
--	Quest Functions
----------------------------------------------------------------------------------------
GetAvailableQuestInfo = _G.GetAvailableQuestInfo or function(index)
	if not index then return end

	return IsActiveQuestTrivial(index), 1, false, false
end

----------------------------------------------------------------------------------------
--	Cast Bars for units that aren't "player"
----------------------------------------------------------------------------------------
local CastScanner = CreateFrame("Frame")
CastScanner.db = {}

UnitCastingInfo = _G.UnitCastingInfo or function(unit)
	assert(type(unit) == "string", "Usage: UnitCastingInfo(\"unit\")")
	if unit == "player" then
		return CastingInfo()
	elseif UnitExists(unit) then
		local castStatus, channelStatus, castTime, delay
		local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
		local db = CastScanner.db[UnitGUID(unit)]

		if db and db.castStatus and db.startTimeMS + db.castTime > GetTime() then
			if db.channelStatus then return end
			castStatus				= db.castStatus
			channelStatus			= db.channelStatus
			castTime				= db.castTime
			delay					= db.delay
			name					= db.name
			text					= db.text
			texture					= db.texture
			startTimeMS				= db.startTimeMS
			endTimeMS				= db.endTimeMS
			isTradeSkill			= db.isTradeSkill
			castID					= db.castID
			notInterruptible		= db.notInterruptible
			spellID					= db.spellID
		elseif db then
			wipe(db)
		end

		return name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
	end
end

UnitChannelInfo = _G.UnitChannelInfo or function(unit)
	assert(type(unit) == "string", "Usage: UnitCastingInfo(\"unit\")")
	if unit == "player" then
		return ChannelInfo()
	elseif UnitExists(unit) then
		local castStatus, channelStatus, castTime, delay
		local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
		local db = CastScanner.db[UnitGUID(unit)]

		if db and db.castStatus and db.startTimeMS + db.castTime > GetTime() then
			if not db.channelStatus then return end
			castStatus				= db.castStatus
			channelStatus			= db.channelStatus
			castTime				= db.castTime
			delay					= db.delay
			name					= db.name
			text					= db.text
			texture					= db.texture
			startTimeMS				= db.startTimeMS
			endTimeMS				= db.endTimeMS
			isTradeSkill			= db.isTradeSkill
			castID					= db.castID
			notInterruptible		= db.notInterruptible
			spellID					= db.spellID
		elseif db then
			wipe(db)
		end
		
		return name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
	end
end

function CastScanner:AddCast(GUID, castID, spellID, timestamp, channelStatus)
	if not GUID or not spellID then return nil end

	if not self.db[GUID] then self.db[GUID] = {} end
	local db = self.db[GUID]

	local name, rank, texture, castTime = GetSpellInfo(spellID)
	local text, isTradeSkill = nil, select(2, GetSpellTradeSkillLink(spellID))

	if rank then
		text = tostring(name.." (r"..rank..")")
	else
		text = name
	end

	if isTradeSkill then
		isTradeSkill = true
	else
		isTradeSkill = false
	end

	local notInterruptible, playerGUID, targetGUID = true, UnitGUID("player"), UnitGUID("target")

	if GUID == playerGUID or (GUID == targetGUID and UnitIsPlayer("target")) then
		notInterruptible = false
	end

	db.castStatus					= true
	db.channelStatus				= channelStatus or false
	db.castTime						= castTime
	db.delay						= 0
	db.name							= name
	db.text							= text
	db.texture						= texture
	db.startTimeMS					= timestamp
	db.endTimeMS					= db.startTimeMS + castTime
	db.isTradeSkill					= isTradeSkill
	db.castID						= castID
	db.notInterruptible				= notInterruptible -- build a DB for fallback later
	db.spellID						= spellID

	self.db[GUID]					= db
end

function CastScanner:DelayCast(GUID, castID, spellID, timestamp, channelStatus) -- Needs work
	if not GUID or not spellID or not self.db[GUID] then return nil end

	local db = self.db[GUID]

	local oldStartTimeMS, oldDelay = db.startTimeMS or timestamp, db.delay or 0

	local name, rank, texture, castTime = GetSpellInfo(spellID)
	local text, isTradeSkill = nil, select(2, GetSpellTradeSkillLink(spellID))

	if rank then
		text = tostring(name.." (r"..rank..")")
	else
		text = name
	end

	if isTradeSkill then
		isTradeSkill = true
	else
		isTradeSkill = false
	end

	local notInterruptible, playerGUID, targetGUID = true, UnitGUID("player"), UnitGUID("target")

	if GUID == playerGUID or (GUID == targetGUID and UnitIsPlayer("target")) then
		notInterruptible = false
	end

	db.castStatus					= true
	db.channelStatus				= channelStatus or false
	db.castTime						= castTime
	db.delay						= (oldDelay + (0.5 * 1e3)) or 0
	db.name							= name
	db.text							= text
	db.texture						= texture
	db.startTimeMS					= oldStartTimeMS
	db.endTimeMS					= db.startTimeMS + castTime
	db.isTradeSkill					= isTradeSkill
	db.castID						= castID
	db.notInterruptible				= notInterruptible -- build a DB for fallback later
	db.spellID						= spellID

	if channelStatus then
		-- can range from 0.5 - 1.0 seconds per hit (we'll use the minimum for now)
		db.startTimeMS = -db.castTime + timestamp + (0.5 * 1e3)
	else
		-- can range from 0.5 - 1.0 seconds per hit (we'll use the minimum for now)
		db.endTimeMS = db.endTimeMS + db.delay
	end

	self.db[GUID] = db
end

function CastScanner:RemoveCast(GUID, castID, spellID)
	if self.db[GUID] then
		wipe(self.db[GUID])
	end
end

local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		return "Empty"
	end
end

local channelSpells = {
	-- Druid
	[SpellName(740)] = true,		-- Tranquility
	-- Hunter
	[SpellName(6197)] = true,		-- Eagle Eye
	[SpellName(1002)] = true,		-- Eyes of the Beast
	[SpellName(136)] = true,		-- Mend Pet
	[SpellName(1510)] = true,		-- Volley
	-- Mage
	[SpellName(5143)] = true,		-- Arcane Missiles
	[SpellName(10)] = true,			-- Blizzard
	[SpellName(12051)] = true,		-- Evocation
	-- Paladin
	-- Priest
	[SpellName(605)] = true,		-- Mind Control
	[SpellName(15407)] = true,		-- Mind Flay
	[SpellName(2096)] = true,		-- Mind Vision
	-- Rogue
	-- Shaman
	[SpellName(6196)] = true,		-- Far Sight
	-- Warlock
	[SpellName(689)] = true,		-- Drain Life
	[SpellName(5138)] = true,		-- Drain Mana
	[SpellName(1120)] = true,		-- Drain Soul
	[SpellName(126)] = true,		-- Eye of Kilrogg
	[SpellName(755)] = true,		-- Health Funnel
	[SpellName(1949)] = true,		-- Hellfire
	[SpellName(5740)] = true,		-- Rain of Fire
	[SpellName(18540)] = true,		-- Ritual of Doom
	[SpellName(23598)] = true,		-- Ritual of Summoning
	-- Warrior
	-- Professions
	[SpellName(746)] = true,		-- First Aid
	[SpellName(7620)] = true,		-- Fishing
	-- Racial
	[SpellName(10797)] = true,		-- Starshards
}

-- Combat Log Event
CastScanner:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- Unit Events
CastScanner:RegisterEvent("UNIT_SPELLCAST_SENT")				-- "unit", "target", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_START")				-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_STOP")				-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")			-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")		-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")		-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")		-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_DELAYED")				-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_FAILED")				-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")		-- "unitTarget", "castGUID", spellID
CastScanner:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")			-- "unitTarget", "castGUID", spellID
-- CastScanner:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")		-- "unitTarget" (BfA)
-- CastScanner:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")	-- "unitTarget" (BfA)

CastScanner:SetScript("OnEvent", function(self, event, ...)
	local unitTarget, castGUID, spellID

	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		-- local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, CLEUSpellID, spellName, spellSchool = CombatLogGetCurrentEventInfo()
		local _, subEvent, _, sourceGUID, _, _, _, _, _, _, _, CLEUSpellID, spellName = CombatLogGetCurrentEventInfo()

		if subEvent == "SPELL_CAST_START" then
			if self.db[sourceGUID] then
				if self.db[sourceGUID].castStatus == true and self.db[sourceGUID].spellID == CLEUSpellID then
					castGUID = self.db[sourceGUID].castID
				end
			end

			if not castGUID then return end

			if not spellName == channelSpells[spellName] then
				CastScanner:AddCast(sourceGUID, castGUID, CLEUSpellID, GetTime() * 1e3, true)
			else
				CastScanner:AddCast(sourceGUID, castGUID, CLEUSpellID, GetTime() * 1e3)
			end
		elseif subEvent == "SPELL_CAST_SUCCESS" or subEvent == "SPELL_CAST_FAILED" or subEvent == "SPELL_INTERRUPT" then
			CastScanner:RemoveCast(sourceGUID, castGUID, CLEUSpellID)
		end
	elseif event == "UNIT_SPELLCAST_SENT" then
		unitTarget, _, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)
		CastScanner:AddCast(unitTarget, castGUID, spellID, GetTime() * 1e3)
	elseif event == "UNIT_SPELLCAST_START" then
		unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)
		CastScanner:AddCast(unitTarget, castGUID, spellID, GetTime() * 1e3)
	elseif event == "UNIT_SPELLCAST_DELAYED" then
		unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)
		CastScanner:DelayCast(unitTarget, castGUID, spellID, GetTime() * 1e3)
	elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
		unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)
		CastScanner:AddCast(unitTarget, castGUID, spellID, GetTime() * 1e3, true)
	elseif event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then
		unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)
		CastScanner:DelayCast(unitTarget, castGUID, spellID, GetTime() * 1e3, true)
	elseif event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_CHANNEL_STOP" or event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_FAILED_QUIET" or event == "UNIT_SPELLCAST_INTERRUPTED" then
		unitTarget, castGUID, spellID = ...
		unitTarget = UnitGUID(unitTarget)
		CastScanner:RemoveCast(unitTarget, castGUID, spellID)
	end
end)

----------------------------------------------------------------------------------------
--	Specialization Functions 
----------------------------------------------------------------------------------------
local specializationID = {
	["DRUID"] = {
		[1] = 102, -- Balance
		[2] = 103, -- Feral
		[3] = 105, -- Restoration
	},
	["HUNTER"] = {
		[1] = 253, -- Beast Mastery
		[2] = 254, -- Marksmanship
		[3] = 255, -- Survival
	},
	["MAGE"] = {
		[1] = 62, -- Arcane
		[2] = 63, -- Fire
		[3] = 64, -- Frost
	},
	["PALADIN"] = {
		[1] = 65, -- Holy
		[2] = 66, -- Protection
		[3] = 67, -- Retribution
	},
	["PRIEST"] = {
		[1] = 256, -- Discipline
		[2] = 257, -- Holy
		[3] = 258, -- Shadow
	},
	["ROGUE"] = {
		[1] = 259, -- Assassination
		[2] = 260, -- Combat
		[3] = 261, -- Subtlety
	},
	["SHAMAN"] = {
		[1] = 262, -- Elemental
		[2] = 263, -- Enhancment
		[3] = 264, -- Restoration
	},
	["WARLOCK"] = {
		[1] = 265, -- Affliction
		[2] = 266, -- Demonology
		[3] = 267, -- Destruction
	},
	["WARRIOR"] = {
		[1] = 71, -- Arms
		[2] = 72, -- Fury
		[3] = 73, -- Protection
	}
}

local specializationIcons = {
	["DRUID"] = {
		[1] = "Spell_nature_starfall",			-- Balance
		[2] = "Ability_druid_catform",			-- Feral
		[3] = "Spell_nature_healingtouch"		-- Restoration
	},
	["HUNTER"] = {
		[1] = "Ability_hunter_beasttaming",		-- Beast Mastery
		[2] = "Ability_marksmanship",			-- Marksmanship
		[3] = "Ability_hunter_swiftstrike"		-- Survival
	},
	["MAGE"] = {
		[1] = "Spell_holy_magicalsentry",		-- Arcane
		[2] = "Spell_fire_firebolt02",			-- Fire
		[3] = "Spell_frost_frostbolt02"			-- Frost
	},
	["PALADIN"] = {
		[1] = "Spell_holy_holybolt",			-- Holy
		[2] = "Spell_holy_devotionaura",		-- Protection
		[3] = "Spell_holy_auraoflight"			-- Retribution
	},
	["PRIEST"] = {
		[1] = "Spell_holy_wordfortitude",		-- Discipline
		[2] = "Spell_holy_holybolt",			-- Holy
		[3] = "Spell_shadow_shadowwordpain"		-- Shadow
	},
	["ROGUE"] = {
		[1] = "Ability_rogue_eviscerate",		-- Assassination
		[2] = "Ability_backstab",				-- Combat
		[3] = "Ability_stealth"					-- Subtlety
	},
	["SHAMAN"] = {
		[1] = "Spell_nature_lightning",			-- Elemental
		[2] = "Spell_nature_lightningshield",	-- Enhancment
		[3] = "Spell_nature_magicimmunity"		-- Restoration
	},
	["WARLOCK"] = {
		[1] = "Spell_shadow_deathcoil",			-- Affliction
		[2] = "Spell_shadow_metamorphosis",		-- Demonology
		[3] = "Spell_shadow_rainoffire"			-- Destruction
	},
	["WARRIOR"] = {
		[1] = "Ability_rogue_eviscerate",		-- Arms
		[2] = "Ability_warrior_innerrage",		-- Fury
		[3] = "Ability_warrior_defensivestance"	-- Protection
	}
}

local specializationInfoDB = { -- needs localized names
	[102] = {
		["name"] = "Balance",
		["description"] = "",
		["icon"] = "Spell_nature_starfall",
		["role"] = "DAMAGER",
		["class"] = "DRUID"
	},
	[103] = {
		["name"] = "Feral",
		["description"] = "",
		["icon"] = "Ability_druid_catform",
		["role"] = "TANK",
		["class"] = "DRUID"
	},
	[105] = {
		["name"] = "Restoration",
		["description"] = "",
		["icon"] = "Spell_nature_healingtouch",
		["role"] = "TANK",
		["class"] = "DRUID"
	},
	[253] = {
		["name"] = "Beast Mastery",
		["description"] = "",
		["icon"] = "Ability_hunter_beasttaming",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[254] = {
		["name"] = "Marksmanship",
		["description"] = "",
		["icon"] = "Ability_marksmanship",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[255] = {
		["name"] = "Survival",
		["description"] = "",
		["icon"] = "Ability_hunter_swiftstrike",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[62] = {
		["name"] = "Arcane",
		["description"] = "",
		["icon"] = "Spell_holy_magicalsentry",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[63] = {
		["name"] = "Fire",
		["description"] = "",
		["icon"] = "Spell_fire_firebolt02",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[64] = {
		["name"] = "Frost",
		["description"] = "",
		["icon"] = "Spell_frost_frostbolt02",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[65] = {
		["name"] = "Holy",
		["description"] = "",
		["icon"] = "Spell_holy_holybolt",
		["role"] = "HEALER",
		["class"] = "PALADIN"
	},
	[66] = {
		["name"] = "Protection",
		["description"] = "",
		["icon"] = "Spell_holy_devotionaura",
		["role"] = "TANK",
		["class"] = "PALADIN"
	},
	[67] = {
		["name"] = "Retribution",
		["description"] = "",
		["icon"] = "Spell_holy_auraoflight",
		["role"] = "DAMAGER",
		["class"] = "PALADIN"
	},
	[256] = {
		["name"] = "Discipline",
		["description"] = "",
		["icon"] = "Spell_holy_wordfortitude",
		["role"] = "HEALER",
		["class"] = "PRIEST"
	},
	[257] = {
		["name"] = "Holy",
		["description"] = "",
		["icon"] = "Spell_holy_holybolt",
		["role"] = "HEALER",
		["class"] = "PRIEST"
	},
	[258] = {
		["name"] = "Shadow",
		["description"] = "",
		["icon"] = "Spell_shadow_shadowwordpain",
		["role"] = "DAMAGER",
		["class"] = "PRIEST"
	},
	[259] = {
		["name"] = "Assassination",
		["description"] = "",
		["icon"] = "Ability_rogue_eviscerate",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[260] = {
		["name"] = "Combat",
		["description"] = "",
		["icon"] = "Ability_backstab",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[261] = {
		["name"] = "Subtlety",
		["description"] = "",
		["icon"] = "Ability_stealth",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[262] = {
		["name"] = "Elemental",
		["description"] = "",
		["icon"] = "Spell_nature_lightning",
		["role"] = "DAMAGER",
		["class"] = "SHAMAN"
	},
	[263] = {
		["name"] = "Enhancment",
		["description"] = "",
		["icon"] = "Spell_nature_lightningshield",
		["role"] = "DAMAGER",
		["class"] = "SHAMAN"
	},
	[264] = {
		["name"] = "Restoration",
		["description"] = "",
		["icon"] = "Spell_nature_magicimmunity",
		["role"] = "HEALER",
		["class"] = "SHAMAN"
	},
	[265] = {
		["name"] = "Affliction",
		["description"] = "",
		["icon"] = "Spell_shadow_deathcoil",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[266] = {
		["name"] = "Demonology",
		["description"] = "",
		["icon"] = "Spell_shadow_metamorphosis",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[267] = {
		["name"] = "Destruction",
		["description"] = "",
		["icon"] = "Spell_shadow_rainoffire",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[71] = {
		["name"] = "Arms",
		["description"] = "",
		["icon"] = "Ability_rogue_eviscerate",
		["role"] = "DAMAGER",
		["class"] = "WARRIOR"
	},
	[72] = {
		["name"] = "Fury",
		["description"] = "",
		["icon"] = "Ability_warrior_innerrage",
		["role"] = "DAMAGER",
		["class"] = "WARRIOR"
	},
	[73] = {
		["name"] = "Protection",
		["description"] = "",
		["icon"] = "Ability_warrior_defensivestance",
		["role"] = "TANK",
		["class"] = "WARRIOR"
	},
}

GetSpecialization = _G.GetSpecialization or function(...)
	local current = {}
	local primaryTree = 1
	for i = 1, 3 do
		_, _, current[i] = GetTalentTabInfo(i, "player", nil)
		if current[i] > current[primaryTree] then
			primaryTree = i
		end
	end
	return primaryTree
end

GetSpecializationRole = _G.GetSpecializationRole or function()
	local tree = GetSpecialization()
	local role
	if ((T.class == "PALADIN" and tree == 2) or (T.class == "WARRIOR" and tree == 3)) or (T.class == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
		role = "TANK"
	elseif ((T.class == "PALADIN" and tree == 1) or (T.class == "DRUID" and tree == 3) or (T.class == "SHAMAN" and tree == 3) or (T.class == "PRIEST" and tree ~= 3)) then
		role = "HEALER"
	else
		local int = select(2, UnitStat("player", 4))
		local agi = select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player")
		local ap = base + posBuff + negBuff

		if (((ap > int) or (agi > int)) and not (T.class == "SHAMAN" and tree ~= 1 and tree ~= 3) and not AuraUtil.FindAuraByName(GetSpellInfo(24858), "player")) or T.class == "ROGUE" or T.class == "HUNTER" or (T.class == "SHAMAN" and tree == 2) then
			role = "MELEE" -- ordinarily "DAMAGER"
		else
			role = "CASTER" -- ordinarily "DAMAGER"
		end
	end

	return role
end

GetSpecializationInfo = _G.GetSpecializationInfo or function(specIndex, ...)
	local id = specializationID[T.class][specIndex]
	local name, description, points, background = GetTalentTabInfo(specIndex)
	local icon = "Interface\\ICONS\\" .. specializationIcons[T.class][specIndex]
	local role = GetSpecializationRole()
	if role == "CASTER" or role == "MELEE" then
		role = "DAMAGER"
	end
	local primaryStat = ""
	return id, name, description, icon, background, role, primaryStat
end

GetSpecializationInfoByID = _G.GetSpecializationInfoByID or function(specID)
	if specializationInfoDB[specID] then
		local id = specID
		local name = specializationInfoDB[specID].name
		local description = specializationInfoDB[specID].description
		local icon = "Interface\\ICONS\\"..specializationInfoDB[specID].icon
		local role = specializationInfoDB[specID].role
		local class = specializationInfoDB[specID].class

		if name then
			return id, name, description, icon, role, class
		end
	end
end

UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned or function(unit) -- Needs work
	if unit == "player" then
		local role = GetSpecializationRole()
		if role == "MELEE" or role == "CASTER" then
			role = "DAMAGER"
		else
			role = role or ""
		end
		return role
	end
end

-- Add later
GetInspectSpecialization = _G.GetInspectSpecialization or T.dummy
GetAverageItemLevel = _G.GetAverageItemLevel or function()
	local slotName = {
		"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "WristSlot",
		"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot",
		"Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot"
	}

	local i, total, slot, itn, level = 0, 0, nil, 0

	for i in pairs(slotName) do
		slot = GetInventoryItemLink("player", GetInventorySlotInfo(slotName[i]))
		if slot ~= nil then
			itn = itn + 1
			level = select(4, GetItemInfo(slot))
			total = total + level
		end
	end

	if total < 1 or itn < 1 then return 0 end

	return floor(total / itn), floor(total / itn)
end

----------------------------------------------------------------------------------------
--	Threat Functions (mostly useless for now)
----------------------------------------------------------------------------------------
local threatColors = {
	[0] = {0.69, 0.69, 0.69},
	[1] = {1, 1, 0.47},
	[2] = {1, 0.6, 0},
	[3] = {1, 0, 0}
}

GetThreatStatusColor = _G.GetThreatStatusColor or function(statusIndex)
	if not (type(statusIndex) == "number" and statusIndex >= 0 and statusIndex < 4) then
		statusIndex = 0
	end

	return threatColors[statusIndex][1], threatColors[statusIndex][2], threatColors[statusIndex][3]
end

GetThreatStatus = _G.GetThreatStatus or function(currentThreat, maxThreat) -- Not accounting for 110%/130% modifiers
	assert(type(currentThreat) == "number" and type(maxThreat) == "number", "Usage: GetThreatStatus(currentThreat, maxThreat)")

	if not maxThreat or maxThreat == 0 then
		maxThreat = 0
		maxThreat = 1
	end

	local threatPercent = currentThreat / maxThreat * 100

	if threatPercent >= 100 then
		return 3, threatPercent
	elseif threatPercent < 100 and threatPercent >= 80 then
		return 2, threatPercent
	elseif threatPercent < 80 and threatPercent >= 50 then
		return 1, threatPercent
	else
		return 0, threatPercent
	end
end

-- local ThreatLib = LibStub("Threat-2.0", true)

UnitDetailedThreatSituation = _G.UnitDetailedThreatSituation or function(unit, mob)
	--[[[
	assert(type(unit) == "string" and (type(mob) == "string"), "Usage: UnitDetailedThreatSituation(\"unit\", \"mob\")")
	
	local firstGUID, secondGUID = UnitGUID(unit), UnitGUID(mob)
	local currentThreat, maxThreat = ThreatLib:GetThreat(firstGUID, secondGUID), ThreatLib:GetMaxThreatOnTarget(secondGUID)

	local isTanking = nil
	local status, rawthreatpct = GetThreatStatus(currentThreat, maxThreat)
	local threatpct = nil
	local threatvalue = currentThreat
	
	if status > 1 then
		isTanking = 1
	end

	return isTanking, status, threatpct, rawthreatpct, threatvalue
	--]]
end

UnitThreatSituation = _G.UnitThreatSituation or function(unit, otherunit)
	--[[
	assert(type(unit) == "string" and (type(otherunit) == "string"), "Usage: UnitThreatSituation(\"unit\"[, \"otherunit\"])")
	
	local firstGUID, secondGUID = UnitGUID(unit), UnitGUID(otherunit)
	local currentThreat, maxThreat = ThreatLib:GetThreat(firstGUID, secondGUID), ThreatLib:GetMaxThreatOnTarget(secondGUID)

	local status = GetThreatStatus(currentThreat, maxThreat)

	return status
--]]
end