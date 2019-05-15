local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

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

	QuestLogPopupDetailFrameScrollFrame:StripTextures()
	T.SkinScrollBar(QuestLogPopupDetailFrameScrollFrameScrollBar)

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

	local function SkinReward(button, mapReward)
		if button.NameFrame then button.NameFrame:Hide() end
		if button.CircleBackground then button.CircleBackground:Hide() end
		if button.CircleBackgroundGlow then button.CircleBackgroundGlow:Hide() end
		if button.ValueText then button.ValueText:SetPoint("BOTTOMRIGHT", button.Icon, 0, 0) end
		if button.IconBorder then button.IconBorder:SetAlpha(0) end
		button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button:CreateBackdrop("Default")
		button.backdrop:ClearAllPoints()
		button.backdrop:SetPoint("TOPLEFT", button.Icon, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, 2, -2)
		if mapReward then
			button.Icon:SetSize(26, 26)
		end
	end

	local function SkinRewardSpell(button)
		local name = button:GetName()
		local icon = button.Icon

		_G[name.."NameFrame"]:Hide()
		_G[name.."SpellBorder"]:Hide()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		button:CreateBackdrop("Default")
		button.backdrop:ClearAllPoints()
		button.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)
	end

	SkinRewardSpell(QuestInfoSpellObjectiveFrame)

	for _, name in next, {"HonorFrame", "MoneyFrame", "SkillPointFrame", "XPFrame", "ArtifactXPFrame", "TitleFrame"} do
		SkinReward(MapQuestInfoRewardsFrame[name], true)
	end

	for _, name in next, {"HonorFrame", "SkillPointFrame", "ArtifactXPFrame"} do
		SkinReward(QuestInfoRewardsFrame[name])
	end

	SkinReward(QuestInfoSkillPointFrame)

	hooksecurefunc("QuestInfo_GetRewardButton", function(rewardsFrame, index)
		local button = rewardsFrame.RewardButtons[index]
		if not button.restyled then
			SkinReward(button, rewardsFrame == MapQuestInfoRewardsFrame)
			button.restyled = true
		end
	end)

	hooksecurefunc("QuestInfo_Display", function(template, parentFrame)
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
		QuestInfoQuestType:SetTextColor(1, 1, 1)
		QuestInfoQuestType:SetShadowOffset(1, -1)

		-- Reward frame text
		QuestInfoRewardsFrame.ItemChooseText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.ItemChooseText:SetShadowOffset(1, -1)
		QuestInfoRewardsFrame.ItemReceiveText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.ItemReceiveText:SetShadowOffset(1, -1)
		QuestInfoRewardsFrame.XPFrame.ReceiveText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.XPFrame.ReceiveText:SetShadowOffset(1, -1)
		QuestInfoRewardsFrame.PlayerTitleText:SetTextColor(1, 1, 1)
		QuestInfoRewardsFrame.PlayerTitleText:SetShadowOffset(1, -1)

		QuestObjectiveText()

		if template.canHaveSealMaterial then
			local questFrame = parentFrame:GetParent():GetParent()
			questFrame.SealMaterialBG:Hide()
		end

		local rewardsFrame = QuestInfoFrame.rewardsFrame
		local isQuestLog = QuestInfoFrame.questLog ~= nil
		local isMapQuest = rewardsFrame == MapQuestInfoRewardsFrame

		local numSpellRewards = isQuestLog and GetNumQuestLogRewardSpells() or GetNumRewardSpells()
		if numSpellRewards > 0 then
			-- Spell Headers
			for spellHeader in rewardsFrame.spellHeaderPool:EnumerateActive() do
				spellHeader:SetVertexColor(1, 1, 1)
			end
			-- Follower Rewards
			for followerReward in rewardsFrame.followerRewardPool:EnumerateActive() do
				if not followerReward.isSkinned then
					followerReward:CreateBackdrop("Overlay")
					followerReward.backdrop:SetAllPoints(followerReward.BG)
					followerReward.backdrop:SetPoint("TOPLEFT", 30, -5)
					followerReward.backdrop:SetPoint("BOTTOMRIGHT", 2, 5)
					followerReward.BG:Hide()
					followerReward.isSkinned = true
				end
			end
			-- Spell Rewards
			for spellReward in rewardsFrame.spellRewardPool:EnumerateActive() do
				if not spellReward.isSkinned then
					SkinReward(spellReward)
					local border = select(3, spellReward:GetRegions())
					border:Hide()
					if not isMapQuest then
						spellReward.Icon:SetPoint("TOPLEFT", 0, 0)
						spellReward:SetHitRectInsets(0, 0, 0, 0)
						spellReward:SetSize(147, 41)
					end
					spellReward.isSkinned = true
				end
			end
		end
	end)

	hooksecurefunc(QuestInfoRequiredMoneyText, "SetTextColor", function(self, r)
		if r == 0 then
			self:SetTextColor(1, 0.8, 0)
		elseif r == 0.2 then
			self:SetTextColor(0.6, 0.6, 0.6)
		end
	end)

	QuestInfoItemHighlight:StripTextures()
	QuestInfoItemHighlight:SetTemplate("Default")
	QuestInfoItemHighlight:SetBackdropBorderColor(1, 1, 0)
	QuestInfoItemHighlight:SetBackdropColor(0, 0, 0, 0)

	hooksecurefunc("QuestInfoItem_OnClick", function(self)
		QuestInfoItemHighlight:ClearAllPoints()
		QuestInfoItemHighlight:SetPoint("TOPLEFT", self.Icon, "TOPLEFT", -2, 2)
		QuestInfoItemHighlight:SetPoint("BOTTOMRIGHT", self.Icon, "BOTTOMRIGHT", 2, -2)

		local parent = self:GetParent()
		for i = 1, #parent.RewardButtons do
			local questItem = QuestInfoRewardsFrame.RewardButtons[i]
			if questItem ~= self then
				questItem.Name:SetTextColor(1, 1, 1)
			else
				self.Name:SetTextColor(1, 1, 0)
			end
		end
	end)

	hooksecurefunc("QuestInfo_Display", function()
		for i = 1, #QuestInfoRewardsFrame.RewardButtons do
			local questItem = QuestInfoRewardsFrame.RewardButtons[i]
			if not questItem:IsShown() then break end

			local point, relativeTo, relativePoint, _, y = questItem:GetPoint()
			if point and relativeTo and relativePoint then
				if i == 1 then
					questItem:SetPoint(point, relativeTo, relativePoint, 0, y)
				elseif relativePoint == "BOTTOMLEFT" then
					questItem:SetPoint(point, relativeTo, relativePoint, 0, -5)
				else
					questItem:SetPoint(point, relativeTo, relativePoint, 5, 0)
				end
			end

			questItem.Name:SetTextColor(1, 1, 1)
		end
	end)

	hooksecurefunc("QuestLogQuests_Update", function()
		for i = 6, QuestMapFrame.QuestsFrame.Contents:GetNumChildren() do
			local child = select(i, QuestMapFrame.QuestsFrame.Contents:GetChildren())
			if child and child.ButtonText and not child.Text then
				if not child.isSkinned then
					T.SkinExpandOrCollapse(child)
					child.isSkinned = true
				end
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)