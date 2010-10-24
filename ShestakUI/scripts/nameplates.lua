----------------------------------------------------------------------------------------
--	Based on caelNamePlates
----------------------------------------------------------------------------------------
if not SettingsCF["nameplate"].enable == true then return end

local caelNamePlates = CreateFrame("Frame", nil, UIParent)
caelNamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
SetCVar("bloatthreat", 0)
SetCVar("bloattest", 1)
SetCVar("bloatnameplates", 0)
if SettingsCF["nameplate"].overlap == true then
	SetCVar("spreadnameplates", "0")
else
	SetCVar("spreadnameplates", "1")
end
 
local select = select
 
local isValidFrame = function(frame)
	if frame:GetName() then	return end
	overlayRegion = select(2, frame:GetRegions())
	return overlayRegion and overlayRegion:GetObjectType() == "Texture" and overlayRegion:GetTexture() == "Interface\\Tooltips\\Nameplate-Border"
end
 
local updateTime = function(self, curValue)
	local minValue, maxValue = self:GetMinMaxValues()
	if self.channeling then
		self.time:SetFormattedText("%.1f ", curValue)
		if SettingsCF["nameplate"].show_castbar_name == true then
			self.castName:SetText(select(1, (UnitChannelInfo("target"))))
		end
	else
		self.time:SetFormattedText("%.1f ", maxValue - curValue)
		if SettingsCF["nameplate"].show_castbar_name == true then
			self.castName:SetText(select(1, (UnitCastingInfo("target"))))
		end
	end
end
 
local function round(num, idp)
  if idp and idp > 0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
 
local ShortValue = function(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

local function CheckTarget(self)
	if UnitName("target") == self.oldname:GetText() and self:GetAlpha() == 1 then
		return true
	else
		return false
	end
end

local threatUpdate = function(self, elapsed)
	self.elapsed = self.elapsed + elapsed	
 
	if self.elapsed >= 0.2 then
		local r, g, b = self.healthBar:GetStatusBarColor();
		local r, g, b = floor(r*100+.5)/100, floor(g*100+.5)/100, floor(b*100+.5)/100;
		local isEnemyPlayer = false
		local isTarget = false
		
		for class, color in pairs(RAID_CLASS_COLORS) do
			if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
				isEnemyPlayer = true
			end
		end
		
		if not InCombatLockdown() then self:SetScale(1) end
		
		if SettingsCF["nameplate"].enhance_threat == true then
			if not self.oldglow:IsShown() then
				if InCombatLockdown() and not isEnemyPlayer then
					if SettingsDB.Role == "Tank" then
						self.healthBar:SetStatusBarColor(1, 0, 0)
						self.healthBar.hpBackground:SetVertexColor(0.3, 0, 0)
					else
						self.healthBar:SetStatusBarColor(0.2, 0.8, 0.2)
						self.healthBar.hpBackground:SetVertexColor(0, 0.3, 0)
					end
				else
					self.healthBar:SetStatusBarColor(self.r, self.g, self.b)		
					self.healthBar.hpBackground:SetVertexColor((self.r * 0.3), (self.g * 0.3), (self.b * 0.3))	
				end
			else
				local r, g, b = self.oldglow:GetVertexColor()
				if g + b == 0 then
					if SettingsDB.Role == "Tank" then
						self.healthBar:SetStatusBarColor(0.2, 0.8, 0.2)
						self.healthBar.hpBackground:SetVertexColor(0, 0.3, 0)
					else
						self.healthBar:SetStatusBarColor(1, 0, 0)
						self.healthBar.hpBackground:SetVertexColor(0.3, 0, 0)
					end
				else
					self.healthBar:SetStatusBarColor(1, 1, 0)
					self.healthBar.hpBackground:SetVertexColor(0.3, 0.3, 0)
				end
			end
		else
			if not self.oldglow:IsShown() and not isEnemyPlayer then
				self.healthBar:SetStatusBarColor(self.r, self.g, self.b)
			elseif not isTarget then
				local r, g, b = self.oldglow:GetVertexColor()
				if g + b == 0 then
					self.healthBar:SetStatusBarColor(1, 0, 0)
				else
					self.healthBar:SetStatusBarColor(1, 1, 0)
				end
			end
			self.healthBar:SetStatusBarColor(self.r, self.g, self.b)
		end
 
		local minHealth, maxHealth = self.oldhealth:GetMinMaxValues()
		local valueHealth = self.oldhealth:GetValue()
		local d = math.floor((valueHealth / maxHealth) * 100)
		
		if SettingsCF["nameplate"].health_value == true then
			self.healthBar.percent:SetText(ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth/maxHealth)*100))))
			if isEnemyPlayer then
				if (d <= 45 and d >= 20) then
					self.healthBar.percent:SetTextColor(0.65, 0.63, 0.35)
				elseif(d < 20) then
					self.healthBar.percent:SetTextColor(0.69, 0.31, 0.31)
				else
					self.healthBar.percent:SetTextColor(1, 1, 1)
				end
			end
		end
		
		self.healthBar:ClearAllPoints()
		self.healthBar:SetPoint("CENTER", self.healthBar:GetParent(), 0, 25)
		self.healthBar:SetHeight(SettingsCF["nameplate"].height * UIParent:GetEffectiveScale())
		self.healthBar:SetWidth(SettingsCF["nameplate"].width * UIParent:GetEffectiveScale())
		
		if CheckTarget(self) then
			self.name:SetTextColor(1, 1, 0)
		else
			self.name:SetTextColor(1, 1, 1)
		end
		self.elapsed = 0
	end
