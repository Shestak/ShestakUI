local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TradeSkillUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TradeSkillFrame:StripTextures(true)
	TradeSkillListScrollFrame:StripTextures()
	TradeSkillDetailScrollFrame:StripTextures()
	TradeSkillFrameInset:StripTextures()
	TradeSkillExpandButtonFrame:StripTextures()
	TradeSkillDetailScrollChildFrame:StripTextures()

	TradeSkillFrame:SetTemplate("Transparent")
	TradeSkillRankFrame:StripTextures()
	TradeSkillRankFrame:CreateBackdrop("Overlay")
	TradeSkillRankFrame:SetStatusBarTexture(C.media.texture)

	for i = 1, TRADE_SKILLS_DISPLAYED do
		local bar = _G["TradeSkillSkill"..i.."SubSkillRankBar"]
		if bar then
			bar:StripTextures()
			bar:CreateBackdrop("Overlay")
			bar:SetStatusBarTexture(C.media.texture)
			bar:SetHeight(9)
		end
	end

	TradeSkillFilterButton:StripTextures(true)
	TradeSkillFilterButton:SkinButton(true)
	TradeSkillCreateButton:SkinButton(true)
	TradeSkillCancelButton:SkinButton(true)
	TradeSkillCreateAllButton:SkinButton(true)
	TradeSkillViewGuildCraftersButton:SkinButton(true)

	TradeSkillLinkButton:GetNormalTexture():SetTexCoord(0.25, 0.7, 0.37, 0.75)
	TradeSkillLinkButton:GetPushedTexture():SetTexCoord(0.25, 0.7, 0.45, 0.8)
	TradeSkillLinkButton:GetHighlightTexture():Kill()
	TradeSkillLinkButton:CreateBackdrop("Overlay")
	TradeSkillLinkButton:SetSize(17, 14)
	TradeSkillLinkButton:SetPoint("LEFT", TradeSkillLinkFrame, "LEFT", 5, -1)

	T.SkinEditBox(TradeSkillFrameSearchBox, TradeSkillFrameSearchBox:GetWidth() + 5, TradeSkillFrameSearchBox:GetHeight() - 2)
	TradeSkillFrameSearchBox:ClearAllPoints()
	TradeSkillFrameSearchBox:SetPoint("TOPLEFT", TradeSkillRankFrame, "BOTTOMLEFT", 0, -7)

	T.SkinEditBox(TradeSkillInputBox, nil, TradeSkillInputBox:GetHeight() - 2)

	T.SkinNextPrevButton(TradeSkillDecrementButton)
	T.SkinNextPrevButton(TradeSkillIncrementButton)
	TradeSkillIncrementButton:SetPoint("LEFT", TradeSkillInputBox, "RIGHT", 4, 0)
	TradeSkillIncrementButton:SetSize(22, 22)
	TradeSkillDecrementButton:SetSize(22, 22)

	T.SkinCloseButton(TradeSkillFrameCloseButton)

	T.SkinScrollBar(TradeSkillListScrollFrameScrollBar)
	T.SkinScrollBar(TradeSkillDetailScrollFrameScrollBar)

	hooksecurefunc("TradeSkillFrame_SetSelection", function(id)
		TradeSkillSkillIcon:StyleButton(true)
		TradeSkillSkillIcon:SetTemplate("Default")
		if TradeSkillSkillIcon:GetNormalTexture() then
			TradeSkillSkillIcon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			TradeSkillSkillIcon:GetNormalTexture():ClearAllPoints()
			TradeSkillSkillIcon:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			TradeSkillSkillIcon:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end)

	for i = 1, MAX_TRADE_SKILL_REAGENTS do
		local button = _G["TradeSkillReagent"..i]
		local icon = _G["TradeSkillReagent"..i.."IconTexture"]
		local count = _G["TradeSkillReagent"..i.."Count"]

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

		_G["TradeSkillReagent"..i.."NameFrame"]:Kill()
	end

	-- Guild Crafters
	TradeSkillGuildFrame:StripTextures()
	TradeSkillGuildFrame:SetTemplate("Transparent")
	TradeSkillGuildFrame:SetPoint("BOTTOMLEFT", TradeSkillFrame, "BOTTOMRIGHT", 3, 19)
	TradeSkillGuildFrameContainer:StripTextures()
	TradeSkillGuildFrameContainer:SetTemplate("Overlay")
	T.SkinCloseButton(TradeSkillGuildFrameCloseButton)
	if Auctionator_Search then
		Auctionator_Search:SkinButton(true)
	end
end

T.SkinFuncs["Blizzard_TradeSkillUI"] = LoadSkin