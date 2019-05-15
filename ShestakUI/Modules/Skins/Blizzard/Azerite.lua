local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AzeriteUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	AzeriteEmpoweredItemUI:StripTextures()
	AzeriteEmpoweredItemUI:SetTemplate("Transparent")

	AzeriteEmpoweredItemUI.BorderFrame:StripTextures()

	AzeriteEmpoweredItemUIPortrait:Hide()
	AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame.Bg:Hide()

	T.SkinCloseButton(AzeriteEmpoweredItemUICloseButton)
end

T.SkinFuncs["Blizzard_AzeriteUI"] = LoadSkin