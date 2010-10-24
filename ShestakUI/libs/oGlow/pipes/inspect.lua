-- TODO:
--  - Clean up the dupe code.
--  - Write a description.
-- we might want to merge this with char.lua...

if(select(4, GetAddOnInfo("Fizzle"))) then return end

local hook
local slots = {
	"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist",
	"Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand",
	"SecondaryHand", "Ranged", "Tabard",
}

local update = function(self)
	if(not InspectFrame or not InspectFrame:IsShown() or not oGlow:IsPipeEnabled'inspect') then return end

	local unit = InspectFrame.unit
	for i, slotName in next, slots do
		local itemLink = GetInventoryItemLink(unit, i)
		local inspectSlot = _G["Inspect"..slotName.."Slot"]

		oGlow:CallFilters('inspect', inspectSlot, itemLink)
	end
end

local UNIT_INVENTORY_CHANGED = function(self, event, unit)
	if(InspectFrame.unit == unit) then
		update(self)
	end
end

local function ADDON_LOADED(self, event, addon)
	if(addon == "Blizzard_InspectUI") then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", update)
		self:RegisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)

		if(not hook) then
			InspectFrame:HookScript('OnShow', update)
		end

		self:UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local enable = function(self)
	if(IsAddOnLoaded("Blizzard_InspectUI")) then
		self:RegisterEvent('PLAYER_TARGET_CHANGED', update)
		self:RegisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)

		if(not hook) then
			InspectFrame:HookScript('OnShow', update)
		end
	else
		self:RegisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local disable = function(self)
	self:UnregisterEvent('ADDON_LOADED', ADDON_LOADED)
	self:UnregisterEvent('PLAYER_TARGET_CHANGED', update)
	self:UnregisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)

	if(not InspectFrame) then return end
	
	for i, slotName in next, slots do
		oGlow:CallFilters('inspect', _G["Inspect"..slotName.."Slot"])
	end
end

oGlow:RegisterPipe('inspect', enable, disable, update, 'Inspect frame', nil)
