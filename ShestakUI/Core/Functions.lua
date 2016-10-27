local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Number value function
----------------------------------------------------------------------------------------
T.Round = function(number, decimals)
	if not decimals then decimals = 0 end
	return (("%%.%df"):format(decimals)):format(number)
end

T.ShortValue = function(value)
	if value >= 1e8 then
		return ("%.0fm"):format(value / 1e6)
	elseif value >= 1e7 then
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
	r = tonumber(r) <= 1 and tonumber(r) >= 0 and tonumber(r) or 0
	g = tonumber(g) <= tonumber(g) and tonumber(g) >= 0 and tonumber(g) or 0
	b = tonumber(b) <= 1 and tonumber(b) >= 0 and tonumber(b) or 0
	return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

----------------------------------------------------------------------------------------
--	Chat channel check
----------------------------------------------------------------------------------------
T.CheckChat = function(warning)
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
		return "INSTANCE_CHAT"
	elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
		if warning and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or IsEveryoneAssistant()) then
			return "RAID_WARNING"
		else
			return "RAID"
		end
	elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
		return "PARTY"
	end
	return "SAY"
end

----------------------------------------------------------------------------------------
--	Player's role check
----------------------------------------------------------------------------------------
local isCaster = {
	DEATHKNIGHT = {nil, nil, nil},
	DEMONHUNTER = {nil, nil},
	DRUID = {true},					-- Balance
	HUNTER = {nil, nil, nil},
	MAGE = {true, true, true},
	MONK = {nil, nil, nil},
	PALADIN = {nil, nil, nil},
	PRIEST = {nil, nil, true},		-- Shadow
	ROGUE = {nil, nil, nil},
	SHAMAN = {true},				-- Elemental
	WARLOCK = {true, true, true},
	WARRIOR = {nil, nil, nil}
}

local function CheckRole(self, event, unit)
	local spec = GetSpecialization()
	local role = spec and GetSpecializationRole(spec)

	if role == "TANK" then
		T.Role = "Tank"
	elseif role == "HEALER" then
		T.Role = "Healer"
	elseif role == "DAMAGER" then
		if isCaster[T.class][spec] then
			T.Role = "Caster"
		else
			T.Role = "Melee"
		end
	end
end
local RoleUpdater = CreateFrame("Frame")
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:SetScript("OnEvent", CheckRole)

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
--	Style functions
----------------------------------------------------------------------------------------
T.SkinFuncs = {}
T.SkinFuncs["ShestakUI"] = {}

function T.SkinScrollBar(frame, parent)
	if frame:GetName() then
		if _G[frame:GetName().."BG"] then
			_G[frame:GetName().."BG"]:SetTexture(nil)
		end
		if _G[frame:GetName().."Track"] then
			_G[frame:GetName().."Track"]:SetTexture(nil)
		end
		if _G[frame:GetName().."Top"] then
			_G[frame:GetName().."Top"]:SetTexture(nil)
		end
		if _G[frame:GetName().."Bottom"] then
			_G[frame:GetName().."Bottom"]:SetTexture(nil)
		end
		if _G[frame:GetName().."Middle"] then
			_G[frame:GetName().."Middle"]:SetTexture(nil)
		end
	end

	if frame.Background then frame.Background:SetTexture(nil) end
	if frame.trackBG then frame.trackBG:SetTexture(nil) end
	if frame.Middle then frame.Middle:SetTexture(nil) end
	if frame.Top then frame.Top:SetTexture(nil) end
	if frame.Bottom then frame.Bottom:SetTexture(nil) end
	if frame.ScrollBarTop then frame.ScrollBarTop:SetTexture(nil) end
	if frame.ScrollBarBottom then frame.ScrollBarBottom:SetTexture(nil) end
	if frame.ScrollBarMiddle then frame.ScrollBarMiddle:SetTexture(nil) end

	local UpButton = frame.ScrollUpButton or frame.UpButton or _G[(frame:GetName() or parent).."ScrollUpButton"]
	local DownButton = frame.ScrollDownButton or frame.DownButton or _G[(frame:GetName() or parent).."ScrollDownButton"]
	local ThumbTexture = frame.ThumbTexture or frame.thumbTexture or _G[frame:GetName().."ThumbTexture"]

	if UpButton and DownButton then
		if not UpButton.icon then
			T.SkinNextPrevButton(UpButton, nil, "Up")
			UpButton:SetSize(UpButton:GetWidth() + 7, UpButton:GetHeight() + 7)
		end

		if not DownButton.icon then
			T.SkinNextPrevButton(DownButton, nil, "Down")
			DownButton:SetSize(DownButton:GetWidth() + 7, DownButton:GetHeight() + 7)
		end

		if ThumbTexture then
			ThumbTexture:SetTexture(nil)
			if not frame.thumbbg then
				frame.thumbbg = CreateFrame("Frame", nil, frame)
				frame.thumbbg:SetPoint("TOPLEFT", ThumbTexture, "TOPLEFT", 0, -3)
				frame.thumbbg:SetPoint("BOTTOMRIGHT", ThumbTexture, "BOTTOMRIGHT", 0, 3)
				frame.thumbbg:SetTemplate("Overlay")

				frame:HookScript("OnShow", function()
					local _, maxValue = frame:GetMinMaxValues()
					if maxValue == 0 then
						frame:SetAlpha(0)
					else
						frame:SetAlpha(1)
					end
				end)

				frame:HookScript("OnMinMaxChanged", function()
					local _, maxValue = frame:GetMinMaxValues()
					if maxValue == 0 then
						frame:SetAlpha(0)
					else
						frame:SetAlpha(1)
					end
				end)

				frame:HookScript("OnDisable", function()
					frame:SetAlpha(0)
				end)

				frame:HookScript("OnEnable", function()
					frame:SetAlpha(1)
				end)
			end
		end
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

function T.SkinTab(tab, bg)
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
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	if bg then
		tab.backdrop:SetTemplate("Overlay")
		tab.backdrop:SetPoint("TOPLEFT", 3, -7)
		tab.backdrop:SetPoint("BOTTOMRIGHT", -3, 2)
	else
		tab.backdrop:SetTemplate("Transparent")
		tab.backdrop:SetPoint("TOPLEFT", 10, -3)
		tab.backdrop:SetPoint("BOTTOMRIGHT", -10, 3)
	end
end

function T.SkinNextPrevButton(btn, left, scroll)
	local normal, pushed, disabled
	local isPrevButton = btn:GetName() and (string.find(btn:GetName(), "Left") or string.find(btn:GetName(), "Prev") or string.find(btn:GetName(), "Decrement") or string.find(btn:GetName(), "Back")) or left
	local isScrollUpButton = btn:GetName() and string.find(btn:GetName(), "ScrollUp") or scroll == "Up"
	local isScrollDownButton = btn:GetName() and string.find(btn:GetName(), "ScrollDown") or scroll == "Down"

	if btn:GetNormalTexture() then
		normal = btn:GetNormalTexture():GetTexture()
	end

	if btn:GetPushedTexture() then
		pushed = btn:GetPushedTexture():GetTexture()
	end

	if btn:GetDisabledTexture() then
		disabled = btn:GetDisabledTexture():GetTexture()
	end

	btn:StripTextures()

	if scroll == "Up" or scroll == "Down" then
		normal = nil
		pushed = nil
		disabled = nil
	end

	if not normal then
		if isPrevButton then
			normal = "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up"
		elseif isScrollUpButton then
			normal = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up"
		elseif isScrollDownButton then
			normal = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up"
		else
			normal = "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up"
		end
	end

	if not pushed then
		if isPrevButton then
			pushed = "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down"
		elseif isScrollUpButton then
			pushed = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Down"
		elseif isScrollDownButton then
			pushed = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down"
		else
			pushed = "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down"
		end
	end

	if not disabled then
		if isPrevButton then
			disabled = "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled"
		elseif isScrollUpButton then
			disabled = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Disabled"
		elseif isScrollDownButton then
			disabled = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled"
		else
			disabled = "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled"
		end
	end

	btn:SetNormalTexture(normal)
	btn:SetPushedTexture(pushed)
	btn:SetDisabledTexture(disabled)

	btn:SetTemplate("Overlay")
	btn:SetSize(btn:GetWidth() - 7, btn:GetHeight() - 7)

	if normal and pushed and disabled then
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end

		btn:GetNormalTexture():ClearAllPoints()
		btn:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
		btn:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetAllPoints(btn:GetNormalTexture())
		end
		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
		end
		btn:GetHighlightTexture():SetColorTexture(1, 1, 1, 0.3)
		btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
	end
