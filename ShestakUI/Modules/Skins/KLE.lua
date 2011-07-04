local T, C, L = unpack(select(2, ...))
if C.skins.kle ~= true or not IsAddOnLoaded("KLE") then return end

----------------------------------------------------------------------------------------
--	KLE skin
----------------------------------------------------------------------------------------
local KLE = KLE
local _G = getfenv(0)

local movers = {
	"KLEAlertsCenterStackAnchor",
	"KLEAlertsWarningStackAnchor",
	"KLEDistributorStackAnchor",
	"KLEAlertsTopStackAnchor",
	"KLEArrowsAnchorGrouping",
	"KLEArrowsAnchor1",
	"KLEArrowsAnchor2",
	"KLEArrowsAnchor3",
	"KLEArrowsAnchor4",
}

local function SkinKLEBar(bar)
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

-- Kill KLE's skinning
KLE.NotifyBarTextureChanged = T.dummy
KLE.NotifyBorderChanged = T.dummy
KLE.NotifyBorderColorChanged = T.dummy
KLE.NotifyBorderEdgeSizeChanged = T.dummy
KLE.NotifyBackgroundTextureChanged = T.dummy
KLE.NotifyBackgroundInsetChanged = T.dummy
KLE.NotifyBackgroundColorChanged = T.dummy

-- Hook Window Creation
KLE.CreateWindow_ = KLE.CreateWindow
KLE.CreateWindow = function(self, name, width, height)
	local win = self:CreateWindow_(name, width, height)
	win:SetTemplate("Transparent")
	return win
end

-- Skin the pane
KLE.Pane:SetTemplate("Transparent")

-- Hook Health frames
KLE.LayoutHealthWatchers_ = KLE.LayoutHealthWatchers
KLE.LayoutHealthWatchers = function(self)
	self:LayoutHealthWatchers_()
	for i,hw in ipairs(self.HW) do
		if hw:IsShown() then
			hw:SetTemplate("Transparent")
			hw.border:Kill()
			hw.healthbar:SetStatusBarTexture(C.media.texture)
		end
	end
end

KLE.Alerts.RefreshBars_ = KLE.Alerts.RefreshBars
KLE.Alerts.RefreshBars = function(self)
	if self.refreshing then return end
	self.refreshing = true
	self:RefreshBars_()
	local i = 1
	while _G["KLEAlertBar"..i] do
		local bar = _G["KLEAlertBar"..i]
		bar:SetScale(1)
		bar.SetScale = T.dummy
		SkinKLEBar(bar)
		i = i + 1
	end
	self.refreshing = false
end

KLE.Alerts.Dropdown_ = KLE.Alerts.Dropdown
KLE.Alerts.Dropdown = function(self, ...)
	self:Dropdown_(...)
	self:RefreshBars()
end

KLE.Alerts.CenterPopup_ = KLE.Alerts.CenterPopup
KLE.Alerts.CenterPopup = function(self, ...)
	self:CenterPopup_(...)
	self:RefreshBars()
end

KLE.Alerts.Simple_ = KLE.Alerts.Simple
KLE.Alerts.Simple = function(self, ...)
	self:Simple_(...)
	self:RefreshBars()
end

-- Force some updates
KLE:LayoutHealthWatchers()
KLE.Alerts:RefreshBars()
KLE.Pane.border:Kill()

