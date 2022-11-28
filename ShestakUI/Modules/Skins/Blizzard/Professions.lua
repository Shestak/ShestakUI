local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Professions skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = ProfessionsFrame
	T.SkinFrame(frame)

	ProfessionsFrame.CraftingPage.TutorialButton.Ring:Hide()
	ProfessionsFrame.CraftingPage.TutorialButton:SetPoint("TOPLEFT", frame, "TOPLEFT", -5, 10)

	T.SkinEditBox(frame.CraftingPage.RecipeList.SearchBox, nil, 16)
	frame.CraftingPage.RecipeList.FilterButton:SkinButton()
	frame.CraftingPage.RecipeList.FilterButton:SetPoint("TOPRIGHT", ProfessionsFrame.CraftingPage.RecipeList, "TOPRIGHT", -8, -6)
	T.SkinCloseButton(ProfessionsFrame.CraftingPage.RecipeList.FilterButton.ResetButton)
	ProfessionsFrame.CraftingPage.RecipeList.FilterButton.ResetButton:ClearAllPoints()
	ProfessionsFrame.CraftingPage.RecipeList.FilterButton.ResetButton:SetPoint("CENTER", ProfessionsFrame.CraftingPage.RecipeList.FilterButton, "TOPRIGHT", 0, 0)

	local RankBar = frame.CraftingPage.RankBar
	RankBar.Border:Hide()
	RankBar.Background:Hide()
	RankBar:CreateBackdrop("Overlay")
	RankBar.backdrop:SetOutside(RankBar.Fill)

	local LinkButton = frame.CraftingPage.LinkButton
	LinkButton:GetNormalTexture():SetTexCoord(0.25, 0.7, 0.37, 0.75)
	LinkButton:GetPushedTexture():SetTexCoord(0.25, 0.7, 0.45, 0.8)
	LinkButton:GetHighlightTexture():Kill()
	LinkButton:CreateBackdrop("Overlay")
	LinkButton:SetSize(17, 14)
	LinkButton:SetPoint("LEFT", ProfessionsFrame.CraftingPage.RankBar, "RIGHT", 1, -3)

	for _, name in pairs({"Prof0ToolSlot", "Prof0Gear0Slot", "Prof0Gear1Slot", "Prof1ToolSlot", "Prof1Gear0Slot", "Prof1Gear1Slot", "CookingToolSlot", "CookingGear0Slot", "FishingToolSlot", "FishingGear0Slot", "FishingGear1Slot"}) do
		local button = frame.CraftingPage[name]
		if button then
			button:StripTextures()
			button.icon:SkinIcon()
			-- T.SkinIconBorder(button.IconBorder, button.backdrop)
			button:SetNormalTexture(0)
			button:SetPushedTexture(0)
		end
	end

	local RecipeList = frame.CraftingPage.RecipeList
	RecipeList:StripTextures()
	RecipeList.BackgroundNineSlice:Hide()
	T.SkinScrollBar(RecipeList.ScrollBar)
	RecipeList.ScrollBar.Back:SetSize(17, 15)
	RecipeList.ScrollBar.Track.Thumb:SetWidth(17)
	RecipeList.ScrollBar.Forward:SetSize(17, 15)

	local SchematicForm = frame.CraftingPage.SchematicForm
	SchematicForm:StripTextures()
	-- SchematicForm.Background:SetAlpha(0)
	SchematicForm:CreateBackdrop("Overlay")
	SchematicForm.backdrop:SetInside()
	SchematicForm.Background:SetInside(SchematicForm, 4, 4)

	T.SkinCheckBox(SchematicForm.TrackRecipeCheckBox, 24)

	local OutputIcon = SchematicForm.OutputIcon
	if OutputIcon then
		OutputIcon.Icon:SkinIcon()
		T.SkinIconBorder(OutputIcon.IconBorder, OutputIcon.Icon:GetParent().backdrop)
		OutputIcon.IconBorder:SetAlpha(0)
		OutputIcon:GetHighlightTexture():Hide()
		OutputIcon.CircleMask:Hide()
	end

	local function skinReagentIcon(button)
		button.Icon:SkinIcon()
		button:SetNormalTexture(0)
		button:SetPushedTexture(0)
		button:GetHighlightTexture():Hide()
		T.SkinIconBorder(button.IconBorder, button.Icon:GetParent().backdrop)
		if button.SlotBackground then
			button.SlotBackground:Hide()
		end
	end

	hooksecurefunc(SchematicForm, "Init", function(frame)
		for slot in frame.reagentSlotPool:EnumerateActive() do
			skinReagentIcon(slot.Button)
		end

		local slot = SchematicForm.salvageSlot
		if slot then
			skinReagentIcon(slot.Button)
		end

		local slot = SchematicForm.enchantSlot
		if slot then
			skinReagentIcon(slot.Button)
		end
	end)

	hooksecurefunc("OpenProfessionsItemFlyout", function(_, parent)
		for i = 1, parent:GetNumChildren() do
			local frame = select(i, parent:GetChildren())
			if frame.HideUnownedCheckBox and not frame.backdrop then
				frame:StripTextures()
				frame:CreateBackdrop("Transparent")
				frame.backdrop:SetFrameLevel(2)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, 2)
				T.SkinCheckBox(frame.HideUnownedCheckBox, 24)
				hooksecurefunc(frame.ScrollBox, "Update", function(self)
					for i = 1, self.ScrollTarget:GetNumChildren() do
						local button = select(i, self.ScrollTarget:GetChildren())
						if button.IconBorder and not button.styled then
							button:SetTemplate("Transparent")
							button.icon:CropIcon()
							button:SetNormalTexture(0)
							button:SetPushedTexture(0)
							button:GetHighlightTexture():Hide()
							T.SkinIconBorder(button.IconBorder, button)

							button.styled = true
						end
					end
				end)

				break
			end
		end
	end)

	frame.CraftingPage.CreateAllButton:SkinButton()
	frame.CraftingPage.CreateButton:SkinButton()
	T.SkinEditBox(ProfessionsFrame.CraftingPage.CreateMultipleInputBox, nil, 18)
	T.SkinNextPrevButton(ProfessionsFrame.CraftingPage.CreateMultipleInputBox.DecrementButton, true)
	T.SkinNextPrevButton(ProfessionsFrame.CraftingPage.CreateMultipleInputBox.IncrementButton)
	ProfessionsFrame.CraftingPage.CreateMultipleInputBox.IncrementButton:SetPoint("LEFT", ProfessionsFrame.CraftingPage.CreateMultipleInputBox, "RIGHT", 5, 0)
	ProfessionsFrame.CraftingPage.CreateMultipleInputBox.IncrementButton:SetSize(22, 22)
	ProfessionsFrame.CraftingPage.CreateMultipleInputBox.DecrementButton:SetSize(22, 22)

	for _, tab in next, {frame.TabSystem:GetChildren()} do
		T.SkinTab(tab)
	end

	-- Guild
	frame.CraftingPage.ViewGuildCraftersButton:SkinButton()
	local GuildFrame = frame.CraftingPage.GuildFrame
	GuildFrame:StripTextures()
	GuildFrame:CreateBackdrop("Transparent")
	GuildFrame.Container:StripTextures()
	GuildFrame.Container:CreateBackdrop("Overlay")
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)