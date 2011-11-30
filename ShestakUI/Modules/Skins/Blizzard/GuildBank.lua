local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GuildBankUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	GuildBankFrame:StripTextures()
	GuildBankFrame:SetTemplate("Transparent")
	GuildBankEmblemFrame:StripTextures(true)

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

	GuildBankFrameWithdrawButton:Point("RIGHT", GuildBankFrameDepositButton, "LEFT", -2, 0)

	GuildBankInfoScrollFrame:StripTextures()
	GuildBankTransactionsScrollFrame:StripTextures()

	GuildBankFrame.inset = CreateFrame("Frame", nil, GuildBankFrame)
	GuildBankFrame.inset:SetTemplate("Overlay")
	GuildBankFrame.inset:Point("TOPLEFT", 30, -65)
	GuildBankFrame.inset:Point("BOTTOMRIGHT", -20, 63)

	GuildItemSearchBox:StripTextures()
	GuildItemSearchBox:CreateBackdrop("Overlay")
	GuildItemSearchBox.backdrop:Point("TOPLEFT", 10, -2)
	GuildItemSearchBox.backdrop:Point("BOTTOMRIGHT", -5, 2)

	for i = 1, NUM_GUILDBANK_COLUMNS do
		_G["GuildBankColumn"..i]:StripTextures()

		for x = 1, NUM_SLOTS_PER_GUILDBANK_GROUP do
			local button = _G["GuildBankColumn"..i.."Button"..x]
			local icon = _G["GuildBankColumn"..i.."Button"..x.."IconTexture"]
			button:StripTextures()
			button:StyleButton()
			button:SetTemplate("Default", true)

			icon:ClearAllPoints()
			icon:Point("TOPLEFT", 2, -2)
			icon:Point("BOTTOMRIGHT", -2, 2)
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end

	for i = 1, 8 do
		local button = _G["GuildBankTab"..i.."Button"]
		local texture = _G["GuildBankTab"..i.."ButtonIconTexture"]
		_G["GuildBankTab"..i]:StripTextures(true)

		button:StripTextures()
		button:StyleButton(true)
		button:SetTemplate("Default", true)

		-- Reposition tabs
		button:ClearAllPoints()
		if i == 1 then
			button:SetPoint("TOPLEFT", GuildBankFrame, "TOPRIGHT", 1, 0)
		else
			local fixpos = i-1
			button:SetPoint("TOP", _G["GuildBankTab"..fixpos.."Button"], "BOTTOM", 0, -20)
		end

		texture:ClearAllPoints()
		texture:Point("TOPLEFT", 2, -2)
		texture:Point("BOTTOMRIGHT", -2, 2)
		texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	for i = 1, 4 do
		T.SkinTab(_G["GuildBankFrameTab"..i])
	end

	-- Reposition tabs
	GuildBankFrameTab1:ClearAllPoints()
	GuildBankFrameTab1:SetPoint("TOPLEFT", GuildBankFrame, "BOTTOMLEFT", 0, 2)

	-- Popup
	GuildBankPopupFrame:CreateBackdrop("Transparent")
	GuildBankPopupFrame.backdrop:Point("TOPLEFT", 5, 0)
	GuildBankPopupFrame.backdrop:Point("BOTTOMRIGHT", -25, 23)
	GuildBankPopupFrame:StripTextures()
	GuildBankPopupFrame:Point("TOPLEFT", GuildBankFrame, "TOPRIGHT", -4, 0)

	GuildBankPopupCancelButton:SkinButton(true)
	GuildBankPopupOkayButton:SkinButton(true)
	GuildBankPopupScrollFrame:StripTextures()
	GuildBankPopupEditBox:StripTextures(true)
	T.SkinEditBox(GuildBankPopupEditBox)
	GuildBankPopupEditBox:Height(GuildBankPopupEditBox:GetHeight() - 5)

	for i = 1, 16 do
		local button = _G["GuildBankPopupButton"..i]
		local texture = _G["GuildBankPopupButton"..i.."Icon"]

		button:StripTextures()
		button:StyleButton(true)
		button:SetTemplate("Default", true)

		texture:ClearAllPoints()
		texture:Point("TOPLEFT", 2, -2)
		texture:Point("BOTTOMRIGHT", -2, 2)
		texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end
end

T.SkinFuncs["Blizzard_GuildBankUI"] = LoadSkin