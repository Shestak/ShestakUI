local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	OrderHallUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	OrderHallCommandBar:StripTextures()
	OrderHallCommandBar:SetTemplate("Transparent")
	OrderHallCommandBar:ClearAllPoints()
	OrderHallCommandBar:SetPoint("TOP", UIParent, 0, -1)
	OrderHallCommandBar.ClassIcon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
	OrderHallCommandBar.ClassIcon:SetSize(46, 20)
	OrderHallCommandBar.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)
	OrderHallCommandBar.AreaName:ClearAllPoints()
	OrderHallCommandBar.AreaName:SetPoint("LEFT", OrderHallCommandBar.CurrencyIcon, "RIGHT", 25, 0)
	OrderHallCommandBar.AreaName:SetVertexColor(T.color.r, T.color.g, T.color.b)
	OrderHallCommandBar.WorldMapButton:Kill()

	OrderHallMissionFrame.ClassHallIcon:Kill()
	OrderHallMissionFrame:StripTextures()
	OrderHallMissionFrame:SetTemplate("Transparent")
	T.SkinCloseButton(OrderHallMissionFrame.CloseButton)

	for i = 1, 3 do
		T.SkinTab(_G["OrderHallMissionFrameTab" .. i])
	end

	OrderHallMissionFrame.GarrCorners:StripTextures()
	OrderHallMissionFrameMissions:StripTextures()
	OrderHallMissionFrameMissionsListScrollFrame:StripTextures()
	T.SkinScrollBar(OrderHallMissionFrameMissionsListScrollFrameScrollBar)
	OrderHallMissionFrameMissions.CombatAllyUI:StripTextures()
	OrderHallMissionFrameMissions.CombatAllyUI:CreateBackdrop("Overlay")
	OrderHallMissionFrameMissions.CombatAllyUI.backdrop:SetPoint("TOPLEFT", 18, -2)
	OrderHallMissionFrameMissions.CombatAllyUI.backdrop:SetPoint("BOTTOMRIGHT", -4, 2)
	OrderHallMissionFrameMissions.CombatAllyUI.InProgress.Unassign:SkinButton()
	OrderHallMissionFrameMissions.CombatAllyUI.InProgress.CombatAllySpell.iconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OrderHallMissionFrameMissions.CombatAllyUI.InProgress.CombatAllySpell:CreateBackdrop("Default")
	OrderHallMissionFrameMissions.MaterialFrame:StripTextures()
	OrderHallMissionFrame.MissionTab:StripTextures()
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage:StripTextures()
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage:SetTemplate("Overlay")
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CombatAllySpell:SetPoint("TOP", OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CombatAllyDescriptionLabel, "BOTTOM", 0, -5)
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CombatAllySpell.iconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CombatAllySpell:CreateBackdrop("Default")
	T.SkinCloseButton(OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CloseButton)
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.StartMissionButton:SkinButton()

	for i = 1, 2 do
		_G["OrderHallMissionFrameMissionsTab" .. i]:StripTextures()
		_G["OrderHallMissionFrameMissionsTab" .. i]:SkinButton()
		_G["OrderHallMissionFrameMissionsTab" .. i]:SetHeight(_G["OrderHallMissionFrameMissionsTab" .. i]:GetHeight() - 10)
	end

	OrderHallMissionFrameMissionsTab1:SetPoint("BOTTOMLEFT", OrderHallMissionFrameMissions, "TOPLEFT", 18, 0)

	for i = 1, #OrderHallMissionFrame.MissionTab.MissionList.listScroll.buttons do
		local button = OrderHallMissionFrame.MissionTab.MissionList.listScroll.buttons[i]
		if not button.backdrop then
			button:StripTextures()
			button:CreateBackdrop("Overlay")
			button.backdrop:SetPoint("TOPLEFT", 0, 0)
			button.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
			button:StyleButton(nil, 2)
		end
	end

	local Follower = OrderHallMissionFrameFollowers
	Follower:StripTextures()
	Follower:SetTemplate("Transparent")
	T.SkinEditBox(Follower.SearchBox)
	Follower.SearchBox:SetPoint("TOPLEFT", 2, 25)
	Follower.SearchBox:SetSize(301, 20)
	T.SkinScrollBar(OrderHallMissionFrameFollowersListScrollFrameScrollBar)
	Follower.MaterialFrame:StripTextures()
	T.SkinCloseButton(OrderHallMissionFrame.MissionTab.MissionPage.CloseButton)
	OrderHallMissionFrame.MissionTab.MissionPage.StartMissionButton:SkinButton()

	local FollowerList = OrderHallMissionFrame.FollowerTab
	FollowerList:StripTextures()
	FollowerList.ModelCluster:StripTextures()
	FollowerList.Class:SetSize(50, 43)
	FollowerList.XPBar:StripTextures()
	FollowerList.XPBar:SetStatusBarTexture(C["media"].texture)
	FollowerList.XPBar:CreateBackdrop()

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

	hooksecurefunc(OrderHallMissionFrame.FollowerList, "ShowFollower", onShowFollower)

	OrderHallMissionFrame.FollowerTab.AbilitiesFrame.CombatAllySpell1.iconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OrderHallMissionFrame.FollowerTab.AbilitiesFrame.CombatAllySpell1:CreateBackdrop("Default")

	local Mission = OrderHallMissionFrameMissions
	Mission.CompleteDialog:StripTextures()
	Mission.CompleteDialog:SetTemplate("Transparent")
	Mission.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	OrderHallMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	OrderHallTalentFrame:StripTextures()
	OrderHallTalentFrame:SetTemplate("Transparent")
	T.SkinCloseButton(OrderHallTalentFrameCloseButton)
	ClassHallTalentInset:StripTextures()
	OrderHallTalentFrame.Currency:SetFont(C["media"].normal_font, 16)
	OrderHallTalentFrame.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)

	hooksecurefunc(OrderHallCommandBar, "RefreshCategories", function(self)
		local index = 0
		C_Timer.After(0.5, function()
			for i, child in ipairs({self:GetChildren()}) do
				if child.Icon and child.Count and child.TroopPortraitCover then
					index = index + 1
					child.TroopPortraitCover:Hide()
					child.Icon:SetSize(38, 21)
				end
			end
			self:SetWidth(270 + index * 112)
		end)
	end)
end

T.SkinFuncs["Blizzard_OrderHallUI"] = LoadSkin