local T, C, L, _ = unpack(select(2, ...))
if C.skins.combustion_helper ~= true or T.class ~= "MAGE" then return end

----------------------------------------------------------------------------------------
--	CombustionHelper skin
----------------------------------------------------------------------------------------
local CBHSkin = CreateFrame("Frame")
CBHSkin:RegisterEvent("PLAYER_LOGIN")
CBHSkin:RegisterEvent("PLAYER_TALENT_UPDATE")
CBHSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("CombustionHelper") then return end

	CombustionFrame:SetTemplate("Transparent")
	CombustionFrame.SetBackdrop = T.dummy

	CombuMBTrackerBorderFrame:SetTemplate("Transparent")
	CombuMBTrackerBorderFrame.SetBackdrop = T.dummy

	CombuCautscalevar = 1
	combusettingstable.combuscale = 1
	combusettingstable.combuchat = false
	combusettingstable.combureport = false
	combusettingstable.combureportpyro = false
	combusettingstable.combuignitereport = false
	combusettingstable.combureportmunching = false
	combusettingstable.combureportthreshold = false
	combusettingstable.combutexturename = "Smooth"
	combusettingstable.combumbtrackertexturename = "Smooth"
	combusettingstable.combufontname = "Hooge"
	combusettingstable.combumbtrackerfontname = "Hooge"
	combusettingstable.bgcolornormal = {unpack(C.media.overlay_color)}
	combusettingstable.edgecolornormal = {unpack(C.media.border_color)}
	combusettingstable.bgcolorcombustion = {0, 1, 0, C.media.overlay_color[4]}
	combusettingstable.bgcolorimpact = {1, 1, 0, C.media.overlay_color[4]}

	combumbtrackersettingstable.combumbtrackerscale = 1
	combumbtrackersettingstable.combumbtrackerchat = false
	combumbtrackersettingstable.combumbtrackerrefreshmode = false
	combumbtrackersettingstable.combumbtrackerfontname = "Hooge"
	combumbtrackersettingstable.combumbtrackertexturename = "Smooth"
	combumbtrackersettingstable.bgcolornormal = {unpack(C.media.overlay_color)}
	combumbtrackersettingstable.edgecolornormal = {unpack(C.media.border_color)}

	--RegPyroButton:Hide()
	--RegIgniteButton:Hide()
	--RegLBButton:Hide()

	if CombuCautenablevar == true then
		CombuCautTimerText:SetFont(C.font.stylization_font, (C.font.stylization_font_size / combusettingstable.combuscale) * 2, C.font.stylization_font_style)
		CombuCautTimerText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		CombuCautFrame:SetTemplate("Default")
		CombuCautIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		CombuCautIcon:ClearAllPoints()
		CombuCautIcon:Point("TOPLEFT", 2, -2)
		CombuCautIcon:Point("BOTTOMRIGHT", -2, 2)
	end

	for _, label in ipairs({RegLBLabel, RegIgniteLabel, RegPyroLabel, RegLBTextFrameLabel, RegIgnTextFrameLabel, RegPyroTextFrameLabel, RegStatusTextFrameLabel}) do
		label:SetFont(C.font.stylization_font, C.font.stylization_font_size / combusettingstable.combuscale, C.font.stylization_font_style)
		label:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	end

	for _, bar in ipairs({RegLBbar, RegIgnbar, RegPyrobar, RegCombubar}) do
		bar:SetHeight(C.font.stylization_font_size)
	end

	-- Options
	CombuOptionsTooltipFrame:SetTemplate("Transparent")
	CombuOptionsTooltipTitle:SetFont(C.media.normal_font, 13)
	CombuOptionsTooltipTitle:SetShadowOffset(1, -1)
	CombuOptionsTooltipText:SetFont(C.media.normal_font, 11)
	CombuOptionsTooltipText:SetShadowOffset(1, -1)

	local buttons = {
		"CombuvalueokButton",
		"CombutimerokButton",
		"ComburesetButton",
		"CombuCautAnnounceEditBoxokButton",
		"CombuCautAnnounceAltEditBoxokButton",
		"CombuCautresetButton",
		"CombuMBTrackerresetButton"
	}

	for i = 1, getn(buttons) do
		_G[buttons[i]]:SkinButton()
	end

	local checkboxes = {
		"CombulockButton",
		"CombureportButton",
		"Combureportthreshold",
		"CombuMunchingButton",
		"ComburefreshpyroButton",
		"CombuimpactButton",
		"CombutrackerButton",
		"CombuchatButton",
		"CombuThresholdSoundButton",
		"CombuBarButton",
		"CombuTileButton",
		"CombuCautEnableButton",
		"CombuCautlockButton",
		"CombuCautHideButton",
		"CombuCautTimerButton",
		"CombuCautChatAloneButton",
		"CombuCautAnnounceRaidButton",
		"CombuCautAnnounceSayButton",
		"CombuCautAnnounceYellButton",
		"CombuCautAnnounceAltButton",
		"CombuMBTrackertargetButton",
		"CombuMBTrackerFlamestrikeButton",
		"CombuMBTrackerlockButton",
		"CombuMBTrackerButton",
		"CombuMBTrackerchatButton",
		"CombuMBTrackerrefreshButton",
		"CombuMBTrackerTileButton"
	}

	for i = 1, getn(checkboxes) do
		T.SkinCheckBox(_G[checkboxes[i]])
	end
end)