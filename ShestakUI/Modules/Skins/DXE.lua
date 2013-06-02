local T, C, L, _ = unpack(select(2, ...))
if C.skins.dxe ~= true or not IsAddOnLoaded("DXE") then return end

----------------------------------------------------------------------------------------
--	DXE skin
----------------------------------------------------------------------------------------
local movers = {
	"DXEAlertsTopStackAnchor",
	"DXEAlertsCenterStackAnchor",
	"DXEAlertsWarningStackAnchor",
	"DXEAlertsDebuffStackAnchor",
	"DXEAlertsMessageStackAnchor",
	"DXEAlertsInformStackAnchor",
	"DXEArrowsAnchor1",
	"DXEArrowsAnchor2",
	"DXEArrowsAnchor3",
}

local function SkinDXEBar(bar)
	-- Main bar
	bar:SetTemplate("Transparent")
	bar.bg:SetTexture(nil)
	bar.border:Kill()
	bar.statusbar:SetStatusBarTexture(C.media.texture)
	bar.statusbar:ClearAllPoints()
	bar.statusbar:SetPoint("TOPLEFT", 2, -2)
	bar.statusbar:SetPoint("BOTTOMRIGHT", -2, 2)

	-- Right Icon
	bar.righticon:SetTemplate("Default")
	bar.righticon.border:Kill()
	bar.righticon.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	bar.righticon.t:ClearAllPoints()
	bar.righticon.t:SetPoint("TOPLEFT", 2, -2)
	bar.righticon.t:SetPoint("BOTTOMRIGHT", -2, 2)
	bar.righticon.t:SetDrawLayer("ARTWORK")

	-- Left Icon
	bar.lefticon:SetTemplate("Default")
	bar.lefticon.border:Kill()
	bar.lefticon.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	bar.lefticon.t:ClearAllPoints()
	bar.lefticon.t:SetPoint("TOPLEFT", 2, -2)
	bar.lefticon.t:SetPoint("BOTTOMRIGHT", -2, 2)
	bar.lefticon.t:SetDrawLayer("ARTWORK")
end

-- Kill DXE's skinning
local DXE = DXE
DXE.NotifyBarTextureChanged = T.dummy
DXE.NotifyBorderChanged = T.dummy
DXE.NotifyFontChanged = T.dummy
DXE.NotifyBorderColorChanged = T.dummy
DXE.NotifyBorderEdgeSizeChanged = T.dummy
DXE.NotifyBackgroundTextureChanged = T.dummy
DXE.NotifyBackgroundInsetChanged = T.dummy
DXE.NotifyBackgroundColorChanged = T.dummy

-- Hook Window Creation
DXE.CreateWindow_ = DXE.CreateWindow
DXE.CreateWindow = function(self, name, width, height)
	local win = self:CreateWindow_(name, width, height)
	win:SetTemplate("Transparent")
	win.titletext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	win.titletext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	return win
end

-- Skin the pane
DXE.Pane:SetTemplate("Transparent")

-- Hook Health frames
DXE.LayoutHealthWatchers_ = DXE.LayoutHealthWatchers
DXE.LayoutHealthWatchers = function(self)
	self:LayoutHealthWatchers_()
	for i,hw in ipairs(self.HW) do
		if hw:IsShown() then
			hw:SetTemplate("Transparent")
			hw.border:Kill()
			hw.healthbar:SetStatusBarTexture(C.media.texture)
			hw.title:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			hw.title:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			hw.health:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			hw.health:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end
	end
end

DXE.Alerts.RefreshBars_ = DXE.Alerts.RefreshBars
DXE.Alerts.RefreshBars = function(self)
	if self.refreshing then return end
	self.refreshing = true
	self:RefreshBars_()
	local i = 1
	while _G["DXEAlertBar"..i] do
		local bar = _G["DXEAlertBar"..i]
		bar:SetScale(1)
		bar.SetScale = T.dummy
		bar.statusbar:SetStatusBarColor(T.color.r, T.color.g, T.color.b)
		bar.statusbar.SetStatusBarColor = T.dummy
		bar.text:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		bar.text:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		SkinDXEBar(bar)
		i = i + 1
	end
	self.refreshing = false
end

