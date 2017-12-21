local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ArtifactUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ArtifactFrame:StripTextures()
	ArtifactFrame:SetTemplate("Transparent")
	ArtifactFrame:CreateBackdrop()
	T.SkinCloseButton(ArtifactFrame.CloseButton)
	T.SkinCloseButton(ArtifactRelicForgeFrameCloseButton)
	T.SkinCloseButton(ArtifactFrame.PerksTab.RelicTalentAlert.CloseButton)
	T.SkinCloseButton(ArtifactFrame.KnowledgeLevelHelpBox.CloseButton)

	ArtifactFrame.BorderFrame:StripTextures()

	for i = 1, 2 do
		T.SkinTab(_G["ArtifactFrameTab" .. i])
	end
	ArtifactFrameTab1:ClearAllPoints()
	ArtifactFrameTab1:SetPoint("TOPLEFT", ArtifactFrame, "BOTTOMLEFT", 0, -2)
	
	ArtifactRelicForgeFrame:StripTextures()
	ArtifactRelicForgeFrame:CreateBackdrop("Transparent")
	ArtifactRelicForgeFrame.PreviewRelicFrame:StripTextures()
	ArtifactRelicForgeFrame.PreviewRelicCover:StripTextures()
	
	ArtifactFrame.PerksTab.RelicTalentAlert:StripTextures()
	ArtifactFrame.PerksTab.RelicTalentAlert:CreateBackdrop("Transparent")
	ArtifactFrame.PerksTab.RelicTalentAlert:SetPoint("TOPRIGHT", ArtifactFrame, "TOPRIGHT", -20, 0)
	
	ArtifactFrame.KnowledgeLevelHelpBox:StripTextures()
	ArtifactFrame.KnowledgeLevelHelpBox.Arrow:Hide()
	ArtifactFrame.KnowledgeLevelHelpBox:CreateBackdrop("Transparent")
	
	ArtifactRelicForgeFrame.TutorialFrame.GlowBox:StripTextures()
	ArtifactRelicForgeFrame.TutorialFrame.GlowBox:CreateBackdrop("Transparent")
	ArtifactRelicForgeFrame.TutorialFrame.GlowBox.Button:SkinButton()
end

T.SkinFuncs["Blizzard_ArtifactUI"] = LoadSkin
