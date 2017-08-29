local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DressUp skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	DressUpFrame:StripTextures()
	DressUpFrame:CreateBackdrop("Transparent")
	DressUpFramePortrait:Hide()
	if T.wowbuild >= 24904 then
		DressUpFramePortraitFrame:Hide()
		DressUpFrameInset:Hide()
		MaximizeMinimizeFrame:StripTextures()
		MaximizeMinimizeFrame.MaximizeButton:Kill()
		MaximizeMinimizeFrame.MinimizeButton:Kill()
	else
		DressUpFrame.backdrop:SetPoint("TOPLEFT", 16, -12)
		DressUpFrame.backdrop:SetPoint("BOTTOMRIGHT", -30, 76)
	end

	DressUpFrameResetButton:SkinButton()
	DressUpFrameCancelButton:SkinButton()
	DressUpFrameUndressButton:SkinButton()
	DressUpFrameOutfitDropDown.SaveButton:SkinButton()
	DressUpFrameOutfitDropDown.SaveButton:ClearAllPoints()
	DressUpFrameOutfitDropDown.SaveButton:SetPoint("RIGHT", DressUpFrameOutfitDropDown, 86, 4)
	T.SkinDropDownBox(DressUpFrameOutfitDropDown)
	DressUpFrameOutfitDropDown:SetSize(195, 34)

	T.SkinCloseButton(DressUpFrameCloseButton, DressUpFrame.backdrop)
	DressUpFrameResetButton:SetPoint("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)

	-- Wardrobe edit frame
	WardrobeOutfitFrame:StripTextures(true)
	WardrobeOutfitFrame:SetTemplate("Transparent")

	WardrobeOutfitEditFrame:StripTextures(true)
	WardrobeOutfitEditFrame:SetTemplate("Transparent")
	WardrobeOutfitEditFrame.EditBox:StripTextures()
	T.SkinEditBox(WardrobeOutfitEditFrame.EditBox)
	WardrobeOutfitEditFrame.EditBox.backdrop:SetPoint("TOPLEFT", WardrobeOutfitEditFrame.EditBox, "TOPLEFT", -5, -5)
	WardrobeOutfitEditFrame.EditBox.backdrop:SetPoint("BOTTOMRIGHT", WardrobeOutfitEditFrame.EditBox, "BOTTOMRIGHT", 0, 5)
	WardrobeOutfitEditFrame.AcceptButton:SkinButton()
	WardrobeOutfitEditFrame.CancelButton:SkinButton()
	WardrobeOutfitEditFrame.DeleteButton:SkinButton()
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)