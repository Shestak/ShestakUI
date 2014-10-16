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
end

T.SkinFuncs["Blizzard_EncounterJournal"] = LoadSkin