local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AzeriteEssenceUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinHelpBox(AzeriteEssenceUI.EssenceList.Tutorial)

	AzeriteEssenceUI:StripTextures()
	AzeriteEssenceUI:SetTemplate("Transparent")

	AzeriteEssenceUIPortrait:SetAlpha(0)

	AzeriteEssenceUI.PowerLevelBadgeFrame:ClearAllPoints()
	AzeriteEssenceUI.PowerLevelBadgeFrame:SetPoint("TOPLEFT")
	AzeriteEssenceUI.PowerLevelBadgeFrame.Ring:Hide()
	AzeriteEssenceUI.PowerLevelBadgeFrame.BackgroundBlack:Hide()

	for _, button in pairs(AzeriteEssenceUI.EssenceList.buttons) do
		button:DisableDrawLayer("ARTWORK")
		button:StyleButton(nil, 3)

		button.Icon:SkinIcon()
		button.Icon:SetSize(27, 27)
		button.Icon:SetPoint("LEFT", button, "LEFT", 6, 0)

		button.bg = CreateFrame("Frame", nil, button)
		button.bg:CreateBackdrop("Overlay")
		button.bg:SetFrameLevel(button:GetFrameLevel() - 1)
		button.bg:SetPoint("TOPLEFT", 3, -3)
		button.bg:SetPoint("BOTTOMRIGHT", -3, 3)
	end

	local HeaderButton = AzeriteEssenceUI.EssenceList.HeaderButton
	HeaderButton.Middle:Hide()
	HeaderButton.Left:Hide()
	HeaderButton.Right:Hide()

	T.SkinScrollBar(AzeriteEssenceUI.EssenceList.ScrollBar)
	T.SkinCloseButton(AzeriteEssenceUICloseButton)
end

T.SkinFuncs["Blizzard_AzeriteEssenceUI"] = LoadSkin