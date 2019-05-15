local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PetStable skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	PetStableFrame:StripTextures(true)
	PetStableLeftInset:StripTextures(true)
	PetStableFrameInset:StripTextures(true)
	PetStableBottomInset:StripTextures(true)
	PetStableModelShadow:StripTextures(true)

	PetStableFrame:CreateBackdrop("Transparent")

	T.SkinRotateButton(PetStableModelRotateLeftButton)
	T.SkinRotateButton(PetStableModelRotateRightButton)
	PetStableModelRotateRightButton:ClearAllPoints()
	PetStableModelRotateRightButton:SetPoint("LEFT", PetStableModelRotateLeftButton, "RIGHT", 3, 0)

	T.SkinNextPrevButton(PetStablePrevPageButton, nil, "Any")
	T.SkinNextPrevButton(PetStableNextPageButton, nil, "Any")

	T.SkinCloseButton(PetStableFrameCloseButton)

	for i = 1, NUM_PET_ACTIVE_SLOTS do
		local button = _G["PetStableActivePet"..i]
		local icon = _G["PetStableActivePet"..i.."IconTexture"]

		button:StripTextures()
		button:StyleButton()
		button:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	for i = 1, NUM_PET_STABLE_SLOTS do
		local button = _G["PetStableStabledPet"..i]
		local icon = _G["PetStableStabledPet"..i.."IconTexture"]

		button:StripTextures()
		button:StyleButton()
		button:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	PetStableSelectedPetIcon:SkinIcon()

	PetStableDiet:StripTextures()
	PetStableDiet:SetSize(20, 20)
	PetStableDiet:SetPoint("TOPRIGHT", -9, -2)

	PetStableDietTexture:SetTexture("Interface\\Icons\\ability_hunter_beasttraining")
	PetStableDietTexture:SkinIcon()
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)