local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemText skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemTextFrame:StripTextures(true)
	ItemTextFrameInset:StripTextures()
	ItemTextScrollFrame:StripTextures()
	ItemTextFrame:CreateBackdrop("Transparent")
	ItemTextFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	ItemTextFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	T.SkinCloseButton(ItemTextFrameCloseButton, ItemTextFrame.backdrop)
	T.SkinNextPrevButton(ItemTextPrevPageButton)
	T.SkinNextPrevButton(ItemTextNextPageButton)
	T.SkinScrollBar(ItemTextScrollFrameScrollBar)
	ItemTextPageText:SetTextColor(1, 1, 1)
	ItemTextPageText.SetTextColor = T.dummy
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)