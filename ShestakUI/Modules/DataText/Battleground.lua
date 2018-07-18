local T, C, L, _ = unpack(select(2, ...))
if C.stats.battleground ~= true then return end

----------------------------------------------------------------------------------------
--	BGScore(by Elv22, edited by Tukz)
----------------------------------------------------------------------------------------
-- Map IDs
local WSG = 92
local TP = 206
local AV = 91
local SOTA = 128
local IOC = 169
local EOTS = 112
local TBFG = 275
local AB = 93
local TOK = 417
local SSM = 423
local DG = 519
local SS = 907

local classcolor = ("|cff%.2x%.2x%.2x"):format(T.color.r * 255, T.color.g * 255, T.color.b * 255)

local BGFrame = CreateFrame("Frame", "InfoBattleGround", UIParent)
BGFrame:CreatePanel("Invisible", 300, C.font.stats_font_size, unpack(C.position.bg_score))
BGFrame:EnableMouse(true)
BGFrame:SetScript("OnEnter", function(self)
	local numScores = GetNumBattlefieldScores()
	for i = 1, numScores do
		local name, _, honorableKills, deaths, _, _, _, _, _, damageDone, healingDone = GetBattlefieldScore(i)
		if name and name == T.name then
			local areaID = C_Map.GetBestMapForUnit("player") or 0
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, T.Scale(4))
			GameTooltip:ClearLines()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(STATISTICS, classcolor..name.."|r")
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(HONORABLE_KILLS..":", honorableKills, 1, 1, 1)
			GameTooltip:AddDoubleLine(DEATHS..":", deaths, 1, 1, 1)
			GameTooltip:AddDoubleLine(DAMAGE..":", damageDone, 1, 1, 1)
			GameTooltip:AddDoubleLine(SHOW_COMBAT_HEALING..":", healingDone, 1, 1, 1)
			-- Add extra statistics depending on what BG you are
			if areaID == WSG or areaID == TP then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2)..":", GetBattlefieldStatData(i, 2), 1, 1, 1)
			elseif areaID == EOTS then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
			elseif areaID == AV then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2)..":", GetBattlefieldStatData(i, 2), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(3)..":", GetBattlefieldStatData(i, 3), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(4)..":", GetBattlefieldStatData(i, 4), 1, 1, 1)
			elseif areaID == SOTA then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2)..":", GetBattlefieldStatData(i, 2), 1, 1, 1)
			elseif areaID == IOC or areaID == TBFG or areaID == AB then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2)..":", GetBattlefieldStatData(i, 2), 1, 1, 1)
			elseif areaID == TOK then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2)..":", GetBattlefieldStatData(i, 2), 1, 1, 1)
			elseif areaID == SSM then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
			elseif areaID == DG then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2)..":", GetBattlefieldStatData(i, 3), 1, 1, 1)
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(3)..":", GetBattlefieldStatData(i, 4), 1, 1, 1)
			elseif areaID == SS then
				GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1)..":", GetBattlefieldStatData(i, 1), 1, 1, 1)
			end
			break
		end
	end
	GameTooltip:Show()
end)

BGFrame:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
BGFrame:SetScript("OnMouseUp", function(self, button)
	if QueueStatusMinimapButton:IsShown() then
		if button == "RightButton" then
			ToggleBattlefieldMap()
		else
			ToggleWorldStateScoreFrame()
		end
	end
end)

local Stat = CreateFrame("Frame")
Stat:EnableMouse(true)

local Text1 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
Text1:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
Text1:SetShadowOffset(C.font.stats_font_shadow and 1 or 0, C.font.stats_font_shadow and -1 or 0)
Text1:SetPoint("LEFT", 5, 0)
Text1:SetHeight(C.font.stats_font_size)

local Text2 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
Text2:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
Text2:SetShadowOffset(C.font.stats_font_shadow and 1 or 0, C.font.stats_font_shadow and -1 or 0)
Text2:SetPoint("LEFT", Text1, "RIGHT", 5, 0)
Text2:SetHeight(C.font.stats_font_size)

local Text3 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
Text3:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
Text3:SetShadowOffset(C.font.stats_font_shadow and 1 or 0, C.font.stats_font_shadow and -1 or 0)
Text3:SetPoint("LEFT", Text2, "RIGHT", 5, 0)
Text3:SetHeight(C.font.stats_font_size)

local int = 2
local function Update(self, t)
	int = int - t
	if int < 0 then
		local dmgtxt
		RequestBattlefieldScoreData()
		local numScores = GetNumBattlefieldScores()
		for i = 1, numScores do
			local name, killingBlows, _, _, honorGained, _, _, _, _, damageDone, healingDone = GetBattlefieldScore(i)
			if healingDone > damageDone then
				dmgtxt = (classcolor..SHOW_COMBAT_HEALING.." :|r "..T.ShortValue(healingDone))
			else
				dmgtxt = (classcolor..DAMAGE.." :|r "..T.ShortValue(damageDone))
			end
			if name and name == T.name then
				Text1:SetText(dmgtxt)
				Text2:SetText(classcolor..COMBAT_HONOR_GAIN.." :|r "..format("%d", honorGained))
				Text3:SetText(classcolor..KILLING_BLOWS.." :|r "..killingBlows)
			end
		end
		int = 2
	end
end

-- Hide text when not in an bg
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" then
			BGFrame:Show()
		else
			Text1:SetText("")
			Text2:SetText("")
			Text3:SetText("")
			BGFrame:Hide()
		end
	end
end

Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnUpdate", Update)
Update(Stat, 2)