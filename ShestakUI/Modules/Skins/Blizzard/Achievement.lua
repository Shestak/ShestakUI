local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AchievementUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frames = {
		"AchievementFrame",
		"AchievementFrameCategories",
		"AchievementFrameSummary",
		"AchievementFrameHeader",
		"AchievementFrameSummaryCategoriesHeader",
		"AchievementFrameSummaryAchievementsHeader",
		"AchievementFrameStatsBG",
		"AchievementFrameAchievements",
		"AchievementFrameComparison",
		"AchievementFrameComparisonHeader",
		"AchievementFrameComparisonSummaryPlayer",
		"AchievementFrameComparisonSummaryFriend"
	}

	for _, frame in pairs(frames) do
		_G[frame]:StripTextures(true)
	end

	local noname_frames = {
		"AchievementFrameStats",
		"AchievementFrameSummary",
		"AchievementFrameAchievements",
		"AchievementFrameComparison"
	}

	for _, frame in pairs(noname_frames) do
		for i = 1, _G[frame]:GetNumChildren() do
			local child = select(i, _G[frame]:GetChildren())
			if child and not child:GetName() then
				child:SetBackdrop(nil)
			end
		end
	end

	AchievementFrame:CreateBackdrop("Transparent")
	AchievementFrame.backdrop:Point("TOPLEFT", 0, 6)
	AchievementFrame.backdrop:SetPoint("BOTTOMRIGHT")
	AchievementFrameHeaderTitle:ClearAllPoints()
	AchievementFrameHeaderTitle:Point("TOPLEFT", AchievementFrame.backdrop, "TOPLEFT", -22, -8)
	AchievementFrameHeaderPoints:ClearAllPoints()
	AchievementFrameHeaderPoints:Point("LEFT", AchievementFrameHeaderTitle, "RIGHT", 2, 0)

	-- Backdrops
	AchievementFrameCategoriesContainer:CreateBackdrop("Overlay")
	AchievementFrameCategoriesContainer.backdrop:Point("TOPLEFT", 0, 4)
	AchievementFrameCategoriesContainer.backdrop:Point("BOTTOMRIGHT", -2, -3)
	AchievementFrameAchievementsContainer:CreateBackdrop("Overlay")
	AchievementFrameAchievementsContainer.backdrop:Point("TOPLEFT", -3, 2)
	AchievementFrameAchievementsContainer.backdrop:Point("BOTTOMRIGHT", -3, -3)
	AchievementFrameStatsContainer:CreateBackdrop("Overlay")
	AchievementFrameStatsContainer.backdrop:Point("TOPLEFT", -2, 2)
	AchievementFrameStatsContainer.backdrop:Point("BOTTOMRIGHT", -2, -3)
	AchievementFrameComparisonStatsContainer:CreateBackdrop("Overlay")
	AchievementFrameComparisonStatsContainer.backdrop:Point("TOPLEFT", -3, 2)
	AchievementFrameComparisonStatsContainer.backdrop:Point("BOTTOMRIGHT", -2, -3)

	T.SkinCloseButton(AchievementFrameCloseButton, AchievementFrame.backdrop)
	T.SkinDropDownBox(AchievementFrameFilterDropDown)
	AchievementFrameFilterDropDown:Point("TOPRIGHT", AchievementFrame, "TOPRIGHT", -44, 5)

	-- ScrollBars
	T.SkinScrollBar(AchievementFrameCategoriesContainerScrollBar)
	T.SkinScrollBar(AchievementFrameAchievementsContainerScrollBar)
	T.SkinScrollBar(AchievementFrameStatsContainerScrollBar)
	T.SkinScrollBar(AchievementFrameComparisonContainerScrollBar)
	T.SkinScrollBar(AchievementFrameComparisonStatsContainerScrollBar)

	-- Tabs
	for i = 1, 3 do
		T.SkinTab(_G["AchievementFrameTab"..i])
		_G["AchievementFrameTab"..i]:SetFrameLevel(_G["AchievementFrameTab"..i]:GetFrameLevel() + 2)
	end

	local function SkinStatusBar(bar)
		bar:StripTextures()
		bar:SetStatusBarTexture(C.media.texture)
		bar:SetStatusBarColor(0, 0.7, 0.1)
		bar:CreateBackdrop("Overlay")

		if _G[bar:GetName().."Title"] then
			_G[bar:GetName().."Title"]:SetPoint("LEFT", 4, 0)
		end

		if _G[bar:GetName().."Label"] then
			_G[bar:GetName().."Label"]:SetPoint("LEFT", 4, 0)
		end

		if _G[bar:GetName().."Text"] then
			_G[bar:GetName().."Text"]:SetPoint("RIGHT", -4, 0)
		end
	end

	SkinStatusBar(AchievementFrameSummaryCategoriesStatusBar)
	SkinStatusBar(AchievementFrameComparisonSummaryPlayerStatusBar)
	SkinStatusBar(AchievementFrameComparisonSummaryFriendStatusBar)
	AchievementFrameComparisonSummaryFriendStatusBar.text:ClearAllPoints()
	AchievementFrameComparisonSummaryFriendStatusBar.text:SetPoint("CENTER")
	AchievementFrameComparisonHeader:Point("BOTTOMRIGHT", AchievementFrameComparison, "TOPRIGHT", 45, -20)

	for i = 1, 8 do
		local frame = _G["AchievementFrameSummaryCategoriesCategory"..i]
		local button = _G["AchievementFrameSummaryCategoriesCategory"..i.."Button"]
		local highlight = _G["AchievementFrameSummaryCategoriesCategory"..i.."ButtonHighlight"]
		SkinStatusBar(frame)
		button:StripTextures()
		highlight:StripTextures()

		_G[highlight:GetName().."Middle"]:SetTexture(1, 1, 1, 0.3)
		_G[highlight:GetName().."Middle"]:SetAllPoints(frame)
	end

	AchievementFrame:HookScript("OnShow", function()
		for i = 1, 20 do
			local frame = _G["AchievementFrameCategoriesContainerButton"..i]
			local lastframe = _G["AchievementFrameCategoriesContainerButton"..i-1]

			frame:StripTextures()
			frame:StyleButton()
		end
	end)

	hooksecurefunc("AchievementFrameSummary_UpdateAchievements", function()
		for i = 1, ACHIEVEMENTUI_MAX_SUMMARY_ACHIEVEMENTS do
			local frame = _G["AchievementFrameSummaryAchievement"..i]
			_G["AchievementFrameSummaryAchievement"..i.."Highlight"]:Kill()
			frame:StripTextures()

			_G["AchievementFrameSummaryAchievement"..i.."Description"]:SetTextColor(0.6, 0.6, 0.6)

			if not frame.backdrop then
				frame:CreateBackdrop("Overlay", true)
				frame.backdrop:Point("TOPLEFT", 2, -2)
				frame.backdrop:Point("BOTTOMRIGHT", -2, 2)

				_G["AchievementFrameSummaryAchievement"..i.."IconBling"]:Kill()
				_G["AchievementFrameSummaryAchievement"..i.."IconOverlay"]:Kill()
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:SetTemplate("Default")
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:Height(_G["AchievementFrameSummaryAchievement"..i.."Icon"]:GetHeight() - 14)
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:Width(_G["AchievementFrameSummaryAchievement"..i.."Icon"]:GetWidth() - 14)
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:ClearAllPoints()
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:Point("LEFT", 6, 0)
				_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:ClearAllPoints()
				_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:Point("TOPLEFT", 2, -2)
				_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:Point("BOTTOMRIGHT", -2, 2)
			end
		end
	end)

	for i = 1, 7 do
		local frame = _G["AchievementFrameAchievementsContainerButton"..i]
		_G["AchievementFrameAchievementsContainerButton"..i.."Highlight"]:Kill()
		frame:StripTextures()
		frame.SetBackdropBorderColor = T.dummy

		-- Initiate method of creating a backdrop
		frame.bg1 = frame:CreateTexture(nil, "BACKGROUND")
		frame.bg1:SetDrawLayer("BACKGROUND", 4)
		frame.bg1:SetTexture(C.media.blank)
		frame.bg1:SetVertexColor(0.1, 0.1, 0.1)
		frame.bg1:Point("TOPLEFT", T.mult * 4, -T.mult * 4)
		frame.bg1:Point("BOTTOMRIGHT", -T.mult * 4, T.mult * 4)

		frame.bg2 = frame:CreateTexture(nil, "BACKGROUND")
		frame.bg2:SetDrawLayer("BACKGROUND", 3)
		frame.bg2:SetTexture(0, 0, 0)
		frame.bg2:Point("TOPLEFT", T.mult * 3, -T.mult * 3)
		frame.bg2:Point("BOTTOMRIGHT", -T.mult * 3, T.mult * 3)

		frame.bg3 = frame:CreateTexture(nil, "BACKGROUND")
		frame.bg3:SetDrawLayer("BACKGROUND", 2)
		frame.bg3:SetTexture(unpack(C.media.border_color))
		frame.bg3:Point("TOPLEFT", T.mult * 2, -T.mult * 2)
		frame.bg3:Point("BOTTOMRIGHT", -T.mult * 2, T.mult * 2)

		frame.bg4 = frame:CreateTexture(nil, "BACKGROUND")
		frame.bg4:SetDrawLayer("BACKGROUND", 1)
		frame.bg4:SetTexture(0, 0, 0)
		frame.bg4:Point("TOPLEFT", T.mult, -T.mult)
		frame.bg4:Point("BOTTOMRIGHT", -T.mult, T.mult)

		_G["AchievementFrameAchievementsContainerButton"..i.."Description"]:SetTextColor(0.6, 0.6, 0.6)
		_G["AchievementFrameAchievementsContainerButton"..i.."Description"].SetTextColor = T.dummy
		_G["AchievementFrameAchievementsContainerButton"..i.."HiddenDescription"]:SetTextColor(1, 1, 1)
		_G["AchievementFrameAchievementsContainerButton"..i.."HiddenDescription"].SetTextColor = T.dummy

		_G["AchievementFrameAchievementsContainerButton"..i.."IconBling"]:Kill()
		_G["AchievementFrameAchievementsContainerButton"..i.."IconOverlay"]:Kill()
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:SetTemplate("Default")
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:Height(_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:GetHeight() - 14)
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:Width(_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:GetWidth() - 14)
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:ClearAllPoints()
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:Point("LEFT", 6, 0)
		_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:ClearAllPoints()
		_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:Point("TOPLEFT", 2, -2)
		_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:Point("BOTTOMRIGHT", -2, 2)

		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:StripTextures()
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:SetTemplate("Default")
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:Size(12)
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:GetCheckedTexture():Point("TOPLEFT", -4, 4)
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:GetCheckedTexture():Point("BOTTOMRIGHT", 4, -4)

		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:ClearAllPoints()
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:Point("BOTTOMLEFT", frame, "BOTTOMLEFT", 5, 5)

		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"].ClearAllPoints = T.dummy
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"].SetPoint = T.dummy
	end

	local compares = {
		"Player",
		"Friend"
	}

	for _, compare in pairs(compares) do
		for i = 1, 9 do
			local frame = "AchievementFrameComparisonContainerButton"..i..compare

			_G[frame]:StripTextures()
			_G[frame.."Background"]:Kill()

			_G[frame]:CreateBackdrop("Overlay", true)
			_G[frame].backdrop:Point("TOPLEFT", 2, -2)
			_G[frame].backdrop:Point("BOTTOMRIGHT", -2, 2)
			_G[frame].SetBackdropBorderColor = T.dummy

			if _G[frame.."Description"] then
				_G[frame.."Description"]:SetTextColor(0.6, 0.6, 0.6)
				_G[frame.."Description"].SetTextColor = T.dummy
				_G[frame.."Description"]:SetParent(_G[frame].backdrop)
			end

			_G[frame.."Icon"]:SetParent(_G[frame].backdrop)
			_G[frame.."Shield"]:SetParent(_G[frame].backdrop)

			if compare == "Friend" then
				_G[frame.."Shield"]:Point("TOPRIGHT", _G["AchievementFrameComparisonContainerButton"..i.."Friend"], "TOPRIGHT", -20, -9)
			end

			if _G[frame.."Label"] then
				_G[frame.."Label"]:SetParent(_G[frame].backdrop)
			end

			_G[frame.."IconBling"]:Kill()
			_G[frame.."IconOverlay"]:Kill()
			_G[frame.."Icon"]:SetTemplate("Default")
			_G[frame.."Icon"]:Height(_G[frame.."Icon"]:GetHeight() - 14)
			_G[frame.."Icon"]:Width(_G[frame.."Icon"]:GetWidth() - 14)
			_G[frame.."Icon"]:ClearAllPoints()
			_G[frame.."Icon"]:Point("LEFT", 6, 0)
			_G[frame.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G[frame.."IconTexture"]:ClearAllPoints()
			_G[frame.."IconTexture"]:Point("TOPLEFT", 2, -2)
			_G[frame.."IconTexture"]:Point("BOTTOMRIGHT", -2, 2)
		end
	end

	for i = 1, 20 do
		local frame = _G["AchievementFrameStatsContainerButton"..i]
		frame:StyleButton()

		_G["AchievementFrameStatsContainerButton"..i.."BG"]:SetTexture(1, 1, 1, 0.2)
		_G["AchievementFrameStatsContainerButton"..i.."HeaderLeft"]:Kill()
		_G["AchievementFrameStatsContainerButton"..i.."HeaderRight"]:Kill()
		_G["AchievementFrameStatsContainerButton"..i.."HeaderMiddle"]:Kill()

		local frame = "AchievementFrameComparisonStatsContainerButton"..i
		_G[frame]:StripTextures()
		_G[frame]:StyleButton()

		_G[frame.."BG"]:SetTexture(1, 1, 1, 0.2)
		_G[frame.."HeaderLeft"]:Kill()
		_G[frame.."HeaderRight"]:Kill()
		_G[frame.."HeaderMiddle"]:Kill()
	end

	hooksecurefunc("AchievementButton_GetProgressBar", function(index)
		local frame = _G["AchievementFrameProgressBar"..index]
		if frame then
			if not frame.skinned then
				frame:StripTextures()
				frame:SetStatusBarTexture(C.media.texture)
				frame:SetStatusBarColor(0, 0.7, 0.1)
				frame:SetFrameLevel(frame:GetFrameLevel() + 3)
				frame:Height(frame:GetHeight() - 2)

				frame.bg1 = frame:CreateTexture(nil, "BACKGROUND")
				frame.bg1:SetDrawLayer("BACKGROUND", -7)
				frame.bg1:SetTexture(unpack(C.media.backdrop_color))
				frame.bg1:Point("TOPLEFT", -T.mult * 3, T.mult * 3)
				frame.bg1:Point("BOTTOMRIGHT", T.mult * 3, -T.mult * 3)

				frame.bg2 = frame:CreateTexture(nil, "BACKGROUND")
				frame.bg2:SetDrawLayer("BACKGROUND", -6)
				frame.bg2:SetTexture(unpack(C.media.border_color))
				frame.bg2:Point("TOPLEFT", -T.mult * 2, T.mult * 2)
				frame.bg2:Point("BOTTOMRIGHT", T.mult * 2, -T.mult * 2)

				frame.bg3 = frame:CreateTexture(nil, "BACKGROUND")
				frame.bg3:SetDrawLayer("BACKGROUND", -5)
				frame.bg3:SetTexture(unpack(C.media.backdrop_color))
				frame.bg3:Point("TOPLEFT", -T.mult, T.mult)
				frame.bg3:Point("BOTTOMRIGHT", T.mult, -T.mult)

				frame.text:ClearAllPoints()
				frame.text:SetPoint("CENTER", frame, "CENTER", 0, -1)
				frame.text:SetJustifyH("CENTER")

				if index > 1 then
					frame:ClearAllPoints()
					frame:Point("TOP", _G["AchievementFrameProgressBar"..index-1], "BOTTOM", 0, -5)
					frame.SetPoint = T.dummy
					frame.ClearAllPoints = T.dummy
				end

				frame.skinned = true
			end
		end
	end)

	hooksecurefunc("AchievementObjectives_DisplayCriteria", function(objectivesFrame, id)
		local numCriteria = GetAchievementNumCriteria(id)
		local textStrings, metas = 0, 0
		for i = 1, numCriteria do
			local _, criteriaType, completed, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)

			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then
				metas = metas + 1
				local metaCriteria = AchievementButton_GetMeta(metas)
				if objectivesFrame.completed and completed then
					metaCriteria.label:SetTextColor(1, 1, 1, 1)
					metaCriteria.label:SetShadowOffset(0, 0)
				elseif completed then
					metaCriteria.label:SetTextColor(0, 1, 0, 1)
					metaCriteria.label:SetShadowOffset(1, -1)
				else
					metaCriteria.label:SetTextColor(0.6, 0.6, 0.6, 1)
					metaCriteria.label:SetShadowOffset(1, -1)
				end
			elseif criteriaType ~= 1 then
				textStrings = textStrings + 1
				local criteria = AchievementButton_GetCriteria(textStrings)
				if objectivesFrame.completed and completed then
					criteria.name:SetTextColor(1, 1, 1, 1)
					criteria.name:SetShadowOffset(0, 0)
				elseif completed then
					criteria.name:SetTextColor(0, 1, 0, 1)
					criteria.name:SetShadowOffset(1, -1)
				else
					criteria.name:SetTextColor(0.6, 0.6, 0.6, 1)
					criteria.name:SetShadowOffset(1, -1)
				end
			end
		end
	end)
end

T.SkinFuncs["Blizzard_AchievementUI"] = LoadSkin