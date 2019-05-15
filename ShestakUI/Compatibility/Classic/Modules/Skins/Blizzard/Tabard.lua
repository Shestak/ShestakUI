local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Tabard skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TabardFrame:StripTextures()
	TabardFrame:CreateBackdrop("Transparent")
	TabardFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	TabardFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	TabardFramePortrait:Kill()

	TabardModel:CreateBackdrop("Overlay")
	TabardModel.backdrop:SetPoint("TOPLEFT", -8, 0)
	TabardModel.backdrop:SetPoint("BOTTOMRIGHT", 16, -4)

	T.SkinCloseButton(TabardFrameCloseButton, TabardFrame.backdrop)

	TabardFrameGreetingText:ClearAllPoints()
	TabardFrameGreetingText:SetPoint("TOP", TabardFrame.backdrop, "TOP", 0, -28)

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

	TabardFrameCostFrame:StripTextures()
	TabardFrameCostFrame:ClearAllPoints()
	TabardFrameCostFrame:SetPoint("TOPRIGHT", TabardModel.backdrop, "TOPRIGHT", 8, -2)

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
			_G[custom]:SetPoint(point, anchor, point2, x + 14, y + 2)
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)