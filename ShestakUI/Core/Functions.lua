local T, C, L = unpack(select(2, ...))

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
InfoText:SetFont(C.media.normal_font, 25, "OUTLINE")
InfoText:Point("CENTER", UIParent, "CENTER", 0, 90)
InfoText:SetTextColor(0.41, 0.8, 0.94)

T.InfoTextShow = function(s)
	InfoText:SetText(s)
	FadingFrame_Show(InfoFrame)
end

----------------------------------------------------------------------------------------
--	Run slash command function
----------------------------------------------------------------------------------------
T.RunSlashCmd = function(cmd)
	local slash, rest = cmd:match("^(%S+)%s*(.-)$")
	for name, func in pairs(SlashCmdList) do
		local i, slashCmd = 1
		repeat
		slashCmd, i = _G["SLASH_"..name..i], i + 1
		if slashCmd == slash then
			return true, func(rest)
		end
		until not slashCmd
	end
end

----------------------------------------------------------------------------------------
--	Number value function
----------------------------------------------------------------------------------------
T.Round = function(number, decimals)
	if not decimals then decimals = 0 end
	return (("%%.%df"):format(decimals)):format(number)
end

T.ShortValue = function(value)
	if value >= 1e7 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e6 then
		return ("%.2fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e5 then
		return ("%.0fk"):format(value / 1e3)
	elseif value >= 1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

T.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

----------------------------------------------------------------------------------------
--	Pet and shapeshift bars style function
----------------------------------------------------------------------------------------
T.ShiftBarUpdate = function()
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

T.PetBarUpdate = function(self, event)
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
			if not C.actionbar.show_grid then
				petActionButton:SetAlpha(1)
			end
		else
			if not C.actionbar.show_grid then
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
--	Player's Role and Talents spent
----------------------------------------------------------------------------------------
T.CheckForKnownTalent = function(spellid)
	local wanted_name = GetSpellInfo(spellid)
	if not wanted_name then return nil end
	local num_tabs = GetNumTalentTabs()
	for t = 1, num_tabs do
		local num_talents = GetNumTalents(t)
		for i = 1, num_talents do
			local name_talent, _, _, _, current_rank = GetTalentInfo(t, i)
			if name_talent and name_talent == wanted_name then
				if current_rank and current_rank > 0 then
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
	local tree = GetPrimaryTalentTree()
	local resilience
	local resilperc = GetCombatRatingBonus(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)
	if resilperc > GetDodgeChance() and resilperc > GetParryChance() and UnitLevel("player") == MAX_PLAYER_LEVEL then
		resilience = true
	else
		resilience = false
	end
	if ((T.class == "PALADIN" and tree == 2) or 
	(T.class == "WARRIOR" and tree == 3) or 
	(T.class == "DEATHKNIGHT" and tree == 1)) and
	resilience == false or
	(T.class == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
		T.Role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player")
		local playerap = base + posBuff + negBuff

		if (((playerap > playerint) or (playeragi > playerint)) and not (T.class == "SHAMAN" and tree ~= 1 and tree ~= 3) and not (UnitBuff("player", GetSpellInfo(24858)) 
		or UnitBuff("player", GetSpellInfo(65139)))) or T.class == "ROGUE" or T.class == "HUNTER" or (T.class == "SHAMAN" and tree == 2) then
			T.Role = "Melee"
		else
			T.Role = "Caster"
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
T.UTF = function(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if bytes <= i then
		return string
	else
		local len, pos = 0, 1
		while (pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end
		if len == i and pos <= bytes then
			return string:sub(1, pos - 1)..(dots and "..." or "")
		else
			return string
		end
	end
end

----------------------------------------------------------------------------------------
--	Add time before calling a function
----------------------------------------------------------------------------------------
local waitTable = {}
local waitFrame
function T.Delay(delay, func, ...)
	if type(delay) ~= "number" or type(func) ~= "function" then
		return false
	end
	if waitFrame == nil then
		waitFrame = CreateFrame("Frame", "WaitFrame", UIParent)
		waitFrame:SetScript("onUpdate", function(self, elapse)
			local count = #waitTable
			local i = 1
			while (i <= count) do
				local waitRecord = tremove(waitTable, i)
				local d = tremove(waitRecord, 1)
				local f = tremove(waitRecord, 1)
				local p = tremove(waitRecord, 1)
				if d > elapse then
					tinsert(waitTable, i, {d-elapse, f, p})
					i = i + 1
				else
					count = count - 1
					f(unpack(p))
				end
			end
		end)
	end
	tinsert(waitTable, {delay, func, {...}})
	return true
end

----------------------------------------------------------------------------------------
--	Style functions
----------------------------------------------------------------------------------------
T.SkinFuncs = {}
T.SkinFuncs["ShestakUI"] = {}

function T.SkinScrollBar(frame)
	if _G[frame:GetName().."BG"] then _G[frame:GetName().."BG"]:SetTexture(nil) end
	if _G[frame:GetName().."Track"] then _G[frame:GetName().."Track"]:SetTexture(nil) end

	if _G[frame:GetName().."Top"] then
		_G[frame:GetName().."Top"]:SetTexture(nil)
		_G[frame:GetName().."Bottom"]:SetTexture(nil)
		_G[frame:GetName().."Middle"]:SetTexture(nil)
	end
end

local tabs = {
	"LeftDisabled",
	"MiddleDisabled",
	"RightDisabled",
	"Left",
	"Middle",
	"Right",
}

function T.SkinTab(tab)
	if not tab then return end

	for _, object in pairs(tabs) do
		local tex = _G[tab:GetName()..object]
		if tex then
			tex:SetTexture(nil)
		end
	end

	if tab.GetHighlightTexture and tab:GetHighlightTexture() then
		tab:GetHighlightTexture():SetTexture(nil)
	else
		tab:StripTextures()
	end

	tab.backdrop = CreateFrame("Frame", nil, tab)
	tab.backdrop:SetTemplate("Transparent")
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	tab.backdrop:Point("TOPLEFT", 10, -3)
	tab.backdrop:Point("BOTTOMRIGHT", -10, 3)
end

function T.SkinNextPrevButton(btn, horizonal)
	btn:SetTemplate("Overlay")
	btn:Size(btn:GetWidth() - 7, btn:GetHeight() - 7)

	if horizonal then
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
		btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
	else
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end

	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	if btn:GetDisabledTexture() then
		btn:GetDisabledTexture():SetAllPoints(btn:GetNormalTexture())
	end
	if btn:GetPushedTexture() then
		btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	end
	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

function T.SkinRotateButton(btn)
	btn:SetTemplate("Default")
	btn:Size(btn:GetWidth() - 14, btn:GetHeight() - 14)

	btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)
	btn:GetPushedTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)

	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

function T.SkinEditBox(frame)
	if _G[frame:GetName().."Left"] then _G[frame:GetName().."Left"]:Kill() end
	if _G[frame:GetName().."Middle"] then _G[frame:GetName().."Middle"]:Kill() end
	if _G[frame:GetName().."Right"] then _G[frame:GetName().."Right"]:Kill() end
	if _G[frame:GetName().."Mid"] then _G[frame:GetName().."Mid"]:Kill() end
	frame:CreateBackdrop("Overlay")

	if frame:GetName() and frame:GetName():find("Silver") or frame:GetName():find("Copper") then
		frame.backdrop:Point("BOTTOMRIGHT", -12, -2)
	end
end

function T.SkinDropDownBox(frame, width)
	local button = _G[frame:GetName().."Button"]
	if not width then width = 155 end

	frame:StripTextures()
	frame:Width(width)

	_G[frame:GetName().."Text"]:ClearAllPoints()
	_G[frame:GetName().."Text"]:Point("RIGHT", button, "LEFT", -2, 0)

	button:ClearAllPoints()
	button:Point("RIGHT", frame, "RIGHT", -10, 3)
	button.SetPoint = T.dummy

	T.SkinNextPrevButton(button, true)

	frame:CreateBackdrop("Overlay")
	frame:SetFrameLevel(frame:GetFrameLevel() + 2)
	frame.backdrop:Point("TOPLEFT", 20, -2)
	frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
end

function T.SkinCheckBox(frame)
	frame:StripTextures()
	frame:CreateBackdrop("Overlay")
	frame:SetFrameLevel(frame:GetFrameLevel() + 2)
	frame.backdrop:Point("TOPLEFT", 4, -4)
	frame.backdrop:Point("BOTTOMRIGHT", -4, 4)

	if frame.SetCheckedTexture then
		frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end

	if frame.SetDisabledTexture then
		frame:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end

	if not frame:GetChecked() then
		frame:SetDisabledTexture(nil)
	else
		frame:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end

	frame.SetNormalTexture = T.dummy
	frame.SetPushedTexture = T.dummy
	frame.SetHighlightTexture = T.dummy
end

function T.SkinCloseButton(f, point, text)
	f:StripTextures()
	f:SetTemplate("Overlay")
	f:Size(18, 18)

	if not text then text = "x" end
	if not f.text then
		f.text = f:FontString(nil, C.media.normal_font, 17)
		f.text:SetPoint("CENTER", 0, 1)
		f.text:SetText(text)
	end

	if point then
		f:Point("TOPRIGHT", point, "TOPRIGHT", -4, -4)
	else
		f:Point("TOPRIGHT", -4, -4)
	end

	f:HookScript("OnEnter", T.SetModifiedBackdrop)
	f:HookScript("OnLeave", T.SetOriginalBackdrop)
end

local LoadBlizzardSkin = CreateFrame("Frame")
LoadBlizzardSkin:RegisterEvent("ADDON_LOADED")
LoadBlizzardSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.skins.blizzard_frames then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	for _addon, skinfunc in pairs(T.SkinFuncs) do
		if type(skinfunc) == "function" then
			if _addon == addon then
				if skinfunc then
					skinfunc()
				end
			end
		elseif type(skinfunc) == "table" then
			if _addon == addon then
				for _, skinfunc in pairs(T.SkinFuncs[_addon]) do
					if skinfunc then
						skinfunc()
					end
				end
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Unit frames functions
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

T.UpdateAllElements = function(frame)
	for _, v in ipairs(frame.__elements) do
		v(frame, "UpdateElement", frame.unit)
	end
end

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

T.SpawnMenu = function(self)
	local unit = self.unit:gsub("(.)", string.upper, 1)
	if unit == "targettarget" or unit == "focustarget" or unit == "pettarget" then return end

	if _G[unit.."FrameDropDown"] then
		ToggleDropDownMenu(1, nil, _G[unit.."FrameDropDown"], "cursor")
	elseif self.unit:match("party") then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor")
	else
		FriendsDropDown.unit = self.unit
		FriendsDropDown.id = self.id
		FriendsDropDown.initialize = RaidFrameDropDown_Initialize
		ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
	end
end

T.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetShadowOffset(C.font.unit_frames_font_shadow and 1 or 0, C.font.unit_frames_font_shadow and -1 or 0)
	return fs
end

T.PostUpdateHealth = function(health, unit, min, max)
	if unit and unit:find("arena%dtarget") then return end
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
		if (C.unitframe.own_color ~= true and C.unitframe.enemy_health_color and unit == "target" and UnitIsEnemy(unit, "player") and UnitIsPlayer(unit)) or (C.unitframe.own_color ~= true and unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
			local c = T.oUF_colors.reaction[UnitReaction(unit, "player")]
			if c then 
				r, g, b = c[1], c[2], c[3]
				health:SetStatusBarColor(r, g, b)
			else
				r, g, b = 0.3, 0.7, 0.3
				health:SetStatusBarColor(r, g, b)
			end
		end
		if unit == "pet" or unit == "vehicle" then
			local _, class = UnitClass("player")
			local r, g, b = unpack(oUF.colors.class[class])
			if C.unitframe.own_color == true then
				health:SetStatusBarColor(unpack(C.unitframe.uf_color))
				health.bg:SetVertexColor(0.1, 0.1, 0.1)
			else
				if b then
					health:SetStatusBarColor(r, g, b)
				end
			end
		end
		if C.unitframe.bar_color_value == true and not (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
			if C.unitframe.own_color == true then
				r, g, b = C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3]
			else
				r, g, b = health:GetStatusBarColor()
			end
			local newr, newg, newb = oUF.ColorGradient(min / max, 1, 0, 0, 1, 1, 0, r, g, b)

			health:SetStatusBarColor(newr, newg, newb)
			if health.bg and health.bg.multiplier then
				local mu = health.bg.multiplier
				health.bg:SetVertexColor(newr * mu, newg * mu, newb * mu)
			end
		end
		if min ~= max then
			r, g, b = oUF.ColorGradient(min / max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
				if C.unitframe.show_total_value == true then
					if C.unitframe.color_value == true then
						health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5-|r |cff559655%s|r", T.ShortValue(min), T.ShortValue(max))
					else
						health.value:SetFormattedText("|cffffffff%s - %s|r", T.ShortValue(min), T.ShortValue(max))
					end
				else
					if C.unitframe.color_value == true then
						health.value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
					else
						health.value:SetFormattedText("|cffffffff%d - %d%%|r", min, floor(min / max * 100))
					end
				end
			elseif unit == "target" then
				if C.unitframe.show_total_value == true then
					if C.unitframe.color_value == true then
						health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5-|r |cff559655%s|r", T.ShortValue(min), T.ShortValue(max))
					else
						health.value:SetFormattedText("|cffffffff%s - %s|r", T.ShortValue(min), T.ShortValue(max))
					end
				else
					if C.unitframe.color_value == true then
						health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r |cffD7BEA5-|r |cffAF5050%s|r", r * 255, g * 255, b * 255, floor(min / max * 100), T.ShortValue(min))
					else
						health.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), T.ShortValue(min))
					end
				end
			elseif unit and unit:find("boss%d") then
				if C.unitframe.color_value == true then
					health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r |cffD7BEA5-|r |cffAF5050%s|r", r * 255, g * 255, b * 255, floor(min / max * 100), T.ShortValue(min))
				else
					health.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), T.ShortValue(min))
				end
			else
				if C.unitframe.color_value == true then
					health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r", r * 255, g * 255, b * 255, floor(min / max * 100))
				else
					health.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
				end
			end
		else
			if unit == "player" and unit ~= "pet" then
				if C.unitframe.color_value == true then
					health.value:SetText("|cff559655"..max.."|r")
				else
					health.value:SetText("|cffffffff"..max.."|r")
				end
			else
				if C.unitframe.color_value == true then
					health.value:SetText("|cff559655"..T.ShortValue(max).."|r")
				else
					health.value:SetText("|cffffffff"..T.ShortValue(max).."|r")
				end
			end
		end
	end