end

function T.SkinRotateButton(btn)
	btn:SetTemplate("Default")
	btn:SetSize(btn:GetWidth() - 14, btn:GetHeight() - 14)

	btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)
	btn:GetPushedTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)

	btn:GetHighlightTexture():SetColorTexture(1, 1, 1, 0.3)

	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	btn:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
	btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

function T.SkinEditBox(frame, width, height)
	if _G[frame:GetName()] then
		if _G[frame:GetName().."Left"] then _G[frame:GetName().."Left"]:Kill() end
		if _G[frame:GetName().."Middle"] then _G[frame:GetName().."Middle"]:Kill() end
		if _G[frame:GetName().."Right"] then _G[frame:GetName().."Right"]:Kill() end
		if _G[frame:GetName().."Mid"] then _G[frame:GetName().."Mid"]:Kill() end
	end

	if frame.Left then frame.Left:Kill() end
	if frame.Right then frame.Right:Kill() end
	if frame.Middle then frame.Middle:Kill() end

	if frame.LeftTexture then frame.LeftTexture:Kill() end
	if frame.RightTexture then frame.RightTexture:Kill() end
	if frame.MiddleTexture then frame.MiddleTexture:Kill() end

	frame:CreateBackdrop("Overlay")

	if frame:GetName() and (frame:GetName():find("Gold") or frame:GetName():find("Silver") or frame:GetName():find("Copper")) then
		if frame:GetName():find("Gold") then
			frame.backdrop:SetPoint("TOPLEFT", -3, 1)
			frame.backdrop:SetPoint("BOTTOMRIGHT", -3, 0)
		else
			frame.backdrop:SetPoint("TOPLEFT", -3, 1)
			frame.backdrop:SetPoint("BOTTOMRIGHT", -13, 0)
		end
	end

	if width then frame:SetWidth(width) end
	if height then frame:SetHeight(height) end
end

function T.SkinDropDownBox(frame, width)
	local button = _G[frame:GetName().."Button"] or _G[frame:GetName().."_Button"]
	if not width then width = 155 end

	frame:StripTextures()
	frame:SetWidth(width)

	if _G[frame:GetName().."Text"] then
		_G[frame:GetName().."Text"]:ClearAllPoints()
		_G[frame:GetName().."Text"]:SetPoint("RIGHT", button, "LEFT", -2, 0)
	end

	button:ClearAllPoints()
	button:SetPoint("RIGHT", frame, "RIGHT", -10, 3)
	button.SetPoint = T.dummy
	scrolldn = false
	T.SkinNextPrevButton(button)

	frame:CreateBackdrop("Overlay")
	frame:SetFrameLevel(frame:GetFrameLevel() + 2)
	frame.backdrop:SetPoint("TOPLEFT", 20, -2)
	frame.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
end

function T.SkinCheckBox(frame, default)
	frame:SetNormalTexture("")
	frame:SetPushedTexture("")
	frame:CreateBackdrop("Overlay")
	frame:SetFrameLevel(frame:GetFrameLevel() + 2)
	frame.backdrop:SetPoint("TOPLEFT", 4, -4)
	frame.backdrop:SetPoint("BOTTOMRIGHT", -4, 4)

	if frame.SetHighlightTexture then
		local highligh = frame:CreateTexture(nil, nil, self)
		highligh:SetColorTexture(1, 1, 1, 0.3)
		highligh:SetPoint("TOPLEFT", frame, 6, -6)
		highligh:SetPoint("BOTTOMRIGHT", frame, -6, 6)
		frame:SetHighlightTexture(highligh)
	end

	if frame.SetCheckedTexture then
		if default then return end
		local checked = frame:CreateTexture(nil, nil, self)
		checked:SetColorTexture(1, 0.82, 0, 0.8)
		checked:SetPoint("TOPLEFT", frame, 6, -6)
		checked:SetPoint("BOTTOMRIGHT", frame, -6, 6)
		frame:SetCheckedTexture(checked)
	end

	if frame.SetDisabledCheckedTexture then
		local disabled = frame:CreateTexture(nil, nil, self)
		disabled:SetColorTexture(0.6, 0.6, 0.6, 0.75)
		disabled:SetPoint("TOPLEFT", frame, 6, -6)
		disabled:SetPoint("BOTTOMRIGHT", frame, -6, 6)
		frame:SetDisabledCheckedTexture(disabled)
	end

	frame:HookScript("OnDisable", function(self)
		if not self.SetDisabledTexture then return end
		if self:GetChecked() then
			self:SetDisabledTexture(disabled)
		else
			self:SetDisabledTexture("")
		end
	end)
end

function T.SkinCloseButton(f, point, text, pixel)
	f:StripTextures()
	f:SetTemplate("Overlay")
	f:SetSize(18, 18)

	if not text then text = "x" end
	if not f.text then
		if pixel then
			f.text = f:FontString(nil, C.media.pixel_font, 8)
			f.text:SetPoint("CENTER", 0, 0)
		else
			f.text = f:FontString(nil, C.media.normal_font, 17)
			f.text:SetPoint("CENTER", 0, 1)
		end
		f.text:SetText(text)
	end

	if point then
		f:SetPoint("TOPRIGHT", point, "TOPRIGHT", -4, -4)
	else
		f:SetPoint("TOPRIGHT", -4, -4)
	end

	f:HookScript("OnEnter", T.SetModifiedBackdrop)
	f:HookScript("OnLeave", T.SetOriginalBackdrop)
end

function T.HandleIcon(icon, parent)
	parent = parent or icon:GetParent()

	parent:CreateBackdrop("Default")
	parent.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
	parent.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)

	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:SetParent(parent)
end

function T.SkinSlider(f)
	f:SetBackdrop(nil)

	local bd = CreateFrame("Frame", nil, f)
	bd:SetTemplate("Overlay")
	if f:GetOrientation() == "VERTICAL" then
		bd:SetPoint("TOPLEFT", -2, -6)
		bd:SetPoint("BOTTOMRIGHT", 2, 6)
	else
		bd:SetPoint("TOPLEFT", 14, -2)
		bd:SetPoint("BOTTOMRIGHT", -15, 3)
	end
	bd:SetFrameLevel(f:GetFrameLevel() - 1)

	local slider = select(4, f:GetRegions())
	slider:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	slider:SetBlendMode("ADD")
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
if C.unitframe.enable ~= true then return end
local _, ns = ...
local oUF = ns.oUF

