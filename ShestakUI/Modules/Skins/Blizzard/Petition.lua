local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Petition skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	PetitionFrame:StripTextures(true)
	PetitionFrame:CreateBackdrop("Transparent")
	PetitionFrame.backdrop:Point("TOPLEFT", 16, -12)
	PetitionFrame.backdrop:Point("BOTTOMRIGHT", -30, -3)

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

	PetitionFrameRenameButton:Point("LEFT", PetitionFrameRequestButton, "RIGHT", 3, 0)
	PetitionFrameRenameButton:Point("RIGHT", PetitionFrameCancelButton, "LEFT", -3, 0)
	PetitionFrame:Height(PetitionFrame:GetHeight() - 80)

	PetitionFrameCancelButton:Point("BOTTOMRIGHT", PetitionFrame, "BOTTOMRIGHT", -40, 3)
	PetitionFrameRequestButton:Point("BOTTOMLEFT", PetitionFrame, "BOTTOMLEFT", 25, 3)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)