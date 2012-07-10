local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Merchant skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- Main frames
	MerchantFrame:StripTextures(true)
	MerchantFrame:CreateBackdrop("Transparent")
	MerchantFrame.backdrop:Point("TOPLEFT", 0, 0)
	MerchantFrame.backdrop:Point("BOTTOMRIGHT", 2, 0)

	MerchantFrameInset:StripTextures()
	MerchantMoneyBg:StripTextures()
	MerchantMoneyInset:StripTextures()
	MerchantExtraCurrencyBg:StripTextures()
	MerchantExtraCurrencyInset:StripTextures()

	MerchantBuyBackItem:StripTextures(true)
	MerchantBuyBackItem:CreateBackdrop("Overlay")
	MerchantBuyBackItem.backdrop:Point("TOPLEFT", -6, 6)
	MerchantBuyBackItem.backdrop:Point("BOTTOMRIGHT", 2, -6)

	-- Skin tabs
	for i= 1, 2 do
		T.SkinTab(_G["MerchantFrameTab"..i])
	end

	-- Icons/merchant slots
	for i = 1, BUYBACK_ITEMS_PER_PAGE do
		local b = _G["MerchantItem"..i.."ItemButton"]
		local t = _G["MerchantItem"..i.."ItemButtonIconTexture"]
		local item_bar = _G["MerchantItem"..i]

		item_bar:StripTextures(true)
		item_bar:CreateBackdrop("Overlay")

		b:StripTextures()
		b:StyleButton()
		b:SetTemplate("Default", true)
		b:Point("TOPLEFT", item_bar, "TOPLEFT", 4, -4)

		t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		t:ClearAllPoints()
		t:Point("TOPLEFT", 2, -2)
		t:Point("BOTTOMRIGHT", -2, 2)

		_G["MerchantItem"..i.."MoneyFrame"]:ClearAllPoints()
		_G["MerchantItem"..i.."MoneyFrame"]:Point("BOTTOMLEFT", b, "BOTTOMRIGHT", 3, 0)
	end

	-- Buyback item frame + icon
	MerchantBuyBackItemItemButton:StripTextures()
	MerchantBuyBackItemItemButton:StyleButton()
	MerchantBuyBackItemItemButton:SetTemplate("Default", true)
	MerchantBuyBackItemItemButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	MerchantBuyBackItemItemButtonIconTexture:ClearAllPoints()
	MerchantBuyBackItemItemButtonIconTexture:Point("TOPLEFT", 2, -2)
	MerchantBuyBackItemItemButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)

	MerchantRepairItemButton:StyleButton()
	MerchantRepairItemButton:SetTemplate("Default", true)
	MerchantRepairItemButton:GetRegions():SetTexCoord(0.04, 0.24, 0.06, 0.5)
	MerchantRepairItemButton:GetRegions():ClearAllPoints()
	MerchantRepairItemButton:GetRegions():Point("TOPLEFT", 2, -2)
	MerchantRepairItemButton:GetRegions():Point("BOTTOMRIGHT", -2, 2)

	MerchantGuildBankRepairButton:StyleButton()
	MerchantGuildBankRepairButton:SetTemplate("Default", true)
	MerchantGuildBankRepairButtonIcon:SetTexCoord(0.61, 0.82, 0.1, 0.52)
	MerchantGuildBankRepairButtonIcon:ClearAllPoints()
	MerchantGuildBankRepairButtonIcon:Point("TOPLEFT", 2, -2)
	MerchantGuildBankRepairButtonIcon:Point("BOTTOMRIGHT", -2, 2)

	MerchantRepairAllButton:StyleButton()
	MerchantRepairAllButton:SetTemplate("Default", true)
	MerchantRepairAllIcon:SetTexCoord(0.34, 0.1, 0.34, 0.535, 0.535, 0.1, 0.535, 0.535)
	MerchantRepairAllIcon:ClearAllPoints()
	MerchantRepairAllIcon:Point("TOPLEFT", 2, -2)
	MerchantRepairAllIcon:Point("BOTTOMRIGHT", -2, 2)

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
				t:Point("LEFT", c, "RIGHT", 2, 0)

				b:CreateBackdrop("Default")
				b.backdrop:Point("TOPLEFT", t, "TOPLEFT", -2, 2)
				b.backdrop:Point("BOTTOMRIGHT", t, "BOTTOMRIGHT", 2, -2)

				b.reskinned = true
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)