local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true and C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Tags
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

oUF.Tags.Methods["Threat"] = function(unit)
	local _, status, percent = UnitDetailedThreatSituation("player", "target")
	if percent and percent > 0 then
		return ("%s%d%%|r"):format(Hex(GetThreatStatusColor(status)), percent)
	end
end
oUF.Tags.Events["Threat"] = "UNIT_THREAT_LIST_UPDATE"

oUF.Tags.Methods["DiffColor"] = function(unit)
	local r, g, b
	local level = UnitLevel(unit)
	if level < 1 then
		r, g, b = 0.69, 0.31, 0.31
	else
		local DiffColor = UnitLevel(unit) - UnitLevel("player")
		if DiffColor >= 5 then
			r, g, b = 0.69, 0.31, 0.31
		elseif DiffColor >= 3 then
			r, g, b = 0.71, 0.43, 0.27
		elseif DiffColor >= -2 then
			r, g, b = 0.84, 0.75, 0.65
		elseif -DiffColor <= GetQuestGreenRange() then
			r, g, b = 0.33, 0.59, 0.33
		else
			r, g, b = 0.55, 0.57, 0.61
		end
	end
	return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end
oUF.Tags.Events["DiffColor"] = "UNIT_LEVEL"

oUF.Tags.Methods["PetNameColor"] = function(unit)
	return string.format("|cff%02x%02x%02x", T.color.r * 255, T.color.g * 255, T.color.b * 255)
end
oUF.Tags.Events["PetNameColor"] = "UNIT_POWER_UPDATE"

oUF.Tags.Methods["GetNameColor"] = function(unit)
	local reaction = UnitReaction(unit, "player")
	if UnitIsPlayer(unit) then
		return _TAGS["raidcolor"](unit)
	elseif reaction then
		local c = T.oUF_colors.reaction[reaction]
		return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
	else
		r, g, b = 0.33, 0.59, 0.33
		return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
	end
end
oUF.Tags.Events["GetNameColor"] = "UNIT_POWER_UPDATE UNIT_FLAGS"

oUF.Tags.Methods["NameArena"] = function(unit)
	local name = UnitName(unit)
	return T.UTF(name, 4, false)
end
oUF.Tags.Events["NameArena"] = "UNIT_NAME_UPDATE"

oUF.Tags.Methods["NameShort"] = function(unit)
	local name = UnitName(unit)
	return T.UTF(name, 8, false)
end
oUF.Tags.Events["NameShort"] = "UNIT_NAME_UPDATE"

oUF.Tags.Methods["NameMedium"] = function(unit)
	local name = UnitName(unit)
	return T.UTF(name, 11, true)
end
oUF.Tags.Events["NameMedium"] = "UNIT_NAME_UPDATE"

oUF.Tags.Methods["NameLong"] = function(unit)
	local name = UnitName(unit)
	return T.UTF(name, 18, true)
end
oUF.Tags.Events["NameLong"] = "UNIT_NAME_UPDATE"

oUF.Tags.Methods["NameLongAbbrev"] = function(unit)
	local name = UnitName(unit)
	local newname = (string.len(name) > 18) and string.gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name
	return T.UTF(newname, 18, false)
end
oUF.Tags.Events["NameLongAbbrev"] = "UNIT_NAME_UPDATE"

oUF.Tags.Methods["LFD"] = function(unit)
	local role = UnitGroupRolesAssigned(unit)
	if role == "TANK" then
		return "|cff0070DE[T]|r"
	elseif role == "HEALER" then
		return "|cff00CC12[H]|r"
	elseif role == "DAMAGER" then
		return "|cffFF3030[D]|r"
	end
end
oUF.Tags.Events["LFD"] = "PLAYER_ROLES_ASSIGNED GROUP_ROSTER_UPDATE"

oUF.Tags.Methods["AltPower"] = function(unit)
	local min = UnitPower(unit, ALTERNATE_POWER_INDEX)
	local max = UnitPowerMax(unit, ALTERNATE_POWER_INDEX)
	if max > 0 and not UnitIsDeadOrGhost(unit) then
		return ("%s%%"):format(math.floor(min / max * 100 + 0.5))
	end
end
oUF.Tags.Events["AltPower"] = "UNIT_POWER_UPDATE"

oUF.Tags.Methods["IncHeal"] = function(unit)
	local incheal = UnitGetIncomingHeals(unit) or 0
	local player = UnitGetIncomingHeals(unit, "player") or 0
	incheal = incheal - player
	if incheal > 0 then
		return "|cff00FF00+"..T.ShortValue(incheal).."|r"
	end
