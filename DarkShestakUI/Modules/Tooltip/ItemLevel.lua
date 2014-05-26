local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.average_lvl ~= true then return end

----------------------------------------------------------------------------------------
--	Equipped average item level(EquippedItemLevel by Villiv)
----------------------------------------------------------------------------------------
-- Additional strings
local WAITING = CONTINUED
local PENDING = CONTINUED..CONTINUED

local upgrades = {
	["1"] = 8, ["373"] = 4, ["374"] = 8, ["375"] = 4, ["376"] = 4, ["377"] = 4,
	["379"] = 4, ["380"] = 4, ["446"] = 4, ["447"] = 8, ["452"] = 8, ["454"] = 4,
	["455"] = 8, ["457"] = 8, ["459"] = 4, ["460"] = 8, ["461"] = 12, ["462"] = 16,
	["466"] = 4, ["467"] = 8, ["469"] = 4, ["470"] = 8, ["471"] = 12, ["472"] = 16,
	["477"] = 4, ["478"] = 8, ["480"] = 8, ["492"] = 4, ["493"] = 8, ["495"] = 4,
	["496"] = 8, ["497"] = 12, ["498"] = 16, ["504"] = 12, ["505"] = 16, ["506"] = 20,
	["507"] = 24
}
-- Output prefix
local PREFIX = STAT_FORMAT:format(STAT_AVERAGE_ITEM_LEVEL).."|Heqppditmlvl|h |h"..HIGHLIGHT_FONT_COLOR_CODE

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...) return self[event](self, event, ...)end)
f:Hide()

local playerGUID, inCombat, updateTimer
local currentUnit, currentGUID
local isDelayed, isForced, isNotified, isReady

local function GetTipUnit()
	local _, unit = GameTooltip:GetUnit()
	if not unit then
		local mouseFocus = GetMouseFocus()
		unit = mouseFocus and (mouseFocus.unit or mouseFocus:GetAttribute("unit"))
	end

	return unit and UnitIsPlayer(unit) and unit
end

local SetTipText
do
	local function search(line, numLines)
		if line > numLines then return end

		local fontString = _G["GameTooltipTextLeft"..line]
		local stringText = fontString and fontString:GetText()
		if stringText and stringText:match(PREFIX) then
			return fontString
		end

		return search(line + 1, numLines)
	end

	function SetTipText(text)
		if not text then return end

		local fontString = search(1, GameTooltip:NumLines())
		if fontString then
			fontString:SetText(PREFIX..text)
		else
			GameTooltip:AddLine(PREFIX..text)
		end

		return GameTooltip:Show()
	end
end

local CanSafeInspect
do
	local limit, period = 6, 11
	local count, startTime = 0, 0

	hooksecurefunc("NotifyInspect", function()
		local currentTime = GetTime()
		if currentTime - startTime > period then
			count, startTime = 1, currentTime
			return
		end

		count = count + 1
	end)

	function CanSafeInspect(unit)
		if not CanInspect(unit) or InspectFrame and InspectFrame:IsShown() or Examiner and Examiner:IsShown() then return end

		local pending = count > limit and period - (GetTime() - startTime)
		return true, pending and pending > 0 and pending
	end
end

local UnitItemLevel
do
	local formatString = "%.0f"

	local function scan(unit, slot, total, count, twoHanded, incomplete)
		if slot > INVSLOT_LAST_EQUIPPED then
			return formatString:format(total / (twoHanded and count - 1 or count)), incomplete
		end

		if slot == INVSLOT_BODY or slot == INVSLOT_RANGED or slot == INVSLOT_TABARD then
			return scan(unit, slot + 1, total, count, twoHanded, incomplete)
		end

		local hasItem = GetInventoryItemTexture(unit, slot) and true
		local _, level, equipLoc

		local link = hasItem and GetInventoryItemLink(unit, slot)
		if link then
			repeat
				_, _, _, level, _, _, _, _, equipLoc = GetItemInfo(link)
				if level and level >= 458 then
					local upgrade = link:match(":(%d+)\124h%[")
					if (upgrade and upgrades[upgrade]) then
						level = level + upgrades[upgrade]
					end
				end
			until level and equipLoc

			total = total + level
		end

		-- Two-handed weapon and Titan's Grip
		if slot == INVSLOT_MAINHAND then
			twoHanded = equipLoc == "INVTYPE_2HWEAPON" and 1 or equipLoc == "INVTYPE_RANGED" and 1 or equipLoc == "INVTYPE_RANGEDRIGHT" and 1 or not hasItem and 0
		elseif slot == INVSLOT_OFFHAND then
			twoHanded = twoHanded == 1 and not hasItem or twoHanded == 0 and equipLoc == "INVTYPE_2HWEAPON"
		end

		local failed = hasItem and not link
		return scan(unit, slot + 1, total, failed and count or count + 1, twoHanded, incomplete or failed)
	end

	function UnitItemLevel(unit)
		if unit == "player" or UnitIsUnit(unit, "player") then
			local _, level = GetAverageItemLevel()
			return formatString:format(level)
		end

		return scan(unit, INVSLOT_FIRST_EQUIPPED, 0, 0)
	end
