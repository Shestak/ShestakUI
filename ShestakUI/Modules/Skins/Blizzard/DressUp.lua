local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DressUp skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	DressUpFrame:StripTextures()
	DressUpFrame:SetTemplate("Transparent")
	DressUpFramePortrait:Hide()
	DressUpFramePortraitFrame:Hide()
	DressUpFrameInset:Hide()

	MaximizeMinimizeFrame:StripTextures()
	MaximizeMinimizeFrame:SetSize(18, 18)
	MaximizeMinimizeFrame:SetPoint("RIGHT", DressUpFrameCloseButton, "LEFT", -2, 0)

	local MaximizeButton = MaximizeMinimizeFrame.MaximizeButton
	MaximizeButton:StripTextures()
	MaximizeButton:SetTemplate("Overlay")

	MaximizeButton.minus = MaximizeButton:CreateTexture(nil, "OVERLAY")
	MaximizeButton.minus:SetSize(7, 1)
	MaximizeButton.minus:SetPoint("CENTER")
	MaximizeButton.minus:SetTexture(C.media.blank)

	MaximizeButton.plus = MaximizeButton:CreateTexture(nil, "OVERLAY")
	MaximizeButton.plus:SetSize(1, 7)
	MaximizeButton.plus:SetPoint("CENTER")
	MaximizeButton.plus:SetTexture(C.media.blank)

	MaximizeButton:HookScript("OnEnter", T.SetModifiedBackdrop)
	MaximizeButton:HookScript("OnLeave", T.SetOriginalBackdrop)

	local MinimizeButton = MaximizeMinimizeFrame.MinimizeButton
	MinimizeButton:StripTextures()
	MinimizeButton:SetTemplate("Overlay")

	MinimizeButton.minus = MinimizeButton:CreateTexture(nil, "OVERLAY")
	MinimizeButton.minus:SetSize(7, 1)
	MinimizeButton.minus:SetPoint("CENTER")
	MinimizeButton.minus:SetTexture(C.media.blank)

	MinimizeButton:HookScript("OnEnter", T.SetModifiedBackdrop)
	MinimizeButton:HookScript("OnLeave", T.SetOriginalBackdrop)

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