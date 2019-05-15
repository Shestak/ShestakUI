local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GuildBankUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	GuildBankFrame:StripTextures()
	GuildBankFrame:SetTemplate("Transparent")
	GuildBankEmblemFrame:StripTextures(true)
	GuildBankMoneyFrameBackground:StripTextures()

	for i = 1, GuildBankFrame:GetNumChildren() do
		local child = select(i, GuildBankFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child)
		end
	end

	GuildBankFrameDepositButton:SkinButton(true)
	GuildBankFrameWithdrawButton:SkinButton(true)
	GuildBankInfoSaveButton:SkinButton(true)
	GuildBankFramePurchaseButton:SkinButton(true)

	GuildBankFrameWithdrawButton:SetPoint("RIGHT", GuildBankFrameDepositButton, "LEFT", -2, 0)

	GuildBankInfoScrollFrame:StripTextures()
	GuildBankTransactionsScrollFrame:StripTextures()
	T.SkinScrollBar(GuildBankPopupScrollFrameScrollBar)
	T.SkinScrollBar(GuildBankInfoScrollFrameScrollBar)
	T.SkinScrollBar(GuildBankTransactionsScrollFrameScrollBar)
	GuildBankInfoScrollFrame:SetHeight(GuildBankInfoScrollFrame:GetHeight() - 5)
	GuildBankTransactionsScrollFrame:SetHeight(GuildBankTransactionsScrollFrame:GetHeight() - 5)

	GuildBankFrame.inset = CreateFrame("Frame", nil, GuildBankFrame)
	GuildBankFrame.inset:SetTemplate("Overlay")
	GuildBankFrame.inset:SetPoint("TOPLEFT", 21, -58)
	GuildBankFrame.inset:SetPoint("BOTTOMRIGHT", -17, 61)

	GuildItemSearchBox:StripTextures(true)
	GuildItemSearchBox:CreateBackdrop("Overlay")
	GuildItemSearchBox.backdrop:SetPoint("TOPLEFT", 13, 0)
	GuildItemSearchBox.backdrop:SetPoint("BOTTOMRIGHT", -5, 0)

	for i = 1, NUM_GUILDBANK_COLUMNS do
		_G["GuildBankColumn"..i]:StripTextures()

		for j = 1, NUM_SLOTS_PER_GUILDBANK_GROUP do
			local button = _G["GuildBankColumn"..i.."Button"..j]
			local icon = _G["GuildBankColumn"..i.."Button"..j.."IconTexture"]
			local border = _G["GuildBankColumn"..i.."Button"..j].IconBorder

			border:Kill()
			button:SetNormalTexture(nil)
			button:StyleButton()
			button:SetTemplate("Default")

			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end

	for i = 1, 8 do
		local button = _G["GuildBankTab"..i.."Button"]
		local texture = _G["GuildBankTab"..i.."ButtonIconTexture"]
		_G["GuildBankTab"..i]:StripTextures(true)

		button:StripTextures()
		button:StyleButton()
		button:SetTemplate("Default")

		-- Reposition tabs
		button:ClearAllPoints()
		if i == 1 then
			button:SetPoint("TOPLEFT", GuildBankFrame, "TOPRIGHT", 1, 0)
		else
			local fixpos = i-1
			button:SetPoint("TOP", _G["GuildBankTab"..fixpos.."Button"], "BOTTOM", 0, -20)
		end

		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", 2, -2)
		texture:SetPoint("BOTTOMRIGHT", -2, 2)
		texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	for i = 1, 4 do
		T.SkinTab(_G["GuildBankFrameTab"..i])
	end

	-- Reposition tabs
	GuildBankFrameTab1:ClearAllPoints()
	GuildBankFrameTab1:SetPoint("TOPLEFT", GuildBankFrame, "BOTTOMLEFT", 0, 2)

	-- Popup
	T.SkinIconSelectionFrame(GuildBankPopupFrame, NUM_GUILDBANK_ICONS_SHOWN, nil, "GuildBankPopup")
end

T.SkinFuncs["Blizzard_GuildBankUI"] = LoadSkin
