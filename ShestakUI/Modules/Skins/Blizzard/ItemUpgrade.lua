local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemUpgrade skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemUpgradeFrame:StripTextures()
	ItemUpgradeFrame:SetTemplate("Transparent")

	ItemUpgradeFrame.UpgradeItemButton:StripTextures()
	ItemUpgradeFrame.UpgradeItemButton:SetTemplate("Default")
	ItemUpgradeFrame.UpgradeItemButton:StyleButton()
	ItemUpgradeFrame.UpgradeItemButton:GetNormalTexture():SetInside()
	ItemUpgradeFrame.UpgradeItemButton.IconBorder:SetAlpha(0)
	ItemUpgradeFrame.UpgradeItemButton.icon:SetInside()
	ItemUpgradeFrame.UpgradeItemButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	T.SkinDropDownBox(ItemUpgradeFrame.ItemInfo.Dropdown)

	ItemUpgradeFrame.UpgradeButton:SkinButton(true)

	ItemUpgradeFrameLeftItemPreviewFrame.NineSlice:SetTemplate("Default")
	ItemUpgradeFrameRightItemPreviewFrame.NineSlice:SetTemplate("Default")

	ItemUpgradeFramePlayerCurrenciesBorder:StripTextures()

	T.SkinCloseButton(ItemUpgradeFrameCloseButton)
end

T.SkinFuncs["Blizzard_ItemUpgradeUI"] = LoadSkin