----------------------------------------------------------------------------------------
--	KLE settings
----------------------------------------------------------------------------------------
function T.UploadDXE()
	-- Force some default profile options
	if not KLEDB then KLEDB = {} end
	if not KLEDB["profiles"] then KLEDB["profiles"] = {} end
	if not KLEDB["profiles"][T.name.." - "..GetRealmName()] then KLEDB["profiles"][T.name.." - "..T.realm] = {} end
	if not KLEDB["profiles"][T.name.." - "..GetRealmName()]["Pane"] then KLEDB["profiles"][T.name.." - "..T.realm]["Pane"] = {} end
	if not KLEDB["profiles"][T.name.." - "..GetRealmName()]["Globals"] then KLEDB["profiles"][T.name.." - "..T.realm]["Globals"] = {} end
	if not KLEDB["profiles"][T.name.." - "..GetRealmName()]["Proximity"] then KLEDB["profiles"][T.name.." - "..T.realm]["Proximity"] = {} end
	if not KLEDB["profiles"][T.name.." - "..GetRealmName()]["PairProximity"] then KLEDB["profiles"][T.name.." - "..T.realm]["PairProximity"] = {} end
	if not KLEDB["profiles"][T.name.." - "..GetRealmName()]["AlternatePower"] then KLEDB["profiles"][T.name.." - "..T.realm]["AlternatePower"] = {} end
	if not KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..GetRealmName()] then KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm] = {} end

	KLEDB["profiles"][T.name.." - "..T.realm]["Globals"]["BackgroundTexture"] = "Smooth"
	KLEDB["profiles"][T.name.." - "..T.realm]["Globals"]["BarTexture"] = "Smooth"
	KLEDB["profiles"][T.name.." - "..T.realm]["Globals"]["Border"] = "None"
	KLEDB["profiles"][T.name.." - "..T.realm]["Globals"]["Font"] = "Hooge"
	KLEDB["profiles"][T.name.." - "..T.realm]["Globals"]["TimerFont"] = "Hooge"

	KLEDB["profiles"][T.name.." - "..T.realm]["Proximity"]["NameFontSize"] = C.font.stylization_font_size
	KLEDB["profiles"][T.name.." - "..T.realm]["Proximity"]["TimeFontSize"] = C.font.stylization_font_size

	KLEDB["profiles"][T.name.." - "..T.realm]["PairProximity"]["TimeFontSize"] = C.font.stylization_font_size
	KLEDB["profiles"][T.name.." - "..T.realm]["PairProximity"]["NameFontSize"] = C.font.stylization_font_size

	KLEDB["profiles"][T.name.." - "..T.realm]["AlternatePower"]["NameFontSize"] = C.font.stylization_font_size
	KLEDB["profiles"][T.name.." - "..T.realm]["AlternatePower"]["TimeFontSize"] = C.font.stylization_font_size

	KLEDB["profiles"][T.name.." - "..T.realm]["Pane"]["TitleFontSize"] = C.font.stylization_font_size
	KLEDB["profiles"][T.name.." - "..T.realm]["Pane"]["BarSpacing"] = 3
	KLEDB["profiles"][T.name.." - "..T.realm]["Pane"]["HealthFontSize"] = C.font.stylization_font_size

	KLEDB["profiles"][T.name.." - "..T.realm]["Positions"]["KLEAlertsTopStackAnchor"]["point"] = "BOTTOMLEFT"
	KLEDB["profiles"][T.name.." - "..T.realm]["Positions"]["KLEAlertsTopStackAnchor"]["relativePoint"] = "BOTTOMLEFT"
	KLEDB["profiles"][T.name.." - "..T.realm]["Positions"]["KLEAlertsTopStackAnchor"]["xOfs"] = 21
	if C.actionbar.bottombars == 1 then
		KLEDB["profiles"][T.name.." - "..T.realm]["Positions"]["KLEAlertsTopStackAnchor"]["yOfs"] = 157
	elseif C.actionbar.bottombars == 2 then
		KLEDB["profiles"][T.name.." - "..T.realm]["Positions"]["KLEAlertsTopStackAnchor"]["yOfs"] = 185
	elseif C.actionbar.bottombars == 3 then
		KLEDB["profiles"][T.name.." - "..T.realm]["Positions"]["KLEAlertsTopStackAnchor"]["yOfs"] = 213
	end

	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["WarningScale"] = 1
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopScale"] = 1
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["CenterScale"] = 1
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["BarFontSize"] = C.font.stylization_font_size
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TimerDecimalFontSize"] = C.font.stylization_font_size
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TimerSecondsFontSize"] = C.font.stylization_font_size * 2
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["ScaleTimerWithBarHeight"] = false
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["SetIconToBarHeight"] = false
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["IconSize"] = 25
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["IconXOffset"] = 3
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["IconYOffset"] = 3
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TimerXOffset"] = 5
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["BarSpacing"] = 9
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["BarHeight"] = 19
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopBarWidth"] = 189
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["CenterBarWidth"] = 189
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["WarningBarWidth"] = 189
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopTextWidth"] = 130
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["CenterTextWidth"] = 130
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["WarningTextWidth"] = 180
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopGrowth"] = "UP"
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["TopAlpha"] = 1
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["CenterAlpha"] = 1
	KLEDB["namespaces"]["Alerts"]["profiles"][T.name.." - "..T.realm]["WarningAlpha"] = 1

	KLEIconDB["hide"] = true

	KLEDB["profiles"][T.name.." - "..T.realm]["Globals"]["InstalledBars"] = C.actionbar.bottombars
end

StaticPopupDialogs["SETTINGS_KLE"] = {
	text = L_POPUP_SETTINGS_KLE,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() T.UploadKLE() ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
}

-- Hook bar
local KLE_Skin = CreateFrame("Frame")
KLE_Skin:RegisterEvent("PLAYER_ENTERING_WORLD")
KLE_Skin:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent(event)
		self = nil

		-- KLE doesn't like the pane timer font to listen for some reason
		KLE.Pane.timer.left:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		KLE.Pane.timer.left:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		KLE.Pane.timer.right:SetFont(C.font.stylization_font, C.font.stylization_font_size * 1.8, C.font.stylization_font_style)
		KLE.Pane.timer.right:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

		for i = 1, #movers do
			if _G[movers[i]] then
				_G[movers[i]]:SetTemplate("Transparent")
			end
		end

		if KLEDB["profiles"][T.name.." - "..T.realm]["Globals"]["InstalledBars"] ~= C.actionbar.bottombars then
			StaticPopup_Show("SETTINGS_KLE")
		end
	end
end)