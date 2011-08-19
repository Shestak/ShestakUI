local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ReforgingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ReforgingFrame:StripTextures()
	ReforgingFrame:SetTemplate("Transparent")

	ReforgingFrameTopInset:StripTextures()
	ReforgingFrameInset:StripTextures()
	ReforgingFrameBottomInset:StripTextures()

	ReforgingFrameRestoreButton:SkinButton(true)
	ReforgingFrameReforgeButton:SkinButton(true)

	T.SkinDropDownBox(ReforgingFrameFilterOldStat, 180)
	T.SkinDropDownBox(ReforgingFrameFilterNewStat, 180)

	ReforgingFrameItemButton:StripTextures()
	ReforgingFrameItemButton:SetTemplate("Default", true)
	ReforgingFrameItemButton:StyleButton()
	ReforgingFrameItemButtonIconTexture:ClearAllPoints()
	ReforgingFrameItemButtonIconTexture:Point("TOPLEFT", 2, -2)
	ReforgingFrameItemButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)

	hooksecurefunc("ReforgingFrame_Update", function(self)
		local currentReforge, icon, name, quality, bound, cost = GetReforgeItemInfo()
		if icon then
			ReforgingFrameItemButtonIconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		else
			ReforgingFrameItemButtonIconTexture:SetTexture(nil)
		end
	end)

	T.SkinCloseButton(ReforgingFrameCloseButton)
end

T.SkinFuncs["Blizzard_ReforgingUI"] = LoadSkin