local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TrainerUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"ClassTrainerFrame",
		"ClassTrainerFrameInset",
		"ClassTrainerScrollFrameScrollChild",
		"ClassTrainerFrameSkillStepButton",
		"ClassTrainerFrameBottomInset"
	}

	local buttons = {
		"ClassTrainerTrainButton"
	}

	local KillTextures = {
		"ClassTrainerFramePortrait",
		"ClassTrainerScrollFrameScrollBarBG",
		"ClassTrainerScrollFrameScrollBarTop",
		"ClassTrainerScrollFrameScrollBarBottom",
		"ClassTrainerScrollFrameScrollBarMiddle"
	}

	for i = 1, 8 do
		_G["ClassTrainerScrollFrameButton"..i]:StripTextures()
		_G["ClassTrainerScrollFrameButton"..i]:StyleButton()
		_G["ClassTrainerScrollFrameButton"..i.."Icon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["ClassTrainerScrollFrameButton"..i]:CreateBackdrop("Default")
		_G["ClassTrainerScrollFrameButton"..i].backdrop:SetPoint("TOPLEFT", _G["ClassTrainerScrollFrameButton"..i.."Icon"], "TOPLEFT", -2, 2)
		_G["ClassTrainerScrollFrameButton"..i].backdrop:SetPoint("BOTTOMRIGHT", _G["ClassTrainerScrollFrameButton"..i.."Icon"], "BOTTOMRIGHT", 2, -2)
		_G["ClassTrainerScrollFrameButton"..i.."Icon"]:SetParent(_G["ClassTrainerScrollFrameButton"..i].backdrop)

		_G["ClassTrainerScrollFrameButton"..i].selectedTex:SetColorTexture(1, 1, 1, 0.3)
		_G["ClassTrainerScrollFrameButton"..i].selectedTex:ClearAllPoints()
		_G["ClassTrainerScrollFrameButton"..i].selectedTex:SetPoint("TOPLEFT", 2, -2)
		_G["ClassTrainerScrollFrameButton"..i].selectedTex:SetPoint("BOTTOMRIGHT", -2, 2)
	end

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

	ClassTrainerFrameSkillStepButton:ClearAllPoints()
	ClassTrainerFrameSkillStepButton:SetPoint("TOPRIGHT", ClassTrainerFrameFilterDropDown, "BOTTOMRIGHT", -16, 0)
	ClassTrainerFrameSkillStepButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	ClassTrainerFrameSkillStepButton:CreateBackdrop("Default")
	ClassTrainerFrameSkillStepButton.backdrop:SetPoint("TOPLEFT", ClassTrainerFrameSkillStepButton.icon, "TOPLEFT", -2, 2)
	ClassTrainerFrameSkillStepButton.backdrop:SetPoint("BOTTOMRIGHT", ClassTrainerFrameSkillStepButton.icon, "BOTTOMRIGHT", 2, -2)
	ClassTrainerFrameSkillStepButton.icon:SetParent(ClassTrainerFrameSkillStepButton.backdrop)
	ClassTrainerFrameSkillStepButtonHighlight:SetColorTexture(1, 1, 1, 0.3)
	ClassTrainerFrameSkillStepButton.selectedTex:SetColorTexture(1, 1, 1, 0.3)

	T.SkinScrollBar(ClassTrainerScrollFrameScrollBar)

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