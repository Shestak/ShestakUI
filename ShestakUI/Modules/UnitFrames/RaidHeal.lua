local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	UnitFrames based on oUF_Caellian(by Caellian)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

-- Party size
local party_width = C.raidframe.heal_party_width
local party_height = C.raidframe.heal_party_height
local party_power_height = C.raidframe.heal_party_power_height
-- Raid size
local raid_width = C.raidframe.heal_raid_width
local raid_height = C.raidframe.heal_raid_height
local raid_power_height = C.raidframe.heal_raid_power_height

-- Create layout
local function Shared(self, unit)
	local unit = (self:GetParent():GetName():match("oUF_Party")) and "party"
	or (self:GetParent():GetName():match("oUF_RaidHeal")) and "raid"
	or (self:GetParent():GetName():match("oUF_MainTank")) and "tank" or unit

	local suffix = self:GetAttribute("unitsuffix")

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
	if (suffix == "pet" or suffix == "target") and unit ~= "tank" then
		self.Health:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
		self.Health:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	elseif unit == "party" then
		self.Health:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, party_power_height > 0 and party_power_height + 1 or 0)
		self.Health:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, party_power_height > 0 and party_power_height + 1 or 0)
	else
		self.Health:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, raid_power_height > 0 and raid_power_height + 1 or 0)
		self.Health:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, raid_power_height > 0 and raid_power_height + 1 or 0)
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
		self.Health.bg:SetVertexColor(unpack(C.unitframe.uf_color_bg))
	else
		self.Health.bg.multiplier = 0.2
	end

	-- Names
	self.Info = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
	self.Info:SetWordWrap(false)
	if (suffix == "pet" or suffix == "target") and unit ~= "tank" then
		self.Info:SetPoint("LEFT", self.Health, "LEFT", 0, 0)
		self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
	else
		self.Info:SetPoint("TOPLEFT", self.Health, "TOPLEFT", 0, -4)
		self.Info:SetPoint("TOPRIGHT", self.Health, "TOPRIGHT", 0, -4)
	end
	self:Tag(self.Info, "[GetNameColor][NameShort]")

	if not (suffix == "pet" or (suffix == "target" and unit ~= "tank")) then
		self.Health.value = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.Health.value:SetPoint("TOP", self.Info, "BOTTOM", 0, -1)
		self.Health.value:SetTextColor(1, 1, 1)

		if C.raidframe.hide_health_value then
			self.Health.value:SetAlpha(0)
		end

		self.Health.PostUpdate = T.PostUpdateRaidHealth

		-- Power bar
		self.Power = CreateFrame("StatusBar", nil, self)
		self.Power:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
		self.Power:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
		self.Power:SetPoint("TOP", self, "BOTTOM", 0, unit == "party" and party_power_height or raid_power_height)
		self.Power:SetStatusBarTexture(C.media.texture)

		self.Power.PostUpdate = function(power, unit)
			if not UnitIsConnected(unit) or UnitIsDeadOrGhost(unit) then
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

	-- Aggro border
	if C.raidframe.aggro_border == true then
		self.ThreatIndicator = CreateFrame("Frame", nil, self)
		self.ThreatIndicator.PostUpdate = T.UpdateThreat
	end

	-- Raid marks
	if C.raidframe.icons_raid_mark == true then
		self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidTargetIndicator:SetSize(12, 12)
		self.RaidTargetIndicator:SetPoint("BOTTOMLEFT", self.Health, -2, -5)
	end

	-- LFD role icons
	if C.raidframe.icons_role == true and not (suffix == "target") then
		self.GroupRoleIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.GroupRoleIndicator:SetSize(10, 10)
		self.GroupRoleIndicator:SetPoint("TOP", self.Health, 0, 6)
	end

	-- Ready check icons
	if C.raidframe.icons_ready_check == true and not (suffix == "target" or suffix == "targettarget") then
		self.ReadyCheckIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheckIndicator:SetSize(12, 12)
		self.ReadyCheckIndicator:SetPoint("BOTTOMRIGHT", self.Health, 2, 1)
	end

	-- Summon icons
	if C.raidframe.icons_sumon == true and not (suffix == "target" or suffix == "targettarget") then
		self.SummonIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.SummonIndicator:SetSize(24, 24)
		self.SummonIndicator:SetPoint("BOTTOMRIGHT", self.Health, 7, -11)
	end

	-- Phase icons
	if C.raidframe.icons_phase == true and not (suffix == "target" or suffix == "targettarget") then
		self.PhaseIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.PhaseIndicator:SetSize(20, 20)
		self.PhaseIndicator:SetPoint("TOPRIGHT", self.Health, 5, 5)
	end

	-- Leader/Assistant icons
	if C.raidframe.icons_leader == true and not (suffix == "target" or suffix == "targettarget") then
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
	if not (suffix == "target" or suffix == "targettarget") then
		self.ResurrectIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.ResurrectIndicator:SetSize(13, 13)
		self.ResurrectIndicator:SetPoint("BOTTOMRIGHT", self.Health, 2, -7)
	end

	-- Debuff highlight
	if not (suffix == "target" or suffix == "targettarget") then
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

		local hab = self.Health:CreateTexture(nil, "ARTWORK")
		hab:SetTexture(C.media.texture)
		hab:SetVertexColor(1, 0, 0, 0.4)

		self.HealthPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			absorbBar = ahpb,
			healAbsorbBar = hab
		}
	end

	-- Range alpha
	if C.raidframe.show_range == true and not (suffix == "target" or suffix == "targettarget") then
		self.Range = {insideAlpha = 1, outsideAlpha = C.raidframe.range_alpha}
	end

	-- Smooth bars
	if C.unitframe.plugins_smooth_bar == true then
		self.Health.Smooth = true
		if not (suffix == "pet" or suffix == "target") then
			self.Power.Smooth = true
		end
	end

	if C.raidframe.plugins_aura_watch == true and not (suffix == "pet" or suffix == "target" or suffix == "targettarget") then
		-- Classbuffs
		T.CreateAuraWatch(self, unit)

		-- Raid debuffs
		self.RaidDebuffs = CreateFrame("Frame", nil, self)
		self.RaidDebuffs:SetSize(19, 19)
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
	end

	if T.PostCreateHealRaidFrames then
		T.PostCreateHealRaidFrames(self, unit)
	end

	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
