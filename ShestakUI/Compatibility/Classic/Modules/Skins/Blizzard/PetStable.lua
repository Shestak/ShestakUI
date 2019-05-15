local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PetStable skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	PetStableFrame:StripTextures(true)
	PetStableFrame:CreateBackdrop("Transparent")
	PetStableFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	PetStableFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(PetStableFrameCloseButton, PetStableFrame.backdrop)

	PetStableFrame:DisableDrawLayer("BACKGROUND")

	PetStableTitleLabel:ClearAllPoints()
	PetStableTitleLabel:SetPoint("TOP", PetStableFrame.backdrop, "TOP", 0, -6)

	T.SkinRotateButton(PetStableModelRotateLeftButton)
	T.SkinRotateButton(PetStableModelRotateRightButton)
	PetStableModelRotateRightButton:ClearAllPoints()
	-- PetStableModelRotateRightButton:SetPoint("LEFT", PetStableModelRotateLeftButton, "RIGHT", 3, 0)

	local buttons = {
		"PetStableCurrentPet",
		"PetStableStabledPet1",
		"PetStableStabledPet2",
	}

	for _, v in pairs(buttons) do
		local button = _G[v]
		local icon = _G[v.."IconTexture"]

		button:StripTextures()
		button:StyleButton()
		button:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)