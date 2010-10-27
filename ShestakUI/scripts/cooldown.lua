----------------------------------------------------------------------------------------
--	Based on OmniCC
----------------------------------------------------------------------------------------
if IsAddOnLoaded("OmniCC") or IsAddOnLoaded("ncCooldown") then return end

local db = SettingsCF["font"]
local format = string.format
local floor = math.floor
local min = math.min

local function GetFormattedTime(s)
	local DAY, HOUR, MINUTE = 86400, 3600, 60
	if s >= DAY then
		return format("%dd", floor(s/DAY + 0.5)), s % DAY
	elseif s >= HOUR then
		return format("%dh", floor(s/HOUR + 0.5)), s % HOUR
	elseif s >= MINUTE then
		return format("%dm", floor(s/MINUTE + 0.5)), s % MINUTE
	end
	return floor(s + 0.5), s - floor(s)
end

local function Timer_OnUpdate(self, elapsed)
	if self.text:IsShown() then
		if self.nextUpdate > 0 then
			self.nextUpdate = self.nextUpdate - elapsed
		else
			if (self:GetEffectiveScale()/UIParent:GetEffectiveScale()) < 0.5 then
				self.text:SetText("")
				self.nextUpdate = 1
			else
				local remain = self.duration - (GetTime() - self.start)
				if floor(remain + 0.5) > 0 then
					local time, nextUpdate = GetFormattedTime(remain)
					self.text:SetText(time)
					self.nextUpdate = nextUpdate
					if(floor(remain + 0.5) > 5) then
						self.text:SetTextColor(1, 1, 1)
					else
						self.text:SetTextColor(1, 0.2, 0.2)
					end
				else
					self.text:Hide()
				end
			end
		end
	end
end

local function Timer_Create(self)
	local scale = min(self:GetParent():GetWidth() / 40, 1)
	if scale < 0.5 then
		self.noOCC = true
	else
		local text = self:CreateFontString(nil, "OVERLAY")
		text:SetPoint("CENTER", SettingsDB.Scale(1), 0)
		text:SetFont(db.cooldown_timers_font, db.cooldown_timers_font_size, db.cooldown_timers_font_style);
		text:SetShadowOffset(db.cooldown_timers_font_shadow and 1 or 0, db.cooldown_timers_font_shadow and -1 or 0)
        text:SetTextColor(1, 1, 1)
		self.text = text
		self:SetScript("OnUpdate", Timer_OnUpdate)
		return text
	end
end

local function Timer_Start(self, start, duration)
	self.start = start
	self.duration = duration
	self.nextUpdate = 0
	local text = self.text or (not self.noOCC and Timer_Create(self))
	if text then
		text:Show()
	end
end

local methods = getmetatable(_G["ActionButton1Cooldown"]).__index
hooksecurefunc(methods, "SetCooldown", function(self, start, duration)
	if start > 0 and duration > 2 then
		Timer_Start(self, start, duration)
	else
		local text = self.text
		if text then
			text:Hide()
		end
	end
end)