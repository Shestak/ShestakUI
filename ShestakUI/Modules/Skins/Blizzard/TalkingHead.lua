local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalkingHeadUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TalkingHeadFrame:StripTextures()
	TalkingHeadFrame:CreateBackdrop("Transparent")
	TalkingHeadFrame.backdrop:SetPoint("TOPLEFT", 13, -13)
	TalkingHeadFrame.backdrop:SetPoint("BOTTOMRIGHT", -35, 11)

	TalkingHeadFrame.MainFrame:StripTextures()
	TalkingHeadFrame.PortraitFrame:StripTextures()
	TalkingHeadFrame.BackgroundFrame:StripTextures()

	TalkingHeadFrame.MainFrame.Model:CreateBackdrop("Default")
	TalkingHeadFrame.MainFrame.Model.backdrop:SetPoint("TOPLEFT", -3, 3)
	TalkingHeadFrame.MainFrame.Model.backdrop:SetPoint("BOTTOMRIGHT", 3, -3)

	T.SkinCloseButton(TalkingHeadFrame.MainFrame.CloseButton)
	TalkingHeadFrame.MainFrame.CloseButton:SetPoint("TOPRIGHT", -39, -17)
end

T.SkinFuncs["Blizzard_TalkingHeadUI"] = LoadSkin