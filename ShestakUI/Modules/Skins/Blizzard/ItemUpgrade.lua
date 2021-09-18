local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemUpgrade skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemUpgradeFrame:StripTextures()
	ItemUpgradeFrame:SetTemplate("Transparent")

	if T.newPatch then
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
	else
		ItemUpgradeFrameMoneyFrame:StripTextures()

		ItemUpgradeFrame.ButtonFrame:StripTextures()
		ItemUpgradeFrame.TextFrame:StripTextures()

		ItemUpgradeFrameUpgradeButton:ClearAllPoints()
		ItemUpgradeFrameUpgradeButton:SetPoint("BOTTOMRIGHT", ItemUpgradeFrame, "BOTTOMRIGHT", -3, 3)
		ItemUpgradeFrameUpgradeButton:SkinButton(true)

		ItemUpgradeFrame.ItemButton:StripTextures()
		ItemUpgradeFrame.ItemButton:SetTemplate("Default")
		ItemUpgradeFrame.ItemButton:StyleButton()
		ItemUpgradeFrame.ItemButton.IconTexture:ClearAllPoints()
		ItemUpgradeFrame.ItemButton.IconTexture:SetPoint("TOPLEFT", 2, -2)
		ItemUpgradeFrame.ItemButton.IconTexture:SetPoint("BOTTOMRIGHT", -2, 2)

		hooksecurefunc("ItemUpgradeFrame_Update", function()
			if GetItemUpgradeItemInfo() then
				ItemUpgradeFrame.ItemButton.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			else
				ItemUpgradeFrame.ItemButton.IconTexture:SetTexture(nil)
			end
		end)

		ItemUpgradeFrame.FinishedGlow:Kill()
	end

	T.SkinCloseButton(ItemUpgradeFrameCloseButton)
end

T.SkinFuncs["Blizzard_ItemUpgradeUI"] = LoadSkin