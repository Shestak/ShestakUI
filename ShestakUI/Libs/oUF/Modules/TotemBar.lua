local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe_class_bar.totem ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_TotemBar(by Soeters)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local total = 0
local delay = 0.01

-- In the order, fire, earth, water, air
local colors = {
	[1] = {0.58, 0.23, 0.10},
	[2] = {0.23, 0.45, 0.13},
	[3] = {0.19, 0.48, 0.60},
	[4] = {0.42, 0.18, 0.74},
}

local function UpdateSlot(self, slot)
	local totem = self.TotemBar
	if not totem[slot] then return end
	local haveTotem, _, startTime, duration = GetTotemInfo(slot)

	totem[slot]:SetStatusBarColor(unpack(totem.colors[slot]))
	totem[slot]:SetValue(0)

	-- Multipliers
	if totem[slot].bg.multiplier then
		local mu = totem[slot].bg.multiplier
		local r, g, b = totem[slot]:GetStatusBarColor()
		r, g, b = r * mu, g * mu, b * mu
		totem[slot].bg:SetVertexColor(r, g, b)
	end

	totem[slot].ID = slot

	-- If we have a totem then set his value
	if haveTotem then
		if duration > 0 then
			totem[slot]:SetValue(1 - ((GetTime() - startTime) / duration))
			-- Status bar update
			totem[slot]:SetScript("OnUpdate", function(self, elapsed)
				total = total + elapsed
				if total >= delay then
					total = 0
					haveTotem, _, startTime, duration = GetTotemInfo(self.ID)
					if startTime == 0 then return end
					if ((GetTime() - startTime) == 0) then
						self:SetValue(0)
					else
						self:SetValue(1 - ((GetTime() - startTime) / duration))
					end
				end
			end)
		else
			-- There's no need to update because it doesn't have any duration
			totem[slot]:SetScript("OnUpdate", nil)
			totem[slot]:SetValue(0)
		end
		if T.class ~= "SHAMAN" then
			totem[slot]:Show()
		end
	else
		totem[slot]:SetValue(0)
		if T.class ~= "SHAMAN" then
			totem[slot]:Hide()
		end
	end
end

local function Update(self, unit)
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

local function Enable(self, unit)
	local totem = self.TotemBar

	if totem then
		self:RegisterEvent("PLAYER_TOTEM_UPDATE", Event, true)
		totem.colors = setmetatable(totem.colors or {}, {__index = colors})
		delay = totem.delay or delay
		if totem.Destroy then
			for i = 1, MAX_TOTEMS do
				if totem[i] then
					local t = _G["TotemFrameTotem"..i]
					t:ClearAllPoints()
					t:SetParent(totem[i])
					t:SetAllPoints(totem[i])
					t:SetFrameLevel(totem[i]:GetFrameLevel() + 1)
					t:SetFrameStrata(totem[i]:GetFrameStrata())
					t:SetAlpha(0)
					_G["TotemFrameTotem"..i.."Icon"]:Hide()
				end
			end
			hooksecurefunc("TotemFrame_Update", function()
				for i = 1, MAX_TOTEMS do
					local t = _G["TotemFrameTotem"..i]
					local slot = t.slot
					if slot and slot > 0 then
						t:ClearAllPoints()
						t:SetAllPoints(totem[slot])
					end
				end
			end)
		end
		return true
	end
end

local function Disable(self, unit)
	local totem = self.TotemBar
	if totem then
		self:UnregisterEvent("PLAYER_TOTEM_UPDATE", Event)
		TotemFrame:Show()
	end
end

oUF:AddElement("TotemBar", Update, Enable, Disable)