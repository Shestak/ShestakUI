local T, C, L = unpack(select(2, ...))
if C.bag.enable == true then return end

local update = function(self)
	if BankFrame:IsShown() then
		for i = 1, NUM_BANKGENERIC_SLOTS or 28 do
			local slotFrame = _G["BankFrameItem"..i]
			local slotLink = GetContainerItemLink(-1, i)

			self:CallFilters("bank", slotFrame, slotLink)
		end
	end
end

local enable = function(self)
	self:RegisterEvent("BANKFRAME_OPENED", update)
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED", update)
end

local disable = function(self)
	self:UnregisterEvent("BANKFRAME_OPENED", update)
	self:UnregisterEvent("PLAYERBANKSLOTS_CHANGED", update)

	for i = 1, NUM_BANKGENERIC_SLOTS or 28 do
		self:CallFilters("bank", _G["BankFrameItem"..i])
	end
end

oGlow:RegisterPipe("bank", enable, disable, update, "Player bank frame", nil)