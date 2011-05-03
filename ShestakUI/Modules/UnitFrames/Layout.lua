local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "ShestakUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local T, C, L = unpack(select(2, ...))
if not C.unitframe.enable == true then return end

----------------------------------------------------------------------------------------
--	
----------------------------------------------------------------------------------------
local backdrop = {
	bgFile = C.media.blank,
	insets = {top = -T.mult, left = -T.mult, bottom = -T.mult, right = -T.mult},
}

-- Create layout
local function Shared(self, unit)
	-- Set our own colors
	self.colors = T.oUF_colors

	-- Register click
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	local unit = (unit and unit:find("arena%dtarget")) and "arenatarget" 
	or (unit and unit:find("arena%d")) and "arena"
	or (unit and unit:find("boss%d")) and "boss" or unit
	
	-- Menu
	self.menu = T.SpawnMenu
	
	if (unit == "arena" and C.unitframe.show_arena == true and unit ~= "arenatarget") or (unit == "boss" and C.unitframe.show_boss == true) then
		self:SetAttribute("type2", "focus")
	else
		self:SetAttribute("*type2", "menu")
	end
	
	-- Backdrop for every units
	self.FrameBackdrop = CreateFrame("Frame", nil, self)
	self.FrameBackdrop:SetTemplate("Default")
	self.FrameBackdrop:SetFrameStrata("LOW")
	self.FrameBackdrop:Point("TOPLEFT", -2, 2)
	self.FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)

	-- Health bar
	self.Health = CreateFrame("StatusBar", self:GetName().."_Health", self)
	if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
		self.Health:Height(21)
	elseif unit == "arenatarget" then
		self.Health:Height(27)
	else
		self.Health:Height(13)
	end
	self.Health:Point("TOPLEFT", self, "TOPLEFT", 0, 0)
	self.Health:Point("TOPRIGHT", self, "TOPRIGHT", 0, 0)
	self.Health:SetStatusBarTexture(C.media.texture)

	self.Health.frequentUpdates = true
	if C.unitframe.own_color == true then
		self.Health.colorTapping = false
		self.Health.colorDisconnected = false
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health:SetStatusBarColor(unpack(C.unitframe.uf_color))
	else
		self.Health.colorTapping = true
		self.Health.colorDisconnected = true
		self.Health.colorClass = true
		self.Health.colorReaction = true
	end
	if C.unitframe.plugins_smooth_bar == true then
		self.Health.Smooth = true
	end
	
	self.Health.PostUpdate = T.PostUpdateHealth

	-- Health bar background
	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints()
	self.Health.bg:SetTexture(C.media.texture)
	if C.unitframe.own_color == true then
		self.Health.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.25)	
	else
		self.Health.bg.multiplier = 0.25
	end
	
	self.Health.value = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
	if unit == "player" or unit == "pet" or unit == "focus" then
		self.Health.value:Point("RIGHT", self.Health, "RIGHT", 0, 0)
		self.Health.value:SetJustifyH("RIGHT")
	elseif unit == "arena" then
		if C.unitframe.arena_on_right == true then
			self.Health.value:Point("LEFT", self.Health, "LEFT", 2, 0)
			self.Health.value:SetJustifyH("LEFT")
		else
			self.Health.value:Point("RIGHT", self.Health, "RIGHT", 0, 0)
			self.Health.value:SetJustifyH("RIGHT")
		end
	elseif unit == "boss" then
		if C.unitframe.boss_on_right == true then
			self.Health.value:Point("LEFT", self.Health, "LEFT", 2, 0)
			self.Health.value:SetJustifyH("LEFT")
		else
			self.Health.value:Point("RIGHT", self.Health, "RIGHT", 0, 0)
			self.Health.value:SetJustifyH("RIGHT")
		end
	else
		self.Health.value:Point("LEFT", self.Health, "LEFT", 2, 0)
		self.Health.value:SetJustifyH("LEFT")
	end

	-- Power bar
	self.Power = CreateFrame("StatusBar", self:GetName().."_Power", self)
	if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
		self.Power:Height(5)
	elseif unit == "arenatarget" then
		self.Power:Height(0)
	else
		self.Power:Height(2)
	end		
	self.Power:Point("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -1)
	self.Power:Point("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -1)
	self.Power:SetStatusBarTexture(C.media.texture)

	self.Power.frequentUpdates = true
	self.Power.colorDisconnected = true
	self.Power.colorTapping = true
	if C.unitframe.own_color == true then
		self.Power.colorClass = true
	else
		self.Power.colorPower = true
	end
	if C.unitframe.plugins_smooth_bar == true then
		self.Power.Smooth = true
	end

	self.Power.PreUpdate = T.PreUpdatePower
	self.Power.PostUpdate = T.PostUpdatePower
	
	self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
	self.Power.bg:SetAllPoints()
	self.Power.bg:SetTexture(C.media.texture)
	if C.unitframe.own_color == true and unit == "pet" then
		self.Power.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.25)
	else
		self.Power.bg.multiplier = 0.3
	end
	
	self.Power.value = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
	if unit == "player" then
		self.Power.value:Point("RIGHT", self.Power, "RIGHT", 0, 0)
		self.Power.value:SetJustifyH("RIGHT")
	elseif unit == "arena" then
		if C.unitframe.arena_on_right == true then
			self.Power.value:Point("LEFT", self.Power, "LEFT", 2, 0)
			self.Power.value:SetJustifyH("LEFT")
		else
			self.Power.value:Point("RIGHT", self.Power, "RIGHT", 0, 0)
			self.Power.value:SetJustifyH("RIGHT")
		end
	elseif unit == "boss" then
		if C.unitframe.boss_on_right == true then
			self.Power.value:Point("LEFT", self.Power, "LEFT", 2, 0)
			self.Power.value:SetJustifyH("LEFT")
		else
			self.Power.value:Point("RIGHT", self.Power, "RIGHT", 0, 0)
			self.Power.value:SetJustifyH("RIGHT")
		end
	elseif unit == "pet" then
		self.Power.value:Hide()
	else
		self.Power.value:Point("LEFT", self.Power, "LEFT", 2, 0)
		self.Power.value:SetJustifyH("LEFT")
	end

	-- Names
	if unit ~= "player" then
		self.Info = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		if unit ~= "arenatarget" then
			self.Level = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		end
		if unit == "target" then
			self.Info:Point("RIGHT", self.Health, "RIGHT", 0, 0)
			self:Tag(self.Info, "[GetNameColor][NameLong]")
			self.Level:Point("RIGHT", self.Power, "RIGHT", 0, 0)
			self:Tag(self.Level, "[cpoints] [Threat] [DiffColor][level][shortclassification]")
		elseif unit == "focus" or unit == "pet" then
			self.Info:Point("LEFT", self.Health, "LEFT", 2, 0)
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
		elseif unit == "arenatarget" then
			self.Info:Point("CENTER", self.Health, "CENTER", 0, 0)
			self:Tag(self.Info, "[GetNameColor][NameArena]")
		elseif unit == "arena" then
			if C.unitframe.arena_on_right == true then
				self.Info:Point("RIGHT", self.Health, "RIGHT", 0, 0)
				self:Tag(self.Info, "[GetNameColor][NameMedium]")
			else
				self.Info:Point("LEFT", self.Health, "LEFT", 2, 0)
				self:Tag(self.Info, "[GetNameColor][NameMedium]")
			end
		elseif unit == "boss" then
			if C.unitframe.boss_on_right == true then
				self.Info:Point("RIGHT", self.Health, "RIGHT", 0, 0)
				self:Tag(self.Info, "[GetNameColor][NameMedium]")
			else
				self.Info:Point("LEFT", self.Health, "LEFT", 2, 0)
				self:Tag(self.Info, "[GetNameColor][NameMedium]")
			end
		else
			self.Info:Point("RIGHT", self.Health, "RIGHT", 0, 0)
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
		end
	elseif unit == "player" and T.class == "DRUID" then
		self.Info = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size*4, C.font.unit_frames_font_style)
		self.Info:SetPoint("BOTTOM", self.Health, "TOP", 0, -10.5)
		self:Tag(self.Info, "[WM1][WM2][WM3]")
	end

	if unit == "player" then
		self.FlashInfo = CreateFrame("Frame", "FlashInfo", self)
		self.FlashInfo:SetScript("OnUpdate", T.UpdateManaLevel)
		self.FlashInfo.parent = self
		self.FlashInfo:SetToplevel(true)
		self.FlashInfo:SetAllPoints(self.Health)

		self.FlashInfo.ManaLevel = T.SetFontString(self.FlashInfo, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.FlashInfo.ManaLevel:Point("CENTER", 0, 0)
		
		-- Combat icon
		if C.unitframe.icons_combat == true then
			self.Combat = self.Health:CreateTexture(nil, "OVERLAY")
			self.Combat:Size(18, 18)
			self.Combat:Point("TOPRIGHT", 4, 8)
		end

		-- Resting icon
		if C.unitframe.icons_resting == true and T.level ~= MAX_PLAYER_LEVEL then
			self.Resting = self.Power:CreateTexture(nil, "OVERLAY")
			self.Resting:Size(18, 18)
			self.Resting:Point("BOTTOMLEFT", -8, -8)
		end

		-- Leader/Assistant/ML icons
		if C.raidframe.icons_leader == true then
			-- Leader icon
			self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
			self.Leader:Size(14, 14)
			self.Leader:Point("TOPLEFT", -3, 9)

			-- Assistant icon
			self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
			self.Assistant:Size(12, 12)
			self.Assistant:Point("TOPLEFT", -3, 8)

			-- Master looter icon
			self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
			self.MasterLooter:Size(12, 12)
			self.MasterLooter:Point("TOPRIGHT", 3, 8)
		end
		
		-- LFD role icons
		if C.raidframe.icons_lfd_role == true then 
			self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
			self.LFDRole:Size(12, 12)
			self.LFDRole:Point("TOPLEFT", 10, 8)
		end

		-- Rune bar
		if C.unitframe.plugins_rune_bar == true and T.class == "DEATHKNIGHT" then
			self.Runes = CreateFrame("Frame", nil, self)
			self.Runes:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			self.Runes:Height(7)
			self.Runes:SetWidth(212)
			self.Runes:SetBackdrop(backdrop)
			self.Runes:SetBackdropColor(0, 0, 0)

			for i = 1, 6 do
				self.Runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, self)
				self.Runes[i]:SetSize(212 / 6, 7)
				if (i == 1) then
					self.Runes[i]:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				else
					self.Runes[i]:Point("TOPLEFT", self.Runes[i-1], "TOPRIGHT", 1, 0)
				end
				self.Runes[i]:SetStatusBarTexture(C.media.texture)
				
				self.Runes[i].bg = self.Runes[i]:CreateTexture(nil, "BORDER")
				self.Runes[i].bg:SetAllPoints()
				self.Runes[i].bg:SetTexture(C.media.texture)
				self.Runes[i].bg.multiplier = 0.25
				
				self.Runes[i].FrameBackdrop = CreateFrame("Frame", nil, self.Runes[i])
				self.Runes[i].FrameBackdrop:SetTemplate("Default")
				self.Runes[i].FrameBackdrop:SetFrameStrata("BACKGROUND")
				self.Runes[i].FrameBackdrop:Point("TOPLEFT", -2, 2)
				self.Runes[i].FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)
			end
		end

		-- Totem bar
		if C.unitframe.plugins_totem_bar == true and T.class == "SHAMAN" then
			self.TotemBar = {}
			self.TotemBar.Destroy = true
			for i = 1, 4 do
				self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
				self.TotemBar[i]:SetSize(214 / 4, 7)
				if (i == 1) then
					self.TotemBar[i]:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				else
					self.TotemBar[i]:Point("TOPLEFT", self.TotemBar[i-1], "TOPRIGHT", 1, 0)
				end
				self.TotemBar[i]:SetStatusBarTexture(C.media.texture)
				self.TotemBar[i]:SetMinMaxValues(0, 1)

				self.TotemBar[i]:SetBackdrop(backdrop)
				self.TotemBar[i]:SetBackdropColor(0, 0, 0)

				self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
				self.TotemBar[i].bg:SetAllPoints()
				self.TotemBar[i].bg:SetTexture(C.media.texture)
				self.TotemBar[i].bg.multiplier = 0.30
				
				self.TotemBar[i].FrameBackdrop = CreateFrame("Frame", nil, self.TotemBar[i])
				self.TotemBar[i].FrameBackdrop:SetTemplate("Default")
				self.TotemBar[i].FrameBackdrop:SetFrameStrata("BACKGROUND")
				self.TotemBar[i].FrameBackdrop:Point("TOPLEFT", -2, 2)
				self.TotemBar[i].FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)
				
				if C.unitframe.plugins_totem_bar_name == true then
					self.TotemBar[i].Name = T.SetFontString(self.TotemBar[i], C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
					self.TotemBar[i].Name:Point("CENTER", self.TotemBar[i], "CENTER", 0, 0)
					self.TotemBar[i].Name:SetTextColor(1, 1, 1)
				end
			end
		end

		-- Druid mana
		if T.class == "DRUID" then
			CreateFrame("Frame"):SetScript("OnUpdate", function() T.UpdateDruidMana(self) end)
			self.DruidMana = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.DruidMana:SetTextColor(1, 0.49, 0.04)
			
			if C.unitframe.plugins_eclipse_bar == true then
				local eclipseBar = CreateFrame("Frame", "EclipseBar", self)
				eclipseBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				eclipseBar:Size(217, 7)
				eclipseBar:SetFrameStrata("MEDIUM")
				eclipseBar:SetFrameLevel(8)
				eclipseBar:SetBackdrop(backdrop)
				eclipseBar:SetBackdropColor(0, 0, 0)
				eclipseBar:SetScript("OnShow", function() T.UpdateEclipse(self, false) end)
				eclipseBar:SetScript("OnUpdate", function() T.UpdateEclipse(self, true) end)
				eclipseBar:SetScript("OnHide", function() T.UpdateEclipse(self, false) end)
				
				eclipseBar.FrameBackdrop = CreateFrame("Frame", nil, eclipseBar)
				eclipseBar.FrameBackdrop:SetTemplate("Default")
				eclipseBar.FrameBackdrop:SetFrameStrata("BACKGROUND")
				eclipseBar.FrameBackdrop:Point("TOPLEFT", -2, 2)
				eclipseBar.FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)
			
				local lunarBar = CreateFrame("StatusBar", nil, eclipseBar)
				lunarBar:Point("LEFT", eclipseBar, "LEFT", 0, 0)
				lunarBar:Size(eclipseBar:GetWidth(), eclipseBar:GetHeight())
				lunarBar:SetStatusBarTexture(C.media.texture)
				lunarBar:SetStatusBarColor(0.30, 0.30, 0.80)
				eclipseBar.LunarBar = lunarBar

				local solarBar = CreateFrame("StatusBar", nil, eclipseBar)
				solarBar:Point("LEFT", lunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
				solarBar:Size(eclipseBar:GetWidth(), eclipseBar:GetHeight())
				solarBar:SetStatusBarTexture(C.media.texture)
				solarBar:SetStatusBarColor(0.80, 0.80, 0.20)
				eclipseBar.SolarBar = solarBar
				
				local eclipseBarText = T.SetFontString(solarBar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				eclipseBarText:Point("CENTER", eclipseBar, "CENTER", -6, 0)
				eclipseBar.PostUpdatePower = T.EclipseDirection
				
				local eclipseBarPers = T.SetFontString(solarBar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				eclipseBarPers:Point("LEFT", eclipseBarText, "RIGHT", 2, 0)
				self:Tag(eclipseBarPers, "[pereclipse]%")
				
				self.EclipseBar = eclipseBar
				self.EclipseBar.Text = eclipseBarText
			end
		end
		
		-- Holy power bar or shard bar
		if (T.class == "WARLOCK" and C.unitframe.plugins_shard_bar == true) or (T.class == "PALADIN" and C.unitframe.plugins_holy_bar == true) then
			local bars = CreateFrame("Frame", nil, self)
			bars:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			bars:Width(217)
			bars:Height(7)
			bars:SetBackdrop(backdrop)
			bars:SetBackdropColor(0, 0, 0)
			
			for i = 1, 3 do
				bars[i] = CreateFrame("StatusBar", self:GetName().."_Shard"..i, self)
				bars[i]:Height(7)
				bars[i]:SetStatusBarTexture(C.media.texture)

				bars[i].bg = bars[i]:CreateTexture(nil, "BORDER")
				bars[i].bg:SetTexture(C.media.texture)
				
				if T.class == "WARLOCK" then
					bars[i]:SetStatusBarColor(0.70, 0.32, 0.75)
					bars[i].bg:SetTexture(0.70, 0.32, 0.75, 0.25)
				elseif T.class == "PALADIN" then
					bars[i]:SetStatusBarColor(0.89, 0.88, 0.1)
					bars[i].bg:SetTexture(0.89, 0.88, 0.1, 0.25)
				end
					
				if i == 1 then
					bars[i]:Point("LEFT", bars)
					bars[i]:Width(71)
					bars[i].bg:SetAllPoints(bars[i])
				else
					bars[i]:Point("LEFT", bars[i-1], "RIGHT", 1, 0)
					bars[i]:Width(72)
					bars[i].bg:SetAllPoints(bars[i])
				end
			end
			
			bars.FrameBackdrop = CreateFrame("Frame", nil, bars)
			bars.FrameBackdrop:SetTemplate("Default")
			bars.FrameBackdrop:SetFrameStrata("BACKGROUND")
			bars.FrameBackdrop:Point("TOPLEFT", -2, 2)
			bars.FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)
			
			if T.class == "WARLOCK" then
				bars.Override = T.UpdateShards				
				self.SoulShards = bars
			elseif T.class == "PALADIN" then
				bars.Override = T.UpdateHoly
				self.HolyPower = bars
			end
		end
		
		-- Vengeance bar
		if C.unitframe.plugins_vengeance_bar == true then
			local vengeanceBar = CreateFrame("Frame", nil, self)
			if (T.class == "PALADIN" and C.unitframe.plugins_holy_bar == true)
			or (T.class == "DEATHKNIGHT" and C.unitframe.plugins_rune_bar == true) then
				vengeanceBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 21)
			else
				vengeanceBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			end
			vengeanceBar:Size(217, 7)
			vengeanceBar:SetBackdrop(backdrop)
			vengeanceBar:SetBackdropColor(0, 0, 0)
			
			vengeanceBar.FrameBackdrop = CreateFrame("Frame", nil, vengeanceBar)
			vengeanceBar.FrameBackdrop:SetTemplate("Default")
			vengeanceBar.FrameBackdrop:SetFrameStrata("BACKGROUND")
			vengeanceBar.FrameBackdrop:Point("TOPLEFT", -2, 2)
			vengeanceBar.FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)

			local statusBar = CreateFrame("StatusBar", nil, vengeanceBar)
			statusBar:Point("LEFT", vengeanceBar, "LEFT", 0, 0)
			statusBar:Size(217, 7)
			statusBar:SetStatusBarTexture(C.media.texture)
			statusBar:SetStatusBarColor(T.color.r, T.color.g, T.color.b)
			vengeanceBar.Bar = statusBar
			
			statusBar.bg = statusBar:CreateTexture(nil, "BORDER")
			statusBar.bg:SetAllPoints()
			statusBar.bg:SetTexture(C.media.texture)
			statusBar.bg:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.25)

			local vengeanceBarText = T.SetFontString(statusBar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			vengeanceBarText:Point("CENTER", statusBar, "CENTER", 0, 0)
			vengeanceBar.Text = vengeanceBarText

			self.VengeanceBar = vengeanceBar
		end
		
		-- Experience bar
		if T.level ~= MAX_PLAYER_LEVEL and C.unitframe.plugins_experience_bar == true then
			self.Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
			self.Experience:Height(94)
			self.Experience:Width(7)
			self.Experience:SetOrientation("Vertical")
			if C.unitframe.portrait_enable == true then
				self.Experience:Point("TOPLEFT", self, "TOPLEFT", -25-C.unitframe.portrait_width, 28)
			else
				self.Experience:Point("TOPLEFT", self, "TOPLEFT", -18, 28)
			end
			self.Experience:SetStatusBarTexture(C.media.texture)
			self.Experience:SetStatusBarColor(T.color.r, T.color.g, T.color.b)
			self.Experience:SetAlpha(0)

			self.Experience:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Experience:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

			self.Experience.bg = self.Experience:CreateTexture(nil, "BORDER")
			self.Experience.bg:SetAllPoints(self.Experience)
			self.Experience.bg:SetTexture(C.media.texture)
			self.Experience.bg:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.25)

			self.Experience.FrameBackdrop = CreateFrame("Frame", nil, self.Experience)
			self.Experience.FrameBackdrop:SetTemplate("Default")
			self.Experience.FrameBackdrop:SetFrameLevel(1)
			self.Experience.FrameBackdrop:Point("TOPLEFT", -2, 2)
			self.Experience.FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)
			
			self.Experience.Rested = CreateFrame("StatusBar", nil, self.Experience)
			self.Experience.Rested:SetParent(self.Experience)
			self.Experience.Rested:SetOrientation("Vertical")
			self.Experience.Rested:SetAllPoints(self.Experience)
			self.Experience.Rested:SetStatusBarTexture(C.media.texture)
			self.Experience.Rested:SetStatusBarColor(0, 0, 1, 0.5)
			
			self.Experience.Tooltip = true
		end
		
		-- Reputation bar
		if C.unitframe.plugins_reputation_bar == true then
			self.Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self)
			self.Reputation:Height(94)
			self.Reputation:Width(7)
			self.Reputation:SetOrientation("Vertical")
			if C.unitframe.portrait_enable == true then
				self.Reputation:Point("TOPLEFT", self, "TOPLEFT", -39-C.unitframe.portrait_width, 28)
			else
				self.Reputation:Point("TOPLEFT", self, "TOPLEFT", -32, 28)
			end
			self.Reputation:SetStatusBarTexture(C.media.texture)
			self.Reputation:SetBackdrop(backdrop)
			self.Reputation:SetBackdropColor(0, 0, 0)
			self.Reputation:SetAlpha(0)

			self.Reputation:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Reputation:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

			self.Reputation.bg = self.Reputation:CreateTexture(nil, "BORDER")
			self.Reputation.bg:SetAllPoints(self.Reputation)
			self.Reputation.bg:SetTexture(C.media.texture)

			self.Reputation.FrameBackdrop = CreateFrame("Frame", nil, self.Reputation)
			self.Reputation.FrameBackdrop:SetTemplate("Default")
			self.Reputation.FrameBackdrop:SetFrameLevel(1)
			self.Reputation.FrameBackdrop:Point("TOPLEFT", -2, 2)
			self.Reputation.FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)
			
			self.Reputation.PostUpdate = T.UpdateReputationColor
			self.Reputation.Tooltip = true
		end
		
		-- Swing bar
		if C.unitframe.plugins_swing == true then
			self.Swing = CreateFrame("StatusBar", self:GetName().."_Swing", self)
			self.Swing:SetStatusBarTexture(C.media.texture)
			self.Swing:SetStatusBarColor(T.color.r, T.color.g, T.color.b)
			self.Swing:Height(5)
			self.Swing:Width(281)
			self.Swing:Point("BOTTOMLEFT", "oUF_Player", "BOTTOMRIGHT", 35, 23)

			self.Swing.bg = self.Swing:CreateTexture(nil, "BORDER")
			self.Swing.bg:SetAllPoints(self.Swing)
			self.Swing.bg:SetTexture(C.media.texture)
			self.Swing.bg:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.25)

			self.Swing.FrameBackdrop = CreateFrame("Frame", nil, self.Swing)
			self.Swing.FrameBackdrop:SetTemplate("Default")
			self.Swing.FrameBackdrop:SetFrameLevel(1)
			self.Swing.FrameBackdrop:Point("TOPLEFT", -2, 2)
			self.Swing.FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)
			
			self.Swing.Text = T.SetFontString(self.Swing, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.Swing.Text:Point("CENTER", 0, 0)
			self.Swing.Text:SetTextColor(1, 1, 1)
		end
		
		-- GCD spark
		if C.unitframe.plugins_gcd == true then
			self.GCD = CreateFrame("Frame", nil, self)
			self.GCD:Width(220)
			self.GCD:Height(3)
			self.GCD:SetFrameStrata("HIGH")
			self.GCD:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 0)

			self.GCD.Color = {1, 1, 1}
			self.GCD.Height = T.Scale(3)
			self.GCD.Width = T.Scale(4)
		end
	end

	if unit == "pet" or unit == "targettarget" or unit == "focus" or unit == "focustarget" then
		self.Debuffs = CreateFrame("Frame", nil, self)
		self.Debuffs:Height(25)
		self.Debuffs:Width(109)
		self.Debuffs.size = T.Scale(25)
		self.Debuffs.spacing = T.Scale(3)
		self.Debuffs.num = 4
		self.Debuffs["growth-y"] = "DOWN"
		if unit == "pet" or unit == "focus" then
			self.Debuffs:Point("TOPRIGHT", self, "BOTTOMRIGHT", 2, -17)
			self.Debuffs.initialAnchor = "TOPRIGHT"
			self.Debuffs["growth-x"] = "LEFT"
		else
			self.Debuffs:Point("TOPLEFT", self, "BOTTOMLEFT", -2, -17)
			self.Debuffs.initialAnchor = "TOPLEFT"
			self.Debuffs["growth-x"] = "RIGHT"
		end
		self.Debuffs.PostCreateIcon = T.PostCreateAura
		self.Debuffs.PostUpdateIcon = T.PostUpdateIcon
		
		if unit == "pet" then
			self:RegisterEvent("UNIT_PET", T.UpdateAllElements)
		end
	end

	if unit == "player" or unit == "target" then
		if C.unitframe.portrait_enable == true then
			self.Portrait = CreateFrame("PlayerModel", self:GetName().."_Portrait", self)
			self.Portrait:Height(C.unitframe.portrait_height)
			self.Portrait:Width(C.unitframe.portrait_width)
			if unit == "player" then
				self.Portrait:Point(unpack(C.position.unitframes.player_portrait))
			elseif unit == "target" then
				self.Portrait:Point(unpack(C.position.unitframes.target_portrait))
			end

			self.PortraitOverlay = CreateFrame("Frame", self:GetName().."_PortraitOverlay", self.Portrait)
			self.PortraitOverlay:SetFrameLevel(self.PortraitOverlay:GetFrameLevel() - 1)
			self.PortraitOverlay:SetTemplate("Transparent")
			if C.unitframe.portrait_classcolor_border == true then
				if unit == "player" then
					self.PortraitOverlay:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
				elseif unit == "target" then
					self.PortraitOverlay:RegisterEvent("PLAYER_TARGET_CHANGED")
					self.PortraitOverlay:SetScript("OnEvent", function(self)
						local _, class = UnitClass("target")
						local color = RAID_CLASS_COLORS[class]
						if color then
							self:SetBackdropBorderColor(color.r, color.g, color.b)
						else
							self:SetBackdropBorderColor(unpack(C.media.border_color))
						end
					end)
				end
			end
			self.PortraitOverlay:Point("TOPLEFT", -2 + T.mult, 2)
			self.PortraitOverlay:Point("BOTTOMRIGHT", 2 + T.mult, -2)

			self.Portrait.PostUpdate = T.FixWorgenPortrait
		end
		
		if unit == "player" then
			self.Debuffs = CreateFrame("Frame", nil, self)
			self.Debuffs:Height(165)
			self.Debuffs:Width(221)
			self.Debuffs.size = T.Scale(25)
			self.Debuffs.spacing = T.Scale(3)
			self.Debuffs.initialAnchor = "BOTTOMRIGHT"
			self.Debuffs["growth-y"] = "UP"
			self.Debuffs["growth-x"] = "LEFT"
			if (T.class == "DEATHKNIGHT" and C.unitframe.plugins_rune_bar == true)
			or (T.class == "SHAMAN" and C.unitframe.plugins_totem_bar == true)
			or (T.class == "DRUID" and C.unitframe.plugins_eclipse_bar == true)
			or (T.class == "PALADIN" and C.unitframe.plugins_holy_bar == true)
			or (T.class == "WARLOCK" and C.unitframe.plugins_shard_bar == true) then
				self.Debuffs:Point("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19)
			else
				self.Debuffs:Point("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5)
			end
			
			self.Debuffs.PostCreateIcon = T.PostCreateAura
			self.Debuffs.PostUpdateIcon = T.PostUpdateIcon
		end
		
		if unit == "target" then
			self.Auras = CreateFrame("Frame", nil, self)
			self.Auras:Point("BOTTOMLEFT", self, "TOPLEFT", -2, 5)
			self.Auras.initialAnchor = "BOTTOMLEFT"
			self.Auras["growth-x"] = "RIGHT"
			self.Auras["growth-y"] = "UP"
			self.Auras.numDebuffs = 16
			self.Auras.numBuffs = 32
			self.Auras:Height(165)
			self.Auras:Width(221)
			self.Auras.spacing = T.Scale(3)
			self.Auras.size = T.Scale(25)
			self.Auras.gap = true
			self.Auras.onlyShowPlayer = C.aura.player_aura_only
			self.Auras.PostCreateIcon = T.PostCreateAura
			self.Auras.PostUpdateIcon = T.PostUpdateIcon

			if C.unitframe.icons_combo_point == true then
				if C.unitframe.icons_combo_point_new == true then
					self.CPoints = CreateFrame("Frame", nil, self)
					self.CPoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
					self.CPoints:SetWidth(217)
					self.CPoints:SetHeight(7)

					for i = 1, 5 do
						self.CPoints[i] = CreateFrame("StatusBar", self:GetName().."_Combo"..i, self.CPoints)
						self.CPoints[i]:SetWidth((217 - 4) / 5)
						self.CPoints[i]:SetHeight(7)
						self.CPoints[i]:SetStatusBarTexture(C.media.texture)
						if i == 1 then
							self.CPoints[i]:SetPoint("LEFT", self.CPoints)
						else
							self.CPoints[i]:SetPoint("LEFT", self.CPoints[i-1], "RIGHT", 1, 0)
						end
					end

					self.CPoints[1]:SetStatusBarColor(0.9, 0.1, 0.1)
					self.CPoints[2]:SetStatusBarColor(0.9, 0.1, 0.1)
					self.CPoints[3]:SetStatusBarColor(0.9, 0.9, 0.1)
					self.CPoints[4]:SetStatusBarColor(0.9, 0.9, 0.1)
					self.CPoints[5]:SetStatusBarColor(0.1, 0.9, 0.1)

					self.CPoints.FrameBackdrop = CreateFrame("Frame", nil, self.CPoints[1])
					self.CPoints.FrameBackdrop:SetTemplate("Default")
					self.CPoints.FrameBackdrop:SetFrameStrata("BACKGROUND")
					self.CPoints.FrameBackdrop:Point("TOPLEFT", self.CPoints, -2, 2)
					self.CPoints.FrameBackdrop:Point("BOTTOMRIGHT", self.CPoints, 2, -2)

					self.CPoints.Override = T.UpdateComboPoint
				else
					local CPoints = {}
					CPoints.unit = PlayerFrame.unit
					for i = 1, 5 do
						CPoints[i] = CreateFrame("StatusBar", nil, self)
						CPoints[i]:Height(6)
						CPoints[i]:Width(7)
						CPoints[i]:SetStatusBarTexture(C.media.blank)
						if i == 1 then
							CPoints[i]:Point("BOTTOMRIGHT", self, "BOTTOMLEFT", -7, 0)
							CPoints[i]:SetStatusBarColor(0.9, 0.1, 0.1)
						else
							CPoints[i]:Point("BOTTOM", CPoints[i-1], "TOP", 0, 7)
						end
						CPoints[i].overlay = CreateFrame("Frame", nil, CPoints[i])
						CPoints[i].overlay:SetTemplate("Default")
						CPoints[i].overlay:SetFrameStrata("BACKGROUND")
						CPoints[i].overlay:Point("TOPLEFT", -2, 2)
						CPoints[i].overlay:Point("BOTTOMRIGHT", 2, -2)
					end
					CPoints[2]:SetStatusBarColor(0.9, 0.1, 0.1)
					CPoints[3]:SetStatusBarColor(0.9, 0.9, 0.1)
					CPoints[4]:SetStatusBarColor(0.9, 0.9, 0.1)
					CPoints[5]:SetStatusBarColor(0.1, 0.9, 0.1)
					self.CPoints = CPoints
				end
			end
			if C.unitframe.plugins_talents == true then
				self.Talents = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				self.Talents:SetTextColor(1, 0, 0)
				self.Talents:Point("BOTTOM", self.Power, "BOTTOM", 0, -1)
			end
			
			self.QuestIcon = self.Health:CreateTexture(nil, "OVERLAY")
			self.QuestIcon:Size(20, 20)
			self.QuestIcon:Point("RIGHT", self.Info, "LEFT", -10, 0)
		end

		if C.unitframe.plugins_combat_feedback == true then
			self.CombatFeedbackText = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
			if C.unitframe.portrait_enable == true then
				self.CombatFeedbackText:Point("BOTTOM", self.Portrait, "BOTTOM", 0, 0)
				self.CombatFeedbackText:SetParent(self.Portrait)
			else
				self.CombatFeedbackText:Point("CENTER", 0, 1)
			end
		end

		if C.unitframe.icons_pvp == true then
			self.Status = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.Status:Point("CENTER", self.Health, "CENTER", 0, 0)
			self.Status:SetTextColor(0.69, 0.31, 0.31)
			self.Status:Hide()
			self.Status.Override = T.dummy

			self.Status.Update = CreateFrame("Frame", nil, self)
			self.Status.Update:SetScript("OnUpdate", function(self, elapsed) T.UpdatePvPStatus(self:GetParent(), elapsed) end)

			self:SetScript("OnEnter", function(self) FlashInfo.ManaLevel:Hide() self.Status:Show() UnitFrame_OnEnter(self) end)
			self:SetScript("OnLeave", function(self) FlashInfo.ManaLevel:Show() self.Status:Hide() UnitFrame_OnLeave(self) end)
		end
	end

	if C.unitframe.unit_castbar == true and unit ~= "arenatarget" then
		self.Castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
		self.Castbar:SetStatusBarTexture(C.media.texture, "OVERLAY")
		
		self.Castbar.bg = self.Castbar:CreateTexture(nil, "BORDER")
		self.Castbar.bg:SetAllPoints()
		self.Castbar.bg:SetTexture(C.media.texture)

		self.Castbar.Overlay = CreateFrame("Frame", nil, self.Castbar)
		self.Castbar.Overlay:SetTemplate("Default")
		self.Castbar.Overlay:SetFrameStrata("BACKGROUND")
		self.Castbar.Overlay:Point("TOPLEFT", -2, 2)
		self.Castbar.Overlay:Point("BOTTOMRIGHT", 2, -2)
		
		self.Castbar.PostCastStart = T.PostCastStart
		self.Castbar.PostChannelStart = T.PostChannelStart

		if unit == "player" then
			if C.unitframe.castbar_icon == true then
				self.Castbar:Point(unpack(C.position.unitframes.player_castbar))
				self.Castbar:Width(258)
			else
				self.Castbar:Point(C.position.unitframes.player_castbar[1], C.position.unitframes.player_castbar[2], C.position.unitframes.player_castbar[3], C.position.unitframes.player_castbar[4] - 23, C.position.unitframes.player_castbar[5])
				self.Castbar:Width(281)
			end
			self.Castbar:Height(16)
		elseif unit == "target" then
			if C.unitframe.castbar_icon == true then
				if C.unitframe.plugins_swing == true then
					self.Castbar:Point(unpack(C.position.unitframes.target_castbar))
				else
					self.Castbar:Point(C.position.unitframes.target_castbar[1], C.position.unitframes.target_castbar[2], C.position.unitframes.target_castbar[3], C.position.unitframes.target_castbar[4], C.position.unitframes.target_castbar[5] - 12)
				end
				self.Castbar:Width(258)
			else
				if C.unitframe.plugins_swing == true then
					self.Castbar:Point(C.position.unitframes.target_castbar[1], C.position.unitframes.target_castbar[2], C.position.unitframes.target_castbar[3], C.position.unitframes.target_castbar[4] + 23, C.position.unitframes.target_castbar[5])
				else
					self.Castbar:Point(C.position.unitframes.target_castbar[1], C.position.unitframes.target_castbar[2], C.position.unitframes.target_castbar[3], C.position.unitframes.target_castbar[4] + 23, C.position.unitframes.target_castbar[5] - 12)
				end
				self.Castbar:Width(281)
			end
			self.Castbar:Height(16)
		elseif unit == "arena" or unit == "boss" then
			self.Castbar:Point("TOPLEFT", self, "BOTTOMLEFT", 0, -7)
			self.Castbar:Width(150)
			self.Castbar:Height(16)
		else
			self.Castbar:Point("TOPLEFT", self, "BOTTOMLEFT", 0, -7)
			self.Castbar:Width(105)
			self.Castbar:Height(5)
		end
		
		if unit == "focus" then
			self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
			self.Castbar.Button:Height(65)
			self.Castbar.Button:Width(65)
			self.Castbar.Button:Point(unpack(C.position.unitframes.focus_castbar))
			self.Castbar.Button:SetTemplate("Default")

			self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
			self.Castbar.Icon:Point("TOPLEFT", self.Castbar.Button, 2, -2)
			self.Castbar.Icon:Point("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
			self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			
			self.Castbar.Time = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
			self.Castbar.Time:SetParent(self.Castbar.Button)
			self.Castbar.Time:Point("CENTER", self.Castbar.Icon, "CENTER", 0, 0)
			self.Castbar.Time:SetTextColor(1, 1, 1)
			self.Castbar.CustomTimeText = T.CustomCastTimeText
		end

		if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
			self.Castbar.Time = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.Castbar.Time:Point("RIGHT", self.Castbar, "RIGHT", 0, 0)
			self.Castbar.Time:SetTextColor(1, 1, 1)
			self.Castbar.Time:SetJustifyH("RIGHT")
			self.Castbar.CustomTimeText = T.CustomCastTimeText
			self.Castbar.CustomDelayText = T.CustomCastDelayText

			self.Castbar.Text = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.Castbar.Text:Point("LEFT", self.Castbar, "LEFT", 2, 0)
			self.Castbar.Text:Point("RIGHT", self.Castbar.Time, "LEFT", -1, 0)
			self.Castbar.Text:SetTextColor(1, 1, 1)
			self.Castbar.Text:SetJustifyH("LEFT")

			self.Castbar:HookScript("OnShow", function() self.Castbar.Text:Show(); self.Castbar.Time:Show() end)
			self.Castbar:HookScript("OnHide", function() self.Castbar.Text:Hide(); self.Castbar.Time:Hide() end)

			if C.unitframe.castbar_icon == true and unit ~= "arena" then
				self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
				self.Castbar.Button:Height(20)
				self.Castbar.Button:Width(20)
				self.Castbar.Button:SetTemplate("Default")

				self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
				self.Castbar.Icon:Point("TOPLEFT", self.Castbar.Button, 2, -2)
				self.Castbar.Icon:Point("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
				self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				
				if unit == "player" then
					self.Castbar.Button:Point("RIGHT", self.Castbar, "LEFT", -5, 0)
				elseif unit == "target" then
					self.Castbar.Button:Point("LEFT", self.Castbar, "RIGHT", 5, 0)
				end
			end
			
			if unit == "arena" or unit == "boss" then
				self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
				self.Castbar.Button:Height(20)
				self.Castbar.Button:Width(20)
				self.Castbar.Button:SetTemplate("Default")
				if unit == "boss" then
					if C.unitframe.boss_on_right == true then
						self.Castbar.Button:Point("TOPRIGHT", self.Castbar, "TOPLEFT", -5, 2)
					else
						self.Castbar.Button:Point("TOPLEFT", self.Castbar, "TOPRIGHT", 5, 2)
					end
				else
					self.Castbar.Button:Point("TOPRIGHT", self.Castbar, "TOPLEFT", -5, 2)
				end

				self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
				self.Castbar.Icon:Point("TOPLEFT", self.Castbar.Button, 2, -2)
				self.Castbar.Icon:Point("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
				self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end

			if unit == "player" and C.unitframe.castbar_latency == true then
				self.Castbar.SafeZone = self.Castbar:CreateTexture(nil, "ARTWORK")
				self.Castbar.SafeZone:SetTexture(C.media.texture)
				self.Castbar.SafeZone:SetVertexColor(0.69, 0.31, 0.31)

				self.Castbar.Latency = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				self.Castbar.Latency:SetTextColor(1, 1, 1)
				self.Castbar.Latency:Point("BOTTOMRIGHT", self.Castbar, "BOTTOMRIGHT", 0, -3)
				self.Castbar.Latency:SetJustifyH("RIGHT")
				
				self:RegisterEvent("UNIT_SPELLCAST_SENT", function(self, event, caster)
					if (caster == "player" or caster == "vehicle") then
						self.Castbar.castSent = GetTime()
					end
				end)
			end
		end
	end

	if C.unitframe.show_arena and unit == "arena" then
		self.Trinket = CreateFrame("Frame", nil, self)
		self.Trinket:Height(31)
		self.Trinket:Width(31)
		if C.unitframe.arena_on_right == true then
			self.Trinket:Point("TOPRIGHT", self, "TOPLEFT", -5, 2)
		else
			self.Trinket:Point("TOPLEFT", self, "TOPRIGHT", 5, 2)
		end
		self.Trinket:SetTemplate("Default")
		self.Trinket.trinketUseAnnounce = true
		self.Trinket.trinketUpAnnounce = true
		
		self.AuraTracker = CreateFrame("Frame", nil, self)
		self.AuraTracker:Width(self.Trinket:GetWidth())
		self.AuraTracker:Height(self.Trinket:GetHeight())
		self.AuraTracker:Point("CENTER", self.Trinket, "CENTER")
		self.AuraTracker:SetFrameStrata("HIGH")
		
		self.AuraTracker.icon = self.AuraTracker:CreateTexture(nil, "ARTWORK")
		self.AuraTracker.icon:Width(self.Trinket:GetWidth())
		self.AuraTracker.icon:Height(self.Trinket:GetHeight())
		self.AuraTracker.icon:Point("TOPLEFT", self.Trinket, 2, -2)
		self.AuraTracker.icon:Point("BOTTOMRIGHT", self.Trinket, -2, 2)
		self.AuraTracker.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		
		self.AuraTracker.text = T.SetFontString(self.AuraTracker, C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
		self.AuraTracker.text:Point("CENTER", self.AuraTracker, 0, 0)
		self.AuraTracker:SetScript("OnUpdate", T.AuraTrackerTime)
	end
	
	if C.unitframe.show_boss and unit == "boss" then
		self.AltPowerBar = CreateFrame("StatusBar", nil, self.Health)
		self.AltPowerBar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
		self.AltPowerBar:Height(4)
		self.AltPowerBar:SetStatusBarTexture(C.media.texture)
		self.AltPowerBar:SetStatusBarColor(1, 0, 0)
		self.AltPowerBar:SetPoint("LEFT")
		self.AltPowerBar:SetPoint("RIGHT")
		self.AltPowerBar:SetPoint("TOP", self.Health, "TOP")	
		self.AltPowerBar:SetBackdrop({
			bgFile = C.media.blank, 
			edgeFile = C.media.blank, 
			tile = false, tileSize = 0, edgeSize = T.Scale(1), 
			insets = { left = 0, right = 0, top = 0, bottom = T.Scale(-1)}
		})
		self.AltPowerBar:SetBackdropColor(0, 0, 0)
		self.AltPowerBar:SetBackdropBorderColor(0, 0, 0)
		
		self.AltPowerBar.text = T.SetFontString(self.AltPowerBar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.AltPowerBar.text:Point("CENTER", self.AltPowerBar, "CENTER", 0, 0)
		self:Tag(self.AltPowerBar.text, "[AltPower]")
		
		self.Auras = CreateFrame("Frame", nil, self)
		if C.unitframe.boss_on_right == true then
			self.Auras:Point("RIGHT", self, "LEFT", -5, 0)
			self.Auras.initialAnchor = "RIGHT"
			self.Auras["growth-x"] = "LEFT"
		else
			self.Auras:Point("LEFT", self, "RIGHT", 5, 0)
			self.Auras.initialAnchor = "LEFT"
			self.Auras["growth-x"] = "RIGHT"
		end
		self.Auras.numDebuffs = 0
		self.Auras.numBuffs = 3
		self.Auras:Height(31)
		self.Auras:Width(87)
		self.Auras.spacing = T.Scale(3)
		self.Auras.size = T.Scale(31)
		self.Auras.gap = true
		self.Auras.PostCreateIcon = T.PostCreateAura
		self.Auras.PostUpdateIcon = T.PostUpdateIcon	

		self:HookScript("OnShow", T.UpdateAllElements)
	end
	
	if C.raidframe.aggro_border == true and unit ~= "arenatarget" then
		table.insert(self.__elements, T.UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", T.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", T.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", T.UpdateThreat)
	end
	
	if C.raidframe.icons_raid_mark == true then
		self.RaidIcon = self:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetParent(self.Health)
		self.RaidIcon:Size((unit == "player" or unit == "target") and 15 or 12, (unit == "player" or unit == "target") and 15 or 12)
		self.RaidIcon:Point("TOP", self.Health, 0, 0)
	end
	
	if unit ~= "arenatarget" then
		self.DebuffHighlight = self.Health:CreateTexture(nil, "OVERLAY")
		self.DebuffHighlight:SetAllPoints(self.Health)
		self.DebuffHighlight:SetTexture(C.media.highlight)
		self.DebuffHighlight:SetVertexColor(0, 0, 0, 0)
		self.DebuffHighlight:SetBlendMode("ADD")
		self.DebuffHighlightAlpha = 1
		self.DebuffHighlightFilter = true
	end
	
	if C.raidframe.plugins_healcomm == true then
		local mhpb = CreateFrame("StatusBar", nil, self.Health)
		mhpb:Point("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		mhpb:Point("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		mhpb:Width(217)
		mhpb:SetStatusBarTexture(C.media.texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
		mhpb:SetMinMaxValues(0, 1)

		local ohpb = CreateFrame("StatusBar", nil, self.Health)
		ohpb:Point("TOPLEFT", mhpb:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ohpb:Point("BOTTOMLEFT", mhpb:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ohpb:Width(217)
		ohpb:SetStatusBarTexture(C.media.texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)

		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 1,
		}
	end
	
	-- Fader	
	if C.unitframe.plugins_fader == true then
		if unit ~= "arena" or unit ~= "arenatarget" or unit ~= "boss" then
			self.Fader = {
				[1] = {Combat = 1, Arena = 1, Instance = 1}, 
				[2] = {PlayerTarget = 1, PlayerNotMaxHealth = 1, PlayerNotMaxMana = 1}, 
				[3] = {Stealth = 0.5},
				[4] = {notCombat = 0, PlayerTaxi = 0},
			}
		end
		self.NormalAlpha = 1
	end

	T.HideAuraFrame(self)
	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
oUF:RegisterStyle("Shestak", Shared)

local player = oUF:Spawn("player", "oUF_Player")
player:Point(unpack(C.position.unitframes.player))
player:Size(217, 27)

local target = oUF:Spawn("target", "oUF_Target")
target:Point(unpack(C.position.unitframes.target))
target:Size(217, 27)

if C.unitframe.show_pet == true then
	local pet = oUF:Spawn("pet", "oUF_Pet")
	pet:Point(unpack(C.position.unitframes.pet))
	pet:Size(105, 16)
end

if C.unitframe.show_focus == true then
	local focus = oUF:Spawn("focus", "oUF_Focus")
	focus:Point(unpack(C.position.unitframes.focus))
	focus:Size(105, 16)

	local focustarget = oUF:Spawn("focustarget", "oUF_FocusTarget")
	focustarget:Point(unpack(C.position.unitframes.focus_target))
	focustarget:Size(105, 16)
else
	local focus = oUF:Spawn("focus", "oUF_Focus")
end

if C.unitframe.show_target_target == true then
	local targettarget = oUF:Spawn("targettarget", "oUF_TargetTarget")
	targettarget:Point(unpack(C.position.unitframes.target_target))
	targettarget:Size(105, 16)
end

if C.unitframe.show_boss == true then
	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
		if i == 1 then
			if C.unitframe.boss_on_right == true then
				boss[i]:Point(unpack(C.position.unitframes.boss))
			else
				boss[i]:Point("BOTTOMLEFT", C.position.unitframes.boss[2], "LEFT", C.position.unitframes.boss[4] + 38, C.position.unitframes.boss[5])
			end
		else
			boss[i]:Point("BOTTOM", boss[i-1], "TOP", 0, 30)
		end
		boss[i]:Size(150, 27)
	end
end

if C.unitframe.show_arena == true then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			if C.unitframe.arena_on_right == true then
				arena[i]:Point(unpack(C.position.unitframes.arena))
			else
				arena[i]:Point("BOTTOMLEFT", C.position.unitframes.arena[2], "LEFT", C.position.unitframes.arena[4] + 83, C.position.unitframes.arena[5])
			end
		else
			arena[i]:Point("BOTTOM", arena[i-1], "TOP", 0, 30)
		end
		arena[i]:Size(150, 27)
	end

	local arenatarget = {}
	for i = 1, 5 do
		arenatarget[i] = oUF:Spawn("arena"..i.."target", "oUF_Arena"..i.."Target")
		if i == 1 then
			if C.unitframe.arena_on_right == true then
				arenatarget[i]:Point("TOPRIGHT", arena[i], "TOPLEFT", -41, 0)
			else
				arenatarget[i]:Point("TOPRIGHT", arena[i], "TOPLEFT", -7, 0)
			end
		else
			arenatarget[i]:Point("BOTTOM", arenatarget[i-1], "TOP", 0, 30)
		end
		arenatarget[i]:Size(30, 27)
	end
end

----------------------------------------------------------------------------------------
--	Testmode(by Fernir)
----------------------------------------------------------------------------------------
SlashCmdList.TESTUF = function()
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if not v.fff then
				v.fff = CreateFrame("Frame")
				v.fff:SetTemplate("Transparent")
				v.fff:SetParent(UIParent)
				v.fff:SetFrameStrata("MEDIUM")
				v.fff:SetFrameLevel(20)
				v.fff:SetPoint("TOPLEFT", v, -2, 2)
				v.fff:SetPoint("BOTTOMRIGHT", v, 2, -2)
			
				v.fffs = T.SetFontString(v.fff, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				v.fffs:SetShadowOffset(0, 0)
				v.fffs:SetAllPoints(v.fff)
				v.fffs:SetText(v:GetName())
			else
				if v.fff:IsShown() then 
					v.fff:Hide()
				else
					v.fff:Show()
				end
			end
		end
	end
end
SLASH_TESTUF1 = "/testuf"
SLASH_TESTUF2 = "/еуыега"

----------------------------------------------------------------------------------------
--	Player line
----------------------------------------------------------------------------------------
local HorizontalPlayerLine = CreateFrame("Frame", "HorizontalPlayerLine", oUF_Player)
HorizontalPlayerLine:CreatePanel("ClassColor", 228, 1, "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -5, -5)

local VerticalPlayerLine = CreateFrame("Frame", "VerticalPlayerLine", oUF_Player)
VerticalPlayerLine:CreatePanel("ClassColor", 1, 98, "RIGHT", HorizontalPlayerLine, "LEFT", 0, 13)

----------------------------------------------------------------------------------------
--	Target line
----------------------------------------------------------------------------------------
local HorizontalTargetLine = CreateFrame("Frame", "HorizontalTargetLine", oUF_Target)
HorizontalTargetLine:CreatePanel("ClassColor", 228, 1, "TOPRIGHT", "oUF_Target", "BOTTOMRIGHT", 5, -5)
HorizontalTargetLine:RegisterEvent("PLAYER_TARGET_CHANGED")
HorizontalTargetLine:SetScript("OnEvent", function(self)
	local _, class = UnitClass("target")
	local color = RAID_CLASS_COLORS[class]
	if color then
		self:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		self:SetBackdropBorderColor(unpack(C.media.border_color))
	end
end)

local VerticalTargetLine = CreateFrame("Frame", "VerticalTargetLine", oUF_Target)
VerticalTargetLine:CreatePanel("ClassColor", 1, 98, "LEFT", HorizontalTargetLine, "RIGHT", 0, 13)
VerticalTargetLine:RegisterEvent("PLAYER_TARGET_CHANGED")
VerticalTargetLine:SetScript("OnEvent", function(self)
	local _, class = UnitClass("target")
	local color = RAID_CLASS_COLORS[class]
	if color then
		self:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		self:SetBackdropBorderColor(unpack(C.media.border_color))
	end
end)

----------------------------------------------------------------------------------------
--	Delete same lines from unit dropdown menu
----------------------------------------------------------------------------------------
do
	UnitPopupMenus["SELF"] = {"PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "CONVERT_TO_RAID", "CONVERT_TO_PARTY", "DUNGEON_DIFFICULTY", "RAID_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "SELECT_ROLE", "LEAVE", "CANCEL"}
	UnitPopupMenus["PET"] = {"PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL"}
	UnitPopupMenus["PARTY"] = {"MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL"}
	UnitPopupMenus["PLAYER"] = {"WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL"}
	UnitPopupMenus["RAID_PLAYER"] = {"MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL"}
	UnitPopupMenus["RAID"] = {"MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "MOVE_PLAYER_FRAME", "MOVE_TARGET_FRAME", "CANCEL"}
	UnitPopupMenus["VEHICLE"] = {"RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL"}
	UnitPopupMenus["TARGET"] = {"RAID_TARGET_ICON", "CANCEL"}
	UnitPopupMenus["ARENAENEMY"] = {"CANCEL"}
	UnitPopupMenus["FOCUS"] = {"RAID_TARGET_ICON", "CANCEL"}
	UnitPopupMenus["BOSS"] = {"RAID_TARGET_ICON", "CANCEL"}
end