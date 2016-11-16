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

	if addon == "ShestakUI" then
		local Tooltips = {
			FloatingGarrisonFollowerTooltip,
			FloatingGarrisonFollowerAbilityTooltip,
			FloatingGarrisonMissionTooltip,
			FloatingGarrisonShipyardFollowerTooltip,
			GarrisonFollowerTooltip,
			GarrisonFollowerAbilityTooltip,
			GarrisonShipyardFollowerTooltip,
			GarrisonShipyardMapMissionTooltip
		}

		for _, tt in pairs(Tooltips) do
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
		end
		T.SkinCloseButton(FloatingGarrisonFollowerTooltip.CloseButton)
		T.SkinCloseButton(FloatingGarrisonFollowerAbilityTooltip.CloseButton)
		T.SkinCloseButton(FloatingGarrisonMissionTooltip.CloseButton)
		T.SkinCloseButton(FloatingGarrisonShipyardFollowerTooltip.CloseButton)
	end

	if addon == "Blizzard_GarrisonUI" then
		GarrisonBuildingFrame.BuildingLevelTooltip:StripTextures()
		GarrisonBuildingFrame.BuildingLevelTooltip:SetTemplate("Transparent")

		GarrisonMissionMechanicFollowerCounterTooltip:HookScript("OnShow", function(self)
			self:SetTemplate("Transparent")
		end)
		GarrisonMissionMechanicTooltip:HookScript("OnShow", function(self)
			self:SetTemplate("Transparent")
		end)
	end
end)

if C.skins.blizzard_frames ~= true then return end

