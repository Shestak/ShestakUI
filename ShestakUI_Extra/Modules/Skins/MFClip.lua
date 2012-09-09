local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.mfclip ~= true then return end

----------------------------------------------------------------------------------------
--	MFClip skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("MFClip") then return end

	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["fLBBorder"] = 2
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["bShowAnchor"] = false
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["fLBScale"] = 1
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["font"] = "Hooge"
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["fLBSpacing"] = 3
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["fLButtonsScale"] = 1
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["lbtexture"] = "Smooth"
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["lbbarcolor"] = {T.color.r, T.color.g, T.color.b, 1}
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["lbbarbgcolor"] = {T.color.r, T.color.g, T.color.b, 0.2}
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["lbbordercolor"] = {0, 0, 0, 0}
	MFClipDB["profiles"][T.name.." - "..GetRealmName()]["lblagcolor"] = {0.69, 0.14, 0.14, 0.75}

	for _, bar in ipairs({MFClip_Button_MF, MFClip_Button_MB, MFClip_Button_VT, MFClip_Button_DP,
		MFClip_Button_SWP, MFClip_Button_MS, MFClip_Button_SWD, MFClip_Button_SU}) do
		bar:SetTemplate("Default")
	end

	for _, bar in ipairs({MFClip_Bar_MF, MFClip_Bar_MB, MFClip_Bar_VT, MFClip_Bar_DP, MFClip_Bar_SWP, MFClip_Bar_SWD}) do
		bar:CreateBackdrop("Default")
		bar.backdrop:Point("TOPLEFT", bar, "TOPLEFT", 0, 0)
		bar.backdrop:Point("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 0, 0)
		bar.backdrop:SetFrameLevel(bar:GetFrameLevel() - 1)

		bar.trtext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		bar.trtext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		bar.brtext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		bar.brtext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		bar.tltext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		bar.tltext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		bar.bltext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		bar.bltext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		bar.ctext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		bar.ctext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		bar.rtext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		bar.rtext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	end

	MFClip.ResizeSingleBar = function(self)
		for _, bar in ipairs({MFClip_Bar_MF, MFClip_Bar_MB, MFClip_Bar_VT, MFClip_Bar_DP, MFClip_Bar_SWP, MFClip_Bar_SWD}) do
			bar.trtext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bar.trtext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			bar.brtext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bar.brtext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			bar.tltext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bar.tltext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			bar.bltext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bar.bltext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			bar.ctext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bar.ctext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			bar.rtext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bar.rtext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end
	end
	MFClip.ResizeLBBars = MFClip.ResizeSingleBar
end)