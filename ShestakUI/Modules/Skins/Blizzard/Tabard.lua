local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Tabard skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TabardFrame:StripTextures(true)
	TabardFrame:CreateBackdrop("Transparent")
	TabardFrame.backdrop:Point("TOPLEFT", 16, -12)
	TabardFrame.backdrop:Point("BOTTOMRIGHT", -30, 76)
	TabardModel:CreateBackdrop("Overlay")
	TabardModel.backdrop:Point("TOPLEFT", 2, 0)
	TabardModel.backdrop:Point("BOTTOMRIGHT", 2, -2)
	T.SkinCloseButton(TabardFrameCloseButton, TabardFrame.backdrop)
	TabardFrameCancelButton:SkinButton()
	TabardFrameAcceptButton:SkinButton()
	T.SkinRotateButton(TabardCharacterModelRotateLeftButton)
	T.SkinRotateButton(TabardCharacterModelRotateRightButton)
	TabardCharacterModelRotateLeftButton:ClearAllPoints()
	TabardCharacterModelRotateLeftButton:Point("BOTTOMLEFT", TabardModel.backdrop, "BOTTOMLEFT", 4, 4)
	TabardCharacterModelRotateRightButton:ClearAllPoints()
	TabardCharacterModelRotateRightButton:Point("LEFT", TabardCharacterModelRotateLeftButton, "RIGHT", 3, 0)
	TabardFrameCostFrame:StripTextures()
	TabardFrameCustomizationFrame:StripTextures()

	for i = 1, 5 do
		local custom = "TabardFrameCustomization"..i
		_G[custom]:StripTextures()
		T.SkinNextPrevButton(_G[custom.."LeftButton"])
		T.SkinNextPrevButton(_G[custom.."RightButton"])

		if i > 1 then
			_G[custom]:ClearAllPoints()
			_G[custom]:Point("TOP", _G["TabardFrameCustomization"..i-1], "BOTTOM", 0, -6)
		else
			local point, anchor, point2, x, y = _G[custom]:GetPoint()
			_G[custom]:Point(point, anchor, point2, x, y + 4)
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)