end

T.PostUpdateRaidHealth = function(health, unit, min, max)
	local self = health:GetParent()
	local power = self.Power
	local border = self.FrameBackdrop
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
		if not UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and C.unitframe.own_color ~= true then
			local c = T.oUF_colors.reaction[5]
			local r, g, b = c[1], c[2], c[3]
			health:SetStatusBarColor(r, g, b)
			health.bg:SetTexture(0.1, 0.1, 0.1)
		end
		if C.unitframe.bar_color_value == true and not (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
			if C.unitframe.own_color == true then
				r, g, b = C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3]
			else
				r, g, b = health:GetStatusBarColor()
			end
			local newr, newg, newb = oUF.ColorGradient(min / max, 1, 0, 0, 1, 1, 0, r, g, b)

			health:SetStatusBarColor(newr, newg, newb)
			if health.bg and health.bg.multiplier then
				local mu = health.bg.multiplier
				health.bg:SetVertexColor(newr * mu, newg * mu, newb * mu)
			end
		end
		if min ~= max then
			r, g, b = oUF.ColorGradient(min / max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if self:GetParent():GetName():match"oUF_PartyDPS" then
				if C.unitframe.color_value == true then
					health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", T.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
				else
					health.value:SetFormattedText("|cffffffff%s - %d%%|r", T.ShortValue(min), floor(min / max * 100))
				end
			else
				if C.unitframe.color_value == true then
					if C.raidframe.deficit_health == true then
						health.value:SetText("|cffffffff".."-"..T.ShortValue(max - min))
					else
						health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r", r * 255, g * 255, b * 255, floor(min / max * 100))
					end
				else
					if C.raidframe.deficit_health == true then
						health.value:SetText("|cffffffff".."-"..T.ShortValue(max - min))
					else
						health.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
					end
				end
			end
		else
			if C.unitframe.color_value == true then
				health.value:SetText("|cff559655"..T.ShortValue(max).."|r")
			else
				health.value:SetText("|cffffffff"..T.ShortValue(max).."|r")
			end
		end
		if C.raidframe.alpha_health == true then
			if min / max > 0.95 then
				health:SetAlpha(0.6)
				power:SetAlpha(0.6)
				border:SetAlpha(0.6)
			else
				health:SetAlpha(1)
				power:SetAlpha(1)
				border:SetAlpha(1)
			end
		end
	end
end

T.PreUpdatePower = function(power, unit)
	local _, pType = UnitPowerType(unit)

	local color = T.oUF_colors.power[pType]
	if color then
		power:SetStatusBarColor(color[1], color[2], color[3])
	end
end

T.PostUpdatePower = function(power, unit, min, max)
	if unit and unit:find("arena%dtarget") then return end
	local self = power:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local color = T.oUF_colors.power[pToken]

	if color then
		power.value:SetTextColor(color[1], color[2], color[3])
	end

	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		power:SetValue(0)
	end

	if unit == "focus" or unit == "focustarget" or unit == "targettarget" or (self:GetParent():GetName():match"oUF_RaidDPS") then return end

	if not UnitIsConnected(unit) then
		power.value:SetText()
	elseif UnitIsDead(unit) or UnitIsGhost(unit) then
		power.value:SetText()
	else
		if min ~= max then
			if pType == 0 then
				if unit == "target" then
					if C.unitframe.show_total_value == true then
						if C.unitframe.color_value == true then
							power.value:SetFormattedText("%s |cffD7BEA5-|r %s", T.ShortValue(max - (max - min)), T.ShortValue(max))
						else
							power.value:SetFormattedText("|cffffffff%s - %s|r", T.ShortValue(max - (max - min)), T.ShortValue(max))
						end
					else
						if C.unitframe.color_value == true then
							power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), T.ShortValue(max - (max - min)))
						else
							power.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), T.ShortValue(max - (max - min)))
						end
					end
				elseif (unit == "player" and power:GetAttribute("normalUnit") == "pet") or unit == "pet" then
					if C.unitframe.show_total_value == true then
						if C.unitframe.color_value == true then
							power.value:SetFormattedText("%s |cffD7BEA5-|r %s", T.ShortValue(max - (max - min)), T.ShortValue(max))
						else
							power.value:SetFormattedText("%s |cffffffff-|r %s", T.ShortValue(max - (max - min)), T.ShortValue(max))
						end
					else
						if C.unitframe.color_value == true then
							power.value:SetFormattedText("%d%%", floor(min / max * 100))
						else
							power.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
						end
					end
				elseif unit and unit:find("arena%d") then
					if C.unitframe.color_value == true then
						power.value:SetFormattedText("|cffD7BEA5%d%% - %s|r", floor(min / max * 100), T.ShortValue(max - (max - min)))
					else
						power.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), T.ShortValue(max - (max - min)))
					end
				elseif self:GetParent():GetName():match"oUF_PartyDPS" then
					if C.unitframe.color_value == true then
						power.value:SetFormattedText("%s |cffD7BEA5-|r %d%%", T.ShortValue(max - (max - min)), floor(min / max * 100))
					else
						power.value:SetFormattedText("|cffffffff%s - %d%%|r", T.ShortValue(max - (max - min)), floor(min / max * 100))
					end
				else
					if C.unitframe.show_total_value == true then
						if C.unitframe.color_value == true then
							power.value:SetFormattedText("%s |cffD7BEA5-|r %s", T.ShortValue(max - (max - min)), T.ShortValue(max))
						else
							power.value:SetFormattedText("|cffffffff%s - %s|r", T.ShortValue(max - (max - min)), T.ShortValue(max))
						end
					else
						if C.unitframe.color_value == true then
							power.value:SetFormattedText("%d |cffD7BEA5-|r %d%%", max - (max - min), floor(min / max * 100))
						else
							power.value:SetFormattedText("|cffffffff%d - %d%%|r", max - (max - min), floor(min / max * 100))
						end
					end
				end
			else
				if C.unitframe.color_value == true then
					power.value:SetText(max - (max - min))
				else
					power.value:SetText("|cffffffff"..max - (max - min).."|r")
				end
			end
		else
			if unit == "pet" or unit == "target" or (unit and unit:find("arena%d")) or (self:GetParent():GetName():match"oUF_PartyDPS") then
				if C.unitframe.color_value == true then
					power.value:SetText(T.ShortValue(min))
				else
					power.value:SetText("|cffffffff"..T.ShortValue(min).."|r")
				end
			else
				if C.unitframe.color_value == true then
					power.value:SetText(min)
				else
					power.value:SetText("|cffffffff"..min.."|r")
				end
			end
		end
	end