end

local UpdateItemLevel
do
	local cache = {}
	local cachedLevel

	local function update(unit, guid)
		local level, incomplete = UnitItemLevel(unit)
		local myLevel = level - UnitItemLevel("player")

		if incomplete then
			updateTimer = TOOLTIP_UPDATE_TIME
			f:Show()
			level = cachedLevel or level
			return SetTipText(WAITING and level..WAITING or level)
		end

		if isReady then
			cache[guid] = level
			return SetTipText(level.." ("..((myLevel > 0) and "|cff00ff00+" or "|cffff0000")..myLevel.."|r|cffffffff)|r")
		end

		level = cachedLevel or level
		return SetTipText(WAITING and level..WAITING or level)
	end

	function UpdateItemLevel()
		cachedLevel = cache[currentGUID]

		if inCombat then
			return SetTipText(cachedLevel)
		end

		if isReady then
			return update(currentUnit, currentGUID)
		end

		if not isForced and cachedLevel then
			return SetTipText(cachedLevel)
		end

		if currentGUID == playerGUID then
			local level = UnitItemLevel("player")
			cache[playerGUID] = level
			return SetTipText(level)
		end

		local canInspect, pending = CanSafeInspect(currentUnit)
		if not canInspect then
			return SetTipText(cachedLevel)
		end

		if pending then
			updateTimer = pending
			f:Show()
			return SetTipText(cachedLevel and cachedLevel..PENDING or PENDING)
		end

		if not isDelayed then
			isDelayed = true
			updateTimer = TOOLTIP_UPDATE_TIME
			f:Show()
			return SetTipText(cachedLevel and (WAITING and cachedLevel..WAITING or cachedLevel) or PENDING)
		end

		if not isNotified then
			isNotified = true
			NotifyInspect(currentUnit)
		end

		return update(currentUnit, currentGUID)
	end
end

local function OnTooltipSetUnit()
	currentUnit, currentGUID, isDelayed, isForced, isNotified, isReady = GetTipUnit(), nil, nil, nil, nil, nil
	if not currentUnit then return end

	currentGUID, isForced = UnitGUID(currentUnit), UnitIsUnit(currentUnit, "target")

	return UpdateItemLevel()
end
GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)

f:SetScript("OnUpdate", function(self, elapsed)
	updateTimer = updateTimer - elapsed
	if updateTimer > 0 then return end
	self:Hide()

	if not currentGUID then return end

	local tipUnit = GetTipUnit()
	if not tipUnit or UnitGUID(tipUnit) ~= currentGUID then return end

	return UpdateItemLevel()
end)

function f:INSPECT_READY(_, guid)
	if not currentGUID or guid ~= currentGUID then return end

	local tipUnit = GetTipUnit()
	if not tipUnit or UnitGUID(tipUnit) ~= currentGUID then return end

	isReady = true

	return UpdateItemLevel()
end
f:RegisterEvent("INSPECT_READY")

function f:UNIT_INVENTORY_CHANGED(_, unit)
	if not currentGUID or UnitGUID(unit) ~= currentGUID then return end

	local tipUnit = GetTipUnit()
	if not tipUnit or UnitGUID(tipUnit) ~= currentGUID then return end

	isForced, isNotified, isReady = true, nil, nil

	return UpdateItemLevel()
end
f:RegisterEvent("UNIT_INVENTORY_CHANGED")

function f:PLAYER_TARGET_CHANGED()
	return self:UNIT_INVENTORY_CHANGED(nil, "target")
end
f:RegisterEvent("PLAYER_TARGET_CHANGED")

function f:PLAYER_REGEN_DISABLED()
	inCombat = true
end
f:RegisterEvent("PLAYER_REGEN_DISABLED")

function f:PLAYER_REGEN_ENABLED()
	inCombat = nil
end
f:RegisterEvent("PLAYER_REGEN_ENABLED")

function f:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil

	playerGUID = UnitGUID("player")
end

if IsLoggedIn() then
	f:PLAYER_LOGIN()
	inCombat = InCombatLockdown()
	return OnTooltipSetUnit()
end

return f:RegisterEvent("PLAYER_LOGIN")