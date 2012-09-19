local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ReforgingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ReforgingFrame:StripTextures()
	ReforgingFrame:SetTemplate("Transparent")

	ReforgingFrameMoneyFrame:StripTextures()
	ReforgingFrame.ButtonFrame:StripTextures()
	ReforgingFrameReforgeButton:ClearAllPoints()
	ReforgingFrameReforgeButton:Point("LEFT", ReforgingFrameRestoreButton, "RIGHT", 2, 0)
	ReforgingFrameReforgeButton:Point("BOTTOMRIGHT", -3, 3)
	ReforgingFrameRestoreButton:SkinButton(true)
	ReforgingFrameReforgeButton:SkinButton(true)

	ReforgingFrame.ItemButton:StripTextures()
	ReforgingFrame.ItemButton:SetTemplate("Default")
	ReforgingFrame.ItemButton.IconTexture:ClearAllPoints()
	ReforgingFrame.ItemButton.IconTexture:Point("TOPLEFT", 2, -2)
	ReforgingFrame.ItemButton.IconTexture:Point("BOTTOMRIGHT", -2, 2)

	local hover = ReforgingFrame.ItemButton:CreateTexture("Frame", nil, self)
	hover:SetTexture(1, 1, 1, 0.3)
	hover:Size(ReforgingFrame.ItemButton:GetWidth(), ReforgingFrame.ItemButton:GetHeight())
	hover:Point("TOPLEFT", ReforgingFrame.ItemButton, 2, -2)
	hover:Point("BOTTOMRIGHT", ReforgingFrame.ItemButton, -2, 2)
	ReforgingFrame.ItemButton:SetHighlightTexture(hover)

	hooksecurefunc("ReforgingFrame_Update", function(self)
		local _, icon = GetReforgeItemInfo()
		if icon then
			ReforgingFrame.ItemButton.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		else
			ReforgingFrame.ItemButton.IconTexture:SetTexture(nil)
		end
	end)

	T.SkinCloseButton(ReforgingFrameCloseButton)
end

T.SkinFuncs["Blizzard_ReforgingUI"] = LoadSkin