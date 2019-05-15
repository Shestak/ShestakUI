local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Quest skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestFrame:StripTextures(true)
	QuestFrameInset:StripTextures(true)
	QuestFrameDetailPanel:StripTextures(true)
	QuestDetailScrollFrame:StripTextures(true)
	QuestDetailScrollChildFrame:StripTextures(true)
	QuestRewardScrollFrame:StripTextures(true)
	QuestRewardScrollChildFrame:StripTextures(true)
	QuestProgressScrollFrame:StripTextures(true)
	QuestGreetingScrollFrame:StripTextures(true)
	QuestFrameProgressPanel:StripTextures(true)
	QuestFrameRewardPanel:StripTextures(true)

	QuestFrame:CreateBackdrop("Transparent")
	QuestFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	QuestFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

	QuestFrameAcceptButton:SkinButton(true)
	QuestFrameDeclineButton:SkinButton(true)
	QuestFrameCompleteButton:SkinButton(true)
	QuestFrameGoodbyeButton:SkinButton(true)
	QuestFrameCompleteQuestButton:SkinButton(true)

	T.SkinCloseButton(QuestFrameCloseButton, QuestFrame.backdrop)
	T.SkinScrollBar(QuestDetailScrollFrameScrollBar)
	T.SkinScrollBar(QuestProgressScrollFrameScrollBar)
	T.SkinScrollBar(QuestRewardScrollFrameScrollBar)
	T.SkinScrollBar(QuestGreetingScrollFrameScrollBar)
	T.SkinScrollBar(QuestNPCModelTextScrollFrameScrollBar)

	for i = 1, 6 do
		local button = _G["QuestProgressItem"..i]
		local texture = _G["QuestProgressItem"..i.."IconTexture"]

		if button.NameFrame then button.NameFrame:Hide() end
		button.Name:SetFont(C.media.normal_font, 12)

		button:CreateBackdrop("Default")
		button.backdrop:ClearAllPoints()
		button.backdrop:SetPoint("TOPLEFT", texture, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", texture, 2, -2)

		texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	hooksecurefunc("QuestFrameProgressItems_Update", function()
		QuestProgressTitleText:SetTextColor(1, 0.8, 0)
		QuestProgressTitleText:SetShadowColor(0, 0, 0)
		QuestProgressText:SetTextColor(1, 1, 1)
		QuestProgressRequiredItemsText:SetTextColor(1, 0.8, 0)
		QuestProgressRequiredItemsText:SetShadowColor(0, 0, 0)
		QuestProgressRequiredMoneyText:SetTextColor(1, 0.8, 0)
	end)

	-- QuestGreeting
	local function UpdateGreetingPanel()
		QuestFrameGreetingPanel:StripTextures()
		QuestFrameGreetingGoodbyeButton:SkinButton()
		GreetingText:SetTextColor(1, 1, 1)
		CurrentQuestsText:SetTextColor(1, 0.8, 0)
		AvailableQuestsText:SetTextColor(1, 0.8, 0)
		QuestGreetingFrameHorizontalBreak:Kill()

		for button in QuestFrameGreetingPanel.titleButtonPool:EnumerateActive() do
			local text = button:GetFontString():GetText()
			if text and strfind(text, "|cff000000") then
				button:GetFontString():SetText(gsub(text, "|cff000000", "|cffFFFF00"))
			end
		end
	end

	QuestFrameGreetingPanel:HookScript("OnShow", UpdateGreetingPanel)
	hooksecurefunc("QuestFrameGreetingPanel_OnShow", UpdateGreetingPanel)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)