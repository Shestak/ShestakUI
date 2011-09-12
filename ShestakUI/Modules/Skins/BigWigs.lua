local T, C, L = unpack(select(2, ...))
if not C.skins.bigwigs == true then return end

----------------------------------------------------------------------------------------
--	BigWigs skin(by Affli)
----------------------------------------------------------------------------------------
local classcolor = true			-- Classcolored bars
local skinrange = true			-- Skin distance window
local disablescaling = true		-- Disables bar scaling (including emphasized bars)

local barcolor = classcolor and RAID_CLASS_COLORS[T.class]
local buttonsize = 21

-- Init some tables to store backgrounds
local freebg = {}

-- Styling functions
local createbg = function()
	local bg = CreateFrame("Frame")
	bg:SetTemplate("Default")
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
		freebg[#freebg + 1] = ibg
	end

	-- Replace dummies with original method functions
	bar.candyBarBar.SetPoint = bar.candyBarBar.OldSetPoint
	bar.candyBarIconFrame.SetWidth = bar.candyBarIconFrame.OldSetWidth
	if disablescaling then 
		bar.SetScale = bar.OldSetScale
	end
end

local applystyle = function(bar)
	-- General bar settings
	bar:Height(15)
	if disablescaling then
		bar:SetScale(1)
		bar.OldSetScale = bar.SetScale
		bar.SetScale = T.dummy
	end

	-- Create or reparent and use bar background
	local bg = nil
	if #freebg > 0 then
		bg = table.remove(freebg)
	else
		bg = createbg()
	end
	bg:SetParent(bar)
	bg:ClearAllPoints()
	bg:Point("TOPLEFT", bar, "TOPLEFT", -2, 2)
	bg:Point("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
	bg:SetFrameStrata("BACKGROUND")
	bg:Show()
	bar:Set("bigwigs:shestakui:bg", bg)

	-- Create or reparent and use icon background
	local ibg = nil
	if bar.candyBarIconFrame:GetTexture() then
		if #freebg > 0 then
			ibg = table.remove(freebg)
		else
			ibg = createbg()
		end
		ibg:SetParent(bar)
		ibg:ClearAllPoints()
		ibg:Point("TOPLEFT", bar.candyBarIconFrame, "TOPLEFT", -2, 2)
		ibg:Point("BOTTOMRIGHT", bar.candyBarIconFrame, "BOTTOMRIGHT", 2, -2)
		ibg:SetFrameStrata("BACKGROUND")
		ibg:Show()
		bar:Set("bigwigs:shestakui:bg", ibg)
	end

	-- Setup timer and bar name fonts and positions
	bar.candyBarLabel:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	bar.candyBarLabel:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	bar.candyBarLabel:SetJustifyH("LEFT")
	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:Point("LEFT", bar, "LEFT", 2, 0)

	bar.candyBarDuration:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	bar.candyBarDuration:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	bar.candyBarDuration:SetJustifyH("RIGHT")
	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:Point("RIGHT", bar, "RIGHT", 1, 0)

	-- Setup bar positions and look
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetAllPoints(bar)
	bar.candyBarBar.OldSetPoint = bar.candyBarBar.SetPoint
	bar.candyBarBar.SetPoint = T.dummy
	bar.candyBarBar:SetStatusBarTexture(C.media.texture)
	if barcolor and not bar.data["bigwigs:emphasized"] == true then bar.candyBarBar:SetStatusBarColor(barcolor.r, barcolor.g, barcolor.b, 1) end
	bar.candyBarBackground:SetTexture(C.media.texture)

	-- Setup icon positions and other things
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:Point("BOTTOMLEFT", bar, "BOTTOMLEFT", -buttonsize - buttonsize/3, 0)
	bar.candyBarIconFrame:Size(buttonsize)
	bar.candyBarIconFrame.OldSetWidth = bar.candyBarIconFrame.SetWidth
	bar.candyBarIconFrame.SetWidth = T.dummy
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
			GetSpacing = function(bar) return T.Scale(13) end,
			ApplyStyle = applystyle,
			BarStopped = freestyle,
			GetStyleName = function() return "ShestakUI" end,
		})
	end
	if prox and skinrange and BigWigs.pluginCore.modules.Bars.db.profile.barStyle == "ShestakUI" then
		hooksecurefunc(BigWigs.pluginCore.modules.Proximity, "RestyleWindow", function()
			BigWigsProximityAnchor:SetTemplate("Transparent")
		end)
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, msg)
	if event == "ADDON_LOADED" then
		if msg == "BigWigs_Plugins" then
			if BigWigs3DB.namespaces.BigWigs_Plugins_Bars.profiles.Default.InstalledBars ~= C.actionbar.bottombars then
				StaticPopup_Show("BW_TEST")
			end
			BigWigs.pluginCore.modules.Bars.db.profile.barStyle = "ShestakUI"
			registerStyle()
			f:UnregisterEvent("ADDON_LOADED")
		end
	end
end)

local pr = function(msg)
	print(tostring(msg))
end

SLASH_BWTEST1 = "/bwtest"
SlashCmdList.BWTEST = function(msg)
	if(msg=="apply") then
		SlashCmdList["BigWigs"]()
		HideUIPanel(InterfaceOptionsFrame)
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
		pr("|cffffff00Type /bwtest apply to apply BigWigs settings.|r")
		pr("|cffffff00Type /bwtest test to launch BigWigs testmode.|r")
	end
end

StaticPopupDialogs["BW_TEST"] = {
	text = L_POPUP_SETTINGS_BW,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function()
		BigWigs.pluginCore.modules.Bars.db.profile.barStyle = "ShestakUI"
		BigWigs.pluginCore.modules.Bars.db.profile.font = C.font.stylization_font
		BigWigs.pluginCore.modules.Messages.db.profile.font = C.media.normal_font
		BigWigs.pluginCore.modules.Messages.db.profile.outline = "OUTLINE"
		BigWigs.pluginCore.modules.Proximity.db.profile.font = C.media.normal_font
		BigWigs.pluginCore.modules.Bars.db.profile.BigWigsAnchor_width = 185
		BigWigs.pluginCore.modules.Bars.db.profile.BigWigsAnchor_x = 49
		BigWigs.pluginCore.modules.Bars.db.profile.BigWigsEmphasizeAnchor_width = 185
		BigWigs.pluginCore.modules.Bars.db.profile.BigWigsEmphasizeAnchor_x = 541
		BigWigs.pluginCore.modules.Bars.db.profile.BigWigsEmphasizeAnchor_y = 493
		BigWigs.pluginCore.modules.Messages.db.profile.fontSize = 30
		BigWigs3IconDB.hide = true
		if C.actionbar.bottombars == 1 then
			BigWigs.pluginCore.modules.Bars.db.profile.BigWigsAnchor_y = 150
		elseif C.actionbar.bottombars == 2 then
			BigWigs.pluginCore.modules.Bars.db.profile.BigWigsAnchor_y = 177
		elseif C.actionbar.bottombars == 3 then
			BigWigs.pluginCore.modules.Bars.db.profile.BigWigsAnchor_y = 203
		end
		BigWigs.pluginCore.modules.Bars.db.profile.InstalledBars = C.actionbar.bottombars
		if InCombatLockdown() then
			pr("|cffffff00"..ERR_NOT_IN_COMBAT.."|r")
			pr("|cffffff00Reload your UI to apply skin.|r")
		else
			ReloadUI()
		end
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 3,
}