----------------------------------------------------------------------------------------
--	BGScore(by elv22, edited by Tukz)
----------------------------------------------------------------------------------------
if SettingsCF.stats.battleground == true then
	-- Info panel
	local ileft = CreateFrame("Frame", "InfoLeft", UIParent)
	SettingsDB.CreatePanel(ileft, 300, SettingsCF.stats.font_size, unpack(SettingsCF.position.bg_score))
	ileft:SetBackdropBorderColor(0, 0, 0, 0)
	ileft:SetBackdropColor(0, 0, 0, 0)
	ileft.bg:SetVertexColor(0, 0, 0, 0)
	ileft:SetFrameLevel(2)
	ileft:SetFrameStrata("BACKGROUND")

	local bgframe = CreateFrame("Frame", "InfoBattleGround", UIParent)
	SettingsDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetBackdropBorderColor(0, 0, 0, 0)
	bgframe:SetBackdropColor(0, 0, 0, 0)
	bgframe.bg:SetVertexColor(0, 0, 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
	local function OnEvent(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == "pvp") then
				bgframe:Show()
			else
				bgframe:Hide()
			end
		end
	end
	bgframe:SetScript("OnEnter", function(self)
	local numScores = GetNumBattlefieldScores()
		for i = 1, numScores do
			name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
			if ( name ) then
				if ( name == UnitName("player") ) then
					GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 4)
					GameTooltip:ClearLines()
					GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
					GameTooltip:ClearLines()
					GameTooltip:AddLine(STATISTICS.." [|cffCC0033"..name.."|r]")
					GameTooltip:AddLine' '
					GameTooltip:AddDoubleLine(KILLING_BLOWS..":", killingBlows, 1, 1, 1)
					GameTooltip:AddDoubleLine(HONORABLE_KILLS..":", honorableKills, 1, 1, 1)
					GameTooltip:AddDoubleLine(DEATHS..":", deaths, 1, 1, 1)
					GameTooltip:AddDoubleLine(HONOR_GAINED..":", format("%d", honorGained), 1, 1, 1)
					GameTooltip:AddDoubleLine(SCORE_DAMAGE_DONE..":", damageDone, 1, 1, 1)
					GameTooltip:AddDoubleLine(SCORE_HEALING_DONE..":", healingDone, 1, 1, 1)
					--GameTooltip:SetNonSpaceWrap(true)
					-- Add extra statistics to watch based on what BG you are in
					if GetRealZoneText() == L_DATATEXT_ARATHI then
						GameTooltip:AddDoubleLine(L_DATATEXT_BASESASSAULTED, GetBattlefieldStatData(i, 1), 1, 1, 1)
						GameTooltip:AddDoubleLine(L_DATATEXT_BASESDEFENDED, GetBattlefieldStatData(i, 2), 1, 1, 1)
					elseif GetRealZoneText() == L_DATATEXT_WARSONG then
						GameTooltip:AddDoubleLine(L_DATATEXT_FLAGSCAPTURED, GetBattlefieldStatData(i, 1), 1, 1, 1)
						GameTooltip:AddDoubleLine(L_DATATEXT_FLAGSRETURNED, GetBattlefieldStatData(i, 2), 1, 1, 1)
					elseif GetRealZoneText() == L_DATATEXT_EYE then
						GameTooltip:AddDoubleLine(L_DATATEXT_FLAGSCAPTURED, GetBattlefieldStatData(i, 1), 1, 1, 1)
					elseif GetRealZoneText() == L_DATATEXT_ALTERAC then
						GameTooltip:AddDoubleLine(L_DATATEXT_GRAVEYARDSASSAULTED, GetBattlefieldStatData(i, 1), 1, 1, 1)
						GameTooltip:AddDoubleLine(L_DATATEXT_GRAVEYARDSDEFENDED, GetBattlefieldStatData(i, 2), 1, 1, 1)
						GameTooltip:AddDoubleLine(L_DATATEXT_TOWERSASSAULTED, GetBattlefieldStatData(i, 3), 1, 1, 1)
						GameTooltip:AddDoubleLine(L_DATATEXT_TOWERSDEFENDED, GetBattlefieldStatData(i, 4), 1, 1, 1)
					elseif GetRealZoneText() == L_DATATEXT_ANCIENTS then
						GameTooltip:AddDoubleLine(L_DATATEXT_DEMOLISHERSDESTROYED, GetBattlefieldStatData(i, 1), 1, 1, 1)
						GameTooltip:AddDoubleLine(L_DATATEXT_GATESDESTROYED, GetBattlefieldStatData(i, 2), 1, 1, 1)
					elseif GetRealZoneText() == L_DATATEXT_ISLE then
						GameTooltip:AddDoubleLine(L_DATATEXT_BASESASSAULTED, GetBattlefieldStatData(i, 1), 1, 1, 1)
						GameTooltip:AddDoubleLine(L_DATATEXT_BASESDEFENDED, GetBattlefieldStatData(i, 2), 1, 1, 1)
					end					
					GameTooltip:Show()
				end
			end
		end
	end) 
	bgframe:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	bgframe:RegisterEvent("PLAYER_ENTERING_WORLD")
	bgframe:SetScript("OnEvent", OnEvent)

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	
	local Text1 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
	Text1:SetFont(SettingsCF["media"].pixel_font, SettingsCF.stats.font_size, SettingsCF.media.pixel_font_style)
	Text1:SetPoint("LEFT", 5, 0)
	Text1:SetHeight(SettingsCF.stats.font_size)

	local Text2 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
	Text2:SetFont(SettingsCF["media"].pixel_font, SettingsCF.stats.font_size, SettingsCF.media.pixel_font_style)
	Text2:SetPoint("LEFT", Text1, "RIGHT", 5, 0)
	Text2:SetHeight(SettingsCF.stats.font_size)

	local Text3 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
	Text3:SetFont(SettingsCF["media"].pixel_font, SettingsCF.stats.font_size, SettingsCF.media.pixel_font_style)
	Text3:SetPoint("LEFT", Text2, "RIGHT", 5, 0)
	Text3:SetHeight(SettingsCF.stats.font_size)

	local int = 1
	local function Update(self, t)
		int = int - t
		if int < 0 then
			RequestBattlefieldScoreData()
			local numScores = GetNumBattlefieldScores()
			for i = 1, numScores do
				local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
				if healingDone > damageDone then
					dmgtxt = (SHOW_COMBAT_HEALING.." : "..healingDone)
				else
					dmgtxt = (COMBATLOG_HIGHLIGHT_DAMAGE.." : "..damageDone)
				end
				if ( name ) then
					if ( name == UnitName("player") ) then
						Text2:SetText(COMBAT_HONOR_GAIN.." : "..format("%d", honorGained))
						Text1:SetText(dmgtxt)
						Text3:SetText(KILLING_BLOWS.." : "..killingBlows)
					end   
				end
			end 
			int  = 1
		end
	end
	
	-- Hide text when not in an bg
	local function OnEvent(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			inInstance, instanceType = IsInInstance()
			if (not inInstance) or (instanceType == "none") then
				Text1:SetText("")
				Text2:SetText("")
				Text3:SetText("")
			end
		end
	end
	
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end