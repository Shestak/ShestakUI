local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DressUp skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	DressUpFrame:StripTextures(true)
	DressUpFrame:CreateBackdrop("Transparent")
	DressUpFrame.backdrop:SetPoint("TOPLEFT", 16, -12)
	DressUpFrame.backdrop:SetPoint("BOTTOMRIGHT", -30, 76)

	DressUpFrameResetButton:SkinButton()
	DressUpFrameCancelButton:SkinButton()
	DressUpFrameUndressButton:SkinButton()
	DressUpFrameOutfitDropDown.SaveButton:SkinButton()
	T.SkinCloseButton(DressUpFrameCloseButton, DressUpFrame.backdrop)
	DressUpFrameCancelButton:SetPoint("BOTTOMRIGHT", DressUpFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	DressUpFrameResetButton:SetPoint("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)
	T.SkinDropDownBox(DressUpFrameOutfitDropDown)
	DressUpFrameOutfitDropDown:SetSize(195, 34)

	DressUpFrameOutfitDropDown.SaveButton:ClearAllPoints()
	DressUpFrameOutfitDropDown.SaveButton:SetPoint("RIGHT", DressUpFrameOutfitDropDown, 86, 4)

	WardrobeOutfitFrame:StripTextures()
	WardrobeOutfitFrame:CreateBackdrop("Transparent")
	WardrobeOutfitFrame.backdrop:SetPoint("TOPLEFT", 2, -2)
	WardrobeOutfitFrame.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)

	SideDressUpFrame:StripTextures(true)
	SideDressUpFrame:SetTemplate("Transparent")
	SideDressUpModelResetButton:SkinButton()
	T.SkinCloseButton(SideDressUpModelCloseButton, SideDressUpFrame)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)