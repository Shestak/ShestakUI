----------------------------------------------------------------------------------------
--	Raid cooldowns(alRaidCD by Allez)
----------------------------------------------------------------------------------------
if not SettingsCF["cooldown"].raid_enable == true then return end

local db = SettingsCF["font"]
local show = {
	raid = SettingsCF["cooldown"].raid_show_inraid,
	party = SettingsCF["cooldown"].raid_show_inparty,
	arena = SettingsCF["cooldown"].raid_show_inarena,
}

local filter = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_MINE
local band = bit.band
local sformat = string.format
local floor = math.floor
local timer = 0
local bars = {}

local FormatTime = function(time)
	if time >= 60 then
		return sformat("%.2d:%.2d", floor(time / 60), time % 60)
	else
		return sformat("%.2d", time)
	end
end

local CreateFS = function(frame, fsize, fstyle)
	local fstring = frame:CreateFontString(nil, "OVERLAY")
	fstring:SetFont(db.raid_cooldowns_font, db.raid_cooldowns_font_size, db.raid_cooldowns_font_style)
	fstring:SetShadowOffset(db.raid_cooldowns_font_shadow and 1 or 0, db.raid_cooldowns_font_shadow and -1 or 0)
	return fstring
end
	
local UpdatePositions = function()
	for i = 1, #bars do
		bars[i]:ClearAllPoints()
		if (i == 1) then
			bars[i]:SetPoint(unpack(SettingsCF["position"].raid_cooldown))
		else
			if SettingsCF["cooldown"].raid_upwards == true then
				bars[i]:SetPoint("BOTTOMLEFT", bars[i-1], "TOPLEFT", 0, SettingsDB.Scale(13))
			else
				bars[i]:SetPoint("TOPLEFT", bars[i-1], "BOTTOMLEFT", 0, SettingsDB.Scale(-13))
			end
		end
		bars[i].id = i
	end
end

local StopTimer = function(bar)
	bar:SetScript("OnUpdate", nil)
	bar:Hide()
	tremove(bars, bar.id)
	UpdatePositions()
end

local BarUpdate = function(self, elapsed)
	local curTime = GetTime()
	if self.endTime < curTime then
		StopTimer(self)
		return
	end
	self:SetValue(100 - (curTime - self.startTime) / (self.endTime - self.startTime) * 100)
	self.right:SetText(FormatTime(self.endTime - curTime))
end

local OnEnter = function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddDoubleLine(self.spell, self.right:GetText())
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Show()
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local OnMouseDown = function(self, button)
	if button == "LeftButton" then
		SendChatMessage(sformat(L_COOLDOWNS.." %s: %s", self.left:GetText(), self.right:GetText()), "RAID")
	elseif button == "RightButton" then
		StopTimer(self)
	end
end

local CreateBar = function()
	local bar = CreateFrame("Statusbar", nil, UIParent)
	if SettingsCF["cooldown"].raid_show_icon == true then
		bar:SetSize(SettingsCF["cooldown"].raid_width, SettingsCF["cooldown"].raid_height)
	else
		bar:SetSize(SettingsCF["cooldown"].raid_width + 28, SettingsCF["cooldown"].raid_height)
	end
	bar:SetStatusBarTexture(SettingsCF["media"].texture)
	bar:SetMinMaxValues(0, 100)
	
	bar.backdrop = CreateFrame("Frame", nil, bar)
	bar.backdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	bar.backdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
	SettingsDB.CreateTemplate(bar.backdrop)
	bar.backdrop:SetFrameStrata("BACKGROUND")
	
	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(SettingsCF["media"].texture)
	
	bar.left = CreateFS(bar)
	bar.left:SetPoint("LEFT", SettingsDB.Scale(3), 0)
	bar.left:SetJustifyH("LEFT")
	bar.left:SetSize(SettingsCF["cooldown"].raid_width - 35, db.raid_cooldowns_font_size)
	
	bar.right = CreateFS(bar)
	bar.right:SetPoint("RIGHT", SettingsDB.Scale(-1), 0)
	bar.right:SetJustifyH("RIGHT")
		
	if SettingsCF["cooldown"].raid_show_icon == true then
		bar.icon = CreateFrame("button", nil, bar)
		bar.icon:SetSize(SettingsDB.Scale(21), SettingsDB.Scale(21))
		bar.icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", SettingsDB.Scale(-7), 0)
	
		bar.icon.backdrop = CreateFrame("Frame", nil, bar.icon)
		bar.icon.backdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		bar.icon.backdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		SettingsDB.CreateTemplate(bar.icon.backdrop)
		bar.icon.backdrop:SetFrameStrata("BACKGROUND")
	end
	return bar
end

local StartTimer = function(name, spellId)
	local bar = CreateBar()
	local spell, rank, icon = GetSpellInfo(spellId)
	bar.endTime = GetTime() + SettingsDB.raid_spells[spellId]
	bar.startTime = GetTime()
	bar.left:SetText(name.." - "..spell)
	bar.right:SetText(FormatTime(SettingsDB.raid_spells[spellId]))
	if SettingsCF["cooldown"].raid_show_icon == true then
		bar.icon:SetNormalTexture(icon)
		bar.icon:GetNormalTexture():SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end
	bar.spell = spell
	bar:Show()
	local color = RAID_CLASS_COLORS[select(2, UnitClass(name))]
	bar:SetStatusBarColor(color.r, color.g, color.b)
	bar.bg:SetVertexColor(color.r, color.g, color.b, 0.25)
	bar:SetScript("OnUpdate", BarUpdate)
	bar:EnableMouse(true)
	bar:SetScript("OnEnter", OnEnter)
	bar:SetScript("OnLeave", OnLeave)
	bar:SetScript("OnMouseDown", OnMouseDown)
	tinsert(bars, bar)
	UpdatePositions()
end

local OnEvent = function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = ...
		if band(sourceFlags, filter) == 0 then return end
		if eventType == "SPELL_RESURRECT" or eventType == "SPELL_CAST_SUCCESS" then
			local spellId = select(9, ...)
			if SettingsDB.raid_spells[spellId] and show[select(2, IsInInstance())] then
				StartTimer(sourceName, spellId)
			end
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" and select(2, IsInInstance()) == "arena" then
		for k, v in pairs(bars) do
			StopTimer(v)
		end
	end
end

local addon = CreateFrame("frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SlashCmdList["RaidCD"] = function(msg) 
	StartTimer(UnitName("player"), 20484)
	StartTimer(UnitName("player"), 6203)
	StartTimer(UnitName("player"), 6346)
	StartTimer(UnitName("player"), 29166)
	StartTimer(UnitName("player"), 32182)
	StartTimer(UnitName("player"), 2825)
end
SLASH_RaidCD1 = "/raidcd"