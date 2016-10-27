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
	for _, specID in pairs(healerSpecIDs) do
		local _, name = GetSpecializationInfoByID(specID)
		if name and not healerSpecs[name] then
			healerSpecs[name] = true
		end
	end

	local lastCheck = 20
	local function CheckHealers(self, elapsed)
		lastCheck = lastCheck + elapsed
		if lastCheck > 25 then
			lastCheck = 0
			healList = {}
			for i = 1, GetNumBattlefieldScores() do
				local name, _, _, _, _, faction, _, _, _, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(i)
				if name and healerSpecs[talentSpec] and t.factions[UnitFactionGroup("player")] == faction then
					name = name:match("(.+)%-.+") or name
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

function Plates:CreateAuraIcon(self)
	local button = CreateFrame("Frame", nil, self.Health)
	button:SetWidth(C.nameplate.auras_size)
	button:SetHeight(C.nameplate.auras_size)

	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetColorTexture(unpack(C.media.backdrop_color))
	button.bg:SetAllPoints(button)

	button.bord = button:CreateTexture(nil, "BORDER")
	button.bord:SetColorTexture(unpack(C.media.border_color))
	button.bord:SetPoint("TOPLEFT", button, "TOPLEFT", T.noscalemult, -T.noscalemult)
	button.bord:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -T.noscalemult, T.noscalemult)

	button.bg2 = button:CreateTexture(nil, "ARTWORK")
	button.bg2:SetColorTexture(unpack(C.media.backdrop_color))
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
		self.NewPlate.CastBar.Background:SetColorTexture(0.78, 0.25, 0.25, 0.2)
	else
		self.NewPlate.CastBar:SetStatusBarColor(Red, Blue, Green)
		self.NewPlate.CastBar.Background:SetColorTexture(0.75, 0.75, 0.25, 0.2)
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
	self.NewPlate.Health.Background:SetColorTexture(red, Green, Blue, 0.2)
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
					self.NewPlate.Health.Background:SetColorTexture(badR, badG, badB, 0.2)
				else
					self.NewPlate.Health:SetStatusBarColor(goodR, goodG, goodB)
					self.NewPlate.Health.Background:SetColorTexture(goodR, goodG, goodB, 0.2)
				end
			end
		else
			local r, g, b = self.ArtContainer.AggroWarningTexture:GetVertexColor()
			if g + b == 0 then
				-- Have Threat
				if T.Role == "Tank" then
					self.NewPlate.Health:SetStatusBarColor(goodR, goodG, goodB)
					self.NewPlate.Health.Background:SetColorTexture(goodR, goodG, goodB, 0.2)
				else
					self.NewPlate.Health:SetStatusBarColor(badR, badG, badB)
					self.NewPlate.Health.Background:SetColorTexture(badR, badG, badB, 0.2)
				end
			else
				-- Losing/Gaining Threat
				self.NewPlate.Health:SetStatusBarColor(transitionR, transitionG, transitionB)
				self.NewPlate.Health.Background:SetColorTexture(transitionR, transitionG, transitionB, 0.2)
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
		self.NewPlate.Health:SetFrameLevel(1)
	else
		self.NewPlate.Health:SetSize(C.nameplate.width * T.noscalemult, C.nameplate.height * T.noscalemult)
		self.NewPlate.CastBar:SetPoint("BOTTOMLEFT", self.NewPlate.Health, "BOTTOMLEFT", 0, -8-(C.nameplate.height * T.noscalemult))
		self.NewPlate.CastBar.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
		self.NewPlate.Health:SetFrameLevel(0)
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
		NewPlate.Health.Text:SetPoint("RIGHT", NewPlate.Health, "RIGHT", 0, 0)
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
	NewPlate.CastBar.Background:SetColorTexture(0.75, 0.75, 0.25, 0.2)
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

-- function Plates:Enable()
	-- self:RegisterOptions()

	-- DefaultCompactNamePlateFriendlyFrameOptions = self.Options.Friendly
	-- DefaultCompactNamePlateEnemyFrameOptions = self.Options.Enemy
	-- DefaultCompactNamePlatePlayerFrameOptions = self.Options.Player
	-- DefaultCompactNamePlateFrameSetUpOptions = self.Options.Size
	-- DefaultCompactNamePlatePlayerFrameSetUpOptions = self.Options.PlayerSize

	-- SetCVar("namePlateMinScale", 1)
	-- SetCVar("namePlateMaxScale", 1)

	-- hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", self.SetupPlate)
	-- hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.ColorHealth)

	-- -- Make sure nameplates are always scaled at 1
	-- -- SetCVar("NamePlateVerticalScale", "1")
	-- -- SetCVar("NamePlateHorizontalScale", "1")

	-- -- C_NamePlate.SetNamePlateOtherSize(C.nameplate.width * T.noscalemult, 45)
	-- -- NamePlateDriverFrame:SetBaseNamePlateSize(C.nameplate.width * T.noscalemult, C.nameplate.height * T.noscalemult)

	-- NamePlateDriverFrame.UpdateNamePlateOptions = T.dummy
	-- InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:Hide()
-- end

-- Plates:Enable()

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
	-- if event == "SPELL_AURA_REMOVED" then
		-- local _, sourceGUID, _, _, _, destGUID, _, _, _, spellID = ...

		-- if sourceGUID == UnitGUID("player") or arg4 == UnitGUID("pet") then
			-- for Plate, NewPlate in pairs(Plates.Container) do
				-- if Plate:IsShown() then
					-- Plates.MatchGUID(Plate, destGUID, spellID)
				-- end
			-- end
		-- end
	-- end
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

-------------------
--[[ Config ]]--
local WhiteList = {
	--[11426]  = true,
	--[196741] = true,
	--[147732] = true,
	--BUFF

	--DEBUFF
	[119381] = true,
	[115078] = true,
	[25046]  = true,
}

local BlackList = {
	--[11426]  = true,
	--[196741] = true,
}

local Config = {
	myfiltertype = "whitelist", -- show aura cast by player
	otherfiltertype = "none",  -- show aura cast by other
	--"whitelist": show only list
	--"blacklist": show only unlist
	--"none": do not show anything

	playerplate = true,
	classresource_show = true,
	classresource = "player", --"player", "target"
}

