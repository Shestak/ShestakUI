local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Options skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	VideoOptionsFrame:StripTextures()
	VideoOptionsFrame:SetTemplate("Transparent")

	VideoOptionsFrameHeader:SetTexture(nil)
	VideoOptionsFrameHeader:ClearAllPoints()
	VideoOptionsFrameHeader:SetPoint("TOP", VideoOptionsFrame, 0, 0)

	local frames = {
		"VideoOptionsFrameCategoryFrame",
		"VideoOptionsFramePanelContainer",
		"AudioOptionsSoundPanel",
		"AudioOptionsSoundPanelPlayback",
		"AudioOptionsSoundPanelHardware",
		"AudioOptionsSoundPanelVolume",
		"AudioOptionsVoicePanel"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			frame:SetTemplate("Overlay")
		end
	end

	local voice = {
		"AudioOptionsVoicePanelTalking",
		"AudioOptionsVoicePanelBinding",
		"AudioOptionsVoicePanelListening"
	}

	for i = 1, getn(voice) do
		local frame = _G[voice[i]]
		if frame then
			frame:StripTextures()
			frame:SetBackdrop({
				bgFile = C.media.blank, edgeFile = C.media.blank, edgeSize = T.mult,
				insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult}
			})
			frame:CreateBorder(true, true)
			frame:SetBackdropColor(0, 0, 0, 0)
			frame:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end

	local buttons = {
		"VideoOptionsFrameOkay",
		"VideoOptionsFrameCancel",
		"VideoOptionsFrameDefaults",
		"VideoOptionsFrameApply",
		"RecordLoopbackSoundButton",
		"PlayLoopbackSoundButton",
		"AudioOptionsVoicePanelChatMode1KeyBindingButton"
	}

	for i = 1, getn(buttons) do
		local button = _G[buttons[i]]
		if button then
			button:SkinButton()
		end
	end

	local checkboxes = {
		"Advanced_MaxFPSCheckBox",
		"Advanced_MaxFPSBKCheckBox",
		"Advanced_DesktopGamma",
		"AudioOptionsSoundPanelEnableSound",
		"AudioOptionsSoundPanelSoundEffects",
		"AudioOptionsSoundPanelErrorSpeech",
		"AudioOptionsSoundPanelEmoteSounds",
		"AudioOptionsSoundPanelPetSounds",
		"AudioOptionsSoundPanelMusic",
		"AudioOptionsSoundPanelLoopMusic",
		"AudioOptionsSoundPanelAmbientSounds",
		"AudioOptionsSoundPanelSoundInBG",
		"AudioOptionsSoundPanelReverb",
		"AudioOptionsSoundPanelHRTF",
		"AudioOptionsSoundPanelEnableDSPs",
		"AudioOptionsSoundPanelPetBattleMusic",
		"AudioOptionsVoicePanelEnableVoice",
		"AudioOptionsVoicePanelEnableMicrophone",
		"AudioOptionsVoicePanelPushToTalkSound",
		"NetworkOptionsPanelOptimizeSpeed",
		"NetworkOptionsPanelUseIPv6",
		"NetworkOptionsPanelAdvancedCombatLogging"
	}

	for i = 1, getn(checkboxes) do
		local checkbox = _G[checkboxes[i]]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	local dropdown = {
		"Graphics_DisplayModeDropDown",
		"Graphics_ResolutionDropDown",
		"Graphics_RefreshDropDown",
		"Graphics_PrimaryMonitorDropDown",
		"Graphics_MultiSampleDropDown",
		"Graphics_VerticalSyncDropDown",
		"Graphics_TextureResolutionDropDown",
		"Graphics_FilteringDropDown",
		"Graphics_ProjectedTexturesDropDown",
		"Graphics_ViewDistanceDropDown",
		"Graphics_EnvironmentalDetailDropDown",
		"Graphics_GroundClutterDropDown",
		"Graphics_ShadowsDropDown",
		"Graphics_LiquidDetailDropDown",
		"Graphics_SunshaftsDropDown",
		"Graphics_ParticleDensityDropDown",
		"Advanced_BufferingDropDown",
		"Advanced_LagDropDown",
		"Advanced_HardwareCursorDropDown",
		"Advanced_GraphicsAPIDropDown",
		"AudioOptionsSoundPanelHardwareDropDown",
		"AudioOptionsSoundPanelSoundChannelsDropDown",
		"AudioOptionsVoicePanelInputDeviceDropDown",
		"AudioOptionsVoicePanelChatModeDropDown",
		"AudioOptionsVoicePanelOutputDeviceDropDown",
		"Graphics_SSAODropDown"
	}

	for i = 1, getn(dropdown) do
		local frame = _G[dropdown[i]]
		if frame then
			T.SkinDropDownBox(frame, 165)
		end
	end

	local sliders = {
		"Graphics_Quality",
		"Advanced_UIScaleSlider",
		"Advanced_MaxFPSSlider",
		"Advanced_MaxFPSBKSlider",
		"Advanced_GammaSlider",
		"AudioOptionsSoundPanelSoundQuality",
		"AudioOptionsSoundPanelMasterVolume",
		"AudioOptionsSoundPanelSoundVolume",
		"AudioOptionsSoundPanelMusicVolume",
		"AudioOptionsSoundPanelAmbienceVolume",
		"AudioOptionsVoicePanelMicrophoneVolume",
		"AudioOptionsVoicePanelSpeakerVolume",
		"AudioOptionsVoicePanelSoundFade",
		"AudioOptionsVoicePanelMusicFade",
		"AudioOptionsVoicePanelAmbienceFade"
	}

	for i = 1, getn(sliders) do
		local slider = _G[sliders[i]]
		if slider then
			T.SkinSlider(slider)
			slider:SetFrameLevel(slider:GetFrameLevel() + 2)
		end
	end

	_G["Graphics_Quality"].SetBackdrop = T.dummy
	_G["Graphics_RightQuality"]:StripTextures()

	LoopbackVUMeter:CreateBackdrop("Overlay")
	LoopbackVUMeter:SetFrameLevel(LoopbackVUMeter:GetFrameLevel() + 1)
	LoopbackVUMeter.backdrop:SetPoint("TOPLEFT", -4, 4)
	LoopbackVUMeter.backdrop:SetPoint("BOTTOMRIGHT", 4, -4)

	_G["VideoOptionsFrameDefaults"]:ClearAllPoints()
	_G["VideoOptionsFrameDefaults"]:SetPoint("TOPLEFT", _G["VideoOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
	_G["VideoOptionsFrameCancel"]:ClearAllPoints()
	_G["VideoOptionsFrameCancel"]:SetPoint("TOPRIGHT", _G["VideoOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
	_G["VideoOptionsFrameOkay"]:ClearAllPoints()
	_G["VideoOptionsFrameOkay"]:SetPoint("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)
	_G["VideoOptionsFrameApply"]:ClearAllPoints()
	_G["VideoOptionsFrameApply"]:SetPoint("RIGHT", _G["VideoOptionsFrameOkay"], "LEFT", -4, 0)
	_G["AudioOptionsVoicePanelPushToTalkSound"]:ClearAllPoints()
	_G["AudioOptionsVoicePanelPushToTalkSound"]:SetPoint("BOTTOMLEFT", _G["AudioOptionsVoicePanelBinding"], "BOTTOMLEFT", 0, 0)
	_G["AudioOptionsVoicePanelChatMode1KeyBindingButton"]:ClearAllPoints()
	_G["AudioOptionsVoicePanelChatMode1KeyBindingButton"]:SetPoint("CENTER", _G["AudioOptionsVoicePanelBinding"], "CENTER", 0, -10)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)