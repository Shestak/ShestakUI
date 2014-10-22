local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe_class_bar.vengeance ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_VengeanceBar(by Evilpaul)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local VENGEANCE_ID = GetSpellInfo(158300)

local Update = function(self, event, unit)
	if self.unit ~= unit then return end

	local vb = self.VengeanceBar

	if vb.PreUpdate then vb:PreUpdate(unit) end

	local _, _, _, _, _, _, _, _, _, _, spellid, _, _, _, vengeanceValue = UnitBuff("player", VENGEANCE_ID)

	if spellid == 158300 and vengeanceValue and vengeanceValue > 0 then
		vb.Bar:SetMinMaxValues(0, 200)

		if vb.Text then
			vb.Text:SetText(vengeanceValue)
		end

		vb.Bar:SetValue(vengeanceValue)
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