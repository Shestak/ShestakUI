local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Skin AltPowerBar(by Tukz)
----------------------------------------------------------------------------------------
local blizzColors = {
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDAMETHYST_HORIZONTAL_FILL.BLP"] = {r = 0.50, g = 0.45, b = 0.75},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDCOBALT_HORIZONTAL_FILL.BLP"] = {r = 0.09, g = 0.26, b = 0.57},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDJADE_HORIZONTAL_FILL.BLP"] = {r = 0.09, g = 0.34, b = 0.26},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDJASPER_HORIZONTAL_FILL.BLP"] = {r = 0.59, g = 0.18, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\MAP_HORIZONTAL_FILL.BLP"] = {r = 0.97, g = 0.81, b = 0}
}

-- Get rid of old AltPowerBar
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")

-- AltPowerBar
local bar = CreateFrame("Frame", "UIAltPowerBar", UIParent)
bar:SetSize(221, 25)
bar:SetPoint(unpack(C.position.alt_power_bar))
bar:SetTemplate("Default")

-- Make moveable
bar:EnableMouse(true)
bar:SetMovable(true)
bar:SetUserPlaced(true)
bar:SetFrameStrata("HIGH")
bar:SetScript("OnMouseDown", function()
	if IsAltKeyDown() or IsShiftKeyDown() then
		bar:ClearAllPoints()
		bar:StartMoving()
	end
end)
bar:SetScript("OnMouseUp", function()
	bar:StopMovingOrSizing()
end)

-- Event handling
bar:RegisterEvent("UNIT_POWER")
bar:RegisterEvent("UNIT_POWER_BAR_SHOW")
bar:RegisterEvent("UNIT_POWER_BAR_HIDE")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if UnitAlternatePowerInfo("player") then
		self:Show()
	else
		self:Hide()
	end
end)

-- Tooltip
bar:SetScript("OnEnter", function(self)
	local name = select(10, UnitAlternatePowerInfo("player"))
	local tooltip = select(11, UnitAlternatePowerInfo("player"))

	GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
	GameTooltip:AddLine(name, 1, 1, 1)
	GameTooltip:AddLine(tooltip, nil, nil, nil, true)

	GameTooltip:Show()
end)
bar:SetScript("OnLeave", GameTooltip_Hide)

-- StatusBar
local status = CreateFrame("StatusBar", "UIAltPowerBarStatus", bar)
status:SetFrameLevel(bar:GetFrameLevel() + 1)
status:SetStatusBarTexture(C.media.texture)
status:SetMinMaxValues(0, 100)
status:SetPoint("TOPLEFT", bar, "TOPLEFT", 2, -2)
status:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -2, 2)

status.bg = status:CreateTexture(nil, "BACKGROUND")
status.bg:SetAllPoints(status)
status.bg:SetTexture(C.media.texture)

status.text = status:CreateFontString(nil, "OVERLAY")
status.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
status.text:SetPoint("CENTER", bar, "CENTER", 0, 0)

-- Update Function
local update = 1
status:SetScript("OnUpdate", function(self, elapsed)
	if not bar:IsShown() then return end
	update = update + elapsed

	if update >= 1 then
		local power = UnitPower("player", ALTERNATE_POWER_INDEX)
		local mpower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
		local texture, r, g, b = UnitAlternatePowerTextureInfo("player", 2, 0)
		if blizzColors[texture] then
			r, g, b = blizzColors[texture].r, blizzColors[texture].g, blizzColors[texture].b
		end
		self:SetMinMaxValues(0, mpower)
		self:SetValue(power)
		self.text:SetText(power.."/"..mpower)
		self:SetStatusBarColor(r, g, b)
		self.bg:SetVertexColor(r, g, b, 0.25)
		update = 0
	end
end)