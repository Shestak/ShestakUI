local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemText skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemTextFrame:StripTextures(true)
	ItemTextScrollFrame:StripTextures()
	ItemTextFrame:CreateBackdrop("Transparent")
	ItemTextFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	ItemTextFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	T.SkinCloseButton(ItemTextCloseButton, ItemTextFrame.backdrop)
	T.SkinNextPrevButton(ItemTextPrevPageButton)
	ItemTextPrevPageButton:ClearAllPoints()
	ItemTextPrevPageButton:SetPoint("TOPLEFT", ItemTextFrame, "TOPLEFT", 48, -50)
	T.SkinNextPrevButton(ItemTextNextPageButton)
	ItemTextNextPageButton:ClearAllPoints()
	ItemTextNextPageButton:SetPoint("TOPRIGHT", ItemTextFrame, "TOPRIGHT", -48, -50)
	T.SkinScrollBar(ItemTextScrollFrameScrollBar)
	ItemTextPageText:SetTextColor(1, 1, 1)
	ItemTextPageText.SetTextColor = T.dummy
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)