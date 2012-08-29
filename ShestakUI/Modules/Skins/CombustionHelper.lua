local T, C, L = unpack(select(2, ...))
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
	LBtrackFrame:SetTemplate("Transparent")

	CombuCautscalevar = 1
	combusettingstable.combuscale = 1
	combusettingstable.comburefreshmode = false
	combusettingstable.combuchat = false
	combusettingstable.combureport = false
	combusettingstable.combureportpyro = false
	combusettingstable.combuignitereport = false
	combusettingstable.combureportmunching = false
	combusettingstable.combureportthreshold = false
	combusettingstable.combutexturename = "Smooth"

	combusettingstable.bgcolornormal = {unpack(C.media.overlay_color)}
	combusettingstable.edgecolornormal = {unpack(C.media.border_color)}
	combusettingstable.bgcolorcombustion = {0, 1, 0, C.media.overlay_color[4]}
	combusettingstable.bgcolorimpact = {1, 1, 0, C.media.overlay_color[4]}

	--FFBButton:Hide()
	--PyroButton:Hide()
	--IgniteButton:Hide()
	--LBButton:Hide()

	if CombuCautenablevar == true then
		CombuCautTimerText:SetFont(C.font.stylization_font, (C.font.stylization_font_size / combusettingstable.combuscale) * 2, C.font.stylization_font_style)
		CombuCautTimerText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		CombuCautFrame:SetTemplate("Default")
		CombuCautIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		CombuCautIcon:ClearAllPoints()
		CombuCautIcon:Point("TOPLEFT", 2, -2)
		CombuCautIcon:Point("BOTTOMRIGHT", -2, 2)
	end

	if combusettingstable.combubartimers == true then
		combusettingstable.combubarwidth = 55

		for _, label in ipairs({LBLabel, IgniteLabel, PyroLabel, FFBLabel, LBTextFrameLabel, IgnTextFrameLabel, PyroTextFrameLabel, FFBTextFrameLabel, CritTypeFrameLabel, CritTextFrameLabel, StatusTextFrameLabel, LBtrack1, LBtrack2, LBtrack3, LBtrack4, LBtrack5, LBtrack1Timer, LBtrack2Timer, LBtrack3Timer, LBtrack4Timer, LBtrack5Timer}) do
			label:SetFont(C.font.stylization_font, C.font.stylization_font_size / combusettingstable.combuscale, C.font.stylization_font_style)
			label:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end

		for _, label in ipairs({LBLabel, IgniteLabel, PyroLabel, FFBLabel}) do
			label:SetWidth(combusettingstable.combubarwidth + 10)
		end

		for _, label in ipairs({LBtrack1Timer, LBtrack2Timer, LBtrack3Timer, LBtrack4Timer, LBtrack5Timer}) do
			label:SetWidth(combusettingstable.combubarwidth - 15)
		end

		for _, bar in ipairs({LBbar, Ignbar, Pyrobar, FFBbar, Critbar, Combubar}) do
			bar:SetHeight(C.font.stylization_font_size)
		end

		CombustionFrame:SetWidth((LBLabel:GetWidth() * 2) + 42)
		StatusTextFrameLabel:SetWidth(CombustionFrame:GetWidth() - 10)
		Combubar:SetWidth(CombustionFrame:GetWidth() - 10)

		for _, label in ipairs({CritTypeFrameLabel, CritTextFrameLabel}) do
			label:SetWidth(CombustionFrame:GetWidth() - 12)
		end

		for _, bar in ipairs({LBtrack1Bar, LBtrack2Bar, LBtrack3Bar, LBtrack4Bar, LBtrack5Bar}) do
			bar:SetHeight(C.font.stylization_font_size)
			bar:SetWidth(LBtrackFrame:GetWidth() - 15)
		end
	else
		combusettingstable.combubarwidth = 132

		CombustionFrame:SetWidth(132)
		CombustionFrame:SetHeight(77)
		LBtrackFrame:SetWidth(132)

		for _, label in ipairs({LBLabel, IgniteLabel, PyroLabel, FFBLabel, LBTextFrameLabel, IgnTextFrameLabel, PyroTextFrameLabel, FFBTextFrameLabel, StatusTextFrameLabel, LBtrack1, LBtrack2, LBtrack3, LBtrack4, LBtrack5, LBtrack1Timer, LBtrack2Timer, LBtrack3Timer, LBtrack4Timer, LBtrack5Timer}) do
			label:SetTextHeight(C.font.stylization_font_size + 5)
			label:SetHeight(C.font.stylization_font_size + 5)
			label:SetFont(C.font.stylization_font, C.font.stylization_font_size / combusettingstable.combuscale, C.font.stylization_font_style)
			label:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end

		for _, label in ipairs({LBLabel, IgniteLabel, PyroLabel, FFBLabel}) do
			label:SetWidth(85)
		end

		for _, label in ipairs({LBtrack1Timer, LBtrack2Timer, LBtrack3Timer, LBtrack4Timer, LBtrack5Timer}) do
			label:SetWidth(62)
		end

		for _, label in ipairs({CritTypeFrameLabel, CritTextFrameLabel}) do
			label:SetWidth(118)
			label:SetTextHeight(C.font.stylization_font_size + 5)
			label:SetHeight(C.font.stylization_font_size + 5)
			label:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			label:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end

		for _, bar in ipairs({LBbar, Ignbar, Pyrobar, FFBbar, Critbar, Combubar}) do
			bar:SetHeight(C.font.stylization_font_size + 5)
			bar:SetWidth(118)
		end

		for _, bar in ipairs({LBtrack1Bar, LBtrack2Bar, LBtrack3Bar, LBtrack4Bar, LBtrack5Bar}) do
			bar:SetHeight(C.font.stylization_font_size)
			bar:SetWidth(LBtrackFrame:GetWidth() - 15)
		end

		StatusTextFrameLabel:SetWidth(CombustionFrame:GetWidth() - 10)
		Combubar:SetWidth(CombustionFrame:GetWidth() - 10)
	end

	if combusettingstable.combulbup == true then
		LBtrackFrame:SetPoint("BOTTOMLEFT", CombustionFrame, "TOPLEFT", 0, 3)
		LBtrackFrame:SetPoint("BOTTOMRIGHT", CombustionFrame, "TOPRIGHT", 0, 3)
	elseif combusettingstable.combulbdown == true then
		LBtrackFrame:SetPoint("TOPLEFT", CombustionFrame, "BOTTOMLEFT", 0, -3)
		LBtrackFrame:SetPoint("TOPRIGHT", CombustionFrame, "BOTTOMRIGHT", 0, -3)
	elseif combusettingstable.combulbright == true then
		LBtrackFrame:SetPoint("TOPLEFT", CombustionFrame, "TOPRIGHT", 3, 0)
	elseif combusettingstable.combulbleft == true then
		LBtrackFrame:SetPoint("TOPRIGHT", CombustionFrame, "TOPLEFT", -3, 0)
	else
		LBtrackFrame:SetPoint("BOTTOMLEFT", CombustionFrame, "TOPLEFT", 0, 3)
		LBtrackFrame:SetPoint("BOTTOMRIGHT", CombustionFrame, "TOPRIGHT", 0, 3)
	end

	-- Options
	CombuOptionsTooltipFrame:SetTemplate("Transparent")
	CombuOptionsTooltipTitle:SetFont(C.media.normal_font, 13)
	CombuOptionsTooltipTitle:SetShadowOffset(1, -1)
	CombuOptionsTooltipText:SetFont(C.media.normal_font, 11)
	CombuOptionsTooltipText:SetShadowOffset(1, -1)

	local buttons = {
		"CombuvalueokButton",
		"CombuIgniteokButton",
		"CombutimerokButton",
		"ComburesetButton",
		"CombuCautAnnounceEditBoxokButton",
		"CombuCautAnnounceAltEditBoxokButton",
		"CombuCautresetButton"
	}

	for i = 1, getn(buttons) do
		local button = _G[buttons[i]]
		if button then
			button:SkinButton()
		end
	end

	local checkboxes = {
		"CombulockButton",
		"CombucritButton",
		"ComburefreshButton",
		"CombureportButton",
		"Combureportthreshold",
		"CombuIgnitePredictButton",
		"CombuffbButton",
		"CombuMunchingButton",
		"CombuFlamestrikeButton",
		"ComburefreshpyroButton",
		"CombuimpactButton",
		"CombutrackerButton",
		"CombuchatButton",
		"CombuLBtrackerButton",
		"CombuLBtargetButton",
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
		"CombuCautAnnounceAltButton"
	}

	for i = 1, getn(checkboxes) do
		local checkbox = _G[checkboxes[i]]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	local dropdown = {
		"LBtrackerDropDown",
		"CombuAutohideDropDown",
		"CombuLanguageDropDown",
		"CombuTextureDropDown",
		"CombuFontDropDown",
		"CombuSoundDropDown",
		"CombuBorderDropDown",
		"CombuBackgroundDropDown"
	}

	for i = 1, getn(dropdown) do
		local frame = _G[dropdown[i]]
		if frame then
			--T.SkinDropDownBox(frame)
		end
	end
end)