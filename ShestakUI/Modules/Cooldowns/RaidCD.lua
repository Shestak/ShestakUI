local T, C, L, _ = unpack(select(2, ...))
if C.raidcooldown.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Raid cooldowns(alRaidCD by Allez)
----------------------------------------------------------------------------------------
local show = {
	raid = C.raidcooldown.show_inraid,
	party = C.raidcooldown.show_inparty,
	arena = C.raidcooldown.show_inarena,
}

local filter = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_MINE
local band = bit.band
local sformat = string.format
local floor = math.floor
local timer = 0
local inEncounter
local bars = {}

local RaidCDAnchor = CreateFrame("Frame", "RaidCDAnchor", UIParent)
RaidCDAnchor:SetPoint(unpack(C.position.raid_cooldown))
if C.raidcooldown.show_icon == true then
	RaidCDAnchor:SetSize(C.raidcooldown.width + 32, C.raidcooldown.height + 10)
else
	RaidCDAnchor:SetSize(C.raidcooldown.width + 32, C.raidcooldown.height + 4)
end

local FormatTime = function(time)
	if time >= 60 then
		return sformat("%.2d:%.2d", floor(time / 60), time % 60)
	else
		return sformat("%.2d", time)
	end
end

local function sortByExpiration(a, b)
	return a.endTime > b.endTime
end

local CreateFS = function(frame, fsize, fstyle)
	local fstring = frame:CreateFontString(nil, "OVERLAY")
	fstring:SetFont(C.font.raid_cooldowns_font, C.font.raid_cooldowns_font_size, C.font.raid_cooldowns_font_style)
	fstring:SetShadowOffset(C.font.raid_cooldowns_font_shadow and 1 or 0, C.font.raid_cooldowns_font_shadow and -1 or 0)
	return fstring
end

local UpdatePositions = function()
	for i = 1, #bars do
		bars[i]:ClearAllPoints()
		if i == 1 then
			bars[i]:SetPoint("BOTTOMRIGHT", RaidCDAnchor, "BOTTOMRIGHT", -2, 2)
		else
			if C.raidcooldown.upwards == true then
				bars[i]:SetPoint("BOTTOMLEFT", bars[i-1], "TOPLEFT", 0, 13)
			else
				bars[i]:SetPoint("TOPLEFT", bars[i-1], "BOTTOMLEFT", 0, -13)
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
	GameTooltip:SetSpellByID(self.spellId)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(self.left:GetText(), self.right:GetText())
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Show()
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local OnMouseDown = function(self, button)
	if button == "LeftButton" then
		SendChatMessage(sformat(L_COOLDOWNS.."%s - %s: %s", self.name, GetSpellLink(self.spellId), self.right:GetText()), T.CheckChat())
	elseif button == "RightButton" then
		StopTimer(self)
	end
end

local CreateBar = function()
	local bar = CreateFrame("Statusbar", nil, UIParent)
	bar:SetFrameStrata("MEDIUM")
	if C.raidcooldown.show_icon == true then
		bar:SetSize(C.raidcooldown.width, C.raidcooldown.height)
	else
		bar:SetSize(C.raidcooldown.width + 28, C.raidcooldown.height)
	end
	bar:SetStatusBarTexture(C.media.texture)
	bar:SetMinMaxValues(0, 100)
	bar:CreateBackdrop("Default")

	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(C.media.texture)

	bar.left = CreateFS(bar)
	bar.left:SetPoint("LEFT", 2, 0)
	bar.left:SetJustifyH("LEFT")
	bar.left:SetSize(C.raidcooldown.width - 30, C.font.raid_cooldowns_font_size)

	bar.right = CreateFS(bar)
	bar.right:SetPoint("RIGHT", 1, 0)
	bar.right:SetJustifyH("RIGHT")

	if C.raidcooldown.show_icon == true then
		bar.icon = CreateFrame("Button", nil, bar)
		bar.icon:SetWidth(bar:GetHeight() + 6)
		bar.icon:SetHeight(bar.icon:GetWidth())
		bar.icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -7, 0)
		bar.icon:CreateBackdrop("Default")
	end
	return bar
end

local StartTimer = function(name, spellId)
	local spell, _, icon = GetSpellInfo(spellId)
	for _, v in pairs(bars) do
		if v.name == name and v.spell == spell then
			return
		end
	end
	local bar = CreateBar()
	bar.endTime = GetTime() + T.raid_spells[spellId]
	bar.startTime = GetTime()
	bar.left:SetText(format("%s - %s", name:gsub("%-[^|]+", ""), spell))
	bar.name = name
	bar.right:SetText(FormatTime(T.raid_spells[spellId]))
	if C.raidcooldown.show_icon == true then
		bar.icon:SetNormalTexture(icon)
		bar.icon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end
	bar.spell = spell
	bar.spellId = spellId
	bar:Show()
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(name))]
	if color then
		bar:SetStatusBarColor(color.r, color.g, color.b)
		bar.bg:SetVertexColor(color.r, color.g, color.b, 0.2)
	else
		bar:SetStatusBarColor(0.3, 0.7, 0.3)
		bar.bg:SetVertexColor(0.3, 0.7, 0.3, 0.2)
	end
	bar:EnableMouse(true)
	bar:SetScript("OnUpdate", BarUpdate)
	bar:SetScript("OnEnter", OnEnter)
	bar:SetScript("OnLeave", OnLeave)
	bar:SetScript("OnMouseDown", OnMouseDown)
	tinsert(bars, bar)
	if C.raidcooldown.expiration == true then
		table.sort(bars, sortByExpiration)
	end
	UpdatePositions()
end

local OnEvent = function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, eventType, _, _, sourceName, sourceFlags = ...
		if band(sourceFlags, filter) == 0 then return end
		if eventType == "SPELL_RESURRECT" or eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_AURA_APPLIED" then
			local spellId = select(12, ...)
			if T.raid_spells[spellId] and show[select(2, IsInInstance())] then
				if (sourceName == T.name and C.raidcooldown.show_my == true) or sourceName ~= T.name then
					StartTimer(sourceName, spellId)
				end
			end
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" and select(2, IsInInstance()) == "arena" or not IsInGroup() then
		for k, v in pairs(bars) do
			v.endTime = 0
		end
	end
	if not inEncounter and IsEncounterInProgress() then
		inEncounter = true
	elseif inEncounter and not IsEncounterInProgress() then
		inEncounter = nil
		for k, v in pairs(bars) do
			v.endTime = 0
		end
	end
end

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SlashCmdList.RaidCD = function()
	StartTimer(UnitName("player"), 20484)	-- Rebirth
	StartTimer(UnitName("player"), 20707)	-- Soulstone
	StartTimer(UnitName("player"), 29166)	-- Innervate
end
SLASH_RaidCD1 = "/raidcd"
SLASH_RaidCD2 = "/кфшвсв"