T.UpdateAllElements = function(frame)
	for _, v in ipairs(frame.__elements) do
		v(frame, "UpdateElement", frame.unit)
	end
end

local SetUpAnimGroup = function(self)
	self.anim = self:CreateAnimationGroup()
	self.anim:SetLooping("BOUNCE")
	self.anim.fade = self.anim:CreateAnimation("Alpha")
	self.anim.fade:SetFromAlpha(1)
	self.anim.fade:SetToAlpha(0)
	self.anim.fade:SetDuration(0.6)
	self.anim.fade:SetSmoothing("IN_OUT")
end

local Flash = function(self)
	if not self.anim then
		SetUpAnimGroup(self)
	end

	if not self.anim:IsPlaying() then
		self.anim:Play()
	end
end

local StopFlash = function(self)
	if self.anim then
		self.anim:Finish()
	end
end

T.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "ARTWORK")
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
			local r, g, b = unpack(T.oUF_colors.class[class])
			if C.unitframe.own_color == true then
				health:SetStatusBarColor(unpack(C.unitframe.uf_color))
				health.bg:SetVertexColor(0.1, 0.1, 0.1)
			else
				if b then
					health:SetStatusBarColor(r, g, b)
					if health.bg and health.bg.multiplier then
						local mu = health.bg.multiplier
						health.bg:SetVertexColor(r * mu, g * mu, b * mu)
					end
				end
			end
		end
		if C.unitframe.bar_color_value == true and not UnitIsTapDenied(unit) then
			if C.unitframe.own_color == true then
				r, g, b = C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3]
			else
				r, g, b = health:GetStatusBarColor()
			end
			local newr, newg, newb = oUF.ColorGradient(min, max, 1, 0, 0, 1, 1, 0, r, g, b)

			health:SetStatusBarColor(newr, newg, newb)
			if health.bg and health.bg.multiplier then
				local mu = health.bg.multiplier
				health.bg:SetVertexColor(newr * mu, newg * mu, newb * mu)
			end
		end
		if min ~= max then
			r, g, b = oUF.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
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
	local border = self.backdrop
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
			if health.bg and health.bg.multiplier then
				local mu = health.bg.multiplier
				health.bg:SetVertexColor(r * mu, g * mu, b * mu)
			end
		end
		if C.unitframe.bar_color_value == true and not UnitIsTapDenied(unit) then
			if C.unitframe.own_color == true then
				r, g, b = C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3]
			else
				r, g, b = health:GetStatusBarColor()
			end
			local newr, newg, newb = oUF.ColorGradient(min, max, 1, 0, 0, 1, 1, 0, r, g, b)

			health:SetStatusBarColor(newr, newg, newb)
			if health.bg and health.bg.multiplier then
				local mu = health.bg.multiplier
				health.bg:SetVertexColor(newr * mu, newg * mu, newb * mu)
			end
		end
		if min ~= max then
			r, g, b = oUF.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if self:GetParent():GetName():match("oUF_PartyDPS") then
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
	local _, pToken = UnitPowerType(unit)

	local color = T.oUF_colors.power[pToken]
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

	if unit == "focus" or unit == "focustarget" or unit == "targettarget" or (self:GetParent():GetName():match("oUF_RaidDPS")) then return end

	if not UnitIsConnected(unit) then
		power.value:SetText()
	elseif UnitIsDead(unit) or UnitIsGhost(unit) or max == 0 then
		power.value:SetText()
	else
		if min ~= max then
			if pType == 0 and pToken ~= "POWER_TYPE_DINO_SONIC" then
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
				elseif unit and (unit:find("arena%d") or unit:find("boss%d")) then
					if C.unitframe.color_value == true then
						power.value:SetFormattedText("|cffD7BEA5%d%% - %s|r", floor(min / max * 100), T.ShortValue(max - (max - min)))
					else
						power.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), T.ShortValue(max - (max - min)))
					end
				elseif self:GetParent():GetName():match("oUF_PartyDPS") then
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
			if unit == "pet" or unit == "target" or (unit and unit:find("arena%d")) or (self:GetParent():GetName():match("oUF_PartyDPS")) then
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

T.UpdateManaLevel = function(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < 0.2 then return end
	self.elapsed = 0

	if UnitPowerType("player") == 0 then
		local percMana = UnitMana("player") / UnitManaMax("player") * 100
		if percMana <= 20 and not UnitIsDeadOrGhost("player") then
			self.ManaLevel:SetText("|cffaf5050"..MANA_LOW.."|r")
			Flash(self)
		else
			self.ManaLevel:SetText()
			StopFlash(self)
		end
	elseif T.class ~= "DRUID" and T.class ~= "PRIEST" and T.class ~= "SHAMAN" then
		self.ManaLevel:SetText()
		StopFlash(self)
	end
end

T.UpdateClassMana = function(self)
	if self.unit ~= "player" then return end

	if UnitPowerType("player") ~= 0 then
		local min = UnitPower("player", 0)
		local max = UnitPowerMax("player", 0)

		local percMana = min / max * 100
		if percMana <= 20 and not UnitIsDeadOrGhost("player") then
			self.FlashInfo.ManaLevel:SetText("|cffaf5050"..MANA_LOW.."|r")
			Flash(self.FlashInfo)
		else
			self.FlashInfo.ManaLevel:SetText()
			StopFlash(self.FlashInfo)
		end

		if min ~= max then
			if self.Power.value:GetText() then
				self.ClassMana:SetPoint("RIGHT", self.Power.value, "LEFT", -1, 0)
				self.ClassMana:SetFormattedText("%d%%|r |cffD7BEA5-|r", floor(min / max * 100))
				self.ClassMana:SetJustifyH("RIGHT")
			else
				self.ClassMana:SetPoint("LEFT", self.Power, "LEFT", 4, 0)
				self.ClassMana:SetFormattedText("%d%%", floor(min / max * 100))
			end
		else
			self.ClassMana:SetText()
		end

		self.ClassMana:SetAlpha(1)
	else
		self.ClassMana:SetAlpha(0)
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

T.UpdateHoly = function(self, event, unit, powerType)
	if self.unit ~= unit or (powerType and powerType ~= "HOLY_POWER") then return end
	local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
	local numMax = UnitPowerMax("player", SPELL_POWER_HOLY_POWER)
	local barWidth = self.HolyPower:GetWidth()
	local spacing = select(4, self.HolyPower[4]:GetPoint())
	local lastBar = 0

	if numMax ~= self.HolyPower.maxPower then
		if numMax == 3 then
			self.HolyPower[4]:Hide()
			self.HolyPower[5]:Hide()
			for i = 1, 3 do
				if i ~= 3 then
					self.HolyPower[i]:SetWidth(barWidth / 3)
					lastBar = lastBar + (barWidth / 3 + spacing)
				else
					self.HolyPower[i]:SetWidth(barWidth - lastBar)
				end
			end
		else
			self.HolyPower[4]:Show()
			self.HolyPower[5]:Show()
			for i = 1, 5 do
				self.HolyPower[i]:SetWidth(self.HolyPower[i].width)
			end
		end
		self.HolyPower.maxPower = numMax
	end

	for i = 1, 5 do
		if i <= num then
			self.HolyPower[i]:SetAlpha(1)
		else
			self.HolyPower[i]:SetAlpha(0.2)
		end
	end
end

T.UpdateComboPoint = function(self, event, unit)
	if powerType and powerType ~= 'COMBO_POINTS' then return end
	if unit == "pet" then return end

	local cpoints = self.CPoints
	local cp = (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) and UnitPower("vehicle", 4) or UnitPower("player", 4)
	local cpOld = (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) and GetComboPoints("vehicle", "target") or GetComboPoints("player", "target")
	if cpOld and cp and (cpOld > cp) then cp = cpOld end

	local numMax
	if (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) then
		numMax = MAX_COMBO_POINTS
	else
		numMax = UnitPowerMax("player", SPELL_POWER_COMBO_POINTS)
		if numMax == 0 then
			numMax = MAX_COMBO_POINTS
		end
	end

	local spacing = select(4, cpoints[5]:GetPoint())
	local w = cpoints:GetWidth()
	local s = 0

	if cpoints.numMax ~= numMax then
		if numMax == 8 then
			cpoints[6]:Show()
			cpoints[7]:Show()
			cpoints[8]:Show()
		elseif numMax == 6 then
			cpoints[6]:Show()
			cpoints[7]:Hide()
			cpoints[8]:Hide()
		else
			cpoints[6]:Hide()
			cpoints[7]:Hide()
			cpoints[8]:Hide()
		end

		for i = 1, numMax do
			if i ~= numMax then
				cpoints[i]:SetWidth(w / numMax - spacing)
				s = s + (w / numMax)
			else
				cpoints[i]:SetWidth(w - s)
			end
		end

		cpoints.numMax = numMax
	end

	for i = 1, numMax do
		if i <= cp then
			cpoints[i]:SetAlpha(1)
		else
			cpoints[i]:SetAlpha(0.2)
		end
	end

	if T.class == "DRUID" and C.unitframe_class_bar.combo_always ~= true then
		local form = GetShapeshiftFormID()

		if form == CAT_FORM or ((UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) and cp > 0) then
			cpoints:Show()
			if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19) end
		else
			cpoints:Hide()
			if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5) end
		end
	end