--[[ Functions ]]--
colorspower = {}
for power, color in next, PowerBarColor do
	if (type(power) == "string") then
		colorspower[power] = {color.r, color.g, color.b}
	end
end

--[[ Auras ]]--
local day, hour, minute = 86400, 3600, 60
local function FormatTime(s)
	if s >= day then
		return format("%dd", floor(s/day + 0.5))
	elseif s >= hour then
		return format("%dh", floor(s/hour + 0.5))
	elseif s >= minute then
		return format("%dm", floor(s/minute + 0.5))
	end

	return format("%d", math.fmod(s, minute))
end

local function CreateAuraIcon(parent)
	local button = CreateFrame("Frame", nil, parent)
	button:SetWidth(C.nameplate.auras_size)
	button:SetHeight(C.nameplate.auras_size)

	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetColorTexture(unpack(C.media.backdrop_color))
	button.bg:SetAllPoints(button)

	button.bord = button:CreateTexture(nil, "BORDER")
	button.bord:SetColorTexture(unpack(C.media.border_color))
	button.bord:SetPoint("TOPLEFT", button, "TOPLEFT", T.noscalemult, -T.noscalemult)
	button.bord:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -T.noscalemult, T.noscalemult)

	button.bg2 = button:CreateTexture(nil, "ARTWORK")
	button.bg2:SetColorTexture(unpack(C.media.backdrop_color))
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
	local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitAura(unit, index, filter)

	button.icon:SetTexture(icon)
	button.expirationTime = expirationTime
	button.duration = duration
	button.spellID = spellID

	button.cd:SetCooldown(expirationTime - duration, duration)

	local color = DebuffTypeColor[debuffType] or DebuffTypeColor.none
	button.bord:SetColorTexture(color.r, color.g, color.b)

	if count and count > 1 then
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

local function AuraFilter(caster, spellname)
	if caster == "player" then
		if Config["myfiltertype"] == "none" then
			return false
		elseif Config["myfiltertype"] == "whitelist" and T.DebuffWhiteList[spellname] then
			return true
		elseif Config["myfiltertype"] == "blacklist" and not BlackList[spellname] then
			return true
		end
	else
		if Config["otherfiltertype"] == "none" then
			return false
		elseif Config["otherfiltertype"] == "whitelist" and T.DebuffWhiteList[spellname] then
			return true
		end
	end
end

local function UpdateBuffs(unitFrame)
	if not unitFrame.icons or not unitFrame.displayedUnit then return end
	if not C.nameplate.track_auras and UnitIsUnit(unitFrame.displayedUnit, "player") then return end
	local unit = unitFrame.displayedUnit
	local i = 1

	-- for index = 1, 15 do
	-- if i > C.nameplate.width / C.nameplate.auras_size then return end
		-- local bname, _, _, _, _, bduration, _, bcaster, _, _, bspellid = UnitAura(unit, index, 'HELPFUL')
		-- local matchbuff = AuraFilter(bcaster, bname)

		-- if bname and matchbuff then
			-- if not unitFrame.icons[i] then
				-- unitFrame.icons[i] = CreateAuraIcon(unitFrame)
			-- end
			-- UpdateAuraIcon(unitFrame.icons[i], unit, index, 'HELPFUL')
			-- if i ~= 1 then
				-- -- unitFrame.icons[i]:SetPoint("LEFT", unitFrame.icons[i-1], "RIGHT", 4, 0)
					-- unitFrame.icons[i]:SetPoint("RIGHT", unitFrame.icons[i-1], "LEFT", -2, 0)
			-- end
			-- i = i + 1
		-- end
	-- end

	for index = 1, 40 do
		if i > C.nameplate.width / C.nameplate.auras_size then return end
		local dname, _, _, _, _, dduration, _, dcaster, _, _, dspellid = UnitAura(unit, index, 'HARMFUL')
		local matchdebuff = AuraFilter(dcaster, dname)

		if dname and matchdebuff then
			if not unitFrame.icons[i] then
				unitFrame.icons[i] = CreateAuraIcon(unitFrame)
			end
			UpdateAuraIcon(unitFrame.icons[i], unit, index, 'HARMFUL')
			if i == 1 then
				unitFrame.icons[i]:SetPoint("RIGHT", unitFrame.icons, "RIGHT")
			elseif i ~= 1 then
				unitFrame.icons[i]:SetPoint("RIGHT", unitFrame.icons[i-1], "LEFT", -2, 0)
			end
			i = i + 1
		end
	end

	unitFrame.iconnumber = i - 1

	-- if i > 1 then
		-- unitFrame.icons[1]:SetPoint("LEFT", unitFrame.icons, "CENTER", -((C.nameplate.auras_size+4)*(unitFrame.iconnumber)-4)/2,0)
	-- end
	for index = i, #unitFrame.icons do unitFrame.icons[index]:Hide() end
end

--[[ Player Power ]]--
-- if Config.playerplate then
	local PowerFrame = CreateFrame("Frame", "NamePlatePowerFrame")

	PowerFrame.powerBar = CreateFrame("StatusBar", nil, PowerFrame)
	PowerFrame.powerBar:SetHeight(3)
	PowerFrame.powerBar:SetStatusBarTexture(C.media.texture)
	PowerFrame.powerBar:SetMinMaxValues(0, 1)
	CreateVirtualFrame(PowerFrame.powerBar)

	PowerFrame:SetScript("OnEvent", function(self, event, unit)
		if GetCVar("nameplateShowSelf") == 0 then return end
		if event == "PLAYER_ENTERING_WORLD" or (event == "UNIT_POWER_FREQUENT" and unit == "player") then
			local minPower, maxPower, _, powertype = UnitPower("player"), UnitPowerMax("player"), UnitPowerType("player")
			local perc

			if maxPower ~= 0 then
				perc = minPower/maxPower
			else
				perc = 0
			end

			PowerFrame.powerBar:SetValue(perc)

			local r, g, b = unpack(colorspower[powertype])

			if r ~= PowerFrame.r or g ~= PowerFrame.g or b ~= PowerFrame.b then
				PowerFrame.powerBar:SetStatusBarColor(r, g, b)
				PowerFrame.r, PowerFrame.g, PowerFrame.b = r, g, b
			end
		elseif event == "NAME_PLATE_UNIT_ADDED" and UnitIsUnit(unit, "player") then
			local namePlatePlayer = C_NamePlate.GetNamePlateForUnit("player")
			if namePlatePlayer then
				PowerFrame:Show()
				PowerFrame:SetParent(namePlatePlayer)
				PowerFrame.powerBar:ClearAllPoints()
				PowerFrame.powerBar:SetPoint("TOPLEFT", namePlatePlayer.UnitFrame.healthBar, "BOTTOMLEFT", 0, -6)
				PowerFrame.powerBar:SetPoint("TOPRIGHT", namePlatePlayer.UnitFrame.healthBar, "BOTTOMRIGHT", 0, -6)
			end
		elseif event == "NAME_PLATE_UNIT_REMOVED" and UnitIsUnit(unit, "player") then
			PowerFrame:Hide()
		end
	end)
	PowerFrame:RegisterEvent("UNIT_POWER_FREQUENT")
	PowerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	PowerFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	PowerFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
