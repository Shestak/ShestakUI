local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Trade skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TradeFrame:StripTextures(true)
	TradeFrameInset:StripTextures()
	TradePlayerItemsInset:StripTextures()
	TradeRecipientItemsInset:StripTextures()
	TradePlayerEnchantInset:StripTextures()
	TradeRecipientEnchantInset:StripTextures()
	TradePlayerInputMoneyInset:StripTextures()
	TradeRecipientMoneyInset:StripTextures()
	TradeRecipientMoneyBg:StripTextures()

	TradeFrame.RecipientOverlay.portrait:SetAlpha(0)
	TradeFrame.RecipientOverlay.portraitFrame:SetAlpha(0)

	TradeFrame:CreateBackdrop("Transparent")
	TradeFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	TradeFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	TradeFrameTradeButton:SkinButton(true)
	TradeFrameCancelButton:SkinButton(true)
	T.SkinCloseButton(TradeFrameCloseButton, TradeFrame.backdrop)

	T.SkinEditBox(TradePlayerInputMoneyFrameGold)
	T.SkinEditBox(TradePlayerInputMoneyFrameSilver)
	T.SkinEditBox(TradePlayerInputMoneyFrameCopper)

	for i = 1, MAX_TRADE_ITEMS do
		local player = _G["TradePlayerItem"..i]
		local recipient = _G["TradeRecipientItem"..i]
		local player_button = _G["TradePlayerItem"..i.."ItemButton"]
		local recipient_button = _G["TradeRecipientItem"..i.."ItemButton"]
		local player_button_icon = _G["TradePlayerItem"..i.."ItemButtonIconTexture"]
		local recipient_button_icon = _G["TradeRecipientItem"..i.."ItemButtonIconTexture"]
		local player_button_count = _G["TradePlayerItem"..i.."ItemButtonCount"]
		local recipient_button_count = _G["TradeRecipientItem"..i.."ItemButtonCount"]

		if player_button and recipient_button then
			player:StripTextures()
			recipient:StripTextures()
			player_button:StripTextures()
			recipient_button:StripTextures()

			player_button.IconBorder:SetAlpha(0)
			recipient_button.IconBorder:SetAlpha(0)

			player_button_icon:ClearAllPoints()
			player_button_icon:SetPoint("TOPLEFT", player_button, "TOPLEFT", 2, -2)
			player_button_icon:SetPoint("BOTTOMRIGHT", player_button, "BOTTOMRIGHT", -2, 2)
			player_button_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			player_button_icon:SetDrawLayer("OVERLAY")

			player_button_count:SetDrawLayer("OVERLAY")

			player_button:SetTemplate("Overlay")
			player_button:StyleButton()

			player_button.bg = CreateFrame("Frame", nil, player_button)
			player_button.bg:SetTemplate("Overlay")
			player_button.bg:SetPoint("TOPLEFT", player_button, "TOPRIGHT", 4, 0)
			player_button.bg:SetPoint("BOTTOMRIGHT", _G["TradePlayerItem"..i.."NameFrame"], "BOTTOMRIGHT", 0, 14)
			player_button.bg:SetFrameLevel(player_button:GetFrameLevel() - 4)

			recipient_button_icon:ClearAllPoints()
			recipient_button_icon:SetPoint("TOPLEFT", recipient_button, "TOPLEFT", 2, -2)
			recipient_button_icon:SetPoint("BOTTOMRIGHT", recipient_button, "BOTTOMRIGHT", -2, 2)
			recipient_button_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			recipient_button_icon:SetDrawLayer("OVERLAY")

			recipient_button_count:SetDrawLayer("OVERLAY")

			recipient_button:SetTemplate("Overlay")
			recipient_button:StyleButton()

			recipient_button.bg = CreateFrame("Frame", nil, recipient_button)
			recipient_button.bg:SetTemplate("Overlay")
			recipient_button.bg:SetPoint("TOPLEFT", recipient_button, "TOPRIGHT", 4, 0)
			recipient_button.bg:SetPoint("BOTTOMRIGHT", _G["TradeRecipientItem"..i.."NameFrame"], "BOTTOMRIGHT", 0, 14)
			recipient_button.bg:SetFrameLevel(recipient_button:GetFrameLevel() - 4)
		end
	end

	TradeHighlightPlayerTop:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightPlayerBottom:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightPlayerMiddle:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightPlayer:SetFrameStrata("HIGH")
	TradeHighlightPlayer:SetPoint("TOPLEFT", TradeFrame, "TOPLEFT", 11, -86)

	TradeHighlightPlayerEnchantTop:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightPlayerEnchantBottom:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightPlayerEnchantMiddle:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightPlayerEnchant:SetFrameStrata("HIGH")

	TradeHighlightRecipientTop:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightRecipientBottom:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightRecipientMiddle:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightRecipient:SetFrameStrata("HIGH")
	TradeHighlightRecipient:SetPoint("TOPLEFT", TradeFrame, "TOPLEFT", 179, -86)

	TradeHighlightRecipientEnchantTop:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightRecipientEnchantBottom:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightRecipientEnchantMiddle:SetColorTexture(0, 1, 0, 0.2)
	TradeHighlightRecipientEnchant:SetFrameStrata("HIGH")
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)