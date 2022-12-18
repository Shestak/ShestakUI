local T, C, L, _ = unpack(select(2, ...))
if C.bag.enable == true then return end

local hook
local _E

local pipe = function(self)
	for _, button in self:EnumerateValidItems() do
		local bagID = button:GetBagID()
		local slotID = button:GetID()
		local slotLink = C_Container.GetContainerItemLink(bagID, slotID)

		oGlow:CallFilters("bags", button, _E and slotLink)
	end
end

local update = function(self)
	local frame = _G["ContainerFrame1"]
	local i = 2
	while(frame and frame.size) do
		pipe(frame)
		frame = _G["ContainerFrame"..i]
		i = i + 1
	end
end

local enable = function(self)
	_E = true

	if not hook then
		for i = 1, NUM_CONTAINER_FRAMES do
			local frame = _G["ContainerFrame"..i]
			hooksecurefunc(frame, "UpdateItems", pipe)
		end
		hooksecurefunc(ContainerFrameCombinedBags, "UpdateItems", pipe)

		hook = true
	end
end

local disable = function(self)
	_E = nil
end

oGlow:RegisterPipe("bags", enable, disable, update, "Bag containers")