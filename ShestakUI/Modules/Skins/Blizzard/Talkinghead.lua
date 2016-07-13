local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Talking "head" popup dialog
----------------------------------------------------------------------------------------
local function LoadSkin()
	TalkingHeadFrame:StripTextures()
	TalkingHeadFrame:SetTemplate("Transparent")
	T.SkinCloseButton(TalkingHeadFrame.MainFrame.CloseButton)
	TalkingHeadFrame.MainFrame:StripTextures()
	TalkingHeadFrame.PortraitFrame:StripTextures()
	TalkingHeadFrame.ignoreFramePositionManager = true
	TalkingHeadFrame:ClearAllPoints()
	TalkingHeadFrame:SetPoint("TOP", UIParent, "TOP", 0, -21)
end

T.SkinFuncs["Blizzard_TalkingHeadUI"] = LoadSkin