end
oUF.Tags.Events["IncHeal"] = "UNIT_HEAL_PREDICTION"

oUF.Tags.Methods["NameplateLevel"] = function(unit)
	local level = UnitLevel(unit)
	local c = UnitClassification(unit)
	if UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) then
		level = UnitBattlePetLevel(unit)
	end

	if level == T.level and c == "normal" then return end
	if level > 0 then
		return level
	else
		return "??"
	end
end
oUF.Tags.Events["NameplateLevel"] = "UNIT_LEVEL PLAYER_LEVEL_UP"

oUF.Tags.Methods["NameplateNameColor"] = function(unit)
	local reaction = UnitReaction(unit, "player")
	if not UnitIsUnit("player", unit) and UnitIsPlayer(unit) and (reaction and reaction >= 5) then
		local c = T.oUF_colors.power["MANA"]
		return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
	elseif UnitIsPlayer(unit) then
		return _TAGS["raidcolor"](unit)
	elseif reaction then
		local c = T.oUF_colors.reaction[reaction]
		return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
	else
		r, g, b = 0.33, 0.59, 0.33
		return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
	end
end
oUF.Tags.Events["NameplateNameColor"] = "UNIT_POWER_UPDATE UNIT_FLAGS"

oUF.Tags.Methods["NameplateHealth"] = function(unit)
	local hp = UnitHealth(unit)
	local maxhp = UnitHealthMax(unit)

	local hpRMH, maxhpRMH
	if T.classic and IsAddOnLoaded("RealMobHealth") then
		hpRMH, maxhpRMH = RealMobHealth.GetHealth(unit, true)

		if hpRMH and maxhpRMH then
			hp, maxhp = hpRMH, maxhpRMH
		end
	end

	if maxhp == 0 then
		return 0
	else
		return ("%s - %d%%"):format(T.ShortValue(hp), hp / maxhp * 100 + 0.5)
	end
end
oUF.Tags.Events["NameplateHealth"] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH NAME_PLATE_UNIT_ADDED"

oUF.Tags.Methods["Absorbs"] = function(unit)
    local absorb = UnitGetTotalAbsorbs(unit)
    if absorb and absorb > 0 then
        return T.ShortValue(absorb)
    end
end
oUF.Tags.Events["Absorbs"] = "UNIT_ABSORB_AMOUNT_CHANGED"

if T.classic and IsAddOnLoaded("RealMobHealth") then
	oUF.Tags.Methods["curhp"] = function(unit)
		local hp = UnitHealth(unit)
		local hpRMH, maxhpRMH = RealMobHealth.GetHealth(unit, true)

		if hpRMH and maxhpRMH then
			hp = hpRMH
		end

		return hp
	end
	oUF.Tags.Events["curhp"] = "UNIT_HEALTH UNIT_MAXHEALTH"

	oUF.Tags.Methods["maxhp"] = function(unit)
		local maxhp = UnitHealthMax(unit)
		local hpRMH, maxhpRMH = RealMobHealth.GetHealth(unit, true)

		if hpRMH and maxhpRMH then
			maxhp = maxhpRMH
		end

		return maxhp
	end
	oUF.Tags.Events["maxhp"] = "UNIT_MAXHEALTH"

	oUF.Tags.Methods["missinghp"] = function(unit)
		local hp, maxhp = UnitHealth(unit), UnitHealthMax(unit)
		local hpRMH, maxhpRMH = RealMobHealth.GetHealth(unit, true)

		if hpRMH and maxhpRMH then
			hp, maxhp = hpRMH, maxhpRMH
		end

		local current = maxhp - hp
		if current > 0 then
			return current
		end
	end
	oUF.Tags.Events["missinghp"] = "UNIT_HEALTH UNIT_MAXHEALTH"

	oUF.Tags.Methods["perhp"] = function(unit)
		local hp, maxhp = UnitHealth(unit), UnitHealthMax(unit)
		local hpRMH, maxhpRMH = RealMobHealth.GetHealth(unit, true)

		if hpRMH and maxhpRMH then
			hp, maxhp = hpRMH, maxhpRMH
		end

		if maxhp == 0 then
			return 0
		else
			return math.floor(hp / maxhp * 100 + 0.5)
		end
	end
	oUF.Tags.Events["perhp"] = "UNIT_HEALTH UNIT_MAXHEALTH"
end