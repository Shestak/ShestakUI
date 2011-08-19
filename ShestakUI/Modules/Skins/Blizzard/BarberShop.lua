local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BarbershopUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"BarberShopFrameOkayButton",
		"BarberShopFrameCancelButton",
		"BarberShopFrameResetButton",
	}
	BarberShopFrameOkayButton:Point("RIGHT", BarberShopFrameSelector4, "BOTTOM", 2, -50)

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end

	for i = 1, 4 do
		local f = _G["BarberShopFrameSelector"..i]
		local f2 = _G["BarberShopFrameSelector"..i-1]
		T.SkinNextPrevButton(_G["BarberShopFrameSelector"..i.."Prev"])
		T.SkinNextPrevButton(_G["BarberShopFrameSelector"..i.."Next"])

		if i ~= 1 then
			f:ClearAllPoints()
			f:Point("TOP", f2, "BOTTOM", 0, -3)
		end

		if f then
			f:StripTextures()
		end
	end

	BarberShopFrameSelector1:ClearAllPoints()
	BarberShopFrameSelector1:Point("TOP", 0, -12)

	BarberShopFrameResetButton:ClearAllPoints()
	BarberShopFrameResetButton:Point("BOTTOM", 0, 12)

	BarberShopFrame:StripTextures()
	BarberShopFrame:SetTemplate("Transparent")
	BarberShopFrame:Size(BarberShopFrame:GetWidth() - 30, BarberShopFrame:GetHeight() - 56)

	BarberShopFrameMoneyFrame:StripTextures()
	BarberShopFrameMoneyFrame:CreateBackdrop()
	BarberShopFrameBackground:Kill()

	BarberShopBannerFrameBGTexture:Kill()
	BarberShopBannerFrame:Kill()

	BarberShopAltFormFrameBorder:StripTextures()
	BarberShopAltFormFrame:Point("BOTTOM", BarberShopFrame, "TOP", 0, 5)
	BarberShopAltFormFrame:StripTextures()
	BarberShopAltFormFrame:CreateBackdrop("Transparent")
end

T.SkinFuncs["Blizzard_BarbershopUI"] = LoadSkin