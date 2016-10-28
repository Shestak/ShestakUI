local T, C, L, _ = unpack(select(2, ...))
if IsAddOnLoaded("OmniCC") or IsAddOnLoaded("ncCooldown") or IsAddOnLoaded("tullaCC") then return end

----------------------------------------------------------------------------------------
--	Cooldown count(tullaCC by Tuller)
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
	text:SetPoint("CENTER", 1, 0)
	text:SetJustifyH("CENTER")
	timer.text = text

	Timer_OnSizeChanged(timer, scaler:GetSize())
	scaler:SetScript("OnSizeChanged", function(self, ...) Timer_OnSizeChanged(timer, ...) end)

	self.timer = timer
	return timer
end

local function Timer_Start(self, start, duration, charges, maxCharges)
	local remainingCharges = charges or 0

	if self:GetName() and string.find(self:GetName(), "ChargeCooldown") then return end
	if start > 0 and duration > 2 and remainingCharges < 2 and (not self.noOCC) then
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
end

hooksecurefunc(getmetatable(_G["ActionButton1Cooldown"]).__index, "SetCooldown", Timer_Start)

if not _G["ActionBarButtonEventsFrame"] then return end

local active = {}
local hooked = {}

local function cooldown_OnShow(self)
	active[self] = true
end

local function cooldown_OnHide(self)
	active[self] = nil
end

local function cooldown_ShouldUpdateTimer(self, start, duration, charges, maxCharges)
	local timer = self.timer
	return not(timer and timer.start == start and timer.duration == duration and timer.charges == charges and timer.maxCharges == maxCharges)
end

local function cooldown_Update(self)
	local button = self:GetParent()
	local action = button.action
	local start, duration, enable = GetActionCooldown(action)
	local charges, maxCharges, chargeStart, chargeDuration = GetActionCharges(action)

	if cooldown_ShouldUpdateTimer(self, start, duration, charges, maxCharges) then
		Timer_Start(self, start, duration, charges, maxCharges)
	end
end

local EventWatcher = CreateFrame("Frame")
EventWatcher:Hide()
EventWatcher:SetScript("OnEvent", function(self, event)
	for cooldown in pairs(active) do
		cooldown_Update(cooldown)
	end
end)
EventWatcher:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")

local function actionButton_Register(frame)
	local cooldown = frame.cooldown
	if not hooked[cooldown] then
		cooldown:HookScript("OnShow", cooldown_OnShow)
		cooldown:HookScript("OnHide", cooldown_OnHide)
		hooked[cooldown] = true
	end
end

if _G["ActionBarButtonEventsFrame"].frames then
	for i, frame in pairs(_G["ActionBarButtonEventsFrame"].frames) do
		actionButton_Register(frame)
	end
end

hooksecurefunc("ActionBarButtonEventsFrame_RegisterFrame", actionButton_Register)