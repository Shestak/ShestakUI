local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	QuestLog skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestLogPopupDetailFrameInset:StripTextures()
	QuestLogPopupDetailFrame:StripTextures()
	QuestLogPopupDetailFrame:CreateBackdrop("Transparent")
	QuestLogPopupDetailFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	QuestLogPopupDetailFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

	T.SkinCloseButton(QuestLogPopupDetailFrameCloseButton, QuestLogPopupDetailFrame.backdrop)
	T.SkinScrollBar(QuestLogPopupDetailFrameScrollFrame)

	QuestLogPopupDetailFrame.ShowMapButton:SkinButton(true)
	QuestLogPopupDetailFrame.ShowMapButton.Text:ClearAllPoints()
	QuestLogPopupDetailFrame.ShowMapButton.Text:SetPoint("CENTER", T.mult, 0)
	QuestLogPopupDetailFrame.ShowMapButton:SetSize(QuestLogPopupDetailFrame.ShowMapButton:GetWidth() - 30, QuestLogPopupDetailFrame.ShowMapButton:GetHeight() - 5)

	QuestLogPopupDetailFrame.AbandonButton:SkinButton()
	QuestLogPopupDetailFrame.TrackButton:SkinButton()
	QuestLogPopupDetailFrame.ShareButton:SkinButton()
	QuestLogPopupDetailFrame.ShareButton:ClearAllPoints()
	QuestLogPopupDetailFrame.ShareButton:SetPoint("LEFT", QuestLogPopupDetailFrame.AbandonButton, "RIGHT", 3, 0)
	QuestLogPopupDetailFrame.ShareButton:SetPoint("RIGHT", QuestLogPopupDetailFrame.TrackButton, "LEFT", -3, 0)

	local function QuestObjectiveText()
		if not QuestInfoFrame.questLog then return end
		local numVisibleObjectives = 0
		for i = 1, GetNumQuestLeaderBoards() do
			local _, type, finished = GetQuestLogLeaderBoard(i)
			if type ~= "spell" and type ~= "log" and numVisibleObjectives < MAX_OBJECTIVES then
				numVisibleObjectives = numVisibleObjectives + 1
				if finished then
					QuestInfoObjectivesFrame.Objectives[numVisibleObjectives]:SetTextColor(1, 1, 1)
				else
					QuestInfoObjectivesFrame.Objectives[numVisibleObjectives]:SetTextColor(0.5, 0.5, 0.5)
				end
				QuestInfoObjectivesFrame.Objectives[numVisibleObjectives]:SetShadowOffset(1, -1)
			end
		end
	end

	hooksecurefunc("QuestMapFrame_ShowQuestDetails", QuestObjectiveText)
	hooksecurefunc("QuestInfo_Display", function(template, parentFrame, acceptButton, material)
		-- Headers
		QuestInfoTitleHeader:SetTextColor(1, 0.8, 0)
		QuestInfoTitleHeader:SetShadowColor(0, 0, 0)
		QuestInfoDescriptionHeader:SetTextColor(1, 0.8, 0)
		QuestInfoDescriptionHeader:SetShadowColor(0, 0, 0)
		QuestInfoObjectivesHeader:SetTextColor(1, 0.8, 0)
		QuestInfoObjectivesHeader:SetShadowColor(0, 0, 0)
		QuestInfoRewardsFrame.Header:SetTextColor(1, 0.8, 0)
		QuestInfoRewardsFrame.Header:SetShadowColor(0, 0, 0)

		-- Other text
		QuestInfoDescriptionText:SetTextColor(1, 1, 1)
		QuestInfoDescriptionText:SetShadowOffset(1, -1)
		QuestInfoObjectivesText:SetTextColor(1, 1, 1)
		QuestInfoObjectivesText:SetShadowOffset(1, -1)
		QuestInfoGroupSize:SetTextColor(1, 1, 1)
		QuestInfoGroupSize:SetShadowOffset(1, -1)
		QuestInfoRewardText:SetTextColor(1, 1, 1)
		QuestInfoRewardText:SetShadowOffset(1, -1)
		QuestInfoSpellObjectiveLearnLabel:SetTextColor(1, 1, 1)
		QuestInfoSpellObjectiveLearnLabel:SetShadowOffset(1, -1)

		-- Reward frame text
		QuestInfoRewardsFrame.ItemChooseText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.ItemChooseText:SetShadowOffset(1, -1)
		QuestInfoRewardsFrame.ItemReceiveText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.ItemReceiveText:SetShadowOffset(1, -1)
		QuestInfoRewardsFrame.SpellLearnText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.SpellLearnText:SetShadowOffset(1, -1)
		QuestInfoRewardsFrame.XPFrame.ReceiveText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.XPFrame.ReceiveText:SetShadowOffset(1, -1)
		QuestInfoRewardsFrame.PlayerTitleText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.PlayerTitleText:SetShadowOffset(1, -1)
		MapQuestInfoRewardsFrameQuestInfoItem1.Count:SetFontObject(NumberFontNormal)

		QuestObjectiveText()
	end)

	hooksecurefunc("QuestInfo_ShowRequiredMoney", function()
		local requiredMoney = GetQuestLogRequiredMoney()
		if requiredMoney > 0 then
			if requiredMoney > GetMoney() then
				QuestInfoRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
			else
				QuestInfoRequiredMoneyText:SetTextColor(1, 0.8, 0)
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)