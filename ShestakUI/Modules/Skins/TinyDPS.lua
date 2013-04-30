local T, C, L, _ = unpack(select(2, ...))
if C.skins.tiny_dps ~= true then return end
if not Minimap then return end

----------------------------------------------------------------------------------------
--	TinyDPS skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("TinyDPS") then return end

	tdpsAnchor:ClearAllPoints()
	tdpsAnchor:SetPoint('BOTTOMLEFT', Minimap, 'BOTTOMLEFT', -2, -30)
	tdpsFrame:SetWidth(Minimap:GetWidth() + 4)
	tdpsPosition = {x = 0, y = 0}
	tdps.width = (Minimap:GetWidth() + 4)
	tdps.barHeight = 12
	tdps.spacing = 3
	tdps.border = {0, 0, 0, 0}
	tdps.backdrop = {0, 0, 0, 0}
	tdps.barbackdrop = {0, 0, 0, 0}
	tdps.swapColor = true
	tdps.showMinimapRaidBuffsReminder = false
	tdps.layout = 11
	tdpsVisibleBars = 5
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

-- Edit by Oz of shestakdotorg --
