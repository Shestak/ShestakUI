----------------------------------------------------------------------------------------
--	Auto UIScale
----------------------------------------------------------------------------------------
local media = SettingsCF["media"]

function SettingsDB.UIScale()
	if SettingsCF["general"].auto_scale == true then
		SettingsCF["general"].uiscale = min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")))
	end
end
SettingsDB.UIScale()

-- Pixel perfect script of custom ui scale
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/SettingsCF["general"].uiscale
local function scale(x)
    return mult*math.floor(x/mult+.5)
end

function SettingsDB.Scale(x) return scale(x) end
SettingsDB.mult = mult

----------------------------------------------------------------------------------------
--	Template functions
----------------------------------------------------------------------------------------
-- Setup backdrop texture
local backdrop = {
	bgFile = media.blank, edgeFile = media.blank,
	tile = false, tileSize = 0,	edgeSize = mult,
	insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
}

-- Create overlay frame
function SettingsDB.SetOverlay(f)
	if f.bg then return end
	f.bg = f:CreateTexture(f:GetName() and f:GetName().."_overlay" or nil, "BORDER", f)
	f.bg:ClearAllPoints()
	f.bg:SetPoint("TOPLEFT", f, "TOPLEFT", mult, -mult)
	f.bg:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -mult, mult)
	f.bg:SetTexture(media.texture)
	f.bg:SetVertexColor(0.1, 0.1, 0.1, 1)
	return f.bg
end

-- Skin panels
function SettingsDB.SkinPanel(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(media.backdrop_color))
	f:SetBackdropBorderColor(unpack(media.border_color))
	SettingsDB.SetOverlay(f)
end

-- Finally create them
function SettingsDB.CreatePanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)	
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	SettingsDB.SkinPanel(f)
end

-- This is used for panels that don't use shadows
function SettingsDB.CreateTemplate(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(media.backdrop_color))
	f:SetBackdropBorderColor(unpack(media.border_color))
end

function SettingsDB.StyleInnerBorder(f)
	if f.iborder then return end
	f.iborder = CreateFrame("Frame", nil, f)
	f.iborder:SetPoint("TOPLEFT", mult, -mult)
	f.iborder:SetPoint("BOTTOMRIGHT", -mult, mult)
	f.iborder:SetBackdrop({
		edgeFile = media.blank, 
		edgeSize = mult, 
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	})
	f.iborder:SetBackdropBorderColor(unpack(media.backdrop_color))
	return f.iborder
end

function SettingsDB.StyleOuterBorder(f)
	if f.oborder then return end
	f.oborder = CreateFrame("Frame", nil, f)
	f.oborder:SetPoint("TOPLEFT", -mult, mult)
	f.oborder:SetPoint("BOTTOMRIGHT", mult, -mult)
	f.oborder:SetBackdrop({
		edgeFile = media.blank, 
		edgeSize = mult, 
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	})
	f.oborder:SetBackdropBorderColor(unpack(media.backdrop_color))
	return f.oborder
end

-- Skin more shit
function SettingsDB.SkinFadedPanel(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(media.overlay_color))
	f:SetBackdropBorderColor(unpack(media.border_color))
	SettingsDB.StyleInnerBorder(f)
	SettingsDB.StyleOuterBorder(f)
end

-- Create our faded panels
function SettingsDB.CreateFadedPanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	SettingsDB.SkinFadedPanel(f)
end

function SettingsDB.CreateBlizzard(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(media.overlay_color))
	f:SetBackdropBorderColor(unpack(media.border_color))
end

----------------------------------------------------------------------------------------
--	Info text function
----------------------------------------------------------------------------------------
local InfoFrame = CreateFrame("Frame", nil, UIParent)
InfoFrame:SetScript("OnUpdate", FadingFrame_OnUpdate)
InfoFrame.fadeInTime = 0.5
InfoFrame.fadeOutTime = 2
InfoFrame.holdTime = 3
InfoFrame:Hide()

local InfoText = InfoFrame:CreateFontString("InfoText", "OVERLAY")
InfoText:SetFont(media.normal_font, 25, "OUTLINE")
InfoText:SetPoint("CENTER", UIParent, "CENTER", 0, 90)
InfoText:SetTextColor(0.41, 0.8, 0.94)

function SettingsDB.InfoTextShow(s)
    InfoText:SetText(s)
    FadingFrame_Show(InfoFrame)
end

----------------------------------------------------------------------------------------
--	Kill object function
----------------------------------------------------------------------------------------
function SettingsDB.Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = SettingsDB.dummy
	object:Hide()
end

