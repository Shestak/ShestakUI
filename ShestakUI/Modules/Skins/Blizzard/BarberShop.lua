local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BarbershopUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		BarberShopFrame.AcceptButton,
		BarberShopFrame.CancelButton,
		BarberShopFrame.ResetButton
	}

	for i = 1, #buttons do
		local button = buttons[i]
		button:SkinButton(true)
		button:SetScale(UIParent:GetScale())
	end

	local smallButtons = {
		CharCustomizeFrame.SmallButtons.ResetCameraButton,
		CharCustomizeFrame.SmallButtons.ZoomOutButton,
		CharCustomizeFrame.SmallButtons.ZoomInButton,
		CharCustomizeFrame.SmallButtons.RotateLeftButton,
		CharCustomizeFrame.SmallButtons.RotateRightButton,
	}

	for i = 1, #smallButtons do
		local button = smallButtons[i]
		button:SetNormalTexture(0)
		button:SetPushedTexture(0)
		button:SetHighlightTexture(0)
	end
end

T.SkinFuncs["Blizzard_BarbershopUI"] = LoadSkin