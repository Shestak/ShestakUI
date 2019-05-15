local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

----------------------------------------------------------------------------------------
--	EncounterJournal skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "Blizzard_EncounterJournal" then
		local tooltip = EncounterJournalTooltip
		local item1 = tooltip.Item1
		local item2 = tooltip.Item2
		tooltip:SetTemplate("Transparent")

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

	EncounterJournalNavBar:StripTextures(true)
	EncounterJournalNavBar.overlay:StripTextures(true)

	EncounterJournalNavBar:CreateBackdrop("Transparent")
	EncounterJournalNavBar.backdrop:SetPoint("TOPLEFT", -3, 1)
	EncounterJournalNavBar.backdrop:SetPoint("BOTTOMRIGHT", 0, -1)
	EncounterJournalNavBarHomeButton:SkinButton(true)
	EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggle:SkinButton(true)
	EncounterJournalEncounterFrameInfoLootScrollFrameSlotFilterToggle:SkinButton(true)
	EncounterJournalEncounterFrameInfoLootScrollFrameClassFilterClearFrame:GetRegions():SetAlpha(0)
	EncounterJournalEncounterFrameInfoDifficulty:SkinButton(true)
	EncounterJournalEncounterFrameInfoDifficulty:SetWidth(95)
	EncounterJournalEncounterFrameInfoDifficulty:SetPoint("TOPRIGHT", EncounterJournalEncounterFrameInfo, "TOPRIGHT", -7, -13)
	EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggle:SetPoint("TOPLEFT", EncounterJournalEncounterFrameInfo, "TOPRIGHT", -349, -13)
	hooksecurefunc(EncounterJournalEncounterFrameInfoResetButton, "SetPoint", function(self, _, _, _, x)
		if x == -10 then
			self:SetPoint("RIGHT", EncounterJournalEncounterFrameInfoDifficulty, "LEFT", -5, 0)
		end
	end)

	EncounterJournal.LootJournal.ItemSetsFrame.ClassButton:SkinButton(true)

	T.SkinEditBox(EncounterJournalSearchBox)
	T.SkinCloseButton(EncounterJournalCloseButton)
	T.SkinDropDownBox(EncounterJournalInstanceSelectTierDropDown)
	T.SkinTab(EncounterJournalInstanceSelectSuggestTab, true)
	T.SkinTab(EncounterJournalInstanceSelectDungeonTab, true)
	T.SkinTab(EncounterJournalInstanceSelectRaidTab, true)
	T.SkinTab(EncounterJournalInstanceSelectLootJournalTab, true)

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
	EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle:SetFont(C.media.normal_font, 16)
	EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle:SetTextColor(1, 1, 1)
	EncounterJournal.encounter.info.overviewScroll.child.overviewDescription.Text:SetTextColor(1, 1, 1)
	EncounterJournal.encounter.info.reset:StripTextures()
	EncounterJournal.encounter.info.reset:SkinButton()
	EncounterJournalEncounterFrameInfoResetButtonTexture:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
	EncounterJournalEncounterFrameInfoResetButtonTexture:SetTexCoord(0.90625000, 0.94726563, 0.00097656, 0.02050781)

	EncounterJournalInstanceSelectDungeonTab:ClearAllPoints()
	EncounterJournalInstanceSelectDungeonTab:SetPoint("BOTTOMLEFT", EncounterJournalInstanceSelectSuggestTab, "BOTTOMRIGHT", 10, 0)
	EncounterJournalInstanceSelectRaidTab:ClearAllPoints()
	EncounterJournalInstanceSelectRaidTab:SetPoint("BOTTOMLEFT", EncounterJournalInstanceSelectDungeonTab, "BOTTOMRIGHT", 10, 0)
	EncounterJournalInstanceSelectLootJournalTab:ClearAllPoints()
	EncounterJournalInstanceSelectLootJournalTab:SetPoint("BOTTOMLEFT", EncounterJournalInstanceSelectRaidTab, "BOTTOMRIGHT", 10, 0)

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
		tab:SetNormalTexture("")
		tab:SetPushedTexture("")
		tab:SetDisabledTexture("")
		tab:SetHighlightTexture("")
	end

	EncounterJournalEncounterFrameInfoOverviewTab:SetPoint("TOPLEFT", EncounterJournalEncounterFrameInfo, "TOPRIGHT", 8, -40)
	EncounterJournalEncounterFrameInfoOverviewTab.SetPoint = T.dummy

	T.SkinScrollBar(EncounterJournalScrollBar)
	T.SkinScrollBar(EncounterJournalInstanceSelectScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoLootScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInstanceFrameLoreScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollBar)
	T.SkinScrollBar(EncounterJournalEncounterFrameInfoBossesScrollFrameScrollBar)

	for i = 1, AJ_MAX_NUM_SUGGESTIONS do
		local suggestion = EncounterJournal.suggestFrame["Suggestion"..i]
		suggestion.bg:Hide()
		suggestion.centerDisplay.title.text:SetTextColor(1, 1, 1)
		suggestion.centerDisplay.description.text:SetTextColor(1, 1, 1)
		suggestion.reward.iconRing:Hide()
		suggestion.reward.iconRingHighlight:SetTexture("")
		suggestion:CreateBackdrop("Default")
		suggestion.backdrop:SetPoint("TOPLEFT", suggestion.icon, -2, 2)
		suggestion.backdrop:SetPoint("BOTTOMRIGHT", suggestion.icon, 2, -2)
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

	EncounterJournal.encounter.instance:SetHeight(EncounterJournal.encounter.info.bossesScroll:GetHeight() - 8)
	EncounterJournal.encounter.instance:ClearAllPoints()
	EncounterJournal.encounter.instance:SetPoint("BOTTOMRIGHT", EncounterJournalEncounterFrame, "BOTTOMRIGHT", -4, 7)
	EncounterJournal.encounter.instance.loreBG:SetSize(325, 280)
	EncounterJournal.encounter.instance.loreBG:ClearAllPoints()
	EncounterJournal.encounter.instance.loreBG:SetPoint("TOP", EncounterJournal.encounter.instance, "TOP", 0, 0)
	EncounterJournal.encounter.instance.mapButton:ClearAllPoints()
	EncounterJournal.encounter.instance.mapButton:SetPoint("BOTTOMLEFT", EncounterJournal.encounter.instance.loreBG, "BOTTOMLEFT", 25, 35)
	T.SkinScrollBar(EncounterJournal.encounter.instance.loreScroll.ScrollBar)
	EncounterJournal.encounter.instance.loreScroll.child.lore:SetTextColor(1, 1, 1)

	local function SkinDungeons()
		local b1 = EncounterJournalInstanceSelectScrollFrameScrollChildInstanceButton1
		if b1 and not b1.isSkinned then
			b1:SkinButton()
			b1.bgImage:SetPoint("TOPLEFT", 2, -2)
			b1.bgImage:SetPoint("BOTTOMRIGHT", -2, 2)
			b1.bgImage:SetTexCoord(0.08, 0.6, 0.08, 0.6)
			b1.bgImage:SetDrawLayer("ARTWORK")
			b1.isSkinned = true
		end

		for i = 1, 100 do
			local b = _G["EncounterJournalInstanceSelectScrollFrameinstance"..i]
			if b and not b.isSkinned then
				b:SkinButton()
				b.bgImage:SetPoint("TOPLEFT", 2, -2)
				b.bgImage:SetPoint("BOTTOMRIGHT", -2, 2)
				b.bgImage:SetTexCoord(0.08, 0.6, 0.08, 0.6)
				b.bgImage:SetDrawLayer("ARTWORK")
				b.isSkinned = true
			end
		end
	end
	hooksecurefunc("EncounterJournal_ListInstances", SkinDungeons)
	EncounterJournal_ListInstances()

	local function SkinBosses()
		local bossIndex = 1
		local _, _, bossID = EJ_GetEncounterInfoByIndex(bossIndex)
		local bossButton

		while bossID do
			bossButton = _G["EncounterJournalBossButton"..bossIndex]
			if bossButton and not bossButton.isSkinned then
				bossButton:SkinButton()
				bossButton.isSkinned = true
			end

			bossIndex = bossIndex + 1
			_, _, bossID = EJ_GetEncounterInfoByIndex(bossIndex)
		end
	end
	hooksecurefunc("EncounterJournal_DisplayInstance", SkinBosses)

	EncounterJournal.LootJournal:DisableDrawLayer("BACKGROUND")

	EncounterJournal.LootJournal.ItemSetsFrame.ClassButton:GetFontString():SetTextColor(1, 1, 1)
	select(5, EncounterJournal.LootJournal.ItemSetsFrame.ClassButton:GetRegions()):Hide()
	select(6, EncounterJournal.LootJournal.ItemSetsFrame.ClassButton:GetRegions()):Hide()
	EncounterJournal.LootJournal.ItemSetsFrame.ClassButton.UpLeft:SetAlpha(0)
	EncounterJournal.LootJournal.ItemSetsFrame.ClassButton.UpRight:SetAlpha(0)
	EncounterJournal.LootJournal.ItemSetsFrame.ClassButton.HighLeft:SetAlpha(0)
	EncounterJournal.LootJournal.ItemSetsFrame.ClassButton.HighRight:SetAlpha(0)
	EncounterJournal.LootJournal.ItemSetsFrame.ClassButton.DownLeft:SetAlpha(0)
	EncounterJournal.LootJournal.ItemSetsFrame.ClassButton.DownRight:SetAlpha(0)

	hooksecurefunc(EncounterJournal.LootJournal.ItemSetsFrame, "UpdateList", function()
		local itemSets = EncounterJournal.LootJournal.ItemSetsFrame.buttons

		for i = 1, #itemSets do
			local itemSet = itemSets[i]
			itemSet.ItemLevel:SetTextColor(1, 1, 1)
			itemSet.Background:Hide()

			if not itemSet.bg then
				itemSet:CreateBackdrop("Overlay")
				itemSet.backdrop:SetPoint("TOPLEFT", -4, 4)
				itemSet.backdrop:SetPoint("BOTTOMRIGHT", 4, -3)
				itemSet.bg = bg
			end

			local items = itemSet.ItemButtons
			for j = 1, #items do
				local item = items[j]
				item.Border:Hide()
				item.Icon:SetPoint("TOPLEFT", 1, -1)
				item.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				item.Icon:SetDrawLayer("OVERLAY")
				item.IconBackdrop = CreateFrame("Frame", nil, item)
				item.IconBackdrop:SetFrameLevel(item:GetFrameLevel() - 1)
				item.IconBackdrop:SetPoint("TOPLEFT", item.Icon, -2, 2)
				item.IconBackdrop:SetPoint("BOTTOMRIGHT", item.Icon, 2, -2)
				item.IconBackdrop:SetTemplate("Default")
				item.IconBackdrop:SetBackdropBorderColor(itemSet.SetName:GetTextColor())
			end
		end
	end)

	local items = EncounterJournal.encounter.info.lootScroll.buttons
	for i = 1, #items do
		local item = items[i]
		hooksecurefunc(item.IconBorder, "SetVertexColor", function(self, r, g, b)
			self:GetParent().IconBackdrop:SetBackdropBorderColor(r, g, b)
			self:SetTexture("")
		end)
		item:CreateBackdrop("Overlay")
		item.backdrop:SetPoint("TOPLEFT", 1, -4)
		item.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

		item.icon:SetSize(30, 30)
		item.icon:SetPoint("TOPLEFT", T.mult*6, -(T.mult*10))
		item.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		item.icon:SetDrawLayer("ARTWORK")

		item.IconBackdrop = CreateFrame("Frame", nil, item)
		item.IconBackdrop:SetFrameLevel(item:GetFrameLevel())
		item.IconBackdrop:SetPoint("TOPLEFT", item.icon, -2, 2)
		item.IconBackdrop:SetPoint("BOTTOMRIGHT", item.icon, 2, -2)
		item.IconBackdrop:SetTemplate("Default")

		item.boss:SetTextColor(1, 1, 1)
		item.boss:ClearAllPoints()
		item.boss:SetPoint("BOTTOMLEFT", 4, 4)
		item.bossTexture:SetAlpha(0)
		item.bosslessTexture:SetAlpha(0)
		item.slot:SetTextColor(1, 1, 1)
		item.slot:SetPoint("BOTTOMLEFT", item.icon, "BOTTOMRIGHT", 7, -2)
		item.armorType:SetTextColor(1, 1, 1)
		item.armorType:SetPoint("BOTTOMRIGHT", item.name, "TOPLEFT", 264, -25)
	end

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
					bullet.Text:SetTextColor(1, 1, 1)
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
end

T.SkinFuncs["Blizzard_EncounterJournal"] = LoadSkin
