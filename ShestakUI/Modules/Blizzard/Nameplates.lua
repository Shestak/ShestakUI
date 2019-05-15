local T, C, L, _ = unpack(select(2, ...))
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	oUF nameplates
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
if C.nameplate.combat == true then
	frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	frame:RegisterEvent("PLAYER_REGEN_DISABLED")

	function frame:PLAYER_REGEN_ENABLED()
		SetCVar("nameplateShowEnemies", 0)
	end

	function frame:PLAYER_REGEN_DISABLED()
		SetCVar("nameplateShowEnemies", 1)
	end
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
function frame:PLAYER_ENTERING_WORLD()
	if C.nameplate.combat == true then
		if InCombatLockdown() then
			SetCVar("nameplateShowEnemies", 1)
		else
			SetCVar("nameplateShowEnemies", 0)
		end
	end
	if not T.classic and C.nameplate.enhance_threat == true then
		SetCVar("threatWarning", 3)
	end
	SetCVar("namePlateMinScale", 1)
	SetCVar("namePlateMaxScale", 1)
	SetCVar("nameplateLargerScale", 1)
	SetCVar("nameplateSelectedScale", 1)
	SetCVar("nameplateMinAlpha", 1)
	SetCVar("nameplateMaxAlpha", 1)

	SetCVar("nameplateOtherTopInset", C.nameplate.clamp and 0.08 or -1)
	SetCVar("nameplateOtherBottomInset", C.nameplate.clamp and 0.1 or -1)
	SetCVar("nameplateMaxDistance", C.nameplate.distance or 40)
end

local healList, exClass, healerSpecs = {}, {}, {}
local testing = false

exClass.DEATHKNIGHT = true
exClass.MAGE = true
exClass.ROGUE = true
exClass.WARLOCK = true
exClass.WARRIOR = true
if C.nameplate.healer_icon == true then
	local t = CreateFrame("Frame")
	t.factions = {
		["Horde"] = 1,
		["Alliance"] = 0,
	}
	local healerSpecIDs = {
		105,	-- Druid Restoration
		270,	-- Monk Mistweaver
		65,		-- Paladin Holy
		256,	-- Priest Discipline
		257,	-- Priest Holy
		264,	-- Shaman Restoration
	}
	local healerClassTokens = {
		"DRUID",
		"PALADIN",
		"PRIEST",
		"SHAMAN",
	}
	if not T.classic then
		for _, specID in pairs(healerSpecIDs) do
			local _, name = GetSpecializationInfoByID(specID)
			if name and not healerSpecs[name] then
				healerSpecs[name] = true
			end
		end
	end

	local lastCheck = 20
	local function CheckHealers(self, elapsed)
		lastCheck = lastCheck + elapsed
		if lastCheck > 25 then
			lastCheck = 0
			healList = {}
			for i = 1, GetNumBattlefieldScores() do
				if not T.classic then
					local name, _, _, _, _, faction, _, _, _, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(i)

					if name and healerSpecs[talentSpec] and t.factions[UnitFactionGroup("player")] == faction then
						name = name:match("(.+)%-.+") or name
						healList[name] = talentSpec
					end
				else -- Temporary? Look into localized names for custom GetSpecializationInfoByID in Classic.
					local name, _, _, _, _, faction, _, _, classToken, damageDone, healingDone, _, _, _, _, talentSpec = GetBattlefieldScore(i)

					if name and healerClassTokens[classToken] and healingDone >= damageDone and t.factions[UnitFactionGroup("player")] == faction then
						name = name:match("(.+)%-.+") or name
						healList[name] = talentSpec
					end
				end
			end
		end
	end

	local function CheckArenaHealers(self, elapsed)
		lastCheck = lastCheck + elapsed
		if lastCheck > 25 then
			lastCheck = 0
			healList = {}
			for i = 1, 5 do
				local specID = GetArenaOpponentSpec(i)
				if specID and specID > 0 then
					local name = UnitName(format("arena%d", i))
					local _, talentSpec = GetSpecializationInfoByID(specID)
					if name and healerSpecs[talentSpec] then
						healList[name] = talentSpec
					end
				end
			end
		end
	end

	local function CheckLoc(self, event)
		if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_ENTERING_BATTLEGROUND" then
			local _, instanceType = IsInInstance()
			if instanceType == "pvp" then
				t:SetScript("OnUpdate", CheckHealers)
			elseif instanceType == "arena" then
				t:SetScript("OnUpdate", CheckArenaHealers)
			else
				healList = {}
				t:SetScript("OnUpdate", nil)
			end
		end
	end

	t:RegisterEvent("PLAYER_ENTERING_WORLD")
	t:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
	t:SetScript("OnEvent", CheckLoc)
