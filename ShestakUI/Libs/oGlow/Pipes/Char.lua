if IsAddOnLoaded("Fizzle") then return end

local _E
local hook
local slots = {
	"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands",
	"Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand", "SecondaryHand", [19] = "Tabard"
}

local update = function(self)
	if CharacterFrame:IsShown() then
		for key, slotName in pairs(slots) do
			local slotFrame = _G["Character"..slotName.."Slot"]
			local slotLink = GetInventoryItemLink("player", key)

			oGlow:CallFilters("char", slotFrame, _E and slotLink)
		end
	end
end

local PLAYER_EQUIPMENT_CHANGED = function(self)
	update(self)
end

local enable = function(self)
	_E = true

	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", PLAYER_EQUIPMENT_CHANGED)

	if not hook then
		hook = function(...)
			if _E then return update(...) end
		end

		CharacterFrame:HookScript("OnShow", hook)
	end
end

local disable = function(self)
	_E = nil
	self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED", PLAYER_EQUIPMENT_CHANGED)
end

oGlow:RegisterPipe("char", enable, disable, update, "Character frame")