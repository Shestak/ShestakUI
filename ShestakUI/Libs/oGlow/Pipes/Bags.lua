local T, C, L = unpack(select(2, ...))
if C.bag.enable == true then return end

local hook

local pipe = function(self)
	if(oGlow:IsPipeEnabled'bags') then
		local id = self:GetID()
		local name = self:GetName()
		local size = self.size

		for i=1, size do
			local bid = size - i + 1
			local slotFrame = _G[name .. 'Item' .. bid]
			local slotLink = GetContainerItemLink(id, i)

			oGlow:CallFilters('bags', slotFrame, slotLink)
		end
	end
end

local update = function(self)
	local frame = _G['ContainerFrame1']
	local i = 2
	while(frame and frame.size) do
		pipe(frame)
		frame = _G['ContainerFrame' .. i]
		i = i + 1
	end
end

local enable = function(self)
	if(not hook) then
		hooksecurefunc("ContainerFrame_Update", pipe)
		hook = true
	end
end

local disable = function(self)
	for i=1, NUM_CONTAINER_FRAMES or 13 do
		local frame = _G['ContainerFrame' .. i]
		local size = frame.size
		if(not size) then break end

		for j=1, size do
			local bid = size - j + 1
			local slotFrame = _G[frame:GetName() .. 'Item' .. bid]

			oGlow:CallFilters('bags', slotFrame)
		end
	end
end

oGlow:RegisterPipe('bags', enable, disable, update, 'Bag containers', nil)