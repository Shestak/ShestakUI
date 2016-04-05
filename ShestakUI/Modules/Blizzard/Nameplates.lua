local T, C, L, _ = unpack(select(2, ...))
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on rNamePlates(by zork, editor Tukz)
----------------------------------------------------------------------------------------
local Plates = CreateFrame("Frame", nil, WorldFrame)
local goodR, goodG, goodB = unpack(C.nameplate.good_color)
local badR, badG, badB = unpack(C.nameplate.bad_color)
local transitionR, transitionG, transitionB = unpack(C.nameplate.near_color)

local NamePlates = CreateFrame("Frame", nil, UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
if C.nameplate.track_auras == true then
	NamePlates:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

local healList, exClass = {}, {}
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
	t.healers = {
		[L_PLANNER_DRUID_4] = true,
		[L_PLANNER_MONK_2] = true,
		[L_PLANNER_PALADIN_1] = true,
		[L_PLANNER_PRIEST_1] = true,
	}

	local lastCheck = 20
	local function CheckHealers(self, elapsed)
		lastCheck = lastCheck + elapsed
		if lastCheck > 25 then
			lastCheck = 0
			healList = {}
			for i = 1, GetNumBattlefieldScores() do
				local name, _, _, _, _, faction, _, _, _, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(i)
				name = name:match("(.+)%-.+") or name
				if name and t.healers[talentSpec] and t.factions[UnitFactionGroup("player")] == faction then
					healList[name] = talentSpec
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
					local name = UnitName(format('arena%d', i))
					local _, talentSpec = GetSpecializationInfoByID(specID)
					if name and t.healers[talentSpec] then
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

local function Abbrev(name)
	local newname = (string.len(name) > 18) and string.gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name
	return T.UTF(newname, 18, false)
end

local function CreateVirtualFrame(frame, point)
	if point == nil then point = frame end
	if point.backdrop then return end

	frame.backdrop = frame:CreateTexture(nil, "BORDER")
	frame.backdrop:SetDrawLayer("BORDER", -8)
	frame.backdrop:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 3, T.noscalemult * 3)
	frame.backdrop:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", T.noscalemult * 3, -T.noscalemult * 3)
	frame.backdrop:SetTexture(unpack(C.media.backdrop_color))

	frame.bordertop = frame:CreateTexture(nil, "BORDER")
	frame.bordertop:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 2, T.noscalemult * 2)
	frame.bordertop:SetPoint("TOPRIGHT", point, "TOPRIGHT", T.noscalemult * 2, T.noscalemult * 2)
	frame.bordertop:SetHeight(T.noscalemult)
	frame.bordertop:SetTexture(unpack(C.media.border_color))
	frame.bordertop:SetDrawLayer("BORDER", -7)

	frame.borderbottom = frame:CreateTexture(nil, "BORDER")
	frame.borderbottom:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", -T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderbottom:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderbottom:SetHeight(T.noscalemult)
	frame.borderbottom:SetTexture(unpack(C.media.border_color))
	frame.borderbottom:SetDrawLayer("BORDER", -7)

	frame.borderleft = frame:CreateTexture(nil, "BORDER")
	frame.borderleft:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 2, T.noscalemult * 2)
	frame.borderleft:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderleft:SetWidth(T.noscalemult)
	frame.borderleft:SetTexture(unpack(C.media.border_color))
	frame.borderleft:SetDrawLayer("BORDER", -7)

	frame.borderright = frame:CreateTexture(nil, "BORDER")
	frame.borderright:SetPoint("TOPRIGHT", point, "TOPRIGHT", T.noscalemult * 2, T.noscalemult * 2)
	frame.borderright:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", -T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderright:SetWidth(T.noscalemult)
	frame.borderright:SetTexture(unpack(C.media.border_color))
	frame.borderright:SetDrawLayer("BORDER", -7)
end

local function SetVirtualBorder(frame, r, g, b)
	frame.bordertop:SetTexture(r, g, b)
	frame.borderbottom:SetTexture(r, g, b)
	frame.borderleft:SetTexture(r, g, b)
	frame.borderright:SetTexture(r, g, b)
end