end

local Abbrev = function(name)	
	local newname = (string.len(name) > 18) and string.gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name
	return SettingsDB.UTF(newname, 18, false)
end

local updatePlate = function(self)
	if not InCombatLockdown() then self:Show() end
	local r, g, b = self.healthBar:GetStatusBarColor()
	local newr, newg, newb
	if g + b == 0 then
		-- Hostile unit
		newr, newg, newb = 0.85, 0.27, 0.27
		self.healthBar:SetStatusBarColor(0.85, 0.27, 0.27)
	elseif r + b == 0 then
		-- Friendly unit
		newr, newg, newb = 0.33, 0.59, 0.33
		self.healthBar:SetStatusBarColor(0.33, 0.59, 0.33)
	elseif r + g == 0 then
		-- Friendly player
		newr, newg, newb = 0.31, 0.45, 0.63
		self.healthBar:SetStatusBarColor(0.31, 0.45, 0.63)
	elseif 2 - (r + g) < 0.05 and b == 0 then
		-- Neutral unit
		newr, newg, newb = 0.65, 0.63, 0.35
		self.healthBar:SetStatusBarColor(0.65, 0.63, 0.35)
	else
		-- Hostile player - class colored
		newr, newg, newb = r, g, b
	end
 
	self.r, self.g, self.b = newr, newg, newb
 
	self.healthBar:ClearAllPoints()
	self.healthBar:SetPoint("CENTER", self.healthBar:GetParent(), 0, 25)
	self.healthBar:SetHeight(SettingsCF["nameplate"].height * UIParent:GetEffectiveScale())
	self.healthBar:SetWidth(SettingsCF["nameplate"].width * UIParent:GetEffectiveScale())
	
	if SettingsCF["nameplate"].name_abbrev == true then
		self.name:SetText(Abbrev(self.oldname:GetText()))
	else
		self.name:SetText(self.oldname:GetText())
	end
 
	self.healthBar.hpBackground:SetVertexColor(self.r * 0.30, self.g * 0.30, self.b * 0.30)
	self.healthBar.hpBackground:SetAlpha(0.9)
 
	self.castBar:ClearAllPoints()
	self.castBar:SetPoint("TOP", self.healthBar, "BOTTOM", 0, -8)
	self.castBar:SetHeight(SettingsCF["nameplate"].height * UIParent:GetEffectiveScale())
	self.castBar:SetWidth(SettingsCF["nameplate"].width * UIParent:GetEffectiveScale())
 
	self.highlight:ClearAllPoints()
	self.highlight:SetAllPoints(self.healthBar)
 
	local level, elite, mylevel = tonumber(self.level:GetText()), self.elite:IsShown(), UnitLevel("player")
	self.level:ClearAllPoints()
	self.level:SetPoint("LEFT", self.name, "RIGHT", 2, 0)
	if self.boss:IsShown() then
		self.level:SetText("B")
		self.level:SetTextColor(0.8, 0.05, 0)
		self.level:Show()
	elseif not elite and level == mylevel then
		self.level:Hide()
	else
		self.level:SetText(level..(elite and "+" or ""))
	end
end

local fixCastbar = function(self)
	self.castbarOverlay:Hide()
	self:SetHeight(SettingsCF["nameplate"].height * UIParent:GetEffectiveScale())
	self:ClearAllPoints()
	self:SetPoint("TOP", self.healthBar, "BOTTOM", 0, -8)
end
 
local colorCastBar = function(self, shielded)
	if shielded then
		self:SetStatusBarColor(0.8, 0.05, 0.05)
		self.cbGlow:SetBackdropBorderColor(0.8, 0.05, 0.05)
		self.icGlow:SetBackdropBorderColor(0.8, 0.05, 0.05)
	else
		self.cbGlow:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
		self.icGlow:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
	end
