if(select(2, UnitClass('player')) ~= 'WARLOCK') then return end

local parent, ns = ...
local oUF = ns.oUF

local MAX_POWER_PER_EMBER = 10
local SPELL_POWER_DEMONIC_FURY = SPELL_POWER_DEMONIC_FURY
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
local SPEC_WARLOCK_DESTRUCTION = SPEC_WARLOCK_DESTRUCTION
local SPEC_WARLOCK_DESTRUCTION_GLYPH_EMBERS = 63304
local SPEC_WARLOCK_AFFLICTION = SPEC_WARLOCK_AFFLICTION
local SPEC_WARLOCK_AFFLICTION_GLYPH_SHARDS = 63302
local SPEC_WARLOCK_DEMONOLOGY = SPEC_WARLOCK_DEMONOLOGY
local LATEST_SPEC = 0

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'BURNING_EMBERS' and powerType ~= 'SOUL_SHARDS' and powerType ~= 'DEMONIC_FURY')) then return end

	local wsb = self.WarlockSpecBars

	if(wsb.PreUpdate) then
		wsb:PreUpdate(unit)
	end

	local spec = GetSpecialization()

	if spec then
		if spec == SPEC_WARLOCK_DESTRUCTION then
			local maxPower = UnitPowerMax('player', SPELL_POWER_BURNING_EMBERS, true)
			local power = UnitPower('player', SPELL_POWER_BURNING_EMBERS, true)
			local numEmbers = power / MAX_POWER_PER_EMBER
			local numBars = floor(maxPower / MAX_POWER_PER_EMBER)

			for i = 1, numBars do
				wsb[i]:SetMinMaxValues((MAX_POWER_PER_EMBER * i) - MAX_POWER_PER_EMBER, MAX_POWER_PER_EMBER * i)
				wsb[i]:SetValue(power)
			end
		elseif spec == SPEC_WARLOCK_AFFLICTION then
			local numShards = UnitPower('player', SPELL_POWER_SOUL_SHARDS)
			local maxShards = UnitPowerMax('player', SPELL_POWER_SOUL_SHARDS)

			for i = 1, maxShards do
				if i <= numShards then
					wsb[i]:SetAlpha(1)
				else
					wsb[i]:SetAlpha(.2)
				end
			end
		elseif spec == SPEC_WARLOCK_DEMONOLOGY then
			local power = UnitPower('player', SPELL_POWER_DEMONIC_FURY)
			local maxPower = UnitPowerMax('player', SPELL_POWER_DEMONIC_FURY)

			wsb[1]:SetMinMaxValues(0, maxPower)
			wsb[1]:SetValue(power)
		end
	end

	if(wsb.PostUpdate) then
		return wsb:PostUpdate(spec)
	end
end

local function Visibility(self, event, unit)
	local wsb = self.WarlockSpecBars
	local spacing = select(4, wsb[4]:GetPoint())
	local w = wsb:GetWidth()
	local s = 0

	local spec = GetSpecialization()
	if spec then
		if not wsb:IsShown() then
			wsb:Show()
		end

		if LATEST_SPEC ~= spec then
			for i = 1, 4 do
				local max = select(2, wsb[i]:GetMinMaxValues())
				if spec == SPEC_WARLOCK_AFFLICTION then
					wsb[i]:SetValue(max)
				else
					wsb[i]:SetValue(0)
				end
				wsb[i]:Show()
			end
		end

		if spec == SPEC_WARLOCK_DESTRUCTION then
			local maxembers = 4

			for i = 1, maxembers do
				if i ~= maxembers then
					wsb[i]:SetWidth(w / maxembers - spacing)
					s = s + (w / maxembers)
				else
					wsb[i]:SetWidth(w - s)
				end
			end
		elseif spec == SPEC_WARLOCK_AFFLICTION then
			local maxshards = 4

			for i = 1, maxshards do
				if i ~= maxshards then
					wsb[i]:SetWidth(w / maxshards - spacing)
					s = s + (w / maxshards)
				else
					wsb[i]:SetWidth(w - s)
				end
			end
		elseif spec == SPEC_WARLOCK_DEMONOLOGY then
			wsb[2]:Hide()
			wsb[3]:Hide()
			wsb[4]:Hide()
			wsb[1]:SetWidth(wsb:GetWidth())
		end

		Update(self, nil, "player")
	else
		if wsb:IsShown() then
			wsb:Hide()
		end
	end

	LATEST_SPEC = spec
end

local Path = function(self, ...)
	return (self.WarlockSpecBars.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'SOUL_SHARDS')
end

local function Enable(self)
	local wsb = self.WarlockSpecBars
	if(wsb) then
		wsb.__owner = self
		wsb.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER', Path)
		self:RegisterEvent('UNIT_DISPLAYPOWER', Path)

		wsb.Visibility = CreateFrame("Frame", nil, wsb)
		wsb.Visibility:RegisterEvent("PLAYER_TALENT_UPDATE")
		wsb.Visibility:SetScript("OnEvent", function(frame, event, unit) Visibility(self, event, unit) end)

		wsb:Hide()

		return true
	end
end

local function Disable(self)
	local wsb = self.WarlockSpecBars
	if(wsb) then
		self:UnregisterEvent('UNIT_POWER', Path)
		self:UnregisterEvent('UNIT_DISPLAYPOWER', Path)
		wsb.Visibility:UnregisterEvent("PLAYER_TALENT_UPDATE")
	end
end

oUF:AddElement('WarlockSpecBars', Path, Enable, Disable)