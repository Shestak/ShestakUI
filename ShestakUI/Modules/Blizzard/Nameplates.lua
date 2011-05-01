local T, C, L = unpack(select(2, ...))
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on dNameplates(by Dawn, editor Elv22)
----------------------------------------------------------------------------------------
local numChildren = -1
local frames = {}
local noscalemult = T.mult * C.general.uiscale

local NamePlates = CreateFrame("Frame", nil, UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
if C.nameplate.track_auras == true then
	NamePlates:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

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
		if object:GetObjectType() == "Texture" then
			object:SetTexture(nil)
			object.SetTexture = T.dummy
		elseif object:GetObjectType() == "FontString" then
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
	parent.backdrop:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult * 3, noscalemult * 3)
	parent.backdrop:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", noscalemult * 3, -noscalemult * 3)
	parent.backdrop:SetTexture(unpack(C.media.backdrop_color))

	parent.bordertop = parent:CreateTexture(nil, "BORDER")
	parent.bordertop:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult * 2, noscalemult * 2)
	parent.bordertop:SetPoint("TOPRIGHT", point, "TOPRIGHT", noscalemult * 2, noscalemult * 2)
	parent.bordertop:SetHeight(noscalemult)
	parent.bordertop:SetTexture(unpack(C.media.border_color))	
	parent.bordertop:SetDrawLayer("BORDER", -7)
	
	parent.borderbottom = parent:CreateTexture(nil, "BORDER")
	parent.borderbottom:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", -noscalemult * 2, -noscalemult * 2)
	parent.borderbottom:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", noscalemult * 2, -noscalemult * 2)
	parent.borderbottom:SetHeight(noscalemult)
	parent.borderbottom:SetTexture(unpack(C.media.border_color))	
	parent.borderbottom:SetDrawLayer("BORDER", -7)
	
	parent.borderleft = parent:CreateTexture(nil, "BORDER")
	parent.borderleft:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult * 2, noscalemult * 2)
	parent.borderleft:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", noscalemult * 2, -noscalemult * 2)
	parent.borderleft:SetWidth(noscalemult)
	parent.borderleft:SetTexture(unpack(C.media.border_color))	
	parent.borderleft:SetDrawLayer("BORDER", -7)
	
	parent.borderright = parent:CreateTexture(nil, "BORDER")
	parent.borderright:SetPoint("TOPRIGHT", point, "TOPRIGHT", noscalemult * 2, noscalemult * 2)
	parent.borderright:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", -noscalemult * 2, -noscalemult * 2)
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

-- Create aura icons
local function CreateAuraIcon(parent)
	local button = CreateFrame("Frame", nil, parent)
	button:SetWidth(20)
	button:SetHeight(20)

	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetTexture(unpack(C.media.backdrop_color))
	button.bg:SetAllPoints(button)

	button.bord = button:CreateTexture(nil, "BORDER")
	button.bord:SetTexture(unpack(C.media.border_color))
	button.bord:SetPoint("TOPLEFT", button, "TOPLEFT", noscalemult, -noscalemult)
	button.bord:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -noscalemult, noscalemult)

	button.bg2 = button:CreateTexture(nil, "ARTWORK")
	button.bg2:SetTexture(unpack(C.media.backdrop_color))
	button.bg2:SetPoint("TOPLEFT", button, "TOPLEFT", noscalemult * 2, -noscalemult * 2)
	button.bg2:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -noscalemult * 2, noscalemult * 2)	

	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", noscalemult * 3, -noscalemult * 3)
	button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -noscalemult * 3, noscalemult * 3)
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.cd = CreateFrame("Cooldown", nil, button)
	button.cd:SetAllPoints(button)
	button.cd:SetReverse(true)

	button.count = button:CreateFontString(nil, "OVERLAY")
	button.count:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * noscalemult, C.font.nameplates_font_style)
	button.count:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	button.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)

	return button
end

