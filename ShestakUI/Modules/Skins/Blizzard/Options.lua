local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Options skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	VideoOptionsFrame:StripTextures()
	VideoOptionsFrame:SetTemplate("Transparent")

	VideoOptionsFrameHeader:SetTexture(nil)
	VideoOptionsFrameHeader:ClearAllPoints()
	VideoOptionsFrameHeader:Point("TOP", VideoOptionsFrame, 0, 0)

	local frames = {
		"VideoOptionsFrameCategoryFrame",
		"VideoOptionsFramePanelContainer",
		"AudioOptionsSoundPanel",
		"AudioOptionsSoundPanelPlayback",
		"AudioOptionsSoundPanelHardware",
		"AudioOptionsSoundPanelVolume",
		"AudioOptionsVoicePanel",
		"AudioOptionsVoicePanelTalking",
		"AudioOptionsVoicePanelBinding",
		"AudioOptionsVoicePanelListening"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			frame:SetTemplate("Overlay")
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
		"AudioOptionsSoundPanelUseHardware",
		"AudioOptionsSoundPanelPetBattleMusic",
		"AudioOptionsVoicePanelEnableVoice",
		"AudioOptionsVoicePanelEnableMicrophone",
		"AudioOptionsVoicePanelPushToTalkSound",
		"NetworkOptionsPanelOptimizeSpeed",
		"NetworkOptionsPanelUseIPv6",
		"Advanced_DesktopGamma"
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

	_G["VideoOptionsFrameDefaults"]:ClearAllPoints()
	_G["VideoOptionsFrameDefaults"]:Point("TOPLEFT", _G["VideoOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
	_G["VideoOptionsFrameCancel"]:ClearAllPoints()
	_G["VideoOptionsFrameCancel"]:Point("TOPRIGHT", _G["VideoOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
	_G["VideoOptionsFrameOkay"]:ClearAllPoints()
	_G["VideoOptionsFrameOkay"]:Point("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)
	_G["VideoOptionsFrameApply"]:ClearAllPoints()
	_G["VideoOptionsFrameApply"]:Point("RIGHT", _G["VideoOptionsFrameOkay"], "LEFT", -4, 0)
	_G["AudioOptionsVoicePanelPushToTalkSound"]:ClearAllPoints()
	_G["AudioOptionsVoicePanelPushToTalkSound"]:Point("BOTTOMLEFT", _G["AudioOptionsVoicePanelBinding"], "BOTTOMLEFT", 0, 0)
	_G["AudioOptionsVoicePanelChatMode1KeyBindingButton"]:ClearAllPoints()
	_G["AudioOptionsVoicePanelChatMode1KeyBindingButton"]:Point("CENTER", _G["AudioOptionsVoicePanelBinding"], "CENTER", 0, -10)

	_G["AudioOptionsSoundPanel"]:SetFrameLevel(1)
	_G["AudioOptionsVoicePanel"]:SetFrameLevel(1)
	_G["AudioOptionsSoundPanelPlayback"]:SetFrameLevel(2)
	_G["AudioOptionsSoundPanelHardware"]:SetFrameLevel(2)
	_G["AudioOptionsSoundPanelVolume"]:SetFrameLevel(2)
	_G["AudioOptionsVoicePanelTalking"]:SetFrameLevel(2)
	_G["AudioOptionsVoicePanelBinding"]:SetFrameLevel(2)
	_G["AudioOptionsVoicePanelListening"]:SetFrameLevel(2)
	_G["AudioOptionsSoundPanelSoundQuality"]:SetFrameLevel(3)
	_G["AudioOptionsSoundPanelMasterVolume"]:SetFrameLevel(3)
	_G["AudioOptionsSoundPanelSoundVolume"]:SetFrameLevel(3)
	_G["AudioOptionsSoundPanelMusicVolume"]:SetFrameLevel(3)
	_G["AudioOptionsSoundPanelAmbienceVolume"]:SetFrameLevel(3)
	_G["AudioOptionsVoicePanelMicrophoneVolume"]:SetFrameLevel(3)
	_G["AudioOptionsVoicePanelSpeakerVolume"]:SetFrameLevel(3)
	_G["AudioOptionsVoicePanelSoundFade"]:SetFrameLevel(3)
	_G["AudioOptionsVoicePanelMusicFade"]:SetFrameLevel(3)
	_G["AudioOptionsVoicePanelAmbienceFade"]:SetFrameLevel(3)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)