----------------------------------------------------------------------------------------
--	Pet and shapeshift bars style function
----------------------------------------------------------------------------------------
function SettingsDB.ShiftBarUpdate()
	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		button = _G["ShapeshiftButton"..i]
		icon = _G["ShapeshiftButton"..i.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
			icon:SetTexture(texture)
			
			cooldown = _G["ShapeshiftButton"..i.."Cooldown"]
			if texture then
				cooldown:SetAlpha(1)
			else
				cooldown:SetAlpha(0)
			end
			
			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
			
			if isActive then
				ShapeshiftBarFrame.lastSelected = button:GetID()
				button:SetChecked(1)
			else
				button:SetChecked(0)
			end

			if isCastable then
				icon:SetVertexColor(1.0, 1.0, 1.0)
			else
				icon:SetVertexColor(0.4, 0.4, 0.4)
			end
		end
	end
end

function SettingsDB.PetBarUpdate(self, event)
	local petActionButton, petActionIcon, petAutoCastableTexture, petAutoCastShine
	for i = 1, NUM_PET_ACTION_SLOTS, 1 do
		local buttonName = "PetActionButton" .. i
		petActionButton = _G[buttonName]
		petActionIcon = _G[buttonName.."Icon"]
		petAutoCastableTexture = _G[buttonName.."AutoCastable"]
		petAutoCastShine = _G[buttonName.."Shine"]
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		
		if not isToken then
			petActionIcon:SetTexture(texture)
			petActionButton.tooltipName = name
		else
			petActionIcon:SetTexture(_G[texture])
			petActionButton.tooltipName = _G[name]
		end
		
		petActionButton.isToken = isToken
		petActionButton.tooltipSubtext = subtext
		
		if isActive and name ~= "PET_ACTION_FOLLOW" then
			petActionButton:SetChecked(1)
			if IsPetAttackAction(i) then
				PetActionButton_StartFlash(petActionButton)
			end
		else
			petActionButton:SetChecked(0)
			if IsPetAttackAction(i) then
				PetActionButton_StopFlash(petActionButton)
			end
		end
		
		if autoCastAllowed then
			petAutoCastableTexture:Show()
		else
			petAutoCastableTexture:Hide()
		end
		
		if autoCastEnabled then
			AutoCastShine_AutoCastStart(petAutoCastShine)
		else
			AutoCastShine_AutoCastStop(petAutoCastShine)
		end
		
		if name then
			if not SettingsCF["actionbar"].show_grid then
				petActionButton:SetAlpha(1)
			end			
		else
			if not SettingsCF["actionbar"].show_grid then
				petActionButton:SetAlpha(0)
			end
		end
		
		if texture then
			if GetPetActionSlotUsable(i) then
				SetDesaturation(petActionIcon, nil)
			else
				SetDesaturation(petActionIcon, 1)
			end
			petActionIcon:Show()
		else
			petActionIcon:Hide()
		end
		
		if not PetHasActionBar() and texture and name ~= "PET_ACTION_FOLLOW" then
			PetActionButton_StopFlash(petActionButton)
			SetDesaturation(petActionIcon, 1)
			petActionButton:SetChecked(0)
		end
	end
end

----------------------------------------------------------------------------------------
--	Style Button function(by Chiril & Karudon)
----------------------------------------------------------------------------------------
function SettingsDB.StyleButton(b, checked) 
    local name = b:GetName()
    local button = _G[name]
    local icon = _G[name.."Icon"]
    local count = _G[name.."Count"]
    local border = _G[name.."Border"]
    local hotkey = _G[name.."HotKey"]
    local cooldown = _G[name.."Cooldown"]
    local nametext = _G[name.."Name"]
    local flash = _G[name.."Flash"]
    local normaltexture = _G[name.."NormalTexture"]
	local icontexture = _G[name.."IconTexture"]
 
    local hover = b:CreateTexture("Frame", nil, self)
    hover:SetTexture(1, 1, 1, 0.3)
    hover:SetHeight(button:GetHeight())
    hover:SetWidth(button:GetWidth())
    hover:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
    hover:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
    button:SetHighlightTexture(hover)
 
    local pushed = b:CreateTexture("Frame", nil, self)
    pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
    pushed:SetHeight(button:GetHeight())
    pushed:SetWidth(button:GetWidth())
    pushed:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
    pushed:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
    button:SetPushedTexture(pushed)
 
	if checked then
		local checked = b:CreateTexture("Frame", nil, self)
		checked:SetTexture(0, 1, 0, 0.3)
		checked:SetHeight(button:GetHeight())
		checked:SetWidth(button:GetWidth())
		checked:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		checked:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		button:SetCheckedTexture(checked)
	end
	
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	end
end

----------------------------------------------------------------------------------------
--	Player's Role and Talents spent
----------------------------------------------------------------------------------------
function SettingsDB.CheckForKnownTalent(spellid)
	local wanted_name = GetSpellInfo(spellid)
	if not wanted_name then return nil end
	local num_tabs = GetNumTalentTabs()
	for t = 1, num_tabs do
		local num_talents = GetNumTalents(t)
		for i = 1, num_talents do
			local name_talent, _, _, _, current_rank = GetTalentInfo(t,i)
			if name_talent and (name_talent == wanted_name) then
				if current_rank and (current_rank > 0) then
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

local RoleUpdater = CreateFrame("Frame")
local function CheckRole(self, event, unit)
	local resilience
	if GetCombatRating(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)*0.02828 > GetDodgeChance() then
		resilience = true
	else
		resilience = false
	end
	if ((SettingsDB.class == "PALADIN" and GetPrimaryTalentTree() == 2) or 
	(SettingsDB.class == "WARRIOR" and GetPrimaryTalentTree() == 3) or 
	(SettingsDB.class == "DEATHKNIGHT" and GetPrimaryTalentTree() == 1)) and
	resilience == false or
	(SettingsDB.class == "DRUID" and GetPrimaryTalentTree() == 2 and GetBonusBarOffset() == 3) then
		SettingsDB.Role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player");
		local playerap = base + posBuff + negBuff;

		if ((playerap > playerint) or (playeragi > playerint)) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139))) then
			SettingsDB.Role = "Melee"
		else
			SettingsDB.Role = "Caster"
		end
	end