end

local UpdateManaLevelDelay = 0
T.UpdateManaLevel = function(self, elapsed)
	UpdateManaLevelDelay = UpdateManaLevelDelay + elapsed
	if self.parent.unit ~= "player" or UpdateManaLevelDelay < 0.2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
	UpdateManaLevelDelay = 0

	local percMana = UnitMana("player") / UnitManaMax("player") * 100

	if percMana <= 20 then
		self.ManaLevel:SetText("|cffaf5050"..MANA_LOW.."|r")
		Flash(self, 0.3)
	else
		self.ManaLevel:SetText()
		StopFlash(self)
	end
end

T.UpdateDruidMana = function(self)
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
				self.DruidMana:Point("RIGHT", self.Power.value, "LEFT", -1, 0)
				self.DruidMana:SetFormattedText("%d%%|r |cffD7BEA5-|r", floor(min / max * 100))
				self.DruidMana:SetJustifyH("RIGHT")
			else
				self.DruidMana:Point("LEFT", self.Power, "LEFT", 4, 1)
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

T.UpdatePvPStatus = function(self, elapsed)
	if self.elapsed and self.elapsed > 0.2 then
		local unit = self.unit
		local time = GetPVPTimer()

		local min = format("%01.f", floor((time / 1000) / 60))
		local sec = format("%02.f", floor((time / 1000) - min * 60))
		if self.Status then
			local factionGroup = UnitFactionGroup(unit)
			if UnitIsPVPFreeForAll(unit) then
				if time ~= 301000 and time ~= -1 then
					self.Status:SetText(PVP.." ".."["..min..":"..sec.."]")
				else
					self.Status:SetText(PVP)
				end
			elseif factionGroup and UnitIsPVP(unit) then
				if time ~= 301000 and time ~= -1 then
					self.Status:SetText(PVP.." ".."["..min..":"..sec.."]")
				else
					self.Status:SetText(PVP)
				end
			else
				self.Status:SetText("")
			end
		end
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
end

