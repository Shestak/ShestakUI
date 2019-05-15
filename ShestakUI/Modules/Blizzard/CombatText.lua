local T, C, L, _ = unpack(select(2, ...))
if C.combattext.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Combat Text(xCT by Affli)
----------------------------------------------------------------------------------------
-- Justify messages in frames
local ct = {
	["justify_1"] = "LEFT",			-- Incoming damage justify
	["justify_2"] = "RIGHT",		-- Incoming healing justify
	["justify_3"] = "CENTER",		-- Various messages justify
	["justify_4"] = "RIGHT",		-- Outgoing damage/healing justify
}

-- Do not edit below unless you know what you are doing
local numf
if C.combattext.damage or C.combattext.healing then
	numf = 4
else
	numf = 3
end

-- Detect vehicle
local function SetUnit()
	if UnitHasVehicleUI("player") then
		ct.unit = "vehicle"
	else
		ct.unit = "player"
	end
	CombatTextSetActiveUnit(ct.unit)
end

-- Limit lines
local function LimitLines()
	for i = 1, #ct.frames do
		f = ct.frames[i]
		if i == 4 and C.combattext.icons then
			f:SetMaxLines(math.floor(f:GetHeight() / (C.combattext.icon_size * 1.5)))
		else
			f:SetMaxLines(math.floor(f:GetHeight() / C.font.combat_text_font_size - 1))
		end
	end
end

-- Scrollable frames
local function SetScroll()
	for i = 1, #ct.frames do
		ct.frames[i]:EnableMouseWheel(true)
		ct.frames[i]:SetScript("OnMouseWheel", function(self, delta)
			if delta > 0 then
				self:ScrollUp()
			elseif delta < 0 then
				self:ScrollDown()
			end
		end)
	end
end

-- Partial resists styler
local part = "-%s [%s %s]"
local r, g, b

