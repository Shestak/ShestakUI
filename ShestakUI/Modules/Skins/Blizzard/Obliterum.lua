local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ObliterumUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ObliterumForgeFrame:SetTemplate("Transparent")
	ObliterumForgeFrame.NineSlice:Hide()

	ObliterumForgeFrameInset:Hide()
	ObliterumForgeFramePortrait:Hide()
	ObliterumForgeFrame.TitleBg:Hide()
	ObliterumForgeFrame.TopTileStreaks:SetTexture("")
	ObliterumForgeFrameBg:Hide()

	ObliterumForgeFrame.ItemSlot.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	ObliterumForgeFrame.ObliterateButton:SkinButton()
	T.SkinCloseButton(ObliterumForgeFrameCloseButton)
end

T.SkinFuncs["Blizzard_ObliterumUI"] = LoadSkin