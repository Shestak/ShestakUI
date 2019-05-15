local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ScrappingMachine skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ScrappingMachineFrame:StripTextures()
	ScrappingMachineFrame:SetTemplate("Transparent")

	local ItemSlots = ScrappingMachineFrame.ItemSlots
	ItemSlots:StripTextures()

	for button in pairs(ItemSlots.scrapButtons.activeObjects) do
		if not button.styled then
			button:SetHighlightTexture("")
			button.Icon:SkinIcon()
			button.IconBorder:SetAlpha(0)
			hooksecurefunc(button.IconBorder, "SetVertexColor", function(_, r, g, b) button.backdrop:SetBackdropBorderColor(r, g, b) end)
			hooksecurefunc(button.IconBorder, "Hide", function() button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color)) end)

			button.styled = true
		end
	end

	ScrappingMachineFrame.ScrapButton:SkinButton()
	T.SkinCloseButton(ScrappingMachineFrameCloseButton)
end

T.SkinFuncs["Blizzard_ScrappingMachineUI"] = LoadSkin