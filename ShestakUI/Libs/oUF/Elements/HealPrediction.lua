local _, ns = ...
local oUF = ns.oUF

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	local hp = self.HealPrediction
	if(hp.PreUpdate) then hp:PreUpdate(unit) end

	local myIncomingHeal = UnitGetIncomingHeals(unit, 'player') or 0
	local allIncomingHeal = UnitGetIncomingHeals(unit) or 0
	local totalAbsorb = UnitGetTotalAbsorbs(unit) or 0
	local myCurrentHealAbsorb = UnitGetTotalHealAbsorbs(unit) or 0
	local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)

	local overHealAbsorb = false
	if(health < myCurrentHealAbsorb) then
		overHealAbsorb = true
		myCurrentHealAbsorb = health
	end

	if(health - myCurrentHealAbsorb + allIncomingHeal > maxHealth * hp.maxOverflow) then
		allIncomingHeal = maxHealth * hp.maxOverflow - health + myCurrentHealAbsorb
	end

	local otherIncomingHeal = 0
	if(allIncomingHeal < myIncomingHeal) then
		myIncomingHeal = allIncomingHeal
	else
		otherIncomingHeal = allIncomingHeal - myIncomingHeal
	end

	local overAbsorb = false
	if(health - myCurrentHealAbsorb + allIncomingHeal + totalAbsorb >= maxHealth or health + totalAbsorb >= maxHealth) then
		if(totalAbsorb > 0) then
			overAbsorb = true
		end

		totalAbsorb = max(0, maxHealth - health)
	end

	if(myCurrentHealAbsorb > allIncomingHeal) then
		myCurrentHealAbsorb = myCurrentHealAbsorb - allIncomingHeal
	else
		myCurrentHealAbsorb = 0
	end

	if(hp.myBar) then
		hp.myBar:SetMinMaxValues(0, maxHealth)
		hp.myBar:SetValue(myIncomingHeal)
		hp.myBar:Show()
	end

	if(hp.otherBar) then
		hp.otherBar:SetMinMaxValues(0, maxHealth)
		hp.otherBar:SetValue(otherIncomingHeal)
		hp.otherBar:Show()
	end

	if(hp.absorbBar) then
		hp.absorbBar:SetMinMaxValues(0, maxHealth)
		hp.absorbBar:SetValue(totalAbsorb)
		hp.absorbBar:Show()
	end

	if(hp.healAbsorbBar) then
		hp.healAbsorbBar:SetMinMaxValues(0, maxHealth)
		hp.healAbsorbBar:SetValue(myCurrentHealAbsorb)
		hp.healAbsorbBar:Show()
	end

	if(hp.PostUpdate) then
		return hp:PostUpdate(unit, overAbsorb, overHealAbsorb)
	end
end

local function Path(self, ...)
	return (self.HealPrediction.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	local hp = self.HealPrediction
	if(hp) then
		hp.__owner = self
		hp.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_HEAL_PREDICTION', Path)
		self:RegisterEvent('UNIT_MAXHEALTH', Path)
		if(hp.frequentUpdates) then
			self:RegisterEvent('UNIT_HEALTH_FREQUENT', Path)
		else
			self:RegisterEvent('UNIT_HEALTH', Path)
		end
		self:RegisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
		self:RegisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)

		if(not hp.maxOverflow) then
			hp.maxOverflow = 1.05
		end

		if(hp.myBar) then
			if(hp.myBar:IsObjectType'StatusBar' and not hp.myBar:GetStatusBarTexture()) then
				hp.myBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end

			hp.myBar:Show()
		end
		if(hp.otherBar) then
			if(hp.otherBar:IsObjectType'StatusBar' and not hp.otherBar:GetStatusBarTexture()) then
				hp.otherBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end

			hp.otherBar:Show()
		end
		if(hp.absorbBar) then
			if(hp.absorbBar:IsObjectType'StatusBar' and not hp.absorbBar:GetStatusBarTexture()) then
				hp.absorbBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end

			hp.absorbBar:Show()
		end
		if(hp.healAbsorbBar) then
			if(hp.healAbsorbBar:IsObjectType'StatusBar' and not hp.healAbsorbBar:GetStatusBarTexture()) then
				hp.healAbsorbBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end

			hp.healAbsorbBar:Show()
		end

		return true
	end
end

local function Disable(self)
	local hp = self.HealPrediction
	if(hp) then
		if(hp.myBar) then
			hp.myBar:Hide()
		end
		if(hp.otherBar) then
			hp.otherBar:Hide()
		end
		if(hp.absorbBar) then
			hp.absorbBar:Hide()
		end
		if(hp.healAbsorbBar) then
			hp.healAbsorbBar:Hide()
		end

		self:UnregisterEvent('UNIT_HEAL_PREDICTION', Path)
		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
		self:UnregisterEvent('UNIT_HEALTH', Path)
		self:UnregisterEvent('UNIT_HEALTH_FREQUENT', Path)
		self:UnregisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
		self:UnregisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)
	end
end

oUF:AddElement('HealPrediction', Path, Enable, Disable)