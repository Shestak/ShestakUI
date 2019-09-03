local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AzeriteEssenceUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinHelpBox(AzeriteEssenceUI.EssenceList.Tutorial)

	AzeriteEssenceUI:StripTextures()
	AzeriteEssenceUI:SetTemplate("Transparent")

	T.SkinCloseButton(AzeriteEssenceUICloseButton)
end

T.SkinFuncs["Blizzard_AzeriteEssenceUI"] = LoadSkin