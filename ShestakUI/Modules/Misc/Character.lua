----------------------------------------------------------------------------------------
-- Taken from DejaStats, adjusted for ShestakUI
----------------------------------------------------------------------------------------
local statPanel = CreateFrame("Frame", nil, CharacterFrameInsetRight)
statPanel:SetSize(200, 350)
statPanel:SetPoint("TOP", 0, -5)
local scrollFrame = CreateFrame("ScrollFrame", nil, statPanel, "UIPanelScrollFrameTemplate")
scrollFrame:SetAllPoints()
local stat = CreateFrame("Frame", nil, scrollFrame)
stat:SetSize(200, 1)
scrollFrame:SetScrollChild(stat)
CharacterStatsPane:ClearAllPoints()
CharacterStatsPane:SetParent(stat)
CharacterStatsPane:SetAllPoints(stat)

-- Change default data
PAPERDOLL_STATCATEGORIES = {
	[1] = {
		categoryFrame = "AttributesCategory",
		stats = {
			[1] = { stat = "STRENGTH", primary = LE_UNIT_STAT_STRENGTH },
			[2] = { stat = "AGILITY", primary = LE_UNIT_STAT_AGILITY },
			[3] = { stat = "INTELLECT", primary = LE_UNIT_STAT_INTELLECT },
			[4] = { stat = "STAMINA" },
			[5] = { stat = "ARMOR" },
			[6] = { stat = "ATTACK_DAMAGE", primary = LE_UNIT_STAT_STRENGTH, roles = { "TANK", "DAMAGER" } },
			[7] = { stat = "ATTACK_DAMAGE", primary = LE_UNIT_STAT_AGILITY, roles = { "TANK", "DAMAGER" } },
			[8] = { stat = "SPELLPOWER", hideAt = 0, primary = LE_UNIT_STAT_INTELLECT },
			[9] = { stat = "MANAREGEN", hideAt = 0, primary = LE_UNIT_STAT_INTELLECT },
			[10] = { stat = "ENERGY_REGEN", hideAt = 0, primary = LE_UNIT_STAT_AGILITY },
			[11] = { stat = "RUNE_REGEN", hideAt = 0, primary = LE_UNIT_STAT_STRENGTH },
			[12] = { stat = "FOCUS_REGEN", hideAt = 0, primary = LE_UNIT_STAT_AGILITY },
			[13] = { stat = "MOVESPEED" },
		},
	},
	[2] = {
		categoryFrame = "EnhancementsCategory",
		stats = {
			[1] = { stat = "CRITCHANCE", hideAt = 0 },
			[2] = { stat = "HASTE", hideAt = 0 },
			[3] = { stat = "MASTERY", hideAt = 0 },
			[4] = { stat = "VERSATILITY", hideAt = 0 },
			[5] = { stat = "LIFESTEAL", hideAt = 0 },
			[6] = { stat = "AVOIDANCE", hideAt = 0 },
			[7] = { stat = "DODGE", hideAt = 0, roles = { "TANK" } },
			[8] = { stat = "PARRY", hideAt = 0, roles = { "TANK" } },
			[9] = { stat = "BLOCK", hideAt = 0, roles = { "TANK" } },
		},
	},
}

PAPERDOLL_STATINFO["ENERGY_REGEN"].updateFunc = function(statFrame, unit)
	statFrame.numericValue = 0
	PaperDollFrame_SetEnergyRegen(statFrame, unit)
end

PAPERDOLL_STATINFO["RUNE_REGEN"].updateFunc = function(statFrame, unit)
	statFrame.numericValue = 0
	PaperDollFrame_SetRuneRegen(statFrame, unit)
end

PAPERDOLL_STATINFO["FOCUS_REGEN"].updateFunc = function(statFrame, unit)
	statFrame.numericValue = 0
	PaperDollFrame_SetFocusRegen(statFrame, unit)
end

-- Fix Movespeed
PAPERDOLL_STATINFO["MOVESPEED"].updateFunc = function(statFrame, unit)
	PaperDollFrame_SetMovementSpeed(statFrame, unit)
end

function PaperDollFrame_SetMovementSpeed(statFrame, unit)
	statFrame.wasSwimming = nil
	statFrame.unit = unit
	MovementSpeed_OnUpdate(statFrame)
	statFrame.onEnterFunc = MovementSpeed_OnEnter
	statFrame:Show()
end