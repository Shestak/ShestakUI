local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ObliterumUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ObliterumForgeFrame:SetTemplate("Transparent")

	ObliterumForgeFrameInset:Hide()
	ObliterumForgeFramePortrait:Hide()
	ObliterumForgeFramePortraitFrame:Hide()
	ObliterumForgeFrameTitleBg:Hide()
	ObliterumForgeFrameBg:Hide()
	ObliterumForgeFrameTopBorder:Hide()
	ObliterumForgeFrameTopRightCorner:Hide()
	ObliterumForgeFrameRightBorder:Hide()
	ObliterumForgeFrameLeftBorder:Hide()
	ObliterumForgeFrameBtnCornerRight:Hide()
	ObliterumForgeFrameBotRightCorner:Hide()
	ObliterumForgeFrameBtnCornerLeft:Hide()
	ObliterumForgeFrameBotLeftCorner:Hide()
	ObliterumForgeFrameBottomBorder:Hide()
	ObliterumForgeFrameButtonBottomBorder:Hide()
	ObliterumForgeFrame.ObliterateButton.RightSeparator:Hide()
	ObliterumForgeFrame.ObliterateButton.LeftSeparator:Hide()

	ObliterumForgeFrame.ObliterateButton:SkinButton()
	T.SkinCloseButton(ObliterumForgeFrameCloseButton)
end

T.SkinFuncs["Blizzard_ObliterumUI"] = LoadSkin