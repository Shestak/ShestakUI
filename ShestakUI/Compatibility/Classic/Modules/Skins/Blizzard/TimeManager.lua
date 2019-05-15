local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TimeManager skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TimeManagerFrame:StripTextures()
	TimeManagerFrame:CreateBackdrop("Transparent")
	TimeManagerFrame.backdrop:SetPoint("TOPLEFT", -3, 0)
	TimeManagerFrame.backdrop:SetPoint("BOTTOMRIGHT", -3, 3)
	TimeManagerFrameInset:StripTextures()

	T.SkinCloseButton(TimeManagerFrameCloseButton, TimeManagerFrame.backdrop)

	T.SkinDropDownBox(TimeManagerAlarmHourDropDown, 79)
	T.SkinDropDownBox(TimeManagerAlarmMinuteDropDown, 79)
	T.SkinDropDownBox(TimeManagerAlarmAMPMDropDown, 70)

	T.SkinEditBox(TimeManagerAlarmMessageEditBox, nil, TimeManagerAlarmMessageEditBox:GetHeight() - 5)

	T.SkinCheckBox(TimeManagerAlarmEnabledButton)
	T.SkinCheckBox(TimeManagerMilitaryTimeCheck)
	T.SkinCheckBox(TimeManagerLocalTimeCheck)

	TimeManagerStopwatchFrame:StripTextures()
	TimeManagerStopwatchCheck:StyleButton(true)
	TimeManagerStopwatchCheck:SetTemplate("Default")
	TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	TimeManagerStopwatchCheck:GetNormalTexture():ClearAllPoints()
	TimeManagerStopwatchCheck:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	TimeManagerStopwatchCheck:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)

	StopwatchFrame:StripTextures()
	StopwatchFrame:CreateBackdrop("Transparent")
	StopwatchFrame.backdrop:SetPoint("TOPLEFT", 2, -15)
	StopwatchFrame.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)

	StopwatchTabFrame:StripTextures()

	T.SkinCloseButton(StopwatchCloseButton)
	T.SkinNextPrevButton(StopwatchPlayPauseButton)
	T.SkinNextPrevButton(StopwatchResetButton)
	StopwatchPlayPauseButton:SetPoint("RIGHT", StopwatchResetButton, "LEFT", -4, 0)
	StopwatchResetButton:SetPoint("BOTTOMRIGHT", StopwatchFrame, "BOTTOMRIGHT", -7, 7)
	StopwatchCloseButton:ClearAllPoints()
	StopwatchCloseButton:SetPoint("BOTTOMRIGHT", StopwatchFrame.backdrop, "TOPRIGHT", 0, 3)
end

T.SkinFuncs["Blizzard_TimeManager"] = LoadSkin