local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalkingHeadUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TalkingHeadFrame:StripTextures()
	TalkingHeadFrame:SetTemplate("Transparent")
	T.SkinCloseButton(TalkingHeadFrame.MainFrame.CloseButton)
	TalkingHeadFrame.MainFrame:StripTextures()
	TalkingHeadFrame.PortraitFrame:StripTextures()
end

T.SkinFuncs["Blizzard_TalkingHeadUI"] = LoadSkin