end
 
local onSizeChanged = function(self)
	self.needFix = true
end
 
local onValueChanged = function(self, curValue)
	updateTime(self, curValue)
	if self.needFix then
		fixCastbar(self)
		self.needFix = nil
	end
end
 
local onShow = function(self)
	self.channeling  = UnitChannelInfo("target")
	fixCastbar(self)
	colorCastBar(self, self.shieldedRegion:IsShown())
end
 
local onHide = function(self)
	self.highlight:Hide()
end
 
local onEvent = function(self, event, unit)
	if unit == "target" then
		if self:IsShown() then
			colorCastBar(self, event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
		end
	end
end
 
local createPlate = function(frame)
	if frame.done then return end
 
	frame.nameplate = true
 
	frame.healthBar, frame.castBar = frame:GetChildren()
	local healthBar, castBar = frame.healthBar, frame.castBar
	local glowRegion, overlayRegion, castbarOverlay, shieldedRegion, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion = frame:GetRegions()
	frame.oldhealth = healthBar
 
	frame.oldname = nameTextRegion
	nameTextRegion:Hide()
	local offset = UIParent:GetEffectiveScale()
	
	local newNameRegion = frame:CreateFontString()
	newNameRegion:SetPoint("BOTTOM", healthBar, "TOP", 0, 4)
	newNameRegion:SetFont(SettingsCF["media"].pixel_font, SettingsCF["nameplate"].font_size * offset, SettingsCF["media"].pixel_font_style)
	newNameRegion:SetTextColor(1, 1, 1)
	if SettingsCF["nameplate"].name_abbrev ~= true then
		newNameRegion:SetWidth(SettingsCF["nameplate"].width * offset)
		newNameRegion:SetHeight(SettingsCF["nameplate"].font_size * offset)
	end
	frame.name = newNameRegion
 
	frame.level = levelTextRegion
	levelTextRegion:SetFont(SettingsCF["media"].pixel_font, SettingsCF["nameplate"].font_size * offset, SettingsCF["media"].pixel_font_style)
	levelTextRegion:SetShadowOffset(0, 0)
	
	healthBar:SetStatusBarTexture(SettingsCF["media"].texture)
 
	healthBar.hpBackground = healthBar:CreateTexture(nil, "BORDER")
	healthBar.hpBackground:SetAllPoints(healthBar)
	healthBar.hpBackground:SetTexture(SettingsCF["media"].texture)
	healthBar.hpBackground:SetVertexColor(0.15, 0.15, 0.15)
 
	healthBar.hpGlow = CreateFrame("Frame", nil, healthBar)
	healthBar.hpGlow:SetBackdrop({
		bgFile = SettingsCF["media"].blank, 
		edgeFile = SettingsCF["media"].blank, 
		tile = false, tileSize = 0, edgeSize = 1 * offset, 
		insets = { left = -1 * offset, right = -1 * offset, top = -1 * offset, bottom = -1 * offset}
	})
	healthBar.hpGlow:SetBackdropColor(unpack(SettingsCF["media"].backdrop_color))
	healthBar.hpGlow:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
	healthBar.hpGlow:SetPoint("TOPLEFT", healthBar, "TOPLEFT", -2 * offset, 2 * offset)
	healthBar.hpGlow:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", 2 * offset, -2 * offset)
	healthBar.hpGlow:SetFrameLevel(healthBar:GetFrameLevel() -1 > 0 and healthBar:GetFrameLevel() -1 or 0)
 
	if SettingsCF["nameplate"].health_value == true then
		healthBar.percent = healthBar:CreateFontString(nil, "OVERLAY")
		healthBar.percent:SetFont(SettingsCF["media"].pixel_font, SettingsCF["nameplate"].font_size * offset, SettingsCF["media"].pixel_font_style)
		healthBar.percent:SetPoint("RIGHT", healthBar, "RIGHT", 0, 0)
		healthBar.percent:SetTextColor(1, 1, 1)
		healthBar.percent:SetJustifyH("RIGHT")
	end
	castBar.castbarOverlay = castbarOverlay
	castBar.healthBar = healthBar
	castBar.shieldedRegion = shieldedRegion
	castBar:SetStatusBarTexture(SettingsCF["media"].texture)
 
	castBar:HookScript("OnShow", onShow)
	castBar:HookScript("OnSizeChanged", onSizeChanged)
	castBar:HookScript("OnValueChanged", onValueChanged)
	castBar:HookScript("OnEvent", onEvent)
	castBar:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")
	castBar:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
 
	castBar.time = castBar:CreateFontString(nil, "ARTWORK")
	castBar.time:SetFont(SettingsCF["media"].pixel_font, SettingsCF["nameplate"].font_size * offset, SettingsCF["media"].pixel_font_style)
	castBar.time:SetPoint("RIGHT", castBar, "RIGHT", 0, 0)
	castBar.time:SetJustifyH("RIGHT")
 
	if SettingsCF["nameplate"].show_castbar_name == true then
		castBar.castName = castBar:CreateFontString(nil, "OVERLAY")
		castBar.castName:SetFont(SettingsCF["media"].pixel_font, SettingsCF["nameplate"].font_size * offset, SettingsCF["media"].pixel_font_style)
		castBar.castName:SetHeight(SettingsCF["nameplate"].height)
		castBar.castName:SetWidth(SettingsCF["nameplate"].width - 27)
		castBar.castName:SetPoint("LEFT", castBar, "LEFT", 2, 0)
		castBar.castName:SetTextColor(1, 1, 1)
		castBar.castName:SetJustifyH("LEFT")
	end
 
	castBar.cbBackground = castBar:CreateTexture(nil, "BACKGROUND")
	castBar.cbBackground:SetAllPoints(castBar)
	castBar.cbBackground:SetTexture(SettingsCF["media"].texture)
	castBar.cbBackground:SetVertexColor(0.15, 0.15, 0.15)
 
	castBar.cbGlow = CreateFrame("Frame", nil, castBar)
	castBar.cbGlow:SetBackdrop({
		bgFile = SettingsCF["media"].blank, 
		edgeFile = SettingsCF["media"].blank, 
		tile = false, tileSize = 0, edgeSize = 1 * offset, 
		insets = { left = -1 * offset, right = -1 * offset, top = -1 * offset, bottom = -1 * offset}
	})
	castBar.cbGlow:SetBackdropColor(unpack(SettingsCF["media"].backdrop_color))
	castBar.cbGlow:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
	castBar.cbGlow:SetPoint("TOPLEFT", castBar, "TOPLEFT", -2 * offset, 2 * offset)
	castBar.cbGlow:SetPoint("BOTTOMRIGHT", castBar, "BOTTOMRIGHT", 2 * offset, -2 * offset)
	castBar.cbGlow:SetFrameLevel(castBar:GetFrameLevel() -1 > 0 and castBar:GetFrameLevel() -1 or 0)
 
	castBar.Holder = CreateFrame("Frame", nil, castBar)
	castBar.Holder:SetFrameLevel(castBar.Holder:GetFrameLevel() + 1)
	castBar.Holder:SetAllPoints()
 
	-- Some frame strata dancing
	castBar.Hold = CreateFrame("Frame", nil, healthBar)
	castBar.Hold:SetPoint("TOPLEFT", healthBar, "TOPLEFT", 0, 0)
	castBar.Hold:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", 0, 0)
	castBar.Hold:SetFrameLevel(10)
	castBar.Hold:SetFrameStrata("MEDIUM")	
 
	if SettingsCF["nameplate"].class_icons == true then
		local cIconTex = castBar.Hold:CreateTexture(nil, "OVERLAY")
		cIconTex:SetPoint("TOPRIGHT", healthBar, "TOPLEFT", -8, 2)
		cIconTex:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
		cIconTex:SetHeight((SettingsCF["nameplate"].height * 2) + 11)
		cIconTex:SetWidth((SettingsCF["nameplate"].height * 2) + 11)
		frame.icon = cIconTex	
 
		frame.icon.Glow = CreateFrame("Frame", nil, frame)
		frame.icon.Glow:SetBackdrop({
			bgFile = SettingsCF["media"].blank, 
			edgeFile = SettingsCF["media"].blank, 
			tile = false, tileSize = 0, edgeSize = 1 * offset, 
			insets = {left = -1 * offset, right = -1 * offset, top = -1 * offset, bottom = -1 * offset}
		})
		frame.icon.Glow:SetBackdropColor(unpack(SettingsCF["media"].backdrop_color))
		frame.icon.Glow:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
		frame.icon.Glow:SetPoint("TOPLEFT", frame.icon, "TOPLEFT", 0, 0)
		frame.icon.Glow:SetPoint("BOTTOMRIGHT", frame.icon, "BOTTOMRIGHT", 0, 0)
		frame.icon.Glow:SetFrameLevel(healthBar:GetFrameLevel() -1 > 0 and healthBar:GetFrameLevel() -1 or 0)
		frame.icon.Glow:Hide()
	end
 
	spellIconRegion:ClearAllPoints()
	spellIconRegion:SetParent(castBar)
	spellIconRegion:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	spellIconRegion:SetPoint("TOPLEFT", healthBar, "TOPRIGHT", 10, 0)
	spellIconRegion:SetSize((SettingsCF["nameplate"].height * 2) + 7, (SettingsCF["nameplate"].height * 2) + 7)
 
	spellIconRegion.IconBackdrop = CreateFrame("Frame", nil, castBar)
	spellIconRegion.IconBackdrop:SetBackdrop({
		bgFile = SettingsCF["media"].blank, 
		edgeFile = SettingsCF["media"].blank, 
		tile = false, tileSize = 0, edgeSize = 1 * offset, 
		insets = {left = -1 * offset, right = -1 * offset, top = -1 * offset, bottom = -1 * offset}
	})
	spellIconRegion.IconBackdrop:SetBackdropColor(unpack(SettingsCF["media"].backdrop_color))
	spellIconRegion.IconBackdrop:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
	spellIconRegion.IconBackdrop:SetPoint("TOPLEFT", spellIconRegion, "TOPLEFT", -2, 2)
	spellIconRegion.IconBackdrop:SetPoint("BOTTOMRIGHT", spellIconRegion, "BOTTOMRIGHT", 2, -2)
	spellIconRegion.IconBackdrop:SetFrameLevel(castBar:GetFrameLevel() -1 > 0 and castBar:GetFrameLevel() -1 or 0)
 
	highlightRegion:SetTexture(SettingsCF["media"].texture)
	highlightRegion:SetVertexColor(0.25, 0.25, 0.25)
	frame.highlight = highlightRegion
 
	raidIconRegion:ClearAllPoints()
	raidIconRegion:SetPoint("CENTER", healthBar, "CENTER", 0, 35)
	raidIconRegion:SetSize(25, 25)
 
	frame.oldglow = glowRegion
	frame.elite = stateIconRegion
	frame.boss = bossIconRegion
	castBar.icGlow = spellIconRegion.IconBackdrop
 
	frame.done = true
 
	glowRegion:SetTexture(nil)
	overlayRegion:SetTexture(nil)
	shieldedRegion:SetTexture(nil)
	castbarOverlay:SetTexture(nil)
	stateIconRegion:SetTexture(nil)
	bossIconRegion:SetTexture(nil)
 
	updatePlate(frame)
	frame:SetScript("OnShow", updatePlate)
	frame:SetScript("OnHide", onHide)
 
	frame.elapsed = 0
	frame:SetScript("OnUpdate", threatUpdate)
 
	if SettingsCF["nameplate"].class_icons == true then
		frame:HookScript("OnUpdate", UpdateClass)
	end
end
 
-- Update class function
if SettingsCF["nameplate"].class_icons == true then
	function UpdateClass(frame)
		local r, g, b = frame.healthBar:GetStatusBarColor()
		local r, g, b = floor(r*100+.5)/100, floor(g*100+.5)/100, floor(b*100+.5)/100
		local classname = ""
		local hasclass = 0
		for class, color in pairs(RAID_CLASS_COLORS) do
			if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
				classname = class
			end
		end
		if (classname) then
			texcoord = CLASS_BUTTONS[classname]
			if texcoord then
				hasclass = 1
			else
				texcoord = {0.5, 0.75, 0.5, 0.75}
				hasclass = 0
			end
		else
			texcoord = {0.5, 0.75, 0.5, 0.75}
			hasclass = 0
		end
		frame.icon:SetTexCoord(texcoord[1],texcoord[2],texcoord[3],texcoord[4])
		if hasclass == 1 then
			frame.icon.Glow:Show()
		else
			frame.icon.Glow:Hide()
		end
	end
end
 
local numKids = 0
caelNamePlates:SetScript("OnUpdate", function(self, elapsed)
	local newNumKids = WorldFrame:GetNumChildren()
	if newNumKids ~= numKids then
		for i = numKids + 1, newNumKids do
			local frame = select(i, WorldFrame:GetChildren())

			if isValidFrame(frame) then
				createPlate(frame)
			end
		end
		numKids = newNumKids
	end
end)

if SettingsCF["nameplate"].combat == true then
	caelNamePlates:RegisterEvent("PLAYER_REGEN_ENABLED")
	function caelNamePlates:PLAYER_REGEN_ENABLED()
		SetCVar("nameplateShowEnemies", 0)
	end

	caelNamePlates:RegisterEvent("PLAYER_REGEN_DISABLED")
	function caelNamePlates.PLAYER_REGEN_DISABLED()
		SetCVar("nameplateShowEnemies", 1)
	end
end