local _, ns = ...
local oUF = ns.oUF

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	local element = self.ResurrectIndicator

	--[[ Callback: ResurrectIndicator:PreUpdate()
	Called before the element has been updated.

	* self - the ResurrectIndicator element
	--]]
	if(element.PreUpdate) then
		element:PreUpdate()
	end

	local incomingResurrect = UnitHasIncomingResurrection(unit)
	if(incomingResurrect) then
		element:Show()
	else
		element:Hide()
	end

	--[[ Callback: ResurrectIndicator:PostUpdate(incomingResurrect)
	Called after the element has been updated.

	* self              - the ResurrectIndicator element
	* incomingResurrect - indicates if the unit has an incoming resurrection (boolean)
	--]]
	if(element.PostUpdate) then
		return element:PostUpdate(incomingResurrect)
	end
end

local function Path(self, ...)
	--[[ Override: ResurrectIndicator.Override(self, event, ...)
	Used to completely override the internal update function.

	* self  - the parent object
	* event - the event triggering the update (string)
	* ...   - the arguments accompanying the event
	--]]
	return (self.ResurrectIndicator.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	local element = self.ResurrectIndicator
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('INCOMING_RESURRECT_CHANGED', Path)

		if(element:IsObjectType('Texture') and not element:GetTexture()) then
			element:SetTexture([[Interface\RaidFrame\Raid-Icon-Rez]])
		end

		return true
	end
end

local function Disable(self)
	local element = self.ResurrectIndicator
	if(element) then
		element:Hide()

		self:UnregisterEvent('INCOMING_RESURRECT_CHANGED', Path)
	end
end

oUF:AddElement('ResurrectIndicator', Path, Enable, Disable)
