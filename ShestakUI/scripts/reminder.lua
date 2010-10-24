----------------------------------------------------------------------------------------
--	Self buffs on player(by Tukz)
----------------------------------------------------------------------------------------
if SettingsCF["reminder"].solo_buffs_enable == true then
	local buffs = SettingsDB.buffs_reminder[SettingsDB.class]
	local sound

	if (buffs and buffs[1]) then
		local function OnEvent(self, event)
			if (event == "PLAYER_LOGIN" or event == "LEARNED_SPELL_IN_TAB") then
				for i, buff in pairs(buffs) do
					local name = GetSpellInfo(buff)
					local usable, nomana = IsUsableSpell(name)
					if (usable or nomana) then
						self.icon:SetTexture(select(3, GetSpellInfo(buff)))
						break
					end
				end
				if (not self.icon:GetTexture() and event == "PLAYER_LOGIN") then
					self:UnregisterAllEvents()
					self:RegisterEvent("LEARNED_SPELL_IN_TAB")
					return
				elseif (self.icon:GetTexture() and event == "LEARNED_SPELL_IN_TAB") then
					self:UnregisterAllEvents()
					self:RegisterEvent("UNIT_AURA")
					self:RegisterEvent("PLAYER_LOGIN")
					self:RegisterEvent("PLAYER_REGEN_ENABLED")
					self:RegisterEvent("PLAYER_REGEN_DISABLED")
				end
			end
			if (UnitAffectingCombat("player") and not UnitInVehicle("player")) then
				for i, buff in pairs(buffs) do
					local name = GetSpellInfo(buff)
					if (name and UnitBuff("player", name)) then
						self:Hide()
						sound = true
						return
					end
				end
				self:Show()
				if SettingsCF["reminder"].solo_buffs_sound == true and sound == true then
					PlaySound("RaidWarning")
					sound = false
				end
			else
				self:Hide()
				sound = true
			end
		end

		local frame = CreateFrame("Frame", _, UIParent)
		SettingsDB.CreatePanel(frame, SettingsCF["reminder"].solo_buffs_size + 4, SettingsCF["reminder"].solo_buffs_size + 4, "CENTER", UIParent, "CENTER", 0, 190)
		
		frame.icon = frame:CreateTexture(nil, "OVERLAY")
		frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.icon:SetPoint("CENTER")
		frame.icon:SetWidth(SettingsCF["reminder"].solo_buffs_size)
		frame.icon:SetHeight(SettingsCF["reminder"].solo_buffs_size)
		frame:Hide()
		
		frame:RegisterEvent("UNIT_AURA")
		frame:RegisterEvent("PLAYER_LOGIN")
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
		frame:RegisterEvent("PLAYER_REGEN_DISABLED")
		frame:RegisterEvent("UNIT_ENTERING_VEHICLE")
		frame:RegisterEvent("UNIT_ENTERED_VEHICLE")
		frame:RegisterEvent("UNIT_EXITING_VEHICLE")
		frame:RegisterEvent("UNIT_EXITED_VEHICLE")

		frame:SetScript("OnEvent", OnEvent)
	end
end

