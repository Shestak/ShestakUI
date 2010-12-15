----------------------------------------------------------------------------------------
--	
----------------------------------------------------------------------------------------
if not SettingsCF.unitframe.enable == true then return end
if IsAddOnLoaded("ShestakUI_DPS") then return end

local db_uf = SettingsCF.unitframe
local db_rf = SettingsCF.raidframe
local db_ff = SettingsCF.font
local db_pf = SettingsCF.position.unitframes

-- Frame size
local unit_width = 60.2
local unit_height = 26

-- Create layout
local function Shared(self, unit)
	local unit = (self:GetParent():GetName():match"oUF_Party") and "party" 
	or (self:GetParent():GetName():match"oUF_RaidHeal") and "raid"
	or (self:GetParent():GetName():match"oUF_MainTank") and "tank" or unit
	
	-- Set our own colors
	self.colors = SettingsDB.oUF_colors
	
	-- Register click
	self:RegisterForClicks("AnyDown")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	-- Menu
	self.menu = SettingsDB.SpawnMenu
	
	-- Update all elements
	self:HookScript("OnShow", SettingsDB.updateAllElements)
	
	-- Backdrop for every units
	self.FrameBackdrop = CreateFrame("Frame", nil, self)
	SettingsDB.CreateTemplate(self.FrameBackdrop)
	self.FrameBackdrop:SetFrameStrata("BACKGROUND")
	self.FrameBackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	self.FrameBackdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
	
	-- Health bar
	self.Health = CreateFrame("StatusBar", nil, self)
	self.Health:SetPoint("TOPLEFT")
	self.Health:SetPoint("TOPRIGHT")
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and unit ~= "tank" then
		self.Health:SetHeight(SettingsDB.Scale(14))
	else
		self.Health:SetHeight(SettingsDB.Scale(23))
	end
	self.Health:SetStatusBarTexture(SettingsCF.media.texture)
	
	if db_rf.vertical_health == true then
		self.Health:SetOrientation("VERTICAL")
	end
	
	self.Health.frequentUpdates = true

	if db_uf.own_color == true then
		self.Health.colorDisconnected = false
		self.Health.colorReaction = false
		self.Health.colorClass = false
		self.Health:SetStatusBarColor(unpack(db_uf.uf_color))
	else
		self.Health.colorDisconnected = true
		self.Health.colorReaction = true
		self.Health.colorClass = true
	end
	
	-- Health bar background
	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints(self.Health)
	self.Health.bg:SetTexture(SettingsCF.media.texture)
	if db_uf.own_color == true then
		self.Health.bg:SetVertexColor(0.1, 0.1, 0.1)
	else
		self.Health.bg.multiplier = 0.25
	end
	
	if not (self:GetAttribute("unitsuffix") == "pet" or (self:GetAttribute("unitsuffix") == "target" and unit ~= "tank")) then
		self.Health.value = SettingsDB.SetFontString(self.Health, db_ff.unit_frames_font, db_ff.unit_frames_font_size, db_ff.unit_frames_font_style)
		self.Health.value:SetPoint("CENTER", self.Health, "CENTER", 0, SettingsDB.Scale(-5))
		self.Health.value:SetTextColor(1, 1, 1)
		
		self.Health.PostUpdate = SettingsDB.PostUpdateRaidHealth

		-- Power bar
		self.Power = CreateFrame("StatusBar", nil, self)
		self.Power:SetHeight(SettingsDB.Scale(2))
		self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -SettingsDB.mult)
		self.Power:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -SettingsDB.mult)
		self.Power:SetStatusBarTexture(SettingsCF.media.texture)

		self.Power.frequentUpdates = true
		self.Power.colorDisconnected = true
		if db_uf.own_color == true then
			self.Power.colorClass = true
		else
			self.Power.colorPower = true
		end

		-- Power bar background
		self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
		self.Power.bg:SetAllPoints(self.Power)
		self.Power.bg:SetTexture(SettingsCF.media.texture)
		self.Power.bg:SetAlpha(1)
		self.Power.bg.multiplier = 0.3
	end
	
	-- Names
	self.Info = SettingsDB.SetFontString(self.Health, db_ff.unit_frames_font, db_ff.unit_frames_font_size, db_ff.unit_frames_font_style)
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and unit ~= "tank" then
		self.Info:SetPoint("CENTER", self.Health, "CENTER", 0, SettingsDB.Scale(1))
	else
		self.Info:SetPoint("CENTER", self.Health, "CENTER", 0, SettingsDB.Scale(4))
	end
	self:Tag(self.Info, "[GetNameColor][NameShort]")
	
	-- Agro border
    if db_rf.aggro_border == true then
		table.insert(self.__elements, SettingsDB.UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", SettingsDB.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", SettingsDB.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", SettingsDB.UpdateThreat)
	end
	
	-- Raid marks
	if db_rf.icons_raid_mark == true then
		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
		self.RaidIcon:SetPoint("BOTTOMLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(-5))
	end
	
	-- LFD role icons
	if db_rf.icons_lfd_role == true and not (self:GetAttribute("unitsuffix") == "target") then 
		self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
		self.LFDRole:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
		self.LFDRole:SetPoint("TOP", 0, SettingsDB.Scale(8))
	end
	
	-- Ready check icons
	if db_rf.icons_ready_check == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheck:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
		self.ReadyCheck:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(1))
	end
	
	-- Leader/Assistant/ML icons
	if db_rf.icons_leader == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		-- Leader icon
		self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
		self.Leader:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
		self.Leader:SetPoint("TOPLEFT", SettingsDB.Scale(-3), SettingsDB.Scale(8))
	
		-- Assistant icon
		self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
		self.Assistant:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
		self.Assistant:SetPoint("TOPLEFT", SettingsDB.Scale(-3), SettingsDB.Scale(8))
		
		-- Master looter icon
		self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
		self.MasterLooter:SetSize(SettingsDB.Scale(12), SettingsDB.Scale(12))
		self.MasterLooter:SetPoint("TOPRIGHT", SettingsDB.Scale(3), SettingsDB.Scale(8))
	end
	
	-- Debuff highlight
	if not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.DebuffHighlight = self.Health:CreateTexture(nil, "OVERLAY")
		self.DebuffHighlight:SetAllPoints(self.Health)
		self.DebuffHighlight:SetTexture(SettingsCF.media.highlight)
		self.DebuffHighlight:SetVertexColor(0, 0, 0, 0)
		self.DebuffHighlight:SetBlendMode("ADD")
		self.DebuffHighlightAlpha = 1
		self.DebuffHighlightFilter = true
	end
	
	-- Incoming heal text/bar
	if db_rf.plugins_healcomm == true then
		local mhpb = CreateFrame("StatusBar", nil, self.Health)
		if db_rf.vertical_health == true then
			mhpb:SetOrientation("VERTICAL")
			mhpb:SetPoint("BOTTOM", self.Health:GetStatusBarTexture(), "TOP", 0, 0)
			mhpb:SetHeight(unit_height)
		else
			mhpb:SetPoint("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
			mhpb:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		end
		mhpb:SetWidth(unit_width)
		mhpb:SetStatusBarTexture(SettingsCF.media.texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

		local ohpb = CreateFrame("StatusBar", nil, self.Health)
		if db_rf.vertical_health == true then
			ohpb:SetOrientation("VERTICAL")
			ohpb:SetPoint("BOTTOM", mhpb:GetStatusBarTexture(), "TOP", 0, 0)
			ohpb:SetHeight(unit_height)	
		else
			ohpb:SetPoint("TOPLEFT", mhpb:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
			ohpb:SetPoint("BOTTOMLEFT", mhpb:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		end
		ohpb:SetWidth(unit_width)
		ohpb:SetStatusBarTexture(SettingsCF.media.texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)

		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 1,
		}
	end

	-- Range alpha
	if db_rf.show_range == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.Range = {insideAlpha = 1, outsideAlpha = db_rf.range_alpha}
	end
	
	-- Smooth bars
	if db_uf.plugins_smooth_bar == true then
		self.Health.Smooth = true
		if not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
			self.Power.Smooth = true
		end
	end

	if db_rf.plugins_aura_watch == true and not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		-- Classbuffs
		SettingsDB.CreateAuraWatch(self, unit)
		
		-- Raid debuffs
		self.RaidDebuffs = CreateFrame("Frame", nil, self)
		self.RaidDebuffs:SetHeight(SettingsDB.Scale(19))
		self.RaidDebuffs:SetWidth(SettingsDB.Scale(19))
		self.RaidDebuffs:SetPoint("CENTER", self, 0, SettingsDB.Scale(1))
		self.RaidDebuffs:SetFrameStrata("HIGH")
		SettingsDB.CreateTemplate(self.RaidDebuffs)

		self.RaidDebuffs.icon = self.RaidDebuffs:CreateTexture(nil, "OVERLAY")
		self.RaidDebuffs.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		self.RaidDebuffs.icon:SetPoint("TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		self.RaidDebuffs.icon:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		
		if SettingsCF.aura.show_spiral == true then
			self.RaidDebuffs.cd = CreateFrame("Cooldown", nil, self.RaidDebuffs)
			self.RaidDebuffs.cd:SetPoint("TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			self.RaidDebuffs.cd:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
			self.RaidDebuffs.cd:SetReverse()
		end

		self.RaidDebuffs.count = SettingsDB.SetFontString(self.RaidDebuffs, db_ff.unit_frames_font, db_ff.unit_frames_font_size, db_ff.unit_frames_font_style)
		self.RaidDebuffs.count:SetPoint("BOTTOMRIGHT", self.RaidDebuffs, "BOTTOMRIGHT", SettingsDB.Scale(2), 0)
		self.RaidDebuffs.count:SetTextColor(1, 1, 1)
	end

	self:RegisterEvent("PARTY_MEMBERS_CHANGED", SettingsDB.updateAllElements)
	self:RegisterEvent("RAID_ROSTER_UPDATE", SettingsDB.updateAllElements)
	
	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
oUF:RegisterStyle("ShestakHeal", Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("ShestakHeal")
	if db_rf.show_party == true then
		-- Party
		local party = self:SpawnHeader("oUF_Party", nil, "custom [@raid6,exists] hide;show",
			"oUF-initialConfigFunction", [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute("initial-width"))
				self:SetHeight(header:GetAttribute("initial-height"))
			]],
			"initial-width", unit_width,
			"initial-height", unit_height,
			"showSolo", db_rf.solo_mode,
			"showPlayer", db_rf.player_in_party,
			"showParty", true,
			"showRaid", true,
			"xOffset", SettingsDB.Scale(7),
			"point", "LEFT"
		)
		if db_rf.player_in_party == true then
			party:SetPoint(unpack(db_pf.party_heal))
		else
			party:SetPoint(db_pf.party_heal[1], db_pf.party_heal[2], db_pf.party_heal[3], db_pf.party_heal[4] + 32, db_pf.party_heal[5])
		end
		
		-- Party targets
		local partytarget = self:SpawnHeader("oUF_PartyTarget", nil, "custom [@raid6,exists] hide;show",
			"oUF-initialConfigFunction", [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute("initial-width"))
				self:SetHeight(header:GetAttribute("initial-height"))
				self:SetAttribute("unitsuffix", "target")
			]],
			"initial-width", unit_width,
			"initial-height", unit_height-12,
			"showSolo", db_rf.solo_mode,
			"showPlayer", db_rf.player_in_party,
			"showParty", true,
			"showRaid", true,
			"xOffset", SettingsDB.Scale(7),
			"point", "LEFT"
		)
		partytarget:SetPoint("TOPLEFT", party, "BOTTOMLEFT", 0, SettingsDB.Scale(-7))
		
		-- Party pets
		local partypet = self:SpawnHeader("oUF_PartyPet", nil, "custom [@raid6,exists] hide;show",
			"oUF-initialConfigFunction", [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute("initial-width"))
				self:SetHeight(header:GetAttribute("initial-height"))
				self:SetAttribute("useOwnerUnit", "true")
				self:SetAttribute("unitsuffix", "pet")
			]],
			"initial-width", unit_width,
			"initial-height", unit_height-12,
			"showSolo", db_rf.solo_mode,
			"showPlayer", db_rf.player_in_party,
			"showParty", true,
			"showRaid", true,
			"xOffset", SettingsDB.Scale(7),
			"point", "LEFT"
		)

		local partypetupdate = CreateFrame("Frame")
		partypetupdate:SetScript("OnEvent", function(...)
			if InCombatLockdown() then return end

			local lastGroup = 1
			local numRaidMembers = GetNumRaidMembers()
			if numRaidMembers > 0 then
				local playerGroup
				for member = 1, numRaidMembers do
					_, _, playerGroup, _, _, _, _, _, _, _, _ = GetRaidRosterInfo(member)
					lastGroup = math.max(lastGroup, playerGroup)
				end
			end

			partypet:SetPoint("TOPLEFT", party[lastGroup], "BOTTOMLEFT", 0, -28)
		end)
		partypetupdate:RegisterEvent("PARTY_MEMBERS_CHANGED")
		partypetupdate:RegisterEvent("PLAYER_ENTERING_WORLD")
		partypetupdate:RegisterEvent("PLAYER_REGEN_ENABLED")
		partypetupdate:RegisterEvent("RAID_ROSTER_UPDATE")
		partypetupdate:RegisterEvent("UNIT_ENTERED_VEHICLE")
		partypetupdate:RegisterEvent("UNIT_EXITED_VEHICLE")
	end

	if db_rf.show_raid == true then
		if db_rf.raid_groups_vertical then
			-- Raid vertical
			local raid = {}
			for i = 1, db_rf.raid_groups do 
				local raidgroup = self:SpawnHeader("oUF_RaidHeal"..i, nil, "custom [@raid6,exists] show;hide",
					"oUF-initialConfigFunction", [[
						local header = self:GetParent()
						self:SetWidth(header:GetAttribute("initial-width"))
						self:SetHeight(header:GetAttribute("initial-height"))
					]],
					"initial-width", unit_width,
					"initial-height", unit_height,
					"showRaid", true,
					"yOffset", SettingsDB.Scale(-5),
					"point", "TOPLEFT",
					"groupFilter", tostring(i),
					"maxColumns", 5,
					"unitsPerColumn", 1,
					"columnSpacing", SettingsDB.Scale(7),
					"columnAnchorPoint", "TOP"
				)
				if i == 1 then
					raidgroup:SetPoint(unpack(db_pf.raid_heal))
				else
					raidgroup:SetPoint("TOPLEFT", raid[i-1], "TOPRIGHT", SettingsDB.Scale(7), 0)
				end
				raid[i] = raidgroup
			end
		else
			-- Raid horizontal
			local raid = {}
			for i = 1, db_rf.raid_groups do 
				local raidgroup = self:SpawnHeader("oUF_RaidHeal"..i, nil, "custom [@raid6,exists] show;hide",
					"oUF-initialConfigFunction", [[
						local header = self:GetParent()
						self:SetWidth(header:GetAttribute("initial-width"))
						self:SetHeight(header:GetAttribute("initial-height"))
					]],
					"initial-width", unit_width,
					"initial-height", unit_height,
					"showRaid", true,
					"groupFilter", tostring(i),
					"point", "LEFT",
					"maxColumns", 5,
					"unitsPerColumn", 1,
					"columnSpacing", SettingsDB.Scale(7),
					"columnAnchorPoint", "LEFT"
				)
				if i == 1 then
					raidgroup:SetPoint(unpack(db_pf.raid_heal))
				else
					raidgroup:SetPoint("TOPLEFT", raid[i-1], "BOTTOMLEFT", 0, SettingsDB.Scale(-7))
				end
				raid[i] = raidgroup
			end
		end
		
		if db_rf.raid_tanks == true then
			-- Tanks
			if db_rf.raid_tanks_tt == true then
				mt_template = "oUF_MainTankTT"
			else
				mt_template = "oUF_MainTank"
			end
			local raidtank = self:SpawnHeader("oUF_MainTank", nil, "raid",
				"oUF-initialConfigFunction", ([[
					self:SetWidth(60.2)
					self:SetHeight(26)
				]]),
				"showRaid", true,
				"yOffset", SettingsDB.Scale(-7),
				"groupFilter", "MAINTANK",
				"template", mt_template
			)
			raidtank:SetPoint(unpack(db_pf.tank))
		end
	end
end)

----------------------------------------------------------------------------------------
--	Force a Clique option if not set(by Elv22)
----------------------------------------------------------------------------------------
if IsAddOnLoaded("Clique") then
	local CliquePath = CliqueDB3["char"][SettingsDB.name.." - "..GetRealmName()]["downclick"]	
	StaticPopupDialogs["SETUP_CLIQUE"] = {
		text = L_POPUP_SETTINGS_CLIQUE,
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function() 
			CliqueDB3["char"][SettingsDB.name.." - "..GetRealmName()]["downclick"] = true 
			ReloadUI() 
		end,
		timeout = 0,
		whileDead = 1,
	}
	local CliqueCheck = CreateFrame("Frame")
	CliqueCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
	CliqueCheck:SetScript("OnEvent", function()
		if CliquePath ~= true then
			StaticPopup_Show("SETUP_CLIQUE")
		end
	end)
end