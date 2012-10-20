local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Skin AltPowerBar(by Tukz)
----------------------------------------------------------------------------------------
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
status:SetStatusBarColor(0.3, 0.7, 0.3)

status.bg = status:CreateTexture(nil, "BACKGROUND")
status.bg:SetAllPoints(status)
status.bg:SetTexture(C.media.texture)
status.bg:SetVertexColor(0.3, 0.7, 0.3, 0.25)

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
		self:SetMinMaxValues(0, mpower)
		self:SetValue(power)
		self.text:SetText(power.."/"..mpower.." - "..floor(power / mpower * 100).."%")
		update = 0
	end
end)