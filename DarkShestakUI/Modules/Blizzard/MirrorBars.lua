local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.unit_castbar ~= true or C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oMirrorBars(by Haste)
----------------------------------------------------------------------------------------
local position = {
	["BREATH"] = "TOP#UIParent#TOP#0#-96";
	["EXHAUSTION"] = "TOP#UIParent#TOP#0#-116";
	["FEIGNDEATH"] = "TOP#UIParent#TOP#0#-142";
}

local colors = {
	EXHAUSTION = {1, 0.9, 0};
	BREATH = {0.31, 0.45, 0.63};
	DEATH = {1, 0.7, 0};
	FEIGNDEATH = {1, 0.7, 0};
}

local Spawn, PauseAll
do
	local barPool = {}

	local loadPosition = function(self)
		local pos = position[self.type]
		local p1, frame, p2, x, y = strsplit("#", pos)

		return self:SetPoint(p1, frame, p2, x, y)
	end

	local OnUpdate = function(self, elapsed)
		if self.paused then return end

		self:SetValue(GetMirrorTimerProgress(self.type) / 1e3)
	end

	local Start = function(self, value, maxvalue, scale, paused, text)
		if paused > 0 then
			self.paused = 1
		elseif self.paused then
			self.paused = nil
		end

		self.text:SetText(text)

		self:SetMinMaxValues(0, maxvalue / 1e3)
		self:SetValue(value / 1e3)

		if not self:IsShown() then self:Show() end
	end

	function Spawn(type)
		if barPool[type] then return barPool[type] end
		local frame = CreateFrame("StatusBar", nil, UIParent)

		frame:SetScript("OnUpdate", OnUpdate)

		local r, g, b = unpack(colors[type])

		local bg = frame:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints(frame)
		bg:SetTexture(C.media.texture)
		bg:SetVertexColor(r * 0.3, g * 0.3, b * 0.3)

		local border = CreateFrame("Frame", nil, frame)
		border:SetPoint("TOPLEFT", frame, -2, 2)
		border:SetPoint("BOTTOMRIGHT", frame, 2, -2)
		border:SetTemplate("Default")
		border:SetFrameLevel(0)

		local text = frame:CreateFontString(nil, "OVERLAY")
		text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		text:SetJustifyH("CENTER")
		text:SetShadowOffset(0, 0)
		text:SetTextColor(1, 1, 1)

		text:SetPoint("LEFT", frame)
		text:SetPoint("RIGHT", frame)
		text:SetPoint("TOP", frame, 0, 1)
		text:SetPoint("BOTTOM", frame)

		frame:SetSize(281, 16)

		frame:SetStatusBarTexture(C.media.texture)
		frame:SetStatusBarColor(r, g, b)

		frame.type = type
		frame.text = text

		frame.Start = Start
		frame.Stop = Stop

		loadPosition(frame)

		barPool[type] = frame
		return frame
	end

	function PauseAll(val)
		for _, bar in next, barPool do
			bar.paused = val
		end
	end
end

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, ...)
	return self[event](self, ...)
end)

function frame:ADDON_LOADED(addon)
	if addon == "ShestakUI" then
		UIParent:UnregisterEvent("MIRROR_TIMER_START")

		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
	end
end
frame:RegisterEvent("ADDON_LOADED")

function frame:PLAYER_ENTERING_WORLD()
	for i = 1, MIRRORTIMER_NUMTIMERS do
		local type, value, maxvalue, scale, paused, text = GetMirrorTimerInfo(i)
		if type ~= "UNKNOWN" then
			Spawn(type):Start(value, maxvalue, scale, paused, text)
		end
	end
end
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

function frame:MIRROR_TIMER_START(type, value, maxvalue, scale, paused, text)
	return Spawn(type):Start(value, maxvalue, scale, paused, text)
end
frame:RegisterEvent("MIRROR_TIMER_START")

function frame:MIRROR_TIMER_STOP(type)
	return Spawn(type):Hide()
end
frame:RegisterEvent("MIRROR_TIMER_STOP")

function frame:MIRROR_TIMER_PAUSE(duration)
	return PauseAll((duration > 0 and duration) or nil)
end
frame:RegisterEvent("MIRROR_TIMER_PAUSE")