local T, C, L = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	Based on alThreatMeter
----------------------------------------------------------------------------------------
if not C.threat.enable == true then return end

local spacing = 7

local ThreatMeterAnchor = CreateFrame("Frame", "ThreatMeterAnchor", UIParent)
ThreatMeterAnchor:SetFrameStrata("HIGH")
ThreatMeterAnchor:SetFrameLevel(20)
ThreatMeterAnchor:Size(C.threat.width + 4, (C.threat.height * C.threat.bar_rows) + (spacing * (C.threat.bar_rows - 1)) + 4)
ThreatMeterAnchor:Point(unpack(C.position.threat_meter))
ThreatMeterAnchor:SetClampedToScreen(true)
ThreatMeterAnchor:SetMovable(true)
ThreatMeterAnchor:SetTemplate("Transparent")
ThreatMeterAnchor:SetBackdropColor(0, 0, 0, 0)
ThreatMeterAnchor:SetBackdropBorderColor(0, 0, 0, 0)
ThreatMeterAnchor.iborder:SetBackdropBorderColor(0, 0, 0, 0)
ThreatMeterAnchor.oborder:SetBackdropBorderColor(0, 0, 0, 0)
ThreatMeterAnchor.text = ThreatMeterAnchor:CreateFontString("ThreatMeterAnchorText", "OVERLAY", nil)
ThreatMeterAnchor.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
ThreatMeterAnchor.text:SetPoint("CENTER")
ThreatMeterAnchor.text:SetText("ThreatMeter Anchor")
ThreatMeterAnchor.text:SetParent(ThreatMeterAnchor)
ThreatMeterAnchor.text:Hide()

local bar, tList, barList = {}, {}, {}
local max = math.max
local timer = 0
local targeted = false

RAID_CLASS_COLORS["PET"] = {r = 0, g = 0.7, b = 0,}

local CreateFS = function(frame, fsize, fstyle)
	local fstring = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	fstring:SetFont(C.font.threat_meter_font, C.font.threat_meter_font_size, C.font.threat_meter_font_style)
	fstring:SetShadowOffset(C.font.threat_meter_font_shadow and 1 or 0, C.font.threat_meter_font_shadow and -1 or 0)
	return fstring
end

local truncate = function(value)
	if value >= 1e6 then
		return string.format("%.2fm", value / 1e6)
	elseif value >= 1e4 then
		return string.format("%.1fk", value / 1e3)
	else
		return string.format("%.0f", value)
	end
end

local AddUnit = function(unit)
	local threatpct, rawpct, threatval = select(3, UnitDetailedThreatSituation(unit, "target"))
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
	bar:Size(C.threat.width, C.threat.height)
	bar:SetStatusBarTexture(C.media.texture)
	bar:SetMinMaxValues(0, 100)
	
	bar.backdrop = CreateFrame("Frame", nil, bar)
	bar.backdrop:Point("TOPLEFT", -2, 2)
	bar.backdrop:Point("BOTTOMRIGHT", 2, -2)
	bar.backdrop:SetTemplate("Default")
	bar.backdrop:SetFrameStrata("BACKGROUND")
	
	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(C.media.texture)
	
	bar.left = CreateFS(bar)
	bar.left:Point("LEFT", 2, 0)
	bar.left:SetJustifyH("LEFT")
	
	bar.right = CreateFS(bar)
	bar.right:Point("RIGHT", 1, 0)
	bar.right:SetJustifyH("RIGHT")
	
	bar:Hide()
	return bar
end

local SortMethod = function(a, b)
	return tList[b].pct < tList[a].pct
end

local UpdateBars = function()
	for i, v in pairs(bar) do
		v:Hide()
	end
	table.sort(barList, SortMethod)
	for i = 1, #barList do
		cur = tList[barList[i]]
		max = tList[barList[1]]
		if i > C.threat.bar_rows or not cur or cur.pct == 0 then break end
		if not bar[i] then 
			bar[i] = CreateBar()
			--bar[i]:Point("TOP", ThreatMeterAnchor, 0, - (C.threat.height + spacing) * (i-1))
			if i == 1 then
				bar[i]:Point("TOP", ThreatMeterAnchor, "TOP", 0, -2)
			else
				bar[i]:Point("TOPLEFT", bar[i-1], "BOTTOMLEFT", 0, -spacing)
			end
		end
		bar[i]:SetValue(100 * cur.pct / max.pct)
		local color = RAID_CLASS_COLORS[cur.class]
		bar[i]:SetStatusBarColor(color.r, color.g, color.b)
		bar[i].bg:SetVertexColor(color.r, color.g, color.b, 0.25)
		bar[i].left:SetText(cur.name)
		bar[i].right:SetText(string.format("%s [%d%%]", truncate(cur.val/100), cur.pct))
		bar[i]:Show()
	end
end

local UpdateThreat = function()
	if targeted then
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers(), 1 do
				CheckUnit("raid"..i)
			end
		elseif GetNumPartyMembers() > 0 then
			for i = 1, GetNumPartyMembers(), 1 do
				CheckUnit("party"..i)
			end
		end
		CheckUnit("targettarget")
		CheckUnit("player")
	end
	UpdateBars()
end

local OnEvent = function(self, event, ...)
	if event == "PLAYER_TARGET_CHANGED" or event == "UNIT_THREAT_LIST_UPDATE" then
		if UnitExists("target") and not UnitIsDead("target") and not UnitIsPlayer("target") and UnitCanAttack("player", "target") then
			targeted = true
		else
			targeted = false
		end
	end
	if event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_REGEN_ENABLED" then
		wipe(tList)
		wipe(barList)
	end
	UpdateThreat()
end

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("PLAYER_TARGET_CHANGED")
addon:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
addon:RegisterEvent("PLAYER_REGEN_ENABLED")

SlashCmdList.alThreat = function(msg)
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