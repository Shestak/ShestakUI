local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Mail skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	MailFrame:StripTextures()
	MailFrame:CreateBackdrop("Transparent")
	MailFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	MailFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

	InboxFrame:StripTextures()
	MailFrameInset:StripTextures()
	SendMailMoneyInset:StripTextures()
	SendMailMoneyBg:StripTextures()

	for i = 1, INBOXITEMS_TO_DISPLAY do
		local bg = _G["MailItem"..i]

		bg:StripTextures()
		bg:CreateBackdrop("Overlay")
		bg.backdrop:SetPoint("TOPLEFT", 2, 1)
		bg.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)

		local b = _G["MailItem"..i.."Button"]
		b:StripTextures()
		b:SetTemplate("Default")
		b:StyleButton()

		local t = _G["MailItem"..i.."ButtonIcon"]
		t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", 2, -2)
		t:SetPoint("BOTTOMRIGHT", -2, 2)

		_G["MailItem"..i.."ButtonIconBorder"]:SetAlpha(0)
	end

	T.SkinCloseButton(MailFrameCloseButton, MailFrame.backdrop)
	T.SkinNextPrevButton(InboxPrevPageButton)
	T.SkinNextPrevButton(InboxNextPageButton)

	T.SkinTab(MailFrameTab1)
	T.SkinTab(MailFrameTab2)

	-- Send mail
	SendMailFrame:StripTextures()

	SendMailScrollFrame:StripTextures(true)
	SendMailScrollFrame:CreateBackdrop("Overlay")
	SendMailScrollFrame.backdrop:SetPoint("TOPLEFT", 12, 0)
	SendMailScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 2, 0)

	T.SkinScrollBar(SendMailScrollFrameScrollBar)

	T.SkinEditBox(SendMailNameEditBox)
	T.SkinEditBox(SendMailSubjectEditBox)
	T.SkinEditBox(SendMailMoneyGold)
	T.SkinEditBox(SendMailMoneySilver)
	T.SkinEditBox(SendMailMoneyCopper)

	SendMailNameEditBox.backdrop:SetPoint("TOPLEFT", -3, -2)
	SendMailNameEditBox.backdrop:SetPoint("BOTTOMRIGHT", 2, 3)
	SendMailSubjectEditBox.backdrop:SetPoint("TOPLEFT", -3, 0)
	SendMailSubjectEditBox.backdrop:SetPoint("BOTTOMRIGHT", -4, 0)

	local function MailFrameSkin()
		for i = 1, ATTACHMENTS_MAX_SEND do
			local b = _G["SendMailAttachment"..i]

			if not b.skinned then
				b:StripTextures()
				b:SetTemplate("Default")
				b:StyleButton()
				b.IconBorder:SetAlpha(0)
				b.skinned = true
			end

			local t = b:GetNormalTexture()

			if t then
				t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				t:ClearAllPoints()
				t:SetPoint("TOPLEFT", 2, -2)
				t:SetPoint("BOTTOMRIGHT", -2, 2)
			end
		end
	end
	hooksecurefunc("SendMailFrame_Update", MailFrameSkin)

	SendMailMailButton:SkinButton()
	SendMailCancelButton:SkinButton()

	SendMailSendMoneyButton:SetSize(18, 18)
	SendMailCODButton:SetSize(18, 18)
	T.SkinCheckBox(SendMailSendMoneyButton)
	T.SkinCheckBox(SendMailCODButton)

	-- Open mail (cod)
	OpenMailFrame:StripTextures(true)
	OpenMailFrame:CreateBackdrop("Transparent")
	OpenMailFrame.backdrop:SetPoint("TOPLEFT", -5, 0)
	OpenMailFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	OpenMailFrameInset:StripTextures()

	T.SkinCloseButton(OpenMailFrameCloseButton, OpenMailFrame.backdrop)
	OpenMailReportSpamButton:SkinButton()
	OpenMailReplyButton:SkinButton()
	OpenMailDeleteButton:SkinButton()
	OpenMailCancelButton:SkinButton()

	OpenMailScrollFrame:StripTextures(true)
	OpenMailScrollFrame:CreateBackdrop("Overlay")
	OpenMailScrollFrame.backdrop:SetPoint("TOPLEFT", 5, 5)
	OpenMailScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, -5)

	T.SkinScrollBar(OpenMailScrollFrameScrollBar)

	SendMailBodyEditBox:SetTextColor(1, 1, 1)
	OpenMailBodyText:SetTextColor(1, 1, 1)
	InvoiceTextFontNormal:SetTextColor(1, 1, 1)
	OpenMailArithmeticLine:Kill()

	OpenMailLetterButton:StripTextures()
	OpenMailLetterButton:SetTemplate("Default")
	OpenMailLetterButton:StyleButton()
	OpenMailLetterButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OpenMailLetterButtonIconTexture:ClearAllPoints()
	OpenMailLetterButtonIconTexture:SetPoint("TOPLEFT", 2, -2)
	OpenMailLetterButtonIconTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	OpenMailMoneyButton:StripTextures()
	OpenMailMoneyButton:SetTemplate("Default")
	OpenMailMoneyButton:StyleButton()
	OpenMailMoneyButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OpenMailMoneyButtonIconTexture:ClearAllPoints()
	OpenMailMoneyButtonIconTexture:SetPoint("TOPLEFT", 2, -2)
	OpenMailMoneyButtonIconTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	for i = 1, ATTACHMENTS_MAX_RECEIVE do
		local b = _G["OpenMailAttachmentButton"..i]
		local t = _G["OpenMailAttachmentButton"..i.."IconTexture"]

		b:StripTextures()
		b:SetTemplate("Default")
		b:StyleButton()
		b.IconBorder:SetAlpha(0)

		if t then
			t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			t:ClearAllPoints()
			t:SetPoint("TOPLEFT", 2, -2)
			t:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end

	OpenMailReplyButton:SetPoint("RIGHT", OpenMailDeleteButton, "LEFT", -2, 0)
	OpenMailDeleteButton:SetPoint("RIGHT", OpenMailCancelButton, "LEFT", -2, 0)
	SendMailMailButton:SetPoint("RIGHT", SendMailCancelButton, "LEFT", -2, 0)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)