----------------------------------------------------------------------------------------
--	Raid buffs on player(by Elv22)
----------------------------------------------------------------------------------------
if SettingsCF["reminder"].raid_buffs_enable == true then
	-- Locals
	local flaskbuffs = SettingsDB.raid_buffs_reminder["Flask"]
	local battleelixirbuffs = SettingsDB.raid_buffs_reminder["BattleElixir"]
	local guardianelixirbuffs = SettingsDB.raid_buffs_reminder["GuardianElixir"]
	local foodbuffs = SettingsDB.raid_buffs_reminder["Food"]
	local visible
	local flasked
	local battleelixired
	local guardianelixired
	local food
	local spell3
	local spell4
	local spell5
	local spell6

	-- Setup caster buffs
	local function SetCasterOnlyBuffs()
		Spell3Buff = {	-- Total Stats
			69378,	-- Drums of Forgotten Kings
			20217,	-- Blessing of Kings
			90363,	-- Embrace of the Shale Spider
			1126,	-- Mark of the Wild
		}
		Spell4Buff = {	-- Total Stamina
			21562,	-- Power Word: Fortitude
			469,	-- Commanding Shout
			6307,	-- Blood Pact
			90364,	-- Qiraji Fortitude
			69377,	-- Runescroll of Fortitude
		}
		Spell5Buff = {	-- Total Mana
			61316,	-- Dalaran Brilliance
			48100,	-- Scroll of Intellect VIII
			1459,	-- Arcane Brilliance
		}
		Spell6Buff = {	-- Mana Regen
			24853,	-- Mana Spring Totem
			19740,	-- Blessing of Might
		}
	end
	
	-- Setup everyone else's buffs
	local function SetBuffs()
		Spell3Buff = {	-- Total Stats
			69378,	-- Drums of Forgotten Kings
			20217,	-- Blessing of Kings
			90363,	-- Embrace of the Shale Spider
			1126,	-- Mark of the Wild
		}
		Spell4Buff = {	-- Total Stamina
			21562,	-- Power Word: Fortitude
			469,	-- Commanding Shout
			6307,	-- Blood Pact
			90364,	-- Qiraji Fortitude
			69377,	-- Runescroll of Fortitude
		}
		Spell5Buff = {	-- Total Mana
			61316,	-- Dalaran Brilliance
			48100,	-- Scroll of Intellect VIII
			1459,	-- Arcane Brilliance
		}
		Spell6Buff = {	-- Total AP
			53138,	-- Abom Might
			19506,	-- Trushot
			30808,	-- Unleashed Rage
			19740,	-- Blessing of Might
		}
	end

	-- We need to check if you have two differant elixirs if your not flasked, before we say your not flasked
	local function CheckElixir(unit)
		if (battleelixirbuffs and battleelixirbuffs[1]) then
			for i, battleelixirbuffs in pairs(battleelixirbuffs) do
				local spellname = select(1, GetSpellInfo(battleelixirbuffs))
				if UnitAura("player", spellname) then
					FlaskFrame.t:SetTexture(select(3, GetSpellInfo(battleelixirbuffs)))
					battleelixired = true
					break
				else
					battleelixired = false
				end
			end
		end
		
		if (guardianelixirbuffs and guardianelixirbuffs[1]) then
			for i, guardianelixirbuffs in pairs(guardianelixirbuffs) do
				local spellname = select(1, GetSpellInfo(guardianelixirbuffs))
				if UnitAura("player", spellname) then
					guardianelixired = true
					if not battleelixired then
						FlaskFrame.t:SetTexture(select(3, GetSpellInfo(guardianelixirbuffs)))
					end
					break
				else
					guardianelixired = false
				end
			end
		end	
		
		if guardianelixired == true and battleelixired == true then
			FlaskFrame:SetAlpha(SettingsCF["reminder"].raid_buffs_alpha)
			flasked = true
			return
		else
			FlaskFrame:SetAlpha(1)
			flasked = false
		end
	end

	-- Main Script
	local function OnAuraChange(self, event, arg1, unit)
		if (event == "UNIT_AURA" and arg1 ~= "player") then 
			return
		end

		-- If We're a caster we may want to see differant buffs
		if SettingsDB.Role == "Caster" then 
			SetCasterOnlyBuffs() 
		else
			SetBuffs()
		end
		
		-- Start checking buffs to see if we can find a match from the list
		if (flaskbuffs and flaskbuffs[1]) then
			FlaskFrame.t:SetTexture(select(3, GetSpellInfo(flaskbuffs[1])))
			for i, flaskbuffs in pairs(flaskbuffs) do
				local spellname = select(1, GetSpellInfo(flaskbuffs))
				if UnitAura("player", spellname) then
					FlaskFrame.t:SetTexture(select(3, GetSpellInfo(flaskbuffs)))
					FlaskFrame:SetAlpha(SettingsCF["reminder"].raid_buffs_alpha)
					flasked = true
					break
				else
					CheckElixir()
				end
			end
		end
		
		if (foodbuffs and foodbuffs[1]) then
			FoodFrame.t:SetTexture(select(3, GetSpellInfo(foodbuffs[1])))
			for i, foodbuffs in pairs(foodbuffs) do
				local spellname = select(1, GetSpellInfo(foodbuffs))
				if UnitAura("player", spellname) then
					FoodFrame:SetAlpha(SettingsCF["reminder"].raid_buffs_alpha)
					FoodFrame.t:SetTexture(select(3, GetSpellInfo(foodbuffs)))
					food = true
					break
				else
					FoodFrame:SetAlpha(1)
					food = false
				end
			end
		end
		
		for i, Spell3Buff in pairs(Spell3Buff) do
			local spellname = select(1, GetSpellInfo(Spell3Buff))
			if UnitAura("player", spellname) then
				Spell3Frame:SetAlpha(SettingsCF["reminder"].raid_buffs_alpha)
				Spell3Frame.t:SetTexture(select(3, GetSpellInfo(Spell3Buff)))
				spell3 = true
				break
			else
				Spell3Frame:SetAlpha(1)
				Spell3Frame.t:SetTexture(select(3, GetSpellInfo(Spell3Buff)))
				spell3 = false
			end
		end
		
		for i, Spell4Buff in pairs(Spell4Buff) do
			local spellname = select(1, GetSpellInfo(Spell4Buff))
			if UnitAura("player", spellname) then
				Spell4Frame:SetAlpha(SettingsCF["reminder"].raid_buffs_alpha)
				Spell4Frame.t:SetTexture(select(3, GetSpellInfo(Spell4Buff)))
				spell4 = true
				break
			else
				Spell4Frame:SetAlpha(1)
				Spell4Frame.t:SetTexture(select(3, GetSpellInfo(Spell4Buff)))
				spell4 = false
			end
		end
		
		for i, Spell5Buff in pairs(Spell5Buff) do
			local spellname = select(1, GetSpellInfo(Spell5Buff))
			if UnitAura("player", spellname) then
				Spell5Frame:SetAlpha(SettingsCF["reminder"].raid_buffs_alpha)
				Spell5Frame.t:SetTexture(select(3, GetSpellInfo(Spell5Buff)))
				spell5 = true
				break
			else
				Spell5Frame:SetAlpha(1)
				Spell5Frame.t:SetTexture(select(3, GetSpellInfo(Spell5Buff)))
				spell5 = false
			end
		end
		
		for i, Spell6Buff in pairs(Spell6Buff) do
			local spellname = select(1, GetSpellInfo(Spell6Buff))
			if UnitAura("player", spellname) then
				Spell6Frame:SetAlpha(SettingsCF["reminder"].raid_buffs_alpha)
				Spell6Frame.t:SetTexture(select(3, GetSpellInfo(Spell6Buff)))
				spell6 = true
				break
			else
				Spell6Frame:SetAlpha(1)
				Spell6Frame.t:SetTexture(select(3, GetSpellInfo(Spell6Buff)))
				spell6 = false
			end
		end

		local inInstance, instanceType = IsInInstance()
		if not (inInstance and (instanceType == "raid")) and SettingsCF["reminder"].raid_buffs_always == false then
			RaidBuffReminder:SetAlpha(0)
			visible = false
		elseif flasked == true and food == true and spell3 == true and spell4 == true and spell5 == true and spell6 == true then
			if not visible then
				RaidBuffReminder:SetAlpha(0)
				visible = false
			end
			if visible then
				UIFrameFadeOut(RaidBuffReminder, 0.5)
				visible = false
			end
		else
			if not visible then
				UIFrameFadeIn(RaidBuffReminder, 0.5)
				visible = true
			end
		end
	end

	-- Create Main bar
	local raidbuff_reminder = CreateFrame("Frame", "RaidBuffReminder", UIParent)
	SettingsDB.CreatePanel(raidbuff_reminder, (SettingsCF["reminder"].raid_buffs_size * 6) + 15, SettingsCF["reminder"].raid_buffs_size + 4, "BOTTOMLEFT", Minimap, "TOPLEFT", -1, 5)
	raidbuff_reminder:SetBackdropBorderColor(0, 0, 0, 0)
	raidbuff_reminder:SetBackdropColor(0, 0, 0, 0)
	raidbuff_reminder.bg:SetVertexColor(0, 0, 0, 0)
	raidbuff_reminder:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	raidbuff_reminder:RegisterEvent("UNIT_INVENTORY_CHANGED")
	raidbuff_reminder:RegisterEvent("UNIT_AURA")
	raidbuff_reminder:RegisterEvent("PLAYER_ENTERING_WORLD")
	raidbuff_reminder:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	raidbuff_reminder:RegisterEvent("CHARACTER_POINTS_CHANGED")
	raidbuff_reminder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	raidbuff_reminder:SetScript("OnEvent", OnAuraChange)

	-- Function to create buttons
	local function CreateButton(name, relativeTo, firstbutton)
		local button = CreateFrame("Frame", name, RaidBuffReminder)
		if firstbutton == true then
			SettingsDB.CreatePanel(button, SettingsCF["reminder"].raid_buffs_size, SettingsCF["reminder"].raid_buffs_size, "BOTTOMLEFT", relativeTo, "BOTTOMLEFT", 2, 2)
		else
			SettingsDB.CreatePanel(button, SettingsCF["reminder"].raid_buffs_size, SettingsCF["reminder"].raid_buffs_size, "LEFT", relativeTo, "RIGHT", 7, 0)
		end
		button:SetFrameLevel(RaidBuffReminder:GetFrameLevel() + 2)
		button:SetBackdropBorderColor(0, 0, 0, 0)
		
		button.FrameBackdrop = CreateFrame("Frame", nil, button)
		SettingsDB.CreateTemplate(button.FrameBackdrop)
		button.FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		button.FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		button.FrameBackdrop:SetFrameLevel(button:GetFrameLevel() - 1)	
		
		button.t = button:CreateTexture(name..".t", "OVERLAY")
		button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.t:SetAllPoints(button)
	end

	-- Create Buttons
	do
		CreateButton("FlaskFrame", RaidBuffReminder, true)
		CreateButton("FoodFrame", FlaskFrame, false)
		CreateButton("Spell3Frame", FoodFrame, false)
		CreateButton("Spell4Frame", Spell3Frame, false)
		CreateButton("Spell5Frame", Spell4Frame, false)
		CreateButton("Spell6Frame", Spell5Frame, false)
	end
end