-- end

--[[ Class bar stuff ]]--
-- if Config.classresource_show then
	local function multicheck(check, ...)
		for i = 1, select("#", ...) do
			if check == select(i, ...) then return true end
		end
		return false
	end

	local ClassPowerID, ClassPowerType, RequireSpec
	local classicon_colors = {	-- monk/paladin/preist
		{.6, 0, .1},
		{.9, .1, .2},
		{1, .2, .3},
		{1, .3, .4},
		{1, .4, .5},
		{1, .5, .6},
	}

	local cpoints_colors = {	-- combat points
		{1, 0, 0},
		{1, 1, 0},
	}

	if(T.class == 'MONK') then
		ClassPowerID = SPELL_POWER_CHI
		ClassPowerType = "CHI"
		RequireSpec = SPEC_MONK_WINDWALKER
	elseif(T.class == 'PALADIN') then
		ClassPowerID = SPELL_POWER_HOLY_POWER
		ClassPowerType = "HOLY_POWER"
		RequireSpec = SPEC_PALADIN_RETRIBUTION
	elseif(T.class == 'MAGE') then
		ClassPowerID = SPELL_POWER_ARCANE_CHARGES
		ClassPowerType = "ARCANE_CHARGES"
		RequireSpec = SPEC_MAGE_ARCANE
	elseif(T.class == 'WARLOCK') then
		ClassPowerID = SPELL_POWER_SOUL_SHARDS
		ClassPowerType = "SOUL_SHARDS"
	elseif(T.class == 'ROGUE' or T.class == 'DRUID') then
		ClassPowerID = SPELL_POWER_COMBO_POINTS
		ClassPowerType = "COMBO_POINTS"
	end

	local Resourcebar = CreateFrame("Frame", "Plateresource", UIParent)
	Resourcebar:SetWidth(100)	--(10+3)*6 - 3
	Resourcebar:SetHeight(3)
	Resourcebar.maxbar = 6

	for i = 1, 6 do
		Resourcebar[i] = CreateFrame("Frame", "Plateresource"..i, Resourcebar)
		Resourcebar[i]:SetFrameLevel(1)
		Resourcebar[i]:SetSize(13.5, 3)
		CreateVirtualFrame(Resourcebar[i])
		Resourcebar[i].tex = Resourcebar[i]:CreateTexture(nil, "OVERLAY")
		Resourcebar[i].tex:SetAllPoints(Resourcebar[i])
		if T.class == "DEATHKNIGHT" then
			Resourcebar[i].value = Resourcebar[i]:CreateFontString(nil, "OVERLAY")
			Resourcebar[i].value:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
			Resourcebar[i].value:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
			Resourcebar[i].value:SetPoint("CENTER")
			Resourcebar[i].tex:SetColorTexture(.7, .7, 1)
		end

		if i == 1 then
			Resourcebar[i]:SetPoint("BOTTOMLEFT", Resourcebar, "BOTTOMLEFT")
		else
			Resourcebar[i]:SetPoint("LEFT", Resourcebar[i-1], "RIGHT", 2, 0)
		end
	end

	Resourcebar:SetScript("OnEvent", function(self, event, unit, powerType)
		if GetCVar("nameplateShowSelf") == 0 then return end
		if event == "PLAYER_TALENT_UPDATE" then
			if multicheck(T.class, "WARLOCK", "PALADIN", "MONK", "MAGE", "ROGUE", "DRUID") and not RequireSpec or RequireSpec == GetSpecialization() then
				self:RegisterEvent("UNIT_POWER_FREQUENT")
				self:RegisterEvent("PLAYER_ENTERING_WORLD")
				self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
				self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
				self:RegisterEvent("PLAYER_TARGET_CHANGED")
				self:RegisterEvent("RUNE_POWER_UPDATE")
				self:Show()
			else
				self:UnregisterEvent("UNIT_POWER_FREQUENT")
				self:UnregisterEvent("PLAYER_ENTERING_WORLD")
				self:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
				self:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
				self:UnregisterEvent("PLAYER_TARGET_CHANGED")
				self:UnregisterEvent("RUNE_POWER_UPDATE")
				self:Hide()
			end
		elseif event == "PLAYER_ENTERING_WORLD" or (event == "UNIT_POWER_FREQUENT" and unit == "player" and powerType == ClassPowerType) then
			if multicheck(T.class, "WARLOCK", "PALADIN", "MONK", "MAGE", "ROGUE", "DRUID") then
				local cur, max, oldMax

				cur = UnitPower('player', ClassPowerID)
				max = UnitPowerMax('player', ClassPowerID)

				if multicheck(T.class, "WARLOCK", "PALADIN", "MONK", "MAGE") then
					for i = 1, max do
						if(i <= cur) then
							self[i]:Show()
						else
							self[i]:Hide()
						end
						if cur == max then
							self[i].tex:SetColorTexture(unpack(classicon_colors[max]))
						else
							self[i].tex:SetColorTexture(unpack(classicon_colors[i]))
						end
					end

					oldMax = self.maxbar
					if(max ~= oldMax) then
						if(max < oldMax) then
							for i = max + 1, oldMax do
								self[i]:Hide()
							end
						end
						for i = 1, 6 do
							self[i]:SetWidth(102/max-2)
						end
						self.maxbar = max
					end
				else
					if max <= 6 then
						for i = 1, max do
							if(i <= cur) then
								self[i]:Show()
							else
								self[i]:Hide()
							end
							self[i].tex:SetColorTexture(unpack(cpoints_colors[1]))
						end
					else
						if cur <= 5 then
							for i = 1, 5 do
								if(i <= cur) then
									self[i]:Show()
								else
									self[i]:Hide()
								end
								self[i].tex:SetColorTexture(unpack(cpoints_colors[1]))
							end
						else
							for i = 1, 5 do
								self[i]:Show()
							end
							for i = 1, cur - 5 do
								self[i].tex:SetColorTexture(unpack(cpoints_colors[2]))
							end
							for i = cur - 4, 5 do
								self[i].tex:SetColorTexture(unpack(cpoints_colors[1]))
							end
						end
					end

					oldMax = self.maxbar
					if(max ~= oldMax) then
						if max == 5 or max == 8 then
							self[6]:Hide()
							for i = 1, 6 do
								self[i]:SetWidth(102/5-2)
							end
						else
							for i = 1, 6 do
								self[i]:SetWidth(102/max-2)
								if i > max then
									self[i]:Hide()
								end
							end
						end
						self.maxbar = max
					end
				end
			end
		elseif T.class == "DEATHKNIGHT" and event == "RUNE_POWER_UPDATE" then
			local rid = unit
			local start, duration, runeReady = GetRuneCooldown(rid)
			if runeReady then
				self[rid]:SetAlpha(1)
				self[rid].tex:SetColorTexture(.7, .7, 1)
				self[rid]:SetScript("OnUpdate", nil)
				self[rid].value:SetText("")
			elseif start then
				self[rid]:SetAlpha(.7)
				self[rid].tex:SetColorTexture(.3, .3, .3)
				self[rid].max = duration
				self[rid].duration = GetTime() - start
				self[rid]:SetScript("OnUpdate", function(self, elapsed)
					self.duration = self.duration + elapsed
					if self.duration >= self.max or self.duration <= 0 then
						self.value:SetText("")
					else
						self.value:SetText(FormatTime(self.max - self.duration))
					end
				end)
			end
		elseif tonumber(GetCVar("nameplateResourceOnTarget")) == 0 then
			if event == "NAME_PLATE_UNIT_ADDED" and UnitIsUnit(unit, "player") then
				local namePlatePlayer = C_NamePlate.GetNamePlateForUnit("player")
				if namePlatePlayer then
					self:SetParent(namePlatePlayer)
					self:ClearAllPoints()
					self:Show()
					self:SetPoint("TOPLEFT", namePlatePlayer.UnitFrame.healthBar, "BOTTOMLEFT", 0, 15)
					self:SetPoint("TOPRIGHT", namePlatePlayer.UnitFrame.healthBar, "BOTTOMRIGHT", 0, 15)
				end
			elseif event == "NAME_PLATE_UNIT_REMOVED" and UnitIsUnit(unit, "player") then
				self:Hide()
			end
		elseif tonumber(GetCVar("nameplateResourceOnTarget")) == 1 and (event == "PLAYER_TARGET_CHANGED" or event == "NAME_PLATE_UNIT_ADDED") then
			local namePlateTarget = C_NamePlate.GetNamePlateForUnit("target")
			if namePlateTarget and UnitCanAttack("player", namePlateTarget.UnitFrame.displayedUnit) then
				self:SetParent(namePlateTarget)
				self:ClearAllPoints()
				self:SetPoint("TOPLEFT", namePlateTarget.UnitFrame.healthBar, "BOTTOMLEFT", 0, 25)
				self:SetPoint("TOPRIGHT", namePlateTarget.UnitFrame.healthBar, "BOTTOMRIGHT", 0, 25)
				self:Show()
			else
				self:Hide()
			end
		end
	end)

	Resourcebar:RegisterEvent("PLAYER_TALENT_UPDATE")
