local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Tabard skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TabardFrame:StripTextures()
	TabardFrame:CreateBackdrop("Transparent")
	TabardFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	TabardFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

	TabardFrameInset:StripTextures()
	TabardFramePortrait:Kill()

	TabardModel:CreateBackdrop("Overlay")
	TabardModel.backdrop:SetPoint("TOPLEFT", 2, 0)
	TabardModel.backdrop:SetPoint("BOTTOMRIGHT", 2, -4)

	T.SkinCloseButton(TabardFrameCloseButton, TabardFrame.backdrop)

	TabardFrameCancelButton:SkinButton()
	TabardFrameAcceptButton:SkinButton()
	TabardFrameAcceptButton:ClearAllPoints()
	TabardFrameAcceptButton:SetPoint("RIGHT", TabardFrameCancelButton, "LEFT", -3, 0)

	T.SkinRotateButton(TabardCharacterModelRotateLeftButton)
	T.SkinRotateButton(TabardCharacterModelRotateRightButton)
	TabardCharacterModelRotateLeftButton:ClearAllPoints()
	TabardCharacterModelRotateLeftButton:SetPoint("BOTTOMLEFT", TabardModel.backdrop, "BOTTOMLEFT", 4, 4)
	TabardCharacterModelRotateRightButton:ClearAllPoints()
	TabardCharacterModelRotateRightButton:SetPoint("LEFT", TabardCharacterModelRotateLeftButton, "RIGHT", 3, 0)

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
			_G[custom]:SetPoint("TOP", _G["TabardFrameCustomization"..i-1], "BOTTOM", 0, -6)
		else
			local point, anchor, point2, x, y = _G[custom]:GetPoint()
			_G[custom]:SetPoint(point, anchor, point2, x, y + 4)
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)