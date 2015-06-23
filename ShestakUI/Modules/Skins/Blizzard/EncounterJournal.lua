local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	EncounterJournal skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	EncounterJournal:StripTextures(true)
	EncounterJournal:CreateBackdrop("Transparent")
	EncounterJournal.backdrop:SetPoint("TOPLEFT", -3, 0)
	EncounterJournal.backdrop:SetPoint("BOTTOMRIGHT", 0, -2)

	EncounterJournalNavBar:StripTextures(true)
	EncounterJournalNavBarOverlay:StripTextures(true)

	EncounterJournalNavBar:CreateBackdrop("Transparent")
	EncounterJournalNavBar.backdrop:SetPoint("TOPLEFT", -3, 1)
	EncounterJournalNavBar.backdrop:SetPoint("BOTTOMRIGHT", 0, -1)
	EncounterJournalNavBarHomeButton:SkinButton(true)

	T.SkinEditBox(EncounterJournalSearchBox)
	T.SkinCloseButton(EncounterJournalCloseButton)
	T.SkinDropDownBox(EncounterJournalInstanceSelectTierDropDown)

	EncounterJournalInset:StripTextures(true)
	EncounterJournal:HookScript("OnShow", function()
		if not EncounterJournalInstanceSelect.backdrop then
			EncounterJournalInstanceSelect:CreateBackdrop("Default")
		end

		if not EncounterJournalEncounterFrameInfo.backdrop then
			EncounterJournalEncounterFrameInfo:CreateBackdrop("Default")
		end
	end)

	local tabs = {
		EncounterJournalEncounterFrameInfoOverviewTab,
		EncounterJournalEncounterFrameInfoLootTab,
		EncounterJournalEncounterFrameInfoBossTab,
		EncounterJournalEncounterFrameInfoModelTab
	}
	for _, tab in pairs(tabs) do
		tab:SetTemplate("Transparent")
		tab:SetSize(60, 54)
		tab:SetNormalTexture("")
		tab:SetPushedTexture("")
		tab:SetDisabledTexture("")
		tab:SetHighlightTexture("")
		tab:ClearAllPoints()
	end

	EncounterJournalEncounterFrameInfoOverviewTab:SetPoint("TOPLEFT", EncounterJournalEncounterFrameInfo, "TOPRIGHT", 11, -40)
	EncounterJournalEncounterFrameInfoLootTab:SetPoint("TOP", EncounterJournalEncounterFrameInfoOverviewTab, "BOTTOM", 0, -3)
	EncounterJournalEncounterFrameInfoBossTab:SetPoint("TOP", EncounterJournalEncounterFrameInfoLootTab, "BOTTOM", 0, -3)
	EncounterJournalEncounterFrameInfoModelTab:SetPoint("TOP", EncounterJournalEncounterFrameInfoBossTab, "BOTTOM", 0, -3)
	EncounterJournalEncounterFrameInfoModelTab.SetPoint = T.dummy

	T.SkinScrollBar(EncounterJournalInstanceSelectScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoLootScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoBossesScrollFrameScrollBar)
		
	local function navButtonFrameLevel(self)
		for i=1, #self.navList do
			local navButton = self.navList[i]
			local lastNav = self.navList[i-1]
			if navButton and lastNav then
				if lastNav:GetFrameLevel() > 2 then
					navButton:SetFrameLevel(lastNav:GetFrameLevel() - 2)
				else
					navButton:SetFrameLevel(0)
				end
			end
		end
	end
	
	hooksecurefunc("NavBar_AddButton", function(self, buttonData)
		local navButton = self.navList[#self.navList]


	if not navButton.skinned then
		navButton:SkinButton(true)

		if(navButton.MenuArrowButton) then
			T.SkinNextPrevButton(navButton.MenuArrowButton, true)
		end
		navButton.skinned = true
	end
	end)
	
	for i = 1, AJ_MAX_NUM_SUGGESTIONS do
		local suggestion = EncounterJournal.suggestFrame["Suggestion"..i];
		if i == 1 then
			suggestion.button:SkinButton()
			T.SkinNextPrevButton(suggestion.prevButton)
			T.SkinNextPrevButton(suggestion.nextButton)
		else
			suggestion.centerDisplay.button:SkinButton()
		end
	end
end

T.SkinFuncs["Blizzard_EncounterJournal"] = LoadSkin
