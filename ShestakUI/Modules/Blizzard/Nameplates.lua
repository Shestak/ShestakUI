local T, C, L = unpack(select(2, ...))
if not C.nameplate.enable == true then return end

----------------------------------------------------------------------------------------
--	Based on caelNamePlates(by Caellian)
----------------------------------------------------------------------------------------
if T.patch < string.format("%s", "4.1.0") then
local caelNamePlates = CreateFrame("Frame", nil, UIParent)
caelNamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
SetCVar("bloatthreat", 0)
SetCVar("bloattest", 0)
SetCVar("bloatnameplates", 0)
if C.nameplate.overlap == true then
	SetCVar("spreadnameplates", 0)
else
	SetCVar("spreadnameplates", 1)
end
 
local select = select
local goodR, goodG, goodB = unpack(C.nameplate.good_color)
local nearR, nearG, nearB = unpack(C.nameplate.near_color)
local badR, badG, badB = unpack(C.nameplate.bad_color)
local offset = T.mult * C.general.uiscale

local isValidFrame = function(frame)
	if frame:GetName() then	return end
	overlayRegion = select(2, frame:GetRegions())
	return overlayRegion and overlayRegion:GetObjectType() == "Texture" and overlayRegion:GetTexture() == "Interface\\Tooltips\\Nameplate-Border"
end
 
local updateTime = function(self, curValue)
	local minValue, maxValue = self:GetMinMaxValues()
	if self.channeling then
		self.time:SetFormattedText("%.1f ", curValue)
		if C.nameplate.show_castbar_name == true then
			self.castName:SetText(select(1, (UnitChannelInfo("target"))))
		end
	else
		self.time:SetFormattedText("%.1f ", maxValue - curValue)
		if C.nameplate.show_castbar_name == true then
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
		
		if C.nameplate.enhance_threat == true then
			if not self.oldglow:IsShown() then
				if InCombatLockdown() and not isEnemyPlayer then
					if T.Role == "Tank" then
						self.healthBar:SetStatusBarColor(badR, badG, badB)
						self.healthBar.hpBackground:SetVertexColor(badR, badG, badB, 0.3)
					else
						self.healthBar:SetStatusBarColor(goodR, goodG, goodB)
						self.healthBar.hpBackground:SetVertexColor(goodR, goodG, goodB, 0.3)
					end
				else
					self.healthBar:SetStatusBarColor(self.r, self.g, self.b)		
					self.healthBar.hpBackground:SetVertexColor(self.r, self.g, self.b, 0.3)	
				end
			else
				local r, g, b = self.oldglow:GetVertexColor()
				if g + b == 0 then
					if T.Role == "Tank" then
						self.healthBar:SetStatusBarColor(goodR, goodG, goodB)
						self.healthBar.hpBackground:SetVertexColor(goodR, goodG, goodB, 0.3)
					else
						self.healthBar:SetStatusBarColor(badR, badG, badB)
						self.healthBar.hpBackground:SetVertexColor(badR, badG, badB, 0.3)
					end
				else
					self.healthBar:SetStatusBarColor(nearR, nearG, nearB)
					self.healthBar.hpBackground:SetVertexColor(nearR, nearG, nearB, 0.3)
				end
			end
		else
			if not self.oldglow:IsShown() and not isEnemyPlayer then
				self.healthBar:SetStatusBarColor(self.r, self.g, self.b)
			elseif not isTarget then
				local r, g, b = self.oldglow:GetVertexColor()
				if g + b == 0 then
					self.healthBar:SetStatusBarColor(badR, badG, badB)
				else
					self.healthBar:SetStatusBarColor(nearR, nearG, nearB)
				end
			end
			self.healthBar:SetStatusBarColor(self.r, self.g, self.b)
		end
 
		local minHealth, maxHealth = self.oldhealth:GetMinMaxValues()
		local valueHealth = self.oldhealth:GetValue()
		local d = math.floor((valueHealth / maxHealth) * 100)
		
		if C.nameplate.health_value == true then
			self.healthBar.percent:SetText(T.ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth/maxHealth)*100))))
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
		self.healthBar:SetPoint("CENTER", self.healthBar:GetParent(), 0, 10)
		self.healthBar:SetHeight(C.nameplate.height * offset)
		self.healthBar:SetWidth(C.nameplate.width * offset)
		
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
	return T.UTF(newname, 18, false)
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
	self.healthBar:SetPoint("CENTER", self.healthBar:GetParent(), 0, 10)
	self.healthBar:SetHeight(C.nameplate.height * offset)
	self.healthBar:SetWidth(C.nameplate.width * offset)
	
	if C.nameplate.name_abbrev == true then
		self.name:SetText(Abbrev(self.oldname:GetText()))
	else
		self.name:SetText(self.oldname:GetText())
	end
 
	self.healthBar.hpBackground:SetVertexColor(self.r, self.g, self.b, 0.30)
 
	self.castBar:ClearAllPoints()
	self.castBar:SetPoint("TOP", self.healthBar, "BOTTOM", 0, -8)
	self.castBar:SetHeight(C.nameplate.height * offset)
	self.castBar:SetWidth(C.nameplate.width * offset)
 
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
	self:SetHeight(C.nameplate.height * offset)
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", self.healthBar, "BOTTOMLEFT", 0, -8)
	self:SetPoint("BOTTOMRIGHT", self.healthBar, "BOTTOMRIGHT", 0, -C.nameplate.height-8)