end	
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:SetScript("OnEvent", CheckRole)
CheckRole()

----------------------------------------------------------------------------------------
--	UTF functions
----------------------------------------------------------------------------------------
function SettingsDB.UTF(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if (bytes <= i) then
		return string
	else
		local len, pos = 0, 1
		while(pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if (c > 0 and c <= 127) then
				pos = pos + 1
			elseif (c >= 192 and c <= 223) then
				pos = pos + 2
			elseif (c >= 224 and c <= 239) then
				pos = pos + 3
			elseif (c >= 240 and c <= 247) then
				pos = pos + 4
			end
			if (len == i) then break end
		end
		if (len == i and pos <= bytes) then
			return string:sub(1, pos - 1)..(dots and "..." or "")
		else
			return string
		end
	end
end

----------------------------------------------------------------------------------------
--	Unit frames functions
----------------------------------------------------------------------------------------
do
	if not SettingsCF.unitframe.enable == true then return end

	local db = SettingsCF["unitframe"]

	local SetUpAnimGroup = function(self)
		self.anim = self:CreateAnimationGroup("Flash")
		self.anim.fadein = self.anim:CreateAnimation("ALPHA", "FadeIn")
		self.anim.fadein:SetChange(1)
		self.anim.fadein:SetOrder(2)

		self.anim.fadeout = self.anim:CreateAnimation("ALPHA", "FadeOut")
		self.anim.fadeout:SetChange(-1)
		self.anim.fadeout:SetOrder(1)
	end

	local Flash = function(self, duration)
		if not self.anim then
			SetUpAnimGroup(self)
		end

		if not self.anim:IsPlaying() or duration ~= self.anim.fadein:GetDuration() then
			self.anim.fadein:SetDuration(duration)
			self.anim.fadeout:SetDuration(duration)
			self.anim:Play()
		end
	end

	local StopFlash = function(self)
		if self.anim then
			self.anim:Finish()
		end
	end

	function SettingsDB.SpawnMenu(self)
		local unit = self.unit:sub(1, -2)
		local cunit = self.unit:gsub("^%l", string.upper)

		if(cunit == 'Vehicle') then
			cunit = 'Pet'
		end

		if(unit == "party" or unit == "partypet") then
			ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor", 0, 0)
		elseif(_G[cunit.."FrameDropDown"]) then
			ToggleDropDownMenu(1, nil, _G[cunit.."FrameDropDown"], "cursor", 0, 0)
		end
	end

	SettingsDB.SetFontString = function(parent, fontName, fontHeight, fontStyle)
		local fs = parent:CreateFontString(nil, "OVERLAY")
		fs:SetFont(fontName, fontHeight, fontStyle)
		fs:SetShadowOffset(SettingsCF["font"].unit_frames_font_shadow and 1 or 0, SettingsCF["font"].unit_frames_font_shadow and -1 or 0)
		return fs
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

	SettingsDB.PostUpdateHealth = function(health, unit, min, max)
		if (unit and unit:find("arena%dtarget")) then return end
		if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
			health:SetValue(0)
			if not UnitIsConnected(unit) then
				health.value:SetText("|cffD7BEA5"..L_UF_OFFLINE.."|r")
			elseif UnitIsDead(unit) then
				health.value:SetText("|cffD7BEA5"..L_UF_DEAD.."|r")
			elseif UnitIsGhost(unit) then
				health.value:SetText("|cffD7BEA5"..L_UF_GHOST.."|r")
			end
		else
			local r, g, b	
			if (db.own_color ~= true and db.enemy_health_color and unit == "target" and UnitIsEnemy(unit, "player")) or (db.own_color ~= true and unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
				local c = SettingsDB.oUF_colors.reaction[UnitReaction(unit, "player")]
				if c then 
					r, g, b = c[1], c[2], c[3]
					health:SetStatusBarColor(r, g, b)
				else
					r, g, b = 75/255,  175/255, 76/255
					health:SetStatusBarColor(r, g, b)
				end	
			end
			if unit == "pet" or unit == "vehicle" then
				local _, class = UnitClass("player")
				local r, g, b = unpack(oUF.colors.class[class])
				if db.own_color == true then
					health:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
					health.bg:SetVertexColor(0.1, 0.1, 0.1)
				else
					if b then
						health:SetStatusBarColor(r, g, b)
					end
				end
			end
			if min ~= max then
				local r, g, b
				r, g, b = oUF.ColorGradient(min/max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
				if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
					if db.show_total_value == true then
						if db.color_value == true then
							health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5-|r |cff559655%s|r", ShortValue(min), ShortValue(max))
						else
							health.value:SetFormattedText("|cffffffff%s|r |cffffffff-|r |cffffffff%s|r", ShortValue(min), ShortValue(max))
						end
					else
						if db.color_value == true then
							health.value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
						else
							health.value:SetFormattedText("|cffffffff%d|r |cffffffff-|r |cffffffff%d%%|r", min, floor(min / max * 100))
						end
					end
				elseif unit == "target" then
					if db.show_total_value == true then
						if db.color_value == true then
							health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5-|r |cff559655%s|r", ShortValue(min), ShortValue(max))
						else
							health.value:SetFormattedText("|cffffffff%s|r |cffffffff-|r |cffffffff%s|r", ShortValue(min), ShortValue(max))
						end
					else
						if db.color_value == true then
							health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r |cffD7BEA5-|r |cffAF5050%s|r", r * 255, g * 255, b * 255, floor(min / max * 100), ShortValue(min))
						else
							health.value:SetFormattedText("|cffffffff%d%%|r |cffffffff-|r |cffffffff%s|r", floor(min / max * 100), ShortValue(min))
						end
					end
				else
					if db.color_value == true then
						health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r", r * 255, g * 255, b * 255, floor(min / max * 100))
					else
						health.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
					end
				end
			else
				if unit == "player" and unit ~= "pet" then
					if db.color_value == true then
						health.value:SetText("|cff559655"..max.."|r")
					else
						health.value:SetText("|cffffffff"..max.."|r")
					end
				else
					if db.color_value == true then
						health.value:SetText("|cff559655"..ShortValue(max).."|r")
					else
						health.value:SetText("|cffffffff"..ShortValue(max).."|r")
					end
				end
			end
		end
	end

	SettingsDB.PostUpdateRaidHealth = function(health, unit, min, max)
		if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
			health:SetValue(0)
			if not UnitIsConnected(unit) then
				health.value:SetText("|cffD7BEA5"..L_UF_OFFLINE.."|r")
			elseif UnitIsDead(unit) then
				health.value:SetText("|cffD7BEA5"..L_UF_DEAD.."|r")
			elseif UnitIsGhost(unit) then
				health.value:SetText("|cffD7BEA5"..L_UF_GHOST.."|r")
			end
		else
			if min ~= max then
				local r, g, b
				r, g, b = oUF.ColorGradient(min/max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
				if db.color_value == true then
					if db.deficit_health == true then
						health.value:SetText("|cffFFFFFF".."-"..ShortValue(max-min))
					else
						health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r", r * 255, g * 255, b * 255, floor(min / max * 100))
					end
				else
					if db.deficit_health == true then
						health.value:SetText("|cffFFFFFF".."-"..ShortValue(max-min))
					else
						health.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
					end
				end
			else
				if db.color_value == true then
					health.value:SetText("|cff559655"..ShortValue(max).."|r")
				else
					health.value:SetText("|cffffffff"..ShortValue(max).."|r")
				end
			end
			if db.alpha_health == true then
				if(min / max > 0.95) then 
					health:SetAlpha(0.6)
					--self.Power:SetAlpha(0.6)
					--self.FrameBackdrop:SetAlpha(0.6)
				else
					health:SetAlpha(1)
					--self.Power:SetAlpha(1)
					--self.FrameBackdrop:SetAlpha(1)
				end
			end
		end
	end
	
	SettingsDB.PostUpdatePetColor = function(health, unit, min, max)
		if not UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and db.own_color ~= true then
			r, g, b = 75/255,  175/255, 76/255
			health:SetStatusBarColor(r, g, b)
			health.bg:SetTexture(0.1, 0.1, 0.1)
		end
	end

	SettingsDB.PreUpdatePower = function(power, unit)
		local _, pType = UnitPowerType(unit)
		
		local color = SettingsDB.oUF_colors.power[pType]
		if color then
			power:SetStatusBarColor(color[1], color[2], color[3])
		end
	end

	SettingsDB.PostUpdatePower = function(power, unit, min, max)
		if (unit and unit:find("arena%dtarget")) then return end
		local self = power:GetParent()
		local pType, pToken = UnitPowerType(unit)
		local color = SettingsDB.oUF_colors.power[pToken]

		if color then
			power.value:SetTextColor(color[1], color[2], color[3])
		end

		if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
			power:SetValue(0)
		end
		
		if unit == "focus" or unit == "focustarget" or unit == "targettarget" then return end
		
		if not UnitIsConnected(unit) then
			power.value:SetText()
		elseif UnitIsDead(unit) or UnitIsGhost(unit) then
			power.value:SetText()
		else
			if min ~= max then
				if pType == 0 then
					if unit == "target" then
						if db.show_total_value == true then
							if db.color_value == true then
								power.value:SetFormattedText("%s |cffD7BEA5-|r %s", ShortValue(max - (max - min)), ShortValue(max))
							else
								power.value:SetFormattedText("|cffffffff%s - %s|r", ShortValue(max - (max - min)), ShortValue(max))
							end
						else
							if db.color_value == true then
								power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), ShortValue(max - (max - min)))
							else
								power.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), ShortValue(max - (max - min)))
							end
						end
					elseif unit == "player" and power:GetAttribute("normalUnit") == "pet" or unit == "pet" then
						if db.show_total_value == true then
							if db.color_value == true then
								power.value:SetFormattedText("%s |cffD7BEA5-|r %s", ShortValue(max - (max - min)), ShortValue(max))
							else
								power.value:SetFormattedText("%s |cffffffff-|r %s", ShortValue(max - (max - min)), ShortValue(max))
							end
						else
							if db.color_value == true then
								power.value:SetFormattedText("%d%%", floor(min / max * 100))
							else
								power.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
							end
						end
					elseif (unit and unit:find("arena%d")) then
						if db.color_value == true then
							power.value:SetFormattedText("|cffD7BEA5%d%% - %s|r", floor(min / max * 100), ShortValue(max - (max - min)))
						else
							power.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), ShortValue(max - (max - min)))
						end
					else
						if db.show_total_value == true then
							if db.color_value == true then
								power.value:SetFormattedText("%s |cffD7BEA5-|r %s", ShortValue(max - (max - min)), ShortValue(max))
							else
								power.value:SetFormattedText("|cffffffff%s - %s|r", ShortValue(max - (max - min)), ShortValue(max))
							end
						else
							if db.color_value == true then
								power.value:SetFormattedText("%d |cffD7BEA5-|r %d%%", max - (max - min), floor(min / max * 100))
							else
								power.value:SetFormattedText("|cffffffff%d - %d%%|r", max - (max - min), floor(min / max * 100))
							end
						end
					end
				else
					if db.color_value == true then
						power.value:SetText(max - (max - min))
					else
						power.value:SetText("|cffffffff"..max - (max - min).."|r")
					end
				end
			else
				if unit == "pet" or unit == "target" or (unit and unit:find("arena%d")) then
					if db.color_value == true then
						power.value:SetText(ShortValue(min))
					else
						power.value:SetText("|cffffffff"..ShortValue(min).."|r")
					end
				else
					if db.color_value == true then
						power.value:SetText(min)
					else
						power.value:SetText("|cffffffff"..min.."|r")
					end
				end
			end
		end
	end

	local delay = 0
	SettingsDB.UpdateManaLevel = function(self, elapsed)
		delay = delay + elapsed
		if self.parent.unit ~= "player" or delay < 0.2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
		delay = 0

		local percMana = UnitMana("player") / UnitManaMax("player") * 100

		if percMana <= 20 then
			self.ManaLevel:SetText("|cffaf5050"..MANA_LOW.."|r")
			Flash(self, 0.3)
		else
			self.ManaLevel:SetText()
			StopFlash(self)
		end
	end

	SettingsDB.UpdateDruidMana = function(self)
		if self.unit ~= "player" then return end

		local num, str = UnitPowerType("player")
		if num ~= 0 then
			local min = UnitPower("player", 0)
			local max = UnitPowerMax("player", 0)
			
			local percMana = min / max * 100
			if percMana <= 20 then
				self.FlashInfo.ManaLevel:SetText("|cffaf5050"..MANA_LOW.."|r")
				Flash(self.FlashInfo, 0.3)
			else
				self.FlashInfo.ManaLevel:SetText()
				StopFlash(self.FlashInfo)
			end

			if min ~= max then
				if self.Power.value:GetText() then
					self.DruidMana:SetPoint("RIGHT", self.Power.value, "LEFT", SettingsDB.Scale(-1), 0)
					self.DruidMana:SetFormattedText("%d%%|r |cffD7BEA5-|r", floor(min / max * 100))
					self.DruidMana:SetJustifyH("RIGHT")
				else
					self.DruidMana:SetPoint("LEFT", self.Power, "LEFT", SettingsDB.Scale(4), SettingsDB.Scale(1))
					self.DruidMana:SetFormattedText("%d%%", floor(min / max * 100))
				end
			else
				self.DruidMana:SetText()
			end

			self.DruidMana:SetAlpha(1)
		else
			self.DruidMana:SetAlpha(0)
		end
	end

	SettingsDB.UpdateShards = function(self, event, unit, powerType)
		if(self.unit ~= unit or (powerType and powerType ~= 'SOUL_SHARDS')) then return end
		local num = UnitPower(unit, SPELL_POWER_SOUL_SHARDS)
		for i = 1, SHARD_BAR_NUM_SHARDS do
			if(i <= num) then
				self.SoulShards[i]:SetAlpha(1)
			else
				self.SoulShards[i]:SetAlpha(0.2)
			end
		end
	end
	
	SettingsDB.UpdateHoly = function(self, event, unit, powerType)
		if(self.unit ~= unit or (powerType and powerType ~= 'HOLY_POWER')) then return end
		local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
		for i = 1, MAX_HOLY_POWER do
			if(i <= num) then
				self.HolyPower[i]:SetAlpha(1)
			else
				self.HolyPower[i]:SetAlpha(0.2)
			end
		end
	end
	
	SettingsDB.EclipseDirection = function(self)
		if ( GetEclipseDirection() == "sun" ) then
			self.Text:SetText("|cff4478BC>>|r")
		elseif ( GetEclipseDirection() == "moon" ) then
			self.Text:SetText("|cffE5994C<<|r")
		else
			self.Text:SetText("")
		end
	end
	
	SettingsDB.UpdateEclipse = function(self, login)
		local eb = self.EclipseBar
		local txt = self.EclipseBar.Text
		if login then
			eb:SetScript("OnUpdate", nil)
		end
		if eb:IsShown() then
			txt:Show()
			if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(19)) end
		else
			txt:Hide()
			if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(5)) end
		end
	end

	SettingsDB.UpdateCPoints = function(self, event, unit)
		if unit == PlayerFrame.unit and unit ~= self.CPoints.unit then
			self.CPoints.unit = unit
		end
	end

	SettingsDB.UpdateReputationColor = function(self, event, unit, bar)
		local name, id = GetWatchedFactionInfo()
		bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
	end

	SettingsDB.UpdatePetInfo = function(self, event)
		if self.Info then self.Info:UpdateTag(self.unit) end
	end

	SettingsDB.PostCastStart = function(Castbar, unit, name, rank, text, castid)
		Castbar.channeling = false

		if unit == "vehicle" then unit = "player" end

		if unit == "player" and db.castbar_latency == true then
			local latency = GetTime() - (Castbar.castSent or 0)
			latency = latency > Castbar.max and Castbar.max or latency
			Castbar.Latency:SetText(("%dms"):format(latency * 1e3))
			Castbar.SafeZone:SetWidth(Castbar:GetWidth() * latency / Castbar.max)
			Castbar.SafeZone:ClearAllPoints()
			Castbar.SafeZone:SetPoint("TOPRIGHT")
			Castbar.SafeZone:SetPoint("BOTTOMRIGHT")
		end

		local r, g, b, color
		if(UnitIsPlayer(unit)) then
			local _, class = UnitClass(unit)
			color = oUF.colors.class[class]
		else
			local reaction = UnitReaction(unit, "player");
			if reaction then
				r = FACTION_BAR_COLORS[reaction].r;
				g = FACTION_BAR_COLORS[reaction].g;
				b = FACTION_BAR_COLORS[reaction].b;
			else
				r, g, b = 1, 1, 1
			end
		end

		if color then
			r, g, b = color[1], color[2], color[3]
		end
		
		if Castbar.interrupt and UnitCanAttack("player", unit) then
			Castbar:SetStatusBarColor(1, 0, 0)
			Castbar.bg:SetVertexColor(1, 0, 0, 0.25)
		else
			if unit == "pet" or unit == "vehicle" then
				local _, class = UnitClass("player")
				local r, g, b = unpack(oUF.colors.class[class])
				if db.own_color == true then
					Castbar:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
					Castbar.bg:SetVertexColor(0.1, 0.1, 0.1)
				else
					if b then
						Castbar:SetStatusBarColor(r, g, b)
						Castbar.bg:SetVertexColor(r, g, b, 0.25)
					end
				end
			else
				if db.own_color == true then
					Castbar:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
					Castbar.bg:SetVertexColor(0.1, 0.1, 0.1)
				else
					Castbar:SetStatusBarColor(r, g, b)
					Castbar.bg:SetVertexColor(r, g, b, 0.25)
				end
			end
		end
	end

	SettingsDB.PostChannelStart = function(Castbar, unit, name, rank, text)
		Castbar.channeling = true
		if unit == "vehicle" then unit = "player" end

		if unit == "player" and db.castbar_latency == true then
			local latency = GetTime() - (Castbar.castSent or 0)
			latency = latency > Castbar.max and Castbar.max or latency
			Castbar.Latency:SetText(("%dms"):format(latency * 1e3))
			Castbar.SafeZone:SetWidth(Castbar:GetWidth() * latency / Castbar.max)
			Castbar.SafeZone:ClearAllPoints()
			Castbar.SafeZone:SetPoint("TOPLEFT")
			Castbar.SafeZone:SetPoint("BOTTOMLEFT")
		end

		local r, g, b, color
		if(UnitIsPlayer(unit)) then
			local _, class = UnitClass(unit)
			color = oUF.colors.class[class]
		else
			local reaction = UnitReaction(unit, "player");
			if reaction then
				r = FACTION_BAR_COLORS[reaction].r;
				g = FACTION_BAR_COLORS[reaction].g;
				b = FACTION_BAR_COLORS[reaction].b;
			else
				r, g, b = 1, 1, 1
			end
		end

		if color then
			r, g, b = color[1], color[2], color[3]
		end
		
		if Castbar.interrupt and UnitCanAttack("player", unit) then
			Castbar:SetStatusBarColor(1, 0, 0)
			Castbar.bg:SetVertexColor(1, 0, 0, 0.25)
		else		
			if unit == "pet" or unit == "vehicle" then
				local _, class = UnitClass("player")
				local r, g, b = unpack(oUF.colors.class[class])
				if db.own_color == true then
					Castbar:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
					Castbar.bg:SetVertexColor(0.1, 0.1, 0.1)
				else
					if b then
						Castbar:SetStatusBarColor(r, g, b)
						Castbar.bg:SetVertexColor(r, g, b, 0.25)
					end
				end
			else
				if db.own_color == true then
					Castbar:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
					Castbar.bg:SetVertexColor(0.1, 0.1, 0.1)
				else
					Castbar:SetStatusBarColor(r, g, b)
					Castbar.bg:SetVertexColor(r, g, b, 0.25)
				end
			end
		end
	end

	SettingsDB.CustomCastTimeText = function(self, duration)
		self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
	end

	SettingsDB.CustomCastDelayText = function(self, duration)
		self.Time:SetText(("%.1f |cffaf5050%s %.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay))
	end

	local FormatTime = function(s)
		local day, hour, minute = 86400, 3600, 60
		if s >= day then
			return format("%dd", floor(s/day + 0.5)), s % day
		elseif s >= hour then
			return format("%dh", floor(s/hour + 0.5)), s % hour
		elseif s >= minute then
			return format("%dm", floor(s/minute + 0.5)), s % minute
		elseif s >= minute / 12 then
			return floor(s + 0.5), (s * 100 - floor(s * 100))/100
		end
		return format("%.1f", s), (s * 100 - floor(s * 100))/100
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

	SettingsDB.AuraTrackerTime = function(self, elapsed)
		if self.active then
			self.timeleft = self.timeleft - elapsed
			if self.timeleft <= 5 then
				self.text:SetTextColor(1, 0, 0)
			else
				self.text:SetTextColor(1, 1, 1)
			end
			if self.timeleft <= 0 then
				self.icon:SetTexture("")
				self.text:SetText("")
			end	
			self.text:SetFormattedText("%.1f", self.timeleft)
		end
	end

	SettingsDB.HideAuraFrame = function(self)
		if self.unit == "player" then
			if not SettingsCF["aura"].player_auras then
				BuffFrame:UnregisterEvent("UNIT_AURA")
				BuffFrame:Hide()
				TemporaryEnchantFrame:Hide()
				self.Debuffs:Hide()
			end
		elseif self.unit == "pet" and not SettingsCF["aura"].pet_debuffs or self.unit == "focus" and not SettingsCF["aura"].focus_debuffs 
		or self.unit == "focustarget" and not SettingsCF["aura"].fot_debuffs or self.unit == "targettarget" and not SettingsCF["aura"].tot_debuffs then
			self.Debuffs:Hide()
		elseif self.unit == "target" and not SettingsCF["aura"].target_auras then
			self.Auras:Hide()
		end
	end
	
	SettingsDB.PostCreateAura = function(element, button)
		SettingsDB.CreateTemplate(button)
		
		button.remaining = SettingsDB.SetFontString(button, SettingsCF["font"].auras_font, SettingsCF["font"].auras_font_size, SettingsCF["font"].auras_font_style)
		button.remaining:SetShadowOffset(SettingsCF["font"].auras_font_shadow and 1 or 0, SettingsCF["font"].auras_font_shadow and -1 or 0)
		button.remaining:SetPoint("CENTER", button, "CENTER", SettingsDB.Scale(2), SettingsDB.Scale(1))
		button.remaining:SetTextColor(1, 1, 1)
		
		button.cd.noOCC = true				-- hide OmniCC CDs
		button.cd.noCooldownCount = true	-- hide CDC CDs
		
		button.icon:SetPoint("TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		button.icon:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.icon:SetDrawLayer("ARTWORK")

		button.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, SettingsDB.Scale(1))
		button.count:SetJustifyH("RIGHT")
		button.count:SetFont(SettingsCF["font"].auras_font, SettingsCF["font"].auras_font_size, SettingsCF["font"].auras_font_style)
		button.count:SetShadowOffset(SettingsCF["font"].auras_font_shadow and 1 or 0, SettingsCF["font"].auras_font_shadow and -1 or 0)
		button.count:SetTextColor(1, 1, 1)

		if SettingsCF["aura"].show_spiral == true then
			element.disableCooldown = false
			button.cd:SetReverse()
			button.overlayFrame = CreateFrame("Frame", nil, button, nil)
			button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
			button.cd:ClearAllPoints()
			button.cd:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			button.cd:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
			button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)
			button.count:SetParent(button.overlayFrame)
			button.remaining:SetParent(button.overlayFrame)
		else
			element.disableCooldown = true
		end
	end

	SettingsDB.PostUpdateIcon = function(icons, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
		local name, _, _, _, dtype, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, icon.filter)
		
		local playerUnits = {
			player = true,
			pet = true,
			vehicle = true,
		}
		
		if icon.debuff then
			if(not UnitIsFriend("player", unit) and not playerUnits[icon.owner]) then
				icon:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
				icon.icon:SetDesaturated(true)
			else
				if SettingsCF["aura"].debuff_color_type == true then
					local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
					icon:SetBackdropBorderColor(color.r, color.g, color.b)
					icon.icon:SetDesaturated(false)
				else
					icon:SetBackdropBorderColor(1, 0, 0)
				end
			end
		else
			if (isStealable or ((SettingsDB.class == "MAGE" or SettingsDB.class == "PRIEST" or SettingsDB.class == "SHAMAN") and dtype == "Magic")) and not UnitIsFriend("player", unit) then
				icon:SetBackdropBorderColor(1, 0.85, 0)
			else
				icon:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
			end
		end

		if duration and duration > 0 and SettingsCF["aura"].show_timer == true then
			icon.remaining:Show()
			icon.timeLeft = expirationTime
			icon:SetScript("OnUpdate", CreateAuraTimer)
		else
			icon.remaining:Hide()
			icon.timeLeft = math.huge
			icon:SetScript("OnUpdate", nil)
		end

		icon.first = true
	end
	
	SettingsDB.HidePortrait = function(self, unit)
		if self.unit == "target" then
			if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then
				self.Portrait:SetAlpha(0)
			else
				self.Portrait:SetAlpha(1)
			end
		end
	end

	SettingsDB.UpdateThreat = function(self, event, unit)
		if self.unit ~= unit then return end
		local threat = UnitThreatSituation(self.unit)
		if threat and threat > 1 then
			r, g, b = GetThreatStatusColor(threat)
			if self.FrameBackdrop then
				self.FrameBackdrop:SetBackdropBorderColor(r, g, b)
			end
		else
			if self.FrameBackdrop then
				self.FrameBackdrop:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
			end
		end 
	end
	
	SettingsDB.CountOffsets = {
		TOPLEFT = {SettingsDB.Scale(9), 0},
		TOPRIGHT = {SettingsDB.Scale(-8), 0},
		BOTTOMLEFT = {SettingsDB.Scale(9), 0},
		BOTTOMRIGHT = {SettingsDB.Scale(-8), 0},
		LEFT = {SettingsDB.Scale(9), 0},
		RIGHT = {SettingsDB.Scale(-8), 0},
		TOP = {0, 0},
		BOTTOM = {0, 0},
	}

	function SettingsDB.CreateAuraWatchIcon(self, icon)
		SettingsDB.CreateTemplate(icon)
		icon.icon:SetPoint("TOPLEFT", SettingsDB.Scale(1), SettingsDB.Scale(-1))
		icon.icon:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-1), SettingsDB.Scale(1))
		icon.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon.icon:SetDrawLayer("ARTWORK")
		if (icon.cd) then
			icon.cd:SetReverse()
		end
		icon.overlay:SetTexture()
	end

	function SettingsDB.CreateAuraWatch(self, unit)
		local auras = CreateFrame("Frame", nil, self)
		auras:SetPoint("TOPLEFT", self.Health, 0, 0)
		auras:SetPoint("BOTTOMRIGHT", self.Health, 0, 0)
		auras.presentAlpha = 1
		auras.missingAlpha = 0
		auras.icons = {}
		auras.PostCreateIcon = SettingsDB.CreateAuraWatchIcon

		if (not SettingsCF["aura"].show_timer) then
			auras.hideCooldown = true
		end

		local buffs = {}

		if (SettingsDB.buffids["ALL"]) then
			for key, value in pairs(SettingsDB.buffids["ALL"]) do
				tinsert(buffs, value)
			end
		end

		if (SettingsDB.buffids[SettingsDB.class]) then
			for key, value in pairs(SettingsDB.buffids[SettingsDB.class]) do
				tinsert(buffs, value)
			end
		end

		if (buffs) then
			for key, spell in pairs(buffs) do
				local icon = CreateFrame("Frame", nil, auras)
				icon.spellID = spell[1]
				icon.anyUnit = spell[4]
				icon:SetWidth(SettingsDB.Scale(7))
				icon:SetHeight(SettingsDB.Scale(7))
				icon:SetPoint(spell[2], 0, 0)

				local tex = icon:CreateTexture(nil, "OVERLAY")
				tex:SetAllPoints(icon)
				tex:SetTexture(SettingsCF["media"].blank)
				if (spell[3]) then
					tex:SetVertexColor(unpack(spell[3]))
				else
					tex:SetVertexColor(0.8, 0.8, 0.8)
				end

				local count = SettingsDB.SetFontString(icon, SettingsCF["font"].unit_frames_font, SettingsCF["font"].unit_frames_font_size, SettingsCF["font"].unit_frames_font_style)
				count:SetPoint("CENTER", unpack(SettingsDB.CountOffsets[spell[2]]))
				icon.count = count

				auras.icons[spell[1]] = icon
			end
		end
		
		self.AuraWatch = auras
	end
end