function Plates:CreateAuraIcon(self)
	local button = CreateFrame("Frame", nil, self.Health)
	button:SetWidth(C.nameplate.auras_size)
	button:SetHeight(C.nameplate.auras_size)

	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetTexture(unpack(C.media.backdrop_color))
	button.bg:SetAllPoints(button)

	button.bord = button:CreateTexture(nil, "BORDER")
	button.bord:SetTexture(unpack(C.media.border_color))
	button.bord:SetPoint("TOPLEFT", button, "TOPLEFT", T.noscalemult, -T.noscalemult)
	button.bord:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -T.noscalemult, T.noscalemult)

	button.bg2 = button:CreateTexture(nil, "ARTWORK")
	button.bg2:SetTexture(unpack(C.media.backdrop_color))
	button.bg2:SetPoint("TOPLEFT", button, "TOPLEFT", T.noscalemult * 2, -T.noscalemult * 2)
	button.bg2:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -T.noscalemult * 2, T.noscalemult * 2)

	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", T.noscalemult * 3, -T.noscalemult * 3)
	button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -T.noscalemult * 3, T.noscalemult * 3)
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.cd = CreateFrame("Cooldown", nil, button)
	button.cd:SetAllPoints(button)
	button.cd:SetReverse(true)

	button.count = button:CreateFontString(nil, "OVERLAY")
	button.count:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	button.count:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	button.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)

	return button
end

local function UpdateAuraIcon(button, unit, index, filter)
	local _, _, icon, count, _, duration, expirationTime, _, _, _, spellID = UnitAura(unit, index, filter)

	button.icon:SetTexture(icon)
	button.cd:SetCooldown(expirationTime - duration, duration)
	button.expirationTime = expirationTime
	button.duration = duration
	button.spellID = spellID
	if count > 1 then
		button.count:SetText(count)
	else
		button.count:SetText("")
	end
	button.cd:SetScript("OnUpdate", function(self)
		if not button.cd.timer then
			self:SetScript("OnUpdate", nil)
			return
		end
		button.cd.timer.text:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		button.cd.timer.text:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	end)
	button:Show()
end

function Plates:OnAura(unit)
	if not self:IsShown() then
		return
	end
	if not C.nameplate.track_auras or not self.NewPlate.icons or not self.NewPlate.unit then return end
	local i = 1
	for index = 1, 40 do
		if i > C.nameplate.width / C.nameplate.auras_size then return end
		local match
		local name, _, _, _, _, duration, _, caster, _, _ = UnitAura(unit, index, "HARMFUL")

		if T.DebuffWhiteList[name] and caster == "player" then match = true end

		if duration and match == true then
			if not self.NewPlate.icons[i] then self.NewPlate.icons[i] = Plates:CreateAuraIcon(self.NewPlate) end
			local icon = self.NewPlate.icons[i]
			if i == 1 then icon:SetPoint("RIGHT", self.NewPlate.icons, "RIGHT") end
			if i ~= 1 and i <= C.nameplate.width / C.nameplate.auras_size then icon:SetPoint("RIGHT", self.NewPlate.icons[i-1], "LEFT", -2, 0) end
			i = i + 1
			UpdateAuraIcon(icon, unit, index, "HARMFUL")
		end
	end
	for index = i, #self.NewPlate.icons do self.NewPlate.icons[index]:Hide() end
end