end

T.UpdateComboPointOld = function(self, event, unit)
	if powerType and powerType ~= 'COMBO_POINTS' then return end
	if unit == "pet" then return end

	local cpoints = self.CPoints
	local cp
	local numMax

	if UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle") then
		cp = GetComboPoints("vehicle", "target")
		numMax = MAX_COMBO_POINTS
	else
		cp = GetComboPoints("player", "target")
		numMax = UnitPowerMax("player", SPELL_POWER_COMBO_POINTS)
		if numMax == 0 then
			numMax = MAX_COMBO_POINTS
		end
	end

	local spacing = select(4, cpoints[5]:GetPoint())
	local w = cpoints:GetWidth()
	local s = 0

	if cpoints.numMax ~= numMax then
		if numMax == 8 then
			cpoints[6]:Show()
			cpoints[7]:Show()
			cpoints[8]:Show()
		elseif numMax == 6 then
			cpoints[6]:Show()
			cpoints[7]:Hide()
			cpoints[8]:Hide()
		else
			cpoints[6]:Hide()
			cpoints[7]:Hide()
			cpoints[8]:Hide()
		end

		for i = 1, numMax do
			if i ~= numMax then
				cpoints[i]:SetWidth(w / numMax - spacing)
				s = s + (w / numMax)
			else
				cpoints[i]:SetWidth(w - s)
			end
		end

		cpoints.numMax = numMax
	end

	for i = 1, numMax do
		if i <= cp then
			cpoints[i]:SetAlpha(1)
		else
			cpoints[i]:SetAlpha(0.2)
		end
	end

	if cpoints[1]:GetAlpha() == 1 then
		for i = 1, numMax do
			cpoints:Show()
			cpoints[i]:Show()
		end
	else
		for i = 1, numMax do
			cpoints:Hide()
			cpoints[i]:Hide()
		end
	end

	if self.RangeBar then
		if cpoints[1]:IsShown() and self.RangeBar:IsShown() then
			cpoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 21)
			if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 33) end
		elseif cpoints[1]:IsShown() or self.RangeBar:IsShown() then
			cpoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
		elseif self.Friendship and self.Friendship:IsShown() then
			if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
		else
			if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5) end
		end
	else
		if cpoints[1]:IsShown() or (self.Friendship and self.Friendship:IsShown()) then
			if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19) end
		else
			if self.Auras then self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5) end
		end
	end
end

T.UpdateReputationColor = function(self, event, unit, bar)
	local name, id = GetWatchedFactionInfo()
	bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
	bar.bg:SetVertexColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b, 0.2)
end

local ticks = {}
local channelingTicks = T.CastBarTicks

local setBarTicks = function(Castbar, ticknum)
	for k, v in pairs(ticks) do
		v:Hide()
	end
	if ticknum and ticknum > 0 then
		local delta = Castbar:GetWidth() / ticknum
		for k = 1, ticknum do
			if not ticks[k] then
				ticks[k] = Castbar:CreateTexture(nil, "OVERLAY")
				ticks[k]:SetTexture(C.media.texture)
				ticks[k]:SetVertexColor(unpack(C.media.border_color))
				ticks[k]:SetWidth(1)
				ticks[k]:SetHeight(Castbar:GetHeight())
				ticks[k]:SetDrawLayer("OVERLAY", 7)
			end
			ticks[k]:ClearAllPoints()
			ticks[k]:SetPoint("CENTER", Castbar, "RIGHT", -delta * k, 0)
			ticks[k]:Show()
		end
	end
end

T.PostCastStart = function(Castbar, unit, name, castid)
	Castbar.channeling = false
	if unit == "vehicle" then unit = "player" end

	if unit == "player" and C.unitframe.castbar_latency == true and Castbar.Latency then
		local _, _, _, lag = GetNetStats()
		local latency = GetTime() - (Castbar.castSent or 0)
		lag = lag / 1e3 > Castbar.max and Castbar.max or lag / 1e3
		latency = latency > Castbar.max and lag or latency
		Castbar.Latency:SetText(("%dms"):format(latency * 1e3))
		Castbar.SafeZone:SetWidth(Castbar:GetWidth() * latency / Castbar.max)
		Castbar.SafeZone:ClearAllPoints()
		Castbar.SafeZone:SetPoint("TOPRIGHT")
		Castbar.SafeZone:SetPoint("BOTTOMRIGHT")
		Castbar.castSent = nil
	end

	if unit == "player" and C.unitframe.castbar_ticks == true then
		setBarTicks(Castbar, 0)
	end

	local r, g, b, color
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		color = T.oUF_colors.class[class]
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
		Castbar:SetStatusBarColor(0.8, 0, 0)
		Castbar.bg:SetVertexColor(0.8, 0, 0, 0.2)
		Castbar.Overlay:SetBackdropBorderColor(0.8, 0, 0)
		if C.unitframe.castbar_icon == true and (unit == "target" or unit == "focus") then
			Castbar.Button:SetBackdropBorderColor(0.8, 0, 0)
		end
	else
		if unit == "pet" or unit == "vehicle" then
			local _, class = UnitClass("player")
			local r, g, b = unpack(T.oUF_colors.class[class])
			if C.unitframe.own_color == true then
				Castbar:SetStatusBarColor(unpack(C.unitframe.uf_color))
				Castbar.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.2)
			else
				if b then
					Castbar:SetStatusBarColor(r, g, b)
					Castbar.bg:SetVertexColor(r, g, b, 0.2)
				end
			end
		else
			if C.unitframe.own_color == true then
				Castbar:SetStatusBarColor(unpack(C.unitframe.uf_color))
				Castbar.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.2)
			else
				Castbar:SetStatusBarColor(r, g, b)
				Castbar.bg:SetVertexColor(r, g, b, 0.2)
			end
		end
		Castbar.Overlay:SetBackdropBorderColor(unpack(C.media.border_color))
		if C.unitframe.castbar_icon == true and (unit == "target" or unit == "focus") then
			Castbar.Button:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end