DXE.Alerts.Dropdown_ = DXE.Alerts.Dropdown
DXE.Alerts.Dropdown = function(self, ...)
	self:Dropdown_(...)
	self:RefreshBars()
end

DXE.Alerts.CenterPopup_ = DXE.Alerts.CenterPopup
DXE.Alerts.CenterPopup = function(self, ...)
	self:CenterPopup_(...)
	self:RefreshBars()
end

DXE.Alerts.Simple_ = DXE.Alerts.Simple
DXE.Alerts.Simple = function(self, ...)
	self:Simple_(...)
	self:RefreshBars()
end

DXE.Alerts.DebuffPopup_ = DXE.Alerts.DebuffPopup
DXE.Alerts.DebuffPopup = function(self, ...)
	self:DebuffPopup_(...)
	self:RefreshBars()
end

DXE.Alerts.Absorb_ = DXE.Alerts.Absorb
DXE.Alerts.Absorb = function(self, ...)
	self:Absorb_(...)
	self:RefreshBars()
end

-- Force some updates
DXE:LayoutHealthWatchers()
DXE.Alerts:RefreshBars()
DXE.Pane.border:Kill()

----------------------------------------------------------------------------------------
--	DXE settings
----------------------------------------------------------------------------------------
function T.UploadDXE()
	-- Force some default profile options
	if not DXEDB then DXEDB = {} end
	if not DXEDB["profiles"] then DXEDB["profiles"] = {} end
	if not DXEDB["profiles"][T.name.." - "..GetRealmName()] then DXEDB["profiles"][T.name.." - "..T.realm] = {} end
	if not DXEDB["profiles"][T.name.." - "..GetRealmName()]["Pane"] then DXEDB["profiles"][T.name.." - "..T.realm]["Pane"] = {} end
	if not DXEDB["profiles"][T.name.." - "..GetRealmName()]["Globals"] then DXEDB["profiles"][T.name.." - "..T.realm]["Globals"] = {} end
	if not DXEDB["profiles"][T.name.." - "..GetRealmName()]["Proximity"] then DXEDB["profiles"][T.name.." - "..T.realm]["Proximity"] = {} end
	if not DXEDB["profiles"][T.name.." - "..GetRealmName()]["PairProximity"] then DXEDB["profiles"][T.name.." - "..T.realm]["PairProximity"] = {} end
	if not DXEDB["profiles"][T.name.." - "..GetRealmName()]["AlternatePower"] then DXEDB["profiles"][T.name.." - "..T.realm]["AlternatePower"] = {} end
	if not DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..GetRealmName()] then DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm] = {} end

	DXEDB["profiles"][T.name.." - "..T.realm]["Globals"]["BackgroundTexture"] = "Smooth"
	DXEDB["profiles"][T.name.." - "..T.realm]["Globals"]["BarTexture"] = "Smooth"
	DXEDB["profiles"][T.name.." - "..T.realm]["Globals"]["Border"] = "None"
	DXEDB["profiles"][T.name.." - "..T.realm]["Globals"]["Font"] = "Hooge"
	DXEDB["profiles"][T.name.." - "..T.realm]["Globals"]["TimerFont"] = "Hooge"

	DXEDB["profiles"][T.name.." - "..T.realm]["Proximity"]["NameFontSize"] = C.font.stylization_font_size
	DXEDB["profiles"][T.name.." - "..T.realm]["Proximity"]["TimeFontSize"] = C.font.stylization_font_size

	DXEDB["profiles"][T.name.." - "..T.realm]["PairProximity"]["TimeFontSize"] = C.font.stylization_font_size
	DXEDB["profiles"][T.name.." - "..T.realm]["PairProximity"]["NameFontSize"] = C.font.stylization_font_size

	DXEDB["profiles"][T.name.." - "..T.realm]["AlternatePower"]["NameFontSize"] = C.font.stylization_font_size
	DXEDB["profiles"][T.name.." - "..T.realm]["AlternatePower"]["TimeFontSize"] = C.font.stylization_font_size

	DXEDB["profiles"][T.name.." - "..T.realm]["Pane"]["TitleFontSize"] = C.font.stylization_font_size
	DXEDB["profiles"][T.name.." - "..T.realm]["Pane"]["BarSpacing"] = 3
	DXEDB["profiles"][T.name.." - "..T.realm]["Pane"]["HealthFontSize"] = C.font.stylization_font_size
	DXEDB["profiles"][T.name.." - "..T.realm]["Pane"]["NeutralColor"] = {T.color.r, T.color.g, T.color.b}
	DXEDB["profiles"][T.name.." - "..T.realm]["Pane"]["LostColor"] = {T.color.r, T.color.g, T.color.b}

	DXEDB["profiles"][T.name.." - "..T.realm]["Positions"]["DXEAlertsTopStackAnchor"]["point"] = "BOTTOMLEFT"
	DXEDB["profiles"][T.name.." - "..T.realm]["Positions"]["DXEAlertsTopStackAnchor"]["relativePoint"] = "BOTTOMLEFT"
	DXEDB["profiles"][T.name.." - "..T.realm]["Positions"]["DXEAlertsTopStackAnchor"]["xOfs"] = 21
	if C.actionbar.bottombars == 1 then
		DXEDB["profiles"][T.name.." - "..T.realm]["Positions"]["DXEAlertsTopStackAnchor"]["yOfs"] = 157
	elseif C.actionbar.bottombars == 2 then
		DXEDB["profiles"][T.name.." - "..T.realm]["Positions"]["DXEAlertsTopStackAnchor"]["yOfs"] = 185
	elseif C.actionbar.bottombars == 3 then
		DXEDB["profiles"][T.name.." - "..T.realm]["Positions"]["DXEAlertsTopStackAnchor"]["yOfs"] = 213
	end

	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["WarningScale"] = 1
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopScale"] = 1
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["CenterScale"] = 1
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["BarFontSize"] = C.font.stylization_font_size
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TimerDecimalFontSize"] = C.font.stylization_font_size
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TimerSecondsFontSize"] = C.font.stylization_font_size * 2
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["ScaleTimerWithBarHeight"] = false
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["SetIconToBarHeight"] = false
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["IconSize"] = 25
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["IconXOffset"] = 3
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["IconYOffset"] = 3
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TimerXOffset"] = 5
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TextXOffset"] = 3
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["BarSpacing"] = 9
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["BarHeight"] = 19
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopBarWidth"] = 189
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["CenterBarWidth"] = 189
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["WarningBarWidth"] = 189
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopTextWidth"] = 130
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["CenterTextWidth"] = 130
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["WarningTextWidth"] = 180
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopGrowth"] = "UP"
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopAlpha"] = 1
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["CenterAlpha"] = 1
	DXEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["WarningAlpha"] = 1

	DXEIconDB["hide"] = true

	DXEDB["profiles"][T.name.." - "..T.realm]["Globals"]["InstalledBars"] = C.actionbar.bottombars