-- end

--[[ Unit frame ]]--
local function UpdateName(unitFrame)
	local name = GetUnitName(unitFrame.displayedUnit, false)
	if name then
		local level = UnitLevel(unitFrame.displayedUnit)
		local classification = UnitClassification(unitFrame.displayedUnit)

		local r, g, b
		if level == -1 or not level then
			level = "??"
			r, g, b = 0.8, 0.05, 0
		else
			local color = GetQuestDifficultyColor(level)
			r, g, b = color.r, color.g, color.b
		end

		if classification == "elite" or classification == "rareelite" then
			level = level.."+"
		end

		if (tonumber(level) == T.level and not classification == "elite") or UnitIsUnit(unitFrame.displayedUnit, "player") then
			unitFrame.level:SetText("")
		else
			unitFrame.level:SetText(level)
		end

		if C.nameplate.class_icons == true and UnitIsPlayer(unitFrame.displayedUnit) then
			unitFrame.level:SetPoint("RIGHT", unitFrame.name, "LEFT", -2, 0)
		else
			unitFrame.level:SetPoint("RIGHT", unitFrame.healthBar, "LEFT", -2, 0)
		end

		unitFrame.level:SetTextColor(r, g, b)

		if UnitIsUnit(unitFrame.displayedUnit, "player") then
			unitFrame.name:SetText("")
		else
			if C.nameplate.name_abbrev == true and C.nameplate.track_auras ~= true then
				unitFrame.name:SetText(Abbrev(name))
			else
				unitFrame.name:SetText(name)
			end
		end

		if C.nameplate.healer_icon == true then
			name = gsub(name, "%s*"..((_G.FOREIGN_SERVER_LABEL:gsub("^%s", "")):gsub("[%*()]", "%%%1")).."$", "")
			name = gsub(name, "%s*"..((_G.INTERACTIVE_SERVER_LABEL:gsub("^%s", "")):gsub("[%*()]", "%%%1")).."$", "")
			if testing then
				unitFrame.HPHeal:Show()
			else
				if healList[name] then
					if exClass[healList[name]] then
						unitFrame.HPHeal:Hide()
					else
						unitFrame.HPHeal:Show()
					end
				else
					unitFrame.HPHeal:Hide()
				end
			end
		end

		if UnitGUID("target") == nil then
			unitFrame:SetAlpha(1)
		else
			if C_NamePlate.GetNamePlateForUnit("target") ~= nil then
				unitFrame:SetAlpha(0.5)
				C_NamePlate.GetNamePlateForUnit("target").UnitFrame:SetAlpha(1)
				if C_NamePlate.GetNamePlateForUnit("player") ~= nil then
					C_NamePlate.GetNamePlateForUnit("player").UnitFrame:SetAlpha(1)
				end
			else
				unitFrame:SetAlpha(1)
			end
		end
	end
