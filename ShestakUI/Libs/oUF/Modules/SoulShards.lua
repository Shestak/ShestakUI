if(select(2, UnitClass('player')) ~= 'WARLOCK') then return end

local parent, ns = ...
local oUF = ns.oUF

local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS

local function Update(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'SOUL_SHARDS')) then return end

	local ss = self.SoulShards

	if(ss.PreUpdate) then
		ss:PreUpdate(unit)
	end

	local cur = UnitPower('player', SPELL_POWER_SOUL_SHARDS)
	local max = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)

	for i = 1, max do
		if i <= cur then
			ss[i]:SetAlpha(1)
		else
			ss[i]:SetAlpha(0.2)
		end
	end

	if(ss.PostUpdate) then
		return ss:PostUpdate(cur)
	end
end

local Path = function(self, ...)
	return (self.SoulShards.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'SOUL_SHARDS')
end

local function Enable(self, unit)
	local ss = self.SoulShards
	if(ss) and unit == 'player' then
		ss.__owner = self
		ss.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER', Path)
		self:RegisterEvent('UNIT_DISPLAYPOWER', Path)

		return true
	end
end

local function Disable(self)
	local ss = self.SoulShards
	if(ss) then
		self:UnregisterEvent('UNIT_POWER', Path)
		self:UnregisterEvent('UNIT_DISPLAYPOWER', Path)
	end
end

oUF:AddElement('SoulShards', Path, Enable, Disable)