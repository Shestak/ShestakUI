local T, C, L = unpack(ShestakUI)
if C.tooltip.enable ~= true or C.extra_general.item_transmogrify ~= true then return end

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

--  White items that are a source for Transmogrify
local wx = {
	[41746] = 1,
	[43600] = 1,
	[43601] = 1,
	[78340] = 1,
	[78341] = 1,
}

local WIMtooltip = function(tooltip)
	local _, link = tooltip:GetItem()
	if not link then return end

	GetItemInfo(link)
	local _, _, quality, _, _, itemType, subType, _, slot = GetItemInfo(link)
	-- No weapon or armor, or misc 'weapon', or invalid slot
	if not itemType or (quality < 2 and not wx[tonumber(link:match("item:(%d+):"))]) or not (itemType == ARMOR or itemType == ENCHSLOT_WEAPON) or (subType == MISCELLANEOUS and not slot == "INVTYPE_HOLDABLE") or not locs[slot] then return end
	local canBeChanged, noChangeReason, canBeSource, noSourceReason = GetItemTransmogrifyInfo(link)

	if not (canBeChanged or canBeSource) then return end

	if noChangeReason or noSourceReason then
		GameTooltip:AddLine(" ")
	end

	if noChangeReason then
		tooltip:AddLine(gsub(_G["ERR_TRANSMOGRIFY_"..noChangeReason] or noChangeReason, "%%s", ""), nil, nil, nil, true)
	end

	if noSourceReason and noSourceReason ~= noChangeReason then
		tooltip:AddLine(gsub(_G["ERR_TRANSMOGRIFY_"..noSourceReason] or noSourceReason, "%%s", ""), nil, nil, nil, true)
	end

	tooltip:Show()
end

GameTooltip:HookScript("OnTooltipSetItem", WIMtooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", WIMtooltip)