end
 
local colorCastBar = function(self, shielded)
	if shielded then
		self:SetStatusBarColor(0.8, 0.05, 0.05)
		self.cbGlow:SetBackdropBorderColor(0.8, 0.05, 0.05)
		self.icGlow:SetBackdropBorderColor(0.8, 0.05, 0.05)
	else
		self.cbGlow:SetBackdropBorderColor(unpack(C.media.border_color))
		self.icGlow:SetBackdropBorderColor(unpack(C.media.border_color))
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
	
	local backdrop = {
		bgFile = C.media.blank, 
		edgeFile = C.media.blank, 
		tile = false, tileSize = 0, edgeSize = 1 * offset, 
		insets = { left = -1 * offset, right = -1 * offset, top = -1 * offset, bottom = -1 * offset}
	}
	
	local newNameRegion = frame:CreateFontString()
	newNameRegion:SetPoint("BOTTOM", healthBar, "TOP", 0, 4)
	newNameRegion:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * offset, C.font.nameplates_font_style)
	newNameRegion:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	newNameRegion:SetTextColor(1, 1, 1)
	if C.nameplate.name_abbrev ~= true then
		newNameRegion:SetWidth(C.nameplate.width * offset)
		newNameRegion:SetHeight(C.font.nameplates_font_size * offset)
	end
	frame.name = newNameRegion
 
	frame.level = levelTextRegion
	levelTextRegion:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * offset, C.font.nameplates_font_style)
	levelTextRegion:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	
	healthBar:SetStatusBarTexture(C.media.texture)
 
	healthBar.hpBackground = healthBar:CreateTexture(nil, "BORDER")
	healthBar.hpBackground:SetAllPoints(healthBar)
	healthBar.hpBackground:SetTexture(C.media.texture)
	healthBar.hpBackground:SetVertexColor(0.15, 0.15, 0.15)
 
	healthBar.hpGlow = CreateFrame("Frame", nil, healthBar)
	healthBar.hpGlow:SetBackdrop(backdrop)
	healthBar.hpGlow:SetBackdropColor(unpack(C.media.backdrop_color))
	healthBar.hpGlow:SetBackdropBorderColor(unpack(C.media.border_color))
	healthBar.hpGlow:SetPoint("TOPLEFT", healthBar, "TOPLEFT", -2 * offset, 2 * offset)
	healthBar.hpGlow:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", 2 * offset, -2 * offset)
	healthBar.hpGlow:SetFrameLevel(healthBar:GetFrameLevel() -1 > 0 and healthBar:GetFrameLevel() -1 or 0)
 
	if C.nameplate.health_value == true then
		healthBar.percent = healthBar:CreateFontString(nil, "OVERLAY")
		healthBar.percent:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * offset, C.font.nameplates_font_style)
		healthBar.percent:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		healthBar.percent:SetPoint("RIGHT", healthBar, "RIGHT", 0, 0)
		healthBar.percent:SetTextColor(1, 1, 1)
		healthBar.percent:SetJustifyH("RIGHT")
	end
	castBar.castbarOverlay = castbarOverlay
	castBar.healthBar = healthBar
	castBar.shieldedRegion = shieldedRegion
	castBar:SetStatusBarTexture(C.media.texture)
 
	castBar:HookScript("OnShow", onShow)
	castBar:HookScript("OnSizeChanged", onSizeChanged)
	castBar:HookScript("OnValueChanged", onValueChanged)
	castBar:HookScript("OnEvent", onEvent)
	castBar:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")
	castBar:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
 
	castBar.time = castBar:CreateFontString(nil, "ARTWORK")
	castBar.time:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * offset, C.font.nameplates_font_style)
	castBar.time:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	castBar.time:SetPoint("RIGHT", castBar, "RIGHT", 0, 0)
	castBar.time:SetJustifyH("RIGHT")
 
	if C.nameplate.show_castbar_name == true then
		castBar.castName = castBar:CreateFontString(nil, "OVERLAY")
		castBar.castName:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * offset, C.font.nameplates_font_style)
		castBar.castName:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		castBar.castName:SetHeight(C.nameplate.height)
		castBar.castName:SetWidth(C.nameplate.width - 27)
		castBar.castName:SetPoint("LEFT", castBar, "LEFT", 2, 0)
		castBar.castName:SetTextColor(1, 1, 1)
		castBar.castName:SetJustifyH("LEFT")
	end
 
	castBar.cbBackground = castBar:CreateTexture(nil, "BACKGROUND")
	castBar.cbBackground:SetAllPoints(castBar)
	castBar.cbBackground:SetTexture(C.media.texture)
	castBar.cbBackground:SetVertexColor(0.15, 0.15, 0.15)
 
	castBar.cbGlow = CreateFrame("Frame", nil, castBar)
	castBar.cbGlow:SetBackdrop(backdrop)
	castBar.cbGlow:SetBackdropColor(unpack(C.media.backdrop_color))
	castBar.cbGlow:SetBackdropBorderColor(unpack(C.media.border_color))
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
 
	if C.nameplate.class_icons == true then
		local cIconTex = castBar.Hold:CreateTexture(nil, "OVERLAY")
		cIconTex:SetPoint("TOPRIGHT", healthBar, "TOPLEFT", -8, 2)
		cIconTex:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
		cIconTex:SetHeight((C.nameplate.height * 2) + 11)
		cIconTex:SetWidth((C.nameplate.height * 2) + 11)
		frame.icon = cIconTex	
 
		frame.icon.Glow = CreateFrame("Frame", nil, frame)
		frame.icon.Glow:SetBackdrop(backdrop)
		frame.icon.Glow:SetBackdropColor(unpack(C.media.backdrop_color))
		frame.icon.Glow:SetBackdropBorderColor(unpack(C.media.border_color))
		frame.icon.Glow:SetPoint("TOPLEFT", frame.icon, "TOPLEFT", 0, 0)
		frame.icon.Glow:SetPoint("BOTTOMRIGHT", frame.icon, "BOTTOMRIGHT", 0, 0)
		frame.icon.Glow:SetFrameLevel(healthBar:GetFrameLevel() -1 > 0 and healthBar:GetFrameLevel() -1 or 0)
		frame.icon.Glow:Hide()
	end
 
	spellIconRegion:ClearAllPoints()
	spellIconRegion:SetParent(castBar)
	spellIconRegion:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	spellIconRegion:SetPoint("TOPLEFT", healthBar, "TOPRIGHT", 10, 0)
	spellIconRegion:SetSize((C.nameplate.height * 2) + 7, (C.nameplate.height * 2) + 7)
 
	spellIconRegion.IconBackdrop = CreateFrame("Frame", nil, castBar)
	spellIconRegion.IconBackdrop:SetBackdrop(backdrop)
	spellIconRegion.IconBackdrop:SetBackdropColor(unpack(C.media.backdrop_color))
	spellIconRegion.IconBackdrop:SetBackdropBorderColor(unpack(C.media.border_color))
	spellIconRegion.IconBackdrop:SetPoint("TOPLEFT", spellIconRegion, "TOPLEFT", -2, 2)
	spellIconRegion.IconBackdrop:SetPoint("BOTTOMRIGHT", spellIconRegion, "BOTTOMRIGHT", 2, -2)
	spellIconRegion.IconBackdrop:SetFrameLevel(castBar:GetFrameLevel() -1 > 0 and castBar:GetFrameLevel() -1 or 0)
 
	highlightRegion:SetTexture(C.media.texture)
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
 
	if C.nameplate.class_icons == true then
		frame:HookScript("OnUpdate", UpdateClass)
	end
