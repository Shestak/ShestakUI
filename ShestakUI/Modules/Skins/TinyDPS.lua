local T, C, L, _ = unpack(select(2, ...))

if not Minimap then return end

----------------------------------------------------------------------------------------
--	TinyDPS skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("TinyDPS") then return end

	tdpsFrame:SetWidth(Minimap:GetWidth() + 4)
	tdpsPosition = {x = 0, y = 0}
	tdps.width = (Minimap:GetWidth() + 4)
	tdpsAnchor:ClearAllPoints()
	if C.skins.tiny_dps == true then
		tdpsAnchor:SetPoint('BOTTOMLEFT', Minimap, 'BOTTOMLEFT', -2, -30)
		tdps.barHeight = 12
		tdpsVisibleBars = 5
	elseif C.skins.tiny_dps_layout_two == true then
		tdpsAnchor:SetPoint('RIGHT', Minimap, 'LEFT', -136, 42)
		tdps.barHeight = 16
		tdpsVisibleBars = 7
	end

	tdps.spacing = 3
	tdps.border = {0, 0, 0, 0}
	tdps.backdrop = {0, 0, 0, 0}
	tdps.barbackdrop = {0, 0, 0, 0}
	tdps.swapColor = true
	tdps.showMinimapRaidBuffsReminder = false
	tdps.layout = 11
	tdpsFont.name = C.font.stylization_font
	tdpsFont.size = C.font.stylization_font_size
	tdpsFont.outline = C.font.stylization_font_style
	tdpsFont.shadow = C.font.stylization_font_shadow and 1 or 0
	tdpsTextOffset = 0

	tdpsFrame:SetTemplate("Transparent")
	noData:SetTextColor(1, 1, 1, 1)

	if tdpsStatusBar then
		tdpsStatusBar:SetStatusBarTexture(C.media.texture)
	end
end)

if C.skins.tiny_dps_layout_two == true then
	local title = CreateFrame("Frame", "TinyDPSTitle", UIParent)
	title:CreatePanel("Transparent", Minimap:GetWidth() + 4, 20, "BOTTOMLEFT", Minimap, "BOTTOMLEFT", -139, 112)
	title:SetFrameLevel(Minimap:GetFrameLevel())
	title:FontString("Text", C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style, C.font.stylization_font_shadow)
	title.Text:SetPoint("CENTER")
	title.Text:SetText("DPS")
end

-- Edit by Oz of shestakdotorg --
