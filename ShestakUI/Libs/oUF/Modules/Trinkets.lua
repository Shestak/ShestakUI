local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Trinkets(by Allez, editor Tukz)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF not loaded')

local Update = function(self, event, ...)
	local _, instanceType = IsInInstance()

	if instanceType ~= 'arena' then
		self.Trinket.Icon:SetTexture("Interface\\Icons\\Ability_pvp_gladiatormedallion")
		self.Trinket:Hide()

		return
	else
		self.Trinket:Show()
	end

	if(self.Trinket.PreUpdate) then self.Trinket:PreUpdate(event, ...) end

	if event == "ARENA_COOLDOWNS_UPDATE" then
		local unit = ...

		if self.unit == unit then
			C_PvP.RequestCrowdControlSpell(unit)

			local spellID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(unit)

			if spellID and startTime ~= 0 and duration ~= 0 then
				CooldownFrame_Set(self.Trinket.cooldownFrame, startTime / 1000, duration / 1000, 1)
			end
		end
	elseif event == "ARENA_CROWD_CONTROL_SPELL_UPDATE" then
		local unit, spellID = ...

		if self.unit == unit then
			local _, _, spellTexture = GetSpellInfo(spellID)

			self.Trinket.Icon:SetTexture(spellTexture)
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		CooldownFrame_Set(self.Trinket.cooldownFrame, 1, 1, 1)
	end

	if(self.Trinket.PostUpdate) then self.Trinket:PostUpdate(event, ...) end
end

local Enable = function(self)
	if self.Trinket then
		self:RegisterEvent("ARENA_COOLDOWNS_UPDATE", Update, true)
		self:RegisterEvent("ARENA_CROWD_CONTROL_SPELL_UPDATE", Update, true)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update, true)

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
			self.Trinket.Icon:SetTexture("Interface\\Icons\\Ability_pvp_gladiatormedallion")
		end

		return true
	end
end

local Disable = function(self)
	if self.Trinket then
		self:UnregisterEvent("ARENA_COOLDOWNS_UPDATE", Update)
		self:UnregisterEvent("ARENA_CROWD_CONTROL_SPELL_UPDATE", Update)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		self.Trinket:Hide()
	end
end

oUF:AddElement('Trinket', Update, Enable, Disable)