local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

----------------------------------------------------------------------------------------
--	Skin AltPowerBar(by Tukz)
----------------------------------------------------------------------------------------
local blizzColors = {
	["INTERFACE\\UNITPOWERBARALT\\XAVIUS_HORIZONTAL_FILL.BLP"] = {r = 0.4, g = 0.1, b = 0.6},
	["INTERFACE\\UNITPOWERBARALT\\TWINOGRONDISTANCE_HORIZONTAL_FILL.BLP"] = {r = 0.5, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\SHADOWPALADINBAR_HORIZONTAL_FILL.BLP"] = {r = 0.4, g = 0.05, b = 0.67},
	["INTERFACE\\UNITPOWERBARALT\\NAARUCHARGE_HORIZONTAL_FILL.BLP"] = {r = 0.5, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\KARGATHROARCROWD_HORIZONTAL_FILL.BLP"] = {r = 0.5, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\BULLETBAR_HORIZONTAL_FILL.BLP"] = {r = 0.5, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\FELCORRUPTIONRED_HORIZONTAL_FILL.BLP"] = {r = 0.8, g = 0.05, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\FELCORRUPTION_HORIZONTAL_FILL.BLP"] = {r = 0.13, g = 0.55, b = 0.13},
	["INTERFACE\\UNITPOWERBARALT\\GARROSHENERGY_HORIZONTAL_FILL.BLP"] = {r = 0.4, g = 0.05, b = 0.67},
	["INTERFACE\\UNITPOWERBARALT\\ARSENAL_HORIZONTAL_FILL.BLP"] = {r = 1, g = 0, b = 0.2},
	["INTERFACE\\UNITPOWERBARALT\\PRIDE_HORIZONTAL_FILL.BLP"] = {r = 0.2, g = 0.4, b = 1},
	["INTERFACE\\UNITPOWERBARALT\\LIGHTNING_HORIZONTAL_FILL.BLP"] = {r = 0.12, g = 0.56, b = 1},
	["INTERFACE\\UNITPOWERBARALT\\THUNDERKING_HORIZONTAL_FILL.BLP"] = {r = 0.12, g = 0.56, b = 1},
	["INTERFACE\\UNITPOWERBARALT\\AMBER_HORIZONTAL_FILL.BLP"] = {r = 0.97, g = 0.81, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDAMETHYST_HORIZONTAL_FILL.BLP"] = {r = 0.67, g = 0, b = 1},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDCOBALT_HORIZONTAL_FILL.BLP"] = {r = 0.1, g = 0.4, b = 0.95},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDJADE_HORIZONTAL_FILL.BLP"] = {r = 0.13, g = 0.55, b = 0.13},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDJASPER_HORIZONTAL_FILL.BLP"] = {r = 1, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\BREWINGSTORM_HORIZONTAL_FILL.BLP"] = {r = 1, g = 0.84, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\SHAWATER_HORIZONTAL_FILL.BLP"] = {r = 0.1, g = 0.6, b = 1},
	["INTERFACE\\UNITPOWERBARALT\\ARCANE_CIRCULAR_FILL.BLP"] = {r = 0.52, g = 0.44, b = 1},
	["INTERFACE\\UNITPOWERBARALT\\MOLTENFEATHERS_HORIZONTAL_FILL.BLP"] = {r = 1, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\RHYOLITH_HORIZONTAL_FILL.BLP"] = {r = 1, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\CHOGALL_HORIZONTAL_FILL.BLP"] = {r = 0.4, g = 0.05, b = 0.67},
	["INTERFACE\\UNITPOWERBARALT\\ONYXIA_HORIZONTAL_FILL.BLP"] = {r = 0.4, g = 0.05, b = 0.67},
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
bar:SetScript("OnMouseDown", function(self, button)
	if IsAltKeyDown() or IsShiftKeyDown() then
		bar:ClearAllPoints()
		bar:StartMoving()
	elseif IsControlKeyDown() and button == "RightButton" then
		bar:SetPoint(unpack(C.position.alt_power_bar))
	end
end)
bar:SetScript("OnMouseUp", function()
	bar:StopMovingOrSizing()
end)

-- Event handling
bar:RegisterEvent("UNIT_POWER_UPDATE")
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
	local name = select(11, UnitAlternatePowerInfo("player"))
	local tooltip = select(12, UnitAlternatePowerInfo("player"))

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -5)
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
		if texture then
			texture = string.upper(texture)
		end
		if blizzColors[texture] then
			r, g, b = blizzColors[texture].r, blizzColors[texture].g, blizzColors[texture].b
		elseif not texture then
			r, g, b = 0.3, 0.7, 0.3
		end
		self:SetMinMaxValues(0, mpower)
		self:SetValue(power)
		self.text:SetText(power.."/"..mpower)
		self:SetStatusBarColor(r, g, b)
		self.bg:SetVertexColor(r, g, b, 0.25)
		update = 0
	end
end)