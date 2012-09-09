local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.vanaskos ~= true then return end

----------------------------------------------------------------------------------------
--	VanasKoS skin(Not Ready)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
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
	VanasKoSFrame.backdrop:Point("TOPLEFT", 16, -12)
	VanasKoSFrame.backdrop:Point("BOTTOMRIGHT", -30, 75)

	VanasKoSListFrameChangeButton:SkinButton()
	VanasKoSListFrameRemoveButton:SkinButton()
	VanasKoSListFrameAddButton:SkinButton()
	VanasKoSListFrameConfigurationButton:SkinButton()

	T.SkinCloseButton(VanasKosFrameCloseButton, VanasKoSFrame.backdrop)
	T.SkinCheckBox(VanasKoSListFrameCheckBox)
	T.SkinNextPrevButton(VanasKoSListFrameToggleRightButton)
	T.SkinNextPrevButton(VanasKoSListFrameToggleLeftButton)

	for i = 1, 2 do
		T.SkinTab(_G["VanasKoSFrameTab"..i])
	end
end)