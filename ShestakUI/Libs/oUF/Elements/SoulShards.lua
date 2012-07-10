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
local LATEST_SPEC = 2

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
	if event == 'QUEST_LOG_UPDATE' then
		self:UnregisterEvent('QUEST_LOG_UPDATE', Visibility)
	end

	local wsb = self.WarlockSpecBars

	local spec = GetSpecialization()
	if spec then
		if not wsb:IsShown() then
			wsb:Show()
		end

		if LATEST_SPEC ~= spec and (spec == SPEC_WARLOCK_DESTRUCTION or spec == SPEC_WARLOCK_AFFLICTION) then
			wsb.number = 4
			wsb[1]:SetWidth(wsb[1].W)
			for i = 1, 4 do
				local max = select(2, wsb[i]:GetMinMaxValues())
				wsb[i]:SetValue(max)
				wsb[i]:Show()
			end
		end

		if spec == SPEC_WARLOCK_DESTRUCTION then
			local EmbersGlyph = false

			for i = 1, GetNumGlyphSockets() do
				local glyphID = select(4, GetGlyphSocketInfo(i))
				if glyphID == SPEC_WARLOCK_DESTRUCTION_GLYPH_EMBERS then EmbersGlyph = true end
			end

			if not EmbersGlyph then
				local spacing = select(4, wsb[4]:GetPoint())
				wsb[4]:Hide()
				local w = wsb:GetWidth()
				local s = 0
				for i = 1, 3 do
					if i ~= 3 then
						wsb[i]:SetWidth(w / 3 - spacing)
						s = s + (w / 3)
					else
						wsb[i]:SetWidth(w - s)
					end
				end
			else
				wsb[4]:Show()
				for i = 1, 4 do
					wsb[i]:SetWidth(wsb[i].W)
				end
			end
		elseif spec == SPEC_WARLOCK_AFFLICTION then
			local ShardsGlyph = false

			for i = 1, GetNumGlyphSockets() do
				local glyphID = select(4, GetGlyphSocketInfo(i))
				if glyphID == SPEC_WARLOCK_AFFLICTION_GLYPH_SHARDS then ShardsGlyph = true end
			end

			if not ShardsGlyph then
				local spacing = select(4, wsb[4]:GetPoint())
				wsb[4]:Hide()
				local w = wsb:GetWidth()
				local s = 0
				for i = 1, 3 do
					if i ~= 3 then
						wsb[i]:SetWidth(w / 3 - spacing)
						s = s + (w / 3)
					else
						wsb[i]:SetWidth(w - s)
					end
				end
			else
				wsb[4]:Show()
				for i = 1, 4 do
					wsb[i]:SetWidth(wsb[i].W)
				end
			end
		elseif spec == SPEC_WARLOCK_DEMONOLOGY then
			wsb.number = 1
			wsb[2]:Hide()
			wsb[3]:Hide()
			wsb[4]:Hide()
			wsb[1]:SetWidth(wsb:GetWidth())
		end
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
		self:RegisterEvent('PLAYER_TALENT_UPDATE', Visibility)

		self:RegisterEvent('QUEST_LOG_UPDATE', Visibility)

		for i = 1, 4 do
			local Point = wsb[i]
			Point.W = Point:GetWidth()
		end

		wsb.number = 4

		return true
	end
end

local function Disable(self)
	local wsb = self.WarlockSpecBars
	if(wsb) then
		self:UnregisterEvent('UNIT_POWER', Path)
		self:UnregisterEvent('UNIT_DISPLAYPOWER', Path)
		self:UnregisterEvent('PLAYER_TALENT_UPDATE', Visibility)
	end
end

oUF:AddElement('WarlockSpecBars', Path, Enable, Disable)
