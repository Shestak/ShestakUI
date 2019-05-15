local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ArtifactUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ArtifactFrame:StripTextures()
	ArtifactFrame:SetTemplate("Transparent")
	ArtifactFrame:CreateBackdrop()
	ArtifactFrame.BorderFrame:StripTextures()

	for i = 1, 2 do
		T.SkinTab(_G["ArtifactFrameTab" .. i])
	end
	ArtifactFrameTab1:ClearAllPoints()
	ArtifactFrameTab1:SetPoint("TOPLEFT", ArtifactFrame, "BOTTOMLEFT", 0, -2)

	ArtifactFrame.ForgeBadgeFrame.ItemIcon:Hide()
	ArtifactFrame.ForgeBadgeFrame.ForgeLevelBackground:ClearAllPoints()
	ArtifactFrame.ForgeBadgeFrame.ForgeLevelBackground:SetPoint("TOPLEFT", ArtifactFrame)

	T.SkinHelpBox(ArtifactFrame.KnowledgeLevelHelpBox)

	T.SkinCloseButton(ArtifactFrame.CloseButton)
	T.SkinCloseButton(ArtifactFrame.AppearanceTabHelpBox.CloseButton)
end

T.SkinFuncs["Blizzard_ArtifactUI"] = LoadSkin