end
 
-- Update class function
if C.nameplate.class_icons == true then
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

if C.nameplate.combat == true then
	caelNamePlates:RegisterEvent("PLAYER_REGEN_ENABLED")
	function caelNamePlates:PLAYER_REGEN_ENABLED()
		SetCVar("nameplateShowEnemies", 0)
	end

	caelNamePlates:RegisterEvent("PLAYER_REGEN_DISABLED")
	function caelNamePlates.PLAYER_REGEN_DISABLED()
		SetCVar("nameplateShowEnemies", 1)
	end
end
end

if T.patch < string.format("%s", "4.1.0") then return end
----------------------------------------------------------------------------------------
--	Based on dNameplates(by Dawn, editor Elv22)
----------------------------------------------------------------------------------------
local numChildren = -1
local frames = {}
local noscalemult = T.mult * C.general.uiscale

local NamePlates = CreateFrame("Frame", nil, UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

local Abbrev = function(name)	
	local newname = (string.len(name) > 18) and string.gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name
	return T.UTF(newname, 18, false)
end

local function QueueObject(parent, object)
	parent.queue = parent.queue or {}
	parent.queue[object] = true
end

local function HideObjects(parent)
	for object in pairs(parent.queue) do
		if(object:GetObjectType() == "Texture") then
			object:SetTexture(nil)
			object.SetTexture = T.dummy
		elseif (object:GetObjectType() == "FontString") then
			object.ClearAllPoints = T.dummy
			object.SetFont = T.dummy
			object.SetPoint = T.dummy
			object:Hide()
			object.Show = T.dummy
			object.SetText = T.dummy
			object.SetShadowOffset = T.dummy
		else
			object:Hide()
			object.Show = T.dummy
		end
	end
end

-- Create a fake backdrop frame using textures
local function CreateVirtualFrame(parent, point)
	if point == nil then point = parent end
	
	if point.backdrop then return end
	parent.backdrop = parent:CreateTexture(nil, "BORDER")
	parent.backdrop:SetDrawLayer("BORDER", -8)
	parent.backdrop:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult*3, noscalemult*3)
	parent.backdrop:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", noscalemult*3, -noscalemult*3)
	parent.backdrop:SetTexture(unpack(C.media.backdrop_color))

	parent.bordertop = parent:CreateTexture(nil, "BORDER")
	parent.bordertop:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult*2, noscalemult*2)
	parent.bordertop:SetPoint("TOPRIGHT", point, "TOPRIGHT", noscalemult*2, noscalemult*2)
	parent.bordertop:SetHeight(noscalemult)
	parent.bordertop:SetTexture(unpack(C.media.border_color))	
	parent.bordertop:SetDrawLayer("BORDER", -7)
	
	parent.borderbottom = parent:CreateTexture(nil, "BORDER")
	parent.borderbottom:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", -noscalemult*2, -noscalemult*2)
	parent.borderbottom:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", noscalemult*2, -noscalemult*2)
	parent.borderbottom:SetHeight(noscalemult)
	parent.borderbottom:SetTexture(unpack(C.media.border_color))	
	parent.borderbottom:SetDrawLayer("BORDER", -7)
	
	parent.borderleft = parent:CreateTexture(nil, "BORDER")
	parent.borderleft:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult*2, noscalemult*2)
	parent.borderleft:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", noscalemult*2, -noscalemult*2)
	parent.borderleft:SetWidth(noscalemult)
	parent.borderleft:SetTexture(unpack(C.media.border_color))	
	parent.borderleft:SetDrawLayer("BORDER", -7)
	
	parent.borderright = parent:CreateTexture(nil, "BORDER")
	parent.borderright:SetPoint("TOPRIGHT", point, "TOPRIGHT", noscalemult*2, noscalemult*2)
	parent.borderright:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", -noscalemult*2, -noscalemult*2)
	parent.borderright:SetWidth(noscalemult)
	parent.borderright:SetTexture(unpack(C.media.border_color))	
	parent.borderright:SetDrawLayer("BORDER", -7)	
