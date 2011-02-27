----------------------------------------------------------------------------------------
--	Enemy cooldowns(alEnemyCD by Allez)
----------------------------------------------------------------------------------------
if not SettingsCF["cooldown"].enemy_enable == true then return end

local show = {
	none = SettingsCF["cooldown"].enemy_show_always,
	pvp = SettingsCF["cooldown"].enemy_show_inpvp,
	arena = SettingsCF["cooldown"].enemy_show_inarena,
}

local icons = {}
local band = bit.band
local pos = SettingsCF["position"].enemy_cooldown

local UpdatePositions = function()
	for i = 1, #icons do
		icons[i]:ClearAllPoints()
		if (i == 1) then
			if SettingsCF["unitframe"].plugins_swing == true then
				icons[i]:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5])
			else
				icons[i]:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5] - 12)
			end
		else
			icons[i]:SetPoint("LEFT", icons[i-1], "RIGHT", SettingsDB.Scale(3), 0)
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

local IconUpdate = function(self, elapsed)
	if (self.endTime < GetTime()) then
		StopTimer(self)
	end
end

local CreateIcon = function()
	local icon = CreateFrame("Frame", nil, UIParent)
	icon:SetWidth(SettingsCF["cooldown"].enemy_size)
	icon:SetHeight(SettingsCF["cooldown"].enemy_size)
	SettingsDB.CreateTemplate(icon)
	icon.Cooldown = CreateFrame("Cooldown", nil, icon)
	icon.Cooldown:SetPoint("TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
	icon.Cooldown:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	icon.Cooldown:SetReverse()
	icon.Texture = icon:CreateTexture(nil, "BORDER")
	icon.Texture:SetPoint("TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
	icon.Texture:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	return icon
end

local StartTimer = function(sID)
	local _,_,texture = GetSpellInfo(sID)
	local icon = CreateIcon()
	icon.Texture:SetTexture(texture)
	icon.Texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	icon.endTime = GetTime() + SettingsDB.enemy_spells[sID]
	icon:Show()
	icon:SetScript("OnUpdate", IconUpdate)
	CooldownFrame_SetTimer(icon.Cooldown, GetTime(), SettingsDB.enemy_spells[sID], 1)
	tinsert(icons, icon)
	UpdatePositions()
end

local OnEvent = function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName = ...
		if eventType == "SPELL_CAST_SUCCESS" and band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE then			
			if sourceName ~= UnitName("player") then
				if SettingsDB.enemy_spells[spellID] and show[select(2, IsInInstance())] then
					StartTimer(spellID)
				end
			end
		end 
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		for k, v in pairs(icons) do
			StopTimer(v)
		end
	end
end
	
local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SlashCmdList["EnemyCD"] = function(msg) 
	StartTimer(47528)
	StartTimer(19647)
	StartTimer(47476)
	StartTimer(51514)
end
SLASH_EnemyCD1 = "/enemycd"