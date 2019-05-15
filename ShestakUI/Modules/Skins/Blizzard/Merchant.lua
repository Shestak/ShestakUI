local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Merchant skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- Main frames
	MerchantFrame:StripTextures(true)
	MerchantFrame:CreateBackdrop("Transparent")
	MerchantFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	MerchantFrame.backdrop:SetPoint("BOTTOMRIGHT", 2, 0)

	MerchantFrameInset:StripTextures()
	MerchantMoneyBg:StripTextures()
	MerchantMoneyInset:StripTextures()
	MerchantExtraCurrencyBg:StripTextures()
	MerchantExtraCurrencyInset:StripTextures()

	-- Skin tabs
	for i = 1, 2 do
		T.SkinTab(_G["MerchantFrameTab"..i])
	end

	-- Icons/merchant slots
	for i = 1, BUYBACK_ITEMS_PER_PAGE do
		local b = _G["MerchantItem"..i.."ItemButton"]
		local t = _G["MerchantItem"..i.."ItemButtonIconTexture"]
		local item_bar = _G["MerchantItem"..i]
		local c = _G["MerchantItem"..i.."AltCurrencyFrameItem1"]
		local ct = _G["MerchantItem"..i.."AltCurrencyFrameItem1Texture"]

		item_bar:StripTextures(true)
		item_bar:CreateBackdrop("Overlay")

		b:StripTextures()
		b:StyleButton()
		b:SetTemplate("Default")
		b:SetPoint("TOPLEFT", item_bar, "TOPLEFT", 4, -4)

		b.IconBorder:SetAlpha(0)

		t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", 2, -2)
		t:SetPoint("BOTTOMRIGHT", -2, 2)

		c:SetPoint("LEFT", _G["MerchantItem"..i.."AltCurrencyFrame"], "LEFT", 13, 5)
		c:CreateBackdrop("Default")
		c.backdrop:SetPoint("TOPLEFT", ct, "TOPLEFT", -2, 2)
		c.backdrop:SetPoint("BOTTOMRIGHT", ct, "BOTTOMRIGHT", 2, -2)
		ct:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		_G["MerchantItem"..i.."MoneyFrame"]:ClearAllPoints()
		_G["MerchantItem"..i.."MoneyFrame"]:SetPoint("BOTTOMLEFT", b, "BOTTOMRIGHT", 3, 0)
	end

	-- Buyback item frame + icon
	MerchantBuyBackItem:StripTextures(true)
	MerchantBuyBackItem:CreateBackdrop("Overlay")
	MerchantBuyBackItem.backdrop:SetPoint("TOPLEFT", -2, 6)
	MerchantBuyBackItem.backdrop:SetPoint("BOTTOMRIGHT", 2, -5)
	MerchantBuyBackItemItemButton:SetPoint("TOPLEFT", MerchantBuyBackItem, "TOPLEFT", 4, 0)

	MerchantBuyBackItemItemButton:StripTextures()
	MerchantBuyBackItemItemButton:StyleButton()
	MerchantBuyBackItemItemButton:SetTemplate("Default")
	MerchantBuyBackItemItemButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	MerchantBuyBackItemItemButtonIconTexture:ClearAllPoints()
	MerchantBuyBackItemItemButtonIconTexture:SetPoint("TOPLEFT", 2, -2)
	MerchantBuyBackItemItemButtonIconTexture:SetPoint("BOTTOMRIGHT", -2, 2)
	MerchantBuyBackItemItemButton.IconBorder:SetAlpha(0)

	MerchantRepairItemButton:StyleButton()
	MerchantRepairItemButton:SetTemplate("Default")
	MerchantRepairItemButton:GetRegions():SetTexCoord(0.04, 0.24, 0.06, 0.5)
	MerchantRepairItemButton:GetRegions():ClearAllPoints()
	MerchantRepairItemButton:GetRegions():SetPoint("TOPLEFT", 2, -2)
	MerchantRepairItemButton:GetRegions():SetPoint("BOTTOMRIGHT", -2, 2)

	MerchantGuildBankRepairButton:StyleButton()
	MerchantGuildBankRepairButton:SetTemplate("Default")
	MerchantGuildBankRepairButtonIcon:SetTexCoord(0.61, 0.82, 0.1, 0.52)
	MerchantGuildBankRepairButtonIcon:ClearAllPoints()
	MerchantGuildBankRepairButtonIcon:SetPoint("TOPLEFT", 2, -2)
	MerchantGuildBankRepairButtonIcon:SetPoint("BOTTOMRIGHT", -2, 2)

	MerchantRepairAllButton:StyleButton()
	MerchantRepairAllButton:SetTemplate("Default")
	MerchantRepairAllIcon:SetTexCoord(0.34, 0.1, 0.34, 0.535, 0.535, 0.1, 0.535, 0.535)
	MerchantRepairAllIcon:ClearAllPoints()
	MerchantRepairAllIcon:SetPoint("TOPLEFT", 2, -2)
	MerchantRepairAllIcon:SetPoint("BOTTOMRIGHT", -2, 2)

	-- Misc frames
	T.SkinCloseButton(MerchantFrameCloseButton, MerchantFrame.backdrop)
	T.SkinNextPrevButton(MerchantNextPageButton)
	T.SkinNextPrevButton(MerchantPrevPageButton)
	T.SkinDropDownBox(MerchantFrameLootFilter)

	-- Reposition tabs
	MerchantFrameTab1:ClearAllPoints()
	MerchantFrameTab1:SetPoint("TOPLEFT", MerchantFrame.backdrop, "BOTTOMLEFT", 0, 2)

	hooksecurefunc("MerchantFrame_UpdateCurrencies", function()
		for i = 1, MAX_MERCHANT_CURRENCIES do
			local b = _G["MerchantToken"..i]
			local t = _G["MerchantToken"..i.."Icon"]
			local c = _G["MerchantToken"..i.."Count"]

			if b and not b.reskinned then
				t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				t:SetPoint("LEFT", c, "RIGHT", 2, 0)

				b:CreateBackdrop("Default")
				b.backdrop:SetPoint("TOPLEFT", t, "TOPLEFT", -2, 2)
				b.backdrop:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", 2, -2)

				b.reskinned = true
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)