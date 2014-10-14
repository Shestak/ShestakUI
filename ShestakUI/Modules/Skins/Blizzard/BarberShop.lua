local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BarbershopUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"BarberShopFrameOkayButton",
		"BarberShopFrameCancelButton",
		"BarberShopFrameResetButton"
	}
	BarberShopFrameOkayButton:SetPoint("RIGHT", BarberShopFrameSelector4, "BOTTOM", 2, -50)

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton(true)
	end

	for i = 1, 5 do
		local f = _G["BarberShopFrameSelector"..i]
		local f2 = _G["BarberShopFrameSelector"..i-1]
		T.SkinNextPrevButton(_G["BarberShopFrameSelector"..i.."Prev"])
		T.SkinNextPrevButton(_G["BarberShopFrameSelector"..i.."Next"])

		if i ~= 1 or i ~= 4 then
			f:ClearAllPoints()
			f:SetPoint("TOP", f2, "BOTTOM", 0, -3)
		end
	end

	BarberShopFrameSelector1:ClearAllPoints()
	BarberShopFrameSelector1:SetPoint("TOP", 0, -12)

	BarberShopFrameResetButton:ClearAllPoints()
	BarberShopFrameResetButton:SetPoint("BOTTOM", 0, 12)

	BarberShopFrame:StripTextures()
	BarberShopFrame:SetTemplate("Transparent")
	BarberShopFrame:SetSize(BarberShopFrame:GetWidth() - 30, BarberShopFrame:GetHeight() - 56)

	BarberShopFrameMoneyFrame:StripTextures()
	BarberShopFrameMoneyFrame:CreateBackdrop("Overlay")
	BarberShopFrameMoneyFrame:ClearAllPoints()
	BarberShopFrameMoneyFrame:SetPoint("BOTTOM", 0, 50)

	BarberShopBannerFrameBGTexture:Kill()
	BarberShopBannerFrame:Kill()

	BarberShopAltFormFrameBorder:StripTextures()
	BarberShopAltFormFrame:SetPoint("BOTTOM", BarberShopFrame, "TOP", 0, 5)
	BarberShopAltFormFrame:StripTextures()
	BarberShopAltFormFrame:CreateBackdrop("Transparent")
end

T.SkinFuncs["Blizzard_BarbershopUI"] = LoadSkin