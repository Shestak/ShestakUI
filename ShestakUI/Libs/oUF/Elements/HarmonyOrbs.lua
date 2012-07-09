if select(2, UnitClass('player')) ~= 'MONK' then return end

local parent, ns = ...
local oUF = ns.oUF

local SPELL_POWER_LIGHT_FORCE = SPELL_POWER_LIGHT_FORCE

local function Update(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'LIGHT_FORCE')) then return end

	local hb = self.HarmonyBar

	if(hb.PreUpdate) then
		hb:PreUpdate(unit)
	end

	local light = UnitPower("player", SPELL_POWER_LIGHT_FORCE)
	local numPoints = UnitPowerMax("player", SPELL_POWER_LIGHT_FORCE)

	if hb.numPoints ~= numPoints then
		if numPoints == 4 then
			hb[5]:Hide()
		else
			hb[5]:Show()
		end

		hb.numPoints = numPoints
	end

	for i = 1, numPoints do
		if i <= light then
			hb[i]:SetAlpha(1)
		else
			hb[i]:SetAlpha(.2)
		end
		if numPoints == 4 then
			hb[i]:SetWidth(214 / 4)
		else
			hb[i]:SetWidth(213 / 5)
		end
	end

	if(hb.PostUpdate) then
		return hb:PostUpdate(light)
	end
end

local Path = function(self, ...)
	return (self.HarmonyBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'LIGHT_FORCE')
end

local function Enable(self, unit)
	local hb = self.HarmonyBar
	if hb and unit == "player" then
		hb.__owner = self
		hb.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER", Path)
		self:RegisterEvent("UNIT_DISPLAYPOWER", Path)

		hb.numPoints = 5

		return true
	end
end

local function Disable(self)
	local hb = self.HarmonyBar
	if(hb) then
		self:UnregisterEvent("UNIT_POWER", Path)
		self:UnregisterEvent("UNIT_DISPLAYPOWER", Path)
	end
end

oUF:AddElement('HarmonyBar', Path, Enable, Disable)
