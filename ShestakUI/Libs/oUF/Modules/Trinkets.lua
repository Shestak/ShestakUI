local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Trinkets(by Allez)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local trinketSpells = {
	[208683] = 120,
	[195710] = 180,
	[42292] = 120
}

local GetTrinketIcon = function(unit)
	if UnitFactionGroup(unit) == "Horde" then
		return "Interface\\Icons\\INV_Jewelry_TrinketPVP_02"
	else
		return "Interface\\Icons\\INV_Jewelry_TrinketPVP_01"
	end
end

local Update = function(self, event, ...)
	local _, instanceType = IsInInstance()
	if instanceType ~= "arena" then
		self.Trinket:Hide()
		return
	else
		self.Trinket:Show()
	end

	if self.Trinket.PreUpdate then self.Trinket:PreUpdate(event) end

	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, eventType, _, sourceGUID, _, _, _, _, _, _, _, spellID = ...
		if eventType == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID(self.unit) and trinketSpells[spellID] then
			CooldownFrame_Set(self.Trinket.cooldownFrame, GetTime(), trinketSpells[spellID], 1)
		end
	elseif event == "ARENA_OPPONENT_UPDATE" then
		local unit, type = ...
		if type == "seen" then
			if UnitExists(unit) and UnitIsPlayer(unit) then
				self.Trinket.Icon:SetTexture(GetTrinketIcon(unit))
			end
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		CooldownFrame_Set(self.Trinket.cooldownFrame, 1, 1, 1)
	end

	if self.Trinket.PostUpdate then self.Trinket:PostUpdate(event) end
end

local Enable = function(self)
	if self.Trinket then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", Update)
		self:RegisterEvent("ARENA_OPPONENT_UPDATE", Update)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)

		if not self.Trinket.cooldownFrame then
			self.Trinket.cooldownFrame = CreateFrame("Cooldown", nil, self.Trinket, "CooldownFrameTemplate")
			self.Trinket.cooldownFrame:SetPoint("TOPLEFT", self.Trinket, 2, -2)
			self.Trinket.cooldownFrame:SetPoint("BOTTOMRIGHT", self.Trinket, -2, 2)
		end

		if not self.Trinket.Icon then
			self.Trinket.Icon = self.Trinket:CreateTexture(nil, "BORDER")
			self.Trinket.Icon:SetPoint("TOPLEFT", self.Trinket, 2, -2)
			self.Trinket.Icon:SetPoint("BOTTOMRIGHT", self.Trinket, -2, 2)
			self.Trinket.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			self.Trinket.Icon:SetTexture(GetTrinketIcon("player"))
		end

		return true
	end
end

local Disable = function(self)
	if self.Trinket then
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", Update)
		self:UnregisterEvent("ARENA_OPPONENT_UPDATE", Update)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		self.Trinket:Hide()
	end
end

oUF:AddElement("Trinket", Update, Enable, Disable)