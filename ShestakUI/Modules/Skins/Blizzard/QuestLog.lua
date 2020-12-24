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

	QuestLogPopupDetailFrameScrollFrame:StripTextures()
	QuestLogPopupDetailFrameScrollFrame:SetPoint("TOPLEFT", 13, -65)
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
	QuestLogPopupDetailFrame.TrackButton:SetWidth(110)
	QuestLogPopupDetailFrame.TrackButton:SetPoint("BOTTOMRIGHT", -4, 5)

	local function QuestObjectiveText()
		if not QuestInfoFrame.questLog then return end
		local numVisibleObjectives = 0
		local waypointText = C_QuestLog.GetNextWaypointText(C_QuestLog.GetSelectedQuest())
		if waypointText then
			numVisibleObjectives = numVisibleObjectives + 1
			QuestInfoObjectivesFrame.Objectives[numVisibleObjectives]:SetTextColor(0.5, 0.5, 0.5)
		end

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

	for _, name in next, {"HonorFrame", "MoneyFrame", "SkillPointFrame", "XPFrame", "ArtifactXPFrame", "TitleFrame", "WarModeBonusFrame"} do
		SkinReward(MapQuestInfoRewardsFrame[name], true)
	end

	for _, name in next, {"HonorFrame", "SkillPointFrame", "ArtifactXPFrame", "WarModeBonusFrame"} do
		SkinReward(QuestInfoRewardsFrame[name])
	end

	QuestInfoPlayerTitleFrame.FrameLeft:SetTexture()
	QuestInfoPlayerTitleFrame.FrameCenter:SetTexture()
	QuestInfoPlayerTitleFrame.FrameRight:SetTexture()
	QuestInfoPlayerTitleFrame.Icon:SkinIcon()

	hooksecurefunc("QuestInfo_GetRewardButton", function(rewardsFrame, index)
		local button = rewardsFrame.RewardButtons[index]
		if not button.backdrop then
			SkinReward(button, rewardsFrame == MapQuestInfoRewardsFrame)

			hooksecurefunc(button.IconBorder, "SetVertexColor", function(self, r, g, b)
				if r ~= 0.65882 and g ~= 0.65882 and b ~= 0.65882 then
					self:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
				else
					self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				end
				self:SetTexture("")
			end)

			hooksecurefunc(button.IconBorder, "Hide", function(self)
				self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end)
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
			local text = QuestInfoSealFrame.Text:GetText()
			if text and text:find("|cff042c54") then
				QuestInfoSealFrame.Text:SetText(string.gsub(text, "|cff042c54", "|cff1C86EE"))
			end
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
					followerReward.backdrop:SetPoint("TOPLEFT", 45, -5)
					followerReward.backdrop:SetPoint("BOTTOMRIGHT", 2, 5)
					followerReward.BG:Hide()
					followerReward.isSkinned = true

					followerReward.PortraitFrame:SetWidth(followerReward.PortraitFrame:GetHeight())
					followerReward.PortraitFrame:ClearAllPoints()
					followerReward.PortraitFrame:SetPoint("RIGHT", followerReward.backdrop, "LEFT", -2, 0)

					followerReward.PortraitFrame.PortraitRing:Hide()
					followerReward.PortraitFrame.PortraitRingQuality:SetTexture()
					followerReward.PortraitFrame.LevelBorder:SetAlpha(0)
					followerReward.PortraitFrame.Portrait:SetTexCoord(0.2, 0.85, 0.2, 0.85)

					local level = followerReward.PortraitFrame.Level
					level:ClearAllPoints()
					level:SetPoint("BOTTOM", followerReward.PortraitFrame, 0, 5)
					level:SetFontObject("SystemFont_Outline_Small")
					level:SetShadowOffset(0, 0)

					local squareBG = CreateFrame("Frame", nil, followerReward.PortraitFrame)
					squareBG:SetFrameLevel(followerReward.PortraitFrame:GetFrameLevel()-1)
					squareBG:SetPoint("TOPLEFT", 2, -2)
					squareBG:SetPoint("BOTTOMRIGHT", -2, 2)
					squareBG:SetTemplate("Default")
					followerReward.PortraitFrame.squareBG = squareBG

					followerReward.PortraitFrame.Portrait:SetPoint("TOPLEFT", squareBG, 2, -2)
					followerReward.PortraitFrame.Portrait:SetPoint("BOTTOMRIGHT", squareBG, -2, 2)

					-- AdventuresFollowerPortraitFrame
					local portrait = followerReward.AdventuresFollowerPortraitFrame
					portrait:SetWidth(portrait:GetHeight() - 2)
					portrait:ClearAllPoints()
					portrait:SetPoint("RIGHT", followerReward.backdrop, "LEFT", -2, 0)

					portrait.CircleMask:Hide()
					portrait.PuckBorder:Hide()
					portrait.LevelDisplayFrame.LevelCircle:SetAlpha(0)

					local level = portrait.LevelDisplayFrame.LevelText
					level:ClearAllPoints()
					level:SetPoint("BOTTOM", portrait, 0, 5)
					level:SetFontObject("SystemFont_Outline_Small")
					level:SetShadowOffset(0, 0)

					if not portrait.backdrop then
						portrait:CreateBackdrop("Default")
						portrait.backdrop:SetPoint("TOPLEFT", portrait, "TOPLEFT", -1, 1)
						portrait.backdrop:SetPoint("BOTTOMRIGHT", portrait, "BOTTOMRIGHT", 1, -1)
						portrait.backdrop:SetFrameLevel(portrait:GetFrameLevel())
					end

					portrait.Portrait:SetTexCoord(0.2, 0.85, 0.2, 0.85)
					portrait.Portrait:ClearAllPoints()
					portrait.Portrait:SetInside(portrait.backdrop, 3, 3)

					local point, relativeTo, relativePoint, _, yOfs = followerReward:GetPoint()
					followerReward:SetPoint(point, relativeTo, relativePoint, 8, yOfs)
				end
				local r, g, b = followerReward.PortraitFrame.PortraitRingQuality:GetVertexColor()
				if r > 0.99 and r < 1 then
					r, g, b = unpack(C.media.border_color)
				end
				followerReward.PortraitFrame.squareBG:SetBackdropBorderColor(r, g, b)
			end
			-- Spell Rewards
			for spellReward in rewardsFrame.spellRewardPool:EnumerateActive() do
				if not spellReward.isSkinned then
					SkinReward(spellReward)
					if not isMapQuest then
						local border = select(3, spellReward:GetRegions())
						border:Hide()

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
	QuestInfoItemHighlight:SetBackdropColor(1, 1, 1, 0.2)

	hooksecurefunc("QuestInfoItem_OnClick", function(self)
		if self.type == "choice" then
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

	QuestModelScene:StripTextures()
	QuestModelScene:CreateBackdrop("Overlay")
	QuestModelScene.backdrop:SetBackdropColor(C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha)
	QuestNPCModelNameTooltipFrame:CreateBackdrop("Overlay")
	QuestNPCModelNameTooltipFrame.backdrop:SetBackdropColor(C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha)
	QuestNPCModelNameTooltipFrame.backdrop:SetPoint("TOPLEFT", QuestModelScene.backdrop, "BOTTOMLEFT", 0, -3)
	QuestNPCModelNameTooltipFrame.backdrop:SetPoint("BOTTOMRIGHT", QuestNPCModelTextFrame, "BOTTOMRIGHT", 2, -1)
	QuestNPCModelNameText:SetPoint("TOPLEFT", QuestNPCModelNameplate, 15, -20)
	QuestNPCModelNameText:SetPoint("BOTTOMRIGHT", QuestNPCModelNameplate, -15, 7)
	QuestNPCModelTextFrame:SetHeight(85)
	QuestNPCModelTextFrame:StripTextures()
	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, _, _, _, _, x, y)
		if parentFrame == QuestLogPopupDetailFrame or parentFrame == QuestFrame then
			x = x + 8
			y = y + 40

			QuestModelScene.backdrop.overlay:Hide()
			QuestNPCModelNameTooltipFrame.backdrop.overlay:Hide()
		else
			QuestModelScene.backdrop.overlay:Show()
			QuestNPCModelNameTooltipFrame.backdrop.overlay:Show()
		end
		QuestModelScene:ClearAllPoints()
		QuestModelScene:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x, y)
	end)

	local function SkinExpandOrCollapse(f)
		local bg = CreateFrame("Frame", nil, f)
		bg:SetSize(13, 13)
		bg:SetPoint("TOPLEFT", f:GetNormalTexture(), 0, -1)
		bg:SetTemplate("Overlay")
		f.bg = bg

		bg.minus = bg:CreateTexture(nil, "OVERLAY")
		bg.minus:SetSize(5, 1)
		bg.minus:SetPoint("CENTER")
		bg.minus:SetTexture(C.media.blank)

		bg.plus = bg:CreateTexture(nil, "OVERLAY")
		bg.plus:SetSize(1, 5)
		bg.plus:SetPoint("CENTER")
		bg.plus:SetTexture(C.media.blank)
		bg.plus:Hide()

		hooksecurefunc(f, "SetNormalAtlas", function(self, texture)
			if self.settingTexture then return end
			self.settingTexture = true
			self:SetNormalTexture("")

			if texture and texture ~= "" then
				if texture:find("Closed") then
					self.bg.plus:Show()
				elseif texture:find("Open") then
					self.bg.plus:Hide()
				end
				self.bg:Show()
			else
				self.bg:Hide()
			end
			self.settingTexture = nil
		end)

		hooksecurefunc(f, "SetPushedAtlas", function(self)
			if self.settingTexture then return end
			self.settingTexture = true
			self:SetPushedTexture("")

			self.settingTexture = nil
		end)

		hooksecurefunc(f, "SetHighlightTexture", function(self, texture)
			if texture == "Interface\\Buttons\\UI-PlusButton-Hilight" then
				self:SetHighlightTexture("")
			end
		end)

		f:HookScript("OnEnter", function(self)
			self.bg:SetBackdropBorderColor(unpack(C.media.classborder_color))
			if self.bg.overlay then
				self.bg.overlay:SetVertexColor(C.media.classborder_color[1] * 0.3, C.media.classborder_color[2] * 0.3, C.media.classborder_color[3] * 0.3, 1)
			end
		end)

		f:HookScript("OnLeave", function(self)
			self.bg:SetBackdropBorderColor(unpack(C.media.border_color))
			if self.bg.overlay then
				self.bg.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
			end
		end)
	end

	local campaignColor = {
		Bastion = {0.45, 0.4, 0.4},
		Maldraxxus = {0.1, 0.3, 0.15},
		Ardenweald = {0.15, 0.25, 0.35},
		Revendreth = {0.25, 0.1, 0.1},
		Kyrian = {0.45, 0.4, 0.4},
		Necrolord = {0.1, 0.3, 0.15},
		Fey = {0.15, 0.25, 0.35},
		Venthyr = {0.25, 0.1, 0.1}
	}

	hooksecurefunc("QuestLogQuests_Update", function()
		for i = 1, QuestMapFrame.QuestsFrame.Contents:GetNumChildren() do
			local child = select(i, QuestMapFrame.QuestsFrame.Contents:GetChildren())
			if child and child.ButtonText and not child.Text then
				if not child.isSkinned then
					SkinExpandOrCollapse(child)
					child.isSkinned = true
				end
			end
		end
		for campaignHeader in QuestScrollFrame.campaignHeaderFramePool:EnumerateActive() do
			local campaign = campaignHeader:GetCampaign()
			if campaign then
				if not campaignHeader.backdrop then
					campaignHeader:CreateBackdrop("Overlay")
					campaignHeader.backdrop:SetPoint("TOPLEFT", campaignHeader.Background, 6, -2)
					campaignHeader.backdrop:SetPoint("BOTTOMRIGHT", campaignHeader.Background, -6, 10)

					campaignHeader.SelectedHighlight:SetAlpha(0)
					campaignHeader.HighlightTexture:SetAlpha(0)
					campaignHeader.Background:SetAlpha(0)
					campaignHeader.TopFiligree:Hide()
					SkinExpandOrCollapse(campaignHeader.CollapseButton)
				end
				if campaignHeader.backdrop then
					if campaignColor[campaign.uiTextureKit] then
						campaignHeader.backdrop.overlay:SetVertexColor(unpack(campaignColor[campaign.uiTextureKit]))
					else
						campaignHeader.backdrop.overlay:SetVertexColor(1, 1, 1, 0.2)
					end
				end
			end
		end
		for callingHeader in QuestScrollFrame.covenantCallingsHeaderFramePool:EnumerateActive() do
			if not callingHeader.backdrop then
				callingHeader:CreateBackdrop("Overlay")
				callingHeader.backdrop:SetPoint("TOPLEFT", callingHeader.Background, 7, -2)
				callingHeader.backdrop:SetPoint("BOTTOMRIGHT", callingHeader.Background, -5, 10)
				callingHeader.backdrop.overlay:SetVertexColor(1, 1, 1, 0.2)

				callingHeader.Background:SetAlpha(0)
				callingHeader.HighlightBackground:SetAlpha(0)
				callingHeader.SelectedTexture:SetAlpha(0)
				callingHeader.Divider:SetAlpha(0)
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)