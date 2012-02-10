local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Mail skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	MailFrame:StripTextures(true)
	MailFrame:CreateBackdrop("Transparent")
	MailFrame.backdrop:Point("TOPLEFT", 16, -12)
	MailFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)

	for i = 1, INBOXITEMS_TO_DISPLAY do
		local bg = _G["MailItem"..i]
		bg:StripTextures()
		bg:CreateBackdrop("Overlay")
		bg.backdrop:Point("TOPLEFT", 2, 1)
		bg.backdrop:Point("BOTTOMRIGHT", -2, 2)

		local b = _G["MailItem"..i.."Button"]
		b:StripTextures()
		b:SetTemplate("Default", true)
		b:StyleButton()

		local t = _G["MailItem"..i.."ButtonIcon"]
		t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		t:ClearAllPoints()
		t:Point("TOPLEFT", 2, -2)
		t:Point("BOTTOMRIGHT", -2, 2)
	end

	T.SkinCloseButton(InboxCloseButton, MailFrame.backdrop)
	T.SkinNextPrevButton(InboxPrevPageButton)
	T.SkinNextPrevButton(InboxNextPageButton)

	MailFrameTab1:StripTextures()
	MailFrameTab2:StripTextures()
	T.SkinTab(MailFrameTab1)
	T.SkinTab(MailFrameTab2)

	-- Reposition tabs
	MailFrameTab1:ClearAllPoints()
	MailFrameTab1:SetPoint("TOPLEFT", MailFrame.backdrop, "BOTTOMLEFT", 0, 2)
	MailFrameTab1.SetPoint = T.dummy

	-- Send mail
	SendMailScrollFrame:StripTextures(true)
	SendMailScrollFrame:CreateBackdrop("Overlay")
	SendMailScrollFrame.backdrop:Point("TOPLEFT", 12, 0)
	SendMailScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

	T.SkinScrollBar(SendMailScrollFrameScrollBar)

	T.SkinEditBox(SendMailNameEditBox)
	T.SkinEditBox(SendMailSubjectEditBox)
	T.SkinEditBox(SendMailMoneyGold)
	T.SkinEditBox(SendMailMoneySilver)
	T.SkinEditBox(SendMailMoneyCopper)

	SendMailNameEditBox.backdrop:Point("BOTTOMRIGHT", 2, 0)
	SendMailSubjectEditBox.backdrop:Point("BOTTOMRIGHT", 2, 0)
	SendMailFrame:StripTextures()

	local function MailFrameSkin()
		for i = 1, ATTACHMENTS_MAX_SEND do
			local b = _G["SendMailAttachment"..i]
			if not b.skinned then
				b:StripTextures()
				b:SetTemplate("Default", true)
				b:StyleButton()
				b.skinned = true
			end
			local t = b:GetNormalTexture()
			if t then
				t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				t:ClearAllPoints()
				t:Point("TOPLEFT", 2, -2)
				t:Point("BOTTOMRIGHT", -2, 2)
			end
		end
	end
	hooksecurefunc("SendMailFrame_Update", MailFrameSkin)

	SendMailMailButton:SkinButton()
	SendMailCancelButton:SkinButton()

	-- Open mail (cod)
	OpenMailFrame:StripTextures(true)
	OpenMailFrame:CreateBackdrop("Transparent")
	OpenMailFrame.backdrop:Point("TOPLEFT", 16, -12)
	OpenMailFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)

	T.SkinCloseButton(OpenMailCloseButton, OpenMailFrame.backdrop)
	OpenMailReportSpamButton:SkinButton()
	OpenMailReplyButton:SkinButton()
	OpenMailDeleteButton:SkinButton()
	OpenMailCancelButton:SkinButton()

	OpenMailScrollFrame:StripTextures(true)
	OpenMailScrollFrame:CreateBackdrop("Overlay")
	OpenMailScrollFrame.backdrop:Point("TOPLEFT", 12, 0)
	OpenMailScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

	OpenMailScrollChildFrame:Point("TOPLEFT", 10, 0)

	T.SkinScrollBar(OpenMailScrollFrameScrollBar)

	SendMailBodyEditBox:SetTextColor(1, 1, 1)
	OpenMailBodyText:SetTextColor(1, 1, 1)
	InvoiceTextFontNormal:SetTextColor(1, 1, 1)
	OpenMailArithmeticLine:Kill()

	OpenMailLetterButton:StripTextures()
	OpenMailLetterButton:SetTemplate("Default", true)
	OpenMailLetterButton:StyleButton()
	OpenMailLetterButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OpenMailLetterButtonIconTexture:ClearAllPoints()
	OpenMailLetterButtonIconTexture:Point("TOPLEFT", 2, -2)
	OpenMailLetterButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)

	OpenMailMoneyButton:StripTextures()
	OpenMailMoneyButton:SetTemplate("Default", true)
	OpenMailMoneyButton:StyleButton()
	OpenMailMoneyButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OpenMailMoneyButtonIconTexture:ClearAllPoints()
	OpenMailMoneyButtonIconTexture:Point("TOPLEFT", 2, -2)
	OpenMailMoneyButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)

	for i = 1, ATTACHMENTS_MAX_SEND do
		local b = _G["OpenMailAttachmentButton"..i]
		b:StripTextures()
		b:SetTemplate("Default", true)
		b:StyleButton()

		local t = _G["OpenMailAttachmentButton"..i.."IconTexture"]
		if t then
			t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			t:ClearAllPoints()
			t:Point("TOPLEFT", 2, -2)
			t:Point("BOTTOMRIGHT", -2, 2)
		end
	end

	OpenMailReplyButton:Point("RIGHT", OpenMailDeleteButton, "LEFT", -2, 0)
	OpenMailDeleteButton:Point("RIGHT", OpenMailCancelButton, "LEFT", -2, 0)
	SendMailMailButton:Point("RIGHT", SendMailCancelButton, "LEFT", -2, 0)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)