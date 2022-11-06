if(select(2, UnitClass("player")) ~= "EVOKER") then return end
--[[ Written for ViksUI by Vik, but should work as normal plugin for oUF 
## Example

-- Essence Charges (Devastation Evoker)
lib.addEssence = function(self)
	if T.class == "EVOKER" then
		-- Essence bar
		if C.unitframe_class_bar.essence == true then
			self.Essence = CreateFrame("Frame", self:GetName().."_Essence", self, "BackdropTemplate", "BackdropTemplate")
			local maxEssence = UnitPowerMax(self.unit, Enum.PowerType.Essence)
			self.Essence:CreateBackdrop("Default")
			self.Essence:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1,7)
			self.Essence:SetHeight(7)
			self.Essence:SetWidth(self:GetWidth()-2)

			for i = 1, 6 do
				self.Essence[i] = CreateFrame("StatusBar", self:GetName().."_Essence"..i, self.Essence, "BackdropTemplate")
				self.Essence[i]:SetSize(213 / 10, 7)
				if i == 1 then
					self.Essence[i]:SetPoint("LEFT", self.Essence)
				else
					self.Essence[i]:SetPoint("TOPLEFT", self.Essence[i-1], "TOPRIGHT", 1, 0)
				end
				self.Essence[i]:SetStatusBarTexture(C.media.texture)
				self.Essence[i]:SetStatusBarColor(0.4, 0.8, 1)

				self.Essence[i].bg = self.Essence[i]:CreateTexture(nil, "BORDER")
				self.Essence[i].bg:SetAllPoints()
				self.Essence[i].bg:SetTexture(C.media.texture)
				self.Essence[i].bg:SetVertexColor(0.4, 0.8, 1, 0.2)
			end
		end
	end
end

]]--

local _, ns = ...
local oUF = ns.oUF

local SPELL_POWER_ESSENCE = Enum.PowerType.Essence

local function Update(self, _, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= "ESSENCE")) then return end
	local maxEssence = UnitPowerMax(self.unit, Enum.PowerType.Essence)
	local element = self.Essence

	if(element.PreUpdate) then
		element:PreUpdate(unit)
	end

	if UnitHasVehicleUI("player") then
		element:Hide()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
	else
		element:Show()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	end

	local cur = UnitPower("player", SPELL_POWER_ESSENCE)
	local max = maxEssence

	local spacing = select(4, element[5]:GetPoint())
	local w = element:GetWidth()
	local s = 0

	if element.max ~= max then
		if max == 6 then
			element[6]:Show()
			element[5]:Show()
		else
			element[6]:Hide()
			element[5]:Show()
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
		if(i <= cur) then
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
	return (self.Essence.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit, "ESSENCE")
end

local function Visibility(self)
	local element = self.Essence

	if not UnitHasVehicleUI("player") then
		element:Show()
		if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	end
	self:RegisterEvent("UNIT_POWER_UPDATE", Path)
end

local function Enable(self)
	local element = self.Essence
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate
		
		self:RegisterEvent("UNIT_POWER_UPDATE", Path, true)
		self:RegisterEvent("UNIT_MAXPOWER", Path, true)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Path, true)
		
		element.handler = CreateFrame("Frame", nil, element)
		element.handler:RegisterEvent("PLAYER_TALENT_UPDATE")
		element.handler:RegisterEvent("PLAYER_ENTERING_WORLD")
		element.handler:SetScript("OnEvent", function() Visibility(self) end)

		return true
	end
end

local function Disable(self)
	local element = self.Essence
	if(element) then
		self:UnregisterEvent("UNIT_POWER_UPDATE", Path)
		self:UnregisterEvent("UNIT_MAXPOWER", Path)
		self:UnregisterEvent("PLAYER_TARGET_CHANGED", Path)
		element.handler:UnregisterEvent("PLAYER_TALENT_UPDATE")
		element.handler:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

oUF:AddElement("Essence", Path, Enable, Disable)
