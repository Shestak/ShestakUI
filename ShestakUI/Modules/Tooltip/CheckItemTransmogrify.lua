local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.item_transmogrify ~= true then return end

----------------------------------------------------------------------------------------
--	Displays items can not be transmogrified(Will It Mog by Nathanyel)
----------------------------------------------------------------------------------------
-- Slots
local locs = {
	["INVTYPE_HEAD"] = 1,
	["INVTYPE_SHOULDER"] = 1,
	["INVTYPE_CHEST"] = 1,
	["INVTYPE_ROBE"] = 1,
	["INVTYPE_WAIST"] = 1,
	["INVTYPE_LEGS"] = 1,
	["INVTYPE_FEET"] = 1,
	["INVTYPE_WRIST"] = 1,
	["INVTYPE_HAND"] = 1,
	["INVTYPE_CLOAK"] = 1,
	["INVTYPE_WEAPON"] = 1,
	["INVTYPE_SHIELD"] = 1,
	["INVTYPE_2HWEAPON"] = 1,
	["INVTYPE_HOLDABLE"] = 1,
	["INVTYPE_WEAPONMAINHAND"] = 1,
	["INVTYPE_WEAPONOFFHAND"] = 1,
	["INVTYPE_RANGED"] = 1,
	["INVTYPE_THROWN"] = 1,
	["INVTYPE_RANGEDRIGHT"] = 1,
}

local WIMtooltip = function(tooltip)
	local _, link = tooltip:GetItem()
	if not link then return end
	local itemID = link:match("item:(%d+)")
	if not itemID then return end

	local rndench = link:match("item:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:([^:]+):")
	GetItemInfo(itemID)
	local _, _, quality, _, _, itemType, subType, _, slot = GetItemInfo(itemID)
	-- No weapon or armor, or misc 'weapon', or invalid slot
	if not itemType or not (itemType == ARMOR or itemType == ENCHSLOT_WEAPON) or (subType == MISCELLANEOUS and (itemType == ENCHSLOT_WEAPON or slot == "INVTYPE_CLOAK")) or not locs[slot] then return end
	local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.GetItemInfo(itemID)

	if rndench and rndench ~= "0" and noSourceReason == "NO_STATS" then
		canBeChanged = true
		canBeSource = true
	end

	if (quality < 2 or subType == MISCELLANEOUS) and not (canBeChanged or canBeSource) then return end

	if noChangeReason or noSourceReason then
		GameTooltip:AddLine(" ")
	end

	if subType == MISCELLANEOUS and itemType ~= "INVTYPE_HOLDABLE" then
		tooltip:AddLine("|cffff0000"..ERR_TRANSMOGRIFY_INVALID_ITEM_TYPE.."|r", nil, nil, nil, true)
	end

	if noChangeReason then
		tooltip:AddLine(gsub("|cffff0000"..(_G["ERR_TRANSMOGRIFY_"..noChangeReason] or ERR_TRANSMOGRIFY_INVALID_SOURCE), "%%s", ""), nil, nil, nil, true)
	end

	if noSourceReason and noSourceReason ~= noChangeReason then
		tooltip:AddLine(gsub("|cffff0000"..(_G["ERR_TRANSMOGRIFY_"..noSourceReason] or ERR_TRANSMOGRIFY_MISMATCH), "%%s", ""), nil, nil, nil, true)
	end

	tooltip:Show()
end

GameTooltip:HookScript("OnTooltipSetItem", WIMtooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", WIMtooltip)