-- Update an aura icon
local function UpdateAuraIcon(button, unit, index, filter)
	local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitAura(unit, index, filter)

	button.icon:SetTexture(icon)
	button.cd:SetCooldown(expirationTime-duration,duration)
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
		button.cd.timer.text:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * noscalemult, C.font.nameplates_font_style)
		button.cd.timer.text:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	end)
	button:Show()
end

-- Filter auras on nameplate, and determine if we need to update them or not
local function OnAura(frame, unit)
	if not frame.icons or not frame.unit then return end
	local i = 1
	for index = 1, 40 do
		if i > 5 then return end
		local match
		local name, _, _, _, _, duration, _, caster, _, _, spellid = UnitAura(frame.unit, index, "HARMFUL")

		if C.nameplate.track_auras == true then
			if T.DebuffWhiteList[name] and caster == "player" then match = true end
		end

		if duration and match == true then
			if not frame.icons[i] then frame.icons[i] = CreateAuraIcon(frame) end
			local icon = frame.icons[i]
			if i == 1 then icon:SetPoint("RIGHT", frame.icons, "RIGHT") end
			if i ~= 1 and i <= 5 then icon:SetPoint("RIGHT", frame.icons[i-1], "LEFT", -2, 0) end
			i = i + 1
			UpdateAuraIcon(icon, frame.unit, index, "HARMFUL")
		end
	end
	for index = i, #frame.icons do frame.icons[index]:Hide() end
end

-- Color the castbar depending on if we can interrupt or not
local function UpdateCastbar(frame)
	frame:ClearAllPoints()
	frame:SetSize(C.nameplate.width * noscalemult, C.nameplate.height * noscalemult)
	frame:SetPoint("TOP", frame:GetParent().hp, "BOTTOM", 0, -8)
	frame:GetStatusBarTexture():SetHorizTile(true)
	if frame.shield:IsShown() then
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
		for _, icon in ipairs(frame.icons) do
			icon:Hide()
		end
	end	
	
	frame:SetScript("OnUpdate", nil)
end

-- Color Nameplate
local function Colorize(frame)
	local r, g, b = frame.healthOriginal:GetStatusBarColor()
	
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

	-- Match values
	frame.hp:SetMinMaxValues(frame.healthOriginal:GetMinMaxValues())
	frame.hp:SetValue(frame.healthOriginal:GetValue())
	frame.healthOriginal:SetScript("OnValueChanged", function()
		frame.hp:SetMinMaxValues(frame.healthOriginal:GetMinMaxValues())
		frame.hp:SetValue(frame.healthOriginal:GetValue())
	end)
	
	-- Colorize Plate
	Colorize(frame)
	frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor = frame.hp:GetStatusBarColor()
	frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
	SetVirtualBorder(frame.hp, unpack(C.media.border_color))
	if C.nameplate.enhance_threat == true then
		frame.hp.name:SetTextColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
	end
	
	-- Set the name text
	if C.nameplate.name_abbrev == true and C.nameplate.track_auras ~= true then
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

	-- Aura tracking
	if C.nameplate.track_auras == true then
		if frame.icons then return end
		frame.icons = CreateFrame("Frame", nil, frame)
		frame.icons:SetPoint("BOTTOMRIGHT", frame.hp, "TOPRIGHT", 0, C.font.nameplates_font_size + 5)
		frame.icons:SetWidth(20 + C.nameplate.width)
		frame.icons:SetHeight(25)
		frame.icons:SetFrameLevel(frame.hp:GetFrameLevel() + 2)
		frame:RegisterEvent("UNIT_AURA")
		frame:HookScript("OnEvent", OnAura)
	end

	HideObjects(frame)
end