T.UpdateShards = function(self, event, unit, powerType)
	if self.unit ~= unit or (powerType and powerType ~= "SOUL_SHARDS") then return end
	local num = UnitPower(unit, SPELL_POWER_SOUL_SHARDS)
	for i = 1, SHARD_BAR_NUM_SHARDS do
		if i <= num then
			self.SoulShards[i]:SetAlpha(1)
		else
			self.SoulShards[i]:SetAlpha(0.2)
		end
	end
end

T.Phasing = function(self, event)
	local inPhase = UnitInPhase(self.unit)
	local picon = self.PhaseIcon

	if not UnitIsPlayer(self.unit) then picon:Hide() return end
end

T.UpdateHoly = function(self, event, unit, powerType)
	if self.unit ~= unit or (powerType and powerType ~= "HOLY_POWER") then return end
	local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
	for i = 1, MAX_HOLY_POWER do
		if i <= num then
			self.HolyPower[i]:SetAlpha(1)
		else
			self.HolyPower[i]:SetAlpha(0.2)
		end
	end
end

T.EclipseDirection = function(self)
	if GetEclipseDirection() == "sun" then
		self.Text:SetText("|cff4478BC>>|r")
	elseif GetEclipseDirection() == "moon" then
		self.Text:SetText("|cffE5994C<<|r")
	else
		self.Text:SetText("")
	end
