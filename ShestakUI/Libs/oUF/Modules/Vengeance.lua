local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe_class_bar.vengeance ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_VengeanceBar(by Evilpaul)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local VENGEANCE_ID = 132365
local tooltip = CreateFrame("GameTooltip", "VengeanceTooltip", UIParent, "GameTooltipTemplate")

local Update = function(self, event, unit)
	if self.unit ~= unit then return end

	local vb = self.VengeanceBar

	if vb.PreUpdate then vb:PreUpdate(unit) end

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

	if hasAura then
		tooltip:SetOwner(UIParent, "ANCHOR_NONE")
		tooltip:SetUnitAura(self.unit, i, "HELPFUL")
		local text = VengeanceTooltipTextLeft2:GetText()
		tooltip:Hide()

		local _, maxHealth = self.Health:GetMinMaxValues()
		vb.Bar:SetMinMaxValues(0, maxHealth / 4)

		local textValue = text:match("%d+")

		if vb.Text then
			vb.Text:SetText(textValue)
		end

		local value = tonumber(textValue)
		vb.Bar:SetValue(value and value or 0)

		vb:Show()

		if self.Debuffs then
			if (T.class == "PALADIN" and C.unitframe_class_bar.holy == true)
			or (T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune == true)
			or (T.class == "MONK" and C.unitframe_class_bar.chi == true) then
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 33)
			elseif (T.class == "WARRIOR" or T.class == "DRUID")
			or (T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune ~= true)
			or (T.class == "PALADIN" and C.unitframe_class_bar.holy ~= true)
			or (T.class == "MONK" and C.unitframe_class_bar.chi ~= true) then
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19)
			end
		end
	else
		vb:Hide()

		if self.Debuffs then
			if (T.class == "PALADIN" and C.unitframe_class_bar.holy == true)
			or (T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune == true)
			or (T.class == "MONK" and C.unitframe_class_bar.chi == true) then
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19)
			elseif (T.class == "WARRIOR" or (T.class == "DRUID" and T.Role == "Tank"))
			or (T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune ~= true)
			or (T.class == "PALADIN" and C.unitframe_class_bar.holy ~= true)
			or (T.class == "MONK" and C.unitframe_class_bar.chi ~= true) then
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5)
			end
		end
	end

	if vb.PostUpdate then
		return vb:PostUpdate(unit)
	end
end

local Path = function(self, ...)
	return (self.VengeanceBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Update(element.__owner, "ForceUpdate", element.__owner.unit)
end

local Enable = function(self)
	local vb = self.VengeanceBar
	if vb then
		vb.__owner = self
		vb.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_AURA", Path)
		self:RegisterEvent("UNIT_MAXHEALTH", Path)

		return true
	end
end

local Disable = function(self)
	local vb = self.VengeanceBar
	if vb then
		self:UnregisterEvent("UNIT_AURA", Path)
		self:UnregisterEvent("UNIT_MAXHEALTH", Path)
	end
end

oUF:AddElement("VengeanceBar", Path, Enable, Disable)