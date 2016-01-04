local T, C, L, _ = unpack(select(2, ...))
if C.skins.mage_nuggets ~= true then return end

----------------------------------------------------------------------------------------
--	MageNuggets skin /run ShowConfigFrames()
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("MageNuggets") then return end

	MageNuggets.cooldownSize = 3

	local sparks = {
		"MageNugMBProcFrame_ProcBarSpark",
		"MageNugFoFProcFrame_ProcBarSpark",
		"MageNugImpactProcFrame_ProcBarSpark",
		"MageNugBFProcFrame_ProcBarSpark",
		"MageNugProcFrame_ProcBarSpark",
		"MageNugLB1_Frame_BarSpark",
		"MageNugLB2_Frame_BarSpark",
		"MageNugLB3_Frame_BarSpark",
	}

	for i = 1, getn(sparks) do
		local spark = _G[sparks[i]]
		if spark then
			spark:SetTexture(nil)
		end
	end

	local icons = {
		"MNPyromaniac_FrameTexture",
		"MageNugMI_FrameTexture1",
		"MageNugCauterize_FrameTexture1",
		"MageNugMBProcFrameTexture",
		"MageNugPolyFrameTexture",
		"MageNugFoFProcFrameTexture",
		"MageNugImpactProcFrameTexture",
		"MageNugBFProcFrameTexture",
		"MageNugProcFrameTexture",
		"MageNugClearcast_FrameTexture",
		"MageNugAB_FrameTexture",
		"MageNugIgnite_FrameTexture",
		"MageNugLB_FrameTextureIcon",
		"MageNugMoonkin_Frame_Texture",
		"MNmoonFire_FrameTexture",
		"MNinsectSwarm_FrameTexture",
		"MNstarSurge_FrameTexture",
		"MageNugCD1_Frame_Texture",
		"MageNugCD2_Frame_Texture",
		"MageNugCD3_Frame_Texture",
		"MageNugCD4_Frame_Texture",
		"MageNugCD5_Frame_Texture",
		"MageNugCD6_Frame_Texture"
	}

	for i = 1, getn(icons) do
		local icon = _G[icons[i]]
		if icon then
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end

	local checkboxes = {
		"MageNugOptionsFrame_CheckButton2",
		"MageNugOptionsFrame_CheckButton3",
		"MageNugOptionsFrame_CheckButton6",
		"MageNugOptionsFrame_CheckButton7",
		"MageNugOptionsFrame_CheckButton8",
		"MageNugOptionsFrame_CheckButton9",
		"MageNugOptionsFrame_CheckButton11",
		"MageNugOptionsFrame_CheckButton13",
		"MageNugOptionsFrame_CheckButton14",
		"MageNugOptionsFrame_CheckButtonCC",
		"MageNugOptionsFrame_CheckButtonMG",
		"MageNugOptionsFrame_CheckButtonMGcombat",
		"MageNugOptionsFrame_IgniteCheckButton",
		"MageNugOptionsFrame_ABcastCheckButton",
		"CauterizeCheckButton",
		"MageNugStatMonOptionFrame_CheckButton0",
		"MageNugStatMonOptionFrame_CheckButton1",
		"MageNugStatMonOptionFrame_CheckButton2",
		"MageNugMsgOptionFrame_CheckButton",
		"MageNugMsgOptionFrame_CheckButton2",
		"MageNugMsgOptionFrame_CheckButton3",
		"MageNugMsgOptionFrame_CheckButton4",
		"MageNugMsgOptionFrame_CheckButton5",
		"MageNugMsgOptionFrame_CheckButton6",
		"MageNugMoonkinOptionFrame_CheckButton",
		"MageNugMoonkinOptionFrame_CheckButton0",
		"MageNugMoonkinOptionFrame_CheckButton1",
		"MageNugMoonkinOptionFrame_CheckButton2",
		"MageNugMoonkinOptionFrame_CheckButton3",
		"MageNugMoonkinOptionFrame_CheckButtonMin",
		"MageNugMoonkinOptionFrame_CheckButtonAnchor",
		"MageNugMoonkinOptionFrame_ProcCheckButton",
		"MageNugMoonkinOptionFrame_CastCheckButton",
		"MageNugPriestOptionFrame_CheckButton0",
		"MageNugPriestOptionFrame_CheckButton2",
		"MageNugPriestOptionFrame_CheckButton3",
		"MageNugSoundOptionFrame_MICheckButton",
		"MageNugSoundOptionFrame_ProcCheckButton",
		"MageNugSoundOptionFrame_PolyCheckButton",
		"MageNugSoundOptionFrame_HotStreakCheckButton",
		"MageNugSoundOptionFrame_ImpactCheckButton",
		"MageNugSoundOptionFrame_FoFCheckButton",
		"MageNugSoundOptionFrame_BrainFreezeCheckButton",
		"MageNugSoundOptionFrame_CauterizeCheckButton",
		"MageNugSoundOptionFrame_TimeWarpCheckButton",
		"MageNugSoundOptionFrame_ABCheckButton",
		"MageNugOption2Frame_MinimapCheckButton",
		"MageNugOption2Frame_CameraCheckButton",
		"MageNugOption2Frame_ConsoleTextCheckButton",
		"MageNugOption2Frame_LockFramesCheckButton",
		"MageNugOption2Frame_CheckButtonTT",
		"MageNugOption2Frame_ClickThruCheckButton",
		"MageNugOption2Frame_SimpleUICheckButton",
		"MageNugCooldownFrame_apButton",
		"MageNugCooldownFrame_cdButton",
		"MageNugCooldownFrame_bwButton",
		"MageNugCooldownFrame_cbButton",
		"MageNugCooldownFrame_csButton",
		"MageNugCooldownFrame_dfButton",
		"MageNugCooldownFrame_dbButton",
		"MageNugCooldownFrame_mwButton",
		"MageNugCooldownFrame_frzButton",
		"MageNugCooldownFrame_msButton",
		"MageNugCooldownFrame_ibrButton",
		"MageNugCooldownFrame_starfallButton",
		"MageNugCooldownFrame_evoButton",
		"MageNugCooldownFrame_treantButton",
		"MageNugCooldownFrame_ivButton",
		"MageNugCooldownFrame_blinkButton",
		"MageNugCooldownFrame_miButton"
	}

	for i = 1, getn(checkboxes) do
		local checkbox = _G[checkboxes[i]]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	local sliders = {
		"MageNugOptionsFrame_Slider1",
		"MageNugOptionsFrame_Slider2",
		"MageNugOptionsFrame_Slider3",
		"MageNugOptionsFrame_Slider4",
		"MageNugOptionsFrame_Slider5",
		"MageNugStatMonOptionFrame_SPSizeSlider",
		"MageNugStatMonOptionFrame_BorderSlider",
		"MageNugStatMonOptionFrame_TransparencySlider",
		"MageNugMoonkinOptionFrame_Slider",
		"MageNugMoonkinOptionFrame_Slider1",
		"MageNugCooldownFrame_Slider1"
	}

	for i = 1, getn(sliders) do
		local slider = _G[sliders[i]]
		if slider then
			T.SkinSlider(slider)
			slider:SetFrameLevel(slider:GetFrameLevel() + 2)
		end
	end

	local editboxs = {
		"SlowFallMsgEditBox",
		"SlowFallMsgEditBox2",
		"SlowFallMsgEditBox3",
		"FocMagNotifyEditBox",
		"FocMagNotifyEditBox2",
		"FocMagNotifyEditBox3",
		"FocMagThankEditBox",
		"FocMagThankEditBox2",
		"InnervThankEditBox",
		"InnervThankEditBox2",
		"PowerInfusionEditBox",
		"DarkIntentEditBox",
		"MageNugMoonkinOptionFrame_SoundEditBox",
		"MageNugMoonkinOptionFrame_InnervateEditBox",
		"MageNugPriestOptionFrame_EditBox1",
		"MageNugPriestOptionFrame_EditBox2",
		"MageNugPriestOptionFrame_EditBox3",
		"MageNugSoundOptionFrame_MISoundEditBox",
		"MageNugSoundOptionFrame_ProcSoundEditBox",
		"MageNugSoundOptionFrame_PolySoundEditBox",
		"MageNugSoundOptionFrame_HotStreakSoundEditBox",
		"MageNugSoundOptionFrame_ImpactSoundEditBox",
		"MageNugSoundOptionFrame_FoFSoundEditBox",
		"MageNugSoundOptionFrame_BrainFreezeSoundEditBox",
		"MageNugSoundOptionFrame_CauterizeSoundEditBox",
		"MageNugSoundOptionFrame_ABSoundEditBox",
		"MageNugSoundOptionFrame_TimeWarpSoundEditBox"
	}

	for i = 1, getn(editboxs) do
		local editbox = _G[editboxs[i]]
		if editbox then
			T.SkinEditBox(editbox, nil, 14)
		end
	end

	local backdrops = {
		"MNPyromaniac_Frame",
		"MageNugMBProcFrame",
		"MageNugPolyFrame",
		"MageNugFoFProcFrame",
		"MageNugImpactProcFrame",
		"MageNugBFProcFrame",
		"MageNugProcFrame",
		"MageNugCauterizeFrame",
		"MNabCast_Frame",
		"MageNugLB1_Frame",
		"MageNugLB2_Frame",
		"MageNugLB3_Frame",
		"MageNugSSProcFrame"
	}

	for i = 1, getn(backdrops) do
		local backdrop = _G[backdrops[i]]
		if backdrop then
			backdrop:SetBackdrop(nil)
		end
	end

	local texts = {
		"MageNugMI_Frame_MIText",
		"MageNugMI_Frame_MIText1",
		"MageNugCauterize_Frame_Text",
		"MageNugCauterize_Frame_Text1",
		"MageNugMBProcFrameText",
		"MageNugMBProcFrameText2",
		"MageNugPolyFrameText",
		"MageNugPolyFrameTimerText",
		"MageNugFoFProcFrameCountText",
		"MageNugFoFProcFrameText",
		"MageNugFoFProcFrameText2",
		"MageNugImpactProcFrameText",
		"MageNugImpactProcFrameText2",
		"MageNugBFProcFrameText",
		"MageNugBFProcFrameText2",
		"MageNugProcFrameText",
		"MageNugProcFrameText2",
		"MageNugClearcast_FrameText",
		"MageNugClearcast_FrameText2",
		"MageNugAB_FrameText",
		"MageNugAB_FrameText1",
		"MageNugAB_FrameText2",
		"MNabCast_FrameText",
		"MageNugIgnite_FrameText2",
		"MageNugLB1_Frame_Text",
		"MageNugLB1_Frame_Text2",
		"MageNugLB2_Frame_Text",
		"MageNugLB2_Frame_Text2",
		"MageNugLB3_Frame_Text",
		"MageNugLB3_Frame_Text2",
		"MageNugSP_FrameText",
		"MNSpellSteal_FrameTitleText",
		"MNSpellSteal_FrameBuffText",
		"MNSpellStealFocus_FrameTitleText",
		"MNSpellStealFocus_FrameBuffText",
		"MageNugMoonkin_Frame_Text",
		"MNmoonFire_FrameText",
		"MNinsectSwarm_FrameText",
		"MNstarSurge_FrameText",
		"MageNugCD_Frame_Text",
		"MageNugCD1_Frame_Text",
		"MageNugCD2_Frame_Text",
		"MageNugCD3_Frame_Text",
		"MageNugCD4_Frame_Text",
		"MageNugCD5_Frame_Text",
		"MageNugCD6_Frame_Text",
		"MageNugCD1_Frame_Text2",
		"MageNugCD2_Frame_Text2",
		"MageNugCD3_Frame_Text2",
		"MageNugCD4_Frame_Text2",
		"MageNugCD5_Frame_Text2",
		"MageNugCD6_Frame_Text2",
	}

	for i = 1, getn(texts) do
		local text = _G[texts[i]]
		if text then
			text:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			text:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end
	end

	local bars = {
		"MageNugCauterize_Frame_Bar",
		"MageNugMBProcFrame_ProcBar",
		"MageNugPolyFrame_Bar",
		"MageNugFoFProcFrame_ProcBar",
		"MageNugImpactProcFrame_ProcBar",
		"MageNugBFProcFrame_ProcBar",
		"MageNugProcFrame_ProcBar",
		"MageNugClearcast_Frame_Bar",
		"MageNugAB_Frame_ABBar",
		"MageNugIgnite_Frame_Bar",
		"MageNugLB1_Frame_Bar",
		"MageNugLB2_Frame_Bar",
		"MageNugLB3_Frame_Bar",
		"MageNugMoonkin_Frame_Bar",
		"MageNugMI_Frame_MiBar",
		"MageNugCD1_Frame_Bar",
		"MageNugCD2_Frame_Bar",
		"MageNugCD3_Frame_Bar",
		"MageNugCD4_Frame_Bar",
		"MageNugCD5_Frame_Bar",
		"MageNugCD6_Frame_Bar",
	}

	for i = 1, getn(bars) do
		local bar = _G[bars[i]]
		if bar then
			bar:SetStatusBarTexture(C.media.texture)
		end
	end

	-- MageNugMI_Frame
	MageNugMI_FrameTexture1:SetSize(21, 21)

	MageNugMI_Frame:CreateBackdrop("Default")
	MageNugMI_Frame.backdrop:SetPoint("TOPLEFT", MageNugMI_FrameTexture1, -2, 2)
	MageNugMI_Frame.backdrop:SetPoint("BOTTOMRIGHT", MageNugMI_FrameTexture1, 2, -2)

	MageNugMI_Frame_MiBar:SetWidth(186)
	MageNugMI_Frame_MiBar:SetHeight(15)
	MageNugMI_Frame_MiBar:CreateBackdrop("Default")
	MageNugMI_Frame_MiBar:ClearAllPoints()
	MageNugMI_Frame_MiBar:SetPoint("BOTTOMLEFT", MageNugMI_FrameTexture1, "BOTTOMRIGHT", 7, 0)

	MageNugMI_Frame_MIText:ClearAllPoints()
	MageNugMI_Frame_MIText:SetPoint("LEFT", MageNugMI_Frame_MiBar, "LEFT", 2, 0)

	MageNugMI_Frame_MIText1:ClearAllPoints()
	MageNugMI_Frame_MIText1:SetPoint("RIGHT", MageNugMI_Frame_MiBar, "RIGHT", 0, 0)

	-- MageNugCauterize_Frame
	MageNugCauterize_FrameTexture1:SetSize(21, 21)

	MageNugCauterize_Frame:CreateBackdrop("Default")
	MageNugCauterize_Frame.backdrop:SetPoint("TOPLEFT", MageNugCauterize_FrameTexture1, -2, 2)
	MageNugCauterize_Frame.backdrop:SetPoint("BOTTOMRIGHT", MageNugCauterize_FrameTexture1, 2, -2)

	MageNugCauterize_Frame_Bar:SetWidth(186)
	MageNugCauterize_Frame_Bar:SetHeight(15)
	MageNugCauterize_Frame_Bar:CreateBackdrop("Default")
	MageNugCauterize_Frame_Bar:ClearAllPoints()
	MageNugCauterize_Frame_Bar:SetPoint("BOTTOMLEFT", MageNugCauterize_FrameTexture1, "BOTTOMRIGHT", 7, 0)

	MageNugCauterize_Frame_Text:ClearAllPoints()
	MageNugCauterize_Frame_Text:SetPoint("LEFT", MageNugCauterize_Frame_Bar, "LEFT", 2, 0)

	MageNugCauterize_Frame_Text1:ClearAllPoints()
	MageNugCauterize_Frame_Text1:SetPoint("RIGHT", MageNugCauterize_Frame_Bar, "RIGHT", 0, 0)

	-- MageNugMBProcFrame
	MageNugMBProcFrameTextureBorder:Hide()

	MageNugMBProcFrame:CreateBackdrop("Default")
	MageNugMBProcFrame.backdrop:SetPoint("TOPLEFT", MageNugMBProcFrameTexture, -2, 2)
	MageNugMBProcFrame.backdrop:SetPoint("BOTTOMRIGHT", MageNugMBProcFrameTexture, 2, -2)

	MageNugMBProcFrame_ProcBar:SetFrameStrata("BACKGROUND")
	MageNugMBProcFrame_ProcBar:SetWidth(186)
	MageNugMBProcFrame_ProcBar:SetHeight(15)
	MageNugMBProcFrame_ProcBar:CreateBackdrop("Default")
	MageNugMBProcFrame_ProcBar:ClearAllPoints()
	MageNugMBProcFrame_ProcBar:SetPoint("BOTTOMLEFT", MageNugMBProcFrameTexture, "BOTTOMRIGHT", 7, 0)

	MageNugMBProcFrameText:ClearAllPoints()
	MageNugMBProcFrameText:SetPoint("LEFT", MageNugMBProcFrame_ProcBar, "LEFT", 2, 0)

	MageNugMBProcFrameText2:ClearAllPoints()
	MageNugMBProcFrameText2:SetPoint("RIGHT", MageNugMBProcFrame_ProcBar, "RIGHT", 0, 0)

	-- MageNugPolyFrame
	MageNugPolyFrameTextureBorder:Hide()

	MageNugPolyFrame:CreateBackdrop("Default")
	MageNugPolyFrame.backdrop:SetPoint("TOPLEFT", MageNugPolyFrameTexture, -2, 2)
	MageNugPolyFrame.backdrop:SetPoint("BOTTOMRIGHT", MageNugPolyFrameTexture, 2, -2)

	MageNugPolyFrame_Bar:SetFrameStrata("BACKGROUND")
	MageNugPolyFrame_Bar:SetWidth(186)
	MageNugPolyFrame_Bar:SetHeight(15)
	MageNugPolyFrame_Bar:CreateBackdrop("Default")
	MageNugPolyFrame_Bar:ClearAllPoints()
	MageNugPolyFrame_Bar:SetPoint("BOTTOMLEFT", MageNugPolyFrameTexture, "BOTTOMRIGHT", 7, 0)

	MageNugPolyFrameText:ClearAllPoints()
	MageNugPolyFrameText:SetPoint("LEFT", MageNugPolyFrame_Bar, "LEFT", 2, 0)

	MageNugPolyFrameTimerText:ClearAllPoints()
	MageNugPolyFrameTimerText:SetPoint("RIGHT", MageNugPolyFrame_Bar, "RIGHT", 0, 0)

	-- MageNugFoFProcFrame
	MageNugFoFProcFrameTextureBorder:Hide()

	MageNugFoFProcFrame:CreateBackdrop("Default")
	MageNugFoFProcFrame.backdrop:SetPoint("TOPLEFT", MageNugFoFProcFrameTexture, -2, 2)
	MageNugFoFProcFrame.backdrop:SetPoint("BOTTOMRIGHT", MageNugFoFProcFrameTexture, 2, -2)

	MageNugFoFProcFrame_ProcBar:SetFrameStrata("BACKGROUND")
	MageNugFoFProcFrame_ProcBar:SetWidth(186)
	MageNugFoFProcFrame_ProcBar:SetHeight(15)
	MageNugFoFProcFrame_ProcBar:CreateBackdrop("Default")
	MageNugFoFProcFrame_ProcBar:ClearAllPoints()
	MageNugFoFProcFrame_ProcBar:SetPoint("BOTTOMLEFT", MageNugFoFProcFrameTexture, "BOTTOMRIGHT", 7, 0)

	MageNugFoFProcFrameCountText:ClearAllPoints()
	MageNugFoFProcFrameCountText:SetPoint("BOTTOMRIGHT", MageNugFoFProcFrameTexture, "BOTTOMRIGHT", -2, 2)

	MageNugFoFProcFrameText:ClearAllPoints()
	MageNugFoFProcFrameText:SetPoint("LEFT", MageNugFoFProcFrame_ProcBar, "LEFT", 2, 0)

	MageNugFoFProcFrameText2:ClearAllPoints()
	MageNugFoFProcFrameText2:SetPoint("RIGHT", MageNugFoFProcFrame_ProcBar, "RIGHT", 0, 0)

	-- MageNugImpactProcFrame
	MageNugImpactProcFrameTexture:SetSize(21, 21)

	MageNugImpactProcFrame:CreateBackdrop("Default")
	MageNugImpactProcFrame.backdrop:SetPoint("TOPLEFT", MageNugImpactProcFrameTexture, -2, 2)
	MageNugImpactProcFrame.backdrop:SetPoint("BOTTOMRIGHT", MageNugImpactProcFrameTexture, 2, -2)

	MageNugImpactProcFrame_ProcBar:SetFrameStrata("BACKGROUND")
	MageNugImpactProcFrame_ProcBar:SetWidth(186)
	MageNugImpactProcFrame_ProcBar:SetHeight(15)
	MageNugImpactProcFrame_ProcBar:CreateBackdrop("Default")
	MageNugImpactProcFrame_ProcBar:ClearAllPoints()
	MageNugImpactProcFrame_ProcBar:SetPoint("BOTTOMLEFT", MageNugImpactProcFrameTexture, "BOTTOMRIGHT", 7, 0)

	MageNugImpactProcFrameText:ClearAllPoints()
	MageNugImpactProcFrameText:SetPoint("LEFT", MageNugImpactProcFrame_ProcBar, "LEFT", 2, 0)

	MageNugImpactProcFrameText2:ClearAllPoints()
	MageNugImpactProcFrameText2:SetPoint("RIGHT", MageNugImpactProcFrame_ProcBar, "RIGHT", 0, 0)

	-- MageNugBFProcFrame
	MageNugBFProcFrameTextureBorder:Hide()

	MageNugBFProcFrame:CreateBackdrop("Default")
	MageNugBFProcFrame.backdrop:SetPoint("TOPLEFT", MageNugBFProcFrameTexture, -2, 2)
	MageNugBFProcFrame.backdrop:SetPoint("BOTTOMRIGHT", MageNugBFProcFrameTexture, 2, -2)

	MageNugBFProcFrame_ProcBar:SetFrameStrata("BACKGROUND")
	MageNugBFProcFrame_ProcBar:SetWidth(186)
	MageNugBFProcFrame_ProcBar:SetHeight(15)
	MageNugBFProcFrame_ProcBar:CreateBackdrop("Default")
	MageNugBFProcFrame_ProcBar:ClearAllPoints()
	MageNugBFProcFrame_ProcBar:SetPoint("BOTTOMLEFT", MageNugBFProcFrameTexture, "BOTTOMRIGHT", 7, 0)

	MageNugBFProcFrameText:ClearAllPoints()
	MageNugBFProcFrameText:SetPoint("LEFT", MageNugBFProcFrame_ProcBar, "LEFT", 2, 0)

	MageNugBFProcFrameText2:ClearAllPoints()
	MageNugBFProcFrameText2:SetPoint("RIGHT", MageNugBFProcFrame_ProcBar, "RIGHT", 0, 0)

	-- MageNugProcFrame
	MageNugProcFrameTextureBorder:Hide()

	MageNugProcFrame:CreateBackdrop("Default")
	MageNugProcFrame.backdrop:SetPoint("TOPLEFT", MageNugProcFrameTexture, -2, 2)
	MageNugProcFrame.backdrop:SetPoint("BOTTOMRIGHT", MageNugProcFrameTexture, 2, -2)

	MageNugProcFrame_ProcBar:SetFrameStrata("BACKGROUND")
	MageNugProcFrame_ProcBar:SetWidth(186)
	MageNugProcFrame_ProcBar:SetHeight(15)
	MageNugProcFrame_ProcBar:CreateBackdrop("Default")
	MageNugProcFrame_ProcBar:ClearAllPoints()
	MageNugProcFrame_ProcBar:SetPoint("BOTTOMLEFT", MageNugProcFrameTexture, "BOTTOMRIGHT", 7, 0)

	MageNugProcFrameText:ClearAllPoints()
	MageNugProcFrameText:SetPoint("LEFT", MageNugProcFrame_ProcBar, "LEFT", 2, 0)

	MageNugProcFrameText2:ClearAllPoints()
	MageNugProcFrameText2:SetPoint("RIGHT", MageNugProcFrame_ProcBar, "RIGHT", 0, 0)

	-- MageNugCauterizeFrame
	MageNugCauterizeFrame:CreateBackdrop("Transparent")
	MageNugCauterizeFrame.backdrop:SetPoint("TOPLEFT", MageNugCauterizeFrame, -2, -3)
	MageNugCauterizeFrame.backdrop:SetPoint("BOTTOMRIGHT", MageNugCauterizeFrame, 2, 3)

	for i = 1, MageNugCauterizeFrame:GetNumRegions() do
		local region = select(i, MageNugCauterizeFrame:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetSize(30, 30)
			region:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
		if region:GetObjectType() == "FontString" then
			region:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			region:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end
	end

	-- MageNugClearcast_Frame
	MageNugClearcast_Frame:SetTemplate("Default")

	MageNugClearcast_FrameTexture:SetDrawLayer("ARTWORK")
	MageNugClearcast_FrameTexture:ClearAllPoints()
	MageNugClearcast_FrameTexture:SetPoint("TOPLEFT", 2, -2)
	MageNugClearcast_FrameTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	-- MageNugAB_Frame
	MageNugAB_Frame:SetTemplate("Default")

	MageNugAB_FrameTexture:SetDrawLayer("ARTWORK")
	MageNugAB_FrameTexture:ClearAllPoints()
	MageNugAB_FrameTexture:SetPoint("TOPLEFT", 2, -2)
	MageNugAB_FrameTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	-- MageNugIgnite_Frame
	MageNugIgnite_Frame:SetTemplate("Default")

	MageNugIgnite_FrameTexture:SetDrawLayer("ARTWORK")
	MageNugIgnite_FrameTexture:ClearAllPoints()
	MageNugIgnite_FrameTexture:SetPoint("TOPLEFT", 2, -2)
	MageNugIgnite_FrameTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	MageNugIgnite_FrameText:SetFont(C.font.stylization_font, C.font.stylization_font_size * 2, C.font.stylization_font_style)
	MageNugIgnite_FrameText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	MageNugIgnite_FrameText:ClearAllPoints()
	MageNugIgnite_FrameText:SetPoint("CENTER", MageNugIgnite_Frame, "CENTER", 0, 0)

	-- MageNugLB_Frame
	MageNugLB_Frame:SetTemplate("Default")
	MageNugLB_Frame:SetSize(21, 21)

	MageNugLB_FrameTexture:SetTexture()
	MageNugLB_FrameTextureBorder:SetTexture()
	MageNugLB_FrameTextureTitle:SetTexture()

	MageNugLB_Frame_Text:SetFont(C.font.stylization_font, C.font.stylization_font_size * 2, C.font.stylization_font_style)
	MageNugLB_Frame_Text:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	MageNugLB_Frame_Text:ClearAllPoints()
	MageNugLB_Frame_Text:SetPoint("CENTER", MageNugLB_Frame, "CENTER", 0, 0)

	-- MageNugLB1_Frame
	MageNugLB1_Frame:SetFrameStrata("BACKGROUND")
	MageNugLB1_Frame:CreateBackdrop("Default")
	MageNugLB1_Frame.backdrop:SetPoint("TOPLEFT", MageNugLB1_Frame, -2, 0)
	MageNugLB1_Frame.backdrop:SetPoint("BOTTOMRIGHT", MageNugLB1_Frame, 2, -1)
	MageNugLB1_Frame:ClearAllPoints()
	MageNugLB1_Frame:SetPoint("BOTTOMLEFT", MageNugLB_Frame, "BOTTOMRIGHT", 5, 1)

	MageNugLB1_Frame_Text:SetParent(MageNugLB1_Frame_Bar)
	MageNugLB1_Frame_Text:ClearAllPoints()
	MageNugLB1_Frame_Text:SetPoint("RIGHT", MageNugLB1_Frame, "RIGHT", 0, 0)

	MageNugLB1_Frame_Text2:SetParent(MageNugLB1_Frame_Bar)
	MageNugLB1_Frame_Text2:ClearAllPoints()
	MageNugLB1_Frame_Text2:SetPoint("LEFT", MageNugLB1_Frame, "LEFT", 2, 0)

	-- MageNugLB2_Frame
	MageNugLB2_Frame:SetFrameStrata("BACKGROUND")
	MageNugLB2_Frame:CreateBackdrop("Default")
	MageNugLB2_Frame.backdrop:SetPoint("TOPLEFT", MageNugLB2_Frame, -2, 0)
	MageNugLB2_Frame.backdrop:SetPoint("BOTTOMRIGHT", MageNugLB2_Frame, 2, -1)
	MageNugLB2_Frame:ClearAllPoints()
	MageNugLB2_Frame:SetPoint("BOTTOM", MageNugLB1_Frame, "TOP", 0, 6)

	MageNugLB2_Frame_Text:SetParent(MageNugLB2_Frame_Bar)
	MageNugLB2_Frame_Text:ClearAllPoints()
	MageNugLB2_Frame_Text:SetPoint("RIGHT", MageNugLB2_Frame, "RIGHT", 0, 0)

	MageNugLB2_Frame_Text2:SetParent(MageNugLB2_Frame_Bar)
	MageNugLB2_Frame_Text2:ClearAllPoints()
	MageNugLB2_Frame_Text2:SetPoint("LEFT", MageNugLB2_Frame, "LEFT", 2, 0)

	-- MageNugLB3_Frame
	MageNugLB3_Frame:SetFrameStrata("BACKGROUND")
	MageNugLB3_Frame:CreateBackdrop("Default")
	MageNugLB3_Frame.backdrop:SetPoint("TOPLEFT", MageNugLB3_Frame, -2, 0)
	MageNugLB3_Frame.backdrop:SetPoint("BOTTOMRIGHT", MageNugLB3_Frame, 2, -1)
	MageNugLB3_Frame:ClearAllPoints()
	MageNugLB3_Frame:SetPoint("BOTTOM", MageNugLB2_Frame, "TOP", 0, 6)

	MageNugLB3_Frame_Text:SetParent(MageNugLB3_Frame_Bar)
	MageNugLB3_Frame_Text:ClearAllPoints()
	MageNugLB3_Frame_Text:SetPoint("RIGHT", MageNugLB3_Frame, "RIGHT", 0, 0)

	MageNugLB3_Frame_Text2:SetParent(MageNugLB3_Frame_Bar)
	MageNugLB3_Frame_Text2:ClearAllPoints()
	MageNugLB3_Frame_Text2:SetPoint("LEFT", MageNugLB3_Frame, "LEFT", 2, 0)

	-- MageNugSP_Frame
	MageNugSP_Frame:SetTemplate("Transparent")

	-- MNSpellSteal_Frame
	MNSpellSteal_Frame:SetTemplate("Transparent")

	-- MNSpellStealFocus_Frame
	MNSpellStealFocus_Frame:SetTemplate("Transparent")

	-- MageNugMoonkin_Frame
	MageNugMoonkin_Frame:CreateBackdrop("Default")
	MageNugMoonkin_Frame.backdrop:SetPoint("TOPLEFT", MageNugMoonkin_Frame_Texture, -2, 2)
	MageNugMoonkin_Frame.backdrop:SetPoint("BOTTOMRIGHT", MageNugMoonkin_Frame_Texture, 2, -2)

	MageNugMoonkin_Frame_Bar:CreateBackdrop("Default")
	MageNugMoonkin_Frame_Bar:ClearAllPoints()
	MageNugMoonkin_Frame_Bar:SetPoint("BOTTOMLEFT", MageNugMoonkin_Frame_Texture, "BOTTOMRIGHT", 7, 0)
	MageNugMoonkin_Frame_Bar:SetSize(80, 15)

	-- MNmoonFire_Frame
	MNmoonFire_Frame:SetTemplate("Default")
	MNmoonFire_Frame:ClearAllPoints()
	MNmoonFire_Frame:SetPoint("BOTTOMLEFT", MageNugMoonkin_Frame_Bar, "TOPLEFT", -2, 5)

	MNmoonFire_FrameTexture:ClearAllPoints()
	MNmoonFire_FrameTexture:SetPoint("TOPLEFT", 2, -2)
	MNmoonFire_FrameTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	MNmoonFire_FrameText:ClearAllPoints()
	MNmoonFire_FrameText:SetPoint("CENTER", MNmoonFire_Frame, 0, 0)

	-- MNinsectSwarm_Frame
	MNinsectSwarm_Frame:SetTemplate("Default")
	MNinsectSwarm_Frame:ClearAllPoints()
	MNinsectSwarm_Frame:SetPoint("LEFT", MNmoonFire_Frame, "RIGHT", 3, 0)

	MNinsectSwarm_FrameTexture:ClearAllPoints()
	MNinsectSwarm_FrameTexture:SetPoint("TOPLEFT", 2, -2)
	MNinsectSwarm_FrameTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	MNinsectSwarm_FrameText:ClearAllPoints()
	MNinsectSwarm_FrameText:SetPoint("CENTER", MNinsectSwarm_Frame, 0, 0)

	-- MNstarSurge_Frame
	MNstarSurge_Frame:SetTemplate("Default")
	MNstarSurge_Frame:ClearAllPoints()
	MNstarSurge_Frame:SetPoint("LEFT", MNinsectSwarm_Frame, "RIGHT", 3, 0)

	MNstarSurge_FrameTexture:ClearAllPoints()
	MNstarSurge_FrameTexture:SetPoint("TOPLEFT", 2, -2)
	MNstarSurge_FrameTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	MNstarSurge_FrameText:ClearAllPoints()
	MNstarSurge_FrameText:SetPoint("CENTER", MNstarSurge_Frame, 0, 0)

	-- MageNugCD_Frame
	for i = 1, 6 do
		local cooldown = _G["MageNugCD"..i.."_Frame"]
		local text1 = _G["MageNugCD"..i.."_Frame_Text"]
		local text2 = _G["MageNugCD"..i.."_Frame_Text2"]
		if cooldown then
			cooldown:CreateBackdrop("Default")
			cooldown.backdrop:SetFrameStrata("BACKGROUND")
			cooldown.backdrop:SetPoint("TOPLEFT", cooldown, -2, 2)
			cooldown.backdrop:SetPoint("BOTTOMRIGHT", cooldown, 14, -2)
		end
		if text1 then
			text1:ClearAllPoints()
			text1:SetPoint("LEFT", cooldown, "LEFT", 15, 0)
		end
		if text2 then
			text2:ClearAllPoints()
			text2:SetPoint("RIGHT", cooldown, "RIGHT", 14, 0)
		end
		if i == 1 then
			cooldown:SetPoint("TOP", MageNugCD_Frame, "TOP", 0, -11)
		else
			cooldown:SetPoint("TOP", _G["MageNugCD"..(i-1).."_Frame"], "BOTTOM", 0, -7)
		end
	end

	-- MageNugAlliFrame
	MageNugAlliFrame:SetTemplate("Transparent")

	MageNugAlliFrameClose:SkinButton()
	MageNugAlliFrameShowOptions:SkinButton()

	MageNugAlliFrameText:SetFont(C.media.normal_font, 13)
	MageNugAlliFrameText2:SetFont(C.media.normal_font, 13)
	MageNugHordeFrameText:SetFont(C.media.normal_font, 13)
	MageNugHordeFrameText2:SetFont(C.media.normal_font, 13)

	local portals = {
		"MageNugAlliFramePortDal",
		"MageNugAlliFramePortShat",
		"MageNugAlliFramePortOrg",
		"MageNugAlliFramePortUC",
		"MageNugAlliFramePortTB",
		"MageNugAlliFramePortSMC",
		"MageNugAlliFramePortStonard",
		"MageNugAlliFramePortTol",
		"MageNugAlliFramePortIF",
		"MageNugAlliFramePortSW",
		"MageNugAlliFramePortDarn",
		"MageNugAlliFramePortExo",
		"MageNugAlliFramePortTheramore",
		"MageNugAlliFrameTeleDal",
		"MageNugAlliFrameTeleShat",
		"MageNugAlliFrameTeleOrg",
		"MageNugAlliFrameTeleUC",
		"MageNugAlliFrameTeleTB",
		"MageNugAlliFrameTeleSMC",
		"MageNugAlliFrameTeleStonard",
		"MageNugAlliFrameTeleTol",
		"MageNugAlliFrameTeleIF",
		"MageNugAlliFrameTeleSW",
		"MageNugAlliFrameTeleDarn",
		"MageNugAlliFrameTeleExo",
		"MageNugAlliFrameTeleTheramore",
		"MageNugAlliFrameHearth"
	}

	for i = 1, getn(portals) do
		local portal = _G[portals[i]]
		local texture = _G[portals[i].."TelDalTexture"]
		if portal then
			portal:SetTemplate("Default")
			portal:StyleButton()
		end
		if texture then
			texture:SetDrawLayer("ARTWORK")
			texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			texture:ClearAllPoints()
			texture:SetPoint("TOPLEFT", 2, -2)
			texture:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end

	-- Options
	MageNugStatMonOptionFrameBlackBackdropButton:SkinButton()
	MageNugMoonkinOptionFrame_Button:SkinButton()
	MageNugOption2FrameButton1:SkinButton()
	MageNugOption2FrameButton2:SkinButton()
	MageNugOption2FrameButton3:SkinButton()
end)