end

T.UpdateEclipse = function(self, login)
	local eb = self.EclipseBar
	local txt = self.EclipseBar.Text

	if login then
		eb:SetScript("OnUpdate", nil)
	end

	if eb:IsShown() then
		txt:Show()
		if self.Debuffs then self.Debuffs:Point("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
	else
		txt:Hide()
		if self.Debuffs then self.Debuffs:Point("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
	end
end

T.UpdateReputationColor = function(self, event, unit, bar)
	local name, id = GetWatchedFactionInfo()
	bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
	bar.bg:SetVertexColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b, 0.25)
end

T.UpdateComboPoint = function(self, event, unit)
	if unit == "pet" then return end

	local cpoints = self.CPoints
	local cp
	if UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle") then
		cp = GetComboPoints("vehicle", "target")
	else
		cp = GetComboPoints("player", "target")
	end

	for i = 1, MAX_COMBO_POINTS do
		if i <= cp then
			cpoints[i]:SetAlpha(1)
		else
			cpoints[i]:SetAlpha(0.2)
		end
	end

	if cpoints[1]:GetAlpha() == 1 then
		for i = 1, MAX_COMBO_POINTS do
			cpoints[i]:Show()
		end
	else
		for i = 1, MAX_COMBO_POINTS do
			cpoints[i]:Hide()
		end
	end

	if cpoints[1]:IsShown() then
		if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
	else
		if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5) end
	end
