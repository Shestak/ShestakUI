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
	EncounterJournalNavBar.backdrop:SetPoint("TOPLEFT", -2, 0)
	EncounterJournalNavBar.backdrop:SetPoint("BOTTOMRIGHT")
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

		EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoBossTab:SetPoint("RIGHT", EncounterJournalEncounterFrameInfoResetButton, "LEFT", -400, 0)
		EncounterJournalEncounterFrameInfoLootTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoLootTab:SetPoint("RIGHT", EncounterJournalEncounterFrameInfoBossTab, "LEFT", 20, 0)
		EncounterJournalEncounterFrameInfoModelTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoModelTab:SetPoint("RIGHT", EncounterJournalEncounterFrameInfoLootTab, "LEFT", 20, 0)

		EncounterJournalEncounterFrameInfoBossTab:SetFrameStrata("HIGH")
		EncounterJournalEncounterFrameInfoLootTab:SetFrameStrata("HIGH")
		EncounterJournalEncounterFrameInfoModelTab:SetFrameStrata("HIGH")

		EncounterJournalEncounterFrameInfoBossTab:SetScale(0.70)
		EncounterJournalEncounterFrameInfoLootTab:SetScale(0.70)
		EncounterJournalEncounterFrameInfoModelTab:SetScale(0.70)
	end)

	T.SkinScrollBar(EncounterJournalInstanceSelectScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoLootScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoBossesScrollFrameScrollBar)

	EncounterJournalEncounterFrameInfoBossTab:GetNormalTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetPushedTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetDisabledTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetHighlightTexture():SetTexture(nil)

	EncounterJournalEncounterFrameInfoLootTab:GetNormalTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetPushedTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetDisabledTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetHighlightTexture():SetTexture(nil)

	EncounterJournalEncounterFrameInfoModelTab:GetNormalTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoModelTab:GetPushedTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoModelTab:GetDisabledTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoModelTab:GetHighlightTexture():SetTexture(nil)
end

T.SkinFuncs["Blizzard_EncounterJournal"] = LoadSkin