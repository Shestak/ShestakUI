local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Garrison skin
----------------------------------------------------------------------------------------
local function LoadSkin()
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