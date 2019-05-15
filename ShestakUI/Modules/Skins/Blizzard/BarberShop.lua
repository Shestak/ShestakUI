local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BarbershopUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	BarberShopFrame:StripTextures()
	BarberShopFrame:CreateBackdrop("Transparent")
	BarberShopFrame.backdrop:SetPoint("TOPLEFT", 2, -2)
	BarberShopFrame.backdrop:SetPoint("BOTTOMRIGHT", -2, 35)

	BarberShopFrameMoneyFrame:StripTextures()
	BarberShopFrameMoneyFrame:CreateBackdrop("Overlay")
	BarberShopFrameMoneyFrame.backdrop:SetPoint("TOPLEFT", -3, 0)
	BarberShopFrameMoneyFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 3)

	BarberShopFrameOkayButton:SkinButton(true)
	BarberShopFrameCancelButton:SkinButton(true)
	BarberShopFrameResetButton:SkinButton(true)

	for i = 1, #BarberShopFrame.Selector do
		local prevBtn, nextBtn = BarberShopFrame.Selector[i]:GetChildren()
		T.SkinNextPrevButton(prevBtn, true)
		T.SkinNextPrevButton(nextBtn)
	end

	BarberShopBannerFrameBGTexture:Kill()
	BarberShopBannerFrame:Kill()

	BarberShopBannerFrameCaption:ClearAllPoints()
	BarberShopBannerFrameCaption:SetPoint("TOP", BarberShopFrame, 0, 0)
	BarberShopBannerFrameCaption:SetParent(BarberShopFrame)

	BarberShopAltFormFrameBorder:StripTextures()
	BarberShopAltFormFrame:SetPoint("BOTTOM", BarberShopFrame, "TOP", 0, 3)
	BarberShopAltFormFrame:StripTextures()
	BarberShopAltFormFrame:CreateBackdrop("Transparent")
end

T.SkinFuncs["Blizzard_BarbershopUI"] = LoadSkin