----------------------------------------------------------------------------------------
--	DBM skin(by Affli)
----------------------------------------------------------------------------------------
if not SettingsCF["skins"].dbm == true then return end

local forcebosshealthclasscolor = false		-- Forces BossHealth to be classcolored. Not recommended.
local croprwicons = true					-- Crops blizz shitty borders from icons in RaidWarning messages
local rwiconsize = 15						-- RaidWarning icon size. Works only if croprwicons = true
local backdrop = {
	bgFile = SettingsCF["media"].blank,
	insets = {left = 0, right = 0, top = 0, bottom = 0},
}

local DBMSkin = CreateFrame("Frame")
DBMSkin:RegisterEvent("PLAYER_LOGIN")
DBMSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("DBM-Core") then
		local function SkinBars(self)
			for bar in self:GetBarIterator() do
				if not bar.injected then
					bar.ApplyStyle = function()
						local frame = bar.frame
						local tbar = _G[frame:GetName().."Bar"]
						local spark = _G[frame:GetName().."BarSpark"]
						local texture = _G[frame:GetName().."BarTexture"]
						local icon1 = _G[frame:GetName().."BarIcon1"]
						local icon2 = _G[frame:GetName().."BarIcon2"]
						local name = _G[frame:GetName().."BarName"]
						local timer = _G[frame:GetName().."BarTimer"]

						if (icon1.overlay) then
							icon1.overlay = _G[icon1.overlay:GetName()]
						else
							icon1.overlay = CreateFrame("Frame", "$parentIcon1Overlay", tbar)
							icon1.overlay:SetWidth(SettingsDB.Scale(25))
							icon1.overlay:SetHeight(SettingsDB.Scale(25))
							icon1.overlay:SetFrameStrata("BACKGROUND")
							icon1.overlay:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", SettingsDB.Scale(-5), SettingsDB.Scale(-2))
							SettingsDB.SkinFadedPanel(icon1.overlay)
						end

						if (icon2.overlay) then
							icon2.overlay = _G[icon2.overlay:GetName()]
						else
							icon2.overlay = CreateFrame("Frame", "$parentIcon2Overlay", tbar)
							icon2.overlay:SetWidth(SettingsDB.Scale(25))
							icon2.overlay:SetHeight(SettingsDB.Scale(25))
							icon2.overlay:SetFrameStrata("BACKGROUND")
							icon2.overlay:SetPoint("BOTTOMLEFT", tbar, "BOTTOMRIGHT", SettingsDB.Scale(5), SettingsDB.Scale(-2))
							SettingsDB.SkinFadedPanel(icon2.overlay)
						end

						if bar.color then
							tbar:SetStatusBarColor(bar.color.r, bar.color.g, bar.color.b)
							tbar:SetBackdrop(backdrop)
							tbar:SetBackdropColor(bar.color.r, bar.color.g, bar.color.b, 0.15)
						else
							tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
							tbar:SetBackdrop(backdrop)
							tbar:SetBackdropColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB, 0.15)
						end
						
						if bar.enlarged then frame:SetWidth(SettingsDB.Scale(bar.owner.options.HugeWidth)) else frame:SetWidth(SettingsDB.Scale(bar.owner.options.Width)) end
						if bar.enlarged then tbar:SetWidth(SettingsDB.Scale(bar.owner.options.HugeWidth)) else tbar:SetWidth(SettingsDB.Scale(bar.owner.options.Width)) end

						if not frame.styled then
							bar.frame:SetScale(1)
							frame:SetHeight(SettingsDB.Scale(19))
							SettingsDB.CreateTemplate(bar.frame)
							frame.styled = true
						end

						if not spark.killed then
							spark:SetAlpha(0)
							spark:SetTexture(nil)
							spark.killed = true
						end
			
						if not icon1.styled then
							icon1:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							icon1:ClearAllPoints()
							icon1:SetPoint("TOPLEFT", icon1.overlay, SettingsDB.Scale(2), SettingsDB.Scale(-2))
							icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, SettingsDB.Scale(-2), SettingsDB.Scale(2))
							icon1.styled = true
						end
						
						if not icon2.styled then
							icon2:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							icon2:ClearAllPoints()
							icon2:SetPoint("TOPLEFT", icon2.overlay, SettingsDB.Scale(2), SettingsDB.Scale(-2))
							icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, SettingsDB.Scale(-2), SettingsDB.Scale(2))
							icon2.styled=true
						end
						
						if not texture.styled then
							texture:SetTexture(SettingsCF["media"].texture)
							texture.styled = true
						end
						
						if not tbar.styled then
							tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
							tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
							tbar.styled = true
						end

						if not name.styled then
							name:ClearAllPoints()
							name:SetPoint("LEFT", frame, "LEFT", SettingsDB.Scale(4), 0)
							name:SetWidth(165)
							name:SetHeight(8)
							name:SetFont(SettingsCF["font"].stylization_font, SettingsCF["font"].stylization_font_size, SettingsCF["font"].stylization_font_style)
							name:SetShadowOffset(SettingsCF["font"].stylization_font_shadow and 1 or 0, SettingsCF["font"].stylization_font_shadow and -1 or 0)
							name:SetJustifyH("LEFT")
							name.SetFont = SettingsDB.dummy
							name.styled = true
						end
						
						if not timer.styled then	
							timer:ClearAllPoints()
							timer:SetPoint("RIGHT", frame, "RIGHT", SettingsDB.Scale(-1), 0)
							timer:SetFont(SettingsCF["font"].stylization_font, SettingsCF["font"].stylization_font_size, SettingsCF["font"].stylization_font_style)
							timer:SetShadowOffset(SettingsCF["font"].stylization_font_shadow and 1 or 0, SettingsCF["font"].stylization_font_shadow and -1 or 0)
							timer:SetJustifyH("RIGHT")
							timer.SetFont = SettingsDB.dummy
							timer.styled = true
						end
						
						if bar.owner.options.IconLeft then icon1:Show() icon1.overlay:Show() else icon1:Hide() icon1.overlay:Hide() end
						if bar.owner.options.IconRight then icon2:Show() icon2.overlay:Show() else icon2:Hide() icon2.overlay:Hide() end
						tbar:SetAlpha(1)
						frame:SetAlpha(1)
						texture:SetAlpha(1)
						frame:Show()
						bar:Update(0)
						bar.injected = true
					end
					bar:ApplyStyle()
				end
			end
		end

		local SkinBossTitle = function()
			local anchor = DBMBossHealthDropdown:GetParent()
			if not anchor.styled then
				local header = {anchor:GetRegions()}
				if header[1]:IsObjectType("FontString") then
					header[1]:SetFont(SettingsCF["font"].stylization_font, SettingsCF["font"].stylization_font_size, SettingsCF["font"].stylization_font_style)
					header[1]:SetShadowOffset(SettingsCF["font"].stylization_font_shadow and 1 or 0, SettingsCF["font"].stylization_font_shadow and -1 or 0)
					header[1]:SetTextColor(1, 1, 1, 1)
					anchor.styled = true	
				end
				header = nil
			end
			anchor = nil
		end
		
		local SkinBoss = function()
			local count = 1
			while (_G[format("DBM_BossHealth_Bar_%d", count)]) do
				local bar = _G[format("DBM_BossHealth_Bar_%d", count)]
				local background = _G[bar:GetName().."BarBorder"]
				local progress = _G[bar:GetName().."Bar"]
				local name = _G[bar:GetName().."BarName"]
				local timer = _G[bar:GetName().."BarTimer"]
				local prev = _G[format("DBM_BossHealth_Bar_%d", count-1)]

				if (count == 1) then
					local _, anch, _ , _, _ = bar:GetPoint()
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("BOTTOM", anch, "TOP", 0, SettingsDB.Scale(3))
					else
						bar:SetPoint("TOP", anch, "BOTTOM", 0, SettingsDB.Scale(-3))
					end
				else
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("BOTTOMLEFT", prev, "TOPLEFT", 0, SettingsDB.Scale(3))
					else
						bar:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, SettingsDB.Scale(-3))
					end
				end

				if not bar.styled then
					bar:SetScale(1)
					bar:SetHeight(SettingsDB.Scale(19))
					SettingsDB.CreateTemplate(bar)
					background:SetNormalTexture(nil)
					bar.styled = true
				end	
				
				if not progress.styled then
					progress:SetStatusBarTexture(SettingsCF["media"].texture)
					progress:SetBackdrop(backdrop)
					progress:SetBackdropColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 0.15)
					if forcebosshealthclasscolor then
						progress:SetStatusBarColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 1)
						progress:HookScript("OnUpdate", function(self, v)
							self:SetStatusBarColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 1)
						end)
					end
					progress.styled = true
				end
				progress:ClearAllPoints()
				progress:SetPoint("TOPLEFT", bar, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
				progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("LEFT", bar, "LEFT", SettingsDB.Scale(4), 0)
					name:SetFont(SettingsCF["font"].stylization_font, SettingsCF["font"].stylization_font_size, SettingsCF["font"].stylization_font_style)
					name:SetShadowOffset(SettingsCF["font"].stylization_font_shadow and 1 or 0, SettingsCF["font"].stylization_font_shadow and -1 or 0)
					name:SetJustifyH("LEFT")
					name.styled = true
				end
				
				if not timer.styled then
					timer:ClearAllPoints()
					timer:SetPoint("RIGHT", bar, "RIGHT", SettingsDB.Scale(-1), 0)
					timer:SetFont(SettingsCF["font"].stylization_font, SettingsCF["font"].stylization_font_size, SettingsCF["font"].stylization_font_style)
					timer:SetShadowOffset(SettingsCF["font"].stylization_font_shadow and 1 or 0, SettingsCF["font"].stylization_font_shadow and -1 or 0)
					timer:SetJustifyH("RIGHT")
					timer.styled = true
				end
				count = count + 1
			end
		end
		
		hooksecurefunc(DBT, "CreateBar", SkinBars)
		hooksecurefunc(DBM.BossHealth, "Show", SkinBossTitle)
		hooksecurefunc(DBM.BossHealth, "AddBoss", SkinBoss)

		DBM.RangeCheck:Show()
		DBM.RangeCheck:Hide()

		DBMRangeCheck:HookScript("OnShow", function(self)
			SettingsDB.SkinFadedPanel(self)
		end)
		
		if croprwicons then
			local replace = string.gsub
			local old = RaidNotice_AddMessage
			RaidNotice_AddMessage = function(noticeFrame, textString, colorInfo)
				if textString:find(" |T") then
					textString=replace(textString,"(:12:12)",":"..rwiconsize..":"..rwiconsize..":0:0:64:64:5:59:5:59")
				end
				return old(noticeFrame, textString, colorInfo)
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	DBM settings(by ALZA and help from Affli)
----------------------------------------------------------------------------------------
function SettingsDB.UploadDBM()
	--if(DBM_SavedOptions) then table.wipe(DBM_SavedOptions) end
	DBM_SavedOptions.Enabled = true
	DBM_SavedOptions.ShowMinimapButton = false
	DBM_SavedOptions.WarningIconLeft = false
	DBM_SavedOptions.WarningIconRight = false
	DBM_SavedOptions["WarningColors"] = {
		{["b"] = SettingsDB.color.b, ["g"] = SettingsDB.color.g, ["r"] = SettingsDB.color.r,},
		{["b"] = SettingsDB.color.b, ["g"] = SettingsDB.color.g, ["r"] = SettingsDB.color.r,},
		{["b"] = SettingsDB.color.b, ["g"] = SettingsDB.color.g, ["r"] = SettingsDB.color.r,},
		{["b"] = SettingsDB.color.b, ["g"] = SettingsDB.color.g, ["r"] = SettingsDB.color.r,},
	}
	DBM_SavedOptions.HealthFrameGrowUp = false
	DBM_SavedOptions.HealthFrameWidth = 218
	DBM_SavedOptions.HPFrameX = 100
	DBM_SavedOptions.HPFramePoint = "LEFT"
	DBM_SavedOptions.RangeFrameX = 244
	DBM_SavedOptions.RangeFramePoint = "LEFT"
	DBM_SavedOptions.ShowSpecialWarnings = true
	DBM_SavedOptions.SpecialWarningFont = SettingsCF.media.normal_font
	DBM_SavedOptions.SpecialWarningFontSize = 50
	DBM_SavedOptions.SpecialWarningX = 0
	DBM_SavedOptions.SpecialWarningY = 75

	DBT_SavedOptions["DBM"].StartColorR = SettingsDB.color.r
	DBT_SavedOptions["DBM"].StartColorG = SettingsDB.color.g
	DBT_SavedOptions["DBM"].StartColorB = SettingsDB.color.b
	DBT_SavedOptions["DBM"].EndColorR = SettingsDB.color.r
	DBT_SavedOptions["DBM"].EndColorG = SettingsDB.color.g
	DBT_SavedOptions["DBM"].EndColorB = SettingsDB.color.b
	DBT_SavedOptions["DBM"].Scale = 1
	DBT_SavedOptions["DBM"].HugeScale = 1
	DBT_SavedOptions["DBM"].BarXOffset = 0
	DBT_SavedOptions["DBM"].BarYOffset = 7
	DBT_SavedOptions["DBM"].Font = SettingsCF.font.stylization_font
	DBT_SavedOptions["DBM"].FontSize = SettingsCF.font.stylization_font_size
	DBT_SavedOptions["DBM"].Width = 190
	DBT_SavedOptions["DBM"].TimerX = 143
	DBT_SavedOptions["DBM"].TimerPoint = "BOTTOMLEFT"
	DBT_SavedOptions["DBM"].FillUpBars = true
	DBT_SavedOptions["DBM"].IconLeft = true
	DBT_SavedOptions["DBM"].ExpandUpwards = true
	DBT_SavedOptions["DBM"].Texture = SettingsCF.media.texture
	DBT_SavedOptions["DBM"].IconRight = false
	DBT_SavedOptions["DBM"].HugeBarXOffset = 0
	DBT_SavedOptions["DBM"].HugeBarsEnabled = false
	DBT_SavedOptions["DBM"].HugeWidth = 190
	DBT_SavedOptions["DBM"].HugeTimerX = 7
	DBT_SavedOptions["DBM"].HugeTimerPoint = "CENTER"
	DBT_SavedOptions["DBM"].HugeBarYOffset = 7
	
	if SettingsCF.actionbar.bottombars == 1 then
		DBM_SavedOptions.HPFrameY = 126
		DBM_SavedOptions.RangeFrameY = 101
		DBT_SavedOptions["DBM"].TimerY = 139
		DBT_SavedOptions["DBM"].HugeTimerY = -136
	elseif SettingsCF.actionbar.bottombars == 2 then
		DBM_SavedOptions.HPFrameY = 154
		DBM_SavedOptions.RangeFrameY = 129
		DBT_SavedOptions["DBM"].TimerY = 167
		DBT_SavedOptions["DBM"].HugeTimerY = -108
	elseif SettingsCF.actionbar.bottombars == 3 then
		DBM_SavedOptions.HPFrameY = 182
		DBM_SavedOptions.RangeFrameY = 157
		DBT_SavedOptions["DBM"].TimerY = 195
		DBT_SavedOptions["DBM"].HugeTimerY = -80
	end
	DBM_SavedOptions.InstalledBars = SettingsCF.actionbar.bottombars
end

StaticPopupDialogs["SETTINGS_DBM"] = {
	text = L_POPUP_SETTINGS_DBM,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = function() SettingsDB.UploadDBM() ReloadUI() end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = true,
}

----------------------------------------------------------------------------------------
--	On logon function
----------------------------------------------------------------------------------------
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	if IsAddOnLoaded("DBM-Core") then
		if DBM_SavedOptions.InstalledBars ~= SettingsCF.actionbar.bottombars then
			--if (DBM_SavedOptions == nil) then DBM_SavedOptions = {} end
			--if(DBM_SavedOptions) then table.wipe(DBM_SavedOptions) end
			StaticPopup_Show("SETTINGS_DBM")
		end
	end
end)