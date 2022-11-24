local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AchievementUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frames = {
		"AchievementFrame",
		"AchievementFrameCategories",
		"AchievementFrameSummary",
		"AchievementFrameSummaryCategoriesHeader",
		"AchievementFrameSummaryAchievementsHeader",
		"AchievementFrameStatsBG",
		"AchievementFrameAchievements",
		"AchievementFrameComparison",
		"AchievementFrameComparisonHeader",
	}

	for _, frame in pairs(frames) do
		_G[frame]:StripTextures(true)
	end

	AchievementFrame.Header:StripTextures(true)

	select(3, _G.AchievementFrameAchievements:GetChildren()):Hide()
	_G.AchievementFrameSummary:GetChildren():Hide()

	AchievementFrame:CreateBackdrop("Transparent")
	AchievementFrame.backdrop:SetPoint("TOPLEFT", 0, 7)
	AchievementFrame.backdrop:SetPoint("BOTTOMRIGHT")
	AchievementFrame.Header.Title:ClearAllPoints()
	AchievementFrame.Header.Title:SetPoint("TOPLEFT", AchievementFrame.backdrop, "TOPLEFT", -22, -8)
	AchievementFrame.Header.Points:ClearAllPoints()
	AchievementFrame.Header.Points:SetPoint("LEFT", AchievementFrame.Header.Title, "RIGHT", -2, 0)

	-- Backdrops
	AchievementFrameCategories:CreateBackdrop("Overlay")
	AchievementFrameCategories.backdrop:SetPoint("TOPLEFT", 0, 4)
	AchievementFrameCategories.backdrop:SetPoint("BOTTOMRIGHT", -2, -3)
	AchievementFrameSummary:CreateBackdrop("Overlay")
	AchievementFrameSummary.backdrop:SetPoint("TOPLEFT", -3, 0)
	AchievementFrameSummary.backdrop:SetPoint("BOTTOMRIGHT", -3, -3)
	AchievementFrameStats:CreateBackdrop("Overlay")
	AchievementFrameStats.backdrop:SetPoint("TOPLEFT", 2, 0)
	AchievementFrameStats.backdrop:SetPoint("BOTTOMRIGHT", -2, -3)
	AchievementFrameComparison.StatContainer:CreateBackdrop("Overlay")
	AchievementFrameComparison.StatContainer.backdrop:SetPoint("TOPLEFT", 2, 0)
	AchievementFrameComparison.StatContainer.backdrop:SetPoint("BOTTOMRIGHT", 1, -3)

	T.SkinCloseButton(AchievementFrameCloseButton, AchievementFrame.backdrop)
	T.SkinDropDownBox(AchievementFrameFilterDropDown)
	AchievementFrameFilterDropDown:ClearAllPoints()
	AchievementFrameFilterDropDown:SetPoint("TOPLEFT", AchievementFrameAchievements, "TOPLEFT", -19, 24)

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function()
		if not IsAddOnLoaded("Overachiever") then return end
		AchievementFrameFilterDropDownButton:SetWidth(17)
		AchievementFrameFilterDropDown:ClearAllPoints()
		AchievementFrameFilterDropDown:SetPoint("TOPLEFT", AchievementFrameAchievements, "TOPLEFT", -19, 24)
	end)

	T.SkinEditBox(AchievementFrame.SearchBox)
	AchievementFrame.SearchBox:SetHeight(15)
	AchievementFrame.SearchBox:ClearAllPoints()
	AchievementFrame.SearchBox:SetPoint("TOPRIGHT", AchievementFrame, "TOPRIGHT", -51, 0)

	AchievementFrame.SearchPreviewContainer:StripTextures()
	AchievementFrame.SearchPreviewContainer:CreateBackdrop("Transparent")
	AchievementFrame.SearchPreviewContainer.backdrop:SetPoint("TOPLEFT", -2, 2)
	AchievementFrame.SearchPreviewContainer.backdrop:SetPoint("BOTTOMRIGHT", AchievementFrame.SearchPreviewContainer.ShowAllSearchResults, 2, -2)

	AchievementFrame.SearchResults:StripTextures()
	AchievementFrame.SearchResults:SetTemplate("Transparent")
	T.SkinCloseButton(AchievementFrame.SearchResults.CloseButton)

	-- ScrollBars
	T.SkinScrollBar(AchievementFrameCategories.ScrollBar)
	T.SkinScrollBar(AchievementFrameAchievements.ScrollBar)
	T.SkinScrollBar(AchievementFrameStats.ScrollBar)
	T.SkinScrollBar(AchievementFrameComparison.AchievementContainer.ScrollBar)
	T.SkinScrollBar(AchievementFrameComparison.StatContainer.ScrollBar)
	T.SkinScrollBar(AchievementFrame.SearchResults.ScrollBar)

	AchievementFrameCategories.ScrollBar:SetPoint("TOPLEFT", AchievementFrameCategories, "TOPRIGHT", -1, 3)
	AchievementFrameCategories.ScrollBar:SetPoint("BOTTOMLEFT", AchievementFrameCategories, "BOTTOMRIGHT", -1, -7)

	-- Tabs
	for i = 1, 3 do
		T.SkinTab(_G["AchievementFrameTab"..i])
		_G["AchievementFrameTab"..i]:SetFrameLevel(_G["AchievementFrameTab"..i]:GetFrameLevel() + 2)
	end

	local function SkinStatusBar(bar, comparison)
		bar:StripTextures()
		bar:SetStatusBarTexture(C.media.texture)
		bar:SetStatusBarColor(0, 0.7, 0.1)
		bar:CreateBackdrop("Overlay")

		if comparison then
			local title = bar.Title
			local text = bar.Text

			if title then
				title:SetPoint("LEFT", 4, 0)
			end

			if text then
				text:SetPoint("CENTER")
			end
		else
			local title = _G[bar:GetName().."Title"]
			local label = _G[bar:GetName().."Label"]
			local text = _G[bar:GetName().."Text"]

			if title then
				title:SetPoint("LEFT", 4, 0)
			end

			if label then
				label:SetPoint("LEFT", 4, 0)
			end

			if text then
				text:SetPoint("RIGHT", -4, 0)
			end
		end
	end

	SkinStatusBar(AchievementFrameSummaryCategoriesStatusBar)
	SkinStatusBar(AchievementFrameComparison.Summary.Player.StatusBar, true)
	SkinStatusBar(AchievementFrameComparison.Summary.Friend.StatusBar, true)
	AchievementFrameComparisonHeader:SetPoint("BOTTOMRIGHT", AchievementFrameComparison, "TOPRIGHT", 39, 26)
	AchievementFrameComparisonHeader:CreateBackdrop("Transparent")
	AchievementFrameComparisonHeader.backdrop:SetPoint("TOPLEFT", 20, -20)
	AchievementFrameComparisonHeader.backdrop:SetPoint("BOTTOMRIGHT", -17, 1)

	for i = 1, 12 do
		local frame = _G["AchievementFrameSummaryCategoriesCategory"..i]
		local button = _G["AchievementFrameSummaryCategoriesCategory"..i.."Button"]
		local highlight = _G["AchievementFrameSummaryCategoriesCategory"..i.."ButtonHighlight"]

		SkinStatusBar(frame)
		button:StripTextures()
		highlight:StripTextures()

		frame.Label:SetPoint("LEFT", frame, "LEFT", 4, 0)

		_G[highlight:GetName().."Middle"]:SetColorTexture(1, 1, 1, 0.3)
		_G[highlight:GetName().."Middle"]:SetAllPoints(frame)
	end

	hooksecurefunc(_G.AchievementFrameCategories.ScrollBox, "Update", function(frame)
		for _, child in next, { frame.ScrollTarget:GetChildren() } do
			local button = child.Button
			if button and not button.IsSkinned then
				button:StripTextures()
				button.Background:Hide()
				button:StyleButton()

				button.IsSkinned = true
			end
		end
	end)

	hooksecurefunc(_G.AchievementFrameAchievements.ScrollBox, "Update", function(frame)
		for _, child in next, { frame.ScrollTarget:GetChildren() } do
			if not child.isSkinned then
				child:StripTextures(true)
				child.Background:SetAlpha(0)
				child.Highlight:SetAlpha(0)
				child.Icon.frame:Hide()
				child.Description:SetTextColor(0.6, 0.6, 0.6)
				child.Description.SetTextColor = T.dummy
				child.Description:SetShadowOffset(1, -1)
				child.Description.SetShadowOffset = T.dummy

				child:CreateBackdrop("Overlay")
				child.backdrop:SetPoint("TOPLEFT", 1, -1)
				child.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)
				child.Icon.texture:SkinIcon()

				T.SkinCheckBox(child.Tracked)
				child.Tracked:SetSize(20, 20)
				child.Check:SetAlpha(0)

				hooksecurefunc(child, "UpdatePlusMinusTexture", function (button)
					if button.DateCompleted:IsShown() then
						if button.accountWide then
							button.Label:SetTextColor(0.1, 0.6, 0.8)
							button.backdrop:SetBackdropBorderColor(ACHIEVEMENT_BLUE_BORDER_COLOR:GetRGB())
						else
							button.Label:SetTextColor(1, 0.82, 0)
							button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
						end
					elseif button.accountWide then
						button.Label:SetTextColor(0.6, 0.6, 0.6)
						button.backdrop:SetBackdropBorderColor(ACHIEVEMENT_BLUE_BORDER_COLOR:GetRGB())
					else
						button.Label:SetTextColor(0.6, 0.6, 0.6)
						button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
					end
				end)
				hooksecurefunc(child, "DisplayObjectives", function (frame)
					local objectives = frame:GetObjectiveFrame()
					if objectives and objectives.progressBars then
						for _, bar in next, objectives.progressBars do
							if not bar.isSkinned then
								bar:StripTextures()
								bar:SetStatusBarTexture(C.media.texture)
								bar:SetStatusBarColor(0, 0.7, 0.1)
								bar:CreateBackdrop("Overlay")
								bar.isSkinned = true
							end
						end
					end
				end)

				child.isSkinned = true
			end
		end
	end)

	local numTab = 0
	AchievementFrame:HookScript("OnShow", function()
		if IsAddOnLoaded("Krowi_AchievementFilter") then
			local tab = _G["AchievementFrameTab4"]
			if tab and not tab.isSkinned then
				T.SkinTab(tab)
				tab.isSkinned = true
				numTab = 1
			end
		end
		if IsAddOnLoaded("Overachiever_Tabs") then
			for i = 4 + numTab, 6 + numTab do
				local tab = _G["AchievementFrameTab"..i]
				if tab and not tab.isSkinned then
					T.SkinTab(tab)
					tab.isSkinned = true
				end
			end
		end
		AchievementFrameTab1:SetPoint("TOPLEFT", AchievementFrame, "BOTTOMLEFT", 17, 2)
	end)

	hooksecurefunc("AchievementFrameSummary_UpdateAchievements", function()
		for i = 1, ACHIEVEMENTUI_MAX_SUMMARY_ACHIEVEMENTS do
			local frame = _G["AchievementFrameSummaryAchievement"..i]
			frame:StripTextures()
			frame.Highlight:SetAlpha(0)

			frame.Description:SetTextColor(0.6, 0.6, 0.6)
			frame.Description:SetShadowOffset(1, -1)

			if not frame.backdrop then
				frame:CreateBackdrop("Overlay")
				frame.backdrop:SetPoint("TOPLEFT", 2, -2)
				frame.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)

				frame.TitleBar:Hide()
				frame.Glow:Hide()
				frame.Icon.frame:Hide()

				frame.Icon:SetTemplate("Default")
				frame.Icon:SetHeight(frame.Icon:GetHeight() - 14)
				frame.Icon:SetWidth(frame.Icon:GetWidth() - 14)
				frame.Icon:ClearAllPoints()
				frame.Icon:SetPoint("LEFT", 6, 0)
				frame.Icon.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				frame.Icon.texture:ClearAllPoints()
				frame.Icon.texture:SetPoint("TOPLEFT", 2, -2)
				frame.Icon.texture:SetPoint("BOTTOMRIGHT", -2, 2)
			end

			if frame.accountWide then
				frame.backdrop:SetBackdropBorderColor(ACHIEVEMENT_BLUE_BORDER_COLOR:GetRGB())
			else
				frame.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end)

	hooksecurefunc("AchievementObjectives_DisplayCriteria", function(objectivesFrame, id)
		local numCriteria = GetAchievementNumCriteria(id)
		local textStrings, metas = 0, 0
		for i = 1, numCriteria do
			local _, criteriaType, completed, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)
			if assetID and criteriaType == _G.CRITERIA_TYPE_ACHIEVEMENT then
				metas = metas + 1
				criteria, object = objectivesFrame:GetMeta(metas), "Label"
			elseif criteriaType ~= 1 then
				textStrings = textStrings + 1
				criteria, object = objectivesFrame:GetCriteria(textStrings), "Name"
			end

			local text = criteria and criteria[object]
			if text then
				local r, g, b, x, y
				if completed then
					if objectivesFrame.completed then
						r, g, b, x, y = 1, 1, 1, 0, 0
					else
						r, g, b, x, y = 0, 1, 0, 1, -1
					end
				else
					r, g, b, x, y = .6, .6, .6, 1, -1
				end

				text:SetTextColor(r, g, b)
				text:SetShadowOffset(x, y)
			end
		end
	end)

	-- Comparison
	local Comparison = _G.AchievementFrameComparison
	Comparison:StripTextures()
	select(5, Comparison:GetChildren()):Hide()
	Comparison.Summary.Player:StripTextures()
	Comparison.Summary.Friend:StripTextures()

	local function HandleCompareCategory(button)
		button:StripTextures()
		button.Background:Hide()
		button:CreateBackdrop("Overlay")
		button.backdrop:SetInside(button, 2, 2)

		button.TitleBar:Hide()
		button.Glow:Hide()
		button.Icon.frame:Hide()

		button.Icon:SetTemplate("Default")
		button.Icon:SetHeight(button.Icon:GetHeight() - 14)
		button.Icon:SetWidth(button.Icon:GetWidth() - 14)
		button.Icon:ClearAllPoints()
		button.Icon:SetPoint("LEFT", 6, 0)
		button.Icon.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.Icon.texture:ClearAllPoints()
		button.Icon.texture:SetPoint("TOPLEFT", 2, -2)
		button.Icon.texture:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	hooksecurefunc(Comparison.AchievementContainer.ScrollBox, "Update", function(frame)
		for _, child in next, { frame.ScrollTarget:GetChildren() } do
			if not child.isSkinned then
				HandleCompareCategory(child.Player)
				child.Player.Description:SetTextColor(0.6, 0.6, 0.6)
				child.Player.Description.SetTextColor = T.dummy
				HandleCompareCategory(child.Friend)

				child.isSkinned = true
			end
		end
	end)

	hooksecurefunc(Comparison.StatContainer.ScrollBox, "Update", function(frame)
		for _, child in next, { frame.ScrollTarget:GetChildren() } do
			if not child.isSkinned then
				child:StyleButton()
				child.Background:SetColorTexture(1, 1, 1, 0.15)

				child.Left:Kill()
				child.Middle:Kill()
				child.Right:Kill()

				child.Left2:Kill()
				child.Middle2:Kill()
				child.Right2:Kill()

				child.IsSkinned = true
			end
		end
	end)

	-- Stats
	select(4, _G.AchievementFrameStats:GetChildren()):Hide()
	hooksecurefunc(_G.AchievementFrameStats.ScrollBox, "Update", function(frame)
		for _, child in next, { frame.ScrollTarget:GetChildren() } do
			if not child.IsSkinned then
				child:StyleButton()
				child.Background:SetColorTexture(1, 1, 1, 0.2)

				child.Left:Kill()
				child.Middle:Kill()
				child.Right:Kill()

				child.IsSkinned = true
			end
		end
	end)
end

T.SkinFuncs["Blizzard_AchievementUI"] = LoadSkin