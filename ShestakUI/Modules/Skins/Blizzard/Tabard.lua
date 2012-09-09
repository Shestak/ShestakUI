local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Tabard skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TabardFrame:StripTextures()
	TabardFrame:CreateBackdrop("Transparent")
	TabardFrame.backdrop:Point("TOPLEFT", 0, 0)
	TabardFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

	TabardFrameInset:StripTextures()
	TabardFramePortrait:Kill()

	TabardModel:CreateBackdrop("Overlay")
	TabardModel.backdrop:Point("TOPLEFT", 2, 0)
	TabardModel.backdrop:Point("BOTTOMRIGHT", 2, -4)

	T.SkinCloseButton(TabardFrameCloseButton, TabardFrame.backdrop)

	TabardFrameCancelButton:SkinButton()
	TabardFrameAcceptButton:SkinButton()
	TabardFrameAcceptButton:ClearAllPoints()
	TabardFrameAcceptButton:Point("RIGHT", TabardFrameCancelButton, "LEFT", -3, 0)

	T.SkinRotateButton(TabardCharacterModelRotateLeftButton)
	T.SkinRotateButton(TabardCharacterModelRotateRightButton)
	TabardCharacterModelRotateLeftButton:ClearAllPoints()
	TabardCharacterModelRotateLeftButton:Point("BOTTOMLEFT", TabardModel.backdrop, "BOTTOMLEFT", 4, 4)
	TabardCharacterModelRotateRightButton:ClearAllPoints()
	TabardCharacterModelRotateRightButton:Point("LEFT", TabardCharacterModelRotateLeftButton, "RIGHT", 3, 0)

	TabardFrameMoneyBg:StripTextures()
	TabardFrameMoneyInset:StripTextures()
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