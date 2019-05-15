local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Petition skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	PetitionFrame:StripTextures(true)
	PetitionFrameInset:StripTextures()
	PetitionFrame:CreateBackdrop("Transparent")
	PetitionFrame.backdrop:SetAllPoints()

	PetitionFrameSignButton:SkinButton()
	PetitionFrameRequestButton:SkinButton()
	PetitionFrameRenameButton:SkinButton()
	PetitionFrameCancelButton:SkinButton()
	T.SkinCloseButton(PetitionFrameCloseButton, PetitionFrame.backdrop)

	PetitionFrameCharterTitle:SetTextColor(1, 0.8, 0)
	PetitionFrameCharterTitle:SetShadowColor(0, 0, 0)
	PetitionFrameCharterName:SetTextColor(1, 1, 1)
	PetitionFrameMasterTitle:SetTextColor(1, 0.8, 0)
	PetitionFrameMasterTitle:SetShadowColor(0, 0, 0)
	PetitionFrameMasterName:SetTextColor(1, 1, 1)
	PetitionFrameMemberTitle:SetTextColor(1, 0.8, 0)
	PetitionFrameMemberTitle:SetShadowColor(0, 0, 0)

	for i = 1, 9 do
		_G["PetitionFrameMemberName"..i]:SetTextColor(1, 1, 1)
	end

	PetitionFrameInstructions:SetTextColor(1, 1, 1)

	PetitionFrameRenameButton:SetPoint("LEFT", PetitionFrameRequestButton, "RIGHT", 3, 0)
	PetitionFrameRenameButton:SetPoint("RIGHT", PetitionFrameCancelButton, "LEFT", -3, 0)
	PetitionFrameCancelButton:SetPoint("BOTTOMRIGHT", PetitionFrame, "BOTTOMRIGHT", -5, 4)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)