local hook

local getID = function(loc)
	local player, bank, bags, slot, bag = EquipmentManager_UnpackLocation(loc)
	if not player and not bank and not bags then return end

	if not bags then
		return GetInventoryItemID("player", slot)
	else
		return GetContainerItemID(bag, slot)
	end
end

local pipe = function(self)
	local location, id = self.location
	if location and location < PDFITEMFLYOUT_FIRST_SPECIAL_LOCATION then
		id = getID(location)
	end

	return oGlow:CallFilters("char-flyout", self, id)
end

local update = function(self)
	local buttons = PaperDollFrameItemFlyout.buttons
	for _, button in next, buttons do
		pipe(button)
	end
end

local enable = function(self)
	if not hook then
		hooksecurefunc("PaperDollFrameItemFlyout_DisplayButton", pipe)
		hook = true
	end
end

local disable = function(self)
	local buttons = PaperDollFrameItemFlyout.buttons
	for _, button in next, buttons do
		self:CallFilters("char-flyout", button)
	end
end

oGlow:RegisterPipe("char-flyout", enable, disable, update, "Character equipment flyout frame", nil)