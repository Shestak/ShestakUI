if(select(2, UnitClass('player')) ~= 'DEATHKNIGHT') then return end

local parent, ns = ...
local oUF = ns.oUF

local OnUpdate = function(self, elapsed)
	local duration = self.duration + elapsed
	if(duration >= self.max) then
		return self:SetScript('OnUpdate', nil)
	else
		self.duration = duration
		return self:SetValue(duration)
	end
end

local Update = function(self, event, rid)
	local runes = self.Runes
	local rune = runes[rid]
	if(not rune) then return end

	if(UnitHasVehicleUI'player') then
		rune:Hide()
	else
		local start, duration, runeReady = GetRuneCooldown(rid)
		if(runeReady) then
			rune:SetMinMaxValues(0, 1)
			rune:SetValue(1)
			rune:SetScript("OnUpdate", nil)
		else
			rune.duration = GetTime() - start
			rune.max = duration
			rune:SetMinMaxValues(1, duration)
			rune:SetScript("OnUpdate", OnUpdate)
		end

		rune:Show()
	end

	if(runes.PostUpdate) then
		return runes:PostUpdate(rune, rid, start, duration, runeReady)
	end
end

local Path = function(self, event, ...)
	local UpdateMethod = self.Runes.Override or Update
	if(event == 'RUNE_POWER_UPDATE') then
		return UpdateMethod(self, event, ...)
	else
		for index = 1, 6 do
			UpdateMethod(self, event, index)
		end
	end
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate')
end

local Enable = function(self, unit)
	local runes = self.Runes
	if(runes and unit == 'player') then
		runes.__owner = self
		runes.ForceUpdate = ForceUpdate

		self:RegisterEvent("RUNE_POWER_UPDATE", Path, true)

		return true
	end
end

local Disable = function(self)
	self:UnregisterEvent("RUNE_POWER_UPDATE", Path)
end

oUF:AddElement("Runes", Path, Enable, Disable)