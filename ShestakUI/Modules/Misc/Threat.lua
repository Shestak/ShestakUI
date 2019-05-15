local T, C, L, _ = unpack(select(2, ...))
if C.threat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on alThreatMeter(by Allez)
----------------------------------------------------------------------------------------
local spacing = 7

local ThreatMeterAnchor = CreateFrame("Frame", "ThreatMeterAnchor", UIParent)
ThreatMeterAnchor:SetSize(C.threat.width + 4, (C.threat.height * C.threat.bar_rows) + (spacing * (C.threat.bar_rows - 1)) + 4)
if C.actionbar.split_bars then
	ThreatMeterAnchor:SetPoint(C.position.threat_meter[1], SplitBarRight, C.position.threat_meter[3], C.position.threat_meter[4], C.position.threat_meter[5])
else
	ThreatMeterAnchor:SetPoint(unpack(C.position.threat_meter))
end

local bar, tList, barList = {}, {}, {}
local max = math.max
local targeted = false

RAID_CLASS_COLORS["PET"] = {r = 0, g = 0.7, b = 0, colorStr = "ff00b200"}

local CreateFS = function(frame)
	local fstring = frame:CreateFontString(nil, "OVERLAY")
	fstring:SetFont(C.font.threat_meter_font, C.font.threat_meter_font_size, C.font.threat_meter_font_style)
	fstring:SetShadowOffset(C.font.threat_meter_font_shadow and 1 or 0, C.font.threat_meter_font_shadow and -1 or 0)
	return fstring
end

local truncate = function(value)
	if value >= 1e6 then
		return string.format("%.2fb", value / 1e6)
	elseif value >= 1e3 then
		return string.format("%.2fm", value / 1e3)
	else
		return string.format("%.0fk", value)
	end
end

local AddUnit = function(unit)
	local threatpct, _, threatval = select(3, UnitDetailedThreatSituation(unit, "target"))
	if threatval and threatval < 0 then
		threatval = threatval + 410065408
	end
	local guid = UnitGUID(unit)
	if not tList[guid] then
		tinsert(barList, guid)
		tList[guid] = {
			name = UnitName(unit),
			class = UnitIsPlayer(unit) and select(2, UnitClass(unit)) or "PET",
		}
	end
	tList[guid].pct = threatpct or 0
	tList[guid].val = threatval or 0
end

local CheckUnit = function(unit)
	if UnitExists(unit) and UnitIsVisible(unit) then
		AddUnit(unit)
		if UnitExists(unit.."pet") then
			AddUnit(unit.."pet")
		end
	end
end

local CreateBar = function()
	local bar = CreateFrame("Statusbar", nil, UIParent)
	bar:SetSize(C.threat.width, C.threat.height)
	bar:SetStatusBarTexture(C.media.texture)
	bar:SetMinMaxValues(0, 100)
	bar:CreateBackdrop("Default")

	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(C.media.texture)

	bar.left = CreateFS(bar)
	bar.left:SetPoint("LEFT", 2, 0)
	bar.left:SetJustifyH("LEFT")

	bar.right = CreateFS(bar)
	bar.right:SetPoint("RIGHT", 1, 0)
	bar.right:SetJustifyH("RIGHT")

	bar:Hide()
	return bar
end

local SortMethod = function(a, b)
	return tList[b].pct < tList[a].pct
end

local UpdateBars = function()
	for _, v in pairs(bar) do
		v:Hide()
	end
	table.sort(barList, SortMethod)
	for i = 1, #barList do
		cur = tList[barList[i]]
		max = tList[barList[1]]
		if i > C.threat.bar_rows or not cur or cur.pct == 0 then break end
		if not bar[i] then
			bar[i] = CreateBar()
			if i == 1 then
				bar[i]:SetPoint("TOP", ThreatMeterAnchor, "TOP", 0, -2)
			else
				bar[i]:SetPoint("TOPLEFT", bar[i-1], "BOTTOMLEFT", 0, -spacing)
			end
		end
		bar[i]:SetValue(100 * cur.pct / max.pct)
		local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[cur.class]
		bar[i]:SetStatusBarColor(color.r, color.g, color.b)
		bar[i].bg:SetVertexColor(color.r, color.g, color.b, 0.2)
		bar[i].left:SetText(cur.name)
		bar[i].right:SetText(string.format("%s [%d%%]", truncate(cur.val / 1000), cur.pct))
		bar[i]:Show()
	end
end

local UpdateThreat = function()
	if targeted then
		if GetNumGroupMembers() > 0 then
			local unit = IsInRaid() and "raid" or "party"
			for i = 1, GetNumGroupMembers(), 1 do
				CheckUnit(unit..i)
			end
		end
		CheckUnit("targettarget")
		CheckUnit("player")
	end
	UpdateBars()
end

local lastCombatLogUpdate = 0

local OnEvent = function(self, event, ...)
	if event == "PLAYER_TARGET_CHANGED" or event == "UNIT_THREAT_LIST_UPDATE" or event == "PLAYER_REGEN_DISABLED" then
		if C.threat.hide_solo == true and GetNumGroupMembers() == 0 then
			targeted = false
		else
			if UnitExists("target") and not UnitIsDead("target") and not UnitIsPlayer("target") and UnitCanAttack("player", "target") then
				targeted = true
			else
				targeted = false
			end
		end
	end
	if event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_REGEN_ENABLED" then
		wipe(tList)
		wipe(barList)
		if T.classic then
			lastCombatLogUpdate = 0
			if event == "PLAYER_REGEN_ENABLED" then
				targeted = false
			end
		end
	end
	UpdateThreat()
end

if T.classic then
	local UpdateFromCombatLog = CreateFrame("Frame")
	UpdateFromCombatLog:SetScript("OnEvent", function(self, event, ...)
		if not UnitAffectingCombat("player") then return end
		if GetTime() - lastCombatLogUpdate > 0.25 then
			lastCombatLogUpdate = GetTime()
			OnEvent()
		end
	end)
	UpdateFromCombatLog:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("PLAYER_TARGET_CHANGED")
if not T.classic then
	addon:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
else
	addon:RegisterEvent("PLAYER_REGEN_DISABLED")
end
addon:RegisterEvent("PLAYER_REGEN_ENABLED")

SlashCmdList.alThreat = function()
	for i = 1, C.threat.bar_rows do
		tList[i] = {
			name = UnitName("player"),
			class = select(2, UnitClass("player")),
			pct = i / C.threat.bar_rows * 100,
			val = i * 10000,
		}
		tinsert(barList, i)
	end
	UpdateBars()
	wipe(tList)
	wipe(barList)
end
SLASH_alThreat1 = "/threat"
SLASH_alThreat2 = "/еркуфе"