if (select(4, GetAddOnInfo("Fizzle"))) then return end

local _E
local slots = {
	"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist",
	"Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand",
	"SecondaryHand", "Ranged", "Tabard",
}

local _MISSING = {}
local itemInfoReceived = function()
	if not next(_MISSING) then
		return
	end

	local unit = InspectFrame.unit
	if not unit then
		table.wipe(_MISSING)
	end

	for i, slotName in next, _MISSING do
		local itemLink = GetInventoryItemLink(unit, i)
		if itemLink then
			oGlow:CallFilters("inspect", _G["Inspect"..slotName.."Slot"], _E and itemLink)

			_MISSING[i] = nil
		end
	end
end

local update = function(self)
	if not InspectFrame or not InspectFrame:IsShown() then return end

	local unit = InspectFrame.unit
	for i, slotName in next, slots do
		local itemLink = GetInventoryItemLink(unit, i)
		local itemTexture = GetInventoryItemTexture(unit, i)

		if itemTexture and not itemLink then
			GetItemInfo(GetInventoryItemID(unit, i))
			_MISSING[i] = slotName
		end

		oGlow:CallFilters("inspect", _G["Inspect"..slotName.."Slot"], _E and itemLink)
	end
end

local UNIT_INVENTORY_CHANGED = function(self, event, unit)
	if InspectFrame.unit == unit then
		update(self)
	end
end

local function ADDON_LOADED(self, event, addon)
	if addon == "Blizzard_InspectUI" then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", update)
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", UNIT_INVENTORY_CHANGED)
		self:RegisterEvent("INSPECT_READY", update)
		self:RegisterEvent("GET_ITEM_INFO_RECEIVED", itemInfoReceived)

		self:UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local enable = function(self)
	_E = true

	if IsAddOnLoaded("Blizzard_InspectUI") then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", update)
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", UNIT_INVENTORY_CHANGED)
		self:RegisterEvent("INSPECT_READY", update)
		self:RegisterEvent("GET_ITEM_INFO_RECEIVED", itemInfoReceived)
	else
		self:RegisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local disable = function(self)
	_E = nil

	self:UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
	self:UnregisterEvent("PLAYER_TARGET_CHANGED", update)
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED", UNIT_INVENTORY_CHANGED)
	self:UnregisterEvent("INSPECT_READY", update)
	self:UnregisterEvent("GET_ITEM_INFO_RECEIVED", itemInfoReceived)
end

oGlow:RegisterPipe("inspect", enable, disable, update, "Inspect frame", nil)