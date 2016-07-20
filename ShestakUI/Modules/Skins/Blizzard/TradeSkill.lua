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
	-- TradeSkillViewGuildCraftersButton:SkinButton(true)

	TradeSkillFrame.LinkToButton:GetNormalTexture():SetTexCoord(0.25, 0.7, 0.37, 0.75)
	TradeSkillFrame.LinkToButton:GetPushedTexture():SetTexCoord(0.25, 0.7, 0.45, 0.8)
	TradeSkillFrame.LinkToButton:GetHighlightTexture():Kill()
	TradeSkillFrame.LinkToButton:CreateBackdrop("Overlay")
	TradeSkillFrame.LinkToButton:SetSize(17, 14)
	TradeSkillFrame.LinkToButton:SetPoint("BOTTOMRIGHT", TradeSkillFrame.FilterButton, "TOPRIGHT", -2, 4)

	T.SkinEditBox(TradeSkillFrame.SearchBox, TradeSkillFrame.SearchBox:GetWidth() + 5, TradeSkillFrame.SearchBox:GetHeight() - 2)
	-- TradeSkillFrame.SearchBox:ClearAllPoints()
	-- TradeSkillFrame.SearchBox:SetPoint("TOPLEFT", TradeSkillFrame.RankFrame, "BOTTOMLEFT", 0, -7)

	T.SkinEditBox(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox, nil, TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:GetHeight() - 2)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:DisableDrawLayer("BACKGROUND")

	T.SkinNextPrevButton(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.DecrementButton, true)
	T.SkinNextPrevButton(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SetPoint("LEFT", TradeSkillFrame.DetailsFrame.CreateMultipleInputBox, "RIGHT", 4, 0)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SetSize(22, 22)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.DecrementButton:SetSize(22, 22)

	T.SkinCloseButton(TradeSkillFrameCloseButton)

	-- T.SkinScrollBar(TradeSkillFrame.RecipeList.scrollBar)
	-- T.SkinScrollBar(TradeSkillFrame.DetailsFrame.ScrollBar)

	--BETA TradeSkillFrame.DetailsFrame.Contents.ResultIcon:DisableDrawLayer("OVERLAY")
	-- hooksecurefunc(TradeSkillDetailsMixin, "RefreshButtons", function()
		-- TradeSkillFrame.DetailsFrame.Contents.ResultIcon:StyleButton(true)
		-- TradeSkillFrame.DetailsFrame.Contents.ResultIcon:SetTemplate("Default")
		-- if TradeSkillFrame.DetailsFrame.Contents.ResultIcon:GetNormalTexture() then
			-- TradeSkillFrame.DetailsFrame.Contents.ResultIcon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			-- TradeSkillFrame.DetailsFrame.Contents.ResultIcon:GetNormalTexture():ClearAllPoints()
			-- TradeSkillFrame.DetailsFrame.Contents.ResultIcon:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			-- TradeSkillFrame.DetailsFrame.Contents.ResultIcon:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		-- end
	-- end)

	-- for i = 1, MAX_TRADE_SKILL_REAGENTS do
		-- local button = _G["TradeSkillFrame.DetailsFrame.Contents.Reagent"..i]
		-- local icon = _G["TradeSkillReagent"..i.."IconTexture"]
		-- local count = _G["TradeSkillReagent"..i.."Count"]

		-- icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		-- icon:SetDrawLayer("OVERLAY")

		-- if not icon.backdrop then
			-- icon.backdrop = CreateFrame("Frame", nil, button)
			-- icon.backdrop:SetFrameStrata("BACKGROUND")
			-- icon.backdrop:SetTemplate("Default")
			-- icon.backdrop:SetPoint("TOPLEFT", button, "TOPLEFT", 1, -1)
			-- icon.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", 42, 1)
		-- end
		-- icon:SetParent(icon.backdrop)
		-- icon:SetPoint("TOPLEFT", icon.backdrop, "TOPLEFT", 2, -2)
		-- icon:SetPoint("BOTTOMRIGHT", icon.backdrop, "BOTTOMRIGHT", -2, 2)

		-- count:SetFont(C.media.normal_font, 12, "OUTLINE")
		-- count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
		-- count:SetDrawLayer("OVERLAY")

		-- _G["TradeSkillReagent"..i.."NameFrame"]:Kill()
	-- end

	-- -- Guild Crafters
	-- TradeSkillGuildFrame:StripTextures()
	-- TradeSkillGuildFrame:SetTemplate("Transparent")
	-- TradeSkillGuildFrame:SetPoint("BOTTOMLEFT", TradeSkillFrame, "BOTTOMRIGHT", 3, 19)
	-- TradeSkillGuildFrameContainer:StripTextures()
	-- TradeSkillGuildFrameContainer:SetTemplate("Overlay")
	-- T.SkinCloseButton(TradeSkillGuildFrameCloseButton)
	-- if Auctionator_Search then
		-- Auctionator_Search:SkinButton(true)
	-- end
end

T.SkinFuncs["Blizzard_TradeSkillUI"] = LoadSkin