if(select(2, UnitClass("player")) ~= "WARLOCK") then return end

local _, ns = ...
local oUF = ns.oUF

local SPELL_POWER_SOUL_SHARDS = Enum.PowerType.SoulShards or 7

local function Update(self, _, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= "SOUL_SHARDS")) then return end

	local element = self.SoulShards

	if(element.PreUpdate) then
		element:PreUpdate(unit)
	end

	local cur = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
	local max = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)

	for i = 1, max do
		if i <= cur then
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
	return (self.SoulShards.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit, "SOUL_SHARDS")
end

local function Enable(self, unit)
	local element = self.SoulShards
	if(element) and unit == "player" then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER_UPDATE", Path)
		self:RegisterEvent("UNIT_DISPLAYPOWER", Path)

		return true
	end
end

local function Disable(self)
	local element = self.SoulShards
	if(element) then
		self:UnregisterEvent("UNIT_POWER_UPDATE", Path)
		self:UnregisterEvent("UNIT_DISPLAYPOWER", Path)
	end
end

oUF:AddElement("SoulShards", Path, Enable, Disable)