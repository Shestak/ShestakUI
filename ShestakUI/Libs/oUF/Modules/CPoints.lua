local T, C, L = unpack(select(2, ...))

local _, ns = ...
local oUF = ns.oUF

local MAX_COMBO_POINTS = MAX_COMBO_POINTS

local Update = function(self, event, unit, powerType)
	if powerType and powerType ~= "COMBO_POINTS" then return end
	if unit == "pet" then return end

	local cpoints = self.CPoints
	local cur, max

	if UnitHasVehicleUI("player") then
		cur = UnitPower("vehicle", 4)
		max = UnitPowerMax("vehicle", 4)
	else
		cur = UnitPower("player", 4)
		max = UnitPowerMax("player", 4)
	end

	if max == 0 then
		max = MAX_COMBO_POINTS
	end

	local spacing = select(4, cpoints[5]:GetPoint())
	local w = cpoints:GetWidth()
	local s = 0

	if cpoints.max ~= max then
		if max == 6 then
			cpoints[6]:Show()
		else
			cpoints[6]:Hide()
		end

		for i = 1, max do
			if i ~= max then
				cpoints[i]:SetWidth(w / max - spacing)
				s = s + (w / max)
			else
				cpoints[i]:SetWidth(w - s)
			end
		end

		cpoints.max = max
	end

	for i = 1, max do
		if i <= cur then
			cpoints[i]:SetAlpha(1)
		else
			cpoints[i]:SetAlpha(0.2)
		end
	end

	if C.unitframe_class_bar.combo_old == true or (T.class ~= "DRUID" and T.class ~= "ROGUE") then
		if cpoints[1]:GetAlpha() == 1 then
			for i = 1, max do
				cpoints:Show()
				cpoints[i]:Show()
			end
		else
			for i = 1, max do
				cpoints:Hide()
				cpoints[i]:Hide()
			end
		end

		if self.RangeBar then
			if cpoints[1]:IsShown() and self.RangeBar:IsShown() then
				cpoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 21)
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 33) end
			elseif cpoints[1]:IsShown() or self.RangeBar:IsShown() then
				cpoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
			else
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5) end
			end
		else
			if cpoints[1]:IsShown() then
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
			else
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5) end
			end
		end
	end
end

local Path = function(self, ...)
	return (self.CPoints.Override or Update) (self, ...)
end

local function Visibility(self, event, unit)
	local cpoints = self.CPoints
	local form = GetShapeshiftFormID()

	if form == CAT_FORM or (UnitHasVehicleUI("player") and UnitPower("vehicle", 4) > 0) then
		cpoints:Show()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	else
		cpoints:Hide()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
	end
end

local function VisibilityPath(self, ...)
	return (self.CPoints.OverrideVisibility or Visibility) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local Enable = function(self)
	local cpoints = self.CPoints
	if(cpoints) then
		cpoints.__owner = self
		cpoints.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER_UPDATE", Path, true)
		self:RegisterEvent("UNIT_MAXPOWER", Path, true)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Path)

		if T.class == "DRUID" and C.unitframe_class_bar.combo_always ~= true and C.unitframe_class_bar.combo_old ~= true then
			self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", VisibilityPath)
		end

		for index = 1, MAX_COMBO_POINTS do
			local cpoint = cpoints[index]
			if(cpoint:IsObjectType"Texture" and not cpoint:GetTexture()) then
				cpoint:SetTexture[[Interface\ComboFrame\ComboPoint]]
				cpoint:SetTexCoord(0, 0.375, 0, 1)
			end
		end

		return true
	end
end

local Disable = function(self)
	local cpoints = self.CPoints
	if(cpoints) then
		self:UnregisterEvent("UNIT_POWER_UPDATE", Path)
		self:UnregisterEvent("UNIT_MAXPOWER", Path)
		self:UnregisterEvent("PLAYER_TARGET_CHANGED", Path)
		self:UnregisterEvent("UPDATE_SHAPESHIFT_FORM", VisibilityPath)
	end
end

oUF:AddElement("CPoints", Path, Enable, Disable)