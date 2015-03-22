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
			FloatingGarrisonMissionTooltip,
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
	-- Building frame
	GarrisonBuildingFrame:StripTextures()
	GarrisonBuildingFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonBuildingFrame.CloseButton)
	GarrisonBuildingFrame.TownHallBox.UpgradeButton:SkinButton()
	GarrisonBuildingFrame.InfoBox.UpgradeButton:SkinButton()
	GarrisonBuildingFrame.BuildingLevelTooltip:StripTextures()
	GarrisonBuildingFrame.BuildingLevelTooltip:SetTemplate('Transparent')

	GarrisonLandingPage:StripTextures()
	GarrisonLandingPage:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonLandingPage.CloseButton)
	GarrisonLandingPageTab1:SetPoint("TOPLEFT", GarrisonLandingPage, "BOTTOMLEFT", 70, 2)
	T.SkinTab(GarrisonLandingPageTab1)
	T.SkinTab(GarrisonLandingPageTab2)

	GarrisonLandingPage.FollowerList:StripTextures()
	GarrisonLandingPage.FollowerList:SetTemplate("Transparent")
	GarrisonLandingPage.FollowerList.SearchBox:SetPoint("TOPLEFT", 2, 25)
	T.SkinEditBox(GarrisonLandingPage.FollowerList.SearchBox)

	GarrisonMissionFrame:StripTextures()
	GarrisonMissionFrame.TitleText:Show()
	GarrisonMissionFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonMissionFrame.CloseButton)
	T.SkinCloseButton(GarrisonMissionFrame.MissionTab.MissionPage.CloseButton)

	-- Handle MasterPlan AddOn
	do
		local function skinMasterPlan()
			T.SkinTab(GarrisonMissionFrameTab3)
			T.SkinTab(GarrisonMissionFrameTab4)
			local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
			T.SkinCloseButton(MissionPage.MinimizeButton, nil, "-")
			MissionPage.MinimizeButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
		end

		if IsAddOnLoaded("MasterPlan") then
			skinMasterPlan()
		else
			local f = CreateFrame("Frame")
			f:RegisterEvent("ADDON_LOADED")
			f:SetScript("OnEvent", function(self, event, addon)
				if addon == "MasterPlan" then
					skinMasterPlan()
					self:UnregisterEvent("ADDON_LOADED")
				end
			end)
		end
	end
	local StartButton = GarrisonMissionFrame.MissionTab.MissionPage.StartMissionButton
	StartButton:SkinButton()
	StartButton.overlay:SetVertexColor(0.3, 0.3, 0.3, 0.3)
	StartButton:SetScript("OnLeave", function(self)
		StartButton:SetBackdropBorderColor(unpack(C.media.border_color))
		StartButton.overlay:SetVertexColor(0.3, 0.3, 0.3, 0.3)
	end)

	GarrisonMissionFrameTab1:SetPoint("BOTTOMLEFT", GarrisonMissionFrame, "BOTTOMLEFT", 11, -40)
	T.SkinTab(GarrisonMissionFrameTab1)
	T.SkinTab(GarrisonMissionFrameTab2)

	GarrisonMissionFrameFollowers:StripTextures()
	GarrisonMissionFrameFollowers:SetTemplate("Transparent")
	T.SkinEditBox(GarrisonMissionFrameFollowers.SearchBox)
	T.SkinScrollBar(GarrisonMissionFrameFollowersListScrollFrameScrollBar)

	-- Mission list
	local MissionTab = GarrisonMissionFrame.MissionTab
	local MissionList = MissionTab.MissionList
	local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
	MissionList:DisableDrawLayer("BORDER")
	T.SkinScrollBar(MissionList.listScroll.scrollBar)
	T.SkinCloseButton(MissionPage.CloseButton)
	MissionPage.CloseButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
	MissionList.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	MissionPage.StartMissionButton:SkinButton()
	GarrisonMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	hooksecurefunc("GarrisonMissionButton_SetRewards", function(self, rewards, numRewards)
		if self.numRewardsStyled == nil then
			self.numRewardsStyled = 0
		end
		while self.numRewardsStyled < numRewards do
			self.numRewardsStyled = self.numRewardsStyled + 1
			local reward = self.Rewards[self.numRewardsStyled]
			local icon = reward.Icon
			reward:GetRegions():Hide()
			if not reward.border then
				reward.border = CreateFrame("Frame", nil, reward)
				reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end
		end
	end)

	hooksecurefunc("GarrisonMissionPage_SetReward", function(frame, reward)
		frame.BG:SetTexture()
		if not frame.backdrop then
			frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
		frame.Icon:SetDrawLayer("BORDER", 0)
	end)

	hooksecurefunc("GarrisonMissionPage_UpdateStartButton", function(missionPage)
		missionPage.StartMissionButton.Flash:Hide()
		missionPage.StartMissionButton.FlashAnim:Stop()
	end)

	-- Capacitive display frame
	GarrisonCapacitiveDisplayFrame:StripTextures(true)
	GarrisonCapacitiveDisplayFrame.Inset:StripTextures()
	GarrisonCapacitiveDisplayFrame:SetTemplate("Transparent")

	T.SkinNextPrevButton(GarrisonCapacitiveDisplayFrame.DecrementButton)
	T.SkinNextPrevButton(GarrisonCapacitiveDisplayFrame.IncrementButton)
	GarrisonCapacitiveDisplayFrame.Count:StripTextures()
	T.SkinEditBox(GarrisonCapacitiveDisplayFrame.Count)
	T.SkinCloseButton(GarrisonCapacitiveDisplayFrameCloseButton)
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:SkinButton()
	GarrisonCapacitiveDisplayFrame.CreateAllWorkOrdersButton:SkinButton()
	local CapacitiveDisplay = GarrisonCapacitiveDisplayFrame.CapacitiveDisplay
	CapacitiveDisplay.IconBG:SetTexture()
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	CapacitiveDisplay.ShipmentIconFrame:SetTemplate("Default", true)
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetPoint("TOPLEFT", -2, 2)
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetPoint("BOTTOMRIGHT", 2, -2)

	--Fix frame strata
	GarrisonCapacitiveDisplayFrame:SetFrameStrata("MEDIUM")
	GarrisonCapacitiveDisplayFrame:SetFrameLevel(45)

	do
		local reagentIndex = 1
		hooksecurefunc("GarrisonCapacitiveDisplayFrame_Update", function(self)
			local reagents = CapacitiveDisplay.Reagents
			local reagent = reagents[reagentIndex]
			while reagent do
				reagent.NameFrame:SetTexture()
				reagent.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				reagent.Icon:SetDrawLayer("BORDER")

				if not reagent.border then
					reagent.border = CreateFrame("Frame", nil, reagent)
					reagent.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					reagent.Count:SetParent(reagent.border)
				end

				if not reagent.backdrop then
					reagent:CreateBackdrop("Default", true)
				end

				reagentIndex = reagentIndex + 1
				reagent = reagents[reagentIndex]
			end
		end)
	end
end

T.SkinFuncs["Blizzard_GarrisonUI"] = LoadSkin
