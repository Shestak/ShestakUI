local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ObliterumUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ObliterumForgeFrame:StripTextures()
	ObliterumForgeFrame:SetTemplate("Transparent")

	ObliterumForgeFrame.ItemSlot:StripTextures()
	ObliterumForgeFrame.ItemSlot.Icon:SkinIcon()

	ObliterumForgeFrame.ObliterateButton:SkinButton()
	T.SkinCloseButton(ObliterumForgeFrameCloseButton)
end

T.SkinFuncs["Blizzard_ObliterumUI"] = LoadSkin