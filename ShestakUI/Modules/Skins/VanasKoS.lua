local T, C, L, _ = unpack(select(2, ...))
if C.skins.vanaskos ~= true then return end

----------------------------------------------------------------------------------------
--	VanasKoS skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("VanasKoS") then return end

	table.insert(UISpecialFrames, "VanasKoSFrame")

	VanasKoS_WarnFrame:SetTemplate("Transparent")
	VanasKoS_WarnFrame.SetBackdropBorderColor = T.dummy

	VanasKoS_FontKos:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	VanasKoS_FontEnemy:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	VanasKoS_FontFriendly:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	VanasKoS_FontNormal:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)

	VanasKoSFrame:StripTextures(true)
	VanasKoSFrame:CreateBackdrop("Transparent")
	VanasKoSFrame.backdrop:SetPoint("TOPLEFT", 16, -12)
	VanasKoSFrame.backdrop:SetPoint("BOTTOMRIGHT", -30, 75)

	VanasKoSListFrameChangeButton:SkinButton()
	VanasKoSListFrameRemoveButton:SkinButton()
	VanasKoSListFrameAddButton:SkinButton()
	VanasKoSListFrameConfigurationButton:SkinButton()

	T.SkinCloseButton(VanasKosFrameCloseButton, VanasKoSFrame.backdrop)
	T.SkinCheckBox(VanasKoSListFrameCheckBox)
	T.SkinNextPrevButton(VanasKoSListFrameToggleRightButton)
	T.SkinNextPrevButton(VanasKoSListFrameToggleLeftButton)
	T.SkinDropDownBox(VanasKoSPvPStatsCharacterDropDown, 90)
	T.SkinDropDownBox(VanasKoSPvPStatsTimeSpanDropDown, 90)
	T.SkinDropDownBox(VanasKoSFrameChooseListDropDown)
	T.SkinEditBox(VanasKoSListFrameSearchBox, nil, 18)

	for i = 1, 2 do
		T.SkinTab(_G["VanasKoSFrameTab"..i])
	end

	for i = 1, 5 do
		_G["VanasKoSListFrameColButton"..i]:StripTextures()
	end

	VanasKoSPvPStatsCharacterDropDown:ClearAllPoints()
	VanasKoSPvPStatsCharacterDropDown:SetPoint("RIGHT", VanasKoSListFrameToggleLeftButton, "LEFT", -7, 0)
	VanasKoSPvPStatsTimeSpanDropDown:ClearAllPoints()
	VanasKoSPvPStatsTimeSpanDropDown:SetPoint("RIGHT", VanasKoSPvPStatsCharacterDropDown, "LEFT", 10, 0)
	VanasKoSListFrameAddButton:ClearAllPoints()
	VanasKoSListFrameAddButton:SetPoint("BOTTOMRIGHT", VanasKoSFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	VanasKoSListFrameRemoveButton:ClearAllPoints()
	VanasKoSListFrameRemoveButton:SetPoint("RIGHT", VanasKoSListFrameAddButton, "LEFT", -3, 0)
	VanasKoSListFrameChangeButton:ClearAllPoints()
	VanasKoSListFrameChangeButton:SetPoint("RIGHT", VanasKoSListFrameRemoveButton, "LEFT", -3, 0)
	VanasKoSListFrameConfigurationButton:ClearAllPoints()
	VanasKoSListFrameConfigurationButton:SetPoint("BOTTOMRIGHT", VanasKoSListFrameAddButton, "TOPRIGHT", 0, 3)
	VanasKoSListFrameSearchBox:ClearAllPoints()
	VanasKoSListFrameSearchBox:SetPoint("RIGHT", VanasKoSListFrameConfigurationButton, "LEFT", -5, 0)
end)