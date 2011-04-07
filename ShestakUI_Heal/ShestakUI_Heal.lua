local ADDON_NAME, ns = ...
local oUF = oUFShestakUI or oUF
assert(oUF, "ShestakUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local T, C, L = unpack(ShestakUI)
if not C.unitframe.enable == true then return end
if IsAddOnLoaded("ShestakUI_DPS") then return end

----------------------------------------------------------------------------------------
--	
----------------------------------------------------------------------------------------
-- Frame size
local unit_width = 60.2
local unit_height = 26

-- Create layout
local function Shared(self, unit)
	local unit = (self:GetParent():GetName():match"oUF_Party") and "party" 
	or (self:GetParent():GetName():match"oUF_RaidHeal") and "raid"
	or (self:GetParent():GetName():match"oUF_MainTank") and "tank" or unit
	
	-- Set our own colors
	self.colors = T.oUF_colors
	
	-- Register click
	self:RegisterForClicks("AnyDown")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	-- Menu
	self.menu = T.SpawnMenu
	
	-- Backdrop for every units
	self.FrameBackdrop = CreateFrame("Frame", nil, self)
	self.FrameBackdrop:SetTemplate("Default")
	self.FrameBackdrop:SetFrameStrata("BACKGROUND")
	self.FrameBackdrop:Point("TOPLEFT", -2, 2)
	self.FrameBackdrop:Point("BOTTOMRIGHT", 2, -2)
	
	-- Health bar
	self.Health = CreateFrame("StatusBar", nil, self)
	self.Health:SetPoint("TOPLEFT")
	self.Health:SetPoint("TOPRIGHT")
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and unit ~= "tank" then
		self.Health:Height(14)
	else
		self.Health:Height(23)
	end
	self.Health:SetStatusBarTexture(C.media.texture)
	
	if C.raidframe.vertical_health == true then
		self.Health:SetOrientation("VERTICAL")
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
		self.Health.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.25)
	else
		self.Health.bg.multiplier = 0.25
	end
	
	if not (self:GetAttribute("unitsuffix") == "pet" or (self:GetAttribute("unitsuffix") == "target" and unit ~= "tank")) then
		self.Health.value = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.Health.value:Point("CENTER", self.Health, "CENTER", 0, -5)
		self.Health.value:SetTextColor(1, 1, 1)
		
		self.Health.PostUpdate = T.PostUpdateRaidHealth

		-- Power bar
		self.Power = CreateFrame("StatusBar", nil, self)
		self.Power:Height(2)
		self.Power:Point("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -1)
		self.Power:Point("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -1)
		self.Power:SetStatusBarTexture(C.media.texture)

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
		self.Power.bg.multiplier = 0.3
	end
	
	-- Names
	self.Info = T.SetFontString(self.Health, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and unit ~= "tank" then
		self.Info:Point("CENTER", self.Health, "CENTER", 0, 0)
	else
		self.Info:Point("CENTER", self.Health, "CENTER", 0, 4)
	end
	self:Tag(self.Info, "[GetNameColor][NameShort]")
	
	-- Agro border
    if C.raidframe.aggro_border == true then
		table.insert(self.__elements, T.UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", T.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", T.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", T.UpdateThreat)
	end
	
	-- Raid marks
	if C.raidframe.icons_raid_mark == true then
		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:Size(12, 12)
		self.RaidIcon:Point("BOTTOMLEFT", self.Health, -2, -5)
	end
	
	-- LFD role icons
	if C.raidframe.icons_lfd_role == true and not (self:GetAttribute("unitsuffix") == "target") then 
		self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
		self.LFDRole:Size(12, 12)
		self.LFDRole:Point("TOP", self.Health, 0, 8)
	end
	
	-- Ready check icons
	if C.raidframe.icons_ready_check == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheck:Size(12, 12)
		self.ReadyCheck:Point("BOTTOMRIGHT", self.Health, 2, 1)
	end
	
	-- Leader/Assistant/ML icons
	if C.raidframe.icons_leader == true and not (self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "targettarget") then
		-- Leader icon
		self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
		self.Leader:Size(12, 12)
		self.Leader:Point("TOPLEFT", self.Health, -3, 8)
	
		-- Assistant icon
		self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
		self.Assistant:Size(12, 12)
		self.Assistant:Point("TOPLEFT", self.Health, -3, 8)
		
		-- Master looter icon
		self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
		self.MasterLooter:Size(12, 12)
		self.MasterLooter:Point("TOPRIGHT", self.Health, 3, 8)
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
	if C.raidframe.plugins_healcomm == true then
		local mhpb = CreateFrame("StatusBar", nil, self.Health)
		if C.raidframe.vertical_health == true then
			mhpb:SetOrientation("VERTICAL")
			mhpb:Point("BOTTOM", self.Health:GetStatusBarTexture(), "TOP", 0, 0)
			mhpb:Height(unit_height)
		else
			mhpb:Point("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
			mhpb:Point("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		end
		mhpb:Width(unit_width)
		mhpb:SetStatusBarTexture(C.media.texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

		local ohpb = CreateFrame("StatusBar", nil, self.Health)
		if C.raidframe.vertical_health == true then
			ohpb:SetOrientation("VERTICAL")
			ohpb:Point("BOTTOM", mhpb:GetStatusBarTexture(), "TOP", 0, 0)
			ohpb:Height(unit_height)	
		else
			ohpb:Point("TOPLEFT", mhpb:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
			ohpb:Point("BOTTOMLEFT", mhpb:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		end
		ohpb:Width(unit_width)
		ohpb:SetStatusBarTexture(C.media.texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)

		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 1,
		}
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
		self.RaidDebuffs:Height(19)
		self.RaidDebuffs:Width(19)
		self.RaidDebuffs:Point("CENTER", self, 0, 1)
		self.RaidDebuffs:SetFrameStrata("HIGH")
		self.RaidDebuffs:SetTemplate("Default")

		self.RaidDebuffs.icon = self.RaidDebuffs:CreateTexture(nil, "OVERLAY")
		self.RaidDebuffs.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		self.RaidDebuffs.icon:Point("TOPLEFT", 2, -2)
		self.RaidDebuffs.icon:Point("BOTTOMRIGHT", -2, 2)
			
		if C.aura.show_spiral == true then
			self.RaidDebuffs.cd = CreateFrame("Cooldown", nil, self.RaidDebuffs)
			self.RaidDebuffs.cd:Point("TOPLEFT", 2, -2)
			self.RaidDebuffs.cd:Point("BOTTOMRIGHT", -2, 2)
			self.RaidDebuffs.cd:SetReverse()
			self.RaidDebuffs.cd.noOCC = true
		end

		self.RaidDebuffs.count = T.SetFontString(self.RaidDebuffs, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		self.RaidDebuffs.count:Point("BOTTOMRIGHT", self.RaidDebuffs, "BOTTOMRIGHT", 2, 0)
		self.RaidDebuffs.count:SetTextColor(1, 1, 1)
	end
	
	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
oUF:RegisterStyle("ShestakHeal", Shared)
oUF:Factory(function(self)
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
			"showParty", true,
			"showRaid", true,
			"xOffset", T.Scale(7),
			"point", "LEFT"
		)
		if C.raidframe.player_in_party == true then
			party:Point(unpack(C.position.unitframes.party_heal))
		else
			party:Point(C.position.unitframes.party_heal[1], C.position.unitframes.party_heal[2], C.position.unitframes.party_heal[3], C.position.unitframes.party_heal[4] + 32, C.position.unitframes.party_heal[5])
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
			"initial-height", T.Scale(unit_height-12),
			"showSolo", C.raidframe.solo_mode,
			"showPlayer", C.raidframe.player_in_party,
			"showParty", true,
			"showRaid", true,
			"xOffset", T.Scale(7),
			"point", "LEFT"
		)
		partytarget:Point("TOPLEFT", party, "BOTTOMLEFT", 0, -7)
		
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
			"initial-height", T.Scale(unit_height-12),
			"showSolo", C.raidframe.solo_mode,
			"showPlayer", C.raidframe.player_in_party,
			"showParty", true,
			"showRaid", true,
			"xOffset", T.Scale(7),
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

			partypet:Point("TOPLEFT", party[lastGroup], "BOTTOMLEFT", 0, -28)
		end)
		partypetupdate:RegisterEvent("PARTY_MEMBERS_CHANGED")
		partypetupdate:RegisterEvent("PLAYER_ENTERING_WORLD")
		partypetupdate:RegisterEvent("PLAYER_REGEN_ENABLED")
		partypetupdate:RegisterEvent("RAID_ROSTER_UPDATE")
		partypetupdate:RegisterEvent("UNIT_ENTERED_VEHICLE")
		partypetupdate:RegisterEvent("UNIT_EXITED_VEHICLE")
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
					"maxColumns", 5,
					"unitsPerColumn", 1,
					"columnSpacing", T.Scale(7),
					"columnAnchorPoint", "TOP"
				)
				if i == 1 then
					raidgroup:Point(unpack(C.position.unitframes.raid_heal))
				else
					raidgroup:Point("TOPLEFT", raid[i-1], "TOPRIGHT", 7, 0)
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
					"point", "LEFT",
					"maxColumns", 5,
					"unitsPerColumn", 1,
					"columnSpacing", T.Scale(7),
					"columnAnchorPoint", "LEFT"
				)
				if i == 1 then
					raidgroup:Point(unpack(C.position.unitframes.raid_heal))
				else
					raidgroup:Point("TOPLEFT", raid[i-1], "BOTTOMLEFT", 0, -7)
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
					self:SetWidth(60.2)
					self:SetHeight(26)
				]]),
				"showRaid", true,
				"yOffset", T.Scale(-7),
				"groupFilter", "MAINTANK",
				"template", mt_template
			)
			raidtank:Point(unpack(C.position.unitframes.tank))
		end
	end
end)

----------------------------------------------------------------------------------------
--	Force a Clique option if not set(by Elv22)
----------------------------------------------------------------------------------------
if IsAddOnLoaded("Clique") then
	local CliquePath = CliqueDB3["char"][T.name.." - "..GetRealmName()]["downclick"]	
	StaticPopupDialogs["SETUP_CLIQUE"] = {
		text = L_POPUP_SETTINGS_CLIQUE,
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function() 
			CliqueDB3["char"][T.name.." - "..GetRealmName()]["downclick"] = true 
			ReloadUI() 
		end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = true,
	}
	local CliqueCheck = CreateFrame("Frame")
	CliqueCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
	CliqueCheck:SetScript("OnEvent", function()
		if CliquePath ~= true then
			StaticPopup_Show("SETUP_CLIQUE")
		end
	end)
end