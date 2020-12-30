﻿local T, C, L, _ = unpack(select(2, ...))
if C.enemycooldown.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Enemy cooldowns(alEnemyCD by Allez)
----------------------------------------------------------------------------------------
local show = {
	none = C.enemycooldown.show_always,
	pvp = C.enemycooldown.show_inpvp,
	arena = C.enemycooldown.show_inarena,
}
local direction = C.enemycooldown.direction
local icons = {}
local band = bit.band
local pos = C.position.enemy_cooldown
local limit = (C.actionbar.button_size * 12)/C.enemycooldown.size
local space = C.filger.cooldown_space

local EnemyCDAnchor = CreateFrame("Frame", "EnemyCDAnchor", UIParent)
if C.unitframe.enable ~= true then
	EnemyCDAnchor:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
else
	if C.unitframe.plugins_swing == true then
		EnemyCDAnchor:SetPoint(unpack(C.position.enemy_cooldown))
	else
		EnemyCDAnchor:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5] - 12)
	end
end
if direction == "UP" or direction == "DOWN" then
	EnemyCDAnchor:SetSize(C.enemycooldown.size, (C.enemycooldown.size * 5) + 12)
else
	EnemyCDAnchor:SetSize((C.enemycooldown.size * 5) + 12, C.enemycooldown.size)
end

local OnEnter = function(self)
	if IsShiftKeyDown() then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetSpellByID(self.sID)
		GameTooltip:SetClampedToScreen(true)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DONE_BY.." "..self.name)
		GameTooltip:Show()
	end
end

local function sortByExpiration(a, b)
	return a.endTime < b.endTime
end

local UpdatePositions = function()
	for i = 1, #icons do
		icons[i]:ClearAllPoints()
		if i == 1 then
			icons[i]:SetPoint("BOTTOMLEFT", EnemyCDAnchor, "BOTTOMLEFT", 0, 0)
		elseif i < limit then
			if direction == "UP" then
				icons[i]:SetPoint("BOTTOM", icons[i-1], "TOP", 0, space)
			elseif direction == "DOWN" then
				icons[i]:SetPoint("TOP", icons[i-1], "BOTTOM", 0, -space)
			elseif direction == "RIGHT" then
				icons[i]:SetPoint("LEFT", icons[i-1], "RIGHT", space, 0)
			elseif direction == "LEFT" then
				icons[i]:SetPoint("RIGHT", icons[i-1], "LEFT", -space, 0)
			else
				icons[i]:SetPoint("LEFT", icons[i-1], "RIGHT", space, 0)
			end

		end
		if i < limit then
			icons[i]:SetAlpha(1)
		else
			icons[i]:SetAlpha(0)
		end
		icons[i].id = i
	end
end

local StopTimer = function(icon)
	icon:SetScript("OnUpdate", nil)
	icon:Hide()
	tremove(icons, icon.id)
	UpdatePositions()
end

local IconUpdate = function(self)
	if (self.endTime < GetTime()) then
		StopTimer(self)
	end
end

local CreateIcon = function()
	local icon = CreateFrame("Frame", nil, UIParent)
	icon:SetSize(C.enemycooldown.size, C.enemycooldown.size)
	icon:SetTemplate("Default")
	icon.Cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
	icon.Cooldown:SetPoint("TOPLEFT", 2, -2)
	icon.Cooldown:SetPoint("BOTTOMRIGHT", -2, 2)
	icon.Cooldown:SetReverse(true)
	icon.Texture = icon:CreateTexture(nil, "BORDER")
	icon.Texture:SetPoint("TOPLEFT", 2, -2)
	icon.Texture:SetPoint("BOTTOMRIGHT", -2, 2)
	return icon
end

local StartTimer = function(sGUID, sID)
	local _, _, texture = GetSpellInfo(sID)
	local icon = CreateIcon()
	icon.Texture:SetTexture(texture)
	icon.Texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon.endTime = GetTime() + T.EnemySpells[sID]
	local _, class, _, _, _, name, _ = GetPlayerInfoByGUID(sGUID)
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
	if color then
		name = format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, name)
		if C.enemycooldown.class_color then
			icon:SetBackdropBorderColor(color.r, color.g, color.b)
		end
	end
	for _, v in pairs(icons) do
		if v.name == name and v.sID == sID then
			StopTimer(v)
		end
	end
	icon.name = name
	icon.sID = sID
	icon:Show()
	icon:SetScript("OnUpdate", IconUpdate)
	icon:SetScript("OnEnter", OnEnter)
	icon:SetScript("OnLeave", GameTooltip_Hide)
	CooldownFrame_Set(icon.Cooldown, GetTime(), T.EnemySpells[sID], 1)
	tinsert(icons, icon)
	table.sort(icons, sortByExpiration)
	UpdatePositions()
end

local OnEvent = function(_, event)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, eventType, _, sourceGUID, _, sourceFlags, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()

		if eventType == "SPELL_CAST_SUCCESS" and sourceName ~= T.name then
			local _, instanceType = IsInInstance()
			if show[instanceType] then
				if band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0 then
					if T.EnemySpells[spellID] then
						StartTimer(sourceGUID, spellID)
					end
				end
			elseif instanceType == "party" and C.enemycooldown.show_inparty then
				if band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) ~= 0 then
					if T.EnemySpells[spellID] then
						StartTimer(sourceGUID, spellID)
					end
				end
			end
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		for _, v in pairs(icons) do
			v.endTime = 0
		end
	end
end

for spell in pairs(T.EnemySpells) do
	local name = GetSpellInfo(spell)
	if not name then
		print("|cffff0000WARNING: spell ID ["..tostring(spell).."] no longer exists! Report this to Shestak.|r")
	end
end

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SlashCmdList.EnemyCD = function()
	StartTimer(UnitGUID(T.name), 47528)
	StartTimer(UnitGUID(T.name), 19647)
	StartTimer(UnitGUID(T.name), 47476)
	StartTimer(UnitGUID(T.name), 51514)
end
SLASH_EnemyCD1 = "/enemycd"
SLASH_EnemyCD2 = "/утуьнсв"
