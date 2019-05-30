local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemText skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemTextFrame:StripTextures(true)
	ItemTextScrollFrame:StripTextures()
	ItemTextFrame:CreateBackdrop("Transparent")
	ItemTextFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	ItemTextFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	ItemTextTitleText:ClearAllPoints()
	ItemTextTitleText:SetPoint("TOP", GossipFrame.backdrop, "TOP", 0, -6)

	ItemTextCurrentPage:ClearAllPoints()
	ItemTextCurrentPage:SetPoint("TOP", GossipFrame.backdrop, "TOP", 0, -44)

	T.SkinCloseButton(ItemTextCloseButton, ItemTextFrame.backdrop)

	T.SkinNextPrevButton(ItemTextPrevPageButton)
	ItemTextPrevPageButton:ClearAllPoints()
	ItemTextPrevPageButton:SetPoint("TOPLEFT", ItemTextFrame, "TOPLEFT", 48, -50)
	T.SkinNextPrevButton(ItemTextNextPageButton)
	ItemTextNextPageButton:ClearAllPoints()
	ItemTextNextPageButton:SetPoint("TOPRIGHT", ItemTextFrame, "TOPRIGHT", -70, -50)

	T.SkinScrollBar(ItemTextScrollFrameScrollBar)

	ItemTextPageText:SetTextColor(1, 1, 1)
	ItemTextPageText.SetTextColor = T.dummy
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)