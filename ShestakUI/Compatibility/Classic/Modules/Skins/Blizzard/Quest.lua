local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return else return end -- incomplete

----------------------------------------------------------------------------------------
--	Quest skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestFrame:CreateBackdrop("Transparent")
	QuestFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	QuestFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	QuestDetailScrollFrame:SetHeight(QuestFrame.backdrop:GetHeight() / 1.3)
	QuestRewardScrollFrame:SetHeight(QuestFrame.backdrop:GetHeight() / 1.3)
	QuestProgressScrollFrame:SetHeight(QuestFrame.backdrop:GetHeight() / 1.3)
	QuestGreetingScrollFrame:SetHeight(QuestFrame.backdrop:GetHeight() / 1.3)

	QuestNpcNameFrame:ClearAllPoints()
	QuestNpcNameFrame:SetPoint("TOP", QuestFrame.backdrop, "TOP", 0, -6)

	T.SkinCloseButton(QuestFrameCloseButton, QuestFrame.backdrop)

	local QuestStrip = {
		"QuestFrame",
		"QuestFrameDetailPanel",
		"QuestDetailScrollFrame",
		"QuestDetailScrollChildFrame",
		"QuestRewardScrollFrame",
		"QuestRewardScrollChildFrame",
		"QuestProgressScrollFrame",
		"QuestGreetingScrollFrame",
		"QuestFrameProgressPanel",
		"QuestFrameRewardPanel",
	}

	for _, object in pairs(QuestStrip) do
		_G[object]:StripTextures(true)
	end

	local LeftQuestButtons = {
		"QuestFrameAcceptButton",
		"QuestFrameCompleteButton",
		"QuestFrameCompleteQuestButton",
	}

	local RightQuestButtons = {
		"QuestFrameDeclineButton",
		"QuestFrameGoodbyeButton",
		"QuestFrameCancelButton",
	}

	for _, button in pairs(LeftQuestButtons) do
		_G[button]:SkinButton()
		_G[button]:SetPoint("BOTTOMLEFT", QuestFrame.backdrop, "BOTTOMLEFT", 4, 4)
	end

	for _, button in pairs(RightQuestButtons) do
		_G[button]:SkinButton()
		_G[button]:SetPoint("BOTTOMRIGHT", QuestFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	end

	local ScrollBars = {
		"QuestDetailScrollFrameScrollBar",
		"QuestProgressScrollFrameScrollBar",
		"QuestRewardScrollFrameScrollBar",
		"QuestGreetingScrollFrameScrollBar",
		"QuestNPCModelTextScrollFrameScrollBar",
	}

	for _, scrollbar in pairs(ScrollBars) do
		T.SkinScrollBar(_G[scrollbar])
	end

	QuestInfoTitleHeader:SetTextColor(1, 0.8, 0)
	QuestInfoTitleHeader:SetShadowColor(0, 0, 0)
	QuestInfoDescriptionText:SetTextColor(1, 1, 1)
	QuestInfoObjectivesHeader:SetTextColor(1, 0.8, 0)
	QuestInfoObjectivesHeader:SetShadowColor(0, 0, 0)
	QuestInfoObjectivesText:SetTextColor(1, 1, 1)
	QuestInfoRewardsFrame.Header:SetTextColor(1, 0.8, 0)
	QuestInfoRewardsFrame.Header:SetShadowColor(0, 0, 0)
	QuestInfoRewardsFrame.ItemChooseText:SetTextColor(1, 1, 1)

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
		QuestFrameGreetingGoodbyeButton:SetPoint("BOTTOMRIGHT", QuestFrame.backdrop, "BOTTOMRIGHT", -4, 4)
		GreetingText:SetTextColor(1, 1, 1)
		CurrentQuestsText:SetTextColor(1, 0.8, 0)
		AvailableQuestsText:SetTextColor(1, 0.8, 0)
		QuestGreetingFrameHorizontalBreak:Kill()

		for i = 1, MAX_NUM_QUESTS do
			local button = _G["QuestTitleButton"..i]
			button:SetTextColor(1, 1, 0)
		end

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