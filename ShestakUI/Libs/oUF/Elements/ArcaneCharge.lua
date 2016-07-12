if(select(2, UnitClass('player')) ~= 'MAGE') then return end

local parent, ns = ...
local oUF = ns.oUF

local SPELL_POWER_ARCANE_CHARGES = SPELL_POWER_ARCANE_CHARGES

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'ARCANE_CHARGES')) then return end

	local ac = self.ArcaneCharge
	if(ac.PreUpdate) then ac:PreUpdate() end

	local max = UnitPowerMax('player', SPELL_POWER_ARCANE_CHARGES)
	local num = UnitPower('player', SPELL_POWER_ARCANE_CHARGES)
	for i = 1, max do
		if(i <= num) then
			ac[i]:SetAlpha(1)
		else
			ac[i]:SetAlpha(0.2)
		end
	end

	if(ac.PostUpdate) then
		return ac:PostUpdate(num)
	end
end

local Path = function(self, ...)
	return (self.ArcaneCharge.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'ARCANE_CHARGES')
end

local function Visibility(self, event, unit)
	local ac = self.ArcaneCharge
	local spec = GetSpecialization()

	if spec == SPEC_MAGE_ARCANE then
		ac:Show()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	else
		ac:Hide()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
	end
end

local function Enable(self)
	local ac = self.ArcaneCharge
	if(ac) then
		ac.__owner = self
		ac.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER', Path)

		ac.Visibility = CreateFrame("Frame", nil, ac)
		ac.Visibility:RegisterEvent("PLAYER_TALENT_UPDATE")
		ac.Visibility:RegisterEvent("PLAYER_ENTERING_WORLD")
		ac.Visibility:SetScript("OnEvent", function(frame, event, unit) Visibility(self, event, unit) end)

		return true
	end
end

local function Disable(self)
	local ac = self.ArcaneCharge
	if(ac) then
		self:UnregisterEvent('UNIT_POWER', Path)
		ac.Visibility:UnregisterEvent("PLAYER_TALENT_UPDATE")
		ac.Visibility:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

oUF:AddElement('ArcaneCharge', Path, Enable, Disable)