end

local function UpdateHealth(unitFrame)
	local unit = unitFrame.displayedUnit
	local minHealth, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
	local perc = minHealth / maxHealth
	local perc_text = string.format("%d%%", math.floor(perc * 100))

	unitFrame.healthBar:SetValue(perc)

	if C.nameplate.health_value == true then
		if UnitIsUnit("player", unitFrame.displayedUnit) then
			unitFrame.healthBar.value:SetText("")
		else
			unitFrame.healthBar.value:SetText(T.ShortValue(minHealth).." - "..perc_text)
		end
	end

	if UnitIsPlayer(unit) then
		if perc <= 0.5 and perc >= 0.2 then
			SetVirtualBorder(unitFrame.healthBar, 1, 1, 0)
		elseif perc < 0.2 then
			SetVirtualBorder(unitFrame.healthBar, 1, 0, 0)
		else
			SetVirtualBorder(unitFrame.healthBar, unpack(C.media.border_color))
		end
	elseif not UnitIsPlayer(unit) and C.nameplate.enhance_threat == true then
		SetVirtualBorder(unitFrame.healthBar, unpack(C.media.border_color))
	end
end

local function IsOnThreatList(unit)
	local _, threatStatus = UnitDetailedThreatSituation("player", unit)
	if threatStatus == 3 then  -- securely tanking, highest threat
		if T.Role == "Tank" then
			return unpack(C.nameplate.good_color)
		else
			return unpack(C.nameplate.bad_color)
		end
	elseif threatStatus == 2 then  -- insecurely tanking, another unit have higher threat but not tanking
		return unpack(C.nameplate.near_color)
	elseif threatStatus == 1 then  -- not tanking, higher threat than tank
		return unpack(C.nameplate.near_color)
	elseif threatStatus == 0 then  -- not tanking, lower threat than tank
		if T.Role == "Tank" then
			return unpack(C.nameplate.bad_color)
		else
			return unpack(C.nameplate.good_color)
		end
	end
end

local function IsTapDenied(unitFrame)
	return UnitIsTapDenied(unitFrame.unit) and not UnitPlayerControlled(unitFrame.unit)
end

local function UpdateHealthColor(unitFrame)
	local unit = unitFrame.displayedUnit
	local r, g, b
	local threat

	if not UnitIsConnected(unit) then
		r, g, b = 0.7, 0.7, 0.7
	else
		local _, class = UnitClass(unit)
		local classColor = T.oUF_colors.class[class]

		if UnitIsUnit("player", unit) then
			r, g, b = unpack(T.oUF_colors.class[class])
		elseif UnitIsPlayer(unit) and classColor and UnitReaction(unit, 'player') >= 5 then
			r, g, b = unpack(T.oUF_colors.power["MANA"])
		elseif UnitIsPlayer(unit) and classColor and UnitReaction(unit, 'player') <= 4 then
			r, g, b = unpack(T.oUF_colors.class[class])
		elseif IsTapDenied(unitFrame) then
			r, g, b = 0.6, 0.6, 0.6
		else
			if IsOnThreatList(unitFrame.displayedUnit) then
				if C.nameplate.enhance_threat ~= true then
					SetVirtualBorder(unitFrame.healthBar, unpack(IsOnThreatList(unitFrame.displayedUnit)))
				else
					r, g, b = IsOnThreatList(unitFrame.displayedUnit)
					threat = true
				end
			else
				local reaction = T.oUF_colors.reaction[UnitReaction(unit, "player")]
				if reaction then
					r, g, b = reaction[1], reaction[2], reaction[3]
				else
					r, g, b = UnitSelectionColor(unit, true)
				end
			end
		end
	end

	if (r ~= unitFrame.r or g ~= unitFrame.g or b ~= unitFrame.b) then
		unitFrame.healthBar:SetStatusBarColor(r, g, b)
		unitFrame.healthBar.Background:SetColorTexture(r, g, b, 0.2)
		unitFrame.name:SetTextColor(r, g, b)
		if threat then
			local reaction = T.oUF_colors.reaction[UnitReaction(unit, "player")]
			if reaction then
				red, green, blue = reaction[1], reaction[2], reaction[3]
			else
				red, green, blue = UnitSelectionColor(unit, true)
			end
			unitFrame.name:SetTextColor(red, green, blue)
		end
		unitFrame.r, unitFrame.g, unitFrame.b = r, g, b
	end
end

local function UpdateCastBar(unitFrame)
	local castBar = unitFrame.castBar
	castBar.startCastColor = CreateColor(1, 0.8, 0)
	castBar.startChannelColor = CreateColor(1, 0.8, 0)
	castBar.finishedCastColor = CreateColor(1, 0.8, 0)
	castBar.failedCastColor = CreateColor(0.5, 0.2, 0.2)
	castBar.nonInterruptibleColor = CreateColor(0.78, 0.25, 0.25)

	CastingBarFrame_AddWidgetForFade(castBar, castBar.BorderShield)
	if not UnitIsUnit("player", unitFrame.displayedUnit) then
		CastingBarFrame_SetUnit(castBar, unitFrame.unit, false, false)
	end
end

function NamePlates_UpdateCastBar(self)
	local Minimum, Maximum = self:GetMinMaxValues()
	local Current = self:GetValue()
	local Shield = self.BorderShield

	if Shield:IsShown() then
		self:SetStatusBarColor(0.78, 0.25, 0.25)
		self.Background:SetColorTexture(0.78, 0.25, 0.25, 0.2)
	else
		self:SetStatusBarColor(1, 0.8, 0)
		self.Background:SetColorTexture(1, 0.8, 0, 0.2)
	end

	local last = self.last and self.last or 0
	local finish = (Current > last) and (Maximum - Current) or Current

	self.Time:SetFormattedText("%.1f ", finish)
	self.last = Current
end

local function UpdateRaidTarget(unitFrame)
	local icon = unitFrame.RaidTargetFrame.RaidTargetIcon
	local index = GetRaidTargetIndex(unitFrame.displayedUnit)
	if index then
		if not UnitIsUnit(unitFrame.displayedUnit, "player") then
			SetRaidTargetIconTexture(icon, index)
			icon:Show()
		end
	else
		icon:Hide()
	end
