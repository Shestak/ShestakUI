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
			GarrisonShipyardFollowerTooltip,
			FloatingGarrisonShipyardFollowerTooltip,
			GarrisonFollowerTooltip
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
	GarrisonBuildingFrame.BuildingLevelTooltip:SetTemplate("Transparent")

	-- Mission UI
	GarrisonMissionFrame:StripTextures()
	GarrisonMissionFrame.TitleText:Show()
	GarrisonMissionFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonMissionFrame.CloseButton)
	T.SkinCloseButton(GarrisonMissionFrame.MissionTab.MissionPage.CloseButton)
	GarrisonMissionFrameTab1:SetPoint("BOTTOMLEFT", GarrisonMissionFrame, "BOTTOMLEFT", 11, -40)
	T.SkinTab(GarrisonMissionFrameTab1)
	T.SkinTab(GarrisonMissionFrameTab2)

	-- Landing page
	GarrisonLandingPage:StripTextures()
	GarrisonLandingPage:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonLandingPage.CloseButton)
	GarrisonLandingPageTab1:SetPoint("TOPLEFT", GarrisonLandingPage, "BOTTOMLEFT", 70, 2)
	T.SkinTab(GarrisonLandingPageTab1)
	T.SkinTab(GarrisonLandingPageTab2)
	T.SkinTab(GarrisonLandingPageTab3)
	GarrisonLandingPage.FollowerList:StripTextures()
	GarrisonLandingPage.FollowerList:SetTemplate("Transparent")
	GarrisonLandingPage.FollowerList.SearchBox:SetPoint("TOPLEFT", 2, 25)
	T.SkinEditBox(GarrisonLandingPage.FollowerList.SearchBox)
	-- GarrisonLandingPage.ShipFollowerList:StripTextures()
	GarrisonLandingPage.ShipFollowerList:SetTemplate("Transparent")
	T.SkinEditBox(GarrisonLandingPage.ShipFollowerList.SearchBox)

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

	-- ShipYard
	GarrisonShipyardFrame:StripTextures(true)
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
	MissionList.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	GarrisonShipyardFrame.MissionComplete.NextMissionButton:SkinButton()
	MissionList.CompleteDialog:SetAllPoints(MissionList.MapTexture)
	GarrisonShipyardFrame.MissionCompleteBackground:SetAllPoints(MissionList.MapTexture)
	MissionPage.StartMissionButton:SkinButton()
	MissionPage.StartMissionButton.Flash:Hide()
	MissionPage.StartMissionButton.Flash.Show = T.dummy
	MissionPage.StartMissionButton.FlashAnim:Stop()
	MissionPage.StartMissionButton.FlashAnim.Play = T.dummy
	GarrisonMissionFrameHelpBoxButton:SkinButton()
	GarrisonShipyardFrame.MissionTab.MissionList.CompleteDialog.BorderFrame:StripTextures()
	GarrisonShipyardFrame.MissionTab.MissionList.CompleteDialog.BorderFrame:SetTemplate("Transparent")

	-- Handle MasterPlan AddOn
	do
		local function skinMasterPlan()
			T.SkinTab(GarrisonLandingPageTab4)
			T.SkinTab(GarrisonMissionFrameTab3)
			T.SkinTab(GarrisonMissionFrameTab4)
			T.SkinTab(GarrisonShipyardFrameTab3)
			local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
			T.SkinCloseButton(MissionPage.MinimizeButton, nil, "-")
			MissionPage.MinimizeButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
			MPCompleteAll:SkinButton()
			MPPokeTentativeParties:SkinButton()
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

	GarrisonMissionFrameFollowers:StripTextures()
	GarrisonMissionFrameFollowers:SetTemplate("Transparent")
	T.SkinEditBox(GarrisonMissionFrameFollowers.SearchBox)
	T.SkinScrollBar(GarrisonMissionFrameFollowersListScrollFrameScrollBar)
	T.SkinScrollBar(GarrisonLandingPageReportListListScrollFrameScrollBar)
	T.SkinScrollBar(GarrisonMissionFrame.FollowerList.listScroll.scrollBar)
	T.SkinScrollBar(GarrisonShipyardFrame.FollowerList.listScroll.scrollBar)
	T.SkinScrollBar(GarrisonLandingPageFollowerListListScrollFrameScrollBar)
	T.SkinScrollBar(GarrisonLandingPageShipFollowerListListScrollFrameScrollBar)

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

	-- Capacitive display frame
	GarrisonCapacitiveDisplayFrame:StripTextures(true)
	GarrisonCapacitiveDisplayFrame.Inset:StripTextures()
	GarrisonCapacitiveDisplayFrame:SetTemplate("Transparent")

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
	CapacitiveDisplay.ShipmentIconFrame:SetTemplate("Default", true)
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetPoint("TOPLEFT", -2, 2)
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetPoint("BOTTOMRIGHT", 2, -2)

	-- Fix frame strata
	GarrisonCapacitiveDisplayFrame:SetFrameStrata("MEDIUM")
	GarrisonCapacitiveDisplayFrame:SetFrameLevel(45)

	local function onUpdateData(self)
		local followerFrame = self:GetParent()
		local followers = followerFrame.FollowerList.followers
		local followersList = followerFrame.FollowerList.followersList
		local numFollowers = #followersList
		local scrollFrame = followerFrame.FollowerList.listScroll
		local offset = HybridScrollFrame_GetOffset(scrollFrame)
		local buttons = scrollFrame.buttons
		local numButtons = #buttons

		for i = 1, #buttons do
			local button = buttons[i]
			local portrait = button.PortraitFrame

			if not button.restyled then
				button.BG:Hide()
				button.Selection:SetTexture("")
				button.AbilitiesBG:SetTexture("")

				button:CreateBackdrop("Overlay")
				button.backdrop:SetAllPoints()
				button:StyleButton()

				button.BusyFrame:SetAllPoints()


				if portrait then
					local level = portrait.Level
					local cover = portrait.PortraitRingCover

					portrait.PortraitRing:Hide()
					portrait.PortraitRingQuality:SetTexture("")

					portrait.LevelBorder:SetTexture(0, 0, 0, .5)
					portrait.LevelBorder:SetSize(44, 11)
					portrait.LevelBorder:ClearAllPoints()
					portrait.LevelBorder:SetPoint("BOTTOM", 0, 12)

					level:ClearAllPoints()
					level:SetPoint("BOTTOM", portrait, 0, 12)

					local squareBG = CreateFrame("Frame", nil, portrait)
					squareBG:SetFrameLevel(portrait:GetFrameLevel() - 1)
					squareBG:SetPoint("TOPLEFT", 3, -3)
					squareBG:SetPoint("BOTTOMRIGHT", -3, 11)
					squareBG:SetTemplate("Transparent")
					portrait.squareBG = squareBG

					if cover then
						cover:SetTexture(0, 0, 0)
						cover:SetAllPoints(squareBG)
					end
					portrait:ClearAllPoints()
					portrait:SetPoint("TOPLEFT", 4, -1)
				end

				button.restyled = true
			end

			if button.Selection:IsShown() then
				button.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				button.backdrop.overlay:SetVertexColor(1, 0.82, 0, 0.3)
			else
				button.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end

			if portrait then
				if portrait.PortraitRingQuality:IsShown() then
					portrait.squareBG:SetBackdropBorderColor(portrait.PortraitRingQuality:GetVertexColor())
				else
					portrait.squareBG:SetBackdropBorderColor(0, 0, 0)
				end
			end
		end
	end

	hooksecurefunc(GarrisonMissionFrameFollowers, "UpdateData", onUpdateData)
	hooksecurefunc(GarrisonLandingPageFollowerList, "UpdateData", onUpdateData)

	hooksecurefunc("GarrisonMissionFrame_SetFollowerPortrait", function(portrait, followerInfo)
		if not portrait.styled then
			local level = portrait.Level
			local cover = portrait.PortraitRingCover

			portrait.PortraitRing:Hide()
			portrait.PortraitRingQuality:SetTexture("")

			portrait.LevelBorder:SetTexture(0, 0, 0, .5)
			portrait.LevelBorder:SetSize(44, 11)
			portrait.LevelBorder:ClearAllPoints()
			portrait.LevelBorder:SetPoint("BOTTOM", 0, 12)

			level:ClearAllPoints()
			level:SetPoint("BOTTOM", portrait, 0, 12)

			local squareBG = CreateFrame("Frame", nil, portrait)
			squareBG:SetFrameLevel(portrait:GetFrameLevel() - 1)
			squareBG:SetPoint("TOPLEFT", 3, -3)
			squareBG:SetPoint("BOTTOMRIGHT", -3, 11)
			squareBG:SetTemplate("Transparent")
			portrait.squareBG = squareBG

			if cover then
				cover:SetTexture(0, 0, 0)
				cover:SetAllPoints(squareBG)
			end

			portrait.styled = true
		end

		local color = ITEM_QUALITY_COLORS[followerInfo.quality]

		portrait.squareBG:SetBackdropBorderColor(color.r, color.g, color.b)
	end)

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

			ability.IconButton:CreateBackdrop("Overlay")

			icon:SetTexCoord(.08, .92, .08, .92)
			icon:SetDrawLayer("BACKGROUND", 1)

			numAbilitiesStyled = numAbilitiesStyled + 1
			ability = abilities[numAbilitiesStyled]
		end

		self.numAbilitiesStyled = numAbilitiesStyled
	end

	hooksecurefunc(GarrisonMissionFrame.FollowerList, "ShowFollower", onShowFollower)
	hooksecurefunc(GarrisonLandingPageFollowerList, "ShowFollower", onShowFollower)

	local xpBar = GarrisonLandingPage.FollowerTab.XPBar
	select(1, xpBar:GetRegions()):Hide()
	xpBar.XPLeft:Hide()
	xpBar.XPRight:Hide()
	select(4, xpBar:GetRegions()):Hide()

	xpBar:SetStatusBarTexture(C.media.texture)
	xpBar:CreateBackdrop("Overlay")

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
