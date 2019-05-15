local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	Show All Action Bars
----------------------------------------------------------------------------------------
SetActionBarToggles(1, 1, 1, 1, 1) -- Seemingly not working? Using the below as an alternative for now.

if IsTestBuild() then
	local actionBars = {
		"BottomLeft",
		"BottomRight",
		"Right",
		"RightTwo"
	}

	for i = 1, 4 do
		local bar = select(i, GetActionBarToggles())
		if not bar then
			local checkbox = actionBars[i]
			_G["InterfaceOptionsActionBarsPanel"..checkbox]:Click()
		end
	end

	SetCVar("alwaysShowActionBars", 1)
end

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
--	Cast Bars for units that aren't "player"
----------------------------------------------------------------------------------------
local unitEvents = {
	["CURRENT_SPELL_CAST_CHANGED"] = true,
	["UNIT_SPELLCAST_SENT"] = true,
	["UNIT_SPELLCAST_CHANNEL_START"] = true,
	["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
	["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
	["UNIT_SPELLCAST_DELAYED"] = true,
	["UNIT_SPELLCAST_FAILED"] = true,
	["UNIT_SPELLCAST_FAILED_QUIET"] = true,
	["UNIT_SPELLCAST_INTERRUPTED"] = true,
	["UNIT_SPELLCAST_INTERRUPTIBLE"] = true,
	["UNIT_SPELLCAST_NOT_INTERRUPTIBLE"] = true,
	["UNIT_SPELLCAST_START"] = true,
	["UNIT_SPELLCAST_STOP"] = true,
	["UNIT_SPELLCAST_SUCCEEDED"] = true
}

local castEvents = {
	["SPELL_CAST_START"] = true,
	["SPELL_CAST_SUCCESS"] = true,
	["SPELL_CAST_FAILED"] = true,
	["SPELL_INTERRUPT"] = true,
	["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
	["UNIT_SPELLCAST_DELAYED"] = true,
	["UNIT_SPELLCAST_FAILED"] = true,
	["UNIT_SPELLCAST_FAILED_QUIET"] = true,
	["UNIT_SPELLCAST_INTERRUPTED"] = true,
	["UNIT_SPELLCAST_INTERRUPTIBLE"] = true,
	["UNIT_SPELLCAST_NOT_INTERRUPTIBLE"] = true,
	["UNIT_SPELLCAST_START"] = true,
	["UNIT_SPELLCAST_STOP"] = true,
	["UNIT_SPELLCAST_SUCCEEDED"] = true
}

local CastScanner = CreateFrame("Frame")

local function CombatLogCheck(unit)
	if not unit then return end

	local guid = UnitGUID(unit)
	local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()
	local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
	-- name:				String - The name of the spell, or nil if no spell is being cast.
	-- text:				String - The name to be displayed.
	-- texture:				String - The texture path associated with the spell icon.
	-- startTimeMS:			Number - Specifies when casting began in milliseconds (corresponds to GetTime()*1000).
	-- endTimeMS:			Number - Specifies when casting will end in milliseconds (corresponds to GetTime()*1000).
	-- isTradeSkill:		Boolean - Specifies if the cast is a tradeskill
	-- castID:				String - GUID-like string (an example is 3-3890-1159-21205-8936-00014B7E7F) where the second to last value is the spellID. The other values are as yet unknown.
	-- notInterruptible:	Boolean - if true, indicates that this cast cannot be interrupted.
	-- spellID:				Integer - The spell's unique identifier. (Added in 7.2.5)
	return name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
end

UnitCastingInfo = _G.UnitCastingInfo or function()
	if unit == "player" then
		return CastingInfo()
	elseif unit == "pet" then
		-- things here later
	elseif unit == "target" then
		-- things here later
	elseif unit == "focus" then
		-- things here later
	end
end

UnitChannelInfo = _G.UnitChannelInfo or function()
	if unit == "player" then
		return ChannelInfo()
	elseif unit == "pet" then
		-- things here later
	elseif unit == "target" then
		-- things here later
	elseif unit == "focus" then
		-- things here later
	end
end

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

GetSpecialization = _G.GetSpecialization or function()
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
			local class = select(2, UnitClass(unit))
			if class == "MAGE" or class == "HUNTER" or class == "ROGUE" or class == "WARLOCK" then
				role = "DAMAGER"
			elseif class == "DRUID" or class == "PALADIN" or class == "PRIEST" or class == "SHAMAN" then
				role = "HEALER"
			elseif class == "WARRIOR" then
				role = "TANK"
			end
		end
		return role
	end
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