function Plates:GetColor()
	local Red, Green, Blue = self.ArtContainer.HealthBar:GetStatusBarColor()
	local texcoord = {0, 0, 0, 0}
	self.isClass = false

	for class, _ in pairs(RAID_CLASS_COLORS) do
		Red, Green, Blue = floor(Red * 100 + 0.5) / 100, floor(Green * 100 + 0.5) / 100, floor(Blue * 100 + 0.5) / 100
		local AltBlue = Blue

		if class == "MONK" then
			AltBlue = AltBlue - 0.01
		end

		if RAID_CLASS_COLORS[class].r == Red and RAID_CLASS_COLORS[class].g == Green and RAID_CLASS_COLORS[class].b == AltBlue then
			self.isClass = true
			self.isFriendly = false
			if C.nameplate.class_icons == true then
				texcoord = CLASS_BUTTONS[class]
				self.NewPlate.class.Glow:Show()
				self.NewPlate.class:SetTexCoord(texcoord[1], texcoord[2], texcoord[3], texcoord[4])
			end
			Red, Green, Blue = unpack(T.oUF_colors.class[class])
			return Red, Green, Blue
		end
	end

	self.isTapped = false

	if (Red + Blue + Blue) == 1.59 then			-- Tapped
		Red, Green, Blue = 0.6, 0.6, 0.6
		self.isFriendly = false
		self.isTapped = true
	elseif Green + Blue == 0 then				-- Hostile
		Red, Green, Blue = unpack(T.oUF_colors.reaction[1])
		self.isFriendly = false
	elseif Red + Blue == 0 then					-- Friendly NPC
		Red, Green, Blue = unpack(T.oUF_colors.power["MANA"])
		self.isFriendly = true
	elseif Red + Green > 1.95 then				-- Neutral NPC
		Red, Green, Blue = unpack(T.oUF_colors.reaction[4])
		self.isFriendly = false
	elseif Red + Green == 0 then				-- Friendly Player
		Red, Green, Blue = unpack(T.oUF_colors.reaction[5])
		self.isFriendly = true
	else
		self.isFriendly = false
	end

	if C.nameplate.class_icons == true then
		if self.isClass == true then
			self.NewPlate.class.Glow:Show()
		else
			self.NewPlate.class.Glow:Hide()
		end
		self.NewPlate.class:SetTexCoord(texcoord[1], texcoord[2], texcoord[3], texcoord[4])
	end

	return Red, Green, Blue
end

function Plates:UpdateCastBar()
	local Red, Blue, Green = self.ArtContainer.CastBar:GetStatusBarColor()
	local Minimum, Maximum = self.ArtContainer.CastBar:GetMinMaxValues()
	local Current = self.ArtContainer.CastBar:GetValue()
	local Shield = self.ArtContainer.CastBarFrameShield

	if Shield:IsShown() then
		self.NewPlate.CastBar:SetStatusBarColor(0.78, 0.25, 0.25)
		self.NewPlate.CastBar.Background:SetTexture(0.78, 0.25, 0.25, 0.2)
	else
		self.NewPlate.CastBar:SetStatusBarColor(Red, Blue, Green)
		self.NewPlate.CastBar.Background:SetTexture(0.75, 0.75, 0.25, 0.2)
	end

	self.NewPlate.CastBar:SetMinMaxValues(Minimum, Maximum)
	self.NewPlate.CastBar:SetValue(Current)

	local last = self.NewPlate.CastBar.last and self.NewPlate.CastBar.last or 0
	local finish = (Current > last) and (Maximum - Current) or Current

	self.NewPlate.CastBar.Time:SetFormattedText("%.1f ", finish)
	self.NewPlate.CastBar.last = Current
end

function Plates:CastOnShow()
	self.NewPlate.CastBar.Icon:SetTexture(self.ArtContainer.CastBarSpellIcon:GetTexture())
	if C.nameplate.show_castbar_name == true then
		self.NewPlate.CastBar.Name:SetText(self.ArtContainer.CastBarText:GetText())
	end
	self.NewPlate.CastBar:Show()
end

function Plates:CastOnHide()
	self.NewPlate.CastBar:Hide()
end