end

local function SetVirtualBorder(parent, r, g, b)
	parent.bordertop:SetTexture(r, g, b)
	parent.borderbottom:SetTexture(r, g, b)
	parent.borderleft:SetTexture(r, g, b)
	parent.borderright:SetTexture(r, g, b)
end

-- Color the castbar depending on if we can interrupt or not
local function UpdateCastbar(frame)
	frame:ClearAllPoints()
	frame:SetSize(C.nameplate.width * noscalemult, C.nameplate.height * noscalemult)
	frame:SetPoint("TOP", frame:GetParent().hp, "BOTTOM", 0, -8)
	frame:GetStatusBarTexture():SetHorizTile(true)
	if(frame.shield:IsShown()) then
		frame:SetStatusBarColor(0.78, 0.25, 0.25, 1)
	end
end	

-- Determine whether or not the cast is Channelled or a Regular cast so we can grab the proper Cast Name
local function UpdateCastText(frame, curValue)
	local minValue, maxValue = frame:GetMinMaxValues()
	
	if UnitChannelInfo("target") then
		frame.time:SetFormattedText("%.1f ", curValue)
		if C.nameplate.show_castbar_name == true then
			frame.name:SetText(select(1, (UnitChannelInfo("target"))))
		end
	end
	
	if UnitCastingInfo("target") then
		frame.time:SetFormattedText("%.1f ", maxValue - curValue)
		if C.nameplate.show_castbar_name == true then
			frame.name:SetText(select(1, (UnitCastingInfo("target"))))
		end
	end
