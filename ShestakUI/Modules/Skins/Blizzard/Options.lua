local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

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
		"AudioOptionsVoicePanel",
		"Display_",
		"Graphics_",
		"RaidGraphics_"
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
		"PlayLoopbackSoundButton"
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
		"AudioOptionsSoundPanelDialogSounds",
		"NetworkOptionsPanelOptimizeSpeed",
		"NetworkOptionsPanelUseIPv6",
		"NetworkOptionsPanelAdvancedCombatLogging",
		"Advanced_ShowHDModels",
		"Display_RaidSettingsEnabledCheckBox"
	}

	for i = 1, getn(checkboxes) do
		local checkbox = _G[checkboxes[i]]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	local dropdown = {
		"Display_DisplayModeDropDown",
		"Display_ResolutionDropDown",
		"Display_RefreshDropDown",
		"Display_PrimaryMonitorDropDown",
		"Display_AntiAliasingDropDown",
		"Display_VerticalSyncDropDown",
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
		"Graphics_DepthEffectsDropDown",
		"Graphics_LightingQualityDropDown",
		"Graphics_OutlineModeDropDown",
		"Advanced_BufferingDropDown",
		"Advanced_LagDropDown",
		"Advanced_HardwareCursorDropDown",
		"Advanced_GraphicsAPIDropDown",
		"Advanced_PhysicsInteractionDropDown",
		"Advanced_MultisampleAntiAliasingDropDown",
		"Advanced_MultisampleAlphaTest",
		"Advanced_PostProcessAntiAliasingDropDown",
		"Advanced_ResampleQualityDropDown",
		"Advanced_AdapterDropDown",
		"AudioOptionsSoundPanelHardwareDropDown",
		"AudioOptionsSoundPanelSoundChannelsDropDown",
		"AudioOptionsSoundPanelSoundCacheSizeDropDown",
		"AudioOptionsVoicePanelInputDeviceDropDown",
		"AudioOptionsVoicePanelMicDeviceDropdown",
		"AudioOptionsVoicePanelOutputDeviceDropdown",
		"Graphics_SSAODropDown",
		"Graphics_RefractionDropDown",
		"RaidGraphics_TextureResolutionDropDown",
		"RaidGraphics_FilteringDropDown",
		"RaidGraphics_ProjectedTexturesDropDown",
		"RaidGraphics_ViewDistanceDropDown",
		"RaidGraphics_EnvironmentalDetailDropDown",
		"RaidGraphics_GroundClutterDropDown",
		"RaidGraphics_ShadowsDropDown",
		"RaidGraphics_LiquidDetailDropDown",
		"RaidGraphics_SunshaftsDropDown",
		"RaidGraphics_ParticleDensityDropDown",
		"RaidGraphics_RefractionDropDown",
		"RaidGraphics_SSAODropDown",
		"RaidGraphics_DepthEffectsDropDown",
		"RaidGraphics_LightingQualityDropDown",
		"RaidGraphics_OutlineModeDropDown"
	}

	for i = 1, getn(dropdown) do
		local frame = _G[dropdown[i]]
		if frame then
			T.SkinDropDownBox(frame, 165)
		end
	end

	local sliders = {
		"Graphics_Quality",
		"Graphics_ViewDistanceSlider",
		"Graphics_EnvironmentalDetailSlider",
		"Graphics_GroundClutterSlider",
		"Advanced_UIScaleSlider",
		"Advanced_MaxFPSSlider",
		"Advanced_MaxFPSBKSlider",
		"Advanced_GammaSlider",
		"Advanced_RenderScaleSlider",
		"Advanced_ContrastSlider",
		"Advanced_BrightnessSlider",
		"AudioOptionsSoundPanelSoundQuality",
		"AudioOptionsSoundPanelMasterVolume",
		"AudioOptionsSoundPanelSoundVolume",
		"AudioOptionsSoundPanelMusicVolume",
		"AudioOptionsSoundPanelAmbienceVolume",
		"AudioOptionsVoicePanelMicrophoneVolume",
		"AudioOptionsVoicePanelSpeakerVolume",
		"AudioOptionsVoicePanelSoundFade",
		"AudioOptionsVoicePanelMusicFade",
		"AudioOptionsVoicePanelAmbienceFade",
		"AudioOptionsSoundPanelDialogVolume",
		"AudioOptionsVoicePanelVoiceChatMicVolume",
		"AudioOptionsVoicePanelVoiceChatMicSensitivity",
		"AudioOptionsVoicePanelVoiceChatVolume",
		"RaidGraphics_Quality",
		"RaidGraphics_ViewDistanceSlider",
		"RaidGraphics_EnvironmentalDetailSlider",
		"RaidGraphics_GroundClutterSlider",
		"Display_RenderScaleSlider"
	}

	for i = 1, getn(sliders) do
		local slider = _G[sliders[i]]
		if slider then
			T.SkinSlider(slider)
			slider:SetFrameLevel(slider:GetFrameLevel() + 2)
		end
	end

	_G["Graphics_Quality"].SetBackdrop = T.dummy
	_G["RaidGraphics_Quality"].SetBackdrop = T.dummy

	local VUMeter = AudioOptionsVoicePanelTestInputDevice.VUMeter
	VUMeter:SetBackdrop(nil)
	VUMeter.Status:CreateBackdrop("Overlay")

	_G["VideoOptionsFrameDefaults"]:ClearAllPoints()
	_G["VideoOptionsFrameDefaults"]:SetPoint("TOPLEFT", _G["VideoOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
	_G["VideoOptionsFrameCancel"]:ClearAllPoints()
	_G["VideoOptionsFrameCancel"]:SetPoint("TOPRIGHT", _G["VideoOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
	_G["VideoOptionsFrameOkay"]:ClearAllPoints()
	_G["VideoOptionsFrameOkay"]:SetPoint("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)
	_G["VideoOptionsFrameApply"]:ClearAllPoints()
	_G["VideoOptionsFrameApply"]:SetPoint("RIGHT", _G["VideoOptionsFrameOkay"], "LEFT", -4, 0)

	GraphicsButton:SetPoint("BOTTOMLEFT", "Graphics_", "TOPLEFT", 0, 3)
	GraphicsButton:SkinButton(true)
	RaidButton:SkinButton(true)

	AudioOptionsVoicePanelTestInputDevice.ToggleTest:SkinButton()

	local function InitializeCommunicationMode(self)
		self.PushToTalkKeybindButton:SkinButton()
	end
	hooksecurefunc("AudioOptionsVoicePanel_InitializeCommunicationModeUI", InitializeCommunicationMode)

	T.SkinDropDownBox(InterfaceOptionsLanguagesPanelAudioLocaleDropDown, 250)
	T.SkinDropDownBox(InterfaceOptionsLanguagesPanelLocaleDropDown, 250)
	T.SkinDropDownBox(AudioOptionsVoicePanelChatModeDropdown, 183)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)