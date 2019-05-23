local T, C, L = unpack(select(2, ...))

local _, ns = ...
local oUF = ns.oUF

local MAX_COMBO_POINTS = MAX_COMBO_POINTS

local function Update(self, event, unit, powerType)
	if(self.unit ~= unit and (powerType and (powerType ~= "COMBO_POINTS"))) then return end

	local element = self.CPoints
	local cur, max

	if not IsClassicBuild() then
		if UnitHasVehicleUI("player") then
			cur = UnitPower("vehicle", 4)
			max = UnitPowerMax("vehicle", 4)
		else
			cur = UnitPower("player", 4)
			max = UnitPowerMax("player", 4)
		end
	else
		cur = UnitPower("player", 14)
		max = UnitPowerMax("player", 14)
	end

	if max == 0 then
		max = MAX_COMBO_POINTS
	end

	local spacing = select(4, element[5]:GetPoint())
	local w = element:GetWidth()
	local s = 0

	if element.max ~= max then
		if not IsClassicBuild() then
			if max == 6 then
				element[6]:Show()
			else
				element[6]:Hide()
			end
		else
			if max == 5 then
				element[5]:Show()
			else
				element[5]:Hide()
			end
		end

		for i = 1, max do
			if i ~= max then
				element[i]:SetWidth(w / max - spacing)
				s = s + (w / max)
			else
				element[i]:SetWidth(w - s)
			end
		end

		element.max = max
	end

	for i = 1, max do
		if i <= cur then
			element[i]:SetAlpha(1)
		else
			element[i]:SetAlpha(0.2)
		end
	end

	if C.unitframe_class_bar.combo_old == true or (T.class ~= "DRUID" and T.class ~= "ROGUE") then
		if element[1]:GetAlpha() == 1 then
			for i = 1, max do
				element:Show()
				element[i]:Show()
			end
		else
			for i = 1, max do
				element:Hide()
				element[i]:Hide()
			end
		end

		if self.RangeBar then
			if element[1]:IsShown() and self.RangeBar:IsShown() then
				element:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 21)
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 33) end
			elseif element[1]:IsShown() or self.RangeBar:IsShown() then
				element:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
			else
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5) end
			end
		else
			if element[1]:IsShown() then
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
			else
				if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5) end
			end
		end
	end
end

local function Path(self, ...)
	return (self.CPoints.Override or Update) (self, ...)
end

local function Visibility(self)
	local element = self.CPoints
	local form = GetShapeshiftFormID()

	if form == CAT_FORM or (UnitHasVehicleUI("player") and UnitPower("vehicle", 4) > 0) then
		element:Show()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	else
		element:Hide()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
	end
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit, "COMBO_POINTS")
end

local Enable = function(self)
	local element = self.CPoints
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER_UPDATE", Path, true)
		self:RegisterEvent("UNIT_MAXPOWER", Path, true)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Path, true)

		if T.class == "DRUID" and C.unitframe_class_bar.combo_always ~= true and C.unitframe_class_bar.combo_old ~= true then
			element.hadler = CreateFrame("Frame", nil, element)
			element.hadler:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
			element.hadler:RegisterEvent("PLAYER_ENTERING_WORLD")
			element.hadler:SetScript("OnEvent", function() Visibility(self) end)
		end

		for index = 1, MAX_COMBO_POINTS do
			local cpoint = element[index]
			if(cpoint:IsObjectType"Texture" and not cpoint:GetTexture()) then
				cpoint:SetTexture[[Interface\ComboFrame\ComboPoint]]
				cpoint:SetTexCoord(0, 0.375, 0, 1)
			end
		end

		return true
	end
end

local Disable = function(self)
	local element = self.CPoints
	if(element) then
		self:UnregisterEvent("UNIT_POWER_UPDATE", Path)
		self:UnregisterEvent("UNIT_MAXPOWER", Path)
		element.hadler:UnregisterEvent("UPDATE_SHAPESHIFT_FORM")
		element.hadler:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

oUF:AddElement("CPoints", Path, Enable, Disable)