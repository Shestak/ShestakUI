local T, C, L = unpack(select(2, ...))
if not C.enemycooldown.enable == true then return end

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

local UpdatePositions = function()
	for i = 1, #icons do
		icons[i]:ClearAllPoints()
		if i == 1 then
			if C.unitframe.plugins_swing == true then
				icons[i]:Point(unpack(C.position.enemy_cooldown))
			else
				icons[i]:Point(pos[1], pos[2], pos[3], pos[4], pos[5] - 12)
			end
		else
			if direction == "UP" then
				icons[i]:Point("BOTTOM", icons[i-1], "TOP", 0, 3)
			elseif direction == "DOWN" then
				icons[i]:Point("TOP", icons[i-1], "BOTTOM", 0, -3)
			elseif direction == "RIGHT" then
				icons[i]:Point("LEFT", icons[i-1], "RIGHT", 3, 0)
			elseif direction == "LEFT" then
				icons[i]:Point("RIGHT", icons[i-1], "LEFT", -3, 0)
			else
				icons[i]:Point("LEFT", icons[i-1], "RIGHT", 3, 0)
			end
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
	icon:Width(C.enemycooldown.size)
	icon:Height(C.enemycooldown.size)
	icon:SetTemplate("Default")
	icon.Cooldown = CreateFrame("Cooldown", nil, icon)
	icon.Cooldown:Point("TOPLEFT", 2, -2)
	icon.Cooldown:Point("BOTTOMRIGHT", -2, 2)
	icon.Cooldown:SetReverse()
	icon.Texture = icon:CreateTexture(nil, "BORDER")
	icon.Texture:Point("TOPLEFT", 2, -2)
	icon.Texture:Point("BOTTOMRIGHT", -2, 2)
	return icon
end

local StartTimer = function(sID)
	local _, _, texture = GetSpellInfo(sID)
	local icon = CreateIcon()
	icon.Texture:SetTexture(texture)
	icon.Texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon.endTime = GetTime() + T.enemy_spells[sID]
	icon:Show()
	icon:SetScript("OnUpdate", IconUpdate)
	CooldownFrame_SetTimer(icon.Cooldown, GetTime(), T.enemy_spells[sID], 1)
	tinsert(icons, icon)
	UpdatePositions()
end

local OnEvent = function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName = ...
		if eventType == "SPELL_CAST_SUCCESS" and band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE then
			if sourceName ~= UnitName("player") then
				if T.enemy_spells[spellID] and show[select(2, IsInInstance())] then
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

SlashCmdList.EnemyCD = function(msg) 
	StartTimer(47528)
	StartTimer(19647)
	StartTimer(47476)
	StartTimer(51514)
end
SLASH_EnemyCD1 = "/enemycd"
SLASH_EnemyCD2 = "/утуьнсв"