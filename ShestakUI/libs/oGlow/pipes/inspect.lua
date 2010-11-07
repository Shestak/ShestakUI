-- TODO:
--  - Clean up the dupe code.
--  - Write a description.
-- we might want to merge this with char.lua...

if(select(4, GetAddOnInfo("Fizzle"))) then return end

local slots = {
	"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist",
	"Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand",
	"SecondaryHand", "Ranged", "Tabard",
}

-- We need to poll until 4.0.3, or so.
local _MISSING = {}
local pollFrame = CreateFrame'Frame'
pollFrame:Hide()

local time = 3
pollFrame:SetScript('OnUpdate', function(self, elapsed)
	time = time + elapsed

	if(time >= 3) then
		local unit = InspectFrame.unit
		for i, slotName in next, _MISSING do
			local itemLink = GetInventoryItemLink(unit, i)
			if(itemLink) then
				oGlow:CallFilters('inspect', _G['Inspect' .. slotName .. 'Slot'], itemLink)

				_MISSING[i] = nil
			end
		end

		if(not next(_MISSING)) then
			self:Hide()
		end
	end
end)

local update = function(self)
	if(not InspectFrame or not InspectFrame:IsShown() or not oGlow:IsPipeEnabled'inspect') then return end

	local unit = InspectFrame.unit
	for i, slotName in next, slots do
		local itemLink = GetInventoryItemLink(unit, i)
		local itemTexture = GetInventoryItemTexture(unit, i)

		if(itemTexture and not itemLink) then
			_MISSING[i] = slotName
			pollFrame:Show()
		end

		oGlow:CallFilters('inspect', _G["Inspect"..slotName.."Slot"], itemLink)
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

		-- We should check the first argument of this event later on.
		-- Blizzard's code isn't actually updated yet, so it doesn't
		-- check if the GUID is correct, nor if the inspect is ready.
		self:RegisterEvent('INSPECT_READY', update)

		self:UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local enable = function(self)
	if(IsAddOnLoaded("Blizzard_InspectUI")) then
		self:RegisterEvent('PLAYER_TARGET_CHANGED', update)
		self:RegisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)
		self:RegisterEvent('INSPECT_READY', update)
	else
		self:RegisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local disable = function(self)
	self:UnregisterEvent('ADDON_LOADED', ADDON_LOADED)
	self:UnregisterEvent('PLAYER_TARGET_CHANGED', update)
	self:UnregisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)
	self:UnregisterEvent('INSPECT_READY', update)

	pollFrame:Hide()
	
	if(not InspectFrame) then return end
	
	for i, slotName in next, slots do
		oGlow:CallFilters('inspect', _G["Inspect"..slotName.."Slot"])
	end
end

oGlow:RegisterPipe('inspect', enable, disable, update, 'Inspect frame', nil)