end

T.PostCastStart = function(Castbar, unit, name, rank, text, castid)
	Castbar.channeling = false
	if unit == "vehicle" then unit = "player" end

	if unit == "player" and C.unitframe.castbar_latency == true then
		local latency = GetTime() - (Castbar.castSent or 0)
		latency = latency > Castbar.max and Castbar.max or latency
		Castbar.Latency:SetText(("%dms"):format(latency * 1e3))
		Castbar.SafeZone:SetWidth(Castbar:GetWidth() * latency / Castbar.max)
		Castbar.SafeZone:ClearAllPoints()
		Castbar.SafeZone:SetPoint("TOPRIGHT")
		Castbar.SafeZone:SetPoint("BOTTOMRIGHT")
	end

	local r, g, b, color
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		color = oUF.colors.class[class]
	else
		local reaction = T.oUF_colors.reaction[UnitReaction(unit, "player")]
		if reaction then
			r, g, b = reaction[1], reaction[2], reaction[3]
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
			if C.unitframe.own_color == true then
				Castbar:SetStatusBarColor(unpack(C.unitframe.uf_color))
				Castbar.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.25)
			else
				if b then
					Castbar:SetStatusBarColor(r, g, b)
					Castbar.bg:SetVertexColor(r, g, b, 0.25)
				end
			end
		else
			if C.unitframe.own_color == true then
				Castbar:SetStatusBarColor(unpack(C.unitframe.uf_color))
				Castbar.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.25)
			else
				Castbar:SetStatusBarColor(r, g, b)
				Castbar.bg:SetVertexColor(r, g, b, 0.25)
			end
		end
	end
