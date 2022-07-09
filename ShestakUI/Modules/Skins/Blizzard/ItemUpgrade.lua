local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemUpgrade skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = ItemUpgradeFrame
	T.SkinCloseButton(frame.CloseButton)

	frame:StripTextures()
	frame:SetTemplate("Transparent")

	frame.UpgradeItemButton:StripTextures()
	frame.UpgradeItemButton:SetTemplate("Default")
	frame.UpgradeItemButton:StyleButton()
	frame.UpgradeItemButton:GetNormalTexture():SetInside()
	frame.UpgradeItemButton.IconBorder:SetAlpha(0)
	frame.UpgradeItemButton.icon:SetInside()
	frame.UpgradeItemButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	T.SkinDropDownBox(frame.ItemInfo.Dropdown)

	frame.UpgradeButton:SkinButton(true)

	frame.UpgradeCostFrame.BGTex:Hide()

	ItemUpgradeFrameLeftItemPreviewFrame.NineSlice:SetTemplate("Overlay")
	ItemUpgradeFrameRightItemPreviewFrame.NineSlice:SetTemplate("Overlay")

	ItemUpgradeFramePlayerCurrenciesBorder:StripTextures()

	local function reskinCurrencyIcon(self)
		for frame in self.iconPool:EnumerateActive() do
			if not frame.Icon.styled then
				frame.Icon:SkinIcon(true)
				frame.Icon.styled = true
			end
		end
	end

	hooksecurefunc(frame.UpgradeCostFrame, "GetIconFrame", reskinCurrencyIcon)
	hooksecurefunc(frame.PlayerCurrencies, "GetIconFrame", reskinCurrencyIcon)
end

T.SkinFuncs["Blizzard_ItemUpgradeUI"] = LoadSkin