end

local function UpdateNamePlateEvents(unitFrame)
	-- These are events affected if unit is in a vehicle
	local unit = unitFrame.unit
	local displayedUnit
	if unit ~= unitFrame.displayedUnit then
		displayedUnit = unitFrame.displayedUnit
	end
	unitFrame:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", unit, displayedUnit)
	unitFrame:RegisterUnitEvent("UNIT_AURA", unit, displayedUnit)
	unitFrame:RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE", unit, displayedUnit)
end

local function UpdateInVehicle(unitFrame)
	if UnitHasVehicleUI(unitFrame.unit) then
		if not unitFrame.inVehicle then
			unitFrame.inVehicle = true
			local prefix, id, suffix = string.match(unitFrame.unit, "([^%d]+)([%d]*)(.*)")
			unitFrame.displayedUnit = prefix.."pet"..id..suffix
			UpdateNamePlateEvents(unitFrame)
		end
	else
		if unitFrame.inVehicle then
			unitFrame.inVehicle = false
			unitFrame.displayedUnit = unitFrame.unit
			UpdateNamePlateEvents(unitFrame)
		end
	end
end

local function UpdateAll(unitFrame)
	UpdateInVehicle(unitFrame)
	if UnitExists(unitFrame.displayedUnit) then
		UpdateName(unitFrame)
		UpdateHealthColor(unitFrame)
		UpdateHealth(unitFrame)
		UpdateCastBar(unitFrame)
		UpdateBuffs(unitFrame)
		UpdateRaidTarget(unitFrame)

		if UnitIsUnit("player", unitFrame.displayedUnit) then
			unitFrame.castBar:UnregisterAllEvents()
		end
	end
end

local function NamePlate_OnEvent(self, event, ...)
	local arg1, arg2, arg3, arg4 = ...
	if event == "PLAYER_TARGET_CHANGED" then
		UpdateName(self)
	elseif event == "PLAYER_ENTERING_WORLD" then
		UpdateAll(self)
	elseif arg1 == self.unit or arg1 == self.displayedUnit then
		if event == "UNIT_HEALTH_FREQUENT" then
			UpdateHealth(self)
		elseif event == "UNIT_AURA" then
			UpdateBuffs(self)
		elseif event == "UNIT_THREAT_LIST_UPDATE" then
			UpdateHealthColor(self)
		elseif event == "UNIT_NAME_UPDATE" then
			UpdateName(self)
		elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_PET" then
			UpdateAll(self)
		end
	end
end

local function RegisterNamePlateEvents(unitFrame)
	unitFrame:RegisterEvent("UNIT_NAME_UPDATE")
	unitFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	unitFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	unitFrame:RegisterEvent("UNIT_PET")
	unitFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
	unitFrame:RegisterEvent("UNIT_EXITED_VEHICLE")
	UpdateNamePlateEvents(unitFrame)
	unitFrame:SetScript("OnEvent", NamePlate_OnEvent)
end

local function UnregisterNamePlateEvents(unitFrame)
	unitFrame:UnregisterAllEvents()
	unitFrame:SetScript("OnEvent", nil)
end

local function SetUnit(unitFrame, unit)
	unitFrame.unit = unit
	unitFrame.displayedUnit = unit	 -- For vehicles
	unitFrame.inVehicle = false
	if unit then
		RegisterNamePlateEvents(unitFrame)
	else
		UnregisterNamePlateEvents(unitFrame)
	end
end

--[[ Driver frame ]]--
local function HideBlizzard()
	NamePlateDriverFrame:UnregisterAllEvents()
	ClassNameplateManaBarFrame:Hide()

	hooksecurefunc(NamePlateDriverFrame, "SetupClassNameplateBar", function()
		NamePlateTargetResourceFrame:Hide()
		NamePlatePlayerResourceFrame:Hide()
	end)

	SetCVar("namePlateMinScale", 1)
	SetCVar("namePlateMaxScale", 1)
	SetCVar("nameplateLargerScale", 1)
	SetCVar("nameplateMaxAlpha", 1)
	SetCVar("nameplateMinAlpha", 1)

	local checkBox = InterfaceOptionsNamesPanelUnitNameplatesMakeLarger
	function checkBox.setFunc(value)
		if value == "1" then
			SetCVar("NamePlateHorizontalScale", checkBox.largeHorizontalScale)
			SetCVar("NamePlateVerticalScale", checkBox.largeVerticalScale)
		else
			SetCVar("NamePlateHorizontalScale", checkBox.normalHorizontalScale)
			SetCVar("NamePlateVerticalScale", checkBox.normalVerticalScale)
		end
		NamePlates_UpdateNamePlateOptions()
	end
end

local function OnUnitFactionChanged(unit)
	-- This would make more sense as a unitFrame:RegisterUnitEvent
	local namePlate = C_NamePlate.GetNamePlateForUnit(unit)
	if namePlate then
		UpdateName(namePlate.UnitFrame)
		UpdateHealthColor(namePlate.UnitFrame)
	end
end

local function OnRaidTargetUpdate()
	for _, namePlate in pairs(C_NamePlate.GetNamePlates()) do
		UpdateRaidTarget(namePlate.UnitFrame)
	end
end

function NamePlates_UpdateNamePlateOptions()
	-- Called at VARIABLES_LOADED and by "Larger Nameplates" interface options checkbox
	local baseNamePlateWidth = C.nameplate.width * T.noscalemult
	local baseNamePlateHeight = 45
	local horizontalScale = tonumber(GetCVar("NamePlateHorizontalScale"))
	if select(4, GetBuildInfo()) >= 70100 then
		C_NamePlate.SetNamePlateFriendlySize(baseNamePlateWidth * horizontalScale, baseNamePlateHeight)
		C_NamePlate.SetNamePlateEnemySize(baseNamePlateWidth * horizontalScale, baseNamePlateHeight)
	else
		C_NamePlate.SetNamePlateOtherSize(baseNamePlateWidth * horizontalScale, baseNamePlateHeight)
	end

	C_NamePlate.SetNamePlateSelfSize(baseNamePlateWidth, baseNamePlateHeight)

	for i, namePlate in ipairs(C_NamePlate.GetNamePlates()) do
		local unitFrame = namePlate.UnitFrame
		UpdateAll(unitFrame)
	end
