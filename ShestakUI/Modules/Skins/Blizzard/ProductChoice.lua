local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ProductChoice skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ProductChoiceFrame:StripTextures()
	ProductChoiceFrame.Inset:StripTextures()
	ProductChoiceFrame:SetTemplate("Transparent")
	T.SkinCloseButton(ProductChoiceFrameCloseButton)
	ProductChoiceFrame.Inset.ClaimButton:SkinButton()
	T.SkinNextPrevButton(ProductChoiceFrame.Inset.NextPageButton)
	T.SkinNextPrevButton(ProductChoiceFrame.Inset.PrevPageButton)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)