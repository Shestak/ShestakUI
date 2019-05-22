local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return else return end -- incomplete

----------------------------------------------------------------------------------------
--	QuestLog skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local QuestStrip = {
		"QuestFrame",
		"QuestLogFrame",
		"QuestLogQuestCount",
		"EmptyQuestLogFrame"
	}

	for _, object in pairs(QuestStrip) do
		_G[object]:StripTextures(true)
	end

	local QuestButtons = {
		"QuestLogFrameAbandonButton",
		"QuestFrameExitButton",
		"QuestFramePushQuestButton",
		"QuestFrameCompleteButton",
		"QuestFrameGoodbyeButton",
		"QuestFrameCompleteQuestButton",
		"QuestFrameCancelButton",
		"QuestFrameAcceptButton",
		"QuestFrameDeclineButton"
	}

	for _, button in pairs(QuestButtons) do
		_G[button]:StripTextures()
		_G[button]:SkinButton()
	end

	local questItems = {
		"QuestLogItem",
		-- "QuestDetailItem",
		-- "QuestRewardItem"
	}

	for _, frame in pairs(questItems) do
		for i = 1, MAX_NUM_ITEMS do
			local item = _G[frame..i]
			local icon = _G[frame..i.."IconTexture"]
			local count = _G[frame..i.."Count"]

			item:StripTextures()
			item:SetTemplate("Default")
			item:StyleButton()
			item:SetSize(143, 40)
			item:SetFrameLevel(item:GetFrameLevel() + 2)

			icon:SetSize(32, 32)
			icon:SetDrawLayer("OVERLAY")
			icon:SetPoint("TOPLEFT", 4, -4)
			-- T.SkinIcon(icon)

			-- count:SetParent(item.backdrop)
			count:SetDrawLayer("OVERLAY")
		end
	end

	local questHonorFrames = {
		-- "QuestLogHonorFrame",
		-- "QuestDetailHonorFrame",
		-- "QuestRewardHonorFrame"
	}

	for _, frame in pairs(questHonorFrames) do
		local honor = _G[frame]
		local icon = _G[frame.."Icon"]
		local points = _G[frame.."Points"]
		local text = _G[frame.."HonorReceiveText"]

		honor:SetTemplate("Default")
		honor:SetSize(143, 40)

		icon.backdrop = CreateFrame("Frame", nil, honor)
		icon.backdrop:SetFrameLevel(honor:GetFrameLevel() - 1)
		icon.backdrop:SetTemplate("Default")
		icon.backdrop:SetOutside(icon)

		icon:SetTexture("Interface\\PVPFrame\\PVP-Currency-"..T.faction)
		icon.SetTexture = T.dummy
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetDrawLayer("OVERLAY")
		icon:SetSize(38, 38)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 1, -1)
		icon:SetParent(icon.backdrop)

		points:ClearAllPoints()
		points:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -2, 2)
		points:SetParent(icon.backdrop)
		points:SetDrawLayer("OVERLAY")
		-- points:FontTemplate(nil, nil, "OUTLINE")

		text:SetPoint("LEFT", honor, "LEFT", 44, 0)
		text:SetText(HONOR_POINTS)
	end

	local function QuestQualityColors(frame, text, quality, link)
		if link and not quality then
			quality = select(3, GetItemInfo(link))
		end

		if quality then
			if frame then
				frame:SetBackdropBorderColor(GetItemQualityColor(quality))
				-- frame.backdrop:SetBackdropBorderColor(GetItemQualityColor(quality))
			end
			text:SetTextColor(GetItemQualityColor(quality))
		else
			if frame then
				frame:SetBackdropBorderColor(unpack(C.media.backdrop_color))
				-- frame.backdrop:SetBackdropBorderColor(unpack(C.media.backdrop_color))
			end
			text:SetTextColor(1, 1, 1)
		end
	end

	-- QuestRewardItemHighlight:StripTextures()
	-- QuestRewardItemHighlight:SetTemplate("Default", nil, true)
	-- QuestRewardItemHighlight:SetBackdropBorderColor(1, 1, 0)
	-- QuestRewardItemHighlight:SetBackdropColor(0, 0, 0, 0)
	-- QuestRewardItemHighlight:SetSize(142, 40)

	hooksecurefunc("QuestRewardItem_OnClick", function()
		QuestRewardItemHighlight:ClearAllPoints();
		QuestRewardItemHighlight:SetOutside(this:GetName().."IconTexture")
		_G[this:GetName().."Name"]:SetTextColor(1, 1, 0)

		for i = 1, MAX_NUM_ITEMS do
			local questItem = _G["QuestRewardItem"..i]
			local questName = _G["QuestRewardItem"..i.."Name"]
			local link = questItem.type and GetQuestItemLink(questItem.type, questItem:GetID())

			if questItem ~= this then
				QuestQualityColors(nil, questName, nil, link)
			end
		end
	end)

	local function QuestObjectiveTextColor()
		local numObjectives = GetNumQuestLeaderBoards()
		local objective
		local _, type, finished
		local numVisibleObjectives = 0
		for i = 1, numObjectives do
			_, type, finished = GetQuestLogLeaderBoard(i)
			if type ~= "spell" then
				numVisibleObjectives = numVisibleObjectives + 1
				objective = _G["QuestLogObjective"..numVisibleObjectives]
				if finished then
					objective:SetTextColor(1, 0.80, 0.10)
				else
					objective:SetTextColor(0.6, 0.6, 0.6)
				end
			end
		end
	end

	hooksecurefunc("QuestLog_UpdateQuestDetails", function()
		local requiredMoney = GetQuestLogRequiredMoney()
		if requiredMoney > 0 then
			if requiredMoney > GetMoney() then
				QuestLogRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
			else
				QuestLogRequiredMoneyText:SetTextColor(1, 0.80, 0.10)
			end
		end
	end)

	hooksecurefunc("QuestFrameItems_Update", function(questState)
		local titleTextColor = {1, 0.80, 0.10}
		local textColor = {1, 1, 1}

		QuestTitleText:SetTextColor(unpack(titleTextColor))
		QuestTitleFont:SetTextColor(unpack(titleTextColor))
		QuestFont:SetTextColor(unpack(textColor))
		QuestFontNormalSmall:SetTextColor(unpack(textColor))
		QuestDescription:SetTextColor(unpack(textColor))
		QuestObjectiveText:SetTextColor(unpack(textColor))

		QuestDetailObjectiveTitleText:SetTextColor(unpack(titleTextColor))
		QuestDetailRewardTitleText:SetTextColor(unpack(titleTextColor))
		QuestDetailItemReceiveText:SetTextColor(unpack(textColor))
		QuestDetailSpellLearnText:SetTextColor(unpack(textColor))
		QuestDetailItemChooseText:SetTextColor(unpack(textColor))

		QuestLogDescriptionTitle:SetTextColor(unpack(titleTextColor))
		QuestLogQuestTitle:SetTextColor(unpack(titleTextColor))
		QuestLogPlayerTitleText:SetTextColor(unpack(titleTextColor))
		QuestLogRewardTitleText:SetTextColor(unpack(titleTextColor))
		QuestLogObjectivesText:SetTextColor(unpack(textColor))
		QuestLogQuestDescription:SetTextColor(unpack(textColor))
		QuestLogItemChooseText:SetTextColor(unpack(textColor))
		QuestLogItemReceiveText:SetTextColor(unpack(textColor))
		QuestLogSpellLearnText:SetTextColor(unpack(textColor))

		QuestRewardRewardTitleText:SetTextColor(unpack(titleTextColor))
		QuestRewardTitleText:SetTextColor(unpack(titleTextColor))
		QuestRewardItemChooseText:SetTextColor(unpack(textColor))
		QuestRewardItemReceiveText:SetTextColor(unpack(textColor))
		QuestRewardSpellLearnText:SetTextColor(unpack(textColor))
		QuestRewardText:SetTextColor(unpack(textColor))

		if GetQuestLogRequiredMoney() > 0 then
			if GetQuestLogRequiredMoney() > GetMoney() then
				QuestLogRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
			else
				QuestLogRequiredMoneyText:titleTextColor(unpack(textColor))
			end
		end

		QuestObjectiveTextColor()

		local numQuestRewards, numQuestChoices
		if questState == "QuestLog" then
			numQuestRewards, numQuestChoices = GetNumQuestLogRewards(), GetNumQuestLogChoices()
		else
			numQuestRewards, numQuestChoices = GetNumQuestRewards(), GetNumQuestChoices()
		end

		local rewardsCount = numQuestChoices + numQuestRewards
		if rewardsCount > 0 then
			local questItem, itemName, link
			local questItemName = questState.."Item"

			for i = 1, rewardsCount do
				questItem = _G[questItemName..i]
				itemName = _G[questItemName..i.."Name"]
				link = questItem.type and (questState == "QuestLog" and GetQuestLogItemLink or GetQuestItemLink)(questItem.type, questItem:GetID())

				QuestQualityColors(questItem, itemName, nil, link)
			end
		end
	end)

	QuestLogTimerText:SetTextColor(1, 1, 1)

	QuestLogFrame:SetAttribute("UIPanelLayout-width", T.Scale(685))
	QuestLogFrame:SetAttribute("UIPanelLayout-height", T.Scale(490))
	QuestLogFrame:SetSize(685, 490)
	QuestLogFrame:CreateBackdrop("Transparent")
	QuestLogFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	QuestLogFrame.backdrop:SetPoint("BOTTOMRIGHT", -1, 8)

	QuestLogTitleText:ClearAllPoints()
	QuestLogTitleText:SetPoint("TOP", QuestLogFrame.backdrop, "TOP", 0, -6)

	QuestDetailScrollFrame:SetHeight(400)
	QuestRewardScrollFrame:SetHeight(400)
	QuestProgressScrollFrame:SetHeight(400)

	QuestLogListScrollFrame:StripTextures()
	QuestLogListScrollFrame:CreateBackdrop("Default", true)
	QuestLogListScrollFrame.backdrop:SetPoint("TOPLEFT", 0, 2)
	QuestLogListScrollFrame:SetSize(305, 375)

	QuestLogDetailScrollFrame:StripTextures()
	QuestLogDetailScrollFrame:CreateBackdrop("Default", true)
	QuestLogDetailScrollFrame.backdrop:SetPoint("TOPLEFT", -4, 2)
	QuestLogDetailScrollFrame:SetSize(300, 375)
	QuestLogDetailScrollFrame:ClearAllPoints()
	QuestLogDetailScrollFrame:SetPoint("TOPRIGHT", QuestLogFrame, -32, -75)

	QuestLogNoQuestsText:ClearAllPoints()
	QuestLogNoQuestsText:SetPoint("CENTER", EmptyQuestLogFrame, "CENTER", -45, 65)

	QuestLogFrameAbandonButton:SetPoint("BOTTOMLEFT", 18, 15)
	QuestLogFrameAbandonButton:SetWidth(101)
	QuestLogFrameAbandonButton:SetText(ABANDON_QUEST)

	QuestFramePushQuestButton:ClearAllPoints()
	QuestFramePushQuestButton:SetPoint("LEFT", QuestLogFrameAbandonButton, "RIGHT", 2, 0)
	QuestFramePushQuestButton:SetWidth(101)
	QuestFramePushQuestButton:SetText(SHARE_QUEST)

	QuestFrameExitButton:SetPoint("BOTTOMRIGHT", -31, 15)
	QuestFrameExitButton:SetWidth(100)

	QuestFrameAcceptButton:SetPoint("BOTTOMLEFT", 20, 4)
	QuestFrameDeclineButton:SetPoint("BOTTOMRIGHT", -37, 4)
	QuestFrameCompleteButton:SetPoint("BOTTOMLEFT", 20, 4)
	QuestFrameGoodbyeButton:SetPoint("BOTTOMRIGHT", -37, 4)
	QuestFrameCompleteQuestButton:SetPoint("BOTTOMLEFT", 20, 4)
	QuestFrameCancelButton:SetPoint("BOTTOMRIGHT", -37, 4)

	QuestFrameNpcNameText:SetPoint("CENTER", QuestNpcNameFrame, "CENTER", -1, 0)

	T.SkinScrollBar(QuestLogDetailScrollFrameScrollBar)
	T.SkinScrollBar(QuestDetailScrollFrameScrollBar)
	T.SkinScrollBar(QuestLogListScrollFrameScrollBar)
	QuestLogListScrollFrameScrollBar:SetPoint("TOPLEFT", QuestLogListScrollFrame, "TOPRIGHT", 5, -16)
	T.SkinScrollBar(QuestProgressScrollFrameScrollBar)
	T.SkinScrollBar(QuestRewardScrollFrameScrollBar)

	T.SkinCloseButton(QuestFrameCloseButton, QuestFrame.backdrop)

	T.SkinCloseButton(QuestLogFrameCloseButton)
	QuestLogFrameCloseButton:ClearAllPoints()
	QuestLogFrameCloseButton:SetPoint("TOPRIGHT", -5, -16)

	QuestLogTrack:Hide()

	local QuestTrack = CreateFrame("Button", "QuestTrack", QuestLogFrame, "UIPanelButtonTemplate")
	QuestTrack:SkinButton()
	QuestTrack:SetPoint("LEFT", QuestFramePushQuestButton, "RIGHT", 2, 0)
	QuestTrack:SetSize(101, 21)
	QuestTrack:SetText(TRACK_QUEST)

	QuestTrack:HookScript("OnClick", function()
		if IsQuestWatched(GetQuestLogSelection()) then
			RemoveQuestWatch(GetQuestLogSelection())

			QuestWatch_Update()
		else
			if GetNumQuestLeaderBoards(GetQuestLogSelection()) == 0 then
				UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0)
				return
			end

			if GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS then
				UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0)
				return
			end

			AddQuestWatch(GetQuestLogSelection())

			QuestLog_Update()
			QuestWatch_Update()
		end

		QuestLog_Update()
	end)

	hooksecurefunc("QuestLog_Update", function()
		local numEntries = GetNumQuestLogEntries()
		if numEntries == 0 then
			QuestTrack:Disable()
		else
			QuestTrack:Enable()
		end

		QuestLogListScrollFrame:Show()
	end)

	for i = 1, MAX_REQUIRED_ITEMS do
		local item = _G["QuestProgressItem"..i]
		local icon = _G["QuestProgressItem"..i.."IconTexture"]
		local count = _G["QuestProgressItem"..i.."Count"]

		item:StripTextures()
		item:SetTemplate("Default")
		item:StyleButton()
		item:SetSize(143, 40)
		item:SetFrameLevel(item:GetFrameLevel() + 2)

		icon:SetSize(38, 38)
		icon:SetDrawLayer("OVERLAY")
		icon:SetPoint("TOPLEFT", 1, -1)
		-- T.SkinIcon(icon)

		-- count:SetParent(item.backdrop)
		count:SetDrawLayer("OVERLAY")
	end

	hooksecurefunc("QuestFrameProgressItems_Update", function()
		QuestProgressTitleText:SetTextColor(1, 0.80, 0.10)
		QuestProgressText:SetTextColor(1, 1, 1)
		QuestProgressRequiredItemsText:SetTextColor(1, 0.80, 0.10)

		if GetQuestMoneyToGet() > 0 then
			if GetQuestMoneyToGet() > GetMoney() then
				QuestProgressRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
			else
				QuestProgressRequiredMoneyText:SetTextColor(1, 0.80, 0.10)
			end
		end

		for i = 1, MAX_REQUIRED_ITEMS do
			local item = _G["QuestProgressItem"..i]
			local name = _G["QuestProgressItem"..i.."Name"]
			local link = item.type and GetQuestItemLink(item.type, item:GetID())

			QuestQualityColors(item, name, nil, link)
		end
	end)

	QUESTS_DISPLAYED = 25

	for i = 7, 25 do
		local questLogTitle = CreateFrame("Button", "QuestLogTitle"..i, QuestLogFrame, "QuestLogTitleButtonTemplate")

		questLogTitle:SetID(i)
		questLogTitle:Hide()
		questLogTitle:SetPoint("TOPLEFT", _G["QuestLogTitle"..i - 1], "BOTTOMLEFT", 0, 1)
	end

	for i = 1, QUESTS_DISPLAYED do
		local questLogTitle = _G["QuestLogTitle"..i]
		local highlight = _G["QuestLogTitle"..i.."Highlight"]

		-- questLogTitle:SetNormalTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\PlusMinusButton")
		-- questLogTitle.SetNormalTexture = T.dummy
		questLogTitle:GetNormalTexture():SetSize(14, 14)
		questLogTitle:GetNormalTexture():SetPoint("LEFT", 3, 0)

		highlight:SetTexture("")
		highlight.SetTexture = T.dummy

		hooksecurefunc(questLogTitle, "SetNormalTexture", function(self, texture)
			if string.find(texture, "MinusButton") then
				self:GetNormalTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
			elseif string.find(texture, "PlusButton") then
				self:GetNormalTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
			else
				self:GetNormalTexture():SetTexCoord(0, 0, 0, 0)
 			end
		end)
	end

	-- QuestLogCollapseAllButton:StripTextures()
	QuestLogCollapseAllButton:SetPoint("TOPLEFT", -51, -2)

	-- QuestLogCollapseAllButton:SetNormalTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\PlusMinusButton")
	QuestLogCollapseAllButton.SetNormalTexture = T.dummy
	QuestLogCollapseAllButton:GetNormalTexture():SetSize(15, 15)

	QuestLogCollapseAllButton:SetHighlightTexture("")
	QuestLogCollapseAllButton.SetHighlightTexture = T.dummy

	-- QuestLogCollapseAllButton:SetDisabledTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\PlusMinusButton")
	-- QuestLogCollapseAllButton.SetDisabledTexture = T.dummy
	-- QuestLogCollapseAllButton:GetDisabledTexture():SetSize(15, 15)
	-- QuestLogCollapseAllButton:GetDisabledTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
	-- QuestLogCollapseAllButton:GetDisabledTexture():SetDesaturated(true)

	hooksecurefunc(QuestLogCollapseAllButton, "SetNormalTexture", function(self, texture)
		if string.find(texture, "MinusButton") then
			self:GetNormalTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
		elseif string.find(texture, "PlusButton") then
			self:GetNormalTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
		else
			self:GetNormalTexture():SetTexCoord(0, 0, 0, 0)
 		end
	end)

	-- Quest Watch
	hooksecurefunc("QuestWatch_Update", function()
		local questIndex, numObjectives, objectivesCompleted
		local _, finished
		local text, title, level, color, hex
		local watchText
		local watchTextIndex = 1

		for i = 1, GetNumQuestWatches() do
			questIndex = GetQuestIndexForWatch(i)
			if questIndex then
				numObjectives = GetNumQuestLeaderBoards(questIndex)
				title, level = GetQuestLogTitle(questIndex)
				color = GetQuestDifficultyColor(level)
				hex = T.RGBToHex(color.r, color.g, color.b)
				text = hex.."["..level.."] "..title

				if numObjectives > 0 then
					watchText = _G["QuestWatchLine"..watchTextIndex]
					watchText:SetText(text)

					watchTextIndex = watchTextIndex + 1
					objectivesCompleted = 0

					for j = 1, numObjectives do
						_, _, finished = GetQuestLogLeaderBoard(j, questIndex)
						watchText = _G["QuestWatchLine"..watchTextIndex]

						if finished then
							watchText:SetTextColor(0, 1, 0)
							objectivesCompleted = objectivesCompleted + 1
						else
							watchText:SetTextColor(0.8, 0.8, 0.8)
						end

						watchTextIndex = watchTextIndex + 1
					end
				end
			end
		end
	end)
end

table.insert(T.SkinFuncs["ShestakUI"], LoadSkin)