end

local function OnNamePlateCreated(namePlate)
	namePlate.UnitFrame = CreateFrame("Button", "$parentUnitFrame", namePlate)
	namePlate.UnitFrame:SetAllPoints(namePlate)
	namePlate.UnitFrame:SetFrameLevel(namePlate:GetFrameLevel())

	namePlate.UnitFrame.healthBar = CreateFrame("StatusBar", nil, namePlate.UnitFrame)
	namePlate.UnitFrame.healthBar:SetHeight(C.nameplate.height * T.noscalemult)
	namePlate.UnitFrame.healthBar:SetPoint("LEFT", 0, 0)
	namePlate.UnitFrame.healthBar:SetPoint("RIGHT", 0, 0)
	namePlate.UnitFrame.healthBar:SetStatusBarTexture(C.media.texture)
	namePlate.UnitFrame.healthBar:SetMinMaxValues(0, 1)
	CreateVirtualFrame(namePlate.UnitFrame.healthBar)

	namePlate.UnitFrame.healthBar.Background = namePlate.UnitFrame.healthBar:CreateTexture(nil, "BORDER")
	namePlate.UnitFrame.healthBar.Background:SetTexture(C.media.texture)
	namePlate.UnitFrame.healthBar.Background:SetAllPoints()

	if C.nameplate.health_value == true then
		namePlate.UnitFrame.healthBar.value = namePlate.UnitFrame.healthBar:CreateFontString(nil, "OVERLAY")
		namePlate.UnitFrame.healthBar.value:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		namePlate.UnitFrame.healthBar.value:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		namePlate.UnitFrame.healthBar.value:SetPoint("RIGHT", namePlate.UnitFrame.healthBar, "RIGHT", 0, 0)
		namePlate.UnitFrame.healthBar.value:SetTextColor(1, 1, 1)
	end

	namePlate.UnitFrame.name = namePlate.UnitFrame:CreateFontString(nil, "OVERLAY")
	namePlate.UnitFrame.name:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	namePlate.UnitFrame.name:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	namePlate.UnitFrame.name:SetPoint("BOTTOMLEFT", namePlate.UnitFrame.healthBar, "TOPLEFT", -3, 4)
	namePlate.UnitFrame.name:SetPoint("BOTTOMRIGHT", namePlate.UnitFrame.healthBar, "TOPRIGHT", 3, 4)
	namePlate.UnitFrame.name:SetTextColor(1, 1, 1)

	namePlate.UnitFrame.level = namePlate.UnitFrame.healthBar:CreateFontString(nil, "OVERLAY")
	namePlate.UnitFrame.level:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	namePlate.UnitFrame.level:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	namePlate.UnitFrame.level:SetTextColor(1, 1, 1)
	namePlate.UnitFrame.level:SetPoint("RIGHT", namePlate.UnitFrame.healthBar, "LEFT", -2, 0)

	namePlate.UnitFrame.castBar = CreateFrame("StatusBar", nil, namePlate.UnitFrame)
	CreateVirtualFrame(namePlate.UnitFrame.castBar)
	namePlate.UnitFrame.castBar:Hide()
	namePlate.UnitFrame.castBar.iconWhenNoninterruptible = false
	namePlate.UnitFrame.castBar:SetHeight(C.nameplate.height * T.noscalemult)
	namePlate.UnitFrame.castBar:SetPoint("TOPRIGHT", namePlate.UnitFrame.healthBar, "BOTTOMRIGHT", 0, -8)
	namePlate.UnitFrame.castBar:SetPoint("BOTTOMLEFT", namePlate.UnitFrame.healthBar, "BOTTOMLEFT", 0, -8-(C.nameplate.height * T.noscalemult))
	namePlate.UnitFrame.castBar:SetStatusBarTexture(C.media.texture)
	namePlate.UnitFrame.castBar:SetStatusBarColor(1, 0.8, 0)

	namePlate.UnitFrame.castBar.Background = namePlate.UnitFrame.castBar:CreateTexture(nil, "BORDER")
	namePlate.UnitFrame.castBar.Background:SetColorTexture(1, 0.8, 0, 0.2)
	namePlate.UnitFrame.castBar.Background:SetAllPoints()

	namePlate.UnitFrame.castBar.Time = namePlate.UnitFrame.castBar:CreateFontString(nil, "ARTWORK")
	namePlate.UnitFrame.castBar.Time:SetPoint("RIGHT", namePlate.UnitFrame.castBar, "RIGHT", 3, 0)
	namePlate.UnitFrame.castBar.Time:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	namePlate.UnitFrame.castBar.Time:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	namePlate.UnitFrame.castBar.Time:SetTextColor(1, 1, 1)

	if C.nameplate.show_castbar_name == true then
		namePlate.UnitFrame.castBar.Text = namePlate.UnitFrame.castBar:CreateFontString(nil, "OVERLAY")
		namePlate.UnitFrame.castBar.Text:SetPoint("LEFT", namePlate.UnitFrame.castBar, "LEFT", 3, 0)
		namePlate.UnitFrame.castBar.Text:SetPoint("RIGHT", namePlate.UnitFrame.castBar, "RIGHT", -11, 0)
		namePlate.UnitFrame.castBar.Text:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		namePlate.UnitFrame.castBar.Text:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		namePlate.UnitFrame.castBar.Text:SetTextColor(1, 1, 1)
		namePlate.UnitFrame.castBar.Text:SetHeight(C.font.nameplates_font_size)
		namePlate.UnitFrame.castBar.Text:SetJustifyH("LEFT")
	end

	namePlate.UnitFrame.castBar.Icon = namePlate.UnitFrame.castBar:CreateTexture(nil, "OVERLAY", 1)
	namePlate.UnitFrame.castBar.Icon:SetPoint("TOPLEFT", namePlate.UnitFrame.healthBar, "TOPRIGHT", 8, 0)
	namePlate.UnitFrame.castBar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	namePlate.UnitFrame.castBar.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
	CreateVirtualFrame(namePlate.UnitFrame.castBar, namePlate.UnitFrame.castBar.Icon)

	namePlate.UnitFrame.castBar.BorderShield = namePlate.UnitFrame.castBar:CreateTexture(nil, "OVERLAY", 1)
	namePlate.UnitFrame.castBar.BorderShield:SetAtlas("nameplates-InterruptShield")
	namePlate.UnitFrame.castBar.BorderShield:SetSize(15, 15)
	namePlate.UnitFrame.castBar.BorderShield:SetPoint("LEFT", namePlate.UnitFrame.castBar, "LEFT", 5, -5)

	namePlate.UnitFrame.castBar.Spark = namePlate.UnitFrame.castBar:CreateTexture(nil, "OVERLAY")
	namePlate.UnitFrame.castBar.Spark:SetSize(30, 25)
	namePlate.UnitFrame.castBar.Spark:SetTexture("")
	namePlate.UnitFrame.castBar.Spark:SetBlendMode("ADD")
	namePlate.UnitFrame.castBar.Spark:SetPoint("CENTER", 0, 3)

	namePlate.UnitFrame.castBar.Flash = namePlate.UnitFrame.castBar:CreateTexture(nil, "OVERLAY")
	namePlate.UnitFrame.castBar.Flash:SetAllPoints()
	namePlate.UnitFrame.castBar.Flash:SetTexture("")
	namePlate.UnitFrame.castBar.Flash:SetBlendMode("ADD")

	CastingBarFrame_OnLoad(namePlate.UnitFrame.castBar, nil, false, true)
	namePlate.UnitFrame.castBar:SetScript("OnEvent", CastingBarFrame_OnEvent)
	namePlate.UnitFrame.castBar:SetScript("OnUpdate", CastingBarFrame_OnUpdate)
	namePlate.UnitFrame.castBar:SetScript("OnShow", CastingBarFrame_OnShow)
	namePlate.UnitFrame.castBar:SetScript("OnHide", function() namePlate.UnitFrame.castBar:Hide() end)
	namePlate.UnitFrame.castBar:HookScript("OnValueChanged", function() NamePlates_UpdateCastBar(namePlate.UnitFrame.castBar) end)

	namePlate.UnitFrame.RaidTargetFrame = CreateFrame("Frame", nil, namePlate.UnitFrame)
	namePlate.UnitFrame.RaidTargetFrame:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
	namePlate.UnitFrame.RaidTargetFrame:SetPoint("BOTTOM", namePlate.UnitFrame.name, "TOP", 0, C.nameplate.track_auras == true and 38 or 16)

	namePlate.UnitFrame.RaidTargetFrame.RaidTargetIcon = namePlate.UnitFrame.RaidTargetFrame:CreateTexture(nil, "OVERLAY")
	namePlate.UnitFrame.RaidTargetFrame.RaidTargetIcon:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
	namePlate.UnitFrame.RaidTargetFrame.RaidTargetIcon:SetAllPoints()
	namePlate.UnitFrame.RaidTargetFrame.RaidTargetIcon:Hide()

	if C.nameplate.track_auras == true then
		namePlate.UnitFrame.icons = CreateFrame("Frame", nil, namePlate.UnitFrame)
		namePlate.UnitFrame.icons:SetPoint("BOTTOMRIGHT", namePlate.UnitFrame.healthBar, "TOPRIGHT", 0, C.font.nameplates_font_size + 7)
		namePlate.UnitFrame.icons:SetWidth(20 + C.nameplate.width)
		namePlate.UnitFrame.icons:SetHeight(C.nameplate.auras_size)
		namePlate.UnitFrame.icons:SetFrameLevel(namePlate.UnitFrame:GetFrameLevel() + 2)
	end

	if C.nameplate.healer_icon == true then
		namePlate.UnitFrame.HPHeal = namePlate.UnitFrame.healthBar:CreateFontString(nil, "OVERLAY")
		namePlate.UnitFrame.HPHeal:SetFont(C.font.nameplates_font, 32, C.font.nameplates_font_style)
		namePlate.UnitFrame.HPHeal:SetText("|cFFD53333+|r")
		if C.nameplate.track_auras == true then
			namePlate.UnitFrame.HPHeal:SetPoint("BOTTOM", namePlate.UnitFrame.name, "TOP", 0, 13)
		else
			namePlate.UnitFrame.HPHeal:SetPoint("BOTTOM", namePlate.UnitFrame.name, "TOP", 0, 0)
		end
	end

	namePlate.UnitFrame:EnableMouse(false)
