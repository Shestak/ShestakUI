if(select(2, UnitClass("player")) ~= "PALADIN") then return end

local _, ns = ...
local oUF = ns.oUF

local SPELL_POWER_HOLY_POWER = Enum.PowerType.HolyPower or 9

local function Update(self, _, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= "HOLY_POWER")) then return end

	local element = self.HolyPower

	if(element.PreUpdate) then
		element:PreUpdate(unit)
	end

	local cur = UnitPower("player", SPELL_POWER_HOLY_POWER)
	local max = 5 -- Cause we don't use :Factory to spawn frames it return sometimes "3"

	for i = 1, max do
		if(i <= cur) then
			element[i]:SetAlpha(1)
		else
			element[i]:SetAlpha(0.2)
		end
	end

	if(element.PostUpdate) then
		return element:PostUpdate(cur)
	end
end

local function Path(self, ...)
	return (self.HolyPower.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit, "HOLY_POWER")
end

local function Visibility(self)
	local element = self.HolyPower
	local spec = GetSpecialization()

	if spec == SPEC_PALADIN_RETRIBUTION then
		element:Show()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	else
		element:Hide()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
	end
end

local function Enable(self)
	local element = self.HolyPower
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER_UPDATE', Path)

		element.hadler = CreateFrame("Frame", nil, element)
		element.hadler:RegisterEvent("PLAYER_TALENT_UPDATE")
		element.hadler:RegisterEvent("PLAYER_ENTERING_WORLD")
		element.hadler:SetScript("OnEvent", function() Visibility(self) end)

		return true
	end
end

local function Disable(self)
	local element = self.HolyPower
	if(element) then
		self:UnregisterEvent('UNIT_POWER_UPDATE', Path)
		element.hadler:UnregisterEvent("PLAYER_TALENT_UPDATE")
		element.hadler:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

oUF:AddElement("HolyPower", Path, Enable, Disable)