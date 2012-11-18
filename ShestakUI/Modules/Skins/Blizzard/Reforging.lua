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
	ReforgingFrameReforgeButton:SetPoint("LEFT", ReforgingFrameRestoreButton, "RIGHT", 2, 0)
	ReforgingFrameReforgeButton:SetPoint("BOTTOMRIGHT", -3, 3)
	ReforgingFrameRestoreButton:SkinButton(true)
	ReforgingFrameReforgeButton:SkinButton(true)

	ReforgingFrame.ItemButton:StripTextures()
	ReforgingFrame.ItemButton:SetTemplate("Default")
	ReforgingFrame.ItemButton.IconTexture:ClearAllPoints()
	ReforgingFrame.ItemButton.IconTexture:SetPoint("TOPLEFT", 2, -2)
	ReforgingFrame.ItemButton.IconTexture:SetPoint("BOTTOMRIGHT", -2, 2)

	local hover = ReforgingFrame.ItemButton:CreateTexture(nil, nil, self)
	hover:SetTexture(1, 1, 1, 0.3)
	hover:SetSize(ReforgingFrame.ItemButton:GetWidth(), ReforgingFrame.ItemButton:GetHeight())
	hover:SetPoint("TOPLEFT", ReforgingFrame.ItemButton, 2, -2)
	hover:SetPoint("BOTTOMRIGHT", ReforgingFrame.ItemButton, -2, 2)
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