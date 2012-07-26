local T, C, L = unpack(ShestakUI)
if C.extra_skins.mage_mana_bar ~= true then return end

----------------------------------------------------------------------------------------
--	MageManaBar skin
----------------------------------------------------------------------------------------
local MMBSkin = CreateFrame("Frame")
MMBSkin:RegisterEvent("PLAYER_LOGIN")
MMBSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("MageManaBar") then return end

	MMBTourFrame:SetTemplate("Transparent")
	MMBTourFrameClose:ClearAllPoints()
	T.SkinCloseButton(MMBTourFrameClose)
	T.SkinCheckBox(MMBTourDisableButton)
	MMBTourLeftButton:SkinButton()
	MMBTourRightButton:SkinButton()

	MageManaBarGlobal:CreateBackdrop("Default")
	MageManaBarGlobal.backdrop:Point("TOPLEFT", -1, 1)
	MageManaBarGlobal.backdrop:Point("BOTTOMRIGHT", 1, -1)

	--MageManaBarWarningBg2:SetWidth(MageManaBarBgFrame:GetWidth())

	local backdrops = {
		"MageManaBarWarningBg",
		"MageManaBarInfoFrameTexture",
		"MageManaBarCastFrameTexture",
		"MageManaBarAlternateBg",
		"MageManaBarHealthBg",
		"MageManaBarBgFrameTexture"
	}

	for i = 1, getn(backdrops) do
		local backdrop = _G[backdrops[i]]
		if backdrop then
			backdrop:SetTexture(nil)
		end
	end

	local bars = {
		"MageManaBarHealthBar",
		"MageManaBarCastBar",
		"MageManaBarFrame"
	}

	for i = 1, getn(bars) do
		local bar = _G[bars[i]]
		if bar then
			bar:SetStatusBarTexture(C.media.texture)
		end
	end

	local texts = {
		"MMBInfoFrame1Text",
		"MMBInfoFrame2Text",
		"MMBInfoFrame3Text",
		"MMBInfoFrame4Text",
		"MMBInfoFrame5Text",
		"MMBInfoFrame6Text",
		"MageManaBarCastBarTimer",
		"MageManaBarCastBarText",
		"MageManaBarAlternateText"
	}

	for i = 1, getn(texts) do
		local text = _G[texts[i]]
		if text then
			text:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			text:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end
	end

	MageManaBarWarningText:SetFont(C.font.stylization_font, C.font.stylization_font_size * 2, C.font.stylization_font_style)
	MageManaBarWarningText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
end)