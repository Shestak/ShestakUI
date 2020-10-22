local _, ns = ...
local oUF = ns.oUF
local Private = oUF.Private

local unitSelectionType = Private.unitSelectionType

-- sourced from FrameXML/UnitPowerBarAlt.lua
local ALTERNATE_POWER_INDEX = Enum.PowerType.Alternate or 10
local ALTERNATE_POWER_NAME = 'ALTERNATE'

local function updateTooltip(self)
	local name, tooltip = GetUnitPowerBarStringsByID(self.__barID)
	GameTooltip:SetText(name or '', 1, 1, 1)
	GameTooltip:AddLine(tooltip or '', nil, nil, nil, true)
	GameTooltip:Show()
end

local function onEnter(self)
	if(not self:IsVisible()) then return end

	GameTooltip_SetDefaultAnchor(GameTooltip, self)
	self:UpdateTooltip()
end

local function onLeave()
	GameTooltip:Hide()
end

local function UpdateColor(self, event, unit, powerType)
	if(self.unit ~= unit or powerType ~= ALTERNATE_POWER_NAME) then return end
	local element = self.AlternativePower

	local r, g, b, t
	if(element.colorThreat and not UnitPlayerControlled(unit) and UnitThreatSituation('player', unit)) then
		t =  self.colors.threat[UnitThreatSituation('player', unit)]
	elseif(element.colorPower) then
		t = self.colors.power[ALTERNATE_POWER_INDEX]
	elseif(element.colorClass and UnitIsPlayer(unit))
		or (element.colorClassNPC and not UnitIsPlayer(unit)) then
		local _, class = UnitClass(unit)
		t = self.colors.class[class]
	elseif(element.colorSelection and unitSelectionType(unit, element.considerSelectionInCombatHostile)) then
		t = self.colors.selection[unitSelectionType(unit, element.considerSelectionInCombatHostile)]
	elseif(element.colorReaction and UnitReaction(unit, 'player')) then
		t = self.colors.reaction[UnitReaction(unit, 'player')]
	elseif(element.colorSmooth) then
		local adjust = 0 - (element.min or 0)
		r, g, b = self:ColorGradient((element.cur or 1) + adjust, (element.max or 1) + adjust, unpack(element.smoothGradient or self.colors.smooth))
	end

	if(t) then
		r, g, b = t[1], t[2], t[3]
	end

	if(b) then
		element:SetStatusBarColor(r, g, b)

		local bg = element.bg
		if(bg) then
			local mu = bg.multiplier or 1
			bg:SetVertexColor(r * mu, g * mu, b * mu)
		end
	end

	--[[ Callback: AlternativePower:PostUpdateColor(unit, r, g, b)
	Called after the element color has been updated.

	* self - the AlternativePower element
	* unit - the unit for which the update has been triggered (string)
	* r    - the red component of the used color (number)[0-1]
	* g    - the green component of the used color (number)[0-1]
	* b    - the blue component of the used color (number)[0-1]
	--]]
	if(element.PostUpdateColor) then
		element:PostUpdateColor(unit, r, g, b)
	end
end

local function Update(self, event, unit, powerType)
	if(self.unit ~= unit or powerType ~= ALTERNATE_POWER_NAME) then return end
	local element = self.AlternativePower

	--[[ Callback: AlternativePower:PreUpdate()
	Called before the element has been updated.

	* self - the AlternativePower element
	--]]
	if(element.PreUpdate) then
		element:PreUpdate()
	end

	local cur, max, min
	local barInfo = element.__barInfo
	if(barInfo) then
		cur = UnitPower(unit, ALTERNATE_POWER_INDEX)
		max = UnitPowerMax(unit, ALTERNATE_POWER_INDEX)
		min = barInfo.minPower
		element:SetMinMaxValues(min, max)
		element:SetValue(cur)
	end

	element.cur = cur
	element.min = min
	element.max = max

	--[[ Callback: AlternativePower:PostUpdate(unit, cur, min, max)
	Called after the element has been updated.

	* self - the AlternativePower element
	* unit - the unit for which the update has been triggered (string)
	* cur  - the current value of the unit's alternative power (number?)
	* min  - the minimum value of the unit's alternative power (number?)
	* max  - the maximum value of the unit's alternative power (number?)
	--]]
	if(element.PostUpdate) then
		return element:PostUpdate(unit, cur, min, max)
	end
