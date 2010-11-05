----------------------------------------------------------------------------------------
--	
----------------------------------------------------------------------------------------
if not SettingsCF["unitframe"].enable == true then return end

local db = SettingsCF["unitframe"]
local pos = SettingsCF["position"].unitframes
local backdrop = {
	bgFile = SettingsCF["media"].blank,
	insets = {top = -SettingsDB.mult, left = -SettingsDB.mult, bottom = -SettingsDB.mult, right = -SettingsDB.mult},
}

----------------------------------------------------------------------------------------
--	Layout
----------------------------------------------------------------------------------------
local function Shared(self, unit)
	-- Set our own colors
	self.colors = SettingsDB.oUF_colors

	-- Register click
	self:RegisterForClicks("AnyDown")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	local unit = (unit and unit:find("arena%dtarget")) and "arenatarget" 
	or (unit and unit:find("arena%d")) and "arena"
	or (unit and unit:find("boss%d")) and "boss" or unit
	
	-- Menu
	self.menu = SettingsDB.SpawnMenu
	
	if (unit == "arena" and db.show_arena == true and unit ~= "arenatarget") or (unit == "boss" and db.show_boss == true) then
		self:SetAttribute("type2", "focus")
	else
		self:SetAttribute("*type2", "menu")
	end
	
	-- Backdrop for every units
	self.FrameBackdrop = CreateFrame("Frame", nil, self)
	SettingsDB.CreateTemplate(self.FrameBackdrop)
	self.FrameBackdrop:SetFrameStrata("BACKGROUND")
	self.FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	self.FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))

	-- Health bar
	self.Health = CreateFrame("StatusBar", self:GetName().."_Health", self)
	if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
		self.Health:SetHeight(SettingsDB.Scale(21))
	elseif unit == "arenatarget" then
		self.Health:SetHeight(SettingsDB.Scale(27))
	else
		self.Health:SetHeight(SettingsDB.Scale(13))
	end
	self.Health:SetPoint("TOPLEFT")
	self.Health:SetPoint("TOPRIGHT")
	self.Health:SetStatusBarTexture(SettingsCF["media"].texture)

	self.Health.frequentUpdates = true
	if db.own_color == true then
		self.Health.colorTapping = false
		self.Health.colorDisconnected = false
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
	else
		self.Health.colorTapping = true
		self.Health.colorDisconnected = true
		self.Health.colorClass = true
		self.Health.colorReaction = true
	end
	if db.plugins_smooth_bar == true then
		self.Health.Smooth = true
	end
	
	self.Health.PostUpdate = SettingsDB.PostUpdateHealth

	-- Health bar background
	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints()
	self.Health.bg:SetTexture(SettingsCF["media"].texture)
	if db.own_color == true then
		self.Health.bg:SetVertexColor(0.1, 0.1, 0.1)	
	else
		self.Health.bg.multiplier = 0.25
	end
	
	self.Health.value = SettingsDB.SetFontString(self.Health, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
	if unit == "player" or unit == "pet" or unit == "focus" then
		self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
		self.Health.value:SetJustifyH("RIGHT")
	elseif unit == "arena" then
		if db.arena_on_right == true then
			self.Health.value:SetPoint("LEFT", self.Health, "LEFT", SettingsDB.Scale(2), 0)
			self.Health.value:SetJustifyH("LEFT")
		else
			self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			self.Health.value:SetJustifyH("RIGHT")
		end
	else
		self.Health.value:SetPoint("LEFT", self.Health, "LEFT", SettingsDB.Scale(2), 0)
		self.Health.value:SetJustifyH("LEFT")
	end

	-- Power bar
	self.Power = CreateFrame("StatusBar", self:GetName().."_Power", self)
	if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
		self.Power:SetHeight(SettingsDB.Scale(5))
	elseif unit == "arenatarget" then
		self.Power:SetHeight(0)
	else
		self.Power:SetHeight(SettingsDB.Scale(2))
	end		
	self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -SettingsDB.mult)
	self.Power:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -SettingsDB.mult)
	self.Power:SetStatusBarTexture(SettingsCF["media"].texture)

	self.Power.frequentUpdates = true
	self.Power.colorDisconnected = true
	self.Power.colorTapping = true
	if db.own_color == true then
		self.Power.colorClass = true
	else
		self.Power.colorPower = true
	end
	if db.plugins_smooth_bar == true then
		self.Power.Smooth = true
	end

	self.Power.PreUpdate = SettingsDB.PreUpdatePower
	self.Power.PostUpdate = SettingsDB.PostUpdatePower
		
	self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
	self.Power.bg:SetAllPoints()
	self.Power.bg:SetTexture(SettingsCF["media"].texture)
	self.Power.bg.multiplier = 0.3
	
	self.Power.value = SettingsDB.SetFontString(self.Power, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
	if unit == "player" then
		self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", 0, 0)
		self.Power.value:SetJustifyH("RIGHT")
	elseif unit == "arena" then
		if db.arena_on_right == true then
			self.Power.value:SetPoint("LEFT", self.Power, "LEFT", SettingsDB.Scale(2), 0)
			self.Power.value:SetJustifyH("LEFT")
		else
			self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", 0, 0)
			self.Power.value:SetJustifyH("RIGHT")
		end
	elseif unit == "pet" then
		self.Power.value:Hide()
	else
		self.Power.value:SetPoint("LEFT", self.Power, "LEFT", SettingsDB.Scale(2), 0)
		self.Power.value:SetJustifyH("LEFT")
	end

	-- Names
	if unit ~= "player" then
		self.Info = SettingsDB.SetFontString(self.Health, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
		if unit ~= "arenatarget" then
			self.Level = SettingsDB.SetFontString(self.Power, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
		end
		if unit == "target" then
			self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			self:Tag(self.Info, "[GetNameColor][NameLong]")
			self.Level:SetPoint("RIGHT", self.Power, "RIGHT", 0, 0)
			self:Tag(self.Level, "[cpoints] [Threat] [DiffColor][level][shortclassification]")
		elseif unit == "focus" or unit == "pet" then
			self.Info:SetPoint("LEFT", self.Health, "LEFT", SettingsDB.Scale(2), 0)
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
			if unit == "pet" then
				self:RegisterEvent("UNIT_PET", SettingsDB.UpdatePetInfo)
			end
		elseif unit == "arenatarget" then
			self.Info:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
			self:Tag(self.Info, "[GetNameColor][NameArena]")
		elseif unit == "arena" then
			if db.arena_on_right == true then
				self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
				self:Tag(self.Info, "[GetNameColor][NameMedium]")
			else
				self.Info:SetPoint("LEFT", self.Health, "LEFT", SettingsDB.Scale(2), 0)
				self:Tag(self.Info, "[GetNameColor][NameMedium]")
			end
		else
			self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
		end
	end

	if unit == "player" then
		self.FlashInfo = CreateFrame("Frame", "FlashInfo", self)
		self.FlashInfo:SetScript("OnUpdate", SettingsDB.UpdateManaLevel)
		self.FlashInfo.parent = self
		self.FlashInfo:SetToplevel(true)
		self.FlashInfo:SetAllPoints(self.Health)

		self.FlashInfo.ManaLevel = SettingsDB.SetFontString(self.FlashInfo, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
		self.FlashInfo.ManaLevel:SetPoint("CENTER", 0, SettingsDB.Scale(1))
		
		-- Combat icon
		if db.icons_combat == true then
			self.Combat = self.Health:CreateTexture(nil, "OVERLAY")
			self.Combat:SetSize(SettingsDB.Scale(18), SettingsDB.Scale(18))
			self.Combat:SetPoint("TOPRIGHT", SettingsDB.Scale(4), SettingsDB.Scale(8))
		end

		-- Resting icon
		if db.icons_resting == true and SettingsDB.level ~= MAX_PLAYER_LEVEL then
			self.Resting = self.Power:CreateTexture(nil, "OVERLAY")
			self.Resting:SetSize(SettingsDB.Scale(18), SettingsDB.Scale(18))
			self.Resting:SetPoint("BOTTOMLEFT", SettingsDB.Scale(-8), SettingsDB.Scale(-8))
		end

		-- Leader/Assistant/ML icons
		if db.icons_leader == true then
			-- Leader icon
			self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
			self.Leader:SetSize(SettingsDB.Scale(14), SettingsDB.Scale(14))
			self.Leader:SetPoint("TOPLEFT", SettingsDB.Scale(-3), SettingsDB.Scale(9))

			-- Assistant icon
			self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
			self.Assistant:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
			self.Assistant:SetPoint("TOPLEFT", SettingsDB.Scale(-3), SettingsDB.Scale(8))

			-- Master looter icon
			self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
			self.MasterLooter:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
			self.MasterLooter:SetPoint("TOPRIGHT", SettingsDB.Scale(3), SettingsDB.Scale(8))
		end
		
		-- LFD role icons
		if db.icons_lfd_role == true then 
			self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
			self.LFDRole:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
			self.LFDRole:SetPoint("TOPLEFT", SettingsDB.Scale(10), SettingsDB.Scale(8))
		end

		-- Rune bar
		if db.plugins_rune_bar == true and SettingsDB.class == "DEATHKNIGHT" then
			self.Runes = CreateFrame("Frame", nil, self)
			self.Runes:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, SettingsDB.Scale(7))
			self.Runes:SetHeight(SettingsDB.Scale(7))
			self.Runes:SetWidth(SettingsDB.Scale(217))
			self.Runes:SetBackdrop(backdrop)
			self.Runes:SetBackdropColor(0, 0, 0)

			for i = 1, 6 do
				self.Runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, self)
				self.Runes[i]:SetSize((217 / 6 - 0.85), 7)
				if (i == 1) then
					self.Runes[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, SettingsDB.Scale(7))
				else
					self.Runes[i]:SetPoint("TOPLEFT", self.Runes[i-1], "TOPRIGHT", SettingsDB.Scale(1), 0)
				end
				self.Runes[i]:SetStatusBarTexture(SettingsCF["media"].texture)
				
				self.Runes[i].bg = self.Runes[i]:CreateTexture(nil, "BORDER")
				self.Runes[i].bg:SetAllPoints()
				self.Runes[i].bg:SetTexture(SettingsCF["media"].texture)
				self.Runes[i].bg.multiplier = 0.25
				
				self.Runes[i].FrameBackdrop = CreateFrame("Frame", nil, self.Runes[i])
				SettingsDB.CreateTemplate(self.Runes[i].FrameBackdrop)
				self.Runes[i].FrameBackdrop:SetFrameStrata("BACKGROUND")
				self.Runes[i].FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
				self.Runes[i].FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			end
		end

		-- Totem bar
		if db.plugins_totem_bar == true and SettingsDB.class == "SHAMAN" then
			self.TotemBar = {}
			self.TotemBar.Destroy = true
			for i = 1, 4 do
				self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
				self.TotemBar[i]:SetSize((214 / 4), 7)
				if (i == 1) then
					self.TotemBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, SettingsDB.Scale(7))
				else
					self.TotemBar[i]:SetPoint("TOPLEFT", self.TotemBar[i-1], "TOPRIGHT", SettingsDB.Scale(1), 0)
				end
				self.TotemBar[i]:SetStatusBarTexture(SettingsCF["media"].texture)
				self.TotemBar[i]:SetMinMaxValues(0, 1)

				self.TotemBar[i]:SetBackdrop(backdrop)
				self.TotemBar[i]:SetBackdropColor(0, 0, 0)

				self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
				self.TotemBar[i].bg:SetAllPoints()
				self.TotemBar[i].bg:SetTexture(SettingsCF["media"].texture)
				self.TotemBar[i].bg.multiplier = 0.30
				
				self.TotemBar[i].FrameBackdrop = CreateFrame("Frame", nil, self.TotemBar[i])
				SettingsDB.CreateTemplate(self.TotemBar[i].FrameBackdrop)
				self.TotemBar[i].FrameBackdrop:SetFrameStrata("BACKGROUND")
				self.TotemBar[i].FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
				self.TotemBar[i].FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
				
				if db.plugins_totem_bar_name == true then
					self.TotemBar[i].Name = SettingsDB.SetFontString(self.TotemBar[i], SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
					self.TotemBar[i].Name:SetPoint("CENTER", self.TotemBar[i], "CENTER", 0, 0)
					self.TotemBar[i].Name:SetTextColor(1, 1, 1)
				end
			end
		end

		-- Druid mana
		if SettingsDB.class == "DRUID" then
			CreateFrame("Frame"):SetScript("OnUpdate", function() SettingsDB.UpdateDruidMana(self) end)
			self.DruidMana = SettingsDB.SetFontString(self.Power, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
			self.DruidMana:SetTextColor(1, 0.49, 0.04)
			
			if db.plugins_eclipse_bar == true then
				local eclipseBar = CreateFrame("Frame", "EclipseBar", self)
				eclipseBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, SettingsDB.Scale(7))
				eclipseBar:SetSize(SettingsDB.Scale(217), SettingsDB.Scale(7))
				eclipseBar:SetFrameStrata("MEDIUM")
				eclipseBar:SetFrameLevel(8)
				eclipseBar:SetBackdrop(backdrop)
				eclipseBar:SetBackdropColor(0, 0, 0)
				eclipseBar:SetScript("OnShow", function() SettingsDB.UpdateEclipse(self, false) end)
				eclipseBar:SetScript("OnUpdate", function() SettingsDB.UpdateEclipse(self, true) end)
				eclipseBar:SetScript("OnHide", function() SettingsDB.UpdateEclipse(self, false) end)
				
				eclipseBar.FrameBackdrop = CreateFrame("Frame", nil, eclipseBar)
				SettingsDB.CreateTemplate(eclipseBar.FrameBackdrop)
				eclipseBar.FrameBackdrop:SetFrameStrata("BACKGROUND")
				eclipseBar.FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
				eclipseBar.FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			
				local lunarBar = CreateFrame("StatusBar", nil, eclipseBar)
				lunarBar:SetPoint("LEFT", eclipseBar, "LEFT", 0, 0)
				lunarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
				lunarBar:SetStatusBarTexture(SettingsCF["media"].texture)
				lunarBar:SetStatusBarColor(0.30, 0.30, 0.80)
				eclipseBar.LunarBar = lunarBar

				local solarBar = CreateFrame("StatusBar", nil, eclipseBar)
				solarBar:SetPoint("LEFT", lunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
				solarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
				solarBar:SetStatusBarTexture(SettingsCF["media"].texture)
				solarBar:SetStatusBarColor(0.80, 0.80, 0.20)
				eclipseBar.SolarBar = solarBar
				
				local eclipseBarText = SettingsDB.SetFontString(solarBar, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
				eclipseBarText:SetPoint("CENTER", eclipseBar, "CENTER", SettingsDB.Scale(-6), 0)
				eclipseBar.PostUpdatePower = SettingsDB.EclipseDirection
				
				local eclipseBarPers = SettingsDB.SetFontString(solarBar, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
				eclipseBarPers:SetPoint("LEFT", eclipseBarText, "RIGHT", SettingsDB.Scale(2), 0)
				self:Tag(eclipseBarPers, "[pereclipse]%")
				
				self.EclipseBar = eclipseBar
				self.EclipseBar.Text = eclipseBarText
			end
		end
		
		-- Holy power bar or shard bar
		if (SettingsDB.class == "WARLOCK" and db.plugins_shard_bar == true) or (SettingsDB.class == "PALADIN" and db.plugins_holy_bar == true) then
			local bars = CreateFrame("Frame", nil, self)
			bars:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, SettingsDB.Scale(7))
			bars:SetWidth(SettingsDB.Scale(217))
			bars:SetHeight(SettingsDB.Scale(7))
			bars:SetBackdrop(backdrop)
			bars:SetBackdropColor(0, 0, 0)
			
			for i = 1, 3 do					
				bars[i]=CreateFrame("StatusBar", self:GetName().."_Shard"..i, self)
				bars[i]:SetHeight(SettingsDB.Scale(7))					
				bars[i]:SetStatusBarTexture(SettingsCF["media"].texture)

				bars[i].bg = bars[i]:CreateTexture(nil, "BORDER")
				bars[i].bg:SetTexture(SettingsCF["media"].texture)
				
				if SettingsDB.class == "WARLOCK" then
					bars[i]:SetStatusBarColor(0.70, 0.32, 0.75)
					bars[i].bg:SetTexture(0.70, 0.32, 0.75, 0.25)
				elseif SettingsDB.class == "PALADIN" then
					bars[i]:SetStatusBarColor(0.89, 0.88, 0.1)
					bars[i].bg:SetTexture(0.89, 0.88, 0.1, 0.25)
				end
					
				if i == 1 then
					bars[i]:SetPoint("LEFT", bars)
					bars[i]:SetWidth(SettingsDB.Scale(71))
					bars[i].bg:SetAllPoints(bars[i])
				else
					bars[i]:SetPoint("LEFT", bars[i-1], "RIGHT", SettingsDB.Scale(1), 0)
					bars[i]:SetWidth(SettingsDB.Scale(72))
					bars[i].bg:SetAllPoints(bars[i])
				end
			end
			
			bars.FrameBackdrop = CreateFrame("Frame", nil, bars)
			SettingsDB.CreateTemplate(bars.FrameBackdrop)
			bars.FrameBackdrop:SetFrameStrata("BACKGROUND")
			bars.FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
			bars.FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			
			if SettingsDB.class == "WARLOCK" then
				bars.Override = SettingsDB.UpdateShards				
				self.SoulShards = bars
			elseif SettingsDB.class == "PALADIN" then
				bars.Override = SettingsDB.UpdateHoly
				self.HolyPower = bars
			end
		end
		
		-- Experience bar
		if SettingsDB.level ~= MAX_PLAYER_LEVEL and db.plugins_experience_bar == true then
			self.Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
			self.Experience:SetHeight(SettingsDB.Scale(94))
			self.Experience:SetWidth(SettingsDB.Scale(7))
			self.Experience:SetOrientation("Vertical")
			self.Experience:SetPoint("TOPLEFT", self, "TOPLEFT", SettingsDB.Scale(-18), SettingsDB.Scale(28))
			self.Experience:SetStatusBarTexture(SettingsCF["media"].texture)
			self.Experience:SetStatusBarColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
			self.Experience:SetBackdrop(backdrop)
			self.Experience:SetBackdropColor(0, 0, 0)
			self.Experience:SetAlpha(0)

			self.Experience:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Experience:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

			self.Experience.bg = self.Experience:CreateTexture(nil, "BORDER")
			self.Experience.bg:SetAllPoints(self.Experience)
			self.Experience.bg:SetTexture(SettingsCF["media"].texture)
			self.Experience.bg:SetVertexColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 0.25)

			self.Experience.FrameBackdrop = CreateFrame("Frame", nil, self.Experience)
			SettingsDB.CreateTemplate(self.Experience.FrameBackdrop)
			self.Experience.FrameBackdrop:SetFrameLevel(1)
			self.Experience.FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
			self.Experience.FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			
			self.Experience.Tooltip = true
		end
		
		-- Reputation bar
		if db.plugins_reputation_bar == true then
			self.Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self)
			self.Reputation:SetHeight(SettingsDB.Scale(94))
			self.Reputation:SetWidth(SettingsDB.Scale(7))
			self.Reputation:SetOrientation("Vertical")
			self.Reputation:SetPoint("TOPLEFT", self, "TOPLEFT", SettingsDB.Scale(-32), SettingsDB.Scale(28))
			self.Reputation:SetStatusBarTexture(SettingsCF["media"].texture)
			self.Reputation:SetStatusBarColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
			self.Reputation:SetBackdrop(backdrop)
			self.Reputation:SetBackdropColor(0, 0, 0)
			self.Reputation:SetAlpha(0)

			self.Reputation:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Reputation:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

			self.Reputation.bg = self.Reputation:CreateTexture(nil, "BORDER")
			self.Reputation.bg:SetAllPoints(self.Reputation)
			self.Reputation.bg:SetTexture(SettingsCF["media"].texture)
			self.Reputation.bg:SetVertexColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 0.25)

			self.Reputation.FrameBackdrop = CreateFrame("Frame", nil, self.Reputation)
			SettingsDB.CreateTemplate(self.Reputation.FrameBackdrop)
			self.Reputation.FrameBackdrop:SetFrameLevel(1)
			self.Reputation.FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
			self.Reputation.FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			
			self.Reputation.PostUpdate = SettingsDB.UpdateReputationColor
			self.Reputation.Tooltip = true
		end
		
		-- Swing bar
		if db.plugins_swing == true then
			self.Swing = CreateFrame("StatusBar", self:GetName().."_Swing", self)
			self.Swing:SetStatusBarTexture(SettingsCF["media"].texture)
			self.Swing:SetStatusBarColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
			self.Swing:SetHeight(SettingsDB.Scale(5))
			self.Swing:SetWidth(SettingsDB.Scale(281))
			self.Swing:SetPoint("BOTTOMLEFT", "oUF_Player", "BOTTOMRIGHT", SettingsDB.Scale(35), SettingsDB.Scale(23))

			self.Swing.bg = self.Swing:CreateTexture(nil, "BORDER")
			self.Swing.bg:SetAllPoints(self.Swing)
			self.Swing.bg:SetTexture(SettingsCF["media"].texture)
			self.Swing.bg:SetVertexColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 0.25)

			self.Swing.FrameBackdrop = CreateFrame("Frame", nil, self.Swing)
			SettingsDB.CreateTemplate(self.Swing.FrameBackdrop)
			self.Swing.FrameBackdrop:SetFrameLevel(1)
			self.Swing.FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
			self.Swing.FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			
			self.Swing.Text = SettingsDB.SetFontString(self.Swing, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
			self.Swing.Text:SetPoint("CENTER", 0, 0)
			self.Swing.Text:SetTextColor(1, 1, 1)
		end
		
		-- GCD spark
		if db.plugins_gcd == true then
			self.GCD = CreateFrame("Frame", nil, self)
			self.GCD:SetWidth(SettingsDB.Scale(220))
			self.GCD:SetHeight(SettingsDB.Scale(3))
			self.GCD:SetFrameStrata("HIGH")
			self.GCD:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 0)

			self.GCD.Color = {1, 1, 1}
			self.GCD.Height = SettingsDB.Scale(3)
			self.GCD.Width = SettingsDB.Scale(4)
		end
	end

	if unit == "pet" or unit == "targettarget" or unit == "focus" or unit == "focustarget" then
		self.Debuffs = CreateFrame("Frame", nil, self)
		self.Debuffs:SetHeight(SettingsDB.Scale(25))
		self.Debuffs:SetWidth(SettingsDB.Scale(109))
		self.Debuffs.size = SettingsDB.Scale(25)
		self.Debuffs.spacing = SettingsDB.Scale(3)
		self.Debuffs.num = 4
		self.Debuffs["growth-y"] = "DOWN"
		if unit == "pet" or unit == "focus" then
			self.Debuffs:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-17))
			self.Debuffs.initialAnchor = "TOPRIGHT"
			self.Debuffs["growth-x"] = "LEFT"
		else
			self.Debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(-17))
			self.Debuffs.initialAnchor = "TOPLEFT"
			self.Debuffs["growth-x"] = "RIGHT"
		end
		self.Debuffs.PostCreateIcon = SettingsDB.PostCreateAura
		self.Debuffs.PostUpdateIcon = SettingsDB.PostUpdateIcon
	end

	if unit == "player" or unit == "target" then
		if db.portrait_enable == true then
			self.Portrait = CreateFrame("PlayerModel", nil, self)
			self.Portrait:SetHeight(db.portrait_height)
			self.Portrait:SetWidth(db.portrait_width)
			if unit == "player" then
				self.Portrait:SetPoint(unpack(SettingsCF["position"].unitframes.player_portrait))
			elseif unit == "target" then
				self.Portrait:SetPoint(unpack(SettingsCF["position"].unitframes.target_portrait))
			end

			self.PortraitOverlay = CreateFrame("StatusBar", self:GetName().."_PortraitOverlay", self.Portrait)
			self.PortraitOverlay:SetFrameLevel(self.PortraitOverlay:GetFrameLevel() - 1)
			if unit == "player" then
				SettingsDB.CreateTemplate(self.PortraitOverlay)
				if db.portrait_classcolor_border == true then
					self.PortraitOverlay:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
				end
			end
			self.PortraitOverlay:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
			self.PortraitOverlay:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			table.insert(self.__elements, SettingsDB.HidePortrait)
		end
		
		if unit == "player" then
			self.Debuffs = CreateFrame("Frame", nil, self)
			self.Debuffs:SetHeight(SettingsDB.Scale(165))
			self.Debuffs:SetWidth(SettingsDB.Scale(221))
			self.Debuffs.size = SettingsDB.Scale(25)
			self.Debuffs.spacing = SettingsDB.Scale(3)
			self.Debuffs.initialAnchor = "BOTTOMRIGHT"
			self.Debuffs["growth-y"] = "UP"
			self.Debuffs["growth-x"] = "LEFT"
			if (SettingsDB.class == "DEATHKNIGHT" and db.plugins_rune_bar == true) 
			or (SettingsDB.class == "SHAMAN" and db.plugins_totem_bar == true)
			or (SettingsDB.class == "DRUID" and db.plugins_eclipse_bar == true) 
			or (SettingsDB.class == "PALADIN" and db.plugins_holy_bar == true)
			or (SettingsDB.class == "WARLOCK" and db.plugins_shard_bar == true) then
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(19))
			else
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(5))
			end
			
			self.Debuffs.PostCreateIcon = SettingsDB.PostCreateAura
			self.Debuffs.PostUpdateIcon = SettingsDB.PostUpdateIcon
		end
		
		if unit == "target" then
			self.Auras = CreateFrame("Frame", nil, self)
			self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(5))
			self.Auras.initialAnchor = "BOTTOMLEFT"
			self.Auras["growth-x"] = "RIGHT"
			self.Auras["growth-y"] = "UP"
			self.Auras.numDebuffs = SettingsDB.Scale(16)
			self.Auras.numBuffs = SettingsDB.Scale(32)
			self.Auras:SetHeight(SettingsDB.Scale(165))
			self.Auras:SetWidth(SettingsDB.Scale(221))
			self.Auras.spacing = SettingsDB.Scale(3)
			self.Auras.size = SettingsDB.Scale(25)
			self.Auras.gap = true
			self.Auras.onlyShowPlayer = SettingsCF["aura"].player_aura_only
			self.Auras.PostCreateIcon = SettingsDB.PostCreateAura
			self.Auras.PostUpdateIcon = SettingsDB.PostUpdateIcon			

			if db.icons_combo_point == true then
				local CPoints = {}
				CPoints.unit = PlayerFrame.unit
				for i = 1, 5 do
					CPoints[i] = CreateFrame("StatusBar", nil, self)
					CPoints[i]:SetHeight(6)
					CPoints[i]:SetWidth(7)
					CPoints[i]:SetStatusBarTexture(SettingsCF["media"].blank)
					if i == 1 then
						CPoints[i]:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", SettingsDB.Scale(-7), 0)
						CPoints[i]:SetStatusBarColor(0.9, 0.1, 0.1)
					else
						CPoints[i]:SetPoint("BOTTOM", CPoints[i-1], "TOP", 0, SettingsDB.Scale(7))
					end
					CPoints[i].overlay = CreateFrame("Frame", nil, CPoints[i])
					SettingsDB.CreateTemplate(CPoints[i].overlay)
					CPoints[i].overlay:SetFrameStrata("BACKGROUND")
					CPoints[i].overlay:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
					CPoints[i].overlay:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
				end
				CPoints[2]:SetStatusBarColor(0.9, 0.1, 0.1)
				CPoints[3]:SetStatusBarColor(0.9, 0.9, 0.1)
				CPoints[4]:SetStatusBarColor(0.9, 0.9, 0.1)
				CPoints[5]:SetStatusBarColor(0.1, 0.9, 0.1)
				self.CPoints = CPoints
				self:RegisterEvent("UNIT_COMBO_POINTS", SettingsDB.UpdateCPoints)
			end
			if db.plugins_talents == true then
				self.Talents = SettingsDB.SetFontString(self.Power, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
				self.Talents:SetTextColor(1,0,0)
				self.Talents:SetPoint("BOTTOM", self.Power, "BOTTOM", 0, SettingsDB.Scale(-1))
			end
		end

		if db.plugins_combat_feedback == true then
			self.CombatFeedbackText = SettingsDB.SetFontString(self.Health, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size * 2, SettingsCF["font"].unit_frames_font_style)
			if db.portrait_enable == true then
				self.CombatFeedbackText:SetPoint("BOTTOM", self.Portrait, "BOTTOM", 0, 0)
				self.CombatFeedbackText:SetParent(self.Portrait)
			else
				self.CombatFeedbackText:SetPoint("CENTER", 0, SettingsDB.Scale(1))
			end
		end

		if db.icons_pvp == true then
			self.Status = SettingsDB.SetFontString(self.Health, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size * 2, SettingsCF["font"].unit_frames_font_style)
			self.Status:SetPoint("CENTER", 0, SettingsDB.Scale(1))
			self.Status:SetTextColor(0.69, 0.31, 0.31, 0)
			self:Tag(self.Status, "[pvp]")
			
			self:SetScript("OnEnter", function(self) FlashInfo.ManaLevel:Hide() self.Status:SetAlpha(1); UnitFrame_OnEnter(self) end)
			self:SetScript("OnLeave", function(self) FlashInfo.ManaLevel:Show() self.Status:SetAlpha(0); UnitFrame_OnLeave(self) end)
		end
	end

	if db.unit_castbar == true and unit ~= "arenatarget" then
		self.Castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
		self.Castbar:SetStatusBarTexture(SettingsCF["media"].texture, "OVERLAY")
		
		self.Castbar.bg = self.Castbar:CreateTexture(nil, "BORDER")
		self.Castbar.bg:SetAllPoints()
		self.Castbar.bg:SetTexture(SettingsCF["media"].texture)

		self.Castbar.Overlay = CreateFrame("Frame", nil, self.Castbar)
		SettingsDB.CreateTemplate(self.Castbar.Overlay)
		self.Castbar.Overlay:SetFrameStrata("BACKGROUND")
		self.Castbar.Overlay:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		self.Castbar.Overlay:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		
		self.Castbar.PostCastStart = SettingsDB.PostCastStart
		self.Castbar.PostChannelStart = SettingsDB.PostChannelStart

		if unit == "player" then
			if db.castbar_icon == true then
				self.Castbar:SetPoint(pos.player_castbar[1], pos.player_castbar[2], pos.player_castbar[3], pos.player_castbar[4], pos.player_castbar[5])
				self.Castbar:SetWidth(SettingsDB.Scale(258))
			else
				self.Castbar:SetPoint(pos.player_castbar[1], pos.player_castbar[2], pos.player_castbar[3], pos.player_castbar[4]-23, pos.player_castbar[5])
				self.Castbar:SetWidth(SettingsDB.Scale(281))
			end
			self.Castbar:SetHeight(SettingsDB.Scale(16))
		elseif unit == "target" then
			if db.castbar_icon == true then
				if db.plugins_swing == true then
					self.Castbar:SetPoint(pos.target_castbar[1], pos.target_castbar[2], pos.target_castbar[3], pos.target_castbar[4], pos.target_castbar[5])
				else
					self.Castbar:SetPoint(pos.target_castbar[1], pos.target_castbar[2], pos.target_castbar[3], pos.target_castbar[4], pos.target_castbar[5] - 12)
				end
				self.Castbar:SetWidth(SettingsDB.Scale(258))
			else
				if db.plugins_swing == true then
					self.Castbar:SetPoint(pos.target_castbar[1], pos.target_castbar[2], pos.target_castbar[3], pos.target_castbar[4] + 23, pos.target_castbar[5])
				else
					self.Castbar:SetPoint(pos.target_castbar[1], pos.target_castbar[2], pos.target_castbar[3], pos.target_castbar[4] + 23, pos.target_castbar[5] - 12)
				end
				self.Castbar:SetWidth(SettingsDB.Scale(281))
			end
			self.Castbar:SetHeight(SettingsDB.Scale(16))
		elseif unit == "arena" or unit == "boss" then
			self.Castbar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, SettingsDB.Scale(-7))
			self.Castbar:SetWidth(SettingsDB.Scale(150))
			self.Castbar:SetHeight(SettingsDB.Scale(16))
		else
			self.Castbar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, SettingsDB.Scale(-7))
			self.Castbar:SetWidth(SettingsDB.Scale(105))
			self.Castbar:SetHeight(SettingsDB.Scale(5))
		end
		
		if unit == "focus" then
			self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
			self.Castbar.Button:SetHeight(SettingsDB.Scale(65))
			self.Castbar.Button:SetWidth(SettingsDB.Scale(65))
			self.Castbar.Button:SetPoint(unpack(pos.focus_castbar))
			SettingsDB.CreateTemplate(self.Castbar.Button)

			self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
			self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, SettingsDB.Scale(2), SettingsDB.Scale(-2))
			self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, SettingsDB.Scale(-2), SettingsDB.Scale(2))
			self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			
			self.Castbar.Time = SettingsDB.SetFontString(self.Castbar, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size * 2, SettingsCF["font"].unit_frames_font_style)
			self.Castbar.Time:SetParent(self.Castbar.Button)
			self.Castbar.Time:SetPoint("CENTER", self.Castbar.Icon, "CENTER", 0, 0)
			self.Castbar.Time:SetTextColor(1, 1, 1)
			self.Castbar.CustomTimeText = SettingsDB.CustomCastTimeText
		end

		if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
			self.Castbar.Time = SettingsDB.SetFontString(self.Castbar, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
			self.Castbar.Time:SetPoint("RIGHT", self.Castbar, "RIGHT", 0, 0)
			self.Castbar.Time:SetTextColor(1, 1, 1)
			self.Castbar.Time:SetJustifyH("RIGHT")
			self.Castbar.CustomTimeText = SettingsDB.CustomCastTimeText
			self.Castbar.CustomDelayText = SettingsDB.CustomCastDelayText

			self.Castbar.Text = SettingsDB.SetFontString(self.Castbar, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
			self.Castbar.Text:SetPoint("LEFT", self.Castbar, "LEFT", SettingsDB.Scale(2), 0)
			self.Castbar.Text:SetPoint("RIGHT", self.Castbar.Time, "LEFT", SettingsDB.Scale(-1), 0)
			self.Castbar.Text:SetTextColor(1, 1, 1)
			self.Castbar.Text:SetJustifyH("LEFT")

			self.Castbar:HookScript("OnShow", function() self.Castbar.Text:Show(); self.Castbar.Time:Show() end)
			self.Castbar:HookScript("OnHide", function() self.Castbar.Text:Hide(); self.Castbar.Time:Hide() end)

			if db.castbar_icon == true and unit ~= "arena" then
				self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
				self.Castbar.Button:SetHeight(SettingsDB.Scale(20))
				self.Castbar.Button:SetWidth(SettingsDB.Scale(20))
				SettingsDB.CreateTemplate(self.Castbar.Button)

				self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
				self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, SettingsDB.Scale(2), SettingsDB.Scale(-2))
				self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, SettingsDB.Scale(-2), SettingsDB.Scale(2))
				self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				
				if unit == "player" then
					self.Castbar.Button:SetPoint("RIGHT", self.Castbar, "LEFT", SettingsDB.Scale(-5), 0)
				elseif unit == "target" then
					self.Castbar.Button:SetPoint("LEFT", self.Castbar, "RIGHT", SettingsDB.Scale(5), 0)
				end
			end
			
			if unit == "arena" then
				self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
				self.Castbar.Button:SetHeight(SettingsDB.Scale(20))
				self.Castbar.Button:SetWidth(SettingsDB.Scale(20))
				SettingsDB.CreateTemplate(self.Castbar.Button)
				self.Castbar.Button:SetPoint("TOPRIGHT", self.Castbar, "TOPLEFT", SettingsDB.Scale(-5), SettingsDB.Scale(2))

				self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
				self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, SettingsDB.Scale(2), SettingsDB.Scale(-2))
				self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, SettingsDB.Scale(-2), SettingsDB.Scale(2))
				self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end

			if unit == "player" and db.castbar_latency == true then
				self.Castbar.SafeZone = self.Castbar:CreateTexture(nil, "ARTWORK")
				self.Castbar.SafeZone:SetTexture(SettingsCF["media"].texture)
				self.Castbar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 1)

				self.Castbar.Latency = SettingsDB.SetFontString(self.Castbar, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
				self.Castbar.Latency:SetTextColor(1, 1, 1)
				self.Castbar.Latency:SetPoint("RIGHT", self.Castbar, "BOTTOMRIGHT", 0, SettingsDB.Scale(1))
				self.Castbar.Latency:SetJustifyH("RIGHT")
				
				self:RegisterEvent("UNIT_SPELLCAST_SENT", function(self, event, caster)
					if (caster == "player" or caster == "vehicle") then
						self.Castbar.castSent = GetTime()
					end
				end)
			end
		end
	end

	if db.show_arena and unit == "arena" then
		self.Trinket = CreateFrame("Frame", nil, self)
		self.Trinket:SetHeight(SettingsDB.Scale(31))
		self.Trinket:SetWidth(SettingsDB.Scale(31))
		if db.arena_on_right == true then
			self.Trinket:SetPoint("TOPRIGHT", self, "TOPLEFT", SettingsDB.Scale(-5), SettingsDB.Scale(2))
		else
			self.Trinket:SetPoint("TOPLEFT", self, "TOPRIGHT", SettingsDB.Scale(5), SettingsDB.Scale(2))
		end
		self.Trinket.bg = SettingsDB.CreateTemplate(self.Trinket)
		self.Trinket.trinketUseAnnounce = true
			
		self.AuraTracker = CreateFrame("Frame", nil, self)
		self.AuraTracker:SetWidth(self.Trinket:GetWidth())
		self.AuraTracker:SetHeight(self.Trinket:GetHeight())
		self.AuraTracker:SetPoint("CENTER", self.Trinket, "CENTER")
		self.AuraTracker:SetFrameStrata("HIGH")
		
		self.AuraTracker.icon = self.AuraTracker:CreateTexture(nil, "ARTWORK")
		self.AuraTracker.icon:SetWidth(self.Trinket:GetWidth())
		self.AuraTracker.icon:SetHeight(self.Trinket:GetHeight())
		self.AuraTracker.icon:SetPoint("TOPLEFT", self.Trinket, SettingsDB.Scale(2), SettingsDB.Scale(-2))
		self.AuraTracker.icon:SetPoint("BOTTOMRIGHT", self.Trinket, SettingsDB.Scale(-2), SettingsDB.Scale(2))
		self.AuraTracker.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		
		self.AuraTracker.text = SettingsDB.SetFontString(self.AuraTracker, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size * 2, SettingsCF["font"].unit_frames_font_style)
		self.AuraTracker.text:SetPoint("CENTER", self.AuraTracker, 0, 0)
		self.AuraTracker:SetScript("OnUpdate", SettingsDB.AuraTrackerTime)
	end
	
	if db.aggro_border == true and unit ~= "arenatarget" then
		table.insert(self.__elements, SettingsDB.UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", SettingsDB.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", SettingsDB.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", SettingsDB.UpdateThreat)
	end
	
	if db.icons_raid_mark == true then
		self.RaidIcon = self:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetParent(self.Health)
		self.RaidIcon:SetSize((unit == "player" or unit == "target") and 15 or 12, (unit == "player" or unit == "target") and 15 or 12)
		self.RaidIcon:SetPoint("TOP", 0, 0)
	end
	
	if unit ~= "arenatarget" then
		self.DebuffHighlight = self.Health:CreateTexture(nil, "OVERLAY")
		self.DebuffHighlight:SetAllPoints(self.Health)
		self.DebuffHighlight:SetTexture(SettingsCF["media"].highlight)
		self.DebuffHighlight:SetVertexColor(0, 0, 0, 0)
		self.DebuffHighlight:SetBlendMode("ADD")
		self.DebuffHighlightAlpha = 1
		self.DebuffHighlightFilter = true
	end
	
	if db.plugins_healcomm == true then
		local mhpb = CreateFrame("StatusBar", nil, self.Health)
		mhpb:SetPoint("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		mhpb:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		mhpb:SetWidth(SettingsDB.Scale(217))
		mhpb:SetStatusBarTexture(SettingsCF["media"].texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
		mhpb:SetMinMaxValues(0, 1)

		local ohpb = CreateFrame("StatusBar", nil, self.Health)
		ohpb:SetPoint("TOPLEFT", mhpb:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ohpb:SetPoint("BOTTOMLEFT", mhpb:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ohpb:SetWidth(SettingsDB.Scale(217))
		ohpb:SetStatusBarTexture(SettingsCF["media"].texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)

		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 1,
		}
	end

	SettingsDB.HideAuraFrame(self)
	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
oUF:RegisterStyle("Shestak", Shared)

local player = oUF:Spawn("player", "oUF_Player")
player:SetSize(SettingsDB.Scale(217), SettingsDB.Scale(27))

local target = oUF:Spawn("target", "oUF_Target")
target:SetSize(SettingsDB.Scale(217), SettingsDB.Scale(27))

if SettingsCF["actionbar"].bottombars == 1 then
	player:SetPoint(pos.player[1], pos.player[2], pos.player[3], SettingsDB.Scale(pos.player[4]), SettingsDB.Scale(pos.player[5] - 28))
	target:SetPoint(pos.target[1], pos.target[2], pos.target[3], SettingsDB.Scale(pos.target[4]), SettingsDB.Scale(pos.target[5] - 28))
elseif SettingsCF["actionbar"].bottombars == 2 then
	player:SetPoint(pos.player[1], pos.player[2], pos.player[3], SettingsDB.Scale(pos.player[4]), SettingsDB.Scale(pos.player[5]))
	target:SetPoint(pos.target[1], pos.target[2], pos.target[3], SettingsDB.Scale(pos.target[4]), SettingsDB.Scale(pos.target[5]))
elseif SettingsCF["actionbar"].bottombars == 3 then
	player:SetPoint(pos.player[1], pos.player[2], pos.player[3], SettingsDB.Scale(pos.player[4]), SettingsDB.Scale(pos.player[5] + 28))
	target:SetPoint(pos.target[1], pos.target[2], pos.target[3], SettingsDB.Scale(pos.target[4]), SettingsDB.Scale(pos.target[5] + 28))
end

local pet = oUF:Spawn("pet", "oUF_Pet")
pet:SetPoint(unpack(SettingsCF["position"].unitframes.pet))
pet:SetSize(SettingsDB.Scale(105), SettingsDB.Scale(16))

local focus = oUF:Spawn("focus", "oUF_Focus")
focus:SetPoint(unpack(SettingsCF["position"].unitframes.focus))
focus:SetSize(SettingsDB.Scale(105), SettingsDB.Scale(16))

local focustarget = oUF:Spawn("focustarget", "oUF_FocusTarget")
focustarget:SetPoint(unpack(SettingsCF["position"].unitframes.focus_target))
focustarget:SetSize(SettingsDB.Scale(105), SettingsDB.Scale(16))

local targettarget = oUF:Spawn("targettarget", "oUF_TargetTarget")
targettarget:SetPoint(unpack(SettingsCF["position"].unitframes.target_target))
targettarget:SetSize(SettingsDB.Scale(105), SettingsDB.Scale(16))

if db.show_boss == true then
	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
		if i == 1 then
			if db.boss_on_right == true then
				boss[i]:SetPoint(unpack(SettingsCF["position"].unitframes.boss))
			else
				boss[i]:SetPoint("BOTTOMLEFT", pos.boss[2], "LEFT", pos.boss[4] + 38, pos.boss[5])
			end
		else
			boss[i]:SetPoint("BOTTOM", boss[i-1], "TOP", 0, 30)
		end
		boss[i]:SetSize(SettingsDB.Scale(150), SettingsDB.Scale(27))
	end
end

if db.show_arena == true then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			if db.arena_on_right == true then
				arena[i]:SetPoint(pos.arena[1], pos.arena[2], pos.arena[3], pos.arena[4], pos.arena[5])
			else
				arena[i]:SetPoint("BOTTOMLEFT", pos.arena[2], "LEFT", pos.arena[4] + 75, pos.arena[5])
			end
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 30)
		end
		arena[i]:SetSize(SettingsDB.Scale(150), SettingsDB.Scale(27))
	end

	local arenatarget = {}
	for i = 1, 5 do
		arenatarget[i] = oUF:Spawn("arena"..i.."target", "oUF_Arena"..i.."Target")
		if i == 1 then
			if db.arena_on_right == true then
				arenatarget[i]:SetPoint("TOPRIGHT", arena[i], "TOPLEFT", -41, 0)
			else
				arenatarget[i]:SetPoint("TOPRIGHT", arena[i], "TOPLEFT", -7, 0)
			end
		else
			arenatarget[i]:SetPoint("BOTTOM", arenatarget[i-1], "TOP", 0, 30)
		end
		arenatarget[i]:SetSize(SettingsDB.Scale(30), SettingsDB.Scale(27))
	end
end

----------------------------------------------------------------------------------------
--	Remove SET_FOCUS & CLEAR_FOCUS from menu, to prevent errors
----------------------------------------------------------------------------------------
--[[
do
    for k,v in pairs(UnitPopupMenus) do
        for x,y in pairs(UnitPopupMenus[k]) do
            if y == "SET_FOCUS" then
                table.remove(UnitPopupMenus[k],x)
            elseif y == "CLEAR_FOCUS" then
                table.remove(UnitPopupMenus[k],x)
            end
        end
    end
end]]

----------------------------------------------------------------------------------------
--	Testmode(by Fernir)
----------------------------------------------------------------------------------------
SlashCmdList.TestUI = function() 
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if not v.fff then
				v.fff = CreateFrame("Frame")
				SettingsDB.SkinFadedPanel(v.fff)
				v.fff:SetPoint("TOPLEFT", v, SettingsDB.Scale(-2), SettingsDB.Scale(2))
				v.fff:SetPoint("BOTTOMRIGHT", v, SettingsDB.Scale(2), SettingsDB.Scale(-2))
			
				v.fffs = SettingsDB.SetFontString(v.fff, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
				v.fffs:SetShadowOffset(0, 0)
				v.fffs:SetAllPoints(v.fff)
				v.fffs:SetText(v:GetName())
			end
			
			if v.fff:IsVisible() then 
				v.fff:Hide()
			else
				v.fff:Show()
			end
		end
	end
end
SLASH_TestUI1 = "/testuf"