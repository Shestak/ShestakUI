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

	ArtifactFrame.BorderFrame:StripTextures()

	for i = 1, 2 do
		T.SkinTab(_G["ArtifactFrameTab" .. i])
	end
	ArtifactFrameTab1:ClearAllPoints()
	ArtifactFrameTab1:SetPoint("TOPLEFT", ArtifactFrame, "BOTTOMLEFT", 0, -2)
end

T.SkinFuncs["Blizzard_ArtifactUI"] = LoadSkin