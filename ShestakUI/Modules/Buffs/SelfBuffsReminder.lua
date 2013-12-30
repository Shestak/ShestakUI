local T, C, L, _ = unpack(select(2, ...))
if C.reminder.solo_buffs_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Self buffs on player(by Tukz and Elv22)
----------------------------------------------------------------------------------------
local tab = T.ReminderSelfBuffs[T.class]
if not tab then return end

local function OnEvent(self, event, arg1, arg2)
	local group = tab[self.id]
	if not group.spells and not group.weapon then return end
	if not GetActiveSpecGroup() then return end
	if event == "UNIT_AURA" and arg1 ~= "player" then return end
	if group.level and UnitLevel("player") < group.level then return end

	self.icon:SetTexture(nil)
	self:Hide()
	if group.negate_spells then
		for _, buff in pairs(group.negate_spells) do
			local name = GetSpellInfo(buff)
			if (name and UnitBuff("player", name)) then
				return
			end
		end
	end

	local hasOffhandWeapon = OffhandHasWeapon()
	local hasMainHandEnchant, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()
	if not group.weapon then
		for _, buff in pairs(group.spells) do
			local name, _, icon = GetSpellInfo(buff)
			local usable, nomana = IsUsableSpell(name)
			if usable or nomana or group.level then
				self.icon:SetTexture(icon)
				break
			end
		end

		if not self.icon:GetTexture() and event == "PLAYER_LOGIN" then
			self:UnregisterAllEvents()
			self:RegisterEvent("LEARNED_SPELL_IN_TAB")
			return
		elseif self.icon:GetTexture() and event == "LEARNED_SPELL_IN_TAB" then
			self:UnregisterAllEvents()
			self:RegisterEvent("UNIT_AURA")
			if group.combat and group.combat == true then
				self:RegisterEvent("PLAYER_REGEN_ENABLED")
				self:RegisterEvent("PLAYER_REGEN_DISABLED")
			end

			if (group.instance and group.instance == true) or (group.pvp and group.pvp == true) then
				self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			end

			if group.role and group.role == true then
				self:RegisterEvent("UNIT_INVENTORY_CHANGED")
			end
		end
	else
		self:UnregisterAllEvents()
		self:RegisterEvent("UNIT_INVENTORY_CHANGED")

		if hasOffhandWeapon == nil then
			if hasMainHandEnchant == nil then
				self.icon:SetTexture(GetInventoryItemTexture("player", 16))
			end
		else
			if hasOffHandEnchant == nil then
				self.icon:SetTexture(GetInventoryItemTexture("player", 17))
			end

			if hasMainHandEnchant == nil then
				self.icon:SetTexture(GetInventoryItemTexture("player", 16))
			end
		end

		if group.combat and group.combat == true then
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
			self:RegisterEvent("PLAYER_REGEN_DISABLED")
		end

		if (group.instance and group.instance == true) or (group.pvp and group.pvp == true) then
			self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		end

		if group.role and group.role == true then
			self:RegisterEvent("UNIT_INVENTORY_CHANGED")
		end
	end

	local role = group.role
	local spec = group.spec
	local combat = group.combat
	local personal = group.personal
	local instance = group.instance
	local pvp = group.pvp
	local reversecheck = group.reversecheck
	local negate_reversecheck = group.negate_reversecheck
	local canplaysound = false
	local rolepass = false
	local specpass = false
	local _, instanceType, difficultyID = GetInstanceInfo()

	if role ~= nil then
		if role == T.Role then
			rolepass = true
		else
			rolepass = false
		end
	else
		rolepass = true
	end

	if spec ~= nil then
		if spec == GetSpecialization() then
			specpass = true
		else
			specpass = false
		end
	else
		specpass = true
	end

	-- Prevent user error
	if reversecheck ~= nil and (role == nil and spec == nil) then reversecheck = nil end

	-- Only time we allow it to play a sound
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_REGEN_DISABLED") and C.reminder.solo_buffs_sound == true then canplaysound = true end

	if not group.weapon then
		if ((combat and UnitAffectingCombat("player")) or (instance and difficultyID ~= 0) or (pvp and (instanceType == "arena" or instanceType == "pvp"))) and
		specpass == true and rolepass == true and not UnitInVehicle("player") then
			for _, buff in pairs(group.spells) do
				local name = GetSpellInfo(buff)
				local _, _, icon, _, _, _, _, unitCaster = UnitBuff("player", name)
				if personal and personal == true then
					if name and icon and unitCaster == "player" then
						self:Hide()
						return
					end
				else
					if name and icon then
						self:Hide()
						return
					end
				end
			end
			self:Show()
			if canplaysound == true then PlaySoundFile(C.media.warning_sound, "Master") end
		elseif ((combat and UnitAffectingCombat("player")) or (instance and difficultyID ~= 0)) and
		reversecheck == true and not UnitInVehicle("player") then
			if negate_reversecheck and negate_reversecheck == GetSpecialization() then self:Hide() return end
			for _, buff in pairs(group.spells) do
				local name = GetSpellInfo(buff)
				local _, _, icon, _, _, _, _, unitCaster = UnitBuff("player", name)
				if name and icon and unitCaster == "player" then
					self:Show()
					if canplaysound == true then PlaySoundFile(C.media.warning_sound, "Master") end
					return
				end
			end
		else
			self:Hide()
		end
	else
		if ((combat and UnitAffectingCombat("player")) or (instance and difficultyID ~= 0) or (pvp and (instanceType == "arena" or instanceType == "pvp"))) and
		specpass == true and rolepass == true and not UnitInVehicle("player") then
			if hasOffhandWeapon == nil then
				if hasMainHandEnchant == nil then
					self:Show()
					self.icon:SetTexture(GetInventoryItemTexture("player", 16))
					if canplaysound == true then PlaySoundFile(C.media.warning_sound, "Master") end
					return
				end
			else
				if hasMainHandEnchant == nil or hasOffHandEnchant == nil then
					self:Show()
					if hasMainHandEnchant == nil then
						self.icon:SetTexture(GetInventoryItemTexture("player", 16))
					else
						self.icon:SetTexture(GetInventoryItemTexture("player", 17))
					end
					if canplaysound == true then PlaySoundFile(C.media.warning_sound, "Master") end
					return
				end
			end
			self:Hide()
			return
		else
			self:Hide()
			return
		end
	end
end

for i = 1, #tab do
	local frame = CreateFrame("Frame", "ReminderFrame"..i, UIParent)
	frame:CreatePanel("Default", C.reminder.solo_buffs_size, C.reminder.solo_buffs_size, unpack(C.position.self_buffs))
	frame:SetFrameLevel(1)
	frame.id = i

	frame.icon = frame:CreateTexture(nil, "OVERLAY")
	frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	frame.icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
	frame.icon:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
	frame.icon:SetSize(C.reminder.solo_buffs_size, C.reminder.solo_buffs_size)

	frame:Hide()

	frame:RegisterEvent("UNIT_AURA")
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	frame:RegisterEvent("UNIT_ENTERED_VEHICLE")
	frame:RegisterEvent("UNIT_EXITED_VEHICLE")
	frame:SetScript("OnEvent", OnEvent)
	frame:SetScript("OnUpdate", function(self, elapsed)
		if not self.icon:GetTexture() then
			self:Hide()
		end
	end)
	frame:SetScript("OnShow", function(self)
		if not self.icon:GetTexture() then
			self:Hide()
		end
	end)
end