local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Garrison skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local Tooltips = {
		FloatingGarrisonFollowerTooltip,
		FloatingGarrisonFollowerAbilityTooltip,
		GarrisonFollowerAbilityTooltip,
		GarrisonBuildingFrame.BuildingLevelTooltip,
	}
	for i, tt in pairs(Tooltips) do
		tt.Background:SetTexture(nil)
		tt.BorderTop:SetTexture(nil)
		tt.BorderTopLeft:SetTexture(nil)
		tt.BorderTopRight:SetTexture(nil)
		tt.BorderLeft:SetTexture(nil)
		tt.BorderRight:SetTexture(nil)
		tt.BorderBottom:SetTexture(nil)
		tt.BorderBottomRight:SetTexture(nil)
		tt.BorderBottomLeft:SetTexture(nil)
		tt:SetTemplate("Transparent")

		if tt.Portrait then tt.Portrait:StripTextures() end
	end

	GarrisonLandingPage:StripTextures()
	GarrisonLandingPage:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonLandingPage.CloseButton)
	T.SkinTab(GarrisonLandingPageTab1)
	T.SkinTab(GarrisonLandingPageTab2)
	GarrisonLandingPageTab1:ClearAllPoints()
	GarrisonLandingPageTab1:SetPoint("TOPLEFT", GarrisonLandingPage, "BOTTOMLEFT", 70, 2)

	-- GarrisonLandingPageReport.InProgress:GetRegions():Kill()
	-- GarrisonLandingPageReport.InProgress:SkinButton()
	-- GarrisonLandingPageReport.Available:GetRegions():Kill()
	-- GarrisonLandingPageReport.Available:SkinButton()

	GarrisonLandingPage.FollowerList:StripTextures()
	GarrisonLandingPage.FollowerList:SetTemplate("Transparent")
	--WoD T.SkinEditBox(GarrisonLandingPage.FollowerList.SearchBox)
end

T.SkinFuncs["Blizzard_GarrisonUI"] = LoadSkin