-- Function, handles everything
local function OnEvent(self, event, subevent, powerType)
	if event == "COMBAT_TEXT_UPDATE" then
		local arg2, arg3 = GetCurrentCombatTextEventInfo()
		if SHOW_COMBAT_TEXT == "0" then
			return
		else
			if subevent == "DAMAGE" then
				if C.combattext.short_numbers == true then
					arg2 = T.ShortValue(arg2)
				end
				xCT1:AddMessage("-"..arg2, 0.75, 0.1, 0.1)
			elseif subevent == "DAMAGE_CRIT" then
				if C.combattext.short_numbers == true then
					arg2 = T.ShortValue(arg2)
				end
				xCT1:AddMessage("|cffFF0000"..C.combattext.crit_prefix.."|r".."-"..arg2.."|cffFF0000"..C.combattext.crit_postfix.."|r", 1, 0.1, 0.1)
			elseif subevent == "SPELL_DAMAGE" then
				if C.combattext.short_numbers == true then
					arg2 = T.ShortValue(arg2)
				end
				xCT1:AddMessage("-"..arg2, 0.75, 0.3, 0.85)
			elseif subevent == "SPELL_DAMAGE_CRIT" then
				if C.combattext.short_numbers == true then
					arg2 = T.ShortValue(arg2)
				end
				xCT1:AddMessage("|cffFF0000"..C.combattext.crit_prefix.."|r".."-"..arg2.."|cffFF0000"..C.combattext.crit_postfix.."|r", 1, 0.3, 0.5)
			elseif subevent == "HEAL" then
				if arg3 >= C.combattext.heal_treshold then
					if C.combattext.short_numbers == true then
						arg3 = T.ShortValue(arg3)
					end
					if arg2 then
						if COMBAT_TEXT_SHOW_FRIENDLY_NAMES == "1" then
							xCT2:AddMessage(arg2.." +"..arg3, 0.1, 0.75, 0.1)
						else
							xCT2:AddMessage("+"..arg3, 0.1, 0.75, 0.1)
						end
					end
				end
			elseif subevent == "HEAL_CRIT" then
				if arg3 >= C.combattext.heal_treshold then
					if C.combattext.short_numbers == true then
						arg3 = T.ShortValue(arg3)
					end
					if arg2 then
						if COMBAT_TEXT_SHOW_FRIENDLY_NAMES == "1" then
							xCT2:AddMessage(arg2.." +"..arg3, 0.1, 1, 0.1)
						else
							xCT2:AddMessage("+"..arg3, 0.1, 1, 0.1)
						end
					end
				end
			elseif subevent == "PERIODIC_HEAL" then
				if arg3 >= C.combattext.heal_treshold then
					if C.combattext.short_numbers == true then
						arg3 = T.ShortValue(arg3)
					end
					xCT2:AddMessage("+"..arg3, 0.1, 0.5, 0.1)
				end
			elseif subevent == "ABSORB_ADDED" and GetCVar("CombatHealingAbsorbSelf") == "1" then
				if arg3 >= C.combattext.heal_treshold then
					if C.combattext.short_numbers == true then
						arg3 = T.ShortValue(arg3)
					end
					if arg2 then
						if COMBAT_TEXT_SHOW_FRIENDLY_NAMES == "1" then
							xCT2:AddMessage(arg2.." +"..arg3, 0.6, 0.65, 0.1)
						else
							xCT2:AddMessage("+"..arg3, 0.6, 0.65, 0.1)
						end
					end
				end
			elseif subevent == "SPELL_CAST" then
				xCT3:AddMessage(arg2, 1, 0.82, 0)
			elseif subevent == "MISS" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(MISS, 0.5, 0.5, 0.5)
			elseif subevent == "DODGE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(DODGE, 0.5, 0.5, 0.5)
			elseif subevent == "PARRY" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(PARRY, 0.5, 0.5, 0.5)
			elseif subevent == "EVADE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(EVADE, 0.5, 0.5, 0.5)
			elseif subevent == "IMMUNE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(IMMUNE, 0.5, 0.5, 0.5)
			elseif subevent == "DEFLECT" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(DEFLECT, 0.5, 0.5, 0.5)
			elseif subevent == "REFLECT" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(REFLECT, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_MISS" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(MISS, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_DODGE"and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(DODGE, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_PARRY" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(PARRY, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_EVADE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(EVADE, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_IMMUNE" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(IMMUNE, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_DEFLECT" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(DEFLECT, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_REFLECT" and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == "1" then
				xCT1:AddMessage(REFLECT, 0.5, 0.5, 0.5)
			elseif subevent == "RESIST" then
				if arg3 then
					if C.combattext.short_numbers == true then
						arg2 = T.ShortValue(arg2)
						arg3 = T.ShortValue(arg3)
					end
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, RESIST, arg3), 0.75, 0.5, 0.5)
					else
						xCT1:AddMessage("-"..arg2, 0.75, 0.1, 0.1)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(RESIST, 0.5, 0.5, 0.5)
				end
			elseif subevent == "BLOCK" then
				if arg3 then
					if C.combattext.short_numbers == true then
						arg2 = T.ShortValue(arg2)
						arg3 = T.ShortValue(arg3)
					end
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, BLOCK, arg3), 0.75, 0.5, 0.5)
					else
						xCT1:AddMessage("-"..arg2, 0.75, 0.1, 0.1)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(BLOCK, 0.5, 0.5, 0.5)
				end
			elseif subevent == "ABSORB" then
				if arg3 then
					if C.combattext.short_numbers == true then
						arg2 = T.ShortValue(arg2)
						arg3 = T.ShortValue(arg3)
					end
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, ABSORB, arg3), 0.75, 0.5, 0.5)
					else
						xCT1:AddMessage("-"..arg2, 0.75, 0.1, 0.1)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(ABSORB, 0.5, 0.5, 0.5)
				end
			elseif subevent == "SPELL_RESIST" then
				if arg3 then
					if C.combattext.short_numbers == true then
						arg2 = T.ShortValue(arg2)
						arg3 = T.ShortValue(arg3)
					end
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, RESIST, arg3), 0.5, 0.3, 0.5)
					else
						xCT1:AddMessage("-"..arg2, 0.75, 0.3, 0.85)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(RESIST, 0.5, 0.5, 0.5)
				end
			elseif subevent == "SPELL_BLOCK" then
				if arg3 then
					if C.combattext.short_numbers == true then
						arg2 = T.ShortValue(arg2)
						arg3 = T.ShortValue(arg3)
					end
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, BLOCK, arg3), 0.5, 0.3, 0.5)
					else
						xCT1:AddMessage("-"..arg2, 0.75, 0.3, 0.85)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(BLOCK, 0.5, 0.5, 0.5)
				end
			elseif subevent == "SPELL_ABSORB" then
				if arg3 then
					if C.combattext.short_numbers == true then
						arg2 = T.ShortValue(arg2)
						arg3 = T.ShortValue(arg3)
					end
					if COMBAT_TEXT_SHOW_RESISTANCES == "1" then
						xCT1:AddMessage(part:format(arg2, ABSORB, arg3), 0.5, 0.3, 0.5)
					else
						xCT1:AddMessage("-"..arg2, 0.75, 0.3, 0.85)
					end
				elseif COMBAT_TEXT_SHOW_RESISTANCES == "1" then
					xCT1:AddMessage(ABSORB, 0.5, 0.5, 0.5)
				end
			elseif (subevent == "ENERGIZE" or subevent == "PERIODIC_ENERGIZE") and COMBAT_TEXT_SHOW_ENERGIZE == "1" then
				if tonumber(arg2) > 0 then
					if arg3 then
						if arg3 == "MANA" or arg3 == "RAGE" or arg3 == "FOCUS" or arg3 == "ENERGY" or arg3 == "RUNIC_POWER" or arg3 == "DEMONIC_FURY" then
							xCT3:AddMessage("+"..arg2.." ".._G[arg3], PowerBarColor[arg3].r, PowerBarColor[arg3].g, PowerBarColor[arg3].b)
						elseif arg3 == "HOLY_POWER" or arg3 == "SOUL_SHARDS" or arg3 == "CHI" or arg3 == "ARCANE_CHARGES" then
							local numPower = UnitPower("player", GetPowerEnumFromEnergizeString(arg3))
							xCT3:AddMessage("<"..numPower.." ".._G[arg3]..">", PowerBarColor[arg3].r, PowerBarColor[arg3].g, PowerBarColor[arg3].b)
						end
					end
				end
			elseif subevent == "SPELL_AURA_START" and COMBAT_TEXT_SHOW_AURAS == "1" then
				xCT3:AddMessage("+"..arg2, 1, 0.5, 0.5)
			elseif subevent == "SPELL_AURA_END" and COMBAT_TEXT_SHOW_AURAS == "1" then
				xCT3:AddMessage("-"..arg2, 0.5, 0.5, 0.5)
			elseif subevent == "SPELL_AURA_START_HARMFUL" and COMBAT_TEXT_SHOW_AURAS == "1" then
				xCT3:AddMessage("+"..arg2, 1, 0.1, 0.1)
			elseif subevent == "SPELL_AURA_END_HARMFUL" and COMBAT_TEXT_SHOW_AURAS == "1" then
				xCT3:AddMessage("-"..arg2, 0.1, 1, 0.1)
			elseif subevent == "HONOR_GAINED" and COMBAT_TEXT_SHOW_HONOR_GAINED == "1" then
				arg2 = tonumber(arg2)
				if arg2 and abs(arg2) > 1 then
					arg2 = floor(arg2)
					if arg2 > 0 then
						xCT3:AddMessage(HONOR.." +"..arg2, 0.1, 0.1, 1)
					end
				end
			elseif subevent == "FACTION" and COMBAT_TEXT_SHOW_REPUTATION == "1" then
				xCT3:AddMessage(arg2.." +"..arg3, 0.1, 0.1, 1)
			elseif subevent == "SPELL_ACTIVE" and COMBAT_TEXT_SHOW_REACTIVES == "1" then
				xCT3:AddMessage(arg2, 1, 0.82, 0)
			end
		end
	elseif event == "UNIT_HEALTH" and COMBAT_TEXT_SHOW_LOW_HEALTH_MANA == "1" then
		if subevent == ct.unit then
			if UnitHealth(ct.unit) / UnitHealthMax(ct.unit) <= COMBAT_TEXT_LOW_HEALTH_THRESHOLD then
				if not lowHealth then
					xCT3:AddMessage(HEALTH_LOW, 1, 0.1, 0.1)
					lowHealth = true
				end
			else
				lowHealth = nil
			end
		end
	elseif event == "UNIT_MANA" and COMBAT_TEXT_SHOW_LOW_HEALTH_MANA == "1" then
		if subevent == ct.unit then
			local _, powerToken = UnitPowerType(ct.unit)
			if powerToken == "MANA" and (UnitPower(ct.unit) / UnitPowerMax(ct.unit)) <= COMBAT_TEXT_LOW_MANA_THRESHOLD then
				if not lowMana then
					xCT3:AddMessage(MANA_LOW, 1, 0.1, 0.1)
					lowMana = true
				end
			else
				lowMana = nil
			end
		end
	elseif event == "PLAYER_REGEN_ENABLED" and COMBAT_TEXT_SHOW_COMBAT_STATE == "1" then
			xCT3:AddMessage("-"..LEAVING_COMBAT, 0.1, 1, 0.1)
	elseif event == "PLAYER_REGEN_DISABLED" and COMBAT_TEXT_SHOW_COMBAT_STATE == "1" then
			xCT3:AddMessage("+"..ENTERING_COMBAT, 1, 0.1, 0.1)
	elseif event == "UNIT_POWER_UPDATE" and COMBAT_TEXT_SHOW_ENERGIZE == "1" then
		if subevent == ct.unit then
			if powerType and powerType ~= 'COMBO_POINTS' then return end
			local cp = UnitPower(ct.unit, 4)
			if cp > 0 then
				r, g, b = 1, 0.82, 0
				if cp == MAX_COMBO_POINTS then
					r, g, b = 0, 0.82, 1
				end
				xCT3:AddMessage(format(COMBAT_TEXT_COMBO_POINTS, cp), r, g, b)
			end
		end
	elseif event == "RUNE_POWER_UPDATE" then
		local arg1 = subevent
		if GetRuneCooldown(arg1) ~= 0 then return end
		xCT3:AddMessage("+"..COMBAT_TEXT_RUNE_DEATH, 0.75, 0, 0)
	elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITING_VEHICLE" then
		if arg1 == "player" then
			SetUnit()
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		SetUnit()
		if C.combattext.scrollable then
			SetScroll()
		else
			LimitLines()
		end
		if C.combattext.damage or C.combattext.healing then
			ct.pguid = UnitGUID("player")
		end
	end