end

-- Sometimes castbar likes to randomly resize
local OnValueChanged = function(self, curValue)
	UpdateCastText(self, curValue)
	if self.needFix then
		UpdateCastbar(self)
		self.needFix = nil
	end
end

-- Sometimes castbar likes to randomly resize
local OnSizeChanged = function(self)
	self.needFix = true
end

-- We need to reset everything when a nameplate it hidden
local function OnHide(frame)
	frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
	frame.overlay:Hide()
	frame.cb:Hide()
	frame.unit = nil
	frame.guid = nil
	frame.hasClass = nil
	frame.isFriendly = nil
	frame.hp.rcolor = nil
	frame.hp.gcolor = nil
	frame.hp.bcolor = nil
	if frame.icons then
		for _,icon in ipairs(frame.icons) do
			icon:Hide()
		end
	end	
	
	frame:SetScript("OnUpdate",nil)
end

-- Color Nameplate
local function Colorize(frame)
	local r, g, b = frame.hp:GetStatusBarColor()
	
	for class, color in pairs(RAID_CLASS_COLORS) do
		local r, g, b = floor(r * 100 + 0.5) / 100, floor(g * 100 + 0.5) / 100, floor(b * 100 + 0.5) / 100
		if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
			frame.hasClass = true
			frame.isFriendly = false
			frame.hp:SetStatusBarColor(unpack(T.oUF_colors.class[class]))
			return
		end
	end
	
	if g + b == 0 then	-- Hostile
		r, g, b = unpack(T.oUF_colors.reaction[1])
		frame.isFriendly = false
	elseif r + b == 0 then	-- Friendly npc
		r, g, b = unpack(T.oUF_colors.power["MANA"])
		frame.isFriendly = true
	elseif r + g > 1.95 then	-- Neutral
		r, g, b = unpack(T.oUF_colors.reaction[4])
		frame.isFriendly = false
	elseif r + g == 0 then	-- Friendly player
		r, g, b = unpack(T.oUF_colors.reaction[5])
		frame.isFriendly = true
	else	-- Enemy player
		frame.isFriendly = false
	end
	frame.hasClass = false
	
	frame.hp:SetStatusBarColor(r, g, b)
end