oUF:Factory(function(self)
	if C.raidframe.layout ~= "HEAL" and C.raidframe.layout ~= "AUTO" then return end

	oUF:RegisterStyle("ShestakHeal", Shared)
	oUF:SetActiveStyle("ShestakHeal")
	if C.raidframe.show_party == true then
		local party = self:SpawnHeader("oUF_Party", nil, "custom [@raid6,exists] hide;show",
			"oUF-initialConfigFunction", [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute("initial-width"))
				self:SetHeight(header:GetAttribute("initial-height"))
			]],
			"initial-width", party_width,
			"initial-height", T.Scale(party_height),
			"showSolo", C.raidframe.solo_mode,
			"showPlayer", C.raidframe.player_in_party,
			"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
			"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
			"sortMethod", C.raidframe.by_role and "NAME",
			"showParty", true,
			"showRaid", true,
			"xOffset", not C.raidframe.party_vertical and T.Scale(7),
			"yOffset", C.raidframe.party_vertical and T.Scale(-7),
			"point", C.raidframe.party_vertical and "TOP" or "LEFT"
		)
		party:SetPoint("TOPLEFT", _G["PartyAnchor"])
		if C.raidframe.party_vertical then
			_G["PartyAnchor"]:SetSize(party_width, party_height * 5 + T.Scale(7) * 4)
		else
			_G["PartyAnchor"]:SetSize(party_width * 5 + T.Scale(7) * 4, party_height)
		end

		-- Party targets
		if C.raidframe.show_target then
			local partytarget = self:SpawnHeader("oUF_PartyTarget", nil, "custom [@raid6,exists] hide;show",
				"oUF-initialConfigFunction", [[
					local header = self:GetParent()
					self:SetWidth(header:GetAttribute("initial-width"))
					self:SetHeight(header:GetAttribute("initial-height"))
					self:SetAttribute("unitsuffix", "target")
				]],
				"initial-width", C.raidframe.party_vertical and T.Scale(party_height) or party_width,
				"initial-height", C.raidframe.party_vertical and T.Scale(party_height) or T.Scale(party_height / 2),
				"showSolo", C.raidframe.solo_mode,
				"showPlayer", C.raidframe.player_in_party,
				"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
				"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
				"sortMethod", C.raidframe.by_role and "NAME",
				"showParty", true,
				"showRaid", true,
				"xOffset", not C.raidframe.party_vertical and T.Scale(7),
				"yOffset", C.raidframe.party_vertical and T.Scale(-7),
				"point", C.raidframe.party_vertical and "TOP" or "LEFT"
			)
			partytarget:SetPoint("TOPLEFT", _G["PartyTargetAnchor"])
			if C.raidframe.party_vertical then
				_G["PartyTargetAnchor"]:SetSize(T.Scale(party_height), T.Scale(party_height) * 5 + T.Scale(7) * 4)
				_G["PartyTargetAnchor"]:SetPoint("TOPLEFT", party, "TOPRIGHT", 7, 0)
			else
				_G["PartyTargetAnchor"]:SetSize(party_width * 5 + T.Scale(7) * 4, T.Scale(party_height / 2))
			end
		end

		-- Party pets
		if C.raidframe.show_pet then
			local partypet = self:SpawnHeader("oUF_PartyPet", nil, "custom [@raid6,exists] hide;show",
				"oUF-initialConfigFunction", [[
					local header = self:GetParent()
					self:SetWidth(header:GetAttribute("initial-width"))
					self:SetHeight(header:GetAttribute("initial-height"))
					self:SetAttribute("useOwnerUnit", "true")
					self:SetAttribute("unitsuffix", "pet")
				]],
				"initial-width", C.raidframe.party_vertical and T.Scale(party_height) or party_width,
				"initial-height", C.raidframe.party_vertical and T.Scale(party_height) or T.Scale(party_height / 2),
				"showSolo", C.raidframe.solo_mode,
				"showPlayer", C.raidframe.player_in_party,
				"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
				"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
				"sortMethod", C.raidframe.by_role and "NAME",
				"showParty", true,
				"showRaid", true,
				"xOffset", not C.raidframe.party_vertical and T.Scale(7),
				"yOffset", C.raidframe.party_vertical and T.Scale(-7),
				"point", C.raidframe.party_vertical and "TOP" or "LEFT"
			)
			partypet:SetPoint("TOPLEFT", _G["PartyPetAnchor"])
			if C.raidframe.party_vertical then
				_G["PartyPetAnchor"]:SetSize(T.Scale(party_height), T.Scale(party_height) * 5 + T.Scale(7) * 4)
				_G["PartyPetAnchor"]:SetPoint("TOPLEFT", party, "TOPRIGHT", T.Scale(party_height) + 14.5, 0)
			else
				_G["PartyPetAnchor"]:SetSize(party_width * 5 + T.Scale(7) * 4, T.Scale(party_height / 2))
			end
		end
	end

	if C.raidframe.show_raid == true then
		local raid = {}
		for i = 1, C.raidframe.raid_groups do
			local raidgroup = self:SpawnHeader("oUF_RaidHeal"..i, nil, "custom [@raid6,exists] show;hide",
				"oUF-initialConfigFunction", [[
					local header = self:GetParent()
					self:SetWidth(header:GetAttribute("initial-width"))
					self:SetHeight(header:GetAttribute("initial-height"))
				]],
				"initial-width", raid_width,
				"initial-height", T.Scale(raid_height),
				"showRaid", true,
				"groupFilter", tostring(i),
				"groupBy", C.raidframe.by_role and "ASSIGNEDROLE",
				"groupingOrder", C.raidframe.by_role and "TANK,HEALER,DAMAGER,NONE",
				"sortMethod", C.raidframe.by_role and "NAME",
				"maxColumns", 5,
				"unitsPerColumn", 1,
				"columnSpacing", T.Scale(7),
				"yOffset", C.raidframe.raid_groups_vertical and T.Scale(-5),
				"point", C.raidframe.raid_groups_vertical and "TOPLEFT" or "LEFT",
				"columnAnchorPoint", C.raidframe.raid_groups_vertical and "TOP" or "LEFT"
			)
			raidgroup:SetPoint("TOPLEFT", _G["RaidAnchor"..i])
			if C.raidframe.raid_groups_vertical then
				_G["RaidAnchor"..i]:SetSize(raid_width, T.Scale(raid_height) * 5 + T.Scale(7) * 4)
				if i == 1 then
					_G["RaidAnchor"..i]:SetPoint(unpack(C.position.unitframes.raid_heal))
				else
					_G["RaidAnchor"..i]:SetPoint("TOPLEFT", _G["RaidAnchor"..i-1], "TOPRIGHT", 7, 0)
				end
			else
				_G["RaidAnchor"..i]:SetSize(raid_width * 5 + T.Scale(7) * 4, T.Scale(raid_height))
				if i == 1 then
					_G["RaidAnchor"..i]:SetPoint(unpack(C.position.unitframes.raid_heal))
				else
					_G["RaidAnchor"..i]:SetPoint("TOPLEFT", _G["RaidAnchor"..i-1], "BOTTOMLEFT", 0, -7)
				end
			end
			raid[i] = raidgroup
		end

		if C.raidframe.raid_tanks == true then
			-- Tanks
			local raidtank = self:SpawnHeader("oUF_MainTank", nil, "raid",
				"oUF-initialConfigFunction", ([[
					self:SetWidth(%d)
					self:SetHeight(%d)
				]]):format(raid_width, raid_height),
				"showRaid", true,
				"yOffset", T.Scale(-7),
				"groupFilter", "MAINTANK",
				"template", C.raidframe.raid_tanks_tt and "oUF_MainTankTT" or "oUF_MainTank"
			)
			_G["RaidTankAnchor"]:SetSize(raid_width, raid_height)
			raidtank:SetPoint("TOPLEFT", _G["RaidTankAnchor"])
		end
	end
