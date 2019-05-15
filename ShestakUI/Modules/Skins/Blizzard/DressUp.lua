local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DressUp skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	DressUpFrame:StripTextures()
	DressUpFrame:SetTemplate("Transparent")
	DressUpFramePortrait:Hide()
	DressUpFrameInset:Hide()

	DressUpModel:CreateBackdrop("Default")
	DressUpModel.backdrop:SetPoint("TOPLEFT", -3, 4)
	DressUpModel.backdrop:SetPoint("BOTTOMRIGHT", 2, 1)
	DressUpFrame.ModelBackground:SetDrawLayer("BACKGROUND", 3)

	T.SkinMaxMinFrame(MaximizeMinimizeFrame, DressUpFrameCloseButton)

	DressUpFrameCancelButton:SkinButton()
	DressUpFrameResetButton:SkinButton()
	DressUpFrameResetButton:SetPoint("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)
	DressUpFrameUndressButton:SkinButton()

	T.SkinDropDownBox(DressUpFrameOutfitDropDown)
	DressUpFrameOutfitDropDown:SetSize(195, 34)
	DressUpFrameOutfitDropDown.SaveButton:SkinButton()
	DressUpFrameOutfitDropDown.SaveButton:ClearAllPoints()
	DressUpFrameOutfitDropDown.SaveButton:SetPoint("RIGHT", DressUpFrameOutfitDropDown, 86, 4)

	T.SkinCloseButton(DressUpFrameCloseButton, DressUpFrame.backdrop)

	SideDressUpFrame:StripTextures()
	SideDressUpFrame:SetTemplate("Transparent")
	SideDressUpModelResetButton:SkinButton()
	T.SkinCloseButton(SideDressUpModelCloseButton, SideDressUpFrame)

	WardrobeOutfitFrame:StripTextures(true)
	WardrobeOutfitFrame:CreateBackdrop("Transparent")
	WardrobeOutfitFrame.backdrop:SetPoint("TOPLEFT", WardrobeOutfitFrame, "TOPLEFT", 6, -6)
	WardrobeOutfitFrame.backdrop:SetPoint("BOTTOMRIGHT", WardrobeOutfitFrame, "BOTTOMRIGHT", -6, 6)

	WardrobeOutfitEditFrame:StripTextures(true)
	WardrobeOutfitEditFrame:SetTemplate("Transparent")
	WardrobeOutfitEditFrame.AcceptButton:SkinButton()
	WardrobeOutfitEditFrame.CancelButton:SkinButton()
	WardrobeOutfitEditFrame.DeleteButton:SkinButton()
	T.SkinEditBox(WardrobeOutfitEditFrame.EditBox)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)