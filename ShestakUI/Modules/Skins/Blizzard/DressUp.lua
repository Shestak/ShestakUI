local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DressUp skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	DressUpFrame:StripTextures()
	DressUpFrame:SetTemplate("Transparent")
	DressUpFramePortrait:Hide()
	DressUpFrameInset:Hide()

	DressUpFrame.ModelScene:CreateBackdrop("Default")
	DressUpFrame.ModelScene.backdrop:SetPoint("TOPLEFT", -3, 4)
	DressUpFrame.ModelScene.backdrop:SetPoint("BOTTOMRIGHT", 2, 1)
	DressUpFrame.ModelBackground:SetDrawLayer("BACKGROUND", 3)

	T.SkinMaxMinFrame(DressUpFrame.MaximizeMinimizeFrame, DressUpFrameCloseButton)

	DressUpFrameCancelButton:SkinButton()
	DressUpFrameResetButton:SkinButton()
	DressUpFrameResetButton:SetPoint("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)
	DressUpFrameUndressButton:SkinButton()

	local button = DressUpFrame.ToggleOutfitDetailsButton
	button:SetNormalTexture(134331)
	button:SetPushedTexture(134331)
	button:StyleButton(true)
	button:SetTemplate("Default")
	button:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button:GetNormalTexture():SetInside()
	button:GetPushedTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button:GetPushedTexture():SetInside()

	DressUpFrame.OutfitDetailsPanel:StripTextures()
	DressUpFrame.OutfitDetailsPanel:CreateBackdrop("Transparent")
	DressUpFrame.OutfitDetailsPanel.backdrop:SetPoint("TOPLEFT", 11, 0)
	DressUpFrame.OutfitDetailsPanel.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

	hooksecurefunc(DressUpFrame.OutfitDetailsPanel, "Refresh", function(self)
		if self.slotPool then
			for slot in self.slotPool:EnumerateActive() do
				if not slot.skinned then
					slot.Icon:SkinIcon()
					slot.IconBorder:SetAlpha(0)
					slot.skinned = true
				end
				local point, relativeTo, relativePoint, xOfs, yOfs = slot:GetPoint()
				if yOfs == 0 then
					slot:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs - 3)
				end
			end
		end
	end)

	DressUpFrame.LinkButton:SkinButton()
	DressUpFrame.LinkButton:SetPoint("BOTTOMLEFT", 4, 4)

	T.SkinDropDownBox(DressUpFrameOutfitDropDown)
	DressUpFrameOutfitDropDown:SetSize(195, 34)
	DressUpFrameOutfitDropDown.SaveButton:SkinButton()
	DressUpFrameOutfitDropDown.SaveButton:ClearAllPoints()
	DressUpFrameOutfitDropDown.SaveButton:SetPoint("RIGHT", DressUpFrameOutfitDropDown, 86, 4)

	T.SkinCloseButton(DressUpFrameCloseButton, DressUpFrame.backdrop)

	SideDressUpFrame:StripTextures()
	SideDressUpFrame:SetTemplate("Transparent")
	SideDressUpFrame.ResetButton:SkinButton()
	SideDressUpFrame.BGTopLeft:SetPoint("TOPLEFT", 2, -2)
	SideDressUpFrame.BGTopLeft:SetSize(183, 292)
	SideDressUpFrame.BGBottomLeft:SetSize(183, 93)
	T.SkinCloseButton(SideDressUpFrameCloseButton, SideDressUpFrame)

	WardrobeOutfitFrame:StripTextures(true)
	WardrobeOutfitFrame:CreateBackdrop("Transparent")
	WardrobeOutfitFrame.backdrop:SetPoint("TOPLEFT", WardrobeOutfitFrame, "TOPLEFT", 6, -6)
	WardrobeOutfitFrame.backdrop:SetPoint("BOTTOMRIGHT", WardrobeOutfitFrame, "BOTTOMRIGHT", -6, 6)

	WardrobeOutfitEditFrame:StripTextures(true)
	WardrobeOutfitEditFrame:SetTemplate("Transparent")
	WardrobeOutfitEditFrame.AcceptButton:SkinButton()
	WardrobeOutfitEditFrame.CancelButton:SkinButton()
	WardrobeOutfitEditFrame.DeleteButton:SkinButton()
	T.SkinEditBox(WardrobeOutfitEditFrame.EditBox, 250, 25)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)