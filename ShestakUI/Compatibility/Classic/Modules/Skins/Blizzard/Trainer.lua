local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return else return end -- incomplete

----------------------------------------------------------------------------------------
--	TrainerUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ClassTrainerFrame:StripTextures(true)
	ClassTrainerFrame:CreateBackdrop("Transparent")
	ClassTrainerFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	ClassTrainerFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(ClassTrainerFrameCloseButton, ClassTrainerFrame.backdrop)

	ClassTrainerNameText:ClearAllPoints()
	ClassTrainerNameText:SetPoint("TOP", ClassTrainerFrame.backdrop, "TOP", 0, -6)
	ClassTrainerGreetingText:ClearAllPoints()
	ClassTrainerGreetingText:SetPoint("TOP", ClassTrainerNameText, "BOTTOM", 0, -4)

	ClassTrainerCancelButton:SkinButton()
	ClassTrainerTrainButton:SkinButton()
	ClassTrainerTrainButton:ClearAllPoints()
	ClassTrainerTrainButton:SetPoint("RIGHT", ClassTrainerCancelButton, "LEFT", -2, 0)

	T.SkinDropDownBox(ClassTrainerFrameFilterDropDown)

	ClassTrainerListScrollFrame:StripTextures()
	T.SkinScrollBar(ClassTrainerListScrollFrameScrollBar)

	ClassTrainerDetailScrollFrame:StripTextures()
	T.SkinScrollBar(ClassTrainerDetailScrollFrameScrollBar)

	ClassTrainerSkillIcon:StripTextures()
    ClassTrainerSkillIcon:SkinButton()
    --[[
	hooksecurefunc("ClassTrainer_SetSelection", function()
      HandleIcon(ClassTrainerSkillIcon, ClassTrainerSkillIcon:GetNormalTexture())
    end, 1)
	--]]

	ClassTrainerExpandButtonFrame:StripTextures()
    ClassTrainerCollapseAllButton:StripTextures()
    -- SkinCollapseButton(ClassTrainerCollapseAllButton, true)

    --[[
	for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED do
      SkinCollapseButton(_G["ClassTrainerSkill"..i])
    end
	--]]
end

T.SkinFuncs["Blizzard_TrainerUI"] = LoadSkin