end

local function Path(self, ...)
	--[[ Override: AlternativePower.Override(self, event, unit, ...)
	Used to completely override the element's update process.

	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event (string)
	* ...   - the arguments accompanying the event
	--]]
	(self.AlternativePower.Override or Update) (self, ...);

	--[[ Override: AlternativePower.UpdateColor(self, event, unit, ...)
	Used to completely override the internal function for updating the widgets' colors.

	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event (string)
	* ...   - the arguments accompanying the event
	--]]
	(self.AlternativePower.UpdateColor or UpdateColor) (self, ...)
end

local function Visibility(self, event, unit)
	if(unit ~= self.unit) then return end
	local element = self.AlternativePower

	local barID = UnitPowerBarID(unit)
	local barInfo = GetUnitPowerBarInfoByID(barID)
	element.__barID = barID
	element.__barInfo = barInfo
	if(barInfo and (barInfo.showOnRaid and (UnitInParty(unit) or UnitInRaid(unit))
		or not barInfo.hideFromOthers
		or UnitIsUnit(unit, 'player')))
	then
		self:RegisterEvent('UNIT_POWER_UPDATE', Path)
		self:RegisterEvent('UNIT_MAXPOWER', Path)

		element:Show()
		Path(self, event, unit, ALTERNATE_POWER_NAME)
	else
		self:UnregisterEvent('UNIT_POWER_UPDATE', Path)
		self:UnregisterEvent('UNIT_MAXPOWER', Path)

		element:Hide()
		Path(self, event, unit, ALTERNATE_POWER_NAME)
	end
end

local function VisibilityPath(self, ...)
	--[[ Override: AlternativePower.OverrideVisibility(self, event, unit)
	Used to completely override the element's visibility update process.

	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event (string)
	--]]
	return (self.AlternativePower.OverrideVisibility or Visibility) (self, ...)
end

local function ForceUpdate(element)
	return VisibilityPath(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self, unit)
	local element = self.AlternativePower
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER_BAR_SHOW', VisibilityPath)
		self:RegisterEvent('UNIT_POWER_BAR_HIDE', VisibilityPath)

		if(element:IsObjectType('StatusBar') and not (element:GetStatusBarTexture() or element:GetStatusBarAtlas())) then
			element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end

		if(element:IsMouseEnabled()) then
			if(not element:GetScript('OnEnter')) then
				element:SetScript('OnEnter', onEnter)
			end

			if(not element:GetScript('OnLeave')) then
				element:SetScript('OnLeave', onLeave)
			end

			--[[ Override: AlternativePower:UpdateTooltip()
			Called when the mouse is over the widget. Used to populate its tooltip.

			* self - the AlternativePower element
			--]]
			if(not element.UpdateTooltip) then
				element.UpdateTooltip = updateTooltip
			end
		end

		if(unit == 'player') then
			PlayerPowerBarAlt:UnregisterEvent('UNIT_POWER_BAR_SHOW')
			PlayerPowerBarAlt:UnregisterEvent('UNIT_POWER_BAR_HIDE')
			PlayerPowerBarAlt:UnregisterEvent('PLAYER_ENTERING_WORLD')
		end

		return true
	end
end

local function Disable(self, unit)
	local element = self.AlternativePower
	if(element) then
		element:Hide()

		self:UnregisterEvent('UNIT_POWER_BAR_SHOW', VisibilityPath)
		self:UnregisterEvent('UNIT_POWER_BAR_HIDE', VisibilityPath)

		if(unit == 'player') then
			PlayerPowerBarAlt:RegisterEvent('UNIT_POWER_BAR_SHOW')
			PlayerPowerBarAlt:RegisterEvent('UNIT_POWER_BAR_HIDE')
			PlayerPowerBarAlt:RegisterEvent('PLAYER_ENTERING_WORLD')
		end
	end
end

oUF:AddElement('AlternativePower', VisibilityPath, Enable, Disable)
