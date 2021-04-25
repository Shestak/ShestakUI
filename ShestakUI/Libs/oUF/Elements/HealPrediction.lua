-- ShestakUI use modified version of HealPrediction. Do not update if you are not sure what you are doing.

local _, ns = ...
local oUF = ns.oUF

local function UpdateFillBar(frame, previousTexture, bar, amount, maxHealth)
	if amount == 0 then
		bar:Hide()
		return previousTexture
	end

	local totalWidth, totalHeight = frame.Health:GetSize()
	if frame.Health:GetOrientation() == "VERTICAL" then
		bar:SetPoint("BOTTOM", previousTexture, "TOP", 0, 0)

		local barSize = (amount / maxHealth) * totalHeight
		bar:SetHeight(barSize)
	else
		bar:SetPoint('TOPLEFT', previousTexture, 'TOPRIGHT', 0, 0)
		bar:SetPoint('BOTTOMLEFT', previousTexture, 'BOTTOMRIGHT', 0, 0)

		local barSize = (amount / maxHealth) * totalWidth
		bar:SetWidth(barSize)
	end
	bar:Show()

	return bar
end

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	local element = self.HealthPrediction

	if(element.PreUpdate) then
		element:PreUpdate(unit)
	end

	local myIncomingHeal = UnitGetIncomingHeals(unit, 'player') or 0
	local allIncomingHeal = UnitGetIncomingHeals(unit) or 0
	local absorb = UnitGetTotalAbsorbs(unit) or 0
	local healAbsorb = UnitGetTotalHealAbsorbs(unit) or 0
	local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)

	if healAbsorb > allIncomingHeal then
		healAbsorb = healAbsorb - allIncomingHeal
		allIncomingHeal = 0
		myIncomingHeal = 0
		absorb = 0

		if health + healAbsorb > maxHealth then
			healAbsorb = maxHealth - health
		end
	else
		allIncomingHeal = allIncomingHeal - healAbsorb
		healAbsorb = 0

		if health + allIncomingHeal > maxHealth then
			allIncomingHeal = maxHealth - health
		end

		if(allIncomingHeal < myIncomingHeal) then
			myIncomingHeal = allIncomingHeal
			allIncomingHeal = 0
		else
			allIncomingHeal = allIncomingHeal - myIncomingHeal
		end

		if health + myIncomingHeal + allIncomingHeal + absorb >= maxHealth then
			absorb = max(0, maxHealth - (health + myIncomingHeal + allIncomingHeal))
		end
	end

	local previousTexture = self.Health:GetStatusBarTexture()

	if element.healAbsorbBar then
		previousTexture = UpdateFillBar(self, previousTexture, element.healAbsorbBar, healAbsorb, maxHealth)
	end

	if element.myBar then
		previousTexture = UpdateFillBar(self, previousTexture, element.myBar, myIncomingHeal, maxHealth)
	end

	if element.otherBar then
		previousTexture = UpdateFillBar(self, previousTexture, element.otherBar, allIncomingHeal, maxHealth)
	end

	if element.absorbBar then
		previousTexture = UpdateFillBar(self, previousTexture, element.absorbBar, absorb, maxHealth)
	end

	if(element.PostUpdate) then
		return element:PostUpdate(unit, myIncomingHeal, otherIncomingHeal, absorb, healAbsorb)
	end
end

local function Path(self, ...)
	--[[ Override: HealthPrediction.Override(self, event, unit)
	Used to completely override the internal update function.
	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event
	--]]
	return (self.HealthPrediction.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	local element = self.HealthPrediction
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_HEALTH', Path)
		self:RegisterEvent('UNIT_MAXHEALTH', Path)

		if element.myBar or element.otherBar then
			self:RegisterEvent('UNIT_HEAL_PREDICTION', Path)
		end

		if element.absorbBar then
			self:RegisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
		end

		if element.healAbsorbBar then
			self:RegisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)
		end

		return true
	end
end

local function Disable(self)
	local element = self.HealthPrediction
	if(element) then
		if(element.myBar) then
			element.myBar:Hide()
		end

		if(element.otherBar) then
			element.otherBar:Hide()
		end

		if(element.absorbBar) then
			element.absorbBar:Hide()
		end

		if(element.healAbsorbBar) then
			element.healAbsorbBar:Hide()
		end

		self:UnregisterEvent('UNIT_HEALTH', Path)
		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
		self:UnregisterEvent('UNIT_HEAL_PREDICTION', Path)
		self:UnregisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
		self:UnregisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)
	end
end

oUF:AddElement('HealthPrediction', Path, Enable, Disable)