end

local totemData = {}
if not T.classic then
	totemData = {
		-- Earth
		[GetSpellInfo(207399)] = "Interface\\Icons\\spell_nature_reincarnation",			-- Ancestral Protection Totem
		[GetSpellInfo(198838)] = "Interface\\Icons\\spell_nature_stoneskintotem",			-- Earthen Wall Totem
		[GetSpellInfo(51485)]  = "Interface\\Icons\\spell_nature_stranglevines",			-- Earthgrab Totem
		[GetSpellInfo(196932)] = "Interface\\Icons\\spell_totem_wardofdraining",			-- Voodoo Totem
		-- Fire
		[GetSpellInfo(192222)] = "Interface\\Icons\\spell_shaman_spewlava",					-- Liquid Magma Totem
		[GetSpellInfo(204330)] = "Interface\\Icons\\spell_fire_totemofwrath",				-- Skyfury Totem
		-- Water
		[GetSpellInfo(157153)] = "Interface\\Icons\\ability_shaman_condensationtotem",		-- Cloudburst Totem
		[GetSpellInfo(5394)]   = "Interface\\Icons\\INV_Spear_04",							-- Healing Stream Totem
		[GetSpellInfo(108280)] = "Interface\\Icons\\ability_shaman_healingtide",			-- Healing Tide Totem
		-- Air
		[GetSpellInfo(192058)] = "Interface\\Icons\\spell_nature_brilliance",				-- Capacitor Totem
		[GetSpellInfo(98008)]  = "Interface\\Icons\\spell_shaman_spiritlink",				-- Spirit Link Totem
		[GetSpellInfo(192077)] = "Interface\\Icons\\ability_shaman_windwalktotem",			-- Wind Rush Totem
		[GetSpellInfo(204331)] = "Interface\\Icons\\spell_nature_wrathofair_totem",			-- Counterstrike Totem
		[GetSpellInfo(204332)] = "Interface\\Icons\\spell_nature_windfury",					-- Windfury Totem
		[GetSpellInfo(204336)] = "Interface\\Icons\\spell_nature_groundingtotem",			-- Grounding Totem
		-- Totem Mastery
		[GetSpellInfo(202188)] = "Interface\\Icons\\spell_nature_stoneskintotem",			-- Resonance Totem
		[GetSpellInfo(210651)] = "Interface\\Icons\\spell_shaman_stormtotem",				-- Storm Totem
		[GetSpellInfo(210657)] = "Interface\\Icons\\spell_fire_searingtotem",				-- Ember Totem
		[GetSpellInfo(210660)] = "Interface\\Icons\\spell_nature_invisibilitytotem",		-- Tailwind Totem
	}