end

local function OnNamePlateAdded(unit)
	local namePlate = C_NamePlate.GetNamePlateForUnit(unit)
	local unitFrame = namePlate.UnitFrame
	SetUnit(unitFrame, unit)
	UpdateAll(unitFrame)
end

local function OnNamePlateRemoved(unit)
	local namePlate = C_NamePlate.GetNamePlateForUnit(unit)
	SetUnit(namePlate.UnitFrame, nil)
end

local function NamePlates_OnEvent(self, event, ...)
	if event == "VARIABLES_LOADED" then
		HideBlizzard()
		-- if Config.playerplate then
			-- SetCVar("nameplateShowSelf", 1)
		-- else
			-- SetCVar("nameplateShowSelf", 0)
		-- end

		NamePlates_UpdateNamePlateOptions()
	elseif event == "NAME_PLATE_CREATED" then
		local namePlate = ...
		OnNamePlateCreated(namePlate)
	elseif event == "NAME_PLATE_UNIT_ADDED" then
		local unit = ...
		OnNamePlateAdded(unit)
	elseif event == "NAME_PLATE_UNIT_REMOVED" then
		local unit = ...
		OnNamePlateRemoved(unit)
	elseif event == "RAID_TARGET_UPDATE" then
		OnRaidTargetUpdate()
	elseif event == "DISPLAY_SIZE_CHANGED" then
		NamePlates_UpdateNamePlateOptions()
	elseif event == "UNIT_FACTION" then
		OnUnitFactionChanged(...)
	end
end

local NamePlatesFrame = CreateFrame("Frame", "NamePlatesFrame", UIParent)
NamePlatesFrame:SetScript("OnEvent", NamePlates_OnEvent)
NamePlatesFrame:RegisterEvent("VARIABLES_LOADED")
NamePlatesFrame:RegisterEvent("NAME_PLATE_CREATED")
NamePlatesFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
NamePlatesFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
NamePlatesFrame:RegisterEvent("DISPLAY_SIZE_CHANGED")
NamePlatesFrame:RegisterEvent("RAID_TARGET_UPDATE")
NamePlatesFrame:RegisterEvent("UNIT_FACTION")