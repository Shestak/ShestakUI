local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GuildRegistrar skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	EncounterJournal:StripTextures(true)
	EncounterJournal:CreateBackdrop("Transparent")
	EncounterJournal.backdrop:Point("TOPLEFT", -3, 0)
	EncounterJournal.backdrop:SetPoint("BOTTOMRIGHT", 0, -2)

	EncounterJournalNavBar:StripTextures(true)
	EncounterJournalNavBarOverlay:StripTextures(true)

	EncounterJournalNavBar:CreateBackdrop("Transparent")
	EncounterJournalNavBar.backdrop:Point("TOPLEFT", -2, 0)
	EncounterJournalNavBar.backdrop:SetPoint("BOTTOMRIGHT")
	EncounterJournalNavBarHomeButton:SkinButton(true)

	T.SkinEditBox(EncounterJournalSearchBox)
	T.SkinCloseButton(EncounterJournalCloseButton)

	EncounterJournalInset:StripTextures(true)
	EncounterJournal:HookScript("OnShow", function()
		if not EncounterJournalInstanceSelect.backdrop then
			EncounterJournalInstanceSelect:CreateBackdrop("Default")
			EncounterJournalInstanceSelect.backdrop:Point("TOPLEFT", -2, 2)
			EncounterJournalInstanceSelect.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
		end

		if not EncounterJournalEncounterFrameInfo.backdrop then
			EncounterJournalEncounterFrameInfo:CreateBackdrop("Default")
			EncounterJournalEncounterFrameInfo.backdrop:Point("TOPLEFT", -2, 2)
			EncounterJournalEncounterFrameInfo.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
		end

		EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoBossTab:Point("LEFT", EncounterJournalEncounterFrameInfoEncounterTile, "RIGHT", -10, 4)
		EncounterJournalEncounterFrameInfoLootTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoLootTab:Point("LEFT", EncounterJournalEncounterFrameInfoBossTab, "RIGHT", -24, 0)

		EncounterJournalEncounterFrameInfoBossTab:SetFrameStrata("HIGH")
		EncounterJournalEncounterFrameInfoLootTab:SetFrameStrata("HIGH")

		EncounterJournalEncounterFrameInfoBossTab:SetScale(0.75)
		EncounterJournalEncounterFrameInfoLootTab:SetScale(0.75)

		EncounterJournalEncounterFrameInfoLootScrollFrameFilter:SetScript("OnShow", function()
			EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
			EncounterJournalEncounterFrameInfoBossTab:Point("LEFT", EncounterJournalEncounterFrameInfoLootScrollFrameFilter, "RIGHT", 0, 0)
			EncounterJournalEncounterFrameInfoEncounterTile:Hide()
		end)

		EncounterJournalEncounterFrameInfoLootScrollFrameFilter:SetScript("OnHide", function()
			EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
			EncounterJournalEncounterFrameInfoBossTab:Point("LEFT", EncounterJournalEncounterFrameInfoEncounterTile, "RIGHT", -10, 4)
			EncounterJournalEncounterFrameInfoEncounterTile:Show()
		end)
	end)

	T.SkinScrollBar(EncounterJournalInstanceSelectScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoLootScrollFrameScrollBar)

	EncounterJournalEncounterFrameInfoBossTab:GetNormalTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetPushedTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetDisabledTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetHighlightTexture():SetTexture(nil)

	EncounterJournalEncounterFrameInfoLootTab:GetNormalTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetPushedTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetDisabledTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetHighlightTexture():SetTexture(nil)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)