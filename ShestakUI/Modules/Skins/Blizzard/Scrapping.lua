local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ScrappingMachine skin
----------------------------------------------------------------------------------------
local function LoadSkin()	
	ScrappingMachineFrame:SetTemplate("Transparent")

	ScrappingMachineFrameInset:Hide()
	ScrappingMachineFramePortrait:Hide()
	ScrappingMachineFramePortraitFrame:Hide()
	ScrappingMachineFrameTitleBg:Hide()
	ScrappingMachineFrameBg:Hide()
	ScrappingMachineFrame.Background:Hide()
	ScrappingMachineFrameTopBorder:Hide()
	ScrappingMachineFrameTopRightCorner:Hide()
	ScrappingMachineFrameRightBorder:Hide()
	ScrappingMachineFrameLeftBorder:Hide()
	ScrappingMachineFrameBtnCornerRight:Hide()
	ScrappingMachineFrameBotRightCorner:Hide()
	ScrappingMachineFrameBtnCornerLeft:Hide()
	ScrappingMachineFrameBotLeftCorner:Hide()
	ScrappingMachineFrameButtonBottomBorder:Hide()
	ScrappingMachineFrameBottomBorder:Hide()

	ScrappingMachineFrame.ScrapButton:SkinButton()
	T.SkinCloseButton(ScrappingMachineFrameCloseButton)
end

T.SkinFuncs["Blizzard_ScrappingMachineUI"] = LoadSkin