end)

-- Create anchors
for i = 1, C.raidframe.raid_groups do
	local raid = CreateFrame("Frame", "RaidAnchor"..i, UIParent)
end

local party = CreateFrame("Frame", "PartyAnchor", UIParent)
if C.raidframe.player_in_party == true then
	party:SetPoint(unpack(C.position.unitframes.party_heal))
else
	party:SetPoint(C.position.unitframes.party_heal[1], C.position.unitframes.party_heal[2], C.position.unitframes.party_heal[3], C.position.unitframes.party_heal[4] + 32, C.position.unitframes.party_heal[5])
end

local party_target = CreateFrame("Frame", "PartyTargetAnchor", UIParent)
party_target:SetPoint("TOPLEFT", party, "BOTTOMLEFT", 0, -7)

local party_pet = CreateFrame("Frame", "PartyPetAnchor", UIParent)
party_pet:SetPoint("TOPLEFT", party, "BOTTOMLEFT", 0, -((party_height / 2) + 14.5))

local raidtank = CreateFrame("Frame", "RaidTankAnchor", UIParent)
if C.actionbar.split_bars then
	raidtank:SetPoint(C.position.unitframes.tank[1], SplitBarRight, C.position.unitframes.tank[3], C.position.unitframes.tank[4], C.position.unitframes.tank[5])
