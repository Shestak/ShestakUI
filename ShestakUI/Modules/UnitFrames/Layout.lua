local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	UnitFrames based on oUF_Caellian(by Caellian)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

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
	if (unit == "arena" and C.unitframe.show_arena == true and unit ~= "arenatarget") or (unit == "boss" and C.unitframe.show_boss == true) then
		self:SetAttribute("type2", "focus")
		self:SetAttribute("type3", "macro")
		self:SetAttribute("macrotext3", "/clearfocus")
	else
		self:SetAttribute("*type2", "togglemenu")
	end

	-- Backdrop for every units
	self:CreateBackdrop("Default")
	self:SetFrameStrata("BACKGROUND")
	self.backdrop:SetFrameLevel(3)

	-- Health bar
	self.Health = CreateFrame("StatusBar", self:GetName().."_Health", self)
	if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
		self.Health:SetHeight(21)
	elseif unit == "arenatarget" then
		self.Health:SetHeight(27)
	else
		self.Health:SetHeight(13)
	end
	self.Health:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
	self.Health:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
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
		self.Health.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.2)
	else
		self.Health.bg.multiplier = 0.2
	end

	self.Health.value = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
	if unit == "player" or unit == "pet" or unit == "focus" then
		self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
		self.Health.value:SetJustifyH("RIGHT")
	elseif unit == "arena" then
		if C.unitframe.arena_on_right == true then
			self.Health.value:SetPoint("LEFT", self.Health, "LEFT", 2, 0)
			self.Health.value:SetJustifyH("LEFT")
		else
			self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			self.Health.value:SetJustifyH("RIGHT")
		end
	elseif unit == "boss" then
		if C.unitframe.boss_on_right == true then
			self.Health.value:SetPoint("LEFT", self.Health, "LEFT", 2, 0)
			self.Health.value:SetJustifyH("LEFT")
		else
			self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			self.Health.value:SetJustifyH("RIGHT")
		end
	elseif unit == "arenatarget" then
		self.Health.value:Hide()
	else
		self.Health.value:SetPoint("LEFT", self.Health, "LEFT", 2, 0)
		self.Health.value:SetJustifyH("LEFT")
	end

	-- Power bar
	self.Power = CreateFrame("StatusBar", self:GetName().."_Power", self)
	if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
		self.Power:SetHeight(5)
	elseif unit == "arenatarget" then
		self.Power:SetHeight(0)
	else
		self.Power:SetHeight(2)
	end
	self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -1)
	self.Power:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -1)
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
		self.Power.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.2)
	else
		self.Power.bg.multiplier = 0.2
	end

	self.Power.value = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
	if unit == "player" then
		self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", 0, 0)
		self.Power.value:SetJustifyH("RIGHT")
	elseif unit == "arena" then
		if C.unitframe.arena_on_right == true then
			self.Power.value:SetPoint("LEFT", self.Power, "LEFT", 2, 0)
			self.Power.value:SetJustifyH("LEFT")
		else
			self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", 0, 0)
			self.Power.value:SetJustifyH("RIGHT")
		end
	elseif unit == "boss" then
		if C.unitframe.boss_on_right == true then
			self.Power.value:SetPoint("LEFT", self.Power, "LEFT", 2, 0)
			self.Power.value:SetJustifyH("LEFT")
		else
			self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", 0, 0)
			self.Power.value:SetJustifyH("RIGHT")
		end
	elseif unit == "pet" or unit == "focus" or unit == "focustarget" or unit == "targettarget" then
		self.Power.value:Hide()
	else
		self.Power.value:SetPoint("LEFT", self.Power, "LEFT", 2, 0)
		self.Power.value:SetJustifyH("LEFT")
	end

	-- Names
	if unit ~= "player" then
		self.Info = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		if unit ~= "arenatarget" then
			self.Level = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		end
		if unit == "target" then
			self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			self:Tag(self.Info, "[GetNameColor][NameLong]")
			self.Level:SetPoint("RIGHT", self.Power, "RIGHT", 0, 0)
			self:Tag(self.Level, "[cpoints] [Threat] [DiffColor][level][shortclassification]")
		elseif unit == "focus" or unit == "pet" then
			self.Info:SetPoint("LEFT", self.Health, "LEFT", 2, 0)
			if unit == "pet" then
				self:Tag(self.Info, "[PetNameColor][NameMedium]")
			else
				self:Tag(self.Info, "[GetNameColor][NameMedium]")
			end
		elseif unit == "arenatarget" then
			self.Info:SetPoint("CENTER", self.Health, "CENTER", 1, 0)
			self:Tag(self.Info, "[GetNameColor][NameArena]")
		elseif unit == "arena" then
			if C.unitframe.arena_on_right == true then
				self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			else
				self.Info:SetPoint("LEFT", self.Health, "LEFT", 2, 0)
			end
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
		elseif unit == "boss" then
			if C.unitframe.boss_on_right == true then
				self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			else
				self.Info:SetPoint("LEFT", self.Health, "LEFT", 2, 0)
			end
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
		else
			self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
		end
	end

	if unit == "player" then
		self.FlashInfo = CreateFrame("Frame", "FlashInfo", self)
		self.FlashInfo:SetScript("OnUpdate", T.UpdateManaLevel)
		self.FlashInfo:SetFrameLevel(self.Health:GetFrameLevel() + 1)
		self.FlashInfo:SetAllPoints(self.Health)

		self.FlashInfo.ManaLevel = T.SetFontString(self.FlashInfo, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.FlashInfo.ManaLevel:SetPoint("CENTER", 0, 0)

		-- Combat icon
		if C.unitframe.icons_combat == true then
			self.Combat = self.Health:CreateTexture(nil, "OVERLAY")
			self.Combat:SetSize(18, 18)
			self.Combat:SetPoint("TOPRIGHT", 4, 8)
		end

		-- Resting icon
		if C.unitframe.icons_resting == true and T.level ~= MAX_PLAYER_LEVEL then
			self.Resting = self.Power:CreateTexture(nil, "OVERLAY")
			self.Resting:SetSize(18, 18)
			self.Resting:SetPoint("BOTTOMLEFT", -8, -8)
		end

		-- Leader/Assistant/ML icons
		if C.raidframe.icons_leader == true then
			-- Leader icon
			self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
			self.Leader:SetSize(14, 14)
			self.Leader:SetPoint("TOPLEFT", -3, 9)

			-- Assistant icon
			self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
			self.Assistant:SetSize(12, 12)
			self.Assistant:SetPoint("TOPLEFT", -3, 8)

			-- Master looter icon
			self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
			self.MasterLooter:SetSize(12, 12)
			self.MasterLooter:SetPoint("TOPRIGHT", 3, 8)
		end

		-- LFD role icons
		if C.raidframe.icons_role == true then
			self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
			self.LFDRole:SetSize(12, 12)
			self.LFDRole:SetPoint("TOPLEFT", 10, 8)
		end

		-- Rune bar
		if C.unitframe_class_bar.rune == true and T.class == "DEATHKNIGHT" then
			self.Runes = CreateFrame("Frame", self:GetName().."_RuneBar", self)
			self.Runes:CreateBackdrop("Default")
			self.Runes:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			self.Runes:SetSize(217, 7)

			for i = 1, 6 do
				self.Runes[i] = CreateFrame("StatusBar", self:GetName().."_RuneBar", self.Runes)
				self.Runes[i]:SetSize(212 / 6, 7)
				if i == 1 then
					self.Runes[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				else
					self.Runes[i]:SetPoint("TOPLEFT", self.Runes[i-1], "TOPRIGHT", 1, 0)
				end
				self.Runes[i]:SetStatusBarTexture(C.media.texture)
				self.Runes[i]:SetStatusBarColor(0.69, 0.31, 0.31)

				self.Runes[i].bg = self.Runes[i]:CreateTexture(nil, "BORDER")
				self.Runes[i].bg:SetAllPoints()
				self.Runes[i].bg:SetTexture(C.media.texture)
				self.Runes[i].bg:SetVertexColor(0.69, 0.31, 0.31, 0.2)
			end
		end

		if T.class == "MAGE" then
			-- Arcane Charge bar
			if C.unitframe_class_bar.arcane == true then
				self.ArcaneCharge = CreateFrame("Frame", self:GetName().."_ArcaneCharge", self)
				self.ArcaneCharge:CreateBackdrop("Default")
				self.ArcaneCharge:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				self.ArcaneCharge:SetSize(217, 7)

				for i = 1, 4 do
					self.ArcaneCharge[i] = CreateFrame("StatusBar", self:GetName().."_ArcaneCharge"..i, self.ArcaneCharge)
					self.ArcaneCharge[i]:SetSize(214 / 4, 7)
					if i == 1 then
						self.ArcaneCharge[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
					else
						self.ArcaneCharge[i]:SetPoint("TOPLEFT", self.ArcaneCharge[i-1], "TOPRIGHT", 1, 0)
					end
					self.ArcaneCharge[i]:SetStatusBarTexture(C.media.texture)
					self.ArcaneCharge[i]:SetStatusBarColor(0.4, 0.8, 1)

					self.ArcaneCharge[i].bg = self.ArcaneCharge[i]:CreateTexture(nil, "BORDER")
					self.ArcaneCharge[i].bg:SetAllPoints()
					self.ArcaneCharge[i].bg:SetTexture(C.media.texture)
					self.ArcaneCharge[i].bg:SetVertexColor(0.4, 0.8, 1, 0.2)
				end
			end

			-- Rune of Power bar
			if C.unitframe_class_bar.totem == true then
				self.TotemBar = CreateFrame("Frame", self:GetName().."_TotemBar", self)
				self.TotemBar:SetFrameLevel(self.Health:GetFrameLevel() + 2)
				self.TotemBar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
				self.TotemBar:SetSize(108, 7)
				self.TotemBar.Destroy = true

				for i = 1, 2 do
					self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar", self.TotemBar)
					self.TotemBar[i]:SetSize(108 / 2, 7)
					if i == 1 then
						self.TotemBar[i]:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
					else
						self.TotemBar[i]:SetPoint("TOPLEFT", self.TotemBar[i-1], "TOPRIGHT", 0, 0)
					end
					self.TotemBar[i]:SetStatusBarTexture(C.media.texture)
					self.TotemBar[i]:SetMinMaxValues(0, 1)
					self.TotemBar[i]:CreateBorder(false, true)

					self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
					self.TotemBar[i].bg:SetAllPoints()
					self.TotemBar[i].bg:SetTexture(C.media.texture)
					self.TotemBar[i].bg.multiplier = 0.2
				end
			end
		end

		if T.class == "MONK" then
			-- Chi bar
			if C.unitframe_class_bar.chi == true then
				self.HarmonyBar = CreateFrame("Frame", self:GetName().."_HarmonyBar", self)
				self.HarmonyBar:CreateBackdrop("Default")
				self.HarmonyBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				self.HarmonyBar:SetSize(217, 7)

				for i = 1, 6 do
					self.HarmonyBar[i] = CreateFrame("StatusBar", self:GetName().."_HarmonyBar", self.HarmonyBar)
					self.HarmonyBar[i]:SetSize(213 / 6, 7)
					if i == 1 then
						self.HarmonyBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
					else
						self.HarmonyBar[i]:SetPoint("TOPLEFT", self.HarmonyBar[i-1], "TOPRIGHT", 1, 0)
					end
					self.HarmonyBar[i]:SetStatusBarTexture(C.media.texture)
					self.HarmonyBar[i]:SetStatusBarColor(0.33, 0.63, 0.33)

					self.HarmonyBar[i].bg = self.HarmonyBar[i]:CreateTexture(nil, "BORDER")
					self.HarmonyBar[i].bg:SetAllPoints()
					self.HarmonyBar[i].bg:SetTexture(C.media.texture)
					self.HarmonyBar[i].bg:SetVertexColor(0.33, 0.63, 0.33, 0.2)
				end
			end

			-- Statue bar
			if C.unitframe_class_bar.totem == true then
				self.TotemBar = CreateFrame("Frame", self:GetName().."_TotemBar", self)
				self.TotemBar:SetFrameLevel(self.Health:GetFrameLevel() + 2)
				self.TotemBar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
				self.TotemBar:SetSize(53, 7)
				self.TotemBar.Destroy = true

				for i = 1, 1 do
					self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar", self.TotemBar)
					self.TotemBar[i]:SetSize(53, 7)
					self.TotemBar[i]:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
					self.TotemBar[i]:SetStatusBarTexture(C.media.texture)
					self.TotemBar[i]:SetMinMaxValues(0, 1)
					self.TotemBar[i]:CreateBorder(false, true)

					self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
					self.TotemBar[i].bg:SetAllPoints()
					self.TotemBar[i].bg:SetTexture(C.media.texture)
					self.TotemBar[i].bg.multiplier = 0.2
				end
			end

			-- Stagger bar
			if C.unitframe_class_bar.stagger == true then
				self.Stagger = CreateFrame("StatusBar", self:GetName().."_Stagger", self)
				self.Stagger:CreateBackdrop("Default")
				self.Stagger:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				self.Stagger:SetSize(217, 7)
				self.Stagger:SetStatusBarTexture(C.media.texture)

				self.Stagger.bg = self.Stagger:CreateTexture(nil, "BORDER")
				self.Stagger.bg:SetAllPoints()
				self.Stagger.bg:SetTexture(C.media.texture)
				self.Stagger.bg.multiplier = 0.2

				self.Stagger.Text = T.SetFontString(self.Stagger, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				self.Stagger.Text:SetPoint("CENTER", self.Stagger, "CENTER", 0, 0)
			end
		end

		-- Holy Power bar
		if C.unitframe_class_bar.holy == true and T.class == "PALADIN" then
			self.HolyPower = CreateFrame("Frame", self:GetName().."_HolyPowerBar", self)
			self.HolyPower:CreateBackdrop("Default")
			self.HolyPower:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			self.HolyPower:SetSize(217, 7)

			for i = 1, 5 do
				self.HolyPower[i] = CreateFrame("StatusBar", self:GetName().."_HolyPower"..i, self.HolyPower)
				self.HolyPower[i]:SetSize(213 / 5, 7)
				if i == 1 then
					self.HolyPower[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				else
					self.HolyPower[i]:SetPoint("TOPLEFT", self.HolyPower[i-1], "TOPRIGHT", 1, 0)
				end
				self.HolyPower[i]:SetStatusBarTexture(C.media.texture)
				self.HolyPower[i]:SetStatusBarColor(0.89, 0.88, 0.1)

				self.HolyPower[i].bg = self.HolyPower[i]:CreateTexture(nil, "BORDER")
				self.HolyPower[i].bg:SetAllPoints()
				self.HolyPower[i].bg:SetTexture(C.media.texture)
				self.HolyPower[i].bg:SetVertexColor(0.89, 0.88, 0.1, 0.2)
			end
		end

		-- Soul Shards bar
		if C.unitframe_class_bar.shard == true and T.class == "WARLOCK" then
			self.SoulShards = CreateFrame("Frame", self:GetName().."SoulShards", self)
			self.SoulShards:CreateBackdrop("Default")
			self.SoulShards:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			self.SoulShards:SetSize(217, 7)

			for i = 1, 5 do
				self.SoulShards[i] = CreateFrame("StatusBar", self:GetName().."SoulShards"..i, self.SoulShards)
				self.SoulShards[i]:SetSize(213 / 5, 7)
				if i == 1 then
					self.SoulShards[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				else
					self.SoulShards[i]:SetPoint("TOPLEFT", self.SoulShards[i-1], "TOPRIGHT", 1, 0)
				end
				self.SoulShards[i]:SetStatusBarTexture(C.media.texture)
				self.SoulShards[i]:SetStatusBarColor(0.9, 0.37, 0.37)

				self.SoulShards[i].bg = self.SoulShards[i]:CreateTexture(nil, "BORDER")
				self.SoulShards[i].bg:SetAllPoints()
				self.SoulShards[i].bg:SetTexture(C.media.texture)
				self.SoulShards[i].bg:SetVertexColor(0.9, 0.37, 0.37, 0.2)
			end
		end

		-- Rogue/Druid Combo bar
		if C.unitframe_class_bar.combo == true and C.unitframe_class_bar.combo_old ~= true and (T.class == "ROGUE" or T.class == "DRUID") then
			self.CPoints = CreateFrame("Frame", self:GetName().."_ComboBar", self)
			self.CPoints:CreateBackdrop("Default")
			self.CPoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			self.CPoints:SetSize(217, 7)

			for i = 1, 10 do
				self.CPoints[i] = CreateFrame("StatusBar", self:GetName().."_ComboBar", self.CPoints)
				self.CPoints[i]:SetSize(213 / 10, 7)
				if i == 1 then
					self.CPoints[i]:SetPoint("LEFT", self.CPoints)
				else
					self.CPoints[i]:SetPoint("LEFT", self.CPoints[i-1], "RIGHT", 1, 0)
				end
				self.CPoints[i]:SetStatusBarTexture(C.media.texture)
			end

			self.CPoints[1]:SetStatusBarColor(0.9, 0.1, 0.1)
			self.CPoints[2]:SetStatusBarColor(0.9, 0.1, 0.1)
			self.CPoints[3]:SetStatusBarColor(0.9, 0.9, 0.1)
			self.CPoints[4]:SetStatusBarColor(0.9, 0.9, 0.1)
			self.CPoints[5]:SetStatusBarColor(0.1, 0.9, 0.1)
			self.CPoints[6]:SetStatusBarColor(0.3, 0.3, 0.8)
			self.CPoints[7]:SetStatusBarColor(0.3, 0.3, 0.8)
			self.CPoints[8]:SetStatusBarColor(0.3, 0.3, 0.8)
			self.CPoints[9]:SetStatusBarColor(0.3, 0.3, 0.8)
			self.CPoints[10]:SetStatusBarColor(0.3, 0.3, 0.8)

			if T.class == "DRUID" and C.unitframe_class_bar.combo_always ~= true then
				self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", T.UpdateComboPoint)
			end

			self.CPoints.Override = T.UpdateComboPoint
		end

		-- Totem bar
		if C.unitframe_class_bar.totem == true and T.class == "SHAMAN" then
			self.TotemBar = CreateFrame("Frame", self:GetName().."_TotemBar", self)
			self.TotemBar:CreateBackdrop("Default")
			self.TotemBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			self.TotemBar:SetSize(217, 7)
			self.TotemBar.Destroy = true

			for i = 1, 4 do
				self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar", self.TotemBar)
				self.TotemBar[i]:SetSize(213 / 4, 7)

				local fixpos
				if i == 2 then
					self.TotemBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				elseif i == 1 then
					self.TotemBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 55, 7)
				else
					fixpos = i
					if i == 3 then fixpos = i-1 end
					self.TotemBar[i]:SetPoint("TOPLEFT", self.TotemBar[fixpos-1], "TOPRIGHT", 1, 0)
				end
				self.TotemBar[i]:SetStatusBarTexture(C.media.texture)
				self.TotemBar[i]:SetMinMaxValues(0, 1)

				self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
				self.TotemBar[i].bg:SetAllPoints()
				self.TotemBar[i].bg:SetTexture(C.media.texture)
				self.TotemBar[i].bg.multiplier = 0.2
			end
		end

		-- Additional mana
		if T.class == "DRUID" or T.class == "PRIEST" or T.class == "SHAMAN" then
			CreateFrame("Frame"):SetScript("OnUpdate", function() T.UpdateClassMana(self) end)
			self.ClassMana = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.ClassMana:SetTextColor(1, 0.49, 0.04)
		end

		-- Mushroom bar
		if T.class == "DRUID" then
			if C.unitframe_class_bar.totem == true then
				self.TotemBar = CreateFrame("Frame", self:GetName().."_TotemBar", self)
				self.TotemBar:SetFrameLevel(self.Health:GetFrameLevel() + 2)
				self.TotemBar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
				self.TotemBar:SetSize(108, 7)
				self.TotemBar.Destroy = true

				for i = 1, 3 do
					self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar", self.TotemBar)
					self.TotemBar[i]:SetSize(108 / 3, 7)
					if i == 1 then
						self.TotemBar[i]:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
					else
						self.TotemBar[i]:SetPoint("TOPLEFT", self.TotemBar[i-1], "TOPRIGHT", 0, 0)
					end
					self.TotemBar[i]:SetStatusBarTexture(C.media.texture)
					self.TotemBar[i]:SetMinMaxValues(0, 1)
					self.TotemBar[i]:CreateBorder(false, true)

					self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
					self.TotemBar[i].bg:SetAllPoints()
					self.TotemBar[i].bg:SetTexture(C.media.texture)
					self.TotemBar[i].bg.multiplier = 0.2
				end
			end
		end

		-- Mocking Banner bar
		if C.unitframe_class_bar.totem == true and T.class == "WARRIOR" then
			if C.unitframe_class_bar.totem == true then
				self.TotemBar = CreateFrame("Frame", self:GetName().."_TotemBar", self)
				self.TotemBar:SetFrameLevel(self.Health:GetFrameLevel() + 2)
				self.TotemBar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
				self.TotemBar:SetSize(53, 7)
				self.TotemBar.Destroy = true

				for i = 1, 1 do
					self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar", self.TotemBar)
					self.TotemBar[i]:SetSize(53, 7)
					self.TotemBar[i]:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
					self.TotemBar[i]:SetStatusBarTexture(C.media.texture)
					self.TotemBar[i]:SetMinMaxValues(0, 1)
					self.TotemBar[i]:CreateBorder(false, true)

					self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
					self.TotemBar[i].bg:SetAllPoints()
					self.TotemBar[i].bg:SetTexture(C.media.texture)
					self.TotemBar[i].bg.multiplier = 0.2
				end
			end
		end

		-- Experience bar
		if T.level ~= MAX_PLAYER_LEVEL and C.unitframe.plugins_experience_bar == true then
			self.Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
			self.Experience:CreateBackdrop("Default")
			if C.unitframe.portrait_enable == true then
				self.Experience:SetPoint("TOPLEFT", self, "TOPLEFT", -25 - C.unitframe.portrait_width, 28)
			else
				self.Experience:SetPoint("TOPLEFT", self, "TOPLEFT", -18, 28)
			end
			self.Experience:SetSize(7, 94)
			self.Experience:SetOrientation("Vertical")
			self.Experience:SetStatusBarTexture(C.media.texture)
			self.Experience:SetStatusBarColor(T.color.r, T.color.g, T.color.b)
			self.Experience:SetAlpha(0)

			self.Experience.bg = self.Experience:CreateTexture(nil, "BORDER")
			self.Experience.bg:SetAllPoints()
			self.Experience.bg:SetTexture(C.media.texture)
			self.Experience.bg:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.2)

			self.Experience.Rested = CreateFrame("StatusBar", nil, self.Experience)
			self.Experience.Rested:SetParent(self.Experience)
			self.Experience.Rested:SetOrientation("Vertical")
			self.Experience.Rested:SetAllPoints()
			self.Experience.Rested:SetStatusBarTexture(C.media.texture)
			self.Experience.Rested:SetStatusBarColor(0, 0.5, 1, 0.5)

			self.Experience:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Experience:HookScript("OnLeave", function(self) self:SetAlpha(0) end)
			self.Experience.Tooltip = true
		end

		-- Reputation bar
		if C.unitframe.plugins_reputation_bar == true then
			self.Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self)
			self.Reputation:CreateBackdrop("Default")
			if C.unitframe.portrait_enable == true then
				if T.level == MAX_PLAYER_LEVEL then
					self.Reputation:SetPoint("TOPLEFT", self, "TOPLEFT", -25 - C.unitframe.portrait_width, 28)
				else
					self.Reputation:SetPoint("TOPLEFT", self, "TOPLEFT", -39 - C.unitframe.portrait_width, 28)
				end
			else
				if T.level == MAX_PLAYER_LEVEL then
					self.Reputation:SetPoint("TOPLEFT", self, "TOPLEFT", -18, 28)
				else
					self.Reputation:SetPoint("TOPLEFT", self, "TOPLEFT", -32, 28)
				end
			end
			self.Reputation:SetSize(7, 94)
			self.Reputation:SetOrientation("Vertical")
			self.Reputation:SetStatusBarTexture(C.media.texture)
			self.Reputation:SetAlpha(0)

			self.Reputation.bg = self.Reputation:CreateTexture(nil, "BORDER")
			self.Reputation.bg:SetAllPoints()
			self.Reputation.bg:SetTexture(C.media.texture)

			self.Reputation:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Reputation:HookScript("OnLeave", function(self) self:SetAlpha(0) end)
			self.Reputation.PostUpdate = T.UpdateReputationColor
			self.Reputation.Tooltip = true
		end

		-- Artifact Power bar
		if C.unitframe.plugins_artifact_bar == true then
			self.ArtifactPower = CreateFrame("StatusBar", self:GetName().."_ArtifactPower", self)
			self.ArtifactPower:CreateBackdrop("Default")
			self.ArtifactPower:EnableMouse(true)
			if C.unitframe.portrait_enable == true then
				if T.level == MAX_PLAYER_LEVEL then
					if C.unitframe.plugins_reputation_bar == true then
						self.ArtifactPower:SetPoint("TOPLEFT", self, "TOPLEFT", -38 - C.unitframe.portrait_width, 28)
					else
						self.ArtifactPower:SetPoint("TOPLEFT", self, "TOPLEFT", -25 - C.unitframe.portrait_width, 28)
					end
				else
					if C.unitframe.plugins_reputation_bar == true then
						self.ArtifactPower:SetPoint("TOPLEFT", self, "TOPLEFT", -52 - C.unitframe.portrait_width, 28)
					else
						self.ArtifactPower:SetPoint("TOPLEFT", self, "TOPLEFT", -39 - C.unitframe.portrait_width, 28)
					end
				end
			else
				if T.level == MAX_PLAYER_LEVEL then
					if C.unitframe.plugins_reputation_bar == true then
						self.ArtifactPower:SetPoint("TOPLEFT", self, "TOPLEFT", -31, 28)
					else
						self.ArtifactPower:SetPoint("TOPLEFT", self, "TOPLEFT", -18, 28)
					end
				else
					if C.unitframe.plugins_reputation_bar == true then
						self.ArtifactPower:SetPoint("TOPLEFT", self, "TOPLEFT", -45, 28)
					else
						self.ArtifactPower:SetPoint("TOPLEFT", self, "TOPLEFT", -32, 28)
					end
				end
			end
			self.ArtifactPower:SetSize(7, 94)
			self.ArtifactPower:SetOrientation("Vertical")
			self.ArtifactPower:SetStatusBarTexture(C.media.texture)
			self.ArtifactPower.offAlpha = 0

			self.ArtifactPower.bg = self.ArtifactPower:CreateTexture(nil, "BORDER")
			self.ArtifactPower.bg:SetAllPoints()
			self.ArtifactPower.bg:SetTexture(C.media.texture)

			self.ArtifactPower:HookScript("OnEnter", function(self) self.ArtifactPower.offAlpha = 1 end)
			self.ArtifactPower:HookScript("OnLeave", function(self) self.ArtifactPower.offAlpha = 0 end)
			self.ArtifactPower.PostUpdate = function(self, event, isShown)
				self:SetStatusBarColor(T.color.r, T.color.g, T.color.b)
				self.bg:SetVertexColor(1, 0, 0, 0.2)
			end
			self.ArtifactPower.Tooltip = true
		end

		-- GCD spark
		if C.unitframe.plugins_gcd == true then
			self.GCD = CreateFrame("Frame", self:GetName().."_GCD", self)
			self.GCD:SetWidth(220)
			self.GCD:SetHeight(3)
			self.GCD:SetFrameStrata("HIGH")
			self.GCD:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 0)

			self.GCD.Color = {1, 1, 1}
			self.GCD.Height = T.Scale(3)
			self.GCD.Width = T.Scale(4)
		end
	end

	-- Counter bar
	if unit == "player" or unit == "pet" then
		self.CounterBar = CreateFrame("StatusBar", self:GetName().."_CounterBar", self)
		self.CounterBar:CreateBackdrop("Default")
		self.CounterBar:SetWidth(217)
		self.CounterBar:SetHeight(20)
		self.CounterBar:SetStatusBarTexture(C.media.texture)
		self.CounterBar:SetPoint("TOP", UIParent, "TOP", 0, -102)

		self.CounterBar.bg = self.CounterBar:CreateTexture(nil, "BORDER")
		self.CounterBar.bg:SetAllPoints()
		self.CounterBar.bg:SetTexture(C.media.texture)

		self.CounterBar.Text = T.SetFontString(self.CounterBar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.CounterBar.Text:SetPoint("CENTER")

		local r, g, b
		local max

		self.CounterBar:SetScript("OnValueChanged", function(_, value)
			_, max = self.CounterBar:GetMinMaxValues()
			r, g, b = oUF.ColorGradient(value, max, 1, 0, 0, 1, 1, 0, 0, 1, 0)
			self.CounterBar:SetStatusBarColor(r, g, b)
			self.CounterBar.bg:SetVertexColor(r, g, b, 0.2)
			self.CounterBar.Text:SetText(floor(value))
		end)
	end

	if unit == "pet" or unit == "targettarget" or unit == "focus" or unit == "focustarget" then
		self.Debuffs = CreateFrame("Frame", self:GetName().."Debuffs", self)
		self.Debuffs:SetHeight(25)
		self.Debuffs:SetWidth(109)
		self.Debuffs.size = T.Scale(25)
		self.Debuffs.spacing = T.Scale(3)
		self.Debuffs.num = 4
		self.Debuffs["growth-y"] = "DOWN"
		if unit == "pet" or unit == "focus" then
			self.Debuffs:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 2, -17)
			self.Debuffs.initialAnchor = "TOPRIGHT"
			self.Debuffs["growth-x"] = "LEFT"
		else
			self.Debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -2, -17)
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
			self.Portrait:SetHeight(C.unitframe.portrait_height)
			self.Portrait:SetWidth(C.unitframe.portrait_width)
			if unit == "player" then
				self.Portrait:SetPoint(unpack(C.position.unitframes.player_portrait))
			elseif unit == "target" then
				self.Portrait:SetPoint(unpack(C.position.unitframes.target_portrait))
			end

			self.Portrait:CreateBackdrop("Transparent")
			self.Portrait.backdrop:SetPoint("TOPLEFT", -2 + T.mult, 2 + T.mult)
			self.Portrait.backdrop:SetPoint("BOTTOMRIGHT", 2 + T.mult, -2 - T.mult)

			if C.unitframe.portrait_classcolor_border == true then
				if unit == "player" then
					self.Portrait.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
				elseif unit == "target" then
					self.Portrait.backdrop:RegisterEvent("PLAYER_TARGET_CHANGED")
					self.Portrait.backdrop:SetScript("OnEvent", function()
						local _, class = UnitClass("target")
						local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
						if color then
							self.Portrait.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
						else
							self.Portrait.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
						end
					end)
				end
			end
		end

		if unit == "player" then
			self.Debuffs = CreateFrame("Frame", self:GetName().."Debuffs", self)
			self.Debuffs:SetHeight(165)
			self.Debuffs:SetWidth(221)
			self.Debuffs.size = T.Scale(25)
			self.Debuffs.spacing = T.Scale(3)
			self.Debuffs.initialAnchor = "BOTTOMRIGHT"
			self.Debuffs["growth-y"] = "UP"
			self.Debuffs["growth-x"] = "LEFT"
			if (T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune == true)
			or ((T.class == "DRUID" or T.class == "ROGUE") and C.unitframe_class_bar.combo == true and C.unitframe_class_bar.combo_old ~= true)
			or (T.class == "SHAMAN" and C.unitframe_class_bar.totem == true)
			or (T.class == "WARLOCK" and C.unitframe_class_bar.shard == true) then
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19)
			else
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5)
			end

			self.Debuffs.PostCreateIcon = T.PostCreateAura
			self.Debuffs.PostUpdateIcon = T.PostUpdateIcon
		end

		if unit == "target" then
			self.Auras = CreateFrame("Frame", self:GetName().."Auras", self)
			self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5)
			self.Auras.initialAnchor = "BOTTOMLEFT"
			self.Auras["growth-x"] = "RIGHT"
			self.Auras["growth-y"] = "UP"
			self.Auras.numDebuffs = 16
			self.Auras.numBuffs = 32
			self.Auras:SetHeight(165)
			self.Auras:SetWidth(221)
			self.Auras.spacing = T.Scale(3)
			self.Auras.size = T.Scale(25)
			self.Auras.gap = true
			self.Auras.PostCreateIcon = T.PostCreateAura
			self.Auras.PostUpdateIcon = T.PostUpdateIcon

			-- Rogue/Druid Combo bar
			if C.unitframe_class_bar.combo == true and (C.unitframe_class_bar.combo_old == true or (T.class ~= "DRUID" and T.class ~= "ROGUE")) then
				self.CPoints = CreateFrame("Frame", self:GetName().."_ComboBar", self)
				self.CPoints:CreateBackdrop("Default")
				self.CPoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				self.CPoints:SetSize(217, 7)

				for i = 1, 10 do
					self.CPoints[i] = CreateFrame("StatusBar", self:GetName().."_ComboBar", self.CPoints)
					self.CPoints[i]:SetSize(213 / 10, 7)
					if i == 1 then
						self.CPoints[i]:SetPoint("LEFT", self.CPoints)
					else
						self.CPoints[i]:SetPoint("LEFT", self.CPoints[i-1], "RIGHT", 1, 0)
					end
					self.CPoints[i]:SetStatusBarTexture(C.media.texture)
				end

				self.CPoints[1]:SetStatusBarColor(0.9, 0.1, 0.1)
				self.CPoints[2]:SetStatusBarColor(0.9, 0.1, 0.1)
				self.CPoints[3]:SetStatusBarColor(0.9, 0.9, 0.1)
				self.CPoints[4]:SetStatusBarColor(0.9, 0.9, 0.1)
				self.CPoints[5]:SetStatusBarColor(0.1, 0.9, 0.1)
				self.CPoints[6]:SetStatusBarColor(0.3, 0.3, 0.8)
				self.CPoints[7]:SetStatusBarColor(0.3, 0.3, 0.8)
				self.CPoints[8]:SetStatusBarColor(0.3, 0.3, 0.8)
				self.CPoints[9]:SetStatusBarColor(0.3, 0.3, 0.8)
				self.CPoints[10]:SetStatusBarColor(0.3, 0.3, 0.8)

				self.CPoints.Override = T.UpdateComboPointOld
			end

			-- Priest Range bar
			if C.unitframe_class_bar.range == true and T.class == "PRIEST" then
				self.RangeBar = CreateFrame("StatusBar", self:GetName().."_RangeBar", self)
				self.RangeBar:CreateBackdrop("Default")
				self.RangeBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				self.RangeBar:SetSize(217, 7)
				self.RangeBar:SetStatusBarTexture(C.media.texture)

				self.RangeBar.bg = self.RangeBar:CreateTexture(nil, "BORDER")
				self.RangeBar.bg:SetAllPoints()
				self.RangeBar.bg:SetTexture(C.media.texture)
			end

			-- Enemy specialization
			if C.unitframe.plugins_enemy_spec == true then
				self.EnemySpec = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				self.EnemySpec:SetTextColor(1, 0, 0)
				self.EnemySpec:SetPoint("BOTTOM", self.Power, "BOTTOM", 0, -1)
			end

			-- Quest icon
			self.QuestIcon = self.Health:CreateTexture(nil, "OVERLAY")
			self.QuestIcon:SetSize(20, 20)
			self.QuestIcon:SetPoint("RIGHT", self.Info, "LEFT", -10, 0)

			-- Friendship bar
			if C.unitframe.plugins_friendship_bar == true then
				self.Friendship = CreateFrame("StatusBar", self:GetName().."_Friendship", self)
				self.Friendship:CreateBackdrop("Default")
				self.Friendship:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				self.Friendship:SetSize(217, 7)
				self.Friendship:SetStatusBarTexture(C.media.texture)
				self.Friendship:SetStatusBarColor(1, 0, 0)

				self.Friendship.bg = self.Friendship:CreateTexture(nil, "BORDER")
				self.Friendship.bg:SetAllPoints()
				self.Friendship.bg:SetTexture(C.media.texture)
				self.Friendship.bg:SetVertexColor(1, 0, 0, 0.2)

				self.Friendship.Tooltip = true

				self.Friendship.Value = T.SetFontString(self.Friendship, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				self.Friendship.Value:SetPoint("CENTER")
				self.Friendship.Value:SetTextColor(1, 1, 1)
				self:Tag(self.Friendship.Value, "[friendshipstanding] - [curfriendship]/[maxfriendship]")
			end
		end

		if C.unitframe.plugins_combat_feedback == true then
			self.CombatFeedbackText = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
			if C.unitframe.portrait_enable == true then
				self.CombatFeedbackText:SetPoint("BOTTOM", self.Portrait, "BOTTOM", 0, 0)
				self.CombatFeedbackText:SetParent(self.Portrait)
			else
				self.CombatFeedbackText:SetPoint("CENTER", 0, 1)
			end
		end

		if C.unitframe.icons_pvp == true then
			self.Status = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.Status:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
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
		self.Castbar:SetStatusBarTexture(C.media.texture, "ARTWORK")

		self.Castbar.bg = self.Castbar:CreateTexture(nil, "BORDER")
		self.Castbar.bg:SetAllPoints()
		self.Castbar.bg:SetTexture(C.media.texture)

		self.Castbar.Overlay = CreateFrame("Frame", nil, self.Castbar)
		self.Castbar.Overlay:SetTemplate("Default")
		self.Castbar.Overlay:SetFrameStrata("BACKGROUND")
		self.Castbar.Overlay:SetFrameLevel(3)
		self.Castbar.Overlay:SetPoint("TOPLEFT", -2, 2)
		self.Castbar.Overlay:SetPoint("BOTTOMRIGHT", 2, -2)

		self.Castbar.PostCastStart = T.PostCastStart
		self.Castbar.PostChannelStart = T.PostChannelStart

		if unit == "player" then
			if C.unitframe.castbar_icon == true then
				self.Castbar:SetPoint(C.position.unitframes.player_castbar[1], C.position.unitframes.player_castbar[2], C.position.unitframes.player_castbar[3], C.position.unitframes.player_castbar[4] + 11, C.position.unitframes.player_castbar[5])
				self.Castbar:SetWidth(258)
			else
				self.Castbar:SetPoint(unpack(C.position.unitframes.player_castbar))
				self.Castbar:SetWidth(281)
			end
			self.Castbar:SetHeight(16)
		elseif unit == "target" then
			if C.unitframe.castbar_icon == true then
				if C.unitframe.plugins_swing == true then
					self.Castbar:SetPoint(C.position.unitframes.target_castbar[1], C.position.unitframes.target_castbar[2], C.position.unitframes.target_castbar[3], C.position.unitframes.target_castbar[4] - 23, C.position.unitframes.target_castbar[5] + 12)
				else
					self.Castbar:SetPoint(C.position.unitframes.target_castbar[1], C.position.unitframes.target_castbar[2], C.position.unitframes.target_castbar[3], C.position.unitframes.target_castbar[4] - 23, C.position.unitframes.target_castbar[5])
				end
				self.Castbar:SetWidth(258)
			else
				if C.unitframe.plugins_swing == true then
					self.Castbar:SetPoint(C.position.unitframes.target_castbar[1], C.position.unitframes.target_castbar[2], C.position.unitframes.target_castbar[3], C.position.unitframes.target_castbar[4], C.position.unitframes.target_castbar[5] + 12)
				else
					self.Castbar:SetPoint(unpack(C.position.unitframes.target_castbar))
				end
				self.Castbar:SetWidth(281)
			end
			self.Castbar:SetHeight(16)
		elseif unit == "arena" or unit == "boss" then
			self.Castbar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -7)
			self.Castbar:SetWidth(150)
			self.Castbar:SetHeight(16)
		else
			self.Castbar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -7)
			self.Castbar:SetWidth(105)
			self.Castbar:SetHeight(5)
		end

		if unit == "focus" then
			self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
			self.Castbar.Button:SetHeight(65)
			self.Castbar.Button:SetWidth(65)
			self.Castbar.Button:SetPoint(unpack(C.position.unitframes.focus_castbar))
			self.Castbar.Button:SetTemplate("Default")

			self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
			self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, 2, -2)
			self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
			self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			self.Castbar.Time = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
			self.Castbar.Time:SetParent(self.Castbar.Button)
			self.Castbar.Time:SetPoint("CENTER", self.Castbar.Icon, "CENTER", 0, 10)
			self.Castbar.Time:SetTextColor(1, 1, 1)

			self.Castbar.Time2 = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
			self.Castbar.Time2:SetParent(self.Castbar.Button)
			self.Castbar.Time2:SetPoint("CENTER", self.Castbar.Icon, "CENTER", 0, -10)
			self.Castbar.Time2:SetTextColor(1, 1, 1)

			self.Castbar.CustomTimeText = function(self, duration)
				self.Time:SetText(("%.1f"):format(self.max))
				self.Time2:SetText(("%.1f"):format(self.channeling and duration or self.max - duration))
			end
			self.Castbar.CustomDelayText = function(self)
				self.Time:SetText(("|cffaf5050%s %.1f|r"):format(self.channeling and "-" or "+", abs(self.delay)))
			end
		end

		if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
			self.Castbar.Time = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.Castbar.Time:SetPoint("RIGHT", self.Castbar, "RIGHT", 0, 0)
			self.Castbar.Time:SetTextColor(1, 1, 1)
			self.Castbar.Time:SetJustifyH("RIGHT")
			self.Castbar.CustomTimeText = T.CustomCastTimeText
			self.Castbar.CustomDelayText = T.CustomCastDelayText

			self.Castbar.Text = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.Castbar.Text:SetPoint("LEFT", self.Castbar, "LEFT", 2, 0)
			self.Castbar.Text:SetPoint("RIGHT", self.Castbar.Time, "LEFT", -1, 0)
			self.Castbar.Text:SetTextColor(1, 1, 1)
			self.Castbar.Text:SetJustifyH("LEFT")
			self.Castbar.Text:SetHeight(C.font.unit_frames_font_size)

			if C.unitframe.castbar_icon == true and unit ~= "arena" then
				self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
				self.Castbar.Button:SetHeight(20)
				self.Castbar.Button:SetWidth(20)
				self.Castbar.Button:SetTemplate("Default")

				self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
				self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, 2, -2)
				self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
				self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				if unit == "player" then
					self.Castbar.Button:SetPoint("RIGHT", self.Castbar, "LEFT", -5, 0)
				elseif unit == "target" then
					self.Castbar.Button:SetPoint("LEFT", self.Castbar, "RIGHT", 5, 0)
				end
			end

			if unit == "arena" or unit == "boss" then
				self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
				self.Castbar.Button:SetHeight(20)
				self.Castbar.Button:SetWidth(20)
				self.Castbar.Button:SetTemplate("Default")
				if unit == "boss" then
					if C.unitframe.boss_on_right == true then
						self.Castbar.Button:SetPoint("TOPRIGHT", self.Castbar, "TOPLEFT", -5, 2)
					else
						self.Castbar.Button:SetPoint("TOPLEFT", self.Castbar, "TOPRIGHT", 5, 2)
					end
				else
					self.Castbar.Button:SetPoint("TOPRIGHT", self.Castbar, "TOPLEFT", -5, 2)
				end

				self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
				self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, 2, -2)
				self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
				self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end

			if unit == "player" and C.unitframe.castbar_latency == true then
				self.Castbar.SafeZone = self.Castbar:CreateTexture(nil, "BORDER", nil, 1)
				self.Castbar.SafeZone:SetTexture(C.media.texture)
				self.Castbar.SafeZone:SetVertexColor(0.85, 0.27, 0.27)

				self.Castbar.Latency = T.SetFontString(self.Castbar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
				self.Castbar.Latency:SetTextColor(1, 1, 1)
				self.Castbar.Latency:SetPoint("TOPRIGHT", self.Castbar.Time, "BOTTOMRIGHT", 0, 0)
				self.Castbar.Latency:SetJustifyH("RIGHT")

				self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED", function(self, event, caster) -- BETA Event check
					if (caster == "player" or caster == "vehicle") then
						self.Castbar.castSent = GetTime()
					end
				end)
			end
		end
	end

	-- Swing bar
	if C.unitframe.plugins_swing == true and unit == "player" then
		self.Swing = CreateFrame("StatusBar", self:GetName().."_Swing", self)
		self.Swing:CreateBackdrop("Default")
		self.Swing:SetPoint("BOTTOMRIGHT", "oUF_Player_Castbar", "TOPRIGHT", 0, 7)
		self.Swing:SetSize(281, 5)
		self.Swing:SetStatusBarTexture(C.media.texture)
		if C.unitframe.own_color == true then
			self.Swing:SetStatusBarColor(unpack(C.unitframe.uf_color))
		else
			self.Swing:SetStatusBarColor(T.color.r, T.color.g, T.color.b)
		end

		self.Swing.bg = self.Swing:CreateTexture(nil, "BORDER")
		self.Swing.bg:SetAllPoints(self.Swing)
		self.Swing.bg:SetTexture(C.media.texture)
		if C.unitframe.own_color == true then
			self.Swing.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.2)
		else
			self.Swing.bg:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.2)
		end

		self.Swing.Text = T.SetFontString(self.Swing, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.Swing.Text:SetPoint("CENTER", 0, 0)
		self.Swing.Text:SetTextColor(1, 1, 1)
	end

	if C.unitframe.show_arena and unit == "arena" then
		self.Trinket = CreateFrame("Frame", self:GetName().."_Trinket", self)
		self.Trinket:SetSize(31, 31)

		self.FactionIcon = CreateFrame("Frame", nil, self)
		self.FactionIcon:SetSize(31, 31)

		if C.unitframe.arena_on_right == true then
			self.Trinket:SetPoint("TOPRIGHT", self, "TOPLEFT", -5, 2)
			self.FactionIcon:SetPoint("TOPRIGHT", self, "TOPLEFT", -5, 2)
		else
			self.Trinket:SetPoint("TOPLEFT", self, "TOPRIGHT", 5, 2)
			self.FactionIcon:SetPoint("TOPLEFT", self, "TOPRIGHT", 5, 2)
		end
		self.Trinket:SetTemplate("Default")
		self.FactionIcon:SetTemplate("Default")

		self.AuraTracker = CreateFrame("Frame", self:GetName().."_Auratracker", self)
		self.AuraTracker:SetWidth(self.Trinket:GetWidth())
		self.AuraTracker:SetHeight(self.Trinket:GetHeight())
		self.AuraTracker:SetPoint("CENTER", self.Trinket, "CENTER")
		self.AuraTracker:SetFrameStrata("HIGH")

		self.AuraTracker.icon = self.AuraTracker:CreateTexture(nil, "ARTWORK")
		self.AuraTracker.icon:SetWidth(self.Trinket:GetWidth())
		self.AuraTracker.icon:SetHeight(self.Trinket:GetHeight())
		self.AuraTracker.icon:SetPoint("TOPLEFT", self.Trinket, 2, -2)
		self.AuraTracker.icon:SetPoint("BOTTOMRIGHT", self.Trinket, -2, 2)
		self.AuraTracker.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		self.AuraTracker.text = T.SetFontString(self.AuraTracker, C.font.unit_frames_font, C.font.unit_frames_font_size * 2, C.font.unit_frames_font_style)
		self.AuraTracker.text:SetPoint("CENTER", self.AuraTracker, 0, 0)
		self.AuraTracker:SetScript("OnUpdate", T.AuraTrackerTime)

		if C.unitframe.plugins_enemy_spec == true then
			self.EnemySpec = T.SetFontString(self.Power, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.EnemySpec:SetTextColor(1, 0, 0)
			if C.unitframe.arena_on_right == true then
				self.EnemySpec:SetPoint("RIGHT", self.Power, "RIGHT", 0, 0)
				self.EnemySpec:SetJustifyH("LEFT")
			else
				self.EnemySpec:SetPoint("LEFT", self.Power, "LEFT", 2, 0)
				self.EnemySpec:SetJustifyH("RIGHT")
			end
		end
	end

	if C.unitframe.show_boss and unit == "boss" then
		self.AltPowerBar = CreateFrame("StatusBar", nil, self.Health)
		self.AltPowerBar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
		self.AltPowerBar:SetHeight(4)
		self.AltPowerBar:SetStatusBarTexture(C.media.texture)
		self.AltPowerBar:SetStatusBarColor(1, 0, 0)
		self.AltPowerBar:SetPoint("LEFT")
		self.AltPowerBar:SetPoint("RIGHT")
		self.AltPowerBar:SetPoint("TOP", self.Health, "TOP")
		self.AltPowerBar:SetBackdrop({
			bgFile = C.media.blank,
			edgeFile = C.media.blank,
			tile = false, tileSize = 0, edgeSize = T.Scale(1),
			insets = {left = 0, right = 0, top = 0, bottom = T.Scale(-1)}
		})
		self.AltPowerBar:SetBackdropColor(0, 0, 0)
		self.AltPowerBar:SetBackdropBorderColor(0, 0, 0)

		self.AltPowerBar.text = T.SetFontString(self.AltPowerBar, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.AltPowerBar.text:SetPoint("CENTER", self.AltPowerBar, "CENTER", 0, 0)
		self:Tag(self.AltPowerBar.text, "[AltPower]")

		if C.aura.boss_buffs == true then
			self.Auras = CreateFrame("Frame", self:GetName().."_AuraBossBuff", self)
			if C.unitframe.boss_on_right == true then
				self.Auras:SetPoint("RIGHT", self, "LEFT", -5, 0)
				self.Auras.initialAnchor = "RIGHT"
				self.Auras["growth-x"] = "LEFT"
			else
				self.Auras:SetPoint("LEFT", self, "RIGHT", 5, 0)
				self.Auras.initialAnchor = "LEFT"
				self.Auras["growth-x"] = "RIGHT"
			end
			self.Auras.numDebuffs = C.unitframe.boss_debuffs
			self.Auras.numBuffs = C.unitframe.boss_buffs
			self.Auras:SetHeight(31)
			self.Auras:SetWidth(87)
			self.Auras.spacing = T.Scale(3)
			self.Auras.size = T.Scale(31)
			self.Auras.gap = true
			self.Auras.PostCreateIcon = T.PostCreateAura
			self.Auras.PostUpdateIcon = T.PostUpdateIcon
		end

		self:HookScript("OnShow", T.UpdateAllElements)
	end

	-- Agro border
	if C.raidframe.aggro_border == true and unit ~= "arenatarget" then
		table.insert(self.__elements, T.UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", T.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", T.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", T.UpdateThreat)
	end

	-- Raid marks
	if C.raidframe.icons_raid_mark == true then
		self.RaidIcon = self:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetParent(self.Health)
		self.RaidIcon:SetSize((unit == "player" or unit == "target") and 15 or 12, (unit == "player" or unit == "target") and 15 or 12)
		self.RaidIcon:SetPoint("TOP", self.Health, 0, 0)
	end

	-- Debuff highlight
	if unit ~= "arenatarget" then
		self.DebuffHighlight = self.Health:CreateTexture(nil, "OVERLAY")
		self.DebuffHighlight:SetAllPoints(self.Health)
		self.DebuffHighlight:SetTexture(C.media.highlight)
		self.DebuffHighlight:SetVertexColor(0, 0, 0, 0)
		self.DebuffHighlight:SetBlendMode("ADD")
		self.DebuffHighlightAlpha = 1
		self.DebuffHighlightFilter = true
	end

	-- Incoming heal text/bar
	if C.raidframe.plugins_healcomm == true then
		local mhpb = self.Health:CreateTexture(nil, "ARTWORK")
		mhpb:SetTexture(C.media.texture)
		mhpb:SetVertexColor(0, 1, 0.5, 0.2)

		local ohpb = self.Health:CreateTexture(nil, "ARTWORK")
		ohpb:SetTexture(C.media.texture)
		ohpb:SetVertexColor(0, 1, 0, 0.2)

		local ahpb = self.Health:CreateTexture(nil, "ARTWORK")
		ahpb:SetTexture(C.media.texture)
		ahpb:SetVertexColor(1, 1, 0, 0.2)

		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			absorbBar = ahpb,
			maxOverflow = 1,
			frequentUpdates = true
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
player:SetPoint(unpack(C.position.unitframes.player))
player:SetSize(217, 27)

local target = oUF:Spawn("target", "oUF_Target")
target:SetPoint(unpack(C.position.unitframes.target))
target:SetSize(217, 27)

if C.unitframe.show_pet == true then
	local pet = oUF:Spawn("pet", "oUF_Pet")
	pet:SetPoint(unpack(C.position.unitframes.pet))
	pet:SetSize(105, 16)
end

if C.unitframe.show_focus == true then
	local focus = oUF:Spawn("focus", "oUF_Focus")
	focus:SetPoint(unpack(C.position.unitframes.focus))
	focus:SetSize(105, 16)

	local focustarget = oUF:Spawn("focustarget", "oUF_FocusTarget")
	focustarget:SetPoint(unpack(C.position.unitframes.focus_target))
	focustarget:SetSize(105, 16)
else
	local focus = oUF:Spawn("focus", "oUF_Focus")
end

if C.unitframe.show_target_target == true then
	local targettarget = oUF:Spawn("targettarget", "oUF_TargetTarget")
	targettarget:SetPoint(unpack(C.position.unitframes.target_target))
	targettarget:SetSize(105, 16)
end

if C.unitframe.show_boss == true then
	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
		if i == 1 then
			if C.unitframe.boss_on_right == true then
				boss[i]:SetPoint(unpack(C.position.unitframes.boss))
			else
				boss[i]:SetPoint("BOTTOMLEFT", C.position.unitframes.boss[2], "LEFT", C.position.unitframes.boss[4] + 46, C.position.unitframes.boss[5])
			end
		else
			boss[i]:SetPoint("BOTTOM", boss[i-1], "TOP", 0, 30)
		end
		boss[i]:SetSize(150, 27)
	end
end

if C.unitframe.show_arena == true then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			if C.unitframe.arena_on_right == true then
				arena[i]:SetPoint(unpack(C.position.unitframes.arena))
			else
				arena[i]:SetPoint("BOTTOMLEFT", C.position.unitframes.arena[2], "LEFT", C.position.unitframes.arena[4] + 120, C.position.unitframes.arena[5])
			end
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 30)
		end
		arena[i]:SetSize(150, 27)
	end

	local arenatarget = {}
	for i = 1, 5 do
		arenatarget[i] = oUF:Spawn("arena"..i.."target", "oUF_Arena"..i.."Target")
		if i == 1 then
			if C.unitframe.arena_on_right == true then
				arenatarget[i]:SetPoint("TOPLEFT", arena[i], "TOPRIGHT", 7, 0)
			else
				arenatarget[i]:SetPoint("TOPRIGHT", arena[i], "TOPLEFT", -7, 0)
			end
		else
			arenatarget[i]:SetPoint("BOTTOM", arenatarget[i-1], "TOP", 0, 30)
		end
		arenatarget[i]:SetSize(30, 27)
	end
end

----------------------------------------------------------------------------------------
--	Arena preparation(by Blizzard)(../Blizzard_ArenaUI/Blizzard_ArenaUI.lua)
----------------------------------------------------------------------------------------
if C.unitframe.show_arena == true then
	local arenaprep = {}
	for i = 1, 5 do
		arenaprep[i] = CreateFrame("Frame", "oUF_ArenaPrep"..i, UIParent)
		arenaprep[i]:SetAllPoints(_G["oUF_Arena"..i])
		arenaprep[i]:CreateBackdrop("Default")
		arenaprep[i]:SetFrameStrata("BACKGROUND")

		arenaprep[i].Health = CreateFrame("StatusBar", nil, arenaprep[i])
		arenaprep[i].Health:SetAllPoints()
		arenaprep[i].Health:SetStatusBarTexture(C.media.texture)

		arenaprep[i].Spec = T.SetFontString(arenaprep[i].Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		arenaprep[i].Spec:SetPoint("CENTER")

		arenaprep[i]:Hide()
	end

	local arenaprepupdate = CreateFrame("Frame")
	arenaprepupdate:RegisterEvent("PLAYER_LOGIN")
	arenaprepupdate:RegisterEvent("PLAYER_ENTERING_WORLD")
	arenaprepupdate:RegisterEvent("ARENA_OPPONENT_UPDATE")
	arenaprepupdate:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
	arenaprepupdate:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_LOGIN" then
			for i = 1, 5 do
				arenaprep[i]:SetAllPoints(_G["oUF_Arena"..i])
			end
		elseif event == "ARENA_OPPONENT_UPDATE" then
			for i = 1, 5 do
				arenaprep[i]:Hide()
			end
		else
			local numOpps = GetNumArenaOpponentSpecs()

			if numOpps > 0 then
				for i = 1, 5 do
					local f = arenaprep[i]

					if i <= numOpps then
						local s = GetArenaOpponentSpec(i)
						local _, spec, class = nil, "UNKNOWN", "UNKNOWN"

						if s and s > 0 then
							_, spec, _, _, _, class = GetSpecializationInfoByID(s)
						end

						if class and spec then
							local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
							if C.unitframe.own_color == true then
								f.Health:SetStatusBarColor(unpack(C.unitframe.uf_color))
								f.Spec:SetText(spec)
								f.Spec:SetTextColor(color.r, color.g, color.b)
							else
								if color then
									f.Health:SetStatusBarColor(color.r, color.g, color.b)
								else
									f.Health:SetStatusBarColor(unpack(C.unitframe.uf_color))
								end
								f.Spec:SetText(spec)
							end
							f:Show()
						end
					else
						f:Hide()
					end
				end
			else
				for i = 1, 5 do
					arenaprep[i]:Hide()
				end
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Test UnitFrames(by community)
----------------------------------------------------------------------------------------
local moving = false
SlashCmdList.TEST_UF = function(msg)
	if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end
	if not moving then
		for _, frames in pairs({"oUF_Target", "oUF_TargetTarget", "oUF_Pet", "oUF_Focus", "oUF_FocusTarget"}) do
			_G[frames].oldunit = _G[frames].unit
			_G[frames]:SetAttribute("unit", "player")
		end

		if C.unitframe.show_arena == true then
			for i = 1, 5 do
				_G["oUF_Arena"..i].oldunit = _G["oUF_Arena"..i].unit
				_G["oUF_Arena"..i].Trinket.Hide = T.dummy
				_G["oUF_Arena"..i].Trinket.Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_37")
				_G["oUF_Arena"..i]:SetAttribute("unit", "player")

				_G["oUF_Arena"..i.."Target"].oldunit = 	_G["oUF_Arena"..i.."Target"].unit
				_G["oUF_Arena"..i.."Target"]:SetAttribute("unit", "player")

				if C.unitframe.plugins_enemy_spec == true then
					_G["oUF_Arena"..i].EnemySpec:SetText(SPECIALIZATION)
				end

				if C.unitframe.plugins_diminishing == true then
					SlashCmdList.DIMINISHINGCD()
				end
			end
		end

		if C.unitframe.show_boss == true then
			for i = 1, MAX_BOSS_FRAMES do
				_G["oUF_Boss"..i].oldunit = _G["oUF_Boss"..i].unit
				_G["oUF_Boss"..i]:SetAttribute("unit", "player")
			end
		end
		moving = true
	else
		for _, frames in pairs({"oUF_Target", "oUF_TargetTarget", "oUF_Pet", "oUF_Focus", "oUF_FocusTarget"}) do
			_G[frames]:SetAttribute("unit", _G[frames].oldunit)
		end

		if C.unitframe.show_arena == true then
			for i = 1, 5 do
				_G["oUF_Arena"..i].Trinket.Hide = nil
				_G["oUF_Arena"..i]:SetAttribute("unit", _G["oUF_Arena"..i].oldunit)
				_G["oUF_Arena"..i.."Target"]:SetAttribute("unit", _G["oUF_Arena"..i.."Target"].oldunit)
			end
		end

		if C.unitframe.show_boss == true then
			for i = 1, MAX_BOSS_FRAMES do
				_G["oUF_Boss"..i]:SetAttribute("unit", _G["oUF_Boss"..i].oldunit)
			end
		end
		moving = false
	end
end
SLASH_TEST_UF1 = "/testui"
SLASH_TEST_UF2 = "/еуыегш"
SLASH_TEST_UF3 = "/testuf"
SLASH_TEST_UF4 = "/еуыега"

----------------------------------------------------------------------------------------
--	Player line
----------------------------------------------------------------------------------------
if C.unitframe.lines == true then
	local HorizontalPlayerLine = CreateFrame("Frame", "HorizontalPlayerLine", oUF_Player)
	HorizontalPlayerLine:CreatePanel("ClassColor", 228, 1, "TOPLEFT", "oUF_Player", "BOTTOMLEFT", -5, -5)

	local VerticalPlayerLine = CreateFrame("Frame", "VerticalPlayerLine", oUF_Player)
	VerticalPlayerLine:CreatePanel("ClassColor", 1, 98, "RIGHT", HorizontalPlayerLine, "LEFT", 0, 13)
end

----------------------------------------------------------------------------------------
--	Target line
----------------------------------------------------------------------------------------
if C.unitframe.lines == true then
	local HorizontalTargetLine = CreateFrame("Frame", "HorizontalTargetLine", oUF_Target)
	HorizontalTargetLine:CreatePanel("ClassColor", 228, 1, "TOPRIGHT", "oUF_Target", "BOTTOMRIGHT", 5, -5)
	HorizontalTargetLine:RegisterEvent("PLAYER_TARGET_CHANGED")
	HorizontalTargetLine:SetScript("OnEvent", function(self)
		local _, class = UnitClass("target")
		local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
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
		local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		if color then
			self:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			self:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end)
end

----------------------------------------------------------------------------------------
--	Auto reposition heal raid frame
----------------------------------------------------------------------------------------
local function Reposition()
	if SavedOptions and SavedOptions.RaidLayout == "HEAL" and not C.raidframe.raid_groups_vertical then
		if C.raidframe.raid_groups < 6 then return end

		if C.unitframe.castbar_icon == true then
			oUF_Player_Castbar:SetPoint(C.position.unitframes.player_castbar[1], C.position.unitframes.player_castbar[2], C.position.unitframes.player_castbar[3], C.position.unitframes.player_castbar[4] + 11, C.position.unitframes.player_castbar[5] + (C.raidframe.raid_groups - 5) * 33)
		else
			oUF_Player_Castbar:SetPoint(C.position.unitframes.player_castbar[1], C.position.unitframes.player_castbar[2], C.position.unitframes.player_castbar[3], C.position.unitframes.player_castbar[4], C.position.unitframes.player_castbar[5] + (C.raidframe.raid_groups - 5) * 33)
		end

		player:SetPoint(C.position.unitframes.player[1], C.position.unitframes.player[2], C.position.unitframes.player[3], C.position.unitframes.player[4], C.position.unitframes.player[5] + (C.raidframe.raid_groups - 5) * 33)
		target:SetPoint(C.position.unitframes.target[1], C.position.unitframes.target[2], C.position.unitframes.target[3], C.position.unitframes.target[4], C.position.unitframes.target[5] + (C.raidframe.raid_groups - 5) * 33)
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", Reposition)