end

T.PostChannelStart = function(Castbar, unit, name, rank, text)
	Castbar.channeling = true
	if unit == "vehicle" then unit = "player" end

	if unit == "player" and C.unitframe.castbar_latency == true then
		local latency = GetTime() - (Castbar.castSent or 0)
		latency = latency > Castbar.max and Castbar.max or latency
		Castbar.Latency:SetText(("%dms"):format(latency * 1e3))
		Castbar.SafeZone:SetWidth(Castbar:GetWidth() * latency / Castbar.max)
		Castbar.SafeZone:ClearAllPoints()
		Castbar.SafeZone:SetPoint("TOPLEFT")
		Castbar.SafeZone:SetPoint("BOTTOMLEFT")
	end

	local r, g, b, color
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		color = oUF.colors.class[class]
	else
		local reaction = T.oUF_colors.reaction[UnitReaction(unit, "player")]
		if reaction then
			r, g, b = reaction[1], reaction[2], reaction[3]
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
			if C.unitframe.own_color == true then
				Castbar:SetStatusBarColor(unpack(C.unitframe.uf_color))
				Castbar.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.25)
			else
				if b then
					Castbar:SetStatusBarColor(r, g, b)
					Castbar.bg:SetVertexColor(r, g, b, 0.25)
				end
			end
		else
			if C.unitframe.own_color == true then
				Castbar:SetStatusBarColor(unpack(C.unitframe.uf_color))
				Castbar.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.25)
			else
				Castbar:SetStatusBarColor(r, g, b)
				Castbar.bg:SetVertexColor(r, g, b, 0.25)
			end
		end
	end
end

T.CustomCastTimeText = function(self, duration)
	self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
end

T.CustomCastDelayText = function(self, duration)
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

T.AuraTrackerTime = function(self, elapsed)
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

T.HideAuraFrame = function(self)
	if self.unit == "player" then
		if not C.aura.player_auras then
			BuffFrame:UnregisterEvent("UNIT_AURA")
			BuffFrame:Hide()
			TemporaryEnchantFrame:Hide()
			self.Debuffs:Hide()
		end
	elseif self.unit == "pet" and not C.aura.pet_debuffs or self.unit == "focus" and not C.aura.focus_debuffs 
	or self.unit == "focustarget" and not C.aura.fot_debuffs or self.unit == "targettarget" and not C.aura.tot_debuffs then
		self.Debuffs:Hide()
	elseif self.unit == "target" and not C.aura.target_auras then
		self.Auras:Hide()
	end
end

T.PostCreateAura = function(element, button)
	button:SetTemplate("Default")

	button.remaining = T.SetFontString(button, C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
	button.remaining:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
	button.remaining:Point("CENTER", button, "CENTER", 1, 1)
	button.remaining:SetJustifyH("CENTER")
	button.remaining:SetTextColor(1, 1, 1)

	button.cd.noOCC = true
	button.cd.noCooldownCount = true

	button.icon:Point("TOPLEFT", 2, -2)
	button.icon:Point("BOTTOMRIGHT", -2, 2)
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.icon:SetDrawLayer("ARTWORK")

	button.count:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 1)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
	button.count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
	button.count:SetTextColor(1, 1, 1)

	if C.aura.show_spiral == true then
		element.disableCooldown = false
		button.cd:SetReverse()
		button.overlayFrame = CreateFrame("Frame", nil, button, nil)
		button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
		button.cd:ClearAllPoints()
		button.cd:Point("TOPLEFT", button, "TOPLEFT", 2, -2)
		button.cd:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
		button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)
		button.count:SetParent(button.overlayFrame)
		button.remaining:SetParent(button.overlayFrame)
	else
		element.disableCooldown = true
	end
end

T.PostUpdateIcon = function(icons, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
	local name, _, _, _, dtype, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, icon.filter)

	local playerUnits = {
		player = true,
		pet = true,
		vehicle = true,
	}

	if icon.debuff then
		if not UnitIsFriend("player", unit) and not playerUnits[icon.owner] then
			icon:SetBackdropBorderColor(unpack(C.media.border_color))
			icon.icon:SetDesaturated(true)
		else
			if C.aura.debuff_color_type == true then
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				icon:SetBackdropBorderColor(color.r, color.g, color.b)
				icon.icon:SetDesaturated(false)
			else
				icon:SetBackdropBorderColor(1, 0, 0)
			end
		end
	else
		if (isStealable or ((T.class == "MAGE" or T.class == "PRIEST" or T.class == "SHAMAN" or T.class == "HUNTER") and dtype == "Magic")) and not UnitIsFriend("player", unit) then
			icon:SetBackdropBorderColor(1, 0.85, 0)
		else
			icon:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end

	if duration and duration > 0 and C.aura.show_timer == true then
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

T.UpdateThreat = function(self, event, unit)
	if self.unit ~= unit then return end
	local threat = UnitThreatSituation(self.unit)
	if threat and threat > 1 then
		r, g, b = GetThreatStatusColor(threat)
		if self.FrameBackdrop then
			self.FrameBackdrop:SetBackdropBorderColor(r, g, b)
		end
	else
		if self.FrameBackdrop then
			self.FrameBackdrop:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end 
end

T.CountOffsets = {
	TOPLEFT = {9, 0},
	TOPRIGHT = {-8, 0},
	BOTTOMLEFT = {9, 0},
	BOTTOMRIGHT = {-8, 0},
	LEFT = {9, 0},
	RIGHT = {-8, 0},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

T.CreateAuraWatchIcon = function(self, icon)
	icon:SetTemplate("Default")
	icon.icon:Point("TOPLEFT", icon, 1, -1)
	icon.icon:Point("BOTTOMRIGHT", icon, -1, 1)
	icon.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon.icon:SetDrawLayer("ARTWORK")
	if icon.cd then
		icon.cd:SetReverse()
	end
	icon.overlay:SetTexture()
end

T.CreateAuraWatch = function(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:Point("TOPLEFT", self.Health, 0, 0)
	auras:Point("BOTTOMRIGHT", self.Health, 0, 0)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
	auras.PostCreateIcon = T.CreateAuraWatchIcon

	if not C.aura.show_timer then
		auras.hideCooldown = true
	end

	local buffs = {}

	if T.buffids["ALL"] then
		for key, value in pairs(T.buffids["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if T.buffids[T.class] then
		for key, value in pairs(T.buffids[T.class]) do
			tinsert(buffs, value)
		end
	end

	if buffs then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon:Width(7)
			icon:Height(7)
			icon:Point(spell[2], 0, 0)

			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(C.media.blank)
			if spell[3] then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end

			local count = T.SetFontString(icon, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			count:Point("CENTER", unpack(T.CountOffsets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end
	
	self.AuraWatch = auras
end