else
	totemData = {
		-- Earth
		[GetSpellInfo(2484)]   = "Interface\\Icons\\Spell_nature_strengthofearthtotem02",	-- Earthbind Totem
		[GetSpellInfo(5730)]   = "Interface\\Icons\\Spell_nature_stoneclawtotem",			-- Stoneclaw Totem
		[GetSpellInfo(8071)]   = "Interface\\Icons\\Spell_nature_stoneskintotem",			-- Stoneskin Totem
		[GetSpellInfo(8075)]   = "Interface\\Icons\\Spell_nature_earthbindtotem",			-- Strength of Earth Totem
		[GetSpellInfo(8143)]   = "Interface\\Icons\\Spell_nature_tremortotem",				-- Tremor Totem
		[GetSpellInfo(8177)]   = "Interface\\Icons\\Spell_nature_groundingtotem",			-- Grounding Totem
		-- Fire
		[GetSpellInfo(1535)]   = "Interface\\Icons\\Spell_fire_sealoffire",					-- Fire Nova Totem
		[GetSpellInfo(3599)]   = "Interface\\Icons\\Spell_fire_searingtotem",				-- Searing Totem
		[GetSpellInfo(8181)]   = "Interface\\Icons\\Spell_frostresistancetotem_01",			-- Frost Resistance Totem
		[GetSpellInfo(8190)]   = "Interface\\Icons\\Spell_fire_selfdestruct",				-- Magma Totem
		[GetSpellInfo(8227)]   = "Interface\\Icons\\Spell_nature_guardianward",				-- Flametongue Totem
		-- Water
		[GetSpellInfo(5394)]   = "Interface\\Icons\\Inv_spear_04",							-- Healing Stream Totem
		[GetSpellInfo(5675)]   = "Interface\\Icons\\Spell_nature_manaregentotem",			-- Mana Spring Totem
		[GetSpellInfo(8166)]   = "Interface\\Icons\\Spell_nature_poisoncleansingtotem",		-- Poison Cleansing Totem
		[GetSpellInfo(8170)]   = "Interface\\Icons\\Spell_nature_diseasecleansingtotem",	-- Disease Cleansing Totem
		[GetSpellInfo(8184)]   = "Interface\\Icons\\Spell_fireresistancetotem_01",			-- Fire Resistance Totem
		[GetSpellInfo(16190)]  = "Interface\\Icons\\Spell_frost_summonwaterelemental",		-- Mana Tide Totem
		-- Air
		[GetSpellInfo(6495)]   = "Interface\\Icons\\Spell_nature_removecurse",				-- Sentry Totem
		[GetSpellInfo(8512)]   = "Interface\\Icons\\Spell_nature_windfury",					-- Windfury Totem
		[GetSpellInfo(8835)]   = "Interface\\Icons\\Spell_nature_invisibilitytotem",		-- Grace of Air Totem
		[GetSpellInfo(10595)]  = "Interface\\Icons\\Spell_nature_natureresistancetotem",	-- Nature Resistance Totem
		[GetSpellInfo(15107)]  = "Interface\\Icons\\Spell_nature_earthbind",				-- Windwall Totem
		[GetSpellInfo(25908)]  = "Interface\\Icons\\Spell_nature_brilliance",				-- Tranquil Air Totem
	}
end

local function CreateVirtualFrame(frame, point)
	if point == nil then point = frame end
	if point.backdrop then return end

	frame.backdrop = frame:CreateTexture(nil, "BORDER")
	frame.backdrop:SetDrawLayer("BORDER", -8)
	frame.backdrop:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 3, T.noscalemult * 3)
	frame.backdrop:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", T.noscalemult * 3, -T.noscalemult * 3)
	frame.backdrop:SetColorTexture(unpack(C.media.backdrop_color))

	frame.bordertop = frame:CreateTexture(nil, "BORDER")
	frame.bordertop:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 2, T.noscalemult * 2)
	frame.bordertop:SetPoint("TOPRIGHT", point, "TOPRIGHT", T.noscalemult * 2, T.noscalemult * 2)
	frame.bordertop:SetHeight(T.noscalemult)
	frame.bordertop:SetColorTexture(unpack(C.media.border_color))
	frame.bordertop:SetDrawLayer("BORDER", -7)

	frame.borderbottom = frame:CreateTexture(nil, "BORDER")
	frame.borderbottom:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", -T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderbottom:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderbottom:SetHeight(T.noscalemult)
	frame.borderbottom:SetColorTexture(unpack(C.media.border_color))
	frame.borderbottom:SetDrawLayer("BORDER", -7)

	frame.borderleft = frame:CreateTexture(nil, "BORDER")
	frame.borderleft:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 2, T.noscalemult * 2)
	frame.borderleft:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderleft:SetWidth(T.noscalemult)
	frame.borderleft:SetColorTexture(unpack(C.media.border_color))
	frame.borderleft:SetDrawLayer("BORDER", -7)

	frame.borderright = frame:CreateTexture(nil, "BORDER")
	frame.borderright:SetPoint("TOPRIGHT", point, "TOPRIGHT", T.noscalemult * 2, T.noscalemult * 2)
	frame.borderright:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", -T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderright:SetWidth(T.noscalemult)
	frame.borderright:SetColorTexture(unpack(C.media.border_color))
	frame.borderright:SetDrawLayer("BORDER", -7)
