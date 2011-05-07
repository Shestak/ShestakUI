local T, C, L = unpack(select(2, ...))
if IsAddOnLoaded("OmniCC") or IsAddOnLoaded("ncCooldown") then return end

----------------------------------------------------------------------------------------
--	Based on OmniCC
----------------------------------------------------------------------------------------
local format = string.format
local floor = math.floor
local min = math.min

local function GetFormattedTime(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", floor(s / day + 0.5)), s % day
	elseif s >= hour then
		return format("%dh", floor(s / hour + 0.5)), s % hour
	elseif s >= minute then
		return format("%dm", floor(s / minute + 0.5)), s % minute
	end
	return floor(s + 0.5), s - floor(s)
end

local function Timer_Stop(self)
	self.enabled = nil
	self:Hide()
end

local function Timer_ForceUpdate(self)
	self.nextUpdate = 0
	self:Show()
end

local function Timer_OnSizeChanged(self, width, height)
	local fontScale = T.Round(width) / 40
	if fontScale == self.fontScale then
		return
	end

	self.fontScale = fontScale
	if fontScale < 0.5 then
		self:Hide()
	else
		self.text:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
		self.text:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
		if self.enabled then
			Timer_ForceUpdate(self)
		end
	end
end

local function Timer_OnUpdate(self, elapsed)
	if self.text:IsShown() then
		if self.nextUpdate > 0 then
			self.nextUpdate = self.nextUpdate - elapsed
		else
			if (self:GetEffectiveScale() / UIParent:GetEffectiveScale()) < 0.5 then
				self.text:SetText("")
				self.nextUpdate = 1
			else
				local remain = self.duration - (GetTime() - self.start)
				if floor(remain + 0.5) > 0 then
					local time, nextUpdate = GetFormattedTime(remain)
					self.text:SetText(time)
					self.nextUpdate = nextUpdate
					if floor(remain + 0.5) > 5 then
						self.text:SetTextColor(1, 1, 1)
					else
						self.text:SetTextColor(1, 0.2, 0.2)
					end
				else
					Timer_Stop(self)
				end
			end
		end
	end
end

local function Timer_Create(self)
	local scaler = CreateFrame("Frame", nil, self)
	scaler:SetAllPoints(self)

	local timer = CreateFrame("Frame", nil, scaler)
	timer:Hide()
	timer:SetAllPoints(scaler)
	timer:SetScript("OnUpdate", Timer_OnUpdate)

	local text = timer:CreateFontString(nil, "OVERLAY")
	text:Point("CENTER", 1, 0)
	text:SetJustifyH("CENTER")
	timer.text = text

	Timer_OnSizeChanged(timer, scaler:GetSize())
	scaler:SetScript("OnSizeChanged", function(self, ...) Timer_OnSizeChanged(timer, ...) end)

	self.timer = timer
	return timer
end

hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, "SetCooldown", function(self, start, duration)
	if self.noOCC then return end
	if start > 0 and duration > 2 then
		local timer = self.timer or Timer_Create(self)
		timer.start = start
		timer.duration = duration
		timer.enabled = true
		timer.nextUpdate = 0
		if timer.fontScale >= 0.5 then timer:Show() end
	else
		local timer = self.timer
		if timer then
			Timer_Stop(timer)
		end
	end
end)