local function LoadSkin()
	-- Building frame
	GarrisonBuildingFrame:StripTextures()
	GarrisonBuildingFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonBuildingFrame.CloseButton)

	for _, button in pairs({GarrisonBuildingFrame.TownHallBox.UpgradeButton, GarrisonBuildingFrame.InfoBox.UpgradeButton}) do
		button:StripTextures(true)
		button:SkinButton()
	end

	-- Confirmation popup
	local Confirmation = GarrisonBuildingFrame.Confirmation
	Confirmation:StripTextures()
	Confirmation:SetTemplate("Transparent")

	Confirmation.CancelButton:SkinButton()
	Confirmation.BuildButton:SkinButton()
	Confirmation.UpgradeButton:SkinButton()
	Confirmation.UpgradeGarrisonButton:SkinButton()
	Confirmation.ReplaceButton:SkinButton()
	Confirmation.SwitchButton:SkinButton()

	-- Mission UI
	GarrisonMissionFrame:StripTextures()
	GarrisonMissionFrame.GarrCorners:StripTextures()
	GarrisonMissionFrame.TitleText:Show()
	GarrisonMissionFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonMissionFrame.CloseButton)
	GarrisonMissionFrameTab1:SetPoint("BOTTOMLEFT", GarrisonMissionFrame, "BOTTOMLEFT", 11, -40)
	T.SkinTab(GarrisonMissionFrameTab1)
	T.SkinTab(GarrisonMissionFrameTab2)

	-- Mission list
	local MissionTab = GarrisonMissionFrame.MissionTab
	local MissionList = MissionTab.MissionList
	local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
	MissionList:DisableDrawLayer("BORDER")
	T.SkinScrollBar(MissionList.listScroll.scrollBar)
	T.SkinCloseButton(MissionPage.CloseButton)
	MissionPage.CloseButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
	MissionList.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	GarrisonMissionFrame.MissionComplete.NextMissionButton:SkinButton()
	GarrisonMissionFrameHelpBoxButton:SkinButton()

	GarrisonMissionFrameFollowers:StripTextures()
	GarrisonMissionFrameFollowers:SetTemplate("Transparent")
	T.SkinEditBox(GarrisonMissionFrameFollowers.SearchBox)
	GarrisonMissionFrameFollowers.SearchBox:SetPoint("TOPLEFT", 2, 25)
	GarrisonMissionFrameFollowers.SearchBox:SetSize(301, 20)
	T.SkinScrollBar(GarrisonMissionFrameFollowersListScrollFrameScrollBar)
	GarrisonMissionFrameFollowers.MaterialFrame:GetRegions():Hide()
	GarrisonMissionFrameMissions.MaterialFrame:GetRegions():Hide()

	GarrisonMissionFrame.FollowerTab:StripTextures()
	GarrisonMissionFrame.FollowerTab:SetTemplate("Overlay")

	for _, item in pairs({GarrisonMissionFrame.FollowerTab.ItemWeapon, GarrisonMissionFrame.FollowerTab.ItemArmor}) do
		item.Border:Hide()
		item.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		item:CreateBackdrop("Default")
		item.backdrop:SetPoint("TOPLEFT", item.Icon, "TOPLEFT", -2, 2)
		item.backdrop:SetPoint("BOTTOMRIGHT", item.Icon, "BOTTOMRIGHT", 2, -2)
		item.backdrop:SetFrameLevel(item:GetFrameLevel())
	end

	local StartButton = MissionPage.StartMissionButton
	StartButton:SkinButton()

	hooksecurefunc("GarrisonMissionButton_SetRewards", function(self, rewards, numRewards)
		if self.numRewardsStyled == nil then
			self.numRewardsStyled = 0
		end
		while self.numRewardsStyled < numRewards do
			self.numRewardsStyled = self.numRewardsStyled + 1
			local reward = self.Rewards[self.numRewardsStyled]
			reward:GetRegions():Hide()
			if not reward.backdrop then
				reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				reward:CreateBackdrop("Default")
				reward.backdrop:SetPoint("TOPLEFT", reward.Icon, "TOPLEFT", -2, 2)
				reward.backdrop:SetPoint("BOTTOMRIGHT", reward.Icon, "BOTTOMRIGHT", 2, -2)
				reward.backdrop:SetFrameLevel(reward:GetFrameLevel())
			end
		end
	end)

	hooksecurefunc("GarrisonMissionPage_SetReward", function(frame, reward)
		frame.BG:Hide()
		if not frame.backdrop then
			frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			frame:CreateBackdrop("Default")
			frame.backdrop:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
		end
	end)

	-- Landing page
	GarrisonLandingPage:StripTextures()
	GarrisonLandingPage:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonLandingPage.CloseButton)
	GarrisonLandingPageTab1:SetPoint("TOPLEFT", GarrisonLandingPage, "BOTTOMLEFT", 70, 2)
	T.SkinTab(GarrisonLandingPageTab1)
	T.SkinTab(GarrisonLandingPageTab2)
	T.SkinTab(GarrisonLandingPageTab3)
	T.SkinScrollBar(GarrisonLandingPageReportListListScrollFrameScrollBar)

	GarrisonLandingPage.FollowerList:StripTextures()
	GarrisonLandingPage.FollowerList:SetTemplate("Transparent")
	GarrisonLandingPage.FollowerList.SearchBox:SetPoint("TOPLEFT", 2, 25)
	T.SkinEditBox(GarrisonLandingPage.FollowerList.SearchBox)
	T.SkinScrollBar(GarrisonLandingPageFollowerListListScrollFrameScrollBar)

	GarrisonLandingPageShipFollowerList:StripTextures()
	GarrisonLandingPageShipFollowerList:SetTemplate("Transparent")

	GarrisonLandingPageShipFollowerList.SearchBox:SetPoint("TOPLEFT", 2, 25)
	T.SkinEditBox(GarrisonLandingPageShipFollowerList.SearchBox)
	T.SkinScrollBar(GarrisonLandingPageShipFollowerListListScrollFrameScrollBar)

	GarrisonLandingPage.Report.InProgress:ClearAllPoints()
	GarrisonLandingPage.Report.InProgress:SetPoint("BOTTOMLEFT", GarrisonLandingPageReportList, "TOPLEFT", 5, 2)
	GarrisonLandingPage.Report.Available:ClearAllPoints()
	GarrisonLandingPage.Report.Available:SetPoint("LEFT", GarrisonLandingPage.Report.InProgress, "RIGHT", 4, 0)

	for _, tab in pairs({GarrisonLandingPage.Report.InProgress, GarrisonLandingPage.Report.Available}) do
		tab:CreateBackdrop("Overlay")
		tab.backdrop:SetAllPoints()
		tab:StyleButton()

		tab.Text:ClearAllPoints()
		tab.Text:SetPoint("CENTER")
	end

	hooksecurefunc("GarrisonLandingPageReport_SetTab", function(self)
		local unselectedTab = GarrisonLandingPage.Report.unselectedTab
		unselectedTab:SetHeight(36)

		self:SetWidth(198)
		unselectedTab:SetWidth(198)

		unselectedTab:SetNormalTexture("")
		unselectedTab.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
		unselectedTab.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)

		self:SetNormalTexture("")
		self.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
		self.backdrop.overlay:SetVertexColor(1, 0.82, 0, 0.3)
	end)

	for i = 1, #GarrisonLandingPage.Report.List.listScroll.buttons do
		local button = GarrisonLandingPage.Report.List.listScroll.buttons[i]
		for _, reward in pairs(button.Rewards) do
			reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			if not reward.backdrop then
				reward:CreateBackdrop("Default")
				reward.backdrop:SetPoint("TOPLEFT", reward.Icon, "TOPLEFT", -2, 2)
				reward.backdrop:SetPoint("BOTTOMRIGHT", reward.Icon, "BOTTOMRIGHT", 2, -2)
				reward.backdrop:SetFrameLevel(reward:GetFrameLevel())

				reward.Quantity:SetParent(reward.backdrop)
				reward.IconBorder:SetAlpha(0)
			end
		end
	end

	for _, xpBar in pairs({GarrisonLandingPage.FollowerTab.XPBar, GarrisonLandingPage.ShipFollowerTab.XPBar, GarrisonMissionFrame.FollowerTab.XPBar}) do
		xpBar:StripTextures()
		xpBar:CreateBackdrop("Default")
		xpBar.backdrop:SetFrameLevel(xpBar.backdrop:GetFrameLevel() + 1)
		xpBar:SetStatusBarTexture(C.media.texture)
	end

	local function onShowFollower(self, followerId)
		local followerList = self
		local self = self.followerTab

		local abilities = self.AbilitiesFrame.Abilities

		if self.numAbilitiesStyled == nil then
			self.numAbilitiesStyled = 1
		end

		local numAbilitiesStyled = self.numAbilitiesStyled

		local ability = abilities[numAbilitiesStyled]
		while ability do
			local icon = ability.IconButton.Icon

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetDrawLayer("BACKGROUND", 1)
			ability.IconButton:CreateBackdrop("Default")

			numAbilitiesStyled = numAbilitiesStyled + 1
			ability = abilities[numAbilitiesStyled]
		end

		self.numAbilitiesStyled = numAbilitiesStyled
	end

	hooksecurefunc(GarrisonMissionFrame.FollowerList, "ShowFollower", onShowFollower)
	hooksecurefunc(GarrisonLandingPageFollowerList, "ShowFollower", onShowFollower)

	-- ShipYard
	GarrisonShipyardFrame:StripTextures(true)
	GarrisonShipyardFrame.BorderFrame.GarrCorners:StripTextures()
	GarrisonShipyardFrame.BorderFrame:StripTextures(true)
	GarrisonShipyardFrame:CreateBackdrop("Transparent")
	GarrisonShipyardFrame.BorderFrame.TitleText:SetPoint("TOP", -6, -1)
	T.SkinCloseButton(GarrisonShipyardFrame.BorderFrame.CloseButton2)
	T.SkinTab(GarrisonShipyardFrameTab1)
	T.SkinTab(GarrisonShipyardFrameTab2)

	-- ShipYard: Naval Map
	local MissionTab = GarrisonShipyardFrame.MissionTab
	local MissionList = MissionTab.MissionList
	MissionList:CreateBackdrop("Transparent")

	-- ShipYard: Mission
	local MissionPage = MissionTab.MissionPage
	T.SkinCloseButton(MissionPage.CloseButton)
	MissionPage.CloseButton:SetFrameLevel(MissionPage.CloseButton:GetFrameLevel() + 2)
	MissionList.CompleteDialog.BorderFrame:StripTextures()
	MissionList.CompleteDialog.BorderFrame:SetTemplate("Transparent")
	MissionList.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	MissionList.CompleteDialog:SetAllPoints(MissionList.MapTexture)
	GarrisonShipyardFrame.MissionComplete.NextMissionButton:SkinButton()
	GarrisonShipyardFrame.MissionCompleteBackground:SetAllPoints(MissionList.MapTexture)
	MissionPage.StartMissionButton:SkinButton()

	T.SkinEditBox(GarrisonShipyardFrameFollowers.SearchBox)
	GarrisonShipyardFrameFollowers.SearchBox:SetPoint("TOPLEFT", 2, 25)
	GarrisonShipyardFrameFollowers.SearchBox:SetSize(301, 20)
	GarrisonShipyardFrameFollowers:StripTextures()
	GarrisonShipyardFrameFollowers:SetTemplate("Transparent")
	GarrisonShipyardFrameFollowers.MaterialFrame:GetRegions():Hide()
	GarrisonShipyardFrame.FollowerTab:StripTextures()
	GarrisonShipyardFrame.FollowerTab:SetTemplate("Overlay")
	T.SkinScrollBar(GarrisonShipyardFrameFollowersListScrollFrameScrollBar)

	-- Recruiter frame
	GarrisonRecruiterFrame:StripTextures(true)
	GarrisonRecruiterFrame:SetTemplate("Transparent")
	GarrisonRecruiterFrame.Inset:StripTextures()
	T.SkinCloseButton(GarrisonRecruiterFrame.CloseButton)
	GarrisonRecruiterFrame.UnavailableFrame:GetChildren():SkinButton()
	GarrisonRecruiterFrame.Pick.ChooseRecruits:SkinButton()
	T.SkinDropDownBox(GarrisonRecruiterFrame.Pick.ThreatDropDown)
	T.SkinCheckBox(GarrisonRecruiterFrame.Pick.Radio1)
	T.SkinCheckBox(GarrisonRecruiterFrame.Pick.Radio2)

	-- Recruiter select frame
	GarrisonRecruitSelectFrame:StripTextures()
	GarrisonRecruitSelectFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonRecruitSelectFrame.CloseButton)

	GarrisonRecruitSelectFrame.FollowerList:StripTextures()
	GarrisonRecruitSelectFrame.FollowerList:SetTemplate("Transparent")
	T.SkinScrollBar(GarrisonRecruitSelectFrameListScrollFrameScrollBar)
	T.SkinEditBox(GarrisonRecruitSelectFrame.FollowerList.SearchBox)
	GarrisonRecruitSelectFrame.FollowerList.SearchBox:SetPoint("TOPLEFT", 2, 25)
	GarrisonRecruitSelectFrame.FollowerList.SearchBox:SetSize(301, 20)
	GarrisonRecruitSelectFrame.FollowerSelection:StripTextures()
	GarrisonRecruitSelectFrame.FollowerSelection:SetTemplate("Overlay")

	for i = 1, 3 do
		local recruit = GarrisonRecruitSelectFrame.FollowerSelection["Recruit"..i]
		recruit.HireRecruits:SkinButton()
	end

	-- Capacitive display frame
	GarrisonCapacitiveDisplayFrame:StripTextures(true)
	GarrisonCapacitiveDisplayFrame.Inset:StripTextures()
	GarrisonCapacitiveDisplayFrame:SetTemplate("Transparent")
	GarrisonCapacitiveDisplayFrame:SetFrameLevel(5)

	T.SkinNextPrevButton(GarrisonCapacitiveDisplayFrame.DecrementButton, true)
	GarrisonCapacitiveDisplayFrame.DecrementButton:SetSize(22, 22)
	T.SkinNextPrevButton(GarrisonCapacitiveDisplayFrame.IncrementButton)
	GarrisonCapacitiveDisplayFrame.IncrementButton:SetSize(22, 22)
	GarrisonCapacitiveDisplayFrame.Count:StripTextures()
	T.SkinEditBox(GarrisonCapacitiveDisplayFrame.Count)
	GarrisonCapacitiveDisplayFrame.Count:SetHeight(18)
	T.SkinCloseButton(GarrisonCapacitiveDisplayFrameCloseButton)
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:SkinButton()
	GarrisonCapacitiveDisplayFrame.CreateAllWorkOrdersButton:SkinButton()
	local CapacitiveDisplay = GarrisonCapacitiveDisplayFrame.CapacitiveDisplay
	CapacitiveDisplay.IconBG:SetTexture()
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	CapacitiveDisplay.ShipmentIconFrame:SetTemplate("Default")
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetPoint("TOPLEFT", -2, 2)
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetPoint("BOTTOMRIGHT", 2, -2)

	do
		local reagentIndex = 1
		hooksecurefunc("GarrisonCapacitiveDisplayFrame_Update", function(self)
			local reagents = CapacitiveDisplay.Reagents
			local reagent = reagents[reagentIndex]
			while reagent do
				reagent.NameFrame:SetAlpha(0)
				reagent.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				if not reagent.backdrop then
					reagent:CreateBackdrop("Default")
					reagent.backdrop:SetPoint("TOPLEFT", reagent.Icon, -2, 2)
					reagent.backdrop:SetPoint("BOTTOMRIGHT", reagent.Icon, 2, -2)
				end

				reagentIndex = reagentIndex + 1
				reagent = reagents[reagentIndex]
			end
		end)
	end

	-- Handle MasterPlan AddOn
	do
		local function skinMasterPlan()
			T.SkinTab(GarrisonLandingPageTab4)
			T.SkinTab(GarrisonMissionFrameTab3)
			T.SkinTab(GarrisonMissionFrameTab4)
			T.SkinTab(GarrisonShipyardFrameTab3)
			local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
			T.SkinCloseButton(MissionPage.MinimizeButton, nil, "-")
			MissionPage.MinimizeButton:SetPoint("TOPRIGHT", GarrisonMissionFrame.MissionTab.MissionPage.CloseButton, "TOPLEFT", -3, 0)
			MissionPage.MinimizeButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetSize(18, 18)
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetPoint("TOPRIGHT", -4, -4)

			local MissionPage = GarrisonShipyardFrame.MissionTab.MissionPage
			T.SkinCloseButton(MissionPage.MinimizeButton, nil, "-")
			MissionPage.MinimizeButton:SetPoint("TOPRIGHT", GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton, "TOPLEFT", -3, 0)
			MissionPage.MinimizeButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetSize(18, 18)
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetPoint("TOPRIGHT", -4, -4)

			MPCompleteAll:SkinButton()
			MPPokeTentativeParties:SkinButton()
			GarrisonMissionFrameFollowers.SearchBox:SetSize(270, 20)
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
end

T.SkinFuncs["Blizzard_GarrisonUI"] = LoadSkin