-- This is where we create most 'Static' objects for the nameplate
local function SkinObjects(frame)
	local oldhp, cb = frame:GetChildren()
	local threat, hpborder, overlay, oldname, oldlevel, bossicon, raidicon, elite = frame:GetRegions()
	local _, cbborder, cbshield, cbicon = cb:GetRegions()

	-- Health Bar
	frame.healthOriginal = oldhp
	local hp = CreateFrame("Statusbar", nil, frame)
	hp:SetFrameLevel(oldhp:GetFrameLevel())
	hp:SetFrameStrata(oldhp:GetFrameStrata())
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
	raidicon:SetPoint("BOTTOM", hp, "TOP", 0, C.nameplate.track_auras == true and 38 or 16)
	raidicon:SetSize((C.nameplate.height * 2) + 8, (C.nameplate.height * 2) + 8)
	frame.raidicon = raidicon
	
	-- Hide Old Stuff
	QueueObject(frame, oldhp)
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
		if frame.region:IsShown() then
			local _, val = frame.region:GetVertexColor()
			if val > 0.7 then
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
	if C.nameplate.name_abbrev == true then return end
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
	local d = (valueHealth / maxHealth) * 100
	
	if C.nameplate.health_value == true then
		frame.hp.value:SetText(T.ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100))))
	end

	-- Setup frame shadow to change depending on enemy players health, also setup targetted unit to have white shadow
	if frame.hasClass == true or frame.isFriendly == true then
		if d <= 50 and d >= 20 then
			SetVirtualBorder(frame.hp, 1, 1, 0)
		elseif d < 20 then
			SetVirtualBorder(frame.hp, 1, 0, 0)
		else
			SetVirtualBorder(frame.hp, unpack(C.media.border_color))
		end
	elseif (frame.hasClass ~= true and frame.isFriendly ~= true) and C.nameplate.enhance_threat == true then
		SetVirtualBorder(frame.hp, unpack(C.media.border_color))
	end

	if UnitName("target") and frame:GetAlpha() == 1 then
		frame.hp:SetSize((C.nameplate.width + C.nameplate.ad_width) * noscalemult, (C.nameplate.height + C.nameplate.ad_height) * noscalemult)
	else
		frame.hp:SetSize(C.nameplate.width * noscalemult, C.nameplate.height * noscalemult)
	end
end

-- Scan all visible nameplate for a known unit
local function CheckUnit_Guid(frame, ...)
	if UnitExists("target") and frame:GetAlpha() == 1 and UnitName("target") == frame.hp.name:GetText() then
		frame.guid = UnitGUID("target")
		frame.unit = "target"
		OnAura(frame, "target")
	elseif frame.overlay:IsShown() and UnitExists("mouseover") and UnitName("mouseover") == frame.hp.name:GetText() then
		frame.guid = UnitGUID("mouseover")
		frame.unit = "mouseover"
		OnAura(frame, "mouseover")
	else
		frame.unit = nil
	end	
end

-- Attempt to match a nameplate with a GUID from the combat log
local function MatchGUID(frame, destGUID, spellID)
	if not frame.guid then return end

	if frame.guid == destGUID then
		for _, icon in ipairs(frame.icons) do
			if icon.spellID == spellID then
				icon:Hide()
			end
		end
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
		
		if (not frames[frame] and (frame:GetName() and frame:GetName():find("NamePlate%d")) and region and region:GetObjectType() == "Texture" and region:GetTexture() == [[Interface\TargetingFrame\UI-TargetingFrame-Flash]]) then
			SkinObjects(frame)
			frame.region = region
		end
	end
end

-- Core right here, scan for any possible nameplate frames that are Children of the WorldFrame
CreateFrame("Frame"):SetScript("OnUpdate", function(self, elapsed)
	if WorldFrame:GetNumChildren() ~= numChildren then
		numChildren = WorldFrame:GetNumChildren()
		HookFrames(WorldFrame:GetChildren())
	end

	if self.elapsed and self.elapsed > 0.2 then
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

function NamePlates:COMBAT_LOG_EVENT_UNFILTERED(_, event, _, _, sourceName, _, destGUID, _, _, spellID)
	if event == "SPELL_AURA_REMOVED" then
		ForEachPlate(MatchGUID, destGUID, spellID)
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
	
	if C.nameplate.enable == true and C.nameplate.enhance_threat == true then
		SetCVar("threatWarning", 3)
	end
	
	SetCVar("bloatthreat", 0)
	SetCVar("bloattest", 0)
	SetCVar("bloatnameplates", 0)
end