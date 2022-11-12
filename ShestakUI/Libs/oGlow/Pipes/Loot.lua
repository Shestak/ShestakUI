local T, C, L, _ = unpack(select(2, ...))
if C.loot.lootframe == true then return end

local hook
local _E

local update = function(self)
	local slot = self:GetSlotIndex()
	local slotFrame = self.Item

	local itemLink
	if slot then
		itemLink = GetLootSlotLink(slot)
	end

	oGlow:CallFilters("loot", slotFrame, _E and itemLink)
end

local enable = function(self)
	_E = true

	if not hook then
		hooksecurefunc(LootFrameElementMixin, "Init", update)

		hook = true
	end
end

local disable = function(self)
	_E = nil
end

oGlow:RegisterPipe("loot", enable, disable, update, "Loot frame")