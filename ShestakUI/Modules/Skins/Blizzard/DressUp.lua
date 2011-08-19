local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DressUp skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	DressUpFrame:StripTextures(true)
	DressUpFrame:CreateBackdrop("Transparent")
	DressUpFrame.backdrop:Point("TOPLEFT", 16, -12)
	DressUpFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)

	DressUpFrameResetButton:SkinButton()
	DressUpFrameCancelButton:SkinButton()
	DressUpFrameUndressButton:SkinButton()
	T.SkinCloseButton(DressUpFrameCloseButton, DressUpFrame.backdrop)
	T.SkinRotateButton(DressUpModelRotateLeftButton)
	T.SkinRotateButton(DressUpModelRotateRightButton)
	DressUpModelRotateRightButton:Point("TOPLEFT", DressUpModelRotateLeftButton, "TOPRIGHT", 2, 0)
	DressUpFrameCancelButton:Point("BOTTOMRIGHT", DressUpFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	DressUpFrameResetButton:Point("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)