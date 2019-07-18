if select(2, UnitClass("player")) ~= "MONK" then return end

local _, ns = ...
local oUF = ns.oUF

local SPELL_POWER_CHI = Enum.PowerType.Chi or 12

local function Update(self, _, unit, powerType)
	if(self.unit ~= unit and (powerType and (powerType ~= "CHI" and powerType ~= "DARK_FORCE"))) then return end

	local element = self.HarmonyBar

	if(element.PreUpdate) then
		element:PreUpdate(unit)
	end

	local cur = UnitPower("player", SPELL_POWER_CHI)
	local max = UnitPowerMax("player", SPELL_POWER_CHI)
	local spacing = select(4, element[5]:GetPoint())
	local barWidth = element:GetWidth()
	local lastBar = 0

	if element.max ~= max then
		if max == 5 then
			element[6]:Hide()
		else
			element[6]:Show()
		end

		for i = 1, max do
			if i ~= max then
				element[i]:SetWidth(barWidth / max - spacing)
				lastBar = lastBar + (barWidth / max)
			else
				element[i]:SetWidth(barWidth - lastBar)
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

	if(element.PostUpdate) then
		return element:PostUpdate(cur)
	end
end

local function Path(self, ...)
	return (self.HarmonyBar.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit, "CHI")
end

local function Visibility(self)
	local element = self.HarmonyBar
	local spec = GetSpecialization()

	if spec == SPEC_MONK_WINDWALKER then
		element:Show()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	else
		element:Hide()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
	end
end

local function Enable(self, unit)
	local element = self.HarmonyBar
	if element and unit == "player" then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER_UPDATE", Path)
		self:RegisterEvent("UNIT_DISPLAYPOWER", Path)
		self:RegisterEvent("UNIT_MAXPOWER", Path)

		element.hadler = CreateFrame("Frame", nil, element)
		element.hadler:RegisterEvent("PLAYER_TALENT_UPDATE")
		element.hadler:RegisterEvent("PLAYER_ENTERING_WORLD")
		element.hadler:SetScript("OnEvent", function() Visibility(self) end)

		element.maxChi = 0

		return true
	end
end

local function Disable(self)
	local element = self.HarmonyBar
	if(element) then
		self:UnregisterEvent("UNIT_POWER_UPDATE", Path)
		self:UnregisterEvent("UNIT_DISPLAYPOWER", Path)
		self:UnregisterEvent("UNIT_MAXPOWER", Path)
		element.hadler:UnregisterEvent("PLAYER_TALENT_UPDATE")
		element.hadler:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

oUF:AddElement("HarmonyBar", Path, Enable, Disable)