local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	EncounterJournal skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, _, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "Blizzard_EncounterJournal" then
		local tooltip = EncounterJournalTooltip
		local item1 = tooltip.Item1
		local item2 = tooltip.Item2
		tooltip.NineSlice:SetTemplate("Transparent")

		local b = CreateFrame("Frame", "$parentBackdrop", item1)
		b:SetPoint("TOPLEFT", item1.icon, -2, 2)
		b:SetPoint("BOTTOMRIGHT", item1.icon, 2, -2)
		b:SetFrameLevel(1)
		b:SetTemplate("Default")

		local c = CreateFrame("Frame", "$parentBackdrop", item2)
		c:SetPoint("TOPLEFT", item2.icon, -2, 2)
		c:SetPoint("BOTTOMRIGHT", item2.icon, 2, -2)
		c:SetFrameLevel(1)
		c:SetTemplate("Default")

		item1.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		item2.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		item1.IconBorder:SetAlpha(0)
		item2.IconBorder:SetAlpha(0)
	end
end)

if C.skins.blizzard_frames ~= true then return end
local function LoadSkin()
	EncounterJournal:StripTextures(true)
	EncounterJournal.inset:StripTextures(true)
	EncounterJournal:CreateBackdrop("Transparent")
	EncounterJournal.backdrop:SetPoint("TOPLEFT", -3, 0)
	EncounterJournal.backdrop:SetPoint("BOTTOMRIGHT", 0, -2)
	EncounterJournalPortrait:SetAlpha(0)

	EncounterJournalNavBar:StripTextures(true)
	EncounterJournalNavBar.overlay:StripTextures(true)

	EncounterJournalNavBar:CreateBackdrop("Transparent")
	EncounterJournalNavBar.backdrop:SetPoint("TOPLEFT", -3, 1)
	EncounterJournalNavBar.backdrop:SetPoint("BOTTOMRIGHT", 0, -1)
	EncounterJournalNavBarHomeButton:SkinButton(true)
	EncounterJournalEncounterFrameInfoFilterToggle:SkinButton(true)
	EncounterJournalEncounterFrameInfoSlotFilterToggle:SkinButton(true)
	EncounterJournalEncounterFrameInfoClassFilterClearFrame:GetRegions():SetAlpha(0)
	EncounterJournalEncounterFrameInfoDifficulty:SkinButton(true)
	EncounterJournalEncounterFrameInfoDifficulty:SetWidth(95)
	EncounterJournalEncounterFrameInfoDifficulty:SetPoint("TOPRIGHT", EncounterJournalEncounterFrameInfo, "TOPRIGHT", -7, -13)
	-- EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggle:SetPoint("TOPLEFT", EncounterJournalEncounterFrameInfo, "TOPRIGHT", -349, -13)
	hooksecurefunc(EncounterJournalEncounterFrameInfoResetButton, "SetPoint", function(self, _, _, _, x)
		if x == -10 then
			self:SetPoint("RIGHT", EncounterJournalEncounterFrameInfoDifficulty, "LEFT", -5, 0)
		end
	end)

	local mainTabs = {
		EncounterJournalSuggestTab,
		EncounterJournalDungeonTab,
		EncounterJournalRaidTab,
		EncounterJournalLootJournalTab
	}

	for _, tab in pairs(mainTabs) do
		T.SkinTab(tab)
	end

	EncounterJournalSuggestTab:SetPoint("TOPLEFT", EncounterJournal, "BOTTOMLEFT", 11, 0)

	T.SkinEditBox(EncounterJournalSearchBox)
	T.SkinCloseButton(EncounterJournalCloseButton)
	T.SkinDropDownBox(EncounterJournalInstanceSelectTierDropDown)

	EncounterJournalInstanceSelect.bg:Kill()
	EncounterJournalEncounterFrameInfoBG:Kill()
	EncounterJournal.encounter.info.leftShadow:Kill()
	EncounterJournal.encounter.info.rightShadow:Kill()
	EncounterJournal.encounter.info.model.dungeonBG:Kill()
	EncounterJournalEncounterFrameInfoModelFrameShadow:Kill()
	EncounterJournal.encounter.info.instanceButton:ClearAllPoints()
	EncounterJournal.encounter.info.instanceButton:SetPoint("TOPLEFT", EncounterJournal.encounter.info, "TOPLEFT", 0, 15)
	EncounterJournal.encounter.info.instanceTitle:ClearAllPoints()
	EncounterJournal.encounter.info.instanceTitle:SetPoint("BOTTOM", EncounterJournal.encounter.info.bossesScroll, "TOP", 10, 15)
	EncounterJournal.encounter.info.detailsScroll.child.description:SetTextColor(1, 1, 1)
	EncounterJournal.encounter.info.overviewScroll.child.loreDescription:SetTextColor(1, 1, 1)
	EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildHeader:SetAlpha(0)
	EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle:SetFont(C.media.normal_font, 16, "")
	EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle:SetTextColor(1, 1, 1)
	EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChild.overviewDescription.Text:SetTextColor("P", 1, 1, 1)
	EncounterJournal.encounter.info.reset:StripTextures()
	EncounterJournal.encounter.info.reset:SkinButton()
	EncounterJournalEncounterFrameInfoResetButtonTexture:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
	EncounterJournalEncounterFrameInfoResetButtonTexture:SetTexCoord(0.90625000, 0.94726563, 0.00097656, 0.02050781)

	local tabs = {
		EncounterJournalEncounterFrameInfoOverviewTab,
		EncounterJournalEncounterFrameInfoLootTab,
		EncounterJournalEncounterFrameInfoBossTab,
		EncounterJournalEncounterFrameInfoModelTab
	}
	for _, tab in pairs(tabs) do
		tab:CreateBackdrop("Overlay")
		tab.backdrop:SetPoint("TOPLEFT", 3, -3)
		tab.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)
		tab:SetNormalTexture(0)
		tab:SetPushedTexture(0)
		tab:SetDisabledTexture(0)
		tab:SetHighlightTexture(0)
	end

	EncounterJournalEncounterFrameInfoOverviewTab:SetPoint("TOPLEFT", EncounterJournalEncounterFrameInfo, "TOPRIGHT", 8, -40)
	EncounterJournalEncounterFrameInfoOverviewTab.SetPoint = T.dummy

	T.SkinScrollBar(EncounterJournalInstanceSelect.ScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfo.LootContainer.ScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInstanceFrame.LoreScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfo.BossesScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollBar)

	for i = 1, AJ_MAX_NUM_SUGGESTIONS do
		local suggestion = EncounterJournal.suggestFrame["Suggestion"..i]
		suggestion.bg:Hide()
		suggestion.centerDisplay.title.text:SetTextColor(1, 1, 1)
		suggestion.centerDisplay.description.text:SetTextColor(1, 1, 1)
		suggestion.reward.iconRing:Hide()
		suggestion.reward.iconRingHighlight:SetTexture("")

		suggestion.icon.b = CreateFrame("Frame", nil, suggestion)
		suggestion.icon.b:SetTemplate("Default")
		suggestion.icon.b:SetPoint("TOPLEFT", suggestion.icon, "TOPLEFT", -2, 2)
		suggestion.icon.b:SetPoint("BOTTOMRIGHT", suggestion.icon, "BOTTOMRIGHT", 2, -2)
		suggestion.icon.b:SetFrameLevel(1)

		suggestion.reward:CreateBackdrop("Default")
		suggestion.reward.backdrop:SetFrameLevel(suggestion.reward:GetFrameLevel())
		suggestion.reward.backdrop:SetPoint("TOPLEFT", suggestion.reward.icon, -2, 2)
		suggestion.reward.backdrop:SetPoint("BOTTOMRIGHT", suggestion.reward.icon, 2, -2)
		suggestion:CreateBackdrop("Overlay")
		suggestion.backdrop:SetFrameLevel(0)

		if i == 1 then
			suggestion.icon:SetPoint("TOPLEFT", 135, -15)
			suggestion.button:SkinButton()
			suggestion.reward.text:SetTextColor(1, 1, 1)
			suggestion.backdrop:SetPoint("TOPLEFT", -2, -2)
			T.SkinNextPrevButton(suggestion.prevButton)
			T.SkinNextPrevButton(suggestion.nextButton)
		else
			suggestion.icon:SetPoint("TOPLEFT", 10, -10)
			suggestion.centerDisplay:SetPoint("TOPLEFT", 85, -10)
			suggestion.centerDisplay.button:SkinButton()
		end
	end

	EncounterJournalEncounterFrameInstanceFrame.titleBG:SetAlpha(0)
	EncounterJournalEncounterFrameInstanceFrameBG:SetTexCoord(0.69, 0.06, 0.58, 0.09)
	EncounterJournalEncounterFrameInstanceFrameBG:SetRotation(rad(180))
	EncounterJournalEncounterFrameInstanceFrame:CreateBackdrop("Default")
	EncounterJournalEncounterFrameInstanceFrame.backdrop:SetOutside(EncounterJournalEncounterFrameInstanceFrameBG)
	EncounterJournalEncounterFrameInstanceFrameBG:SetSize(325, 240)
	EncounterJournalEncounterFrameInstanceFrameBG:ClearAllPoints()
	EncounterJournalEncounterFrameInstanceFrameBG:SetPoint("TOP", EncounterJournalEncounterFrameInstanceFrame, "TOP", 0, -45)
	EncounterJournalEncounterFrameInstanceFrameMapButton:ClearAllPoints()
	EncounterJournalEncounterFrameInstanceFrameMapButton:SetPoint("BOTTOMLEFT", EncounterJournalEncounterFrameInstanceFrameBG, "BOTTOMLEFT", 5, 5)
	EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont:SetHeight(EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont:GetHeight() + 25)

	for _, child in next, { _G.EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox.ScrollTarget:GetChildren() } do
		if child.FontString then
			child.FontString:SetTextColor(1, 1, 1)
		end
	end

	hooksecurefunc(_G.EncounterJournal.instanceSelect.ScrollBox, "Update", function(frame)
		for _, b in next, {frame.ScrollTarget:GetChildren()} do
			if not b.isSkinned then
				b:SkinButton()
				if b.bgImage then
					b.bgImage:SetPoint("TOPLEFT", 2, -2)
					b.bgImage:SetPoint("BOTTOMRIGHT", -2, 2)
					b.bgImage:SetTexCoord(0.08, 0.6, 0.08, 0.6)
					b.bgImage:SetDrawLayer("ARTWORK")
				end

				b.isSkinned = true
			end
		end
	end)

	hooksecurefunc(_G.EncounterJournal.encounter.info.BossesScrollBox, "Update", function(frame)
		for _, child in next, {frame.ScrollTarget:GetChildren()} do
			if not child.isSkinned then
				child:SkinButton()
				child.isSkinned = true
			end
		end
	end)

	hooksecurefunc(_G.EncounterJournal.encounter.info.LootContainer.ScrollBox, "Update", function(frame)
		for _, child in next, {frame.ScrollTarget:GetChildren()} do
			if not child.isSkinned then
				if child.bossTexture then child.bossTexture:SetAlpha(0) end
				if child.bosslessTexture then child.bosslessTexture:SetAlpha(0) end

				if child.boss then
					child.boss:ClearAllPoints()
					child.boss:SetPoint("BOTTOMLEFT", 4, 4)
					child.boss:SetTextColor(1, 1, 1)
				end

				if child.slot then
					child.slot:ClearAllPoints()
					child.slot:SetPoint("BOTTOMLEFT", child.icon, "BOTTOMRIGHT", 7, -2)
					child.slot:SetTextColor(1, 1, 1)
				end

				if child.armorType then
					child.armorType:ClearAllPoints()
					child.armorType:SetPoint("BOTTOMRIGHT", child.name, "TOPLEFT", 264, -25)
					child.armorType:SetTextColor(1, 1, 1)
				end

				if child.icon then
					child.icon:SetSize(30, 30)
					child.icon:SetPoint("TOPLEFT", T.mult*6, -(T.mult*10))
					child.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					child.icon:SetDrawLayer("ARTWORK")

					if not child.IconBackdrop then
						child.IconBackdrop = CreateFrame("Frame", nil, child)
						child.IconBackdrop:SetFrameLevel(child:GetFrameLevel())
						child.IconBackdrop:SetPoint("TOPLEFT", child.icon, -2, 2)
						child.IconBackdrop:SetPoint("BOTTOMRIGHT", child.icon, 2, -2)
						child.IconBackdrop:SetTemplate("Default")

						hooksecurefunc(child.IconBorder, "SetVertexColor", function(self, r, g, b)
							self:GetParent().IconBackdrop:SetBackdropBorderColor(r, g, b)
							self:SetTexture("")
						end)
					end
				end

				if not child.backdrop and not child.TipButton then
					child:CreateBackdrop("Overlay")
					child.backdrop:SetPoint("TOPLEFT", 0, -4)
					child.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
				end

				child.isSkinned = true
			end
		end
	end)

	local function SkinOverviewInfo(self, _, index)
		local header = self.overviews[index]
		if not header.isSkinned then

			header.descriptionBG:SetAlpha(0)
			header.descriptionBGBottom:SetAlpha(0)
			for i = 4, 18 do
				select(i, header.button:GetRegions()):SetTexture("")
			end

			header.button:SkinButton()
			header.button.title:SetTextColor(1, 1, 0)
			header.button.title.SetTextColor = T.dummy
			header.button.expandedIcon:SetTextColor(1, 1, 1)
			header.button.expandedIcon.SetTextColor = T.dummy

			header.isSkinned = true
		end
	end
	hooksecurefunc("EncounterJournal_SetUpOverview", SkinOverviewInfo)

	local function SkinOverviewInfoBullets(object)
		local parent = object:GetParent()

		if parent.Bullets then
			for _, bullet in pairs(parent.Bullets) do
				if not bullet.styled then
					bullet.Text:SetTextColor("P", 1, 1, 1)
					bullet.styled = true
				end
			end
		end
	end
	hooksecurefunc("EncounterJournal_SetBullets", SkinOverviewInfoBullets)

	local function SkinAbilitiesInfo()
		local index = 1
		local header = _G["EncounterJournalInfoHeader"..index]
		while header do
			if not header.isSkinned then
				header.flashAnim.Play = T.dummy

				header.descriptionBG:SetAlpha(0)
				header.descriptionBGBottom:SetAlpha(0)
				for i = 4, 18 do
					select(i, header.button:GetRegions()):SetTexture("")
				end

				header.description:SetTextColor(1, 1, 1)
				header.button.title:SetTextColor(1, 1, 0)
				header.button.title.SetTextColor = T.dummy
				header.button.expandedIcon:SetTextColor(1, 1, 1)
				header.button.expandedIcon.SetTextColor = T.dummy
				header.button:SkinButton(true)
				header.button.bg = CreateFrame("Frame", nil, header.button)
				header.button.bg:SetTemplate("Default")
				header.button.bg:SetFrameLevel(header.button.bg:GetFrameLevel() - 1)
				header.button.abilityIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				if header.button.abilityIcon:IsShown() then
					header.button.bg:Show()
				else
					header.button.bg:Hide()
				end
				header.isSkinned = true
			end

			if header.button.abilityIcon:IsShown() then
				header.button.bg:Show()
			else
				header.button.bg:Hide()
			end

			index = index + 1
			header = _G["EncounterJournalInfoHeader"..index]
		end
	end
	hooksecurefunc("EncounterJournal_ToggleHeaders", SkinAbilitiesInfo)

	hooksecurefunc("EJSuggestFrame_RefreshDisplay", function()
		local self = EncounterJournal.suggestFrame

		if #self.suggestions > 0 then
			local suggestion = self.Suggestion1
			local data = self.suggestions[1]

			suggestion.iconRing:Hide()

			if data.iconPath then
				suggestion.icon:SetMask("")
				suggestion.icon:SetTexture(data.iconPath)
				suggestion.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end
		end

		if #self.suggestions > 1 then
			for i = 2, #self.suggestions do
				local suggestion = self["Suggestion"..i]
				if not suggestion then break end

				local data = self.suggestions[i]

				suggestion.iconRing:Hide()

				if data.iconPath then
					suggestion.icon:SetMask("")
					suggestion.icon:SetTexture(data.iconPath)
					suggestion.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				end
			end
		end
	end)

	hooksecurefunc("EJSuggestFrame_UpdateRewards", function(suggestion)
		local rewardData = suggestion.reward.data
		if rewardData then
			local texture = rewardData.itemIcon or rewardData.currencyIcon or [[Interface\Icons\achievement_guildperk_mobilebanking]]
			suggestion.reward.icon:SetMask("")
			suggestion.reward.icon:SetTexture(texture)
			suggestion.reward.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end)

	local LootJournal = EncounterJournal.LootJournal
	LootJournal:DisableDrawLayer("BACKGROUND")
	LootJournal.ClassDropDownButton:SkinButton(true)
	LootJournal.RuneforgePowerFilterDropDownButton:SkinButton(true)

	EncounterJournal.LootJournalItems:DisableDrawLayer("BACKGROUND")
	T.SkinDropDownBox(EncounterJournalLootJournalViewDropDown)

	local itemSetsFrame = EncounterJournal.LootJournalItems.ItemSetsFrame
	itemSetsFrame.ClassButton:SkinButton(true)
	T.SkinScrollBar(itemSetsFrame.scrollBar)

	hooksecurefunc(itemSetsFrame, "ConfigureItemButton", function(_, button)
		if not button.styled then
			button.Border:SetAlpha(0)
			button:CreateBackdrop("Overlay")
			button.backdrop:SetPoint("TOPLEFT", button.Border, 5, -5)
			button.backdrop:SetPoint("BOTTOMRIGHT", button.Border, -4, 3)
			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.styled = true
		end

		local quality = select(3, GetItemInfo(button.itemID))
		local color = ITEM_QUALITY_COLORS[quality or 1]
		button.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
	end)

	local button = itemSetsFrame.buttons
	for i = 1, #button do
		local button = button[i]
		button:CreateBackdrop("Overlay")
		button.backdrop:SetPoint("TOPLEFT", 2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
		button.Background:Hide()
		button.ItemLevel:SetTextColor(1, 1, 1)
	end

	T.SkinScrollBar(EncounterJournal.LootJournal.ScrollBar)

	hooksecurefunc(_G.EncounterJournal.LootJournal.ScrollBox, "Update", function(frame)
		for _, btn in next, {frame.ScrollTarget:GetChildren()} do
			if not btn.isSkinned then
				btn.Background:SetAlpha(0)
				btn.BackgroundOverlay:SetAlpha(0)
				btn.CircleMask:Hide()
				btn.Icon:SetSize(50, 50)
				btn.Icon:SkinIcon(true)

				btn:CreateBackdrop("Overlay")
				btn.backdrop:SetPoint("TOPLEFT", 2, -2)
				btn.backdrop:SetPoint("BOTTOMRIGHT", 2, 2)

				btn.IsSkinned = true
			end
		end
	end)
end

T.SkinFuncs["Blizzard_EncounterJournal"] = LoadSkin