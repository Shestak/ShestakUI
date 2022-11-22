local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TrainerUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"ClassTrainerFrame",
		"ClassTrainerFrameSkillStepButton",
		"ClassTrainerFrameBottomInset"
	}

	local buttons = {
		"ClassTrainerTrainButton"
	}

	local KillTextures = {
		"ClassTrainerFramePortrait",
	}

	hooksecurefunc(ClassTrainerFrame.ScrollBox, "Update", function(frame)
		for _, button in next, {frame.ScrollTarget:GetChildren()} do
			if not button.IsSkinned then
				button:StyleButton()
				button.icon:SkinIcon()
				button:SetNormalTexture(0)
				button.disabledBG:SetTexture()
				button.selectedTex:ClearAllPoints()
				button.selectedTex:SetPoint("TOPLEFT", 2, -2)
				button.selectedTex:SetPoint("BOTTOMRIGHT", -2, 2)
				button.selectedTex:SetColorTexture(1, 1, 1, 0.3)

				button.IsSkinned = true
			end
		end
	end)

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton(true)
	end

	ClassTrainerFrame:CreateBackdrop("Transparent")
	ClassTrainerFrame.backdrop:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT")
	ClassTrainerFrame.backdrop:SetPoint("BOTTOMRIGHT", ClassTrainerFrame, "BOTTOMRIGHT")

	T.SkinDropDownBox(ClassTrainerFrameFilterDropDown)
	ClassTrainerFrameFilterDropDown:ClearAllPoints()
	ClassTrainerFrameFilterDropDown:SetPoint("TOPRIGHT", ClassTrainerFrame.backdrop, "TOPRIGHT", 4, -30)

	T.SkinCloseButton(ClassTrainerFrameCloseButton, ClassTrainerFrame)

	local stepButton = ClassTrainerFrameSkillStepButton
	stepButton:ClearAllPoints()
	stepButton:SetPoint("TOPRIGHT", ClassTrainerFrameFilterDropDown, "BOTTOMRIGHT", -16, 0)
	stepButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	stepButton:CreateBackdrop("Default")
	stepButton.backdrop:SetPoint("TOPLEFT", stepButton.icon, "TOPLEFT", -2, 2)
	stepButton.backdrop:SetPoint("BOTTOMRIGHT", stepButton.icon, "BOTTOMRIGHT", 2, -2)
	stepButton.icon:SetParent(stepButton.backdrop)
	ClassTrainerFrameSkillStepButtonHighlight:SetColorTexture(1, 1, 1, 0.3)
	ClassTrainerFrameSkillStepButtonHighlight:SetPoint("TOPLEFT", 2, 0)
	ClassTrainerFrameSkillStepButtonHighlight:SetPoint("BOTTOMRIGHT", -2, 0)
	stepButton.selectedTex:SetColorTexture(1, 1, 1, 0.3)

	T.SkinScrollBar(ClassTrainerFrame.ScrollBar)
	ClassTrainerFrame.ScrollBar:SetPoint("TOPLEFT", ClassTrainerFrame.ScrollBox, "TOPRIGHT", 0, 4)
	ClassTrainerFrame.ScrollBar:SetPoint("BOTTOMLEFT", ClassTrainerFrame.ScrollBox, "BOTTOMRIGHT", 0, -4)

	ClassTrainerStatusBar:StripTextures()
	ClassTrainerStatusBar:SetStatusBarTexture(C.media.texture)
	ClassTrainerStatusBar:CreateBackdrop("Overlay")
	ClassTrainerStatusBar:SetHeight(17)
	ClassTrainerStatusBar:ClearAllPoints()
	ClassTrainerStatusBar:SetPoint("RIGHT", ClassTrainerFrameFilterDropDown, "LEFT", 10, 3)
	ClassTrainerStatusBar.rankText:ClearAllPoints()
	ClassTrainerStatusBar.rankText:SetPoint("CENTER", ClassTrainerStatusBar, "CENTER")
end

T.SkinFuncs["Blizzard_TrainerUI"] = LoadSkin