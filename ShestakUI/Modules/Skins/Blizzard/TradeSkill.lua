local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TradeSkillUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TradeSkillFrame:StripTextures(true)
	TradeSkillFrame.RecipeInset:StripTextures()
	TradeSkillFrame.DetailsInset:StripTextures()
	TradeSkillFrame.DetailsFrame.Background:Hide()

	TradeSkillFrame.RecipeList.LearnedTab:StripTextures()
	TradeSkillFrame.RecipeList.UnlearnedTab:StripTextures()

	TradeSkillFrame:SetTemplate("Transparent")
	TradeSkillFrame.RankFrame:StripTextures()
	TradeSkillFrame.RankFrame:CreateBackdrop("Overlay")
	TradeSkillFrame.RankFrame:SetStatusBarTexture(C.media.texture)

	--BETA for i = 1, TRADE_SKILLS_DISPLAYED do
		-- local bar = _G["TradeSkillSkill"..i.."SubSkillRankBar"]
		-- if bar then
			-- bar:StripTextures()
			-- bar:CreateBackdrop("Overlay")
			-- bar:SetStatusBarTexture(C.media.texture)
			-- bar:SetHeight(9)
		-- end
	-- end

	TradeSkillFrame.FilterButton:StripTextures(true)
	TradeSkillFrame.FilterButton:SkinButton(true)
	TradeSkillFrame.DetailsFrame.CreateButton:SkinButton(true)
	TradeSkillFrame.DetailsFrame.CreateAllButton:SkinButton(true)
	TradeSkillFrame.DetailsFrame.ExitButton:SkinButton(true)

	TradeSkillFrame.LinkToButton:GetNormalTexture():SetTexCoord(0.25, 0.7, 0.37, 0.75)
	TradeSkillFrame.LinkToButton:GetPushedTexture():SetTexCoord(0.25, 0.7, 0.45, 0.8)
	TradeSkillFrame.LinkToButton:GetHighlightTexture():Kill()
	TradeSkillFrame.LinkToButton:CreateBackdrop("Overlay")
	TradeSkillFrame.LinkToButton:SetSize(17, 14)
	TradeSkillFrame.LinkToButton:SetPoint("BOTTOMRIGHT", TradeSkillFrame.FilterButton, "TOPRIGHT", -2, 4)

	T.SkinEditBox(TradeSkillFrame.SearchBox, TradeSkillFrame.SearchBox:GetWidth() + 5, TradeSkillFrame.SearchBox:GetHeight() - 2)
	TradeSkillFrame.SearchBox:ClearAllPoints()
	TradeSkillFrame.SearchBox:SetPoint("RIGHT", TradeSkillFrame.FilterButton, "LEFT", -5, 0)

	T.SkinEditBox(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox, nil, TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:GetHeight() - 2)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:DisableDrawLayer("BACKGROUND")

	T.SkinNextPrevButton(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.DecrementButton, true)
	T.SkinNextPrevButton(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SetPoint("LEFT", TradeSkillFrame.DetailsFrame.CreateMultipleInputBox, "RIGHT", 5, 0)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SetSize(22, 22)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.DecrementButton:SetSize(22, 22)

	TradeSkillFrame.DetailsFrame.ExitButton:SetPoint("TOPRIGHT", TradeSkillFrame.DetailsFrame, "BOTTOMRIGHT", 28, -3)

	T.SkinCloseButton(TradeSkillFrameCloseButton)

	T.SkinScrollBar(TradeSkillFrame.RecipeList.scrollBar, "TradeSkillFrame")
	T.SkinScrollBar(TradeSkillFrame.DetailsFrame.ScrollBar)

	hooksecurefunc(TradeSkillFrame.DetailsFrame, "RefreshDisplay", function()
		local ResultIcon = TradeSkillFrame.DetailsFrame.Contents.ResultIcon
		ResultIcon:SetTemplate("Default")
		if ResultIcon:GetNormalTexture() then
			ResultIcon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			ResultIcon:GetNormalTexture():ClearAllPoints()
			ResultIcon:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			ResultIcon:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		end
		ResultIcon.ResultBorder:SetTexture(nil)
		ResultIcon.IconBorder:SetTexture(nil)

		for i = 1, #TradeSkillFrame.DetailsFrame.Contents.Reagents do
			local button = TradeSkillFrame.DetailsFrame.Contents.Reagents[i]
			local icon = button.Icon
			local count = button.Count

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetDrawLayer("OVERLAY")

			if not icon.backdrop then
				icon.backdrop = CreateFrame("Frame", nil, button)
				icon.backdrop:SetFrameStrata("BACKGROUND")
				icon.backdrop:SetTemplate("Default")
				icon.backdrop:SetPoint("TOPLEFT", button, "TOPLEFT", 1, -1)
				icon.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", 42, 1)
			end

			icon:SetParent(icon.backdrop)
			icon:SetPoint("TOPLEFT", icon.backdrop, "TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", icon.backdrop, "BOTTOMRIGHT", -2, 2)

			count:SetFont(C.media.normal_font, 12, "OUTLINE")
			count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
			count:SetDrawLayer("OVERLAY")

			button.NameFrame:Kill()
		end
	end)

	-- Guild Crafters
	TradeSkillFrame.DetailsFrame.ViewGuildCraftersButton.LeftSeparator:SetTexture(nil)
	TradeSkillFrame.DetailsFrame.ViewGuildCraftersButton.RightSeparator:SetTexture(nil)
	TradeSkillFrame.DetailsFrame.GuildFrame:StripTextures()
	TradeSkillFrame.DetailsFrame.GuildFrame:SetTemplate("Transparent")
	TradeSkillFrame.DetailsFrame.GuildFrame.Container:StripTextures()
	TradeSkillFrame.DetailsFrame.GuildFrame.Container:SetTemplate("Transparent")
	TradeSkillFrame.DetailsFrame.ViewGuildCraftersButton:SkinButton(true)
	T.SkinCloseButton(TradeSkillFrame.DetailsFrame.GuildFrame.CloseButton)
	T.SkinScrollBar(TradeSkillFrameScrollFrame.scrollBar, "TradeSkillFrameScrollFrame")

	if Auctionator_Search then
		Auctionator_Search:SkinButton(true)
	end
end

T.SkinFuncs["Blizzard_TradeSkillUI"] = LoadSkin