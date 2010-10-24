-- TODO:
--  - Clean up the dupe code.
--  - Write a description.

if(select(4, GetAddOnInfo("Fizzle"))) then return end

local hook
local slots = {
	"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist",
	"Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand",
	"SecondaryHand", "Ranged", "Tabard",
}

local update = function(self)
	if(CharacterFrame:IsShown() and oGlow:IsPipeEnabled'char') then
		for key, slotName in ipairs(slots) do
			-- Ammo is located at 0.
			local slotID = key % 20
			local slotFrame = _G['Character' .. slotName .. 'Slot']
			local slotLink = GetInventoryItemLink('player', slotID)

			oGlow:CallFilters('char', slotFrame, slotLink)
		end
	end
end

local UNIT_INVENTORY_CHANGED = function(self, event, unit)
	if(unit == 'player') then
		update(self)
	end
end

local enable = function(self)
	self:RegisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)

	if(not hook) then
		CharacterFrame:HookScript('OnShow', update)
		hook = true
	end
end

local disable = function(self)
	self:UnregisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)

	for key, slotName in ipairs(slots) do
		oGlow:CallFilters('char', _G['Character' .. slotName .. 'Slot'])
	end
end

oGlow:RegisterPipe('char', enable, disable, update, 'Character frame', nil)
