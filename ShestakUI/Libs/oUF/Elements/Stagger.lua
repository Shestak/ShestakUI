local parent, ns = ...
local oUF = ns.oUF

-- percentages at which the bar should change color
local STAGGER_YELLOW_TRANSITION = STAGGER_YELLOW_TRANSITION
local STAGGER_RED_TRANSITION = STAGGER_RED_TRANSITION

-- table indices of bar colors
local STAGGER_GREEN_INDEX = STAGGER_GREEN_INDEX or 1
local STAGGER_YELLOW_INDEX = STAGGER_YELLOW_INDEX or 2
local STAGGER_RED_INDEX = STAGGER_RED_INDEX or 3

local UnitHealthMax = UnitHealthMax
local UnitStagger = UnitStagger

local _, playerClass = UnitClass("player")
local color

local Update = function(self, event, unit)
	if unit and unit ~= self.unit then return end
	local element = self.Stagger

	if(element.PreUpdate) then
		element:PreUpdate()
	end

	local maxHealth = UnitHealthMax("player")
	local stagger = UnitStagger("player")
	local staggerPercent = stagger / maxHealth

	element:SetMinMaxValues(0, maxHealth)
	element:SetValue(stagger)

	if element.Text then
		element.Text:SetText(stagger)
	end

	local rgb
	if(staggerPercent >= STAGGER_RED_TRANSITION) then
		rgb = color[STAGGER_RED_INDEX]
	elseif(staggerPercent > STAGGER_YELLOW_TRANSITION) then
		rgb = color[STAGGER_YELLOW_INDEX]
	else
		rgb = color[STAGGER_GREEN_INDEX]
	end

	local r, g, b = rgb[1], rgb[2], rgb[3]
	element:SetStatusBarColor(r, g, b)

	local bg = element.bg
	if(bg) then
		local mu = bg.multiplier or 1
		bg:SetVertexColor(r * mu, g * mu, b * mu)
	end

	if(element.PostUpdate) then
		element:PostUpdate(maxHealth, stagger, staggerPercent, r, g, b)
	end
end

local Path = function(self, ...)
	return (self.Stagger.Override or Update)(self, ...)
end

local Visibility = function(self, event, unit)
	if(SPEC_MONK_BREWMASTER ~= GetSpecialization() or UnitHasVehiclePlayerFrameUI('player')) then
		if self.Stagger:IsShown() then
			if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
			self.Stagger:Hide()
			self:UnregisterEvent('UNIT_AURA', Path)
		end
	elseif not self.Stagger:IsShown() then
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
		self.Stagger:Show()
		self:RegisterEvent('UNIT_AURA', Path)
		return Path(self, event, unit)
	end
end

local VisibilityPath = function(self, ...)
	return (self.Stagger.OverrideVisibility or Visibility)(self, ...)
end

local ForceUpdate = function(element)
	return VisibilityPath(element.__owner, "ForceUpdate", element.__owner.unit)
end

local Enable = function(self, unit)
	if(playerClass ~= "MONK") then return end

	local element = self.Stagger
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate
		element:Hide()

		color = self.colors.power[BREWMASTER_POWER_BAR_NAME]

		self:RegisterEvent('UNIT_DISPLAYPOWER', VisibilityPath)
		self:RegisterEvent('PLAYER_TALENT_UPDATE', VisibilityPath, true)

		if(element:IsObjectType'StatusBar' and not element:GetStatusBarTexture()) then
			element:SetStatusBarTexture[[Interface\TargetingFrame\UI-StatusBar]]
		end

		MonkStaggerBar:UnregisterEvent'PLAYER_ENTERING_WORLD'
		MonkStaggerBar:UnregisterEvent'PLAYER_SPECIALIZATION_CHANGED'
		MonkStaggerBar:UnregisterEvent'UNIT_DISPLAYPOWER'
		MonkStaggerBar:UnregisterEvent'UPDATE_VEHICLE_ACTION_BAR'

		return true
	end
end

local Disable = function(self)
	local element = self.Stagger
	if(element) then
		element:Hide()
		self:UnregisterEvent('UNIT_AURA', Path)
		self:UnregisterEvent('UNIT_DISPLAYPOWER', VisibilityPath)
		self:UnregisterEvent('PLAYER_TALENT_UPDATE', VisibilityPath)

		MonkStaggerBar:UnregisterEvent'PLAYER_ENTERING_WORLD'
		MonkStaggerBar:UnregisterEvent'PLAYER_SPECIALIZATION_CHANGED'
		MonkStaggerBar:UnregisterEvent'UNIT_DISPLAYPOWER'
		MonkStaggerBar:UnregisterEvent'UPDATE_VEHICLE_ACTION_BAR'
	end
end

oUF:AddElement("Stagger", VisibilityPath, Enable, Disable)