end

-- Change damage font
if C.combattext.damage_style then
	DAMAGE_TEXT_FONT = C.font.combat_text_font
end

-- Hide blizzard combat text
if C.combattext.blizz_head_numbers ~= true then
	if C.combattext.blizz_head_numbers ~= true then
		if not T.classic then
			SetCVar("floatingCombatTextCombatHealing", 0)
		end
		SetCVar("floatingCombatTextCombatDamage", 0)
	else
		if not T.classic then
			SetCVar("floatingCombatTextCombatHealing", 1)
		end
		SetCVar("floatingCombatTextCombatDamage", 1)
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGOUT" then
		if not T.classic then
			SetCVar("floatingCombatTextCombatHealing", 1)
		end
		SetCVar("floatingCombatTextCombatDamage", 1)
	end
end)

-- Frames
ct.locked = true
ct.frames = {}
for i = 1, numf do
	local f = CreateFrame("ScrollingMessageFrame", "xCT"..i, UIParent)
	f:SetFont(C.font.combat_text_font, C.font.combat_text_font_size, C.font.combat_text_font_style)
	f:SetShadowColor(0, 0, 0, C.font.combat_text_font_shadow and 1 or 0)
	f:SetShadowOffset(C.font.combat_text_font_shadow and 1 or 0, C.font.combat_text_font_shadow and -1 or 0)
	f:SetTimeVisible(C.combattext.time_visible)
	f:SetMaxLines(C.combattext.max_lines)
	f:SetSpacing(1)
	f:SetWidth(128)
	f:SetHeight(112)
	f:SetPoint("CENTER", 0, 0)
	f:SetMovable(true)
	f:SetResizable(true)
	f:SetMinResize(128, 128)
	f:SetMaxResize(768, 768)
	f:SetClampedToScreen(true)
	f:SetClampRectInsets(0, 0, C.font.combat_text_font_size, 0)
	f:SetInsertMode(C.combattext.direction and 2 or 1)
	if i == 1 then
		f:SetJustifyH(ct.justify_1)
		if C.unitframe.enable == true and _G.oUF_Player then
			f:SetPoint("BOTTOMLEFT", "oUF_Player", "TOPLEFT", -3, 60)
		else
			f:SetPoint("CENTER", -192, -32)
		end
	elseif i == 2 then
		f:SetJustifyH(ct.justify_2)
		if C.unitframe.enable == true and _G.oUF_Player then
			f:SetPoint("BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 5, 60)
		else
			f:SetPoint("CENTER", 192, -32)
		end
	elseif i == 3 then
		f:SetJustifyH(ct.justify_3)
		f:SetWidth(256)
		f:SetPoint("CENTER", 0, 205)
	else
		f:SetJustifyH(ct.justify_4)
		f:SetWidth(200)
		if C.combattext.icons then
			f:SetHeight(150)
		end
		if C.unitframe.enable == true and _G.oUF_Target then
			f:SetPoint("BOTTOMRIGHT", "oUF_Target", "TOPRIGHT", 2, 278)
		else
			f:SetPoint("CENTER", 330, 205)
		end
		local a, _, c = f:GetFont()
		if C.font.combat_text_font_size == "auto" then
			if C.combattext.icons then
				f:SetFont(a, C.combattext.icon_size / 2, c)
			end
		elseif type(C.font.combat_text_font_size) == "number" then
			f:SetFont(a, C.font.combat_text_font_size, c)
		end
	end
	ct.frames[i] = f
end

-- Register events
local xCT = CreateFrame("Frame")
xCT:RegisterEvent("COMBAT_TEXT_UPDATE")
xCT:RegisterEvent("UNIT_HEALTH")
xCT:RegisterEvent("UNIT_MANA")
xCT:RegisterEvent("PLAYER_REGEN_DISABLED")
xCT:RegisterEvent("PLAYER_REGEN_ENABLED")
xCT:RegisterEvent("UNIT_POWER_UPDATE")
if C.combattext.dk_runes and T.class == "DEATHKNIGHT" then
	xCT:RegisterEvent("RUNE_POWER_UPDATE")
end
if not T.classic then
	xCT:RegisterEvent("UNIT_ENTERED_VEHICLE")
	xCT:RegisterEvent("UNIT_EXITING_VEHICLE")
end
xCT:RegisterEvent("PLAYER_ENTERING_WORLD")
xCT:SetScript("OnEvent", OnEvent)

-- Turn off Blizzard CT
CombatText:UnregisterAllEvents()
CombatText:SetScript("OnLoad", nil)
CombatText:SetScript("OnEvent", nil)
CombatText:SetScript("OnUpdate", nil)

-- Steal external messages sent by other addons using CombatText_AddMessage
hooksecurefunc("CombatText_AddMessage", function(message, _, r, g, b)
	local lastEntry = COMBAT_TEXT_TO_ANIMATE[#COMBAT_TEXT_TO_ANIMATE]
	CombatText_RemoveMessage(lastEntry)
	xCT3:AddMessage(message, r, g, b)
end)

-- Color printer
local pr = function(msg)
	print(tostring(msg))
end

-- Configmode and testmode
local StartConfigmode = function()
	if not InCombatLockdown()then
		for i = 1, #ct.frames do
			f = ct.frames[i]
			f:SetTemplate("Transparent")
			f:SetBackdropBorderColor(1, 0, 0, 1)

			f.fs = f:CreateFontString(nil, "OVERLAY")
			f.fs:SetFont(C.font.combat_text_font, C.font.combat_text_font_size, C.font.combat_text_font_style)
			f.fs:SetPoint("BOTTOM", f, "TOP", 0, 0)
			if i == 1 then
				f.fs:SetText(DAMAGE)
				f.fs:SetTextColor(1, 0.1, 0.1, 0.9)
			elseif i == 2 then
				f.fs:SetText(SHOW_COMBAT_HEALING)
				f.fs:SetTextColor(0.1, 1, 0.1, 0.9)
			elseif i == 3 then
				f.fs:SetText(COMBAT_TEXT_LABEL)
				f.fs:SetTextColor(0.1, 0.1, 1, 0.9)
			else
				f.fs:SetText(SCORE_DAMAGE_DONE.." / "..SCORE_HEALING_DONE)
				f.fs:SetTextColor(1, 1, 0, 0.9)
			end

			f.t = f:CreateTexture("ARTWORK")
			f.t:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
			f.t:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -19)
			f.t:SetHeight(20)
			f.t:SetColorTexture(0.5, 0.5, 0.5)
			f.t:SetAlpha(0.3)

			f.d = f:CreateTexture("ARTWORK")
			f.d:SetHeight(16)
			f.d:SetWidth(16)
			f.d:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
			f.d:SetColorTexture(0.5, 0.5, 0.5)
			f.d:SetAlpha(0.3)

			if not f.tr then
				f.tr = CreateFrame("Frame", nil, f)
				f.tr:SetScript("OnDragStart", function(self)
					self:GetParent():StartMoving()
				end)
				f.tr:SetScript("OnDragStop", function(self)
					self:GetParent():StopMovingOrSizing()
				end)
				f.tr:EnableMouse(true)
				f.tr:RegisterForDrag("LeftButton")
				f.tr:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
				f.tr:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
				f.tr:SetHeight(20)
			end

			f:EnableMouse(true)
			f:RegisterForDrag("LeftButton")
			f:SetScript("OnDragStart", f.StartSizing)
			if not C.combattext.scrollable then
				if i == 4 and C.combattext.icons then
					f:SetScript("OnSizeChanged", function(self)
						self:SetMaxLines(math.floor(self:GetHeight() / (C.combattext.icon_size * 1.5)))
						self:Clear()
					end)
				else
					f:SetScript("OnSizeChanged", function(self)
						self:SetMaxLines(math.floor(self:GetHeight() / C.font.combat_text_font_size - 1))
						self:Clear()
					end)
				end
			end

			f:SetScript("OnDragStop", f.StopMovingOrSizing)
			ct.locked = false
		end
		pr("|cffffff00"..L_COMBATTEXT_UNLOCKED.."|r")
	else
		pr("|cffffff00"..ERR_NOT_IN_COMBAT.."|r")
	end
end

local function EndConfigmode()
	for i = 1, #ct.frames do
		f = ct.frames[i]
		f:SetBackdrop(nil)
		f.iborder:Hide()
		f.oborder:Hide()
		f.fs:Hide()
		f.fs = nil
		f.t:Hide()
		f.t = nil
		f.d:Hide()
		f.d = nil
		f.tr = nil
		f:EnableMouse(false)
		f:SetScript("OnDragStart", nil)
		f:SetScript("OnDragStop", nil)
	end
	ct.locked = true
	pr("|cffffff00"..L_COMBATTEXT_UNSAVED.."|r")
end

local function StartTestMode()
	-- Init random number generator
	local random = math.random
	random(time()); random(); random(time())

	local TimeSinceLastUpdate = 0
	local UpdateInterval
	if C.combattext.damage_color then
		ct.dmindex = {}
		ct.dmindex[1] = 1
		ct.dmindex[2] = 2
		ct.dmindex[3] = 4
		ct.dmindex[4] = 8
		ct.dmindex[5] = 16
		ct.dmindex[6] = 32
		ct.dmindex[7] = 64
	end

	for i = 1, #ct.frames do
		ct.frames[i]:SetScript("OnUpdate", function(self, elapsed)
			UpdateInterval = random(65, 1000) / 250
			TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
			if TimeSinceLastUpdate > UpdateInterval then
				if i == 1 then
					ct.frames[i]:AddMessage("-"..random(100000), 1, random(255) / 255, random(255) / 255)
				elseif i == 2 then
					ct.frames[i]:AddMessage("+"..random(50000), 0.1, random(128, 255) / 255, 0.1)
				elseif i == 3 then
					ct.frames[i]:AddMessage(COMBAT_TEXT_LABEL, random(255) / 255, random(255) / 255, random(255) / 255)
				elseif i == 4 then
					local msg
					local icon
					local color = {}
					msg = random(40000)
					if C.combattext.icons then
						_, _, icon = GetSpellInfo(msg)
						if not icon then
							icon = GetSpellTexture(6603)
						end
					end
					if icon then
						msg = msg.." \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
						if C.combattext.damage_color then
							color = ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
						else
							color = {1, 1, 0}
						end
					elseif C.combattext.damage_color and not C.combattext.icons then
						color = ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
					elseif not C.combattext.damage_color then
						color = {1, 1, random(0, 1)}
					end
					ct.frames[i]:AddMessage(msg, unpack(color))
				end
				TimeSinceLastUpdate = 0
			end
		end)
		ct.testmode = true
	end
end

local function EndTestMode()
	for i = 1, #ct.frames do
		ct.frames[i]:SetScript("OnUpdate", nil)
		ct.frames[i]:Clear()
	end
	if C.combattext.damage_color then
		ct.dmindex = nil
	end
	ct.testmode = false
end

-- Popup dialog
StaticPopupDialogs.XCT_LOCK = {
	text = L_COMBATTEXT_POPUP,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() if not InCombatLockdown() then ReloadUI() else EndConfigmode() end end,
	OnCancel = EndConfigmode,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	showAlert = true,
	preferredIndex = 5,
}

local placed = {
	"xCT1",
	"xCT2",
	"xCT3",
	"xCT4"
}

-- Slash commands
SlashCmdList.XCT = function(input)
	input = string.lower(input)
	if input == "unlock" then
		if ct.locked then
			StartConfigmode()
		else
			pr("|cffffff00"..L_COMBATTEXT_ALREADY_UNLOCKED.."|r")
		end
	elseif input == "lock" then
		if ct.locked then
			pr("|cffffff00"..L_COMBATTEXT_ALREADY_LOCKED.."|r")
		else
			StaticPopup_Show("XCT_LOCK")
		end
	elseif input == "test" then
		if ct.testmode then
			EndTestMode()
			pr("|cffffff00"..L_COMBATTEXT_TEST_DISABLED.."|r")
		else
			StartTestMode()
			pr("|cffffff00"..L_COMBATTEXT_TEST_ENABLED.."|r")
		end
	elseif input == "reset" then
		for i, v in pairs(placed) do
			if _G[v] then
				_G[v]:SetUserPlaced(false)
			end
		end
		ReloadUI()
	else
		pr("|cffffff00"..L_COMBATTEXT_TEST_USE_UNLOCK.."|r")
		pr("|cffffff00"..L_COMBATTEXT_TEST_USE_LOCK.."|r")
		pr("|cffffff00"..L_COMBATTEXT_TEST_USE_TEST.."|r")
		pr("|cffffff00"..L_COMBATTEXT_TEST_USE_RESET.."|r")
	end
end
SLASH_XCT1 = "/xct"
SLASH_XCT2 = "/чсе"

-- Spam merger
local SQ
if C.combattext.merge_aoe_spam then
	if C.combattext.damage or C.combattext.healing then
		local pairs = pairs
		SQ = {}
		for k in pairs(T.aoespam) do
			SQ[k] = {queue = 0, msg = "", color = {}, count = 0, utime = 0, locked = false}
		end
		ct.SpamQueue = function(spellId, add)
			local amount
			local spam = SQ[spellId]["queue"]
			if spam and type(spam) == "number" then
				amount = spam + add
			else
				amount = add
			end
			return amount
		end
		local tslu = 0
		local xCTspam = CreateFrame("Frame")
		xCTspam:SetScript("OnUpdate", function(self, elapsed)
			local count
			tslu = tslu + elapsed
			if tslu > 0.5 then
				tslu = 0
				local utime = time()
				for k in pairs(SQ) do
					if not SQ[k]["locked"] and SQ[k]["queue"] > 0 and SQ[k]["utime"] <= utime then
						if SQ[k]["count"] > 1 then
							count = " |cffFFFFFF x "..SQ[k]["count"].."|r"
						else
							count = ""
						end
						if C.combattext.short_numbers == true then
							SQ[k]["queue"] = T.ShortValue(SQ[k]["queue"])
						end
						xCT4:AddMessage(SQ[k]["queue"]..count..SQ[k]["msg"], unpack(SQ[k]["color"]))
						SQ[k]["queue"] = 0
						SQ[k]["count"] = 0
					end
				end
			end
		end)
	end
end

-- Damage
if C.combattext.damage then
	local unpack, select, time = unpack, select, time
	local gflags = bit.bor(COMBATLOG_OBJECT_AFFILIATION_MINE,
		COMBATLOG_OBJECT_REACTION_FRIENDLY,
		COMBATLOG_OBJECT_CONTROL_PLAYER,
		COMBATLOG_OBJECT_TYPE_GUARDIAN
	)
	local xCTd = CreateFrame("Frame")
	if C.combattext.damage_color then
		ct.dmgcolor = {}
		ct.dmgcolor[1] = {1, 1, 0}		-- Physical
		ct.dmgcolor[2] = {1, 0.9, 0.5}	-- Holy
		ct.dmgcolor[4] = {1, 0.5, 0}	-- Fire
		ct.dmgcolor[8] = {0.3, 1, 0.3}	-- Nature
		ct.dmgcolor[16] = {0.5, 1, 1}	-- Frost
		ct.dmgcolor[32] = {0.5, 0.5, 1}	-- Shadow
		ct.dmgcolor[64] = {1, 0.5, 1}	-- Arcane
	end
	if C.combattext.icons then
		ct.blank = "Interface\\AddOns\\ShestakUI\\Media\\Textures\\Blank.tga"
	end
	local misstypes = {ABSORB = ABSORB, BLOCK = BLOCK, DEFLECT = DEFLECT, DODGE = DODGE, EVADE = EVADE, IMMUNE = IMMUNE, MISS = MISS, MISFIRE = MISS, PARRY = PARRY, REFLECT = REFLECT, RESIST = RESIST}
	local dmg = function(self, event)
		local msg, icon
		local _, eventType, _, sourceGUID, _, sourceFlags, _, destGUID = CombatLogGetCurrentEventInfo()
		if (sourceGUID == ct.pguid and destGUID ~= ct.pguid) or (sourceGUID == UnitGUID("pet") and C.combattext.pet_damage) or (sourceFlags == gflags) then
			if eventType == "SWING_DAMAGE" then
				local amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
				if amount >= C.combattext.treshold then
					local rawamount = amount
					if C.combattext.short_numbers == true then
						amount = T.ShortValue(amount)
					end
					if critical then
						amount = "|cffFF0000"..C.combattext.crit_prefix.."|r"..amount.."|cffFF0000"..C.combattext.crit_postfix.."|r"
					end
					if C.combattext.icons then
						if (sourceGUID == UnitGUID("pet")) or (sourceFlags == gflags) then
							icon = PET_ATTACK_TEXTURE
						else
							icon = GetSpellTexture(6603)
						end
						msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
					end
					local color = {1, 1, 1}
					if C.combattext.merge_aoe_spam and C.combattext.merge_melee then
						local spellId = 6603
						SQ[spellId]["locked"] = true
						SQ[spellId]["queue"] = ct.SpamQueue(spellId, rawamount)
						SQ[spellId]["msg"] = msg
						SQ[spellId]["color"] = color
						SQ[spellId]["count"] = SQ[spellId]["count"] + 1
						if SQ[spellId]["count"] == 1 then
							SQ[spellId]["utime"] = time() + T.aoespam[spellId]
						end
						SQ[spellId]["locked"] = false
						return
					end
					xCT4:AddMessage(amount..""..msg, unpack(color))
				end
			elseif eventType == "RANGE_DAMAGE" then
				local spellId, _, _, amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
				if amount >= C.combattext.treshold then
					local rawamount = amount
					if C.combattext.short_numbers == true then
						amount = T.ShortValue(amount)
					end
					if critical then
						amount = "|cffFF0000"..C.combattext.crit_prefix.."|r"..amount.."|cffFF0000"..C.combattext.crit_postfix.."|r"
					end
					if C.combattext.icons then
						icon = GetSpellTexture(spellId)
						msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
					end
					if C.combattext.merge_aoe_spam then
						spellId = T.merge[spellId] or spellId
						if T.aoespam[spellId] then
							SQ[spellId]["locked"] = true
							SQ[spellId]["queue"] = ct.SpamQueue(spellId, rawamount)
							SQ[spellId]["msg"] = msg
							SQ[spellId]["count"] = SQ[spellId]["count"] + 1
							if SQ[spellId]["count"] == 1 then
								SQ[spellId]["utime"] = time() + T.aoespam[spellId]
							end
							SQ[spellId]["locked"] = false
							return
						end
					end
					xCT4:AddMessage(amount..""..msg)
				end
			elseif eventType == "SPELL_DAMAGE" or (eventType == "SPELL_PERIODIC_DAMAGE" and C.combattext.dot_damage) then
				local spellId, _, spellSchool, amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
				if amount >= C.combattext.treshold then
					local color = {}
					local rawamount = amount
					if C.combattext.short_numbers == true then
						amount = T.ShortValue(amount)
					end
					if critical then
						amount = "|cffFF0000"..C.combattext.crit_prefix.."|r"..amount.."|cffFF0000"..C.combattext.crit_postfix.."|r"
					end
					if C.combattext.icons then
						icon = GetSpellTexture(spellId)
					end
					if C.combattext.damage_color then
						if ct.dmgcolor[spellSchool] then
							color = ct.dmgcolor[spellSchool]
						else
							color = ct.dmgcolor[1]
						end
					else
						color = {1, 1, 0}
					end
					if icon then
						msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
					elseif C.combattext.icons then
						msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
					else
						msg = ""
					end
					if C.combattext.merge_aoe_spam then
						spellId = T.merge[spellId] or spellId
						if bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= COMBATLOG_OBJECT_AFFILIATION_MINE then
							spellId = 6603
						end
						if T.aoespam[spellId] then
							SQ[spellId]["locked"] = true
							SQ[spellId]["queue"] = ct.SpamQueue(spellId, rawamount)
							SQ[spellId]["msg"] = msg
							SQ[spellId]["color"] = color
							SQ[spellId]["count"] = SQ[spellId]["count"] + 1
							if SQ[spellId]["count"] == 1 then
								SQ[spellId]["utime"] = time() + T.aoespam[spellId]
							end
							SQ[spellId]["locked"] = false
							return
						end
					end
					xCT4:AddMessage(amount..""..msg, unpack(color))
				end
			elseif eventType == "SWING_MISSED" then
				local missType = select(12, CombatLogGetCurrentEventInfo())
				if C.combattext.icons then
					if sourceGUID == UnitGUID("pet") or sourceFlags == gflags then
						icon = PET_ATTACK_TEXTURE
					else
						icon = GetSpellTexture(6603)
					end
					missType = misstypes[missType].." \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					missType = misstypes[missType]
				end
				xCT4:AddMessage(missType)
			elseif eventType == "SPELL_MISSED" or eventType == "RANGE_MISSED" then
				local spellId, _, _, missType = select(12, CombatLogGetCurrentEventInfo())
				if missType == "IMMUNE" and spellId == 118895 then return end
				if C.combattext.icons then
					icon = GetSpellTexture(spellId)
					missType = misstypes[missType].." \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					missType = misstypes[missType]
				end
				xCT4:AddMessage(missType)
			elseif eventType == "SPELL_DISPEL" and C.combattext.dispel then
				local id, effect, _, etype = select(15, CombatLogGetCurrentEventInfo())
				local color
				if C.combattext.icons then
					icon = GetSpellTexture(id)
				end
				if icon then
					msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				elseif C.combattext.icons then
					msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					msg = ""
				end
				if etype == "BUFF" then
					color = {0, 1, 0.5}
				else
					color = {1, 0, 0.5}
				end
				xCT3:AddMessage(ACTION_SPELL_DISPEL..": "..effect..msg, unpack(color))
			elseif eventType == "SPELL_STOLEN" and C.combattext.dispel then
				local id, effect = select(15, CombatLogGetCurrentEventInfo())
				local color = {1, 0.5, 0}
				if C.combattext.icons then
					icon = GetSpellTexture(id)
				end
				if icon then
					msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				elseif C.combattext.icons then
					msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					msg = ""
				end
				xCT3:AddMessage(ACTION_SPELL_STOLEN..": "..effect..msg, unpack(color))
			elseif eventType == "SPELL_INTERRUPT" and C.combattext.interrupt then
				local id, effect = select(15, CombatLogGetCurrentEventInfo())
				local color = {1, 0.5, 0}
				if C.combattext.icons then
					icon = GetSpellTexture(id)
				end
				if icon then
					msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				elseif C.combattext.icons then
					msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
				else
					msg = ""
				end
				xCT3:AddMessage(ACTION_SPELL_INTERRUPT..": "..effect..msg, unpack(color))
			elseif eventType == "PARTY_KILL" and C.combattext.killingblow then
				local destGUID, tname = select(8, CombatLogGetCurrentEventInfo())
				local classIndex = select(2, GetPlayerInfoByGUID(destGUID))
				local color = classIndex and RAID_CLASS_COLORS[classIndex] or {r = 0.2, g = 1, b = 0.2}
				xCT3:AddMessage("|cff33FF33"..ACTION_PARTY_KILL..": |r"..tname, color.r, color.g, color.b)
			end
		end
	end

	xCTd:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	xCTd:SetScript("OnEvent", dmg)
end

-- Healing
if C.combattext.healing then
	local unpack, select, time = unpack, select, time
	local xCTh = CreateFrame("Frame")
	if C.combattext.icons then
		ct.blank = "Interface\\AddOns\\ShestakUI\\Media\\Textures\\Blank.tga"
	end
	local heal = function(self, event)
		local msg, icon
		local _, eventType, _, sourceGUID, _, sourceFlags = CombatLogGetCurrentEventInfo()
		if sourceGUID == ct.pguid or sourceFlags == gflags then
			if eventType == "SPELL_HEAL" or (eventType == "SPELL_PERIODIC_HEAL" and C.combattext.show_hots) then
				if C.combattext.healing then
					local spellId, _, _, amount, overhealing, _, critical = select(12, CombatLogGetCurrentEventInfo())
					if T.healfilter[spellId] then
						return
					end
					if amount >= C.combattext.heal_treshold then
						local color = {}
						local rawamount = amount
						if C.combattext.show_overhealing and abs(overhealing) > 0 then
							if C.combattext.short_numbers == true then
								amount = T.ShortValue(math.floor(amount-overhealing)).." ["..T.ShortValue(floor(overhealing)).."]"
							else
								amount = math.floor(amount-overhealing).." ["..floor(overhealing).."]"
							end
						else
							if C.combattext.short_numbers == true then
								amount = T.ShortValue(amount)
							end
						end

						if critical then
							amount = "|cffFF0000"..C.combattext.crit_prefix.."|r"..amount.."|cffFF0000"..C.combattext.crit_postfix.."|r"
							color = {0.1, 1, 0.1}
						else
							color = {0.1, 0.65, 0.1}
						end
						if C.combattext.icons then
							icon = GetSpellTexture(spellId)
						else
							msg = ""
						end
						if icon then
							msg = " \124T"..icon..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
						elseif C.combattext.icons then
							msg = " \124T"..ct.blank..":"..C.combattext.icon_size..":"..C.combattext.icon_size..":0:0:64:64:5:59:5:59\124t"
						end
						if C.combattext.merge_aoe_spam then
							spellId = T.merge[spellId] or spellId
							if T.aoespam[spellId] then
								SQ[spellId]["locked"] = true
								SQ[spellId]["queue"] = ct.SpamQueue(spellId, rawamount)
								SQ[spellId]["msg"] = msg
								SQ[spellId]["color"] = color
								SQ[spellId]["count"] = SQ[spellId]["count"] + 1
								if SQ[spellId]["count"] == 1 then
									SQ[spellId]["utime"] = time() + T.aoespam[spellId]
								end
								SQ[spellId]["locked"] = false
								return
							end
						end
						xCT4:AddMessage(amount..""..msg, unpack(color))
					end
				end
			end
		end
	end

	xCTh:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	xCTh:SetScript("OnEvent", heal)
end

-- Check outdated spells
if C.combattext.merge_aoe_spam then
	for spell in pairs(T.aoespam) do
		local name = GetSpellInfo(spell)
		if not name then
			print("|cffff0000WARNING: spell ID ["..tostring(spell).."] no longer exists! Report this to Shestak.|r")
		end
	end

	for spell in pairs(T.merge) do
		local name = GetSpellInfo(spell)
		if not name then
			print("|cffff0000WARNING: spell ID ["..tostring(spell).."] no longer exists! Report this to Shestak.|r")
		end
	end
end

if C.combattext.healing then
	for spell in pairs(T.healfilter) do
		local name = GetSpellInfo(spell)
		if not name then
			print("|cffff0000WARNING: spell ID ["..tostring(spell).."] no longer exists! Report this to Shestak.|r")
		end
	end
end