else
	raidtank:SetPoint(unpack(C.position.unitframes.tank))
end

----------------------------------------------------------------------------------------
--	Test RaidFrames
----------------------------------------------------------------------------------------
do
	local frames = {}
	local moving = false
	SlashCmdList.TEST_RAID = function()
		if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end
		if not moving then
			oUF_RaidHeal1:Show()
			local raid = {}
			local raid_j = {}
			if #frames == 0 then
				for j = 1, C.raidframe.raid_groups do
					for i = 1, 5 do
						local frame = CreateFrame("Frame", nil, UIParent)
						frame:SetSize(raid_width, raid_height)
						if j == 1 then
							if i == 1 then
								frame:SetPoint("TOPLEFT", oUF_RaidHeal1, "TOPLEFT", 0, 0)
								raid_j[j] = frame
							else
								frame:SetPoint("TOPLEFT", raid[i-1], "TOPRIGHT", 7, 0)
							end
						else
							if i == 1 then
								frame:SetPoint("TOPLEFT", raid_j[j-1], "TOPLEFT", 0, -raid_height - 7)
								raid_j[j] = frame
							else
								frame:SetPoint("TOPLEFT", raid[i-1], "TOPRIGHT", 7, 0)
							end
						end
						frame:CreateBackdrop("Overlay")
						frame.backdrop.overlay:SetVertexColor(0.1, 0.9 - (j * 0.08) , 0.1)
						raid[i] = frame
						table.insert(frames, frame)
					end
				end
			else
				for _, frame in pairs(frames) do
					frame:Show()
				end
			end
			moving = true
		else
			for _, frame in pairs(frames) do
				frame:Hide()
			end
			moving = false
		end
	end
	SLASH_TEST_RAID1 = "/testraid"
	SLASH_TEST_RAID2 = "/еуыекфшв"
	SLASH_TEST_RAID3 = "/raidtest"
	SLASH_TEST_RAID4 = "/кфшвеуые"
end

do
	local frames = {}
	local moving = false
	SlashCmdList.TEST_PARTY = function()
		if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end
		if not moving then
			oUF_PartyUnitButton1:Show()
			local raid = {}
			if #frames == 0 then
				for i = 1, 5 do
					local frame = CreateFrame("Frame", nil, UIParent)
					frame:SetSize(party_width, party_height)
					if i == 1 then
						frame:SetPoint("TOPLEFT", oUF_PartyUnitButton1, "TOPLEFT", 0, 0)
					else
						if C.raidframe.party_vertical then
							frame:SetPoint("TOP", raid[i-1], "BOTTOM", 0, -7)
						else
							frame:SetPoint("TOPLEFT", raid[i-1], "TOPRIGHT", 7, 0)
						end
					end
					frame:CreateBackdrop("Overlay")
					frame.backdrop.overlay:SetVertexColor(random(255) / 255, random(255) / 255, random(255) / 255)
					raid[i] = frame
					table.insert(frames, frame)
				end
			else
				for _, frame in pairs(frames) do
					frame:Show()
				end
			end
			moving = true
		else
			for _, frame in pairs(frames) do
				frame:Hide()
			end
			moving = false
		end
	end
	SLASH_TEST_PARTY1 = "/testparty"
	SLASH_TEST_PARTY2 = "/еуыезфкен"
	SLASH_TEST_PARTY3 = "/partytest"
	SLASH_TEST_PARTY4 = "/зфкенеуые"
end