-- HealthBar OnShow, use this to set variables for the nameplate
local function UpdateObjects(frame)
	local frame = frame:GetParent()
	
	local r, g, b = frame.hp:GetStatusBarColor()

	-- Have to reposition this here so it doesnt resize after being hidden
	frame.hp:ClearAllPoints()
	frame.hp:SetSize(C.nameplate.width * noscalemult, C.nameplate.height * noscalemult)	
	frame.hp:SetPoint("TOP", frame, "TOP", 0, -15)
	frame.hp:GetStatusBarTexture():SetHorizTile(true)
	
	-- Colorize Plate
	Colorize(frame)
	frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor = frame.hp:GetStatusBarColor()
	frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
	SetVirtualBorder(frame.hp, unpack(C.media.border_color))
	if C.nameplate.enhance_threat == true then
		frame.hp.name:SetTextColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
	end
	
	-- Set the name text
	if C.nameplate.name_abbrev == true then
		frame.hp.name:SetText(Abbrev(frame.hp.oldname:GetText()))
	else
		frame.hp.name:SetText(frame.hp.oldname:GetText())
	end
	
	-- Setup level text
	local level, elite, mylevel = tonumber(frame.hp.oldlevel:GetText()), frame.hp.elite:IsShown(), UnitLevel("player")
	frame.hp.level:ClearAllPoints()
	frame.hp.level:SetPoint("RIGHT", frame.hp, "LEFT", -2, 0)
	
	frame.hp.level:SetTextColor(frame.hp.oldlevel:GetTextColor())
	if frame.hp.boss:IsShown() then
		frame.hp.level:SetText("??")
		frame.hp.level:SetTextColor(0.8, 0.05, 0)
		frame.hp.level:Show()
	elseif not elite and level == mylevel then
		frame.hp.level:Hide()
	else
		frame.hp.level:SetText(level..(elite and "+" or ""))
		frame.hp.level:Show()
	end
	
	frame.overlay:ClearAllPoints()
	frame.overlay:SetAllPoints(frame.hp)

	HideObjects(frame)
end

-- This is where we create most 'Static' objects for the nameplate
local function SkinObjects(frame)
	local hp, cb = frame:GetChildren()
	local threat, hpborder, overlay, oldname, oldlevel, bossicon, raidicon, elite = frame:GetRegions()
	local _, cbborder, cbshield, cbicon = cb:GetRegions()

	-- Health Bar
	frame.healthOriginal = hp
	hp:SetFrameLevel(1)
	hp:SetStatusBarTexture(C.media.texture)
	CreateVirtualFrame(hp)
	
	-- Create Level
	hp.level = hp:CreateFontString(nil, "OVERLAY")
	hp.level:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * noscalemult, C.font.nameplates_font_style)
	hp.level:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	hp.level:SetTextColor(1, 1, 1)
	hp.oldlevel = oldlevel
	hp.boss = bossicon
	hp.elite = elite
	
	-- Create Health Text
	if C.nameplate.health_value == true then
		hp.value = hp:CreateFontString(nil, "OVERLAY")	
		hp.value:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * noscalemult, C.font.nameplates_font_style)
		hp.value:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		hp.value:SetPoint("RIGHT", hp, "RIGHT", 0, 0)
		hp.value:SetTextColor(1, 1, 1)
	end
	
	-- Create Name Text
	hp.name = hp:CreateFontString(nil, "OVERLAY")
	hp.name:SetPoint("BOTTOMLEFT", hp, "TOPLEFT", -3, 4)
	hp.name:SetPoint("BOTTOMRIGHT", hp, "TOPRIGHT", 3, 4)
	hp.name:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * noscalemult, C.font.nameplates_font_style)
	hp.name:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	hp.oldname = oldname

	hp.hpbg = hp:CreateTexture(nil, "BORDER")
	hp.hpbg:SetAllPoints(hp)
	hp.hpbg:SetTexture(1, 1, 1, 0.25)
	
	hp:HookScript("OnShow", UpdateObjects)
	frame.hp = hp
	
	-- Create Cast Bar
	cb:SetFrameLevel(1)
	cb:SetStatusBarTexture(C.media.texture)
	CreateVirtualFrame(cb)
	
	cb.cbbg = cb:CreateTexture(nil, "BORDER")
	cb.cbbg:SetAllPoints(cb)
	cb.cbbg:SetTexture(0.75, 0.75, 0.25, 0.15)
	
	-- Create Cast Time Text
	cb.time = cb:CreateFontString(nil, "ARTWORK")
	cb.time:SetPoint("RIGHT", cb, "RIGHT", 3, 0)
	cb.time:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * noscalemult, C.font.nameplates_font_style)
	cb.time:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	cb.time:SetTextColor(1, 1, 1)

	-- Create Cast Name Text
	if C.nameplate.show_castbar_name == true then
		cb.name = cb:CreateFontString(nil, "ARTWORK")
		cb.name:SetPoint("LEFT", cb, "LEFT", 3, 0)
		cb.name:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * noscalemult, C.font.nameplates_font_style)
		cb.name:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		cb.name:SetTextColor(1, 1, 1)
	end
	
	-- Create CastBar Icon
	cbicon:ClearAllPoints()
	cbicon:SetPoint("TOPLEFT", hp, "TOPRIGHT", 8, 0)
	cbicon:SetSize((C.nameplate.height * 2) + 8, (C.nameplate.height * 2) + 8)
	cbicon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	cbicon:SetDrawLayer("OVERLAY")
	cb.icon = cbicon
	CreateVirtualFrame(cb, cb.icon)
	
	cb.shield = cbshield
	cbshield:ClearAllPoints()
	cbshield:SetPoint("TOP", cb, "BOTTOM")
	cb:HookScript("OnShow", UpdateCastbar)
	cb:HookScript("OnSizeChanged", OnSizeChanged)
	cb:HookScript("OnValueChanged", OnValueChanged)	
	frame.cb = cb
	
	-- Highlight
	overlay:SetTexture(1, 1, 1, 0.15)
	overlay:SetAllPoints(hp)
	frame.overlay = overlay

	-- Reposition and Resize RaidIcon
	raidicon:ClearAllPoints()
	raidicon:SetPoint("BOTTOM", hp, "TOP", 0, 16)
	raidicon:SetSize((C.nameplate.height * 2) + 8, (C.nameplate.height * 2) + 8)
	frame.raidicon = raidicon
	
	-- Hide Old Stuff
	QueueObject(frame, oldlevel)
	QueueObject(frame, threat)
	QueueObject(frame, hpborder)
	QueueObject(frame, cbshield)
	QueueObject(frame, cbborder)
	QueueObject(frame, oldname)
	QueueObject(frame, bossicon)
	QueueObject(frame, elite)
	
	UpdateObjects(hp)
	UpdateCastbar(cb)
	
	frame:HookScript("OnHide", OnHide)
	frames[frame] = true
