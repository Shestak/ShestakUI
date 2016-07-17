if(select(2, UnitClass('player')) ~= 'PALADIN') then return end

local parent, ns = ...
local oUF = ns.oUF

local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'HOLY_POWER')) then return end

	local hp = self.HolyPower
	if(hp.PreUpdate) then hp:PreUpdate() end

	local maxHolyPower = UnitPowerMax('player', SPELL_POWER_HOLY_POWER)
	local num = UnitPower('player', SPELL_POWER_HOLY_POWER)
	for i = 1, maxHolyPower do
		if(i <= num) then
			hp[i]:Show()
		else
			hp[i]:Hide()
		end
	end

	if(hp.PostUpdate) then
		return hp:PostUpdate(num)
	end
end

local Path = function(self, ...)
	return (self.HolyPower.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'HOLY_POWER')
end

local function Visibility(self, event, unit)
	local hp = self.HolyPower
	local spec = GetSpecialization()

	if spec == SPEC_PALADIN_RETRIBUTION then
		hp:Show()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	else
		hp:Hide()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
	end
end

local function Enable(self)
	local hp = self.HolyPower
	if(hp) then
		hp.__owner = self
		hp.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER', Path)

		hp.Visibility = CreateFrame("Frame", nil, hp)
		hp.Visibility:RegisterEvent("PLAYER_TALENT_UPDATE")
		hp.Visibility:RegisterEvent("PLAYER_ENTERING_WORLD")
		hp.Visibility:SetScript("OnEvent", function(frame, event, unit) Visibility(self, event, unit) end)

		return true
	end
end

local function Disable(self)
	local hp = self.HolyPower
	if(hp) then
		self:UnregisterEvent('UNIT_POWER', Path)
		hp.Visibility:UnregisterEvent("PLAYER_TALENT_UPDATE")
		hp.Visibility:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

oUF:AddElement('HolyPower', Path, Enable, Disable)