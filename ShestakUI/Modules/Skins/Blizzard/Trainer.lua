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

	T.SkinScrollBar(ClassTrainerFrame.ScrollBar)
	ClassTrainerFrame.ScrollBar:SetPoint("TOPLEFT", ClassTrainerFrame.ScrollBox, "TOPRIGHT", 0, 3)
	ClassTrainerFrame.ScrollBar:SetPoint("BOTTOMLEFT", ClassTrainerFrame.ScrollBox, "BOTTOMRIGHT", 0, -4)

	ClassTrainerStatusBar:StripTextures()
	ClassTrainerStatusBar:SetStatusBarTexture(C.media.texture)
	ClassTrainerStatusBar:CreateBackdrop("Overlay")
	ClassTrainerStatusBar:SetHeight(17)
	ClassTrainerStatusBar:ClearAllPoints()
	ClassTrainerStatusBar:SetPoint("RIGHT", ClassTrainerFrameFilterDropDown, "LEFT", 10, 3)
	ClassTrainerStatusBar.rankText:ClearAllPoints()
	ClassTrainerStatusBar.rankText:SetPoint("CENTER", ClassTrainerStatusBar, "CENTER")

	local stepButton = ClassTrainerFrameSkillStepButton
	stepButton:ClearAllPoints()
	stepButton:SetPoint("TOPRIGHT", ClassTrainerFrameFilterDropDown, "BOTTOMRIGHT", -16, 0)
	stepButton:CreateBackdrop("Overlay")
	stepButton.backdrop:SetPoint("BOTTOMRIGHT", 2, -3)
	stepButton:StyleButton(nil, nil, true)
	stepButton.icon:SkinIcon(true)
	stepButton.icon:SetPoint("LEFT", stepButton, "LEFT", 6, -1)
	stepButton.icon:SetSize(33, 33)
	stepButton.selectedTex:ClearAllPoints()
	stepButton.selectedTex:SetInside(stepButton.backdrop)
	stepButton.selectedTex:SetColorTexture(1, 0.82, 0, 0.3)

	hooksecurefunc(ClassTrainerFrame.ScrollBox, "Update", function(frame)
		for _, button in next, {frame.ScrollTarget:GetChildren()} do
			if not button.IsSkinned then
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 0, 0)
				button.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)
				button:StyleButton(nil, nil, true)
				button.icon:SkinIcon(true)
				button.icon:SetPoint("LEFT", button, "LEFT", 6, 1)
				button.icon:SetSize(33, 33)
				button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:SetNormalTexture(0)
				button.disabledBG:SetTexture()
				button.selectedTex:ClearAllPoints()
				button.selectedTex:SetInside(button.backdrop)
				button.selectedTex:SetColorTexture(1, 0.82, 0, 0.3)

				button.IsSkinned = true
			end
		end
	end)
end

T.SkinFuncs["Blizzard_TrainerUI"] = LoadSkin