end

local goodR, goodG, goodB = unpack(C.nameplate.good_color)
local badR, badG, badB = unpack(C.nameplate.bad_color)
local transitionR, transitionG, transitionB = unpack(C.nameplate.near_color)
local function UpdateThreat(frame, elapsed)
	frame.hp:Show()
	if frame.hasClass == true then return end
	
	if C.nameplate.enhance_threat ~= true then
		if(frame.region:IsShown()) then
			local _, val = frame.region:GetVertexColor()
			if (val > 0.7) then
				SetVirtualBorder(frame.hp, transitionR, transitionG, transitionB)
			else
				SetVirtualBorder(frame.hp, badR, badG, badB)
			end
		else
			SetVirtualBorder(frame.hp, unpack(C.media.border_color))
		end
	else
		if not frame.region:IsShown() then
			if InCombatLockdown() and frame.isFriendly ~= true then
				-- No Threat
				if T.Role == "Tank" then
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.25)
				else
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.25)
				end		
			else
				-- Set colors to their original, not in combat
				frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
				frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
			end
		else
			-- Ok we either have threat or we're losing/gaining it
			local r, g, b = frame.region:GetVertexColor()
			if g + b == 0 then
				-- Have Threat
				if T.Role == "Tank" then
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.25)
				else
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.25)
				end
			else
				-- Losing/Gaining Threat
				frame.hp:SetStatusBarColor(transitionR, transitionG, transitionB)	
				frame.hp.hpbg:SetTexture(transitionR, transitionG, transitionB, 0.25)
			end
		end
	end
end

-- Create our blacklist for nameplates
local function CheckBlacklist(frame, ...)
	if not T.PlateBlacklist then return end
	if T.PlateBlacklist[frame.hp.name:GetText()] then
		frame:SetScript("OnUpdate", function() end)
		frame.hp:Hide()
		frame.cb:Hide()
		frame.overlay:Hide()
		frame.hp.oldlevel:Hide()
	end
end

-- When becoming intoxicated blizzard likes to re-show the old level text, this should fix that
local function HideDrunkenText(frame, ...)
	if frame and frame.hp.oldlevel and frame.hp.oldlevel:IsShown() then
		frame.hp.oldlevel:Hide()
	end
