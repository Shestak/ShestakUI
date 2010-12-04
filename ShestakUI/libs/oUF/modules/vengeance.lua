if SettingsCF.unitframe.plugins_vengeance_bar ~= true then return end

local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'VengeanceBar was unable to locate oUF install')

local VENGEANCE_ID = 76691
local tooltip = CreateFrame('GameTooltip', 'VengeanceTooltip', UIParent, 'GameTooltipTemplate')

local Update = function(self, event, unit)
	if(self.unit ~= unit) then return end

	local vb = self.VengeanceBar

	if(vb.PreUpdate) then vb:PreUpdate(unit) end

	-- check unit auras for vengeance
	local hasAura = false
	local i = 1
	repeat
		local _, _, _, _, _, _, _, _, _, _, spellID = UnitAura(self.unit, i)

		if spellID == VENGEANCE_ID then
			hasAura = true
			break
		end

		i = i + 1
	until not spellID

	if(hasAura) then
		-- get vengeance stack value
		tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
		tooltip:SetUnitAura(self.unit, i, 'HELPFUL')
		local text = VengeanceTooltipTextLeft2:GetText()
		tooltip:Hide()

		local _, maxHealth = self.Health:GetMinMaxValues()
		vb.Bar:SetMinMaxValues(0, maxHealth / 10)
		
		local textValue = text:match('%d+')
		local maxVengeance = floor(0.1*UnitHealthMax("player"))
		
		if(vb.Text) then
			vb.Text:SetText(textValue.." / "..maxVengeance)
		end

		local value = tonumber(textValue)
		vb.Bar:SetValue(value and value or 0)

		vb:Show()
		
		if self.Debuffs then 
			self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(19)) 
		end
	else
		vb:Hide()
		
		if self.Debuffs then 
			self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(5))
		end
	end

	if(vb.PostUpdate) then
		return vb:PostUpdate(unit)
	end
end

local Path = function(self, ...)
	return (self.VengeanceBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Update(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local Enable = function(self)
	local vb = self.VengeanceBar
	if(vb) then
		vb.__owner = self
		vb.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_AURA', Path)
		self:RegisterEvent('UNIT_MAXHEALTH', Path)

		if(vb.Bar and not vb.Bar:GetStatusBarTexture()) then
			vb.Bar:SetStatusBarTexture[[Interface\TargetingFrame\UI-StatusBar]]
		end

		return true
	end
end

local Disable = function(self)
	local vb = self.VengeanceBar
	if(vb) then
		self:UnregisterEvent('UNIT_AURA', Path)
		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
	end
end

oUF:AddElement('VengeanceBar', Path, Enable, Disable)