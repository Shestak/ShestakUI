local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	UnitFrames based on oUF_Caellian(by Caellian)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

-- Frame size
local unit_width = 60.2
local unit_height = 26

-- Create layout
local function Shared(self, unit)
	local unit = (self:GetParent():GetName():match("oUF_Party")) and "party"
	or (self:GetParent():GetName():match("oUF_RaidHeal")) and "raid"
	or (self:GetParent():GetName():match("oUF_MainTank")) and "tank" or unit

	-- Set our own colors
	self.colors = T.oUF_colors

	-- Register click
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	-- Backdrop for every units
	self:CreateBackdrop("Default")

	-- Health bar
	self.Health = CreateFrame("StatusBar", nil, self)
	self.Health:SetPoint("TOPLEFT")
	self.Health:SetPoint("TOPRIGHT")
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and unit ~= "tank" then
		self.Health:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
		self.Health:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	else
		self.Health:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 3)
		self.Health:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 3)
	end
	self.Health:SetStatusBarTexture(C.media.texture)

	if C.raidframe.vertical_health == true then
		self.Health:SetOrientation("VERTICAL")
	end

	self.Health.PostUpdate = function(health, unit)
		if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
			health:SetValue(0)
		end
	end

	self.Health.frequentUpdates = true
	if C.unitframe.own_color == true then
		self.Health.colorDisconnected = false
		self.Health.colorReaction = false
		self.Health.colorClass = false
		self.Health:SetStatusBarColor(unpack(C.unitframe.uf_color))
	else
		self.Health.colorDisconnected = true
		self.Health.colorReaction = true
		self.Health.colorClass = true
	end

	-- Health bar background
	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints(self.Health)
	self.Health.bg:SetTexture(C.media.texture)
	if C.unitframe.own_color == true then
		self.Health.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.2)
	else
		self.Health.bg.multiplier = 0.2
	end

	-- Names
	self.Info = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and unit ~= "tank" then
		self.Info:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
	else
		self.Info:SetPoint("TOP", self.Health, "TOP", 0, -4)
	end
	self:Tag(self.Info, "[GetNameColor][NameShort]")

	if not (self:GetAttribute("unitsuffix") == "pet" or (self:GetAttribute("unitsuffix") == "target" and unit ~= "tank")) then
		self.Health.value = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.Health.value:SetPoint("TOP", self.Info, "BOTTOM", 0, -1)
		self.Health.value:SetTextColor(1, 1, 1)

		self.Health.PostUpdate = T.PostUpdateRaidHealth

		-- Power bar
		self.Power = CreateFrame("StatusBar", nil, self)
		self.Power:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
		self.Power:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
		self.Power:SetPoint("TOP", self, "BOTTOM", 0, 2)
		self.Power:SetStatusBarTexture(C.media.texture)

		self.Power.PostUpdate = function(power, unit)
			if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
				power:SetValue(0)
			end
		end

		self.Power.frequentUpdates = true
		self.Power.colorDisconnected = true
		if C.unitframe.own_color == true then
			self.Power.colorClass = true
		else
			self.Power.colorPower = true
		end

		-- Power bar background
		self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
		self.Power.bg:SetAllPoints(self.Power)
		self.Power.bg:SetTexture(C.media.texture)
		self.Power.bg:SetAlpha(1)
		self.Power.bg.multiplier = 0.2
	end

	-- Agro border
	if C.raidframe.aggro_border == true then
		table.insert(self.__elements, T.UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", T.UpdateThreat, true)
		if not T.classic then
			self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", T.UpdateThreat)
			self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", T.UpdateThreat)
		end
	end

	-- Raid marks
	if C.raidframe.icons_raid_mark == true then
		self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidTargetIndicator:SetSize(12, 12)
		self.RaidTargetIndicator:SetPoint("BOTTOMLEFT", self.Health, -2, -5)
	end

	-- LFD role icons
	if C.raidframe.icons_role == true and not (self:GetAttribute("unitsuffix") == "target") then
		self.GroupRoleIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.GroupRoleIndicator:SetSize(12, 12)
		self.GroupRoleIndicator:SetPoint("TOP", self.Health, 0, 8)
	end

	-- Ready check icons
	if C.raidframe.icons_ready_check == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.ReadyCheckIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheckIndicator:SetSize(12, 12)
		self.ReadyCheckIndicator:SetPoint("BOTTOMRIGHT", self.Health, 2, 1)
	end

	-- Summon icons
	if not T.classic and C.raidframe.icons_sumon == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.SummonIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.SummonIndicator:SetSize(24, 24)
		self.SummonIndicator:SetPoint("BOTTOMRIGHT", self.Health, 7, -11)
	end

	-- Leader/Assistant icons
	if C.raidframe.icons_leader == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		-- Leader icon
		self.LeaderIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.LeaderIndicator:SetSize(12, 12)
		self.LeaderIndicator:SetPoint("TOPLEFT", self.Health, -3, 8)

		-- Assistant icon
		self.AssistantIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.AssistantIndicator:SetSize(12, 12)
		self.AssistantIndicator:SetPoint("TOPLEFT", self.Health, -3, 8)
	end

	-- Resurrect icon
	if not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.ResurrectIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.ResurrectIndicator:SetSize(13, 13)
		self.ResurrectIndicator:SetPoint("BOTTOMRIGHT", self.Health, 2, -7)
	end

	-- Debuff highlight
	if not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.DebuffHighlight = self.Health:CreateTexture(nil, "OVERLAY")
		self.DebuffHighlight:SetAllPoints(self.Health)
		self.DebuffHighlight:SetTexture(C.media.highlight)
		self.DebuffHighlight:SetVertexColor(0, 0, 0, 0)
		self.DebuffHighlight:SetBlendMode("ADD")
		self.DebuffHighlightAlpha = 1
		self.DebuffHighlightFilter = true
	end

	-- Incoming heal text/bar
	if not T.classic and C.raidframe.plugins_healcomm == true then
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

		--self.IncHeal = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		--self.IncHeal:SetPoint("CENTER", self.Health, "TOP", 0, 0)
		--self:Tag(self.IncHeal, "[IncHeal]")
	end

	-- Range alpha
	if C.raidframe.show_range == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.Range = {insideAlpha = 1, outsideAlpha = C.raidframe.range_alpha}
	end

	-- Smooth bars
	if C.unitframe.plugins_smooth_bar == true then
		self.Health.Smooth = true
		if not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
			self.Power.Smooth = true
		end
	end

	if C.raidframe.plugins_aura_watch == true and not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		-- Classbuffs
		T.CreateAuraWatch(self, unit)

		-- Raid debuffs
		self.RaidDebuffs = CreateFrame("Frame", nil, self)
		self.RaidDebuffs:SetHeight(19)
		self.RaidDebuffs:SetWidth(19)
		self.RaidDebuffs:SetPoint("CENTER", self, 0, 1)
		self.RaidDebuffs:SetFrameStrata("MEDIUM")
		self.RaidDebuffs:SetFrameLevel(10)
		self.RaidDebuffs:SetTemplate("Default")

		self.RaidDebuffs.icon = self.RaidDebuffs:CreateTexture(nil, "BORDER")
		self.RaidDebuffs.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		self.RaidDebuffs.icon:SetPoint("TOPLEFT", 2, -2)
		self.RaidDebuffs.icon:SetPoint("BOTTOMRIGHT", -2, 2)

		if C.raidframe.plugins_aura_watch_timer == true then
			self.RaidDebuffs.time = T.SetFontString(self.RaidDebuffs, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			self.RaidDebuffs.time:SetPoint("CENTER", 1, 1)
			self.RaidDebuffs.time:SetTextColor(1, 1, 1)
		end

		self.RaidDebuffs.count = T.SetFontString(self.RaidDebuffs, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.RaidDebuffs.count:SetPoint("BOTTOMRIGHT", self.RaidDebuffs, "BOTTOMRIGHT", 3, -1)
		self.RaidDebuffs.count:SetTextColor(1, 1, 1)

		if C.aura.show_spiral == true then
			self.RaidDebuffs.cd = CreateFrame("Cooldown", nil, self.RaidDebuffs, "CooldownFrameTemplate")
			self.RaidDebuffs.cd:SetPoint("TOPLEFT", 2, -2)
			self.RaidDebuffs.cd:SetPoint("BOTTOMRIGHT", -2, 2)
			self.RaidDebuffs.cd:SetReverse(true)
			self.RaidDebuffs.cd:SetDrawEdge(false)
			self.RaidDebuffs.cd.noCooldownCount = true
			self.RaidDebuffs.parent = CreateFrame("Frame", nil, self.RaidDebuffs)
			self.RaidDebuffs.parent:SetFrameLevel(self.RaidDebuffs.cd:GetFrameLevel() + 1)
			if C.raidframe.plugins_aura_watch_timer == true then
				self.RaidDebuffs.time:SetParent(self.RaidDebuffs.parent)
			end
			self.RaidDebuffs.count:SetParent(self.RaidDebuffs.parent)
		end

		self.RaidDebuffs.ShowDispellableDebuff = C.raidframe.plugins_debuffhighlight_icon
		self.RaidDebuffs.FilterDispellableDebuff = true
		self.RaidDebuffs.MatchBySpellName = true
		self.RaidDebuffs.Debuffs = T.RaidDebuffs
	end

	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
-- Temporary
local BuggedSecureGroupHeaders = true
if BuggedSecureGroupHeaders then return end

oUF:Factory(function(self)
	if SavedOptions == nil or SavedOptions.RaidLayout ~= "HEAL" then return end

	oUF:RegisterStyle("ShestakHeal", Shared)
	oUF:SetActiveStyle("ShestakHeal")
	if C.raidframe.show_party == true then
		-- Party
		local party = self:SpawnHeader("oUF_Party", nil, "custom [@raid6,exists] hide;show",
			"oUF-initialConfigFunction", [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute("initial-width"))
				self:SetHeight(header:GetAttribute("initial-height"))
			]],
			"initial-width", unit_width,
			"initial-height", T.Scale(unit_height),
			"showSolo", C.raidframe.solo_mode,
			"showPlayer", C.raidframe.player_in_party,
			"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
			"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
			"sortMethod", C.raidframe.by_role and "NAME",
			"showParty", true,
			"showRaid", true,
			"xOffset", T.Scale(7),
			"point", "LEFT"
		)
		if C.raidframe.player_in_party == true then
			party:SetPoint(unpack(C.position.unitframes.party_heal))
		else
			party:SetPoint(C.position.unitframes.party_heal[1], C.position.unitframes.party_heal[2], C.position.unitframes.party_heal[3], C.position.unitframes.party_heal[4] + 32, C.position.unitframes.party_heal[5])
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
			"initial-height", T.Scale(unit_height / 2),
			"showSolo", C.raidframe.solo_mode,
			"showPlayer", C.raidframe.player_in_party,
			"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
			"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
			"sortMethod", C.raidframe.by_role and "NAME",
			"showParty", true,
			"showRaid", true,
			"xOffset", T.Scale(7),
			"point", "LEFT"
		)
		partytarget:SetPoint("TOPLEFT", party, "BOTTOMLEFT", 0, -7)

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
			"initial-height", T.Scale(unit_height / 2),
			"showSolo", C.raidframe.solo_mode,
			"showPlayer", C.raidframe.player_in_party,
			"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
			"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
			"sortMethod", C.raidframe.by_role and "NAME",
			"showParty", true,
			"showRaid", true,
			"xOffset", T.Scale(7),
			"point", "LEFT"
		)

		partypet:SetPoint("TOPLEFT", party, "BOTTOMLEFT", 0, -((unit_height / 2) + 14.5))
	end

	if C.raidframe.show_raid == true then
		if C.raidframe.raid_groups_vertical then
			-- Raid vertical
			local raid = {}
			for i = 1, C.raidframe.raid_groups do
				local raidgroup = self:SpawnHeader("oUF_RaidHeal"..i, nil, "custom [@raid6,exists] show;hide",
					"oUF-initialConfigFunction", [[
						local header = self:GetParent()
						self:SetWidth(header:GetAttribute("initial-width"))
						self:SetHeight(header:GetAttribute("initial-height"))
					]],
					"initial-width", unit_width,
					"initial-height", T.Scale(unit_height),
					"showRaid", true,
					"yOffset", T.Scale(-5),
					"point", "TOPLEFT",
					"groupFilter", tostring(i),
					"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
					"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
					"sortMethod", C.raidframe.by_role and "NAME",
					"maxColumns", 5,
					"unitsPerColumn", 1,
					"columnSpacing", T.Scale(7),
					"columnAnchorPoint", "TOP"
				)
				if i == 1 then
					raidgroup:SetPoint(unpack(C.position.unitframes.raid_heal))
				else
					raidgroup:SetPoint("TOPLEFT", raid[i-1], "TOPRIGHT", 7, 0)
				end
				raid[i] = raidgroup
			end
		else
			-- Raid horizontal
			local raid = {}
			for i = 1, C.raidframe.raid_groups do
				local raidgroup = self:SpawnHeader("oUF_RaidHeal"..i, nil, "custom [@raid6,exists] show;hide",
					"oUF-initialConfigFunction", [[
						local header = self:GetParent()
						self:SetWidth(header:GetAttribute("initial-width"))
						self:SetHeight(header:GetAttribute("initial-height"))
					]],
					"initial-width", unit_width,
					"initial-height", T.Scale(unit_height),
					"showRaid", true,
					"groupFilter", tostring(i),
					"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
					"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
					"sortMethod", C.raidframe.by_role and "NAME",
					"point", "LEFT",
					"maxColumns", 5,
					"unitsPerColumn", 1,
					"columnSpacing", T.Scale(7),
					"columnAnchorPoint", "LEFT"
				)
				if i == 1 then
					raidgroup:SetPoint(unpack(C.position.unitframes.raid_heal))
				else
					raidgroup:SetPoint("TOPLEFT", raid[i-1], "BOTTOMLEFT", 0, -7)
				end
				raid[i] = raidgroup
			end
		end

		if C.raidframe.raid_tanks == true then
			-- Tanks
			if C.raidframe.raid_tanks_tt == true then
				mt_template = "oUF_MainTankTT"
			else
				mt_template = "oUF_MainTank"
			end
			local raidtank = self:SpawnHeader("oUF_MainTank", nil, "raid",
				"oUF-initialConfigFunction", ([[
					self:SetWidth(%d)
					self:SetHeight(%d)
				]]):format(unit_width, unit_height),
				"showRaid", true,
				"yOffset", T.Scale(-7),
				"groupFilter", "MAINTANK",
				"template", mt_template
			)
			if C.actionbar.split_bars then
				raidtank:SetPoint(C.position.unitframes.tank[1], SplitBarRight, C.position.unitframes.tank[3], C.position.unitframes.tank[4], C.position.unitframes.tank[5])
			else
				raidtank:SetPoint(unpack(C.position.unitframes.tank))
			end
		end
	end
end)