function Plates:OnShow()
	self.NewPlate:Show()
	Plates.UpdateHealth(self)

	local object = {
		self.ArtContainer.HealthBar,
		self.ArtContainer.Border,
		self.ArtContainer.Highlight,
		self.ArtContainer.LevelText,
		self.ArtContainer.EliteIcon,
		self.ArtContainer.AggroWarningTexture,
		self.ArtContainer.HighLevelIcon,
		self.ArtContainer.CastBar,
		self.ArtContainer.CastBarBorder,
		self.ArtContainer.CastBarFrameShield,
		self.ArtContainer.CastBarText,
		self.ArtContainer.CastBarTextBG,
		self.NameContainer.NameText
	}

	for _, object in pairs(object) do
		objectType = object:GetObjectType()
		if objectType == "Texture" then
			object:SetTexture("")
		elseif objectType == "FontString" then
			object:SetWidth(0.001)
		elseif objectType == "StatusBar" then
			object:SetStatusBarTexture("")
		end
		if object ~= self.ArtContainer.HighLevelIcon and object ~= self.ArtContainer.EliteIcon then
			object:Hide()
		end
	end

	local Name = self.NameContainer.NameText:GetText() or "Unknown"
	local Level = self.ArtContainer.LevelText:GetText() or ""
	local Boss, Elite = self.ArtContainer.HighLevelIcon, self.ArtContainer.EliteIcon

	self.NewPlate.level:SetTextColor(self.ArtContainer.LevelText:GetTextColor())
	if Boss:IsShown() then
		Level = "??"
		self.NewPlate.level:SetTextColor(0.8, 0.05, 0)
	elseif Elite:IsShown() then
		Level = Level.."+"
	end

	if C.nameplate.name_abbrev == true and C.nameplate.track_auras ~= true then
		self.NewPlate.Name:SetText(Abbrev(Name))
	else
		self.NewPlate.Name:SetText(Name)
	end

	if tonumber(Level) == T.level and not Elite:IsShown() then
		self.NewPlate.level:SetText("")
	else
		self.NewPlate.level:SetText(Level)
	end

	if C.nameplate.class_icons == true and self.isClass == true then
		self.NewPlate.level:SetPoint("RIGHT", self.NewPlate.Name, "LEFT", -2, 0)
	else
		self.NewPlate.level:SetPoint("RIGHT", self.NewPlate.Health, "LEFT", -2, 0)
	end

	if C.nameplate.healer_icon == true then
		local name = self.NewPlate.Name:GetText()
		name = gsub(name, "%s*"..((_G.FOREIGN_SERVER_LABEL:gsub("^%s", "")):gsub("[%*()]", "%%%1")).."$", "")
		name = gsub(name, "%s*"..((_G.INTERACTIVE_SERVER_LABEL:gsub("^%s", "")):gsub("[%*()]", "%%%1")).."$", "")
		if testing then
			self.NewPlate.HPHeal:Show()
		else
			if healList[name] then
				if exClass[healList[name]] then
					self.NewPlate.HPHeal:Hide()
				else
					self.NewPlate.HPHeal:Show()
				end
			else
				self.NewPlate.HPHeal:Hide()
			end
		end
	end
end

function Plates:OnHide()
	if self.NewPlate.icons then
		for _, icon in ipairs(self.NewPlate.icons) do
			icon:Hide()
		end
	end
end

function Plates:UpdateHealth()
	self.NewPlate.Health:SetMinMaxValues(self.ArtContainer.HealthBar:GetMinMaxValues())
	self.NewPlate.Health:SetValue(self.ArtContainer.HealthBar:GetValue() - 1) -- Blizzard bug fix
	self.NewPlate.Health:SetValue(self.ArtContainer.HealthBar:GetValue())
end

function Plates:UpdateHealthColor()
	if not self:IsShown() then
		return
	end

	local Red, Green, Blue = Plates.GetColor(self)

	self.NewPlate.Health:SetStatusBarColor(Red, Green, Blue)
	self.NewPlate.Health.Background:SetTexture(Red, Green, Blue, 0.2)
	self.NewPlate.Name:SetTextColor(Red, Green, Blue)

	if self.isClass or self.isTapped then return end

	if C.nameplate.enhance_threat ~= true then
		if self.ArtContainer.AggroWarningTexture:IsShown() then
			local _, val = self.ArtContainer.AggroWarningTexture:GetVertexColor()
			if val > 0.7 then
				SetVirtualBorder(self.NewPlate.Health, transitionR, transitionG, transitionB)
			else
				SetVirtualBorder(self.NewPlate.Health, badR, badG, badB)
			end
		else
			SetVirtualBorder(self.NewPlate.Health, unpack(C.media.border_color))
		end
	else
		if not self.ArtContainer.AggroWarningTexture:IsShown() then
			if InCombatLockdown() and self.isFriendly ~= true then
				-- No Threat
				if T.Role == "Tank" then
					self.NewPlate.Health:SetStatusBarColor(badR, badG, badB)
					self.NewPlate.Health.Background:SetTexture(badR, badG, badB, 0.2)
				else
					self.NewPlate.Health:SetStatusBarColor(goodR, goodG, goodB)
					self.NewPlate.Health.Background:SetTexture(goodR, goodG, goodB, 0.2)
				end
			end
		else
			local r, g, b = self.ArtContainer.AggroWarningTexture:GetVertexColor()
			if g + b == 0 then
				-- Have Threat
				if T.Role == "Tank" then
					self.NewPlate.Health:SetStatusBarColor(goodR, goodG, goodB)
					self.NewPlate.Health.Background:SetTexture(goodR, goodG, goodB, 0.2)
				else
					self.NewPlate.Health:SetStatusBarColor(badR, badG, badB)
					self.NewPlate.Health.Background:SetTexture(badR, badG, badB, 0.2)
				end
			else
				-- Losing/Gaining Threat
				self.NewPlate.Health:SetStatusBarColor(transitionR, transitionG, transitionB)
				self.NewPlate.Health.Background:SetTexture(transitionR, transitionG, transitionB, 0.2)
			end
		end
	end
