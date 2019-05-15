local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Tutorial skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	for i = 1, MAX_TUTORIAL_ALERTS do
		local button = _G["TutorialFrameAlertButton"..i]
		local icon = button:GetNormalTexture()

		button:SetSize(35, 45)
		button:SetTemplate("Default", true)
		button:StyleButton(false)

		icon:SetInside()
		icon:SetTexCoord(0.09, 0.40, 0.11, 0.56)
	end

	TutorialFrame:StripTextures()
	TutorialFrame:CreateBackdrop("Transparent")
	TutorialFrame.backdrop:SetPoint("TOPLEFT", 6, 0)
	TutorialFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, -6)

	TutorialFrameOkayButton:SkinButton()
	TutorialFrameOkayButton:ClearAllPoints()
	TutorialFrameOkayButton:SetPoint("BOTTOMRIGHT", TutorialFrame.backdrop, "BOTTOMRIGHT", -4, 4)

	T.SkinCheckBox(TutorialFrameCheckButton, true)
	TutorialFrameCheckButton:ClearAllPoints()
	TutorialFrameCheckButton:SetPoint("BOTTOMLEFT", TutorialFrame.backdrop, "BOTTOMLEFT", 2, 2)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)