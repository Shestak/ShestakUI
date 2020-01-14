local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ProductChoice skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if T.wowBuild < 33050 then -- FIXME
		ProductChoiceFrame:StripTextures()
		ProductChoiceFrame.Inset:StripTextures()
		ProductChoiceFrame:SetTemplate("Transparent")
		T.SkinCloseButton(ProductChoiceFrameCloseButton)
		ProductChoiceFrame.Inset.ClaimButton:SkinButton()
		T.SkinNextPrevButton(ProductChoiceFrame.Inset.NextPageButton)
		T.SkinNextPrevButton(ProductChoiceFrame.Inset.PrevPageButton)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)