end

function Plates:UpdateHealthText()
	local _, MaxHP = self.ArtContainer.HealthBar:GetMinMaxValues()
	local CurrentHP = self.ArtContainer.HealthBar:GetValue()
	local Percent = (CurrentHP / MaxHP) * 100

	if C.nameplate.health_value == true then
		-- self.NewPlate.Health.Text:SetText(T.ShortValue(CurrentHP).." / "..T.ShortValue(MaxHP))
		self.NewPlate.Health.Text:SetFormattedText("%d%%", Percent)
	end

	if self.isClass == true or self.isFriendly == true then
		if Percent <= 50 and Percent >= 20 then
			SetVirtualBorder(self.NewPlate.Health, 1, 1, 0)
		elseif Percent < 20 then
			SetVirtualBorder(self.NewPlate.Health, 1, 0, 0)
		else
			SetVirtualBorder(self.NewPlate.Health, unpack(C.media.border_color))
		end
	elseif (self.isClass ~= true and self.isFriendly ~= true) and C.nameplate.enhance_threat == true then
		SetVirtualBorder(self.NewPlate.Health, unpack(C.media.border_color))
	end

	if GetUnitName("target") and self.NewPlate:GetAlpha() == 1 then
		self.NewPlate.Health:SetSize((C.nameplate.width + C.nameplate.ad_width) * T.noscalemult, (C.nameplate.height + C.nameplate.ad_height) * T.noscalemult)
		self.NewPlate.CastBar:SetPoint("BOTTOMLEFT", self.NewPlate.Health, "BOTTOMLEFT", 0, -8-((C.nameplate.height + C.nameplate.ad_height) * T.noscalemult))
		self.NewPlate.CastBar.Icon:SetSize(((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8, ((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8)
		self.NewPlate.Health:SetFrameLevel(2)
	else
		self.NewPlate.Health:SetSize(C.nameplate.width * T.noscalemult, C.nameplate.height * T.noscalemult)
		self.NewPlate.CastBar:SetPoint("BOTTOMLEFT", self.NewPlate.Health, "BOTTOMLEFT", 0, -8-(C.nameplate.height * T.noscalemult))
		self.NewPlate.CastBar.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
		self.NewPlate.Health:SetFrameLevel(1)
	end

	if UnitExists("target") and self.NewPlate:GetAlpha() == 1 and GetUnitName("target") == self.NewPlate.Name:GetText() then
		self.NewPlate.guid = UnitGUID("target")
		self.NewPlate.unit = "target"
		Plates.OnAura(self, "target")
	elseif self.ArtContainer.Highlight:IsShown() and UnitExists("mouseover") and GetUnitName("mouseover") == self.NewPlate.Name:GetText() then
		self.NewPlate.guid = UnitGUID("mouseover")
		self.NewPlate.unit = "mouseover"
		Plates.OnAura(self, "mouseover")
	else
		self.NewPlate.unit = nil
	end
end

local function NamePlateSizerOnSizeChanged(self, x, y)
	local plate = self.__owner
	if plate:IsShown() then
		plate.NewPlate:Hide()
		if T.PlateBlacklist[plate.NameContainer.NameText:GetText()] then return end
		plate.NewPlate:SetPoint("CENTER", WorldFrame, "BOTTOMLEFT", x, y)
		plate.NewPlate:Show()
	end
end

local function NamePlateCreateSizer(self)
	local sizer = CreateFrame("Frame", nil, self.NewPlate)
	sizer.__owner = self
	sizer:SetPoint("BOTTOMLEFT", WorldFrame)
	sizer:SetPoint("TOPRIGHT", self, "CENTER")
	sizer:SetScript("OnSizeChanged", NamePlateSizerOnSizeChanged)
end

function Plates:Skin(obj)
	local Plate = obj

	local HealthBar = Plate.ArtContainer.HealthBar
	local Border = Plate.ArtContainer.Border
	local Highlight = Plate.ArtContainer.Highlight
	local LevelText = Plate.ArtContainer.LevelText
	local RaidTargetIcon = Plate.ArtContainer.RaidTargetIcon
	local Elite = Plate.ArtContainer.EliteIcon
	local Threat = Plate.ArtContainer.AggroWarningTexture
	local Boss = Plate.ArtContainer.HighLevelIcon
	local CastBar = Plate.ArtContainer.CastBar
	local CastBarBorder = Plate.ArtContainer.CastBarBorder
	local CastBarSpellIcon = Plate.ArtContainer.CastBarSpellIcon
	local CastBarFrameShield = Plate.ArtContainer.CastBarFrameShield
	local CastBarText = Plate.ArtContainer.CastBarText
	local CastBarTextBG = Plate.ArtContainer.CastBarTextBG

	local Name = Plate.NameContainer.NameText

	self.Container[Plate] = CreateFrame("Frame", nil, self)

	local NewPlate = self.Container[Plate]
	NewPlate:SetSize(C.nameplate.width * T.noscalemult, (C.nameplate.height * T.noscalemult) * 2 + 8)
	NewPlate:SetFrameStrata("BACKGROUND")
	NewPlate:SetFrameLevel(0)

	NewPlate.Health = CreateFrame("StatusBar", nil, NewPlate)
	NewPlate.Health:SetFrameStrata("BACKGROUND")
	NewPlate.Health:SetFrameLevel(1)
	NewPlate.Health:SetSize(C.nameplate.width * T.noscalemult, C.nameplate.height * T.noscalemult)
	NewPlate.Health:SetStatusBarTexture(C.media.texture)
	NewPlate.Health:SetPoint("BOTTOM", 0, 0)
	CreateVirtualFrame(NewPlate.Health)

	NewPlate.Health.Background = NewPlate.Health:CreateTexture(nil, "BORDER")
	NewPlate.Health.Background:SetTexture(C.media.texture)
	NewPlate.Health.Background:SetAllPoints()

	if C.nameplate.health_value == true then
		NewPlate.Health.Text = NewPlate.Health:CreateFontString(nil, "OVERLAY")
		NewPlate.Health.Text:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		NewPlate.Health.Text:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		NewPlate.Health.Text:SetPoint( "RIGHT", NewPlate.Health, "RIGHT", 0, 0)
		NewPlate.Health.Text:SetTextColor(1, 1, 1)
	end

	NewPlate.Name = NewPlate.Health:CreateFontString(nil, "OVERLAY")
	NewPlate.Name:SetPoint("BOTTOMLEFT", NewPlate.Health, "TOPLEFT", -3, 4)
	NewPlate.Name:SetPoint("BOTTOMRIGHT", NewPlate.Health, "TOPRIGHT", 3, 4)
	NewPlate.Name:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	NewPlate.Name:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)

	NewPlate.level = NewPlate.Health:CreateFontString(nil, "OVERLAY")
	NewPlate.level:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	NewPlate.level:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	NewPlate.level:SetTextColor(1, 1, 1)
	NewPlate.level:SetPoint("RIGHT", NewPlate.Health, "LEFT", -2, 0)

	NewPlate.CastBar = CreateFrame("StatusBar", nil, NewPlate.Health)
	NewPlate.CastBar:SetFrameStrata("BACKGROUND")
	NewPlate.CastBar:SetFrameLevel(1)
	NewPlate.CastBar:SetStatusBarTexture(C.media.texture)
	NewPlate.CastBar:SetPoint("TOPRIGHT", NewPlate.Health, "BOTTOMRIGHT", 0, -8)
	NewPlate.CastBar:SetPoint("BOTTOMLEFT", NewPlate.Health, "BOTTOMLEFT", 0, -8-(C.nameplate.height * T.noscalemult))
	NewPlate.CastBar:Hide()
	CreateVirtualFrame(NewPlate.CastBar)

	NewPlate.CastBar.Background = NewPlate.CastBar:CreateTexture(nil, "BORDER")
	NewPlate.CastBar.Background:SetTexture(0.75, 0.75, 0.25, 0.2)
	NewPlate.CastBar.Background:SetAllPoints()

	NewPlate.hiddenFrame = CreateFrame("Frame", nil, NewPlate)
	NewPlate.hiddenFrame:Hide()
	CastBarSpellIcon:SetParent(NewPlate.hiddenFrame)
	NewPlate.CastBar.Icon = NewPlate.CastBar:CreateTexture(nil, "OVERLAY")
	NewPlate.CastBar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	NewPlate.CastBar.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
	NewPlate.CastBar.Icon:SetPoint("TOPLEFT", NewPlate.Health, "TOPRIGHT", 8, 0)
	CreateVirtualFrame(NewPlate.CastBar, NewPlate.CastBar.Icon)

	NewPlate.CastBar.Time = NewPlate.CastBar:CreateFontString(nil, "ARTWORK")
	NewPlate.CastBar.Time:SetPoint("RIGHT", NewPlate.CastBar, "RIGHT", 3, 0)
	NewPlate.CastBar.Time:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	NewPlate.CastBar.Time:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	NewPlate.CastBar.Time:SetTextColor(1, 1, 1)

	if C.nameplate.show_castbar_name == true then
		NewPlate.CastBar.Name = NewPlate.CastBar:CreateFontString(nil, "OVERLAY")
		NewPlate.CastBar.Name:SetPoint("LEFT", NewPlate.CastBar, "LEFT", 3, 0)
		NewPlate.CastBar.Name:SetPoint("RIGHT", NewPlate.CastBar.Time, "LEFT", -1, 0)
		NewPlate.CastBar.Name:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		NewPlate.CastBar.Name:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		NewPlate.CastBar.Name:SetTextColor(1, 1, 1)
		NewPlate.CastBar.Name:SetHeight(C.font.nameplates_font_size)
		NewPlate.CastBar.Name:SetJustifyH("LEFT")
	end

	RaidTargetIcon:ClearAllPoints()
	RaidTargetIcon:SetPoint("BOTTOM", NewPlate.Health, "TOP", 0, C.nameplate.track_auras == true and 38 or 16)
	RaidTargetIcon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)

	if C.nameplate.track_auras == true then
		if not NewPlate.icons then
			NewPlate.icons = CreateFrame("Frame", nil, NewPlate.Health)
			NewPlate.icons:SetPoint("BOTTOMRIGHT", NewPlate.Health, "TOPRIGHT", 0, C.font.nameplates_font_size + 7)
			NewPlate.icons:SetWidth(20 + C.nameplate.width)
			NewPlate.icons:SetHeight(C.nameplate.auras_size)
			NewPlate.icons:SetFrameLevel(NewPlate.Health:GetFrameLevel() + 2)
		end
	end

	if C.nameplate.class_icons == true then
		NewPlate.class = NewPlate.Health:CreateTexture(nil, "OVERLAY")
		NewPlate.class:SetPoint("TOPRIGHT", NewPlate.Health, "TOPLEFT", -8, T.noscalemult * 2)
		NewPlate.class:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
		NewPlate.class:SetSize((C.nameplate.height * 2 * T.noscalemult) + 11, (C.nameplate.height * 2 * T.noscalemult) + 11)

		NewPlate.class.Glow = CreateFrame("Frame", nil, NewPlate.Health)
		NewPlate.class.Glow:SetTemplate("Transparent")
		NewPlate.class.Glow:SetScale(T.noscalemult)
		NewPlate.class.Glow:SetAllPoints(NewPlate.class)
		NewPlate.class.Glow:SetFrameLevel(NewPlate.Health:GetFrameLevel() -1 > 0 and NewPlate.Health:GetFrameLevel() -1 or 0)
		NewPlate.class.Glow:Hide()
	end

	if C.nameplate.healer_icon == true then
		NewPlate.HPHeal = NewPlate.Health:CreateFontString(nil, "OVERLAY")
		NewPlate.HPHeal:SetFont(C.font.nameplates_font, 32, C.font.nameplates_font_style)
		NewPlate.HPHeal:SetText("|cFFD53333+|r")
		if C.nameplate.track_auras == true then
			NewPlate.HPHeal:SetPoint("BOTTOM", NewPlate.Name, "TOP", 0, 13)
		else
			NewPlate.HPHeal:SetPoint("BOTTOM", NewPlate.Name, "TOP", 0, 0)
		end
	end

	Plate.NewPlate = NewPlate

	self.OnShow(Plate)
	NamePlateCreateSizer(obj)
	Plate:HookScript("OnShow", self.OnShow)
	Plate:HookScript("OnHide", self.OnHide)
	HealthBar:HookScript("OnValueChanged", function() self.UpdateHealth(Plate) end)
	CastBar:HookScript("OnShow", function() self.CastOnShow(Plate) end)
	CastBar:HookScript("OnHide", function() self.CastOnHide(Plate) end)
	CastBar:HookScript("OnValueChanged", function() self.UpdateCastBar(Plate) end)

	Plate.IsSkinned = true
end

function Plates:Search(...)
	local count = WorldFrame:GetNumChildren()
	if count ~= numChildren then
		numChildren = count
		for index = 1, select("#", WorldFrame:GetChildren()) do
			local frame = select(index, WorldFrame:GetChildren())
			local name = frame:GetName()

			if not frame.IsSkinned and (name and name:find("^NamePlate%d")) then
				Plates:Skin(frame)
			end
		end
	end
end

function Plates:Update()
	for Plate, NewPlate in pairs(self.Container) do
		if Plate:IsShown() then
			if Plate:GetAlpha() == 1 then
				NewPlate:SetAlpha(1)
			else
				NewPlate:SetAlpha(0.5)
			end

			self.UpdateHealthColor(Plate)
			self.UpdateHealthText(Plate)
		else
			NewPlate:Hide()
		end
	end
end

function Plates:OnUpdate(elapsed)
	self:Search()
	self:Update()
end

function Plates:Enable()
	SetCVar("bloatnameplates", 0)
	SetCVar("bloatthreat", 0)

	self:SetAllPoints()
	self.Container = {}
	self:SetScript("OnUpdate", self.OnUpdate)
end

Plates:Enable()

function Plates:MatchGUID(destGUID, spellID)
	if not self.NewPlate.guid then return end

	if self.NewPlate.guid == destGUID then
		for _, icon in ipairs(self.NewPlate.icons) do
			if icon.spellID == spellID then
				icon:Hide()
			end
		end
	end
end

function NamePlates:COMBAT_LOG_EVENT_UNFILTERED(_, event, ...)
	if event == "SPELL_AURA_REMOVED" then
		local _, sourceGUID, _, _, _, destGUID, _, _, _, spellID = ...

		if sourceGUID == UnitGUID("player") or arg4 == UnitGUID("pet") then
			for Plate, NewPlate in pairs(Plates.Container) do
				if Plate:IsShown() then
					Plates.MatchGUID(Plate, destGUID, spellID)
				end
			end
		end
	end
end

-- Only show nameplates when in combat
if C.nameplate.combat == true then
	NamePlates:RegisterEvent("PLAYER_REGEN_ENABLED")
	NamePlates:RegisterEvent("PLAYER_REGEN_DISABLED")

	function NamePlates:PLAYER_REGEN_ENABLED()
		SetCVar("nameplateShowEnemies", 0)
	end

	function NamePlates:PLAYER_REGEN_DISABLED()
		SetCVar("nameplateShowEnemies", 1)
	end
end

NamePlates:RegisterEvent("PLAYER_ENTERING_WORLD")
function NamePlates:PLAYER_ENTERING_WORLD()
	if C.nameplate.combat == true then
		if InCombatLockdown() then
			SetCVar("nameplateShowEnemies", 1)
		else
			SetCVar("nameplateShowEnemies", 0)
		end
	end
	if C.nameplate.enhance_threat == true then
		SetCVar("threatWarning", 3)
	end
end