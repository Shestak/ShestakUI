local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.tooltip.enable ~= true or C.tooltip.average_lvl ~= true then return end

----------------------------------------------------------------------------------------
--	Average item level (AiL by havoc74)
----------------------------------------------------------------------------------------
local MINCOLOR, COLORINC, INCMOD, MinIL, MaxIL = 0.5, 0.2, 0.5, 95, 195

local slotName = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "WristSlot",
	"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot",
	"Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot"
}

local function GetAiL(unit)
	local i, total, slot, itn, level = 0, 0, nil, 0

	for i in pairs(slotName) do
		slot = GetInventoryItemLink(unit, GetInventorySlotInfo(slotName[i]))
		if slot ~= nil then
			itn = itn + 1
			level = select(4, GetItemInfo(slot))
			total = total + level
		end
	end

	if total < 1 or itn < 1 then return 0 end

	return floor(total / itn)
end

local function GetAiLColor(ail)
	local r, gb

	if ail < MinIL then
		r = (ail / MinIL)
		gb = r
	else
		r = MINCOLOR + ((ail / MaxIL) * INCMOD)
		gb = 1 - ((ail / MaxIL) * INCMOD)
	end

	if r < MINCOLOR then
		r = MINCOLOR
		gb = r
	end

	return r, gb
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	local ail, r, gb, d
	local _, unit = GameTooltip:GetUnit()

	if not UnitIsPlayer(unit) then return end

	if unit and CanInspect(unit) then
		local isInspectOpen = (InspectFrame and InspectFrame:IsShown()) or (Examiner and Examiner:IsShown())
		if unit and CanInspect(unit) and not isInspectOpen then
			NotifyInspect(unit)
			ail = GetAiL(unit)
			d = GetAiL(unit) - GetAiL("player")
			r, gb = GetAiLColor(ail)
			-- ClearInspectPlayer(unit) -- Seems to cause issues in Classic
			if unit == "player" then
				GameTooltip:AddLine(format("|cfffed100"..STAT_AVERAGE_ITEM_LEVEL..":|r "..ail), r, gb, gb)
			else
				GameTooltip:AddLine(format("|cfffed100"..STAT_AVERAGE_ITEM_LEVEL..":|r "..ail).." ("..((d > 0) and "|cff00ff00+" or "|cffff0000")..d.."|r)", r, gb, gb)
			end
			GameTooltip:Show()
		end
	end
end)