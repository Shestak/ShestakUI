local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Garrison skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "Blizzard_GarrisonUI" then
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
	end
end)

if C.skins.blizzard_frames ~= true then return end

local function LoadSkin()
	GarrisonBuildingFrame:StripTextures()
	GarrisonBuildingFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonBuildingFrame.CloseButton)
	GarrisonBuildingFrame.TownHallBox.UpgradeButton:SkinButton()
	GarrisonBuildingFrame.InfoBox.UpgradeButton:SkinButton()
	
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
	GarrisonLandingPage.FollowerList.SearchBox:SetPoint("TOPLEFT", 2, 25)
	T.SkinEditBox(GarrisonLandingPage.FollowerList.SearchBox)
end

T.SkinFuncs["Blizzard_GarrisonUI"] = LoadSkin