end

StaticPopupDialogs.SETTINGS_DXE = {
	text = L_POPUP_SETTINGS_DXE,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() T.UploadDXE() ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

-- Hook bar
local DXE_Skin = CreateFrame("Frame")
DXE_Skin:RegisterEvent("PLAYER_ENTERING_WORLD")
DXE_Skin:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent(event)
		self = nil

		-- DXE doesn't like the pane timer font to listen for some reason
		DXE.Pane.timer.left:SetFont(C.font.stylization_font, C.font.stylization_font_size * 2, C.font.stylization_font_style)
		DXE.Pane.timer.left:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		DXE.Pane.timer.right:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		DXE.Pane.timer.right:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		DXEArrow1.label:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		DXEArrow1.label:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		DXEArrow2.label:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		DXEArrow2.label:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		DXEArrow3.label:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		DXEArrow3.label:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		DXEArrow1.label2:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		DXEArrow1.label2:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		DXEArrow2.label2:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		DXEArrow2.label2:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		DXEArrow3.label2:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		DXEArrow3.label2:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

		for i = 1, #movers do
			if _G[movers[i]] then
				_G[movers[i]]:SetTemplate("Transparent")
			end
		end

		if DXEDB["profiles"][T.name.." - "..T.realm]["Globals"]["InstalledBars"] ~= C.actionbar.bottombars then
			StaticPopup_Show("SETTINGS_DXE")
		end
	end
end)