----------------------------------------------------------------------------------------
--	BigWigs skin(by Affli)
----------------------------------------------------------------------------------------
--if not SettingsCF.skins.bw == true then return end

local classcolor = true			-- Classcolored bars
local skinrange = true			-- Skin distance window

local barcolor = classcolor and RAID_CLASS_COLORS[SettingsDB.class]
local buttonsize = 21

-- Init some tables to store backgrounds
local freebg = {}
local freeibg = {}

-- Init some vars to store methods
local setpoint, setpoint2, setwidth, setscale

-- Styling functions
local createbg = function()
	local bg = CreateFrame("Frame")
	SettingsDB.CreateTemplate(bg)
	return bg
end

local function freestyle(bar)
	-- Reparent and hide bar background
	local bg = bar:Get("bigwigs:shestakui:bg")
	if bg then
		bg:ClearAllPoints()
		bg:SetParent(UIParent)
		bg:Hide()
		freebg[#freebg + 1] = bg
	end
	
	-- Reparent and hide icon background
	local ibg = bar:Get("bigwigs:shestakui:bg")
	if ibg then
		ibg:ClearAllPoints()
		ibg:SetParent(UIParent)
		ibg:Hide()
		freeibg[#freeibg + 1] = ibg
	end
	
	-- Replace dummies with original method functions
	bar.candyBarIconFrame.SetPoint = setpoint
	bar.candyBarBackground.SetPoint = setpoint2
	bar.candyBarIconFrame.SetWidth = setwidth
	bar.SetScale = setscale
end

local applystyle = function(bar)
	-- General bar settings
	bar:SetHeight(SettingsDB.Scale(15))
	bar:SetScale(1)
	bar.SetScale = SettingsDB.dummy
	setscale = bar.SetScale
	
	-- Create or reparent and use bar background
	local bg = nil
	if #freebg > 0 then
		bg = table.remove(freebg)
	else
		bg = createbg()
	end
	bg:SetParent(bar)
	bg:ClearAllPoints()
	bg:SetPoint("TOPLEFT", bar, "TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	bg:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
	bg:SetFrameStrata("BACKGROUND")
	bg:Show()
	bar:Set("bigwigs:shestakui:bg", bg)
	
	-- Create or reparent and use icon background
	local ibg = nil
	if bar.candyBarIconFrame:GetTexture() then
		if #freeibg > 0 then
			ibg = table.remove(freeibg)
		else
			ibg = createbg()
		end
		ibg:SetParent(bar)
		ibg:ClearAllPoints()
		ibg:SetPoint("TOPLEFT", bar.candyBarIconFrame, "TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		ibg:SetPoint("BOTTOMRIGHT", bar.candyBarIconFrame, "BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		ibg:SetFrameStrata("BACKGROUND")
		ibg:Show()
		--ibg:Set("bigwigs:shestakui:ibg", ibg)
	end
	
	-- Setup timer and bar name fonts and positions
	bar.candyBarLabel:SetFont(SettingsCF.font.stylization_font, SettingsCF.font.stylization_font_size, SettingsCF.font.stylization_font_style)
	bar.candyBarLabel:SetShadowOffset(SettingsCF.font.stylization_font_shadow and 1 or 0, SettingsCF.font.stylization_font_shadow and -1 or 0)
	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:SetPoint("LEFT", bar, "LEFT", SettingsDB.Scale(2), 0)
	
	bar.candyBarDuration:SetFont(SettingsCF.font.stylization_font, SettingsCF.font.stylization_font_size, SettingsCF.font.stylization_font_style)
	bar.candyBarDuration:SetShadowOffset(SettingsCF.font.stylization_font_shadow and 1 or 0, SettingsCF.font.stylization_font_shadow and -1 or 0)
	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:SetPoint("RIGHT", bar, "RIGHT", SettingsDB.Scale(2), 0)
	
	-- Setup bar positions and look
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetAllPoints(bar)
	setpoint = bar.candyBarBar.SetPoint
	bar.candyBarBar.SetPoint = SettingsDB.dummy
	bar.candyBarBar:SetStatusBarTexture(SettingsCF.media.texture)
	if barcolor and not bar.data["bigwigs:emphasized"] == true then bar.candyBarBar:SetStatusBarColor(barcolor.r, barcolor.g, barcolor.b, 1) end
	bar.candyBarBackground:SetTexture(SettingsCF.media.texture)

	-- Setup icon positions and other things
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", SettingsDB.Scale(-buttonsize - buttonsize/3), 0)
	bar.candyBarIconFrame:SetSize(SettingsDB.Scale(buttonsize), SettingsDB.Scale(buttonsize))
	setwidth = bar.candyBarIconFrame.SetWidth
	bar.candyBarIconFrame.SetWidth = SettingsDB.dummy
	bar.candyBarIconFrame:SetTexCoord(0.1, 0.9, 0.1, 0.9)
end

local f = CreateFrame("Frame")

local function registerStyle()
	if not BigWigs then return end
	local bars = BigWigs:GetPlugin("Bars", true)
	local prox = BigWigs:GetPlugin("Proximity", true)
	if bars then
		bars:RegisterBarStyle("ShestakUI", {
			apiVersion = 1,
			version = 1,
			GetSpacing = function(bar) return SettingsDB.Scale(13) end,
			ApplyStyle = applystyle,
			BarStopped = freestyle,
			GetStyleName = function() return "ShestakUI" end,
		})
	end
	if prox and skinrange and BigWigs.pluginCore.modules.Bars.db.profile.barStyle == "ShestakUI" then
		hooksecurefunc(BigWigs.pluginCore.modules.Proximity, "RestyleWindow", function() SettingsDB.SkinFadedPanel(BigWigsProximityAnchor) end)
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, msg)
	if event == "ADDON_LOADED" then
		if msg == "BigWigs_Plugins" then
			--[[
			--	BigWigs uses single profile by default, so we should not upload class colors to shared profile. Leaving commented.
				BigWigs.pluginCore.modules.Bars.db.profile.barStyle="ShestakUI"
				BigWigs3DB.namespaces.BigWigs_Plugins_Colors.profiles.Default.barColor.BigWigs_Plugins_Colors.default={barcolor.r, barcolor.g, barcolor.b}
			]]--
			BigWigs.pluginCore.modules.Bars.db.profile.barStyle = "ShestakUI"
			registerStyle()
			f:UnregisterEvent("ADDON_LOADED")
		end
	end
end)

local pr = function(msg)
    print("|cffC495DDBigWigs|r:", tostring(msg))
end

SLASH_BWTEST1 = "/bwtest"
SlashCmdList.BWTEST = function(msg)
	if(msg=="apply") then
		SlashCmdList["BigWigs"]()
		StaticPopup_Show("BW_TEST")        
	elseif(msg=="test") then
		SlashCmdList["BigWigs"]()
		BigWigs.pluginCore.modules.Proximity.Test(BigWigs.pluginCore.modules.Proximity)
		HideUIPanel(InterfaceOptionsFrame)
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
	else
		pr("use |cffFF0000/bwtest apply|r to apply BigWigs settings.")
		pr("use |cffFF0000/bwtest test|r to launch BigWigs testmode.")
	end
end

StaticPopupDialogs["BW_TEST"] = {
	text = "We need to set some BigWigs options to apply Tukui BigWigs skin.\nMost of your settings will remain untouched.",
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function()
		BigWigs.pluginCore.modules.Bars.db.profile.barStyle = "ShestakUI"
		ReloadUI()
	end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = true,
}