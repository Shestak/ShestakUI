local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TimeManager skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TimeManagerFrame:StripTextures()
	TimeManagerFrame:CreateBackdrop("Transparent")
	TimeManagerFrame.backdrop:Point("TOPLEFT", 0, 0)
	TimeManagerFrame.backdrop:Point("BOTTOMRIGHT", -50, 0)

	T.SkinCloseButton(TimeManagerCloseButton, TimeManagerFrame.backdrop)

	T.SkinDropDownBox(TimeManagerAlarmHourDropDown, 70)
	T.SkinDropDownBox(TimeManagerAlarmMinuteDropDown, 70)
	T.SkinDropDownBox(TimeManagerAlarmAMPMDropDown, 70)

	T.SkinEditBox(TimeManagerAlarmMessageEditBox)
	TimeManagerAlarmMessageEditBox:Height(TimeManagerAlarmMessageEditBox:GetHeight() - 5)

	TimeManagerAlarmEnabledButton:SkinButton(true)
	TimeManagerAlarmEnabledButton:HookScript("OnClick", function(self)
		self:SkinButton()
	end)

	TimeManagerFrame:HookScript("OnShow", function(self)
		TimeManagerAlarmEnabledButton:SkinButton()
	end)

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