local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_CounterBar(by p3lim)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local OnUpdate = function(self, elapsed)
	self.expiration = self.expiration - elapsed
	self:SetValue(self.expiration)
end

local Update = function(self, _, unit)
	if self.unit ~= unit then return end

	local counterbar = self.CounterBar
	if counterbar.PreUpdate then
		counterbar:PreUpdate()
	end

	-- We just use 1 as index for now, since there currently is no more bars in use
	local max, expiration, barID = UnitPowerBarTimerInfo(unit, 1)
	if not barID then
		counterbar:Hide()
	else
		counterbar.expiration = expiration - GetTime()
		counterbar:SetMinMaxValues(0, max)
		counterbar:Show()
	end

	if counterbar.PostUpdate then
		-- Not sure what to pass here, since this event only fires on show/hide
		return counterbar:PostUpdate()
	end
end

local Path = function(self, ...)
	return (self.CounterBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local Enable = function(self, unit)
	local counterbar = self.CounterBar
	if counterbar then
		counterbar.__owner = self
		counterbar.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER_BAR_TIMER_UPDATE", Path)

		counterbar:SetScript("OnUpdate", counterbar.OnUpdate or OnUpdate)
		counterbar:Hide()

		if unit == "player" then
			PlayerBuffTimerManager:UnregisterEvent("UNIT_POWER_BAR_TIMER_UPDATE")
			PlayerBuffTimerManager:UnregisterEvent("PLAYER_ENTERING_WORLD")

			-- These events handles all the various alternative power bars,
			-- so unregistering them might not be the optimal solution
			PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
			PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
		end

		if counterbar:IsObjectType("StatusBar") and not counterbar:GetStatusBarTexture() then
			counterbar:SetStatusBarTexture[[Interface\TargetingFrame\UI-StatusBar]]
		end

		return true
	end
end

local Disable = function(self, unit)
	local counterbar = self.CounterBar
	if counterbar then
		self:UnregisterEvent("UNIT_POWER_BAR_TIMER_UPDATE", Path)

		counterbar:SetScript("OnUpdate", nil)

		if unit == "player" then
			PlayerBuffTimerManager:RegisterEvent("UNIT_POWER_BAR_TIMER_UPDATE")
			PlayerBuffTimerManager:RegisterEvent("PLAYER_ENTERING_WORLD")
		end
	end
end

oUF:AddElement("CounterBar", Path, Enable, Disable)