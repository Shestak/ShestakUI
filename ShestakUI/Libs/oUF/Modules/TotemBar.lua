local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe_class_bar.totem ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_TotemBar(by Soeters)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

-- In the order, fire, earth, water, air
local colors = {
	[1] = {0.58, 0.23, 0.10},
	[2] = {0.23, 0.45, 0.13},
	[3] = {0.19, 0.48, 0.60},
	[4] = {0.42, 0.18, 0.74},
}

local function onUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < 0.1 then return end
	self.elapsed = 0
	local time = self.finish - GetTime()
	self:SetValue(time)
end

local function UpdateSlot(self, slot)
	local element = self.TotemBar
	if not element[slot] then return end

	local totem = element[slot]
	local haveTotem, _, startTime, duration = GetTotemInfo(slot)

	totem:SetStatusBarColor(unpack(element.colors[slot]))

	-- Multipliers
	if totem.bg.multiplier then
		local mu = totem.bg.multiplier
		local r, g, b = totem:GetStatusBarColor()
		r, g, b = r * mu, g * mu, b * mu
		totem.bg:SetVertexColor(r, g, b)
	end

	if haveTotem and duration > 0 then
		totem.finish = startTime + duration
		totem:SetMinMaxValues(0, duration)
		totem:SetValue(duration)
		totem:SetScript('OnUpdate', onUpdate)

		if T.class ~= "SHAMAN" then
			totem:Show()
		end
	else
		totem:SetValue(0)
		totem:SetScript("OnUpdate", nil)
		if T.class ~= "SHAMAN" then
			totem:Hide()
		end
	end
end

local function Update(self)
	-- Update every slot on login, still have issues with it
	for i = 1, MAX_TOTEMS do
		UpdateSlot(self, i)
	end
end

local function Event(self, event, ...)
	if event == "PLAYER_TOTEM_UPDATE" then
		UpdateSlot(self, ...)
	end
end

local function anchorTotems(element)
	for t in next, _G.TotemFrame.totemPool.activeObjects do
		local i = t.slot
		t:ClearAllPoints()
		t:SetParent(element[i])
		t:SetAllPoints(element[i])
		t:SetFrameLevel(element[i]:GetFrameLevel() + 1)
		t:SetFrameStrata(element[i]:GetFrameStrata())
		t:SetAlpha(0)
		t.Icon:Hide()
	end
end

local function Enable(self)
	local element = self.TotemBar
	if element then
		self:RegisterEvent("PLAYER_TOTEM_UPDATE", Event, true)
		element.colors = setmetatable(element.colors or {}, {__index = colors})
		if element.Destroy then
			anchorTotems(element)
			hooksecurefunc(TotemFrame, "Update", function()
				anchorTotems(element)
			end)
		end
		return true
	end
end

local function Disable(self)
	local element = self.TotemBar
	if element then
		self:UnregisterEvent("PLAYER_TOTEM_UPDATE", Event)
		TotemFrame:Show()
	end
end

oUF:AddElement("TotemBar", Update, Enable, Disable)