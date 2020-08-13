local T, C, L, _ = unpack(select(2, ...))
if C.stats.battleground ~= true then return end

----------------------------------------------------------------------------------------
--	BGScore(by Elv22, edited by Tukz)
----------------------------------------------------------------------------------------
local classcolor = ("|cff%.2x%.2x%.2x"):format(C.media.classborder_color[1] * 255, C.media.classborder_color[2] * 255, C.media.classborder_color[3] * 255)

local BGFrame = CreateFrame("Frame", "InfoBattleGround", UIParent)
BGFrame:CreatePanel("Invisible", 300, C.font.stats_font_size, unpack(C.position.bg_score))
BGFrame:EnableMouse(true)
BGFrame:SetScript("OnEnter", function(self)
	local pvpStatIDs = C_PvP.GetMatchPVPStatIDs()

	for i = 1, GetNumBattlefieldScores() do
		local name, _, honorableKills, deaths, _, _, _, _, _, damageDone, healingDone = GetBattlefieldScore(i)
		if name and name == T.name then
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, T.Scale(4))
			GameTooltip:ClearLines()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(STATISTICS, classcolor..name.."|r")
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(HONORABLE_KILLS..":", honorableKills, 1, 1, 1)
			GameTooltip:AddDoubleLine(DEATHS..":", deaths, 1, 1, 1)
			GameTooltip:AddDoubleLine(DAMAGE..":", T.ShortValue(damageDone), 1, 1, 1)
			GameTooltip:AddDoubleLine(SHOW_COMBAT_HEALING..":", T.ShortValue(healingDone), 1, 1, 1)

			-- Add extra statistics depending on what BG you are
			for j = 1, #pvpStatIDs do
				local info = C_PvP.GetMatchPVPStatColumn(pvpStatIDs[j])
				if info then
					GameTooltip:AddDoubleLine(info.name..":", GetBattlefieldStatData(i, j), 1, 1, 1)
				end
			end

			break
		end
	end
	GameTooltip:Show()
end)

BGFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
BGFrame:SetScript("OnMouseUp", function(_, button)
	if QueueStatusMinimapButton:IsShown() then
		if button == "RightButton" then
			ToggleBattlefieldMap()
		else
			TogglePVPScoreboardOrResults()
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
local function Update(_, t)
	int = int - t
	if int < 0 then
		local dmgtxt
		RequestBattlefieldScoreData()
		for i = 1, GetNumBattlefieldScores() do
			local name, killingBlows, _, _, honorGained, _, _, _, _, damageDone, healingDone = GetBattlefieldScore(i)
			if name and name == T.name then
				if healingDone > damageDone then
					dmgtxt = (classcolor..SHOW_COMBAT_HEALING.." :|r "..T.ShortValue(healingDone))
				else
					dmgtxt = (classcolor..DAMAGE.." :|r "..T.ShortValue(damageDone))
				end
				Text1:SetText(dmgtxt)
				Text2:SetText(classcolor..COMBAT_HONOR_GAIN.." :|r "..format("%d", honorGained))
				Text3:SetText(classcolor..KILLING_BLOWS.." :|r "..killingBlows)
			end
		end
		int = 2
	end
end

-- Hide text when not in an bg
local function OnEvent(_, event)
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