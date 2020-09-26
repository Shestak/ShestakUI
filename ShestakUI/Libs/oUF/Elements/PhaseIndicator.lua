local _, ns = ...
local oUF = ns.oUF

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	local element = self.PhaseIndicator

	--[[ Callback: PhaseIndicator:PreUpdate()
	Called before the element has been updated.

	* self - the PhaseIndicator element
	--]]
	if(element.PreUpdate) then
		element:PreUpdate()
	end

	local isInSamePhase = not UnitPhaseReason(unit)
	if(not isInSamePhase and UnitIsPlayer(unit) and UnitIsConnected(unit)) then
		element:Show()
	else
		element:Hide()
	end

	--[[ Callback: PhaseIndicator:PostUpdate(isInSamePhase)
	Called after the element has been updated.

	* self          - the PhaseIndicator element
	* isInSamePhase - indicates whether the unit is in the same phase as the player (boolean)
	--]]
	if(element.PostUpdate) then
		return element:PostUpdate(isInSamePhase)
	end
end

local function Path(self, ...)
	--[[ Override: PhaseIndicator.Override(self, event, ...)
	Used to completely override the internal update function.

	* self  - the parent object
	* event - the event triggering the update (string)
	* ...   - the arguments accompanying the event
	--]]
	return (self.PhaseIndicator.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	local element = self.PhaseIndicator
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_PHASE', Path)

		if(element:IsObjectType('Texture') and not element:GetTexture()) then
			element:SetTexture([[Interface\TargetingFrame\UI-PhasingIcon]])
		end

		return true
	end
end

local function Disable(self)
	local element = self.PhaseIndicator
	if(element) then
		element:Hide()

		self:UnregisterEvent('UNIT_PHASE', Path)
	end
end

oUF:AddElement('PhaseIndicator', Path, Enable, Disable)