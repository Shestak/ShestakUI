local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TimeManager skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TimeManagerFrame:StripTextures()
	TimeManagerFrame:CreateBackdrop("Transparent")
	TimeManagerFrame.backdrop:Point("TOPLEFT", -3, 0)
	TimeManagerFrame.backdrop:Point("BOTTOMRIGHT", -3, 3)
	TimeManagerFrameInset:StripTextures()

	T.SkinCloseButton(TimeManagerFrameCloseButton, TimeManagerFrame.backdrop)

	T.SkinDropDownBox(TimeManagerAlarmHourDropDown, 70)
	T.SkinDropDownBox(TimeManagerAlarmMinuteDropDown, 70)
	T.SkinDropDownBox(TimeManagerAlarmAMPMDropDown, 70)

	T.SkinEditBox(TimeManagerAlarmMessageEditBox)
	TimeManagerAlarmMessageEditBox:Height(TimeManagerAlarmMessageEditBox:GetHeight() - 5)

	T.SkinCheckBox(TimeManagerAlarmEnabledButton)
	T.SkinCheckBox(TimeManagerMilitaryTimeCheck)
	T.SkinCheckBox(TimeManagerLocalTimeCheck)

	TimeManagerStopwatchFrame:StripTextures()
	TimeManagerStopwatchCheck:SetTemplate("Default")
	TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	TimeManagerStopwatchCheck:GetNormalTexture():ClearAllPoints()
	TimeManagerStopwatchCheck:GetNormalTexture():Point("TOPLEFT", 2, -2)
	TimeManagerStopwatchCheck:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)

	local hover = TimeManagerStopwatchCheck:CreateTexture("Frame", nil, TimeManagerStopwatchCheck)
	hover:SetTexture(1, 1, 1, 0.3)
	hover:Point("TOPLEFT", TimeManagerStopwatchCheck, 2, -2)
	hover:Point("BOTTOMRIGHT", TimeManagerStopwatchCheck, -2, 2)
	TimeManagerStopwatchCheck:SetHighlightTexture(hover)

	local checked = TimeManagerStopwatchCheck:CreateTexture("Frame", nil, TimeManagerStopwatchCheck)
	checked:SetTexture(0, 1, 0, 0.3)
	checked:Point("TOPLEFT", TimeManagerStopwatchCheck, 2, -2)
	checked:Point("BOTTOMRIGHT", TimeManagerStopwatchCheck, -2, 2)
	TimeManagerStopwatchCheck:SetCheckedTexture(checked)

	StopwatchFrame:StripTextures()
	StopwatchFrame:CreateBackdrop("Transparent")
	StopwatchFrame.backdrop:Point("TOPLEFT", 2, -15)
	StopwatchFrame.backdrop:Point("BOTTOMRIGHT", -2, 2)

	StopwatchTabFrame:StripTextures()

	T.SkinCloseButton(StopwatchCloseButton)
	T.SkinNextPrevButton(StopwatchPlayPauseButton)
	T.SkinNextPrevButton(StopwatchResetButton)
	StopwatchPlayPauseButton:Point("RIGHT", StopwatchResetButton, "LEFT", -4, 0)
	StopwatchResetButton:Point("BOTTOMRIGHT", StopwatchFrame, "BOTTOMRIGHT", -7, 7)
	StopwatchCloseButton:ClearAllPoints()
	StopwatchCloseButton:Point("BOTTOMRIGHT", StopwatchFrame.backdrop, "TOPRIGHT", 0, 3)
end

T.SkinFuncs["Blizzard_TimeManager"] = LoadSkin