end

local function SetVirtualBorder(frame, r, g, b)
	frame.bordertop:SetColorTexture(r, g, b)
	frame.borderbottom:SetColorTexture(r, g, b)
	frame.borderleft:SetColorTexture(r, g, b)
	frame.borderright:SetColorTexture(r, g, b)
end

local FormatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", floor(s / day + 0.5)), s % day
	elseif s >= hour then
		return format("%dh", floor(s / hour + 0.5)), s % hour
	elseif s >= minute then
		return format("%dm", floor(s / minute + 0.5)), s % minute
	elseif s >= minute / 12 then
		return floor(s + 0.5), (s * 100 - floor(s * 100)) / 100
	end
	return format("%.1f", s), (s * 100 - floor(s * 100)) / 100
end

local CreateAuraTimer = function(self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.1 then
			if not self.first then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if self.timeLeft > 0 then
				local time = FormatTime(self.timeLeft)
				self.remaining:SetText(time)
				self.remaining:SetTextColor(1, 1, 1)
			else
				self.remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end

local function threatColor(self, forced)
	if UnitIsPlayer(self.unit) then return end
	local combat = UnitAffectingCombat("player")
	local _, threatStatus = UnitDetailedThreatSituation("player", self.unit)

	if C.nameplate.enhance_threat ~= true then
		SetVirtualBorder(self.Health, unpack(C.media.border_color))
	end
	if UnitIsTapDenied(self.unit) then
		self.Health:SetStatusBarColor(0.6, 0.6, 0.6)
	elseif combat then
		if threatStatus == 3 then	-- securely tanking, highest threat
			if T.Role == "Tank" then
				if C.nameplate.enhance_threat == true then
					self.Health:SetStatusBarColor(unpack(C.nameplate.good_color))
				else
					SetVirtualBorder(self.Health, unpack(C.nameplate.bad_color))
				end
			else
				if C.nameplate.enhance_threat == true then
					self.Health:SetStatusBarColor(unpack(C.nameplate.bad_color))
				else
					SetVirtualBorder(self.Health, unpack(C.nameplate.bad_color))
				end
			end
		elseif threatStatus == 2 then	-- insecurely tanking, another unit have higher threat but not tanking
			if C.nameplate.enhance_threat == true then
				self.Health:SetStatusBarColor(unpack(C.nameplate.near_color))
			else
				SetVirtualBorder(self.Health, unpack(C.nameplate.near_color))
			end
		elseif threatStatus == 1 then	-- not tanking, higher threat than tank
			if C.nameplate.enhance_threat == true then
				self.Health:SetStatusBarColor(unpack(C.nameplate.near_color))
			else
				SetVirtualBorder(self.Health, unpack(C.nameplate.near_color))
			end
		elseif threatStatus == 0 then	-- not tanking, lower threat than tank
			if C.nameplate.enhance_threat == true then
				if T.Role == "Tank" then
					self.Health:SetStatusBarColor(unpack(C.nameplate.bad_color))
					if IsInGroup() or IsInRaid() then
						for i = 1, GetNumGroupMembers() do
							if UnitExists("raid"..i) and not UnitIsUnit("raid"..i, "player") then
								local isTanking = UnitDetailedThreatSituation("raid"..i, self.unit)
								if isTanking and UnitGroupRolesAssigned("raid"..i) == "TANK" then
									self.Health:SetStatusBarColor(unpack(C.nameplate.offtank_color))
								end
							end
						end
					end
				else
					self.Health:SetStatusBarColor(unpack(C.nameplate.good_color))
				end
			end
		end
	elseif not forced then
		self.Health:ForceUpdate()
	end
end

local function UpdateTarget(self)
	if UnitIsUnit(self.unit, "target") and not UnitIsUnit(self.unit, "player") then
		self:SetSize((C.nameplate.width + C.nameplate.ad_width) * T.noscalemult, (C.nameplate.height + C.nameplate.ad_height) * T.noscalemult)
		self.Castbar:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, -8-((C.nameplate.height + C.nameplate.ad_height) * T.noscalemult))
		self.Castbar.Icon:SetSize(((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8, ((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8)
		if C.nameplate.class_icons == true then
			self.Class.Icon:SetSize(((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8, ((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8)
		end
		self:SetAlpha(1)
	else
		self:SetSize(C.nameplate.width * T.noscalemult, C.nameplate.height * T.noscalemult)
		self.Castbar:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, -8-(C.nameplate.height * T.noscalemult))
		self.Castbar.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
		if C.nameplate.class_icons == true then
			self.Class.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
		end
		if UnitExists("target") and not UnitIsUnit(self.unit, "player") then
			self:SetAlpha(0.5)
		else
			self:SetAlpha(1)
		end
	end
end

local function UpdateName(self)
	if C.nameplate.healer_icon == true then
		local name = UnitName(self.unit)
		if name then
			if testing then
				self.HPHeal:Show()
			else
				if healList[name] then
					if exClass[healList[name]] then
						self.HPHeal:Hide()
					else
						self.HPHeal:Show()
					end
				else
					self.HPHeal:Hide()
				end
			end
		end
	end

	if C.nameplate.class_icons == true then
		local reaction = UnitReaction(self.unit, "player")
		if UnitIsPlayer(self.unit) and (reaction and reaction <= 4) then
			local _, class = UnitClass(self.unit)
			local texcoord = CLASS_ICON_TCOORDS[class]
			self.Class.Icon:SetTexCoord(texcoord[1] + 0.015, texcoord[2] - 0.02, texcoord[3] + 0.018, texcoord[4] - 0.02)
			self.Class:Show()
			self.Level:SetPoint("RIGHT", self.Name, "LEFT", -2, 0)
		else
			self.Class.Icon:SetTexCoord(0, 0, 0, 0)
			self.Class:Hide()
			self.Level:SetPoint("RIGHT", self.Health, "LEFT", -2, 0)
		end
	end

	if C.nameplate.totem_icons == true then
		local name = UnitName(self.unit)
		if name then
			if totemData[name] then
				self.Totem.Icon:SetTexture(totemData[name])
				self.Totem.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				self.Totem:Show()
			else
				self.Totem:Hide()
			end
		end
	end
end

local function castColor(self)
	if self.notInterruptible then
		self:SetStatusBarColor(0.78, 0.25, 0.25)
		self.bg:SetColorTexture(0.78, 0.25, 0.25, 0.2)
	else
		self:SetStatusBarColor(1, 0.8, 0)
		self.bg:SetColorTexture(1, 0.8, 0, 0.2)
	end
end

local function callback(self, event, unit)
	if not self then return end
	if unit then
		local name = UnitName(unit)
		if name and T.PlateBlacklist[name] then
			self:Hide()
		else
			self:Show()
		end

		if UnitIsUnit(unit, "player") then
			self.Power:Show()
			self.Name:Hide()
			self.Castbar:SetAlpha(0)
			self.RaidTargetIndicator:SetAlpha(0)
		else
			self.Power:Hide()
			self.Name:Show()
			self.Castbar:SetAlpha(1)
			self.RaidTargetIndicator:SetAlpha(1)
		end
	end
end

local function style(self, unit)
	local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
	local main = self
	self.unit = unit

	self:SetPoint("CENTER", nameplate, "CENTER")
	self:SetSize(C.nameplate.width * T.noscalemult, C.nameplate.height * T.noscalemult)

	-- Health Bar
	self.Health = CreateFrame("StatusBar", nil, self)
	self.Health:SetAllPoints(self)
	self.Health:SetStatusBarTexture(C.media.texture)
	self.Health.frequentUpdates = true
	self.Health.colorTapping = true
	self.Health.colorDisconnected = true
	self.Health.colorClass = true
	self.Health.colorReaction = true
	self.Health.colorHealth = true
	CreateVirtualFrame(self.Health)

	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints()
	self.Health.bg:SetTexture(C.media.texture)
	self.Health.bg.multiplier = 0.2

	-- Create Health Text
	if C.nameplate.health_value == true then
		self.Health.value = self.Health:CreateFontString(nil, "OVERLAY")
		self.Health.value:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		self.Health.value:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
		self:Tag(self.Health.value, "[NameplateHealth]")
	end

	-- Create Player Power bar
	self.Power = CreateFrame("StatusBar", nil, self)
	self.Power:SetStatusBarTexture(C.media.texture)
	self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -6)
	self.Power:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", 0, -6-(C.nameplate.height * T.noscalemult / 2))
	self.Power.frequentUpdates = true
	self.Power.colorPower = true
	self.Power.PostUpdate = T.PreUpdatePower
	CreateVirtualFrame(self.Power)

	self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
	self.Power.bg:SetAllPoints()
	self.Power.bg:SetTexture(C.media.texture)
	self.Power.bg.multiplier = 0.2

	-- Hide Blizzard Power Bar and changed position for Class Bar
	if not T.classic then
		hooksecurefunc(_G.NamePlateDriverFrame, "SetupClassNameplateBars", function(frame)
			if frame.classNamePlateMechanicFrame then
				local point, _, relativePoint, xOfs = frame.classNamePlateMechanicFrame:GetPoint()
				if point then
					if point == "TOP" and C_NamePlate.GetNamePlateForUnit("player") then
						frame.classNamePlateMechanicFrame:SetPoint(point, C_NamePlate.GetNamePlateForUnit("player"), relativePoint, xOfs, 53)
					else
						frame.classNamePlateMechanicFrame:SetPoint(point, C_NamePlate.GetNamePlateForUnit("target"), relativePoint, xOfs, -5)
					end
				end
			end
			if frame.classNamePlatePowerBar then
				frame.classNamePlatePowerBar:Hide()
				frame.classNamePlatePowerBar:UnregisterAllEvents()
			end
		end)
	end

	-- Create Name Text
	self.Name = self:CreateFontString(nil, "OVERLAY")
	self.Name:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	self.Name:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	self.Name:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -3, 4)
	self.Name:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 3, 4)

	if C.nameplate.name_abbrev == true then
		self:Tag(self.Name, "[NameplateNameColor][NameLongAbbrev]")
	else
		self:Tag(self.Name, "[NameplateNameColor][NameLong]")
	end

	-- Create Level
	self.Level = self:CreateFontString(nil, "OVERLAY")
	self.Level:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	self.Level:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	self.Level:SetPoint("RIGHT", self.Health, "LEFT", -2, 0)
	self:Tag(self.Level, "[DiffColor][NameplateLevel][shortclassification]")

	-- Create Cast Bar
	self.Castbar = CreateFrame("StatusBar", nil, self)
	self.Castbar:SetFrameLevel(3)
	self.Castbar:SetStatusBarTexture(C.media.texture)
	self.Castbar:SetStatusBarColor(1, 0.8, 0)
	self.Castbar:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -8)
	self.Castbar:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", 0, -8-(C.nameplate.height * T.noscalemult))
	CreateVirtualFrame(self.Castbar)

	self.Castbar.bg = self.Castbar:CreateTexture(nil, "BORDER")
	self.Castbar.bg:SetAllPoints()
	self.Castbar.bg:SetTexture(C.media.texture)
	self.Castbar.bg:SetColorTexture(1, 0.8, 0, 0.2)

	self.Castbar.PostCastStart = castColor
	self.Castbar.PostChannelStart = castColor
	self.Castbar.PostCastNotInterruptible = castColor
	self.Castbar.PostCastInterruptible = castColor

	-- Create Cast Time Text
	self.Castbar.Time = self.Castbar:CreateFontString(nil, "ARTWORK")
	self.Castbar.Time:SetPoint("RIGHT", self.Castbar, "RIGHT", 0, 0)
	self.Castbar.Time:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	self.Castbar.Time:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)

	self.Castbar.CustomTimeText = function(self, duration)
		self.Time:SetText(("%.1f"):format(self.channeling and duration or self.max - duration))
	end

	-- Create Cast Name Text
	if C.nameplate.show_castbar_name == true then
		self.Castbar.Text = self.Castbar:CreateFontString(nil, "OVERLAY")
		self.Castbar.Text:SetPoint("LEFT", self.Castbar, "LEFT", 3, 0)
		self.Castbar.Text:SetPoint("RIGHT", self.Castbar.Time, "LEFT", -1, 0)
		self.Castbar.Text:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		self.Castbar.Text:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		self.Castbar.Text:SetHeight(C.font.nameplates_font_size)
		self.Castbar.Text:SetJustifyH("LEFT")
	end

	-- Create CastBar Icon
	self.Castbar.Icon = self.Castbar:CreateTexture(nil, "OVERLAY")
	self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	self.Castbar.Icon:SetDrawLayer("ARTWORK")
	self.Castbar.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
	self.Castbar.Icon:SetPoint("TOPLEFT", self.Health, "TOPRIGHT", 8, 0)
	CreateVirtualFrame(self.Castbar, self.Castbar.Icon)

	-- Raid Icon
	self.RaidTargetIndicator = self:CreateTexture(nil, "OVERLAY", nil, 7)
	self.RaidTargetIndicator:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
	self.RaidTargetIndicator:SetPoint("BOTTOM", self.Health, "TOP", 0, C.nameplate.track_debuffs == true and 38 or 16)

	-- Create Class Icon
	if C.nameplate.class_icons == true then
		self.Class = CreateFrame("Frame", nil, self)
		self.Class.Icon = self.Class:CreateTexture(nil, "OVERLAY")
		self.Class.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
		self.Class.Icon:SetPoint("TOPRIGHT", self.Health, "TOPLEFT", -8, 0)
		self.Class.Icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
		self.Class.Icon:SetTexCoord(0, 0, 0, 0)
		CreateVirtualFrame(self.Class, self.Class.Icon)
	end

	-- Create Totem Icon
	if C.nameplate.totem_icons == true then
		self.Totem = CreateFrame("Frame", nil, self)
		self.Totem.Icon = self.Totem:CreateTexture(nil, "OVERLAY")
		self.Totem.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
		self.Totem.Icon:SetPoint("BOTTOM", self.Health, "TOP", 0, 16)
		CreateVirtualFrame(self.Totem, self.Totem.Icon)
	end

	-- Create Healer Icon
	if C.nameplate.healer_icon == true then
		self.HPHeal = self.Health:CreateFontString(nil, "OVERLAY")
		self.HPHeal:SetFont(C.font.nameplates_font, 32, C.font.nameplates_font_style)
		self.HPHeal:SetText("|cFFD53333+|r")
		self.HPHeal:SetPoint("BOTTOM", self.Name, "TOP", 0, C.nameplate.track_debuffs == true and 13 or 0)
	end

	-- Aura tracking
	if C.nameplate.track_debuffs == true or C.nameplate.track_buffs == true then
		self.Auras = CreateFrame("Frame", nil, self)
		self.Auras:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", 0, C.font.nameplates_font_size + 7)
		self.Auras.initialAnchor = "BOTTOMRIGHT"
		self.Auras["growth-y"] = "UP"
		self.Auras["growth-x"] = "LEFT"
		self.Auras.numDebuffs = C.nameplate.track_debuffs and 6 or 0
		self.Auras.numBuffs = C.nameplate.track_buffs and 4 or 0
		self.Auras:SetSize(20 + C.nameplate.width, C.nameplate.auras_size)
		self.Auras.spacing = 5 * T.noscalemult
		self.Auras.size = C.nameplate.auras_size * T.noscalemult - 3

		self.Auras.CustomFilter = function(_, unit, _, name, _, _, _, _, _, caster, _, nameplateShowSelf, _, _, _, _, nameplateShowAll)
			local allow = false

			if caster == "player" then
				if UnitIsUnit(unit, "player") then
					if ((nameplateShowAll or nameplateShowSelf) and not T.BuffBlackList[name]) then
						allow = true
					elseif T.BuffWhiteList[name] then
						allow = true
					end
				else
					if ((nameplateShowAll or nameplateShowSelf) and not T.DebuffBlackList[name]) then
						allow = true
					elseif T.DebuffWhiteList[name] then
						allow = true
					end
				end
			end

			return allow
		end

		self.Auras.PostCreateIcon = function(element, button)
			CreateVirtualFrame(button)
			button:EnableMouse(false)

			button.remaining = T.SetFontString(button, C.font.auras_font, C.font.auras_font_size * T.noscalemult, C.font.auras_font_style)
			button.remaining:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
			button.remaining:SetPoint("CENTER", button, "CENTER", 1, 0)
			button.remaining:SetJustifyH("CENTER")

			button.cd.noCooldownCount = true

			button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			button.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, 0)
			button.count:SetJustifyH("RIGHT")
			button.count:SetFont(C.font.auras_font, C.font.auras_font_size * T.noscalemult, C.font.auras_font_style)
			button.count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

			if C.aura.show_spiral == true then
				element.disableCooldown = false
				button.cd:SetReverse(true)
				button.parent = CreateFrame("Frame", nil, button)
				button.parent:SetFrameLevel(button.cd:GetFrameLevel() + 1)
				button.count:SetParent(button.parent)
				button.remaining:SetParent(button.parent)
			else
				element.disableCooldown = true
			end
		end

		self.Auras.PostUpdateIcon = function(_, _, icon, _, _, duration, expiration)
			if duration and duration > 0 and C.aura.show_timer == true then
				icon.remaining:Show()
				icon.timeLeft = expiration
				icon:SetScript("OnUpdate", CreateAuraTimer)
			else
				icon.remaining:Hide()
				icon.timeLeft = math.huge
				icon:SetScript("OnUpdate", nil)
			end
			icon.first = true
		end
	end

	self.Health:RegisterEvent("PLAYER_REGEN_DISABLED")
	self.Health:RegisterEvent("PLAYER_REGEN_ENABLED")
	if not T.classic then
		self.Health:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
		self.Health:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
	end

	self.Health:SetScript("OnEvent", function(self, event)
		threatColor(main)
	end)

	self.Health.PostUpdate = function(self, unit, min, max)
		local perc = 0
		if max and max > 0 then
			perc = min / max
		end

		local r, g, b
		local mu = self.bg.multiplier
		local unitReaction = UnitReaction(unit, "player")
		if not UnitIsUnit("player", unit) and UnitIsPlayer(unit) and (unitReaction and unitReaction >= 5) then
			r, g, b = unpack(T.oUF_colors.power["MANA"])
			self:SetStatusBarColor(r, g, b)
			self.bg:SetVertexColor(r * mu, g * mu, b * mu)
		elseif not UnitIsTapDenied(unit) and not UnitIsPlayer(unit) then
			local reaction = T.oUF_colors.reaction[unitReaction]
			if reaction then
				r, g, b = reaction[1], reaction[2], reaction[3]
			else
				r, g, b = UnitSelectionColor(unit, true)
			end

			self:SetStatusBarColor(r, g, b)
			self.bg:SetVertexColor(r * mu, g * mu, b * mu)
		end

		if UnitIsPlayer(unit) then
			if perc <= 0.5 and perc >= 0.2 then
				SetVirtualBorder(self, 1, 1, 0)
			elseif perc < 0.2 then
				SetVirtualBorder(self, 1, 0, 0)
			else
				SetVirtualBorder(self, unpack(C.media.border_color))
			end
		elseif not UnitIsPlayer(unit) and C.nameplate.enhance_threat == true then
			SetVirtualBorder(self, unpack(C.media.border_color))
		end

		threatColor(main, true)
	end

	-- Every event should be register with this
	table.insert(self.__elements, UpdateName)
	self:RegisterEvent("UNIT_NAME_UPDATE", UpdateName)

	table.insert(self.__elements, UpdateTarget)
	self:RegisterEvent("PLAYER_TARGET_CHANGED", UpdateTarget, true)

	-- Disable movement via /moveui
	self.disableMovement = true
end

oUF:RegisterStyle("ShestakNameplates", style)
oUF:SetActiveStyle("ShestakNameplates")
oUF:SpawnNamePlates("ShestakNameplates", callback)
