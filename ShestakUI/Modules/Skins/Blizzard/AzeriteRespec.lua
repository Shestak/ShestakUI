local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AzeriteRespecUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	AzeriteRespecFrame:StripTextures()
	AzeriteRespecFrame:SetTemplate("Transparent")

	local ItemSlots = AzeriteRespecFrame.ItemSlot
	ItemSlots:StripTextures()
	ItemSlots.Icon:SkinIcon()

	hooksecurefunc(ItemSlots.GlowOverlay, "Show", function() ItemSlots.backdrop:SetBackdropBorderColor(0.64, 0.2, 0.93) end)
	hooksecurefunc(ItemSlots.GlowOverlay, "Hide", function() ItemSlots.backdrop:SetBackdropBorderColor(unpack(C.media.border_color)) end)

	AzeriteRespecFrame.ButtonFrame.MoneyFrameEdge:StripTextures()
	AzeriteRespecFrameMoneyFrame:SetPoint("BOTTOMRIGHT", -155, 9)

	AzeriteRespecFrame.ButtonFrame:StripTextures()
	AzeriteRespecFrame.ButtonFrame.AzeriteRespecButton:SkinButton()
	AzeriteRespecFrame.ButtonFrame.AzeriteRespecButton:SetPoint("BOTTOMRIGHT", -4, 5)
	T.SkinCloseButton(AzeriteRespecFrameCloseButton)
	T.SkinHelpBox(AzeriteRespecFrame.HelpBox)
end

T.SkinFuncs["Blizzard_AzeriteRespecUI"] = LoadSkin