end

-- Force the name text of a nameplate to be behind other nameplates unless it is our target
local function AdjustNameLevel(frame, ...)
	if UnitName("target") == frame.hp.name:GetText() and frame:GetAlpha() == 1 then
		frame.hp.name:SetDrawLayer("OVERLAY")
	else
		frame.hp.name:SetDrawLayer("BORDER")
	end
end

-- Health Text, also border coloring for certain plates depending on health
local function ShowHealth(frame, ...)
	-- Show current health value
	local minHealth, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local d =(valueHealth / maxHealth) * 100
	
	if C.nameplate.health_value == true then
		frame.hp.value:SetText(T.ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100))))
	end

	-- Setup frame shadow to change depending on enemy players health, also setup targetted unit to have white shadow
	if frame.hasClass == true or frame.isFriendly == true then
		if (d <= 50 and d >= 20) then
			SetVirtualBorder(frame.hp, 1, 1, 0)
		elseif (d < 20) then
			SetVirtualBorder(frame.hp, 1, 0, 0)
		else
			SetVirtualBorder(frame.hp, unpack(C.media.border_color))
		end
	elseif (frame.hasClass ~= true and frame.isFriendly ~= true) and C.nameplate.enhance_threat == true then
		SetVirtualBorder(frame.hp, unpack(C.media.border_color))
	end
end

-- Scan all visible nameplate for a known unit
local function CheckUnit_Guid(frame, ...)
	if UnitExists("target") and frame:GetAlpha() == 1 and UnitName("target") == frame.hp.name:GetText() then
		frame.guid = UnitGUID("target")
		frame.unit = "target"
	elseif frame.overlay:IsShown() and UnitExists("mouseover") and UnitName("mouseover") == frame.hp.name:GetText() then
		frame.guid = UnitGUID("mouseover")
		frame.unit = "mouseover"
	else
		frame.unit = nil
	end	
end

-- Attempt to match a nameplate with a GUID from the combat log
local function MatchGUID(frame, destGUID, spellID)
	if not frame.guid then return end
	
	if frame.guid == destGUID then
		for _, icon in ipairs(frame.icons) do if icon.spellID == spellID then icon:Hide() end end
	end
end

-- Run a function for all visible nameplates, we use this for the blacklist, to check unitguid, and to hide drunken text
local function ForEachPlate(functionToRun, ...)
	for frame in pairs(frames) do
		if frame:IsShown() then
			functionToRun(frame, ...)
		end
	end
end

-- Check if the frames default overlay texture matches blizzards nameplates default overlay texture
local select = select
local function HookFrames(...)
	for index = 1, select("#", ...) do
		local frame = select(index, ...)
		local region = frame:GetRegions()
		
		if(not frames[frame] and (frame:GetName() and frame:GetName():find("NamePlate%d")) and region and region:GetObjectType() == "Texture" and region:GetTexture() == [[Interface\TargetingFrame\UI-TargetingFrame-Flash]]) then
			SkinObjects(frame)
			frame.region = region
		end
	end
end

-- Core right here, scan for any possible nameplate frames that are Children of the WorldFrame
CreateFrame("Frame"):SetScript("OnUpdate", function(self, elapsed)
	if(WorldFrame:GetNumChildren() ~= numChildren) then
		numChildren = WorldFrame:GetNumChildren()
		HookFrames(WorldFrame:GetChildren())
	end

	if(self.elapsed and self.elapsed > 0.2) then
		ForEachPlate(UpdateThreat, self.elapsed)
		ForEachPlate(AdjustNameLevel)
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
	
	ForEachPlate(ShowHealth)
	ForEachPlate(CheckBlacklist)
	ForEachPlate(HideDrunkenText)
	ForEachPlate(CheckUnit_Guid)
end)

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
	
	if C.nameplate.enable == true and C.nameplate.enhance_threat == true then
		SetCVar("threatWarning", 3)
	end
	
	SetCVar("bloatthreat", 0)
	SetCVar("bloattest", 0)
	SetCVar("bloatnameplates", 0)
	if C.nameplate.overlap == true then
		SetCVar("nameplateMotion", 0)
		InterfaceOptionsNamesPanelUnitNameplatesMotionDropDown:Kill()
	else
		SetCVar("nameplateMotion", 1)
	end
end