end

T.PostChannelStart = function(Castbar, unit, name)
	Castbar.channeling = true
	if unit == "vehicle" then unit = "player" end

	if unit == "player" and C.unitframe.castbar_latency == true and Castbar.Latency then
		local _, _, _, lag = GetNetStats()
		local latency = GetTime() - (Castbar.castSent or 0)
		lag = lag / 1e3 > Castbar.max and Castbar.max or lag / 1e3
		latency = latency > Castbar.max and lag or latency
		Castbar.Latency:SetText(("%dms"):format(latency * 1e3))
		Castbar.SafeZone:SetWidth(Castbar:GetWidth() * latency / Castbar.max)
		Castbar.SafeZone:ClearAllPoints()
		Castbar.SafeZone:SetPoint("TOPLEFT")
		Castbar.SafeZone:SetPoint("BOTTOMLEFT")
		Castbar.castSent = nil
	end

	if unit == "player" and C.unitframe.castbar_ticks == true then
		local spell = UnitChannelInfo(unit)
		Castbar.channelingTicks = channelingTicks[spell] or 0
		setBarTicks(Castbar, Castbar.channelingTicks)
	end

	local r, g, b, color
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		color = T.oUF_colors.class[class]
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
		Castbar:SetStatusBarColor(0.8, 0, 0)
		Castbar.bg:SetVertexColor(0.8, 0, 0, 0.2)
		Castbar.Overlay:SetBackdropBorderColor(0.8, 0, 0)
		if C.unitframe.castbar_icon == true and (unit == "target" or unit == "focus") then
			Castbar.Button:SetBackdropBorderColor(0.8, 0, 0)
		end
	else
		if unit == "pet" or unit == "vehicle" then
			local _, class = UnitClass("player")
			local r, g, b = unpack(T.oUF_colors.class[class])
			if C.unitframe.own_color == true then
				Castbar:SetStatusBarColor(unpack(C.unitframe.uf_color))
				Castbar.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.2)
			else
				if b then
					Castbar:SetStatusBarColor(r, g, b)
					Castbar.bg:SetVertexColor(r, g, b, 0.2)
				end
			end
		else
			if C.unitframe.own_color == true then
				Castbar:SetStatusBarColor(unpack(C.unitframe.uf_color))
				Castbar.bg:SetVertexColor(C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 0.2)
			else
				Castbar:SetStatusBarColor(r, g, b)
				Castbar.bg:SetVertexColor(r, g, b, 0.2)
			end
		end
		Castbar.Overlay:SetBackdropBorderColor(unpack(C.media.border_color))
		if C.unitframe.castbar_icon == true and (unit == "target" or unit == "focus") then
			Castbar.Button:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end
end

T.CustomCastTimeText = function(self, duration)
	self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
end

T.CustomCastDelayText = function(self, duration)
	self.Time:SetText(("%.1f |cffaf5050%s %.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "-" or "+", abs(self.delay)))
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
	button.remaining:SetPoint("CENTER", button, "CENTER", 1, 1)
	button.remaining:SetJustifyH("CENTER")

	button.cd.noOCC = true
	button.cd.noCooldownCount = true

	button.icon:SetPoint("TOPLEFT", 2, -2)
	button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, 0)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
	button.count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

	if C.aura.show_spiral == true then
		element.disableCooldown = false
		button.cd:SetReverse(true)
		button.cd:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		button.cd:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
		button.parent = CreateFrame("Frame", nil, button)
		button.parent:SetFrameLevel(button.cd:GetFrameLevel() + 1)
		button.count:SetParent(button.parent)
		button.remaining:SetParent(button.parent)
	else
		element.disableCooldown = true
	end
end

T.PostUpdateIcon = function(icons, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
	local _, _, _, _, dtype, duration, expirationTime, _, isStealable = UnitAura(unit, index, icon.filter)

	local playerUnits = {
		player = true,
		pet = true,
		vehicle = true,
	}

	if icon.debuff then
		if not UnitIsFriend("player", unit) and not playerUnits[icon.owner] then
			if C.aura.player_aura_only then
				icon:Hide()
			else
				icon:SetBackdropBorderColor(unpack(C.media.border_color))
				icon.icon:SetDesaturated(true)
			end
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
		icon.icon:SetDesaturated(false)
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
		self.backdrop:SetBackdropBorderColor(r, g, b)
	else
		self.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
	end
end

local CountOffSets = {
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
	icon.icon:SetPoint("TOPLEFT", icon, 1, -1)
	icon.icon:SetPoint("BOTTOMRIGHT", icon, -1, 1)
	icon.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon.icon:SetDrawLayer("ARTWORK")
	if icon.cd then
		icon.cd:SetReverse(true)
	end
	icon.overlay:SetTexture()
end

T.CreateAuraWatch = function(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 0, 0)
	auras:SetPoint("BOTTOMRIGHT", self.Health, 0, 0)
	auras.icons = {}
	auras.PostCreateIcon = T.CreateAuraWatchIcon

	if not C.aura.show_timer then
		auras.hideCooldown = true
	end

	local buffs = {}

	if T.RaidBuffs["ALL"] then
		for key, value in pairs(T.RaidBuffs["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if T.RaidBuffs[T.class] then
		for key, value in pairs(T.RaidBuffs[T.class]) do
			tinsert(buffs, value)
		end
	end

	if buffs then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon.strictMatching = spell[5]
			icon:SetWidth(7)
			icon:SetHeight(7)
			icon:SetPoint(spell[2], 0, 0)

			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(C.media.blank)
			if spell[3] then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end

			local count = T.SetFontString(icon, C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
			count:SetPoint("CENTER", unpack(CountOffSets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end

	self.AuraWatch = auras
end

--[[

GetDetailedItemLevelInfo Polyfill, v 1.0
by Erorus for The Undermine Journal
https://theunderminejournal.com/

Based on these "specs" for a GetDetailedItemLevelInfo function coming in 7.1
https://www.reddit.com/r/woweconomy/comments/50hp5d/warning_be_careful_flipping/d74olsy

Pass in an itemstring/link to GetDetailedItemLevelInfo
Returns effectiveItemLevel, previewItemLevel, baseItemLevel

This should use the in-game function if it already exists,
otherwise it'll define a function that does what *I think* the official function would do.

]]

if GetDetailedItemLevelInfo then return end

local bonusLevelBoost = {[1]=20,[15]=20,[44]=6,[171]=10,[448]=6,[449]=13,[450]=26,[451]=-12,[497]=50,[499]=6,[518]=-100,[519]=-80,[520]=-60,[521]=-30,[522]=-15,[526]=15,[527]=30,[545]=10,[546]=6,[547]=6,[552]=0,[553]=35,[554]=40,[555]=70,[556]=65,[557]=70,[558]=15,[559]=30,[560]=6,[561]=6,[562]=6,[566]=15,[567]=30,[571]=6,[573]=-60,[575]=20,[576]=30,[577]=20,[579]=7,[591]=20,[592]=30,[593]=45,[594]=45,[595]=15,[597]=5,[598]=10,[599]=15,[609]=40,[617]=60,[618]=75,[619]=60,[620]=75,[622]=3,[623]=6,[624]=9,[625]=12,[626]=15,[627]=18,[628]=21,[629]=24,[630]=27,[631]=30,[632]=33,[633]=36,[634]=39,[635]=42,[636]=45,[637]=48,[638]=51,[639]=54,[640]=57,[641]=60,[642]=55,[644]=20,[646]=6,[648]=45,[651]=25,[665]=15,[666]=20,[667]=25,[668]=30,[669]=35,[670]=40,[671]=45,[672]=50,[673]=33,[674]=36,[675]=39,[676]=42,[677]=45,[678]=48,[679]=51,[680]=54,[681]=57,[682]=60,[694]=15,[695]=30,[696]=45,[697]=60,[698]=75,[699]=100,[700]=5,[701]=10,[702]=3,[703]=6,[704]=12,[706]=30,[707]=15,[708]=10,[709]=20,[710]=70,[754]=5,[755]=10,[756]=15,[757]=25,[758]=30,[759]=35,[760]=40,[761]=10,[762]=15,[763]=20,[764]=30,[765]=35,[766]=40,[769]=25,[1372]=-100,[1373]=-99,[1374]=-98,[1375]=-97,[1376]=-96,[1377]=-95,[1378]=-94,[1379]=-93,[1380]=-92,[1381]=-91,[1382]=-90,[1383]=-89,[1384]=-88,[1385]=-87,[1386]=-86,[1387]=-85,[1388]=-84,[1389]=-83,[1390]=-82,[1391]=-81,[1392]=-80,[1393]=-79,[1394]=-78,[1395]=-77,[1396]=-76,[1397]=-75,[1398]=-74,[1399]=-73,[1400]=-72,[1401]=-71,[1402]=-70,[1403]=-69,[1404]=-68,[1405]=-67,[1406]=-66,[1407]=-65,[1408]=-64,[1409]=-63,[1410]=-62,[1411]=-61,[1412]=-60,[1413]=-59,[1414]=-58,[1415]=-57,[1416]=-56,[1417]=-55,[1418]=-54,[1419]=-53,[1420]=-52,[1421]=-51,[1422]=-50,[1423]=-49,[1424]=-48,[1425]=-47,[1426]=-46,[1427]=-45,[1428]=-44,[1429]=-43,[1430]=-42,[1431]=-41,[1432]=-40,[1433]=-39,[1434]=-38,[1435]=-37,[1436]=-36,[1437]=-35,[1438]=-34,[1439]=-33,[1440]=-32,[1441]=-31,[1442]=-30,[1443]=-29,[1444]=-28,[1445]=-27,[1446]=-26,[1447]=-25,[1448]=-24,[1449]=-23,[1450]=-22,[1451]=-21,[1452]=-20,[1453]=-19,[1454]=-18,[1455]=-17,[1456]=-16,[1457]=-15,[1458]=-14,[1459]=-13,[1460]=-12,[1461]=-11,[1462]=-10,[1463]=-9,[1464]=-8,[1465]=-7,[1466]=-6,[1467]=-5,[1468]=-4,[1469]=-3,[1470]=-2,[1471]=-1,[1472]=0,[1473]=1,[1474]=2,[1475]=3,[1476]=4,[1477]=5,[1478]=6,[1479]=7,[1480]=8,[1481]=9,[1482]=10,[1483]=11,[1484]=12,[1485]=13,[1486]=14,[1487]=15,[1488]=16,[1489]=17,[1490]=18,[1491]=19,[1492]=20,[1493]=21,[1494]=22,[1495]=23,[1496]=24,[1497]=25,[1498]=26,[1499]=27,[1500]=28,[1501]=29,[1502]=30,[1503]=31,[1504]=32,[1505]=33,[1506]=34,[1507]=35,[1508]=36,[1509]=37,[1510]=38,[1511]=39,[1512]=40,[1513]=41,[1514]=42,[1515]=43,[1516]=44,[1517]=45,[1518]=46,[1519]=47,[1520]=48,[1521]=49,[1522]=50,[1523]=51,[1524]=52,[1525]=53,[1526]=54,[1527]=55,[1528]=56,[1529]=57,[1530]=58,[1531]=59,[1532]=60,[1533]=61,[1534]=62,[1535]=63,[1536]=64,[1537]=65,[1538]=66,[1539]=67,[1540]=68,[1541]=69,[1542]=70,[1543]=71,[1544]=72,[1545]=73,[1546]=74,[1547]=75,[1548]=76,[1549]=77,[1550]=78,[1551]=79,[1552]=80,[1553]=81,[1554]=82,[1555]=83,[1556]=84,[1557]=85,[1558]=86,[1559]=87,[1560]=88,[1561]=89,[1562]=90,[1563]=91,[1564]=92,[1565]=93,[1566]=94,[1567]=95,[1568]=96,[1569]=97,[1570]=98,[1571]=99,[1572]=100,[1573]=101,[1574]=102,[1575]=103,[1576]=104,[1577]=105,[1578]=106,[1579]=107,[1580]=108,[1581]=109,[1582]=110,[1583]=111,[1584]=112,[1585]=113,[1586]=114,[1587]=115,[1588]=116,[1589]=117,[1590]=118,[1591]=119,[1592]=120,[1593]=121,[1594]=122,[1595]=123,[1596]=124,[1597]=125,[1598]=126,[1599]=127,[1600]=128,[1601]=129,[1602]=130,[1603]=131,[1604]=132,[1605]=133,[1606]=134,[1607]=135,[1608]=136,[1609]=137,[1610]=138,[1611]=139,[1612]=140,[1613]=141,[1614]=142,[1615]=143,[1616]=144,[1617]=145,[1618]=146,[1619]=147,[1620]=148,[1621]=149,[1622]=150,[1623]=151,[1624]=152,[1625]=153,[1626]=154,[1627]=155,[1628]=156,[1629]=157,[1630]=158,[1631]=159,[1632]=160,[1633]=161,[1634]=162,[1635]=163,[1636]=164,[1637]=165,[1638]=166,[1639]=167,[1640]=168,[1641]=169,[1642]=170,[1643]=171,[1644]=172,[1645]=173,[1646]=174,[1647]=175,[1648]=176,[1649]=177,[1650]=178,[1651]=179,[1652]=180,[1653]=181,[1654]=182,[1655]=183,[1656]=184,[1657]=185,[1658]=186,[1659]=187,[1660]=188,[1661]=189,[1662]=190,[1663]=191,[1664]=192,[1665]=193,[1666]=194,[1667]=195,[1668]=196,[1669]=197,[1670]=198,[1671]=199,[1672]=200,[1800]=210,[1810]=140,[1817]=10,[1818]=20,[1819]=15,[1820]=25,[2829]=-400,[2830]=-399,[2831]=-398,[2832]=-397,[2833]=-396,[2834]=-395,[2835]=-394,[2836]=-393,[2837]=-392,[2838]=-391,[2839]=-390,[2840]=-389,[2841]=-388,[2842]=-387,[2843]=-386,[2844]=-385,[2845]=-384,[2846]=-383,[2847]=-382,[2848]=-381,[2849]=-380,[2850]=-379,[2851]=-378,[2852]=-377,[2853]=-376,[2854]=-375,[2855]=-374,[2856]=-373,[2857]=-372,[2858]=-371,[2859]=-370,[2860]=-369,[2861]=-368,[2862]=-367,[2863]=-366,[2864]=-365,[2865]=-364,[2866]=-363,[2867]=-362,[2868]=-361,[2869]=-360,[2870]=-359,[2871]=-358,[2872]=-357,[2873]=-356,[2874]=-355,[2875]=-354,[2876]=-353,[2877]=-352,[2878]=-351,[2879]=-350,[2880]=-349,[2881]=-348,[2882]=-347,[2883]=-346,[2884]=-345,[2885]=-344,[2886]=-343,[2887]=-342,[2888]=-341,[2889]=-340,[2890]=-339,[2891]=-338,[2892]=-337,[2893]=-336,[2894]=-335,[2895]=-334,[2896]=-333,[2897]=-332,[2898]=-331,[2899]=-330,[2900]=-329,[2901]=-328,[2902]=-327,[2903]=-326,[2904]=-325,[2905]=-324,[2906]=-323,[2907]=-322,[2908]=-321,[2909]=-320,[2910]=-319,[2911]=-318,[2912]=-317,[2913]=-316,[2914]=-315,[2915]=-314,[2916]=-313,[2917]=-312,[2918]=-311,[2919]=-310,[2920]=-309,[2921]=-308,[2922]=-307,[2923]=-306,[2924]=-305,[2925]=-304,[2926]=-303,[2927]=-302,[2928]=-301,[2929]=-300,[2930]=-299,[2931]=-298,[2932]=-297,[2933]=-296,[2934]=-295,[2935]=-294,[2936]=-293,[2937]=-292,[2938]=-291,[2939]=-290,[2940]=-289,[2941]=-288,[2942]=-287,[2943]=-286,[2944]=-285,[2945]=-284,[2946]=-283,[2947]=-282,[2948]=-281,[2949]=-280,[2950]=-279,[2951]=-278,[2952]=-277,[2953]=-276,[2954]=-275,[2955]=-274,[2956]=-273,[2957]=-272,[2958]=-271,[2959]=-270,[2960]=-269,[2961]=-268,[2962]=-267,[2963]=-266,[2964]=-265,[2965]=-264,[2966]=-263,[2967]=-262,[2968]=-261,[2969]=-260,[2970]=-259,[2971]=-258,[2972]=-257,[2973]=-256,[2974]=-255,[2975]=-254,[2976]=-253,[2977]=-252,[2978]=-251,[2979]=-250,[2980]=-249,[2981]=-248,[2982]=-247,[2983]=-246,[2984]=-245,[2985]=-244,[2986]=-243,[2987]=-242,[2988]=-241,[2989]=-240,[2990]=-239,[2991]=-238,[2992]=-237,[2993]=-236,[2994]=-235,[2995]=-234,[2996]=-233,[2997]=-232,[2998]=-231,[2999]=-230,[3000]=-229,[3001]=-228,[3002]=-227,[3003]=-226,[3004]=-225,[3005]=-224,[3006]=-223,[3007]=-222,[3008]=-221,[3009]=-220,[3010]=-219,[3011]=-218,[3012]=-217,[3013]=-216,[3014]=-215,[3015]=-214,[3016]=-213,[3017]=-212,[3018]=-211,[3019]=-210,[3020]=-209,[3021]=-208,[3022]=-207,[3023]=-206,[3024]=-205,[3025]=-204,[3026]=-203,[3027]=-202,[3028]=-201,[3029]=-200,[3030]=-199,[3031]=-198,[3032]=-197,[3033]=-196,[3034]=-195,[3035]=-194,[3036]=-193,[3037]=-192,[3038]=-191,[3039]=-190,[3040]=-189,[3041]=-188,[3042]=-187,[3043]=-186,[3044]=-185,[3045]=-184,[3046]=-183,[3047]=-182,[3048]=-181,[3049]=-180,[3050]=-179,[3051]=-178,[3052]=-177,[3053]=-176,[3054]=-175,[3055]=-174,[3056]=-173,[3057]=-172,[3058]=-171,[3059]=-170,[3060]=-169,[3061]=-168,[3062]=-167,[3063]=-166,[3064]=-165,[3065]=-164,[3066]=-163,[3067]=-162,[3068]=-161,[3069]=-160,[3070]=-159,[3071]=-158,[3072]=-157,[3073]=-156,[3074]=-155,[3075]=-154,[3076]=-153,[3077]=-152,[3078]=-151,[3079]=-150,[3080]=-149,[3081]=-148,[3082]=-147,[3083]=-146,[3084]=-145,[3085]=-144,[3086]=-143,[3087]=-142,[3088]=-141,[3089]=-140,[3090]=-139,[3091]=-138,[3092]=-137,[3093]=-136,[3094]=-135,[3095]=-134,[3096]=-133,[3097]=-132,[3098]=-131,[3099]=-130,[3100]=-129,[3101]=-128,[3102]=-127,[3103]=-126,[3104]=-125,[3105]=-124,[3106]=-123,[3107]=-122,[3108]=-121,[3109]=-120,[3110]=-119,[3111]=-118,[3112]=-117,[3113]=-116,[3114]=-115,[3115]=-114,[3116]=-113,[3117]=-112,[3118]=-111,[3119]=-110,[3120]=-109,[3121]=-108,[3122]=-107,[3123]=-106,[3124]=-105,[3125]=-104,[3126]=-103,[3127]=-102,[3128]=-101,[3130]=201,[3131]=202,[3132]=203,[3133]=204,[3134]=205,[3135]=206,[3136]=207,[3137]=208,[3138]=209,[3139]=210,[3140]=211,[3141]=212,[3142]=213,[3143]=214,[3144]=215,[3145]=216,[3146]=217,[3147]=218,[3148]=219,[3149]=220,[3150]=221,[3151]=222,[3152]=223,[3153]=224,[3154]=225,[3155]=226,[3156]=227,[3157]=228,[3158]=229,[3159]=230,[3160]=231,[3161]=232,[3162]=233,[3163]=234,[3164]=235,[3165]=236,[3166]=237,[3167]=238,[3168]=239,[3169]=240,[3170]=241,[3171]=242,[3172]=243,[3173]=244,[3174]=245,[3175]=246,[3176]=247,[3177]=248,[3178]=249,[3179]=250,[3180]=251,[3181]=252,[3182]=253,[3183]=254,[3184]=255,[3185]=256,[3186]=257,[3187]=258,[3188]=259,[3189]=260,[3190]=261,[3191]=262,[3192]=263,[3193]=264,[3194]=265,[3195]=266,[3196]=267,[3197]=268,[3198]=269,[3199]=270,[3200]=271,[3201]=272,[3202]=273,[3203]=274,[3204]=275,[3205]=276,[3206]=277,[3207]=278,[3208]=279,[3209]=280,[3210]=281,[3211]=282,[3212]=283,[3213]=284,[3214]=285,[3215]=286,[3216]=287,[3217]=288,[3218]=289,[3219]=290,[3220]=291,[3221]=292,[3222]=293,[3223]=294,[3224]=295,[3225]=296,[3226]=297,[3227]=298,[3228]=299,[3229]=300,[3230]=301,[3231]=302,[3232]=303,[3233]=304,[3234]=305,[3235]=306,[3236]=307,[3237]=308,[3238]=309,[3239]=310,[3240]=311,[3241]=312,[3242]=313,[3243]=314,[3244]=315,[3245]=316,[3246]=317,[3247]=318,[3248]=319,[3249]=320,[3250]=321,[3251]=322,[3252]=323,[3253]=324,[3254]=325,[3255]=326,[3256]=327,[3257]=328,[3258]=329,[3259]=330,[3260]=331,[3261]=332,[3262]=333,[3263]=334,[3264]=335,[3265]=336,[3266]=337,[3267]=338,[3268]=339,[3269]=340,[3270]=341,[3271]=342,[3272]=343,[3273]=344,[3274]=345,[3275]=346,[3276]=347,[3277]=348,[3278]=349,[3279]=350,[3280]=351,[3281]=352,[3282]=353,[3283]=354,[3284]=355,[3285]=356,[3286]=357,[3287]=358,[3288]=359,[3289]=360,[3290]=361,[3291]=362,[3292]=363,[3293]=364,[3294]=365,[3295]=366,[3296]=367,[3297]=368,[3298]=369,[3299]=370,[3300]=371,[3301]=372,[3302]=373,[3303]=374,[3304]=375,[3305]=376,[3306]=377,[3307]=378,[3308]=379,[3309]=380,[3310]=381,[3311]=382,[3312]=383,[3313]=384,[3314]=385,[3315]=386,[3316]=387,[3317]=388,[3318]=389,[3319]=390,[3320]=391,[3321]=392,[3322]=393,[3323]=394,[3324]=395,[3325]=396,[3326]=397,[3327]=398,[3328]=399,[3329]=400,[3330]=15,[3331]=5,[3332]=30,[3333]=35,[3334]=40,[3340]=10,[3341]=40,[3381]=0,[3382]=10,[3383]=20,[3384]=30,[3390]=60,[3391]=80,[3393]=20,[3438]=80,[3439]=95,[3440]=110,}
local bonusPreviewLevel = {[1726]=825,[1727]=840,[1798]=705,[1799]=720,[1801]=690,[1805]=865,[1806]=880,[1807]=850,[1824]=805,[1825]=810,[1826]=805,[3379]=835,[3394]=815,[3395]=820,[3396]=825,[3397]=830,[3399]=840,[3410]=840,[3411]=840,[3412]=840,[3413]=840,[3414]=840,[3415]=840,[3416]=840,[3417]=840,[3418]=840,[3427]=805,[3428]=840,[3432]=835,[3443]=875,[3444]=890,[3445]=905,[3446]=845,}
local bonusLevelCurve = {[664]=1648,[767]=1558,[768]=1688,[1723]=1746,[1724]=1748,[1725]=1749,[1729]=1751,[1730]=1752,[1731]=1753,[1732]=1648,[1733]=1758,[1734]=1759,[1735]=1759,[1736]=1756,[1737]=1757,[1738]=1757,[1739]=1760,[1740]=1761,[1741]=1761,[1788]=1787,[1789]=1788,[1790]=1789,[1791]=1790,[1792]=1756,[1793]=1760,[1794]=1758,[1795]=1832,[1796]=1824,[1812]=2002,[3342]=2202,[3380]=2196,[3387]=2208,[3388]=2209,[3389]=2210,[3398]=2247,}
local curvePoints = {[1558]={{98,660},{99,680},{100,685},{109,775},},[1648]={{98,664},{99,684},{100,689},{109,779},},[1688]={{98,668},{99,688},{100,693},{109,783},},[1746]={{1,10},{5,10},{59,62},{60,79},{69,105},{70,139},{79,187},{80,279},{84,333},{85,384},{89,463},{90,530},{99,605},{100,690},{110,780},},[1748]={{1,10},{5,13},{59,67},{60,84},{69,115},{70,149},{79,197},{80,289},{84,343},{85,394},{89,473},{90,540},{99,615},{100,700},{104,760},{110,820},},[1749]={{1,10},{5,15},{59,72},{60,89},{69,125},{70,159},{79,207},{80,299},{84,353},{85,404},{89,483},{90,550},{99,650},{100,710},{110,800},},[1751]={{650,0},{689,0},{690,1},{691,0},{850,0},},[1752]={{650,0},{809,0},{810,1},{811,0},{850,0},},[1753]={{95,1},{100,12},{109,20},{110,20},{115,30},},[1756]={{98,674},{99,694},{100,699},{109,789},},[1757]={{98,684},{99,704},{100,709},{109,799},},[1758]={{98,670},{99,690},{100,695},{109,785},},[1759]={{98,680},{99,700},{100,705},{109,795},},[1760]={{98,678},{99,698},{100,703},{109,793},},[1761]={{98,688},{99,708},{100,713},{109,803},},[1787]={{1,10},{5,10},{39,41},},[1788]={{1,10},{5,13},{39,44},},[1789]={{1,10},{5,15},{39,48},},[1790]={{1,10},{5,10},{59,62},},[1824]={{98,575},{99,660},{100,680},{101,685},{109,770},},[1832]={{98,675},{99,695},{100,700},{109,790},},[2002]={{98,650},{99,660},{100,670},{109,780},},[2196]={{1,10},{5,10},{57,57},{58,75},{67,95},{68,129},{80,177},{81,269},{85,323},{86,374},{90,453},{91,510},{97,580},{98,588},{99,605},{100,655},},[2202]={{98,660},{99,680},{100,685},{109,745},},[2208]={{1,10},{5,10},{57,62},{58,79},{67,105},{68,139},{80,187},{81,279},{85,333},{86,384},{90,463},{91,530},{97,600},{98,640},{99,670},{100,700},{110,700},},[2209]={{1,10},{5,10},{57,61},{58,79},{67,105},{68,139},{80,187},{81,279},{85,333},{86,384},{90,463},{91,530},{97,600},{98,650},{99,680},{100,710},{110,710},},[2210]={{1,10},{5,20},{57,71},{58,89},{67,115},{68,149},{80,197},{81,289},{85,343},{86,394},{90,473},{91,540},{97,610},{98,660},{99,690},{100,720},{110,720},},[2247]={{98,740},{109,810},},}

local function round(num)
	return floor(num + 0.5)
end

local function GetCurvePoint(curveId, point)
	local curve = curvePoints[curveId]
	if not curve then
		return nil
	end

	local lastKey, lastValue = curve[1][1], curve[1][2]
	if lastKey > point then
		return lastValue
	end

	for x = 1,#curve,1 do
		if point == curve[x][1] then
			return curve[x][2]
		end
		if point < curve[x][1] then
			return round((curve[x][2] - lastValue) / (curve[x][1] - lastKey) * (point - lastKey) + lastValue)
		end
		lastKey = curve[x][1]
		lastValue = curve[x][2]
	end

	return lastValue
end

GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or function(item)
	local _, link, _, origLevel = GetItemInfo(item)
	if not link then
		return nil, nil, nil
	end

	local itemString = string.match(link, "item[%-?%d:]+")
	local itemStringParts = { strsplit(":", itemString) }

	local numBonuses = tonumber(itemStringParts[14],10) or 0

	if numBonuses == 0 then
		return origLevel, nil, origLevel
	end

	local effectiveLevel, previewLevel, curve
	effectiveLevel = origLevel

	for y = 1,numBonuses,1 do
		local bonus = tonumber(itemStringParts[14+y],10) or 0

		origLevel = origLevel - (bonusLevelBoost[bonus] or 0)
		previewLevel = bonusPreviewLevel[bonus] or previewLevel
		curve = bonusLevelCurve[bonus] or curve
	end

	if curve and itemStringParts[12] == "512" then
		effectiveLevel = GetCurvePoint(curve, tonumber(itemStringParts[15+numBonuses],10)) or effectiveLevel
	end

	return effectiveLevel, previewLevel, origLevel
end
