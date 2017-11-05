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

	-- MissionFrame
	OrderHallMissionFrame:StripTextures()
	OrderHallMissionFrame:SetTemplate("Transparent")
	OrderHallMissionFrame.GarrCorners:StripTextures()
	OrderHallMissionFrame.ClassHallIcon:Kill()
	T.SkinCloseButton(OrderHallMissionFrame.CloseButton)
	T.SkinCloseButton(OrderHallMissionTutorialFrame.GlowBox.CloseButton)

	for i = 1, 3 do
		T.SkinTab(_G["OrderHallMissionFrameTab" .. i])
	end

	OrderHallMissionFrameMissions.CompleteDialog.BorderFrame:StripTextures()
	OrderHallMissionFrameMissions.CompleteDialog.BorderFrame:SetTemplate("Overlay")
	OrderHallMissionFrameMissions.CompleteDialog.BorderFrame.Stage:StripTextures()

	OrderHallMissionFrame.MissionComplete:StripTextures()
	OrderHallMissionFrame.MissionComplete:CreateBackdrop("Overlay")
	OrderHallMissionFrame.MissionComplete.backdrop:SetPoint("TOPLEFT", 3, 2)
	OrderHallMissionFrame.MissionComplete.backdrop:SetPoint("BOTTOMRIGHT", -3, -12)

	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo:StripTextures()
	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo:CreateOverlay()
	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo.overlay:SetPoint("TOPLEFT", 5, 0)
	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo.overlay:SetPoint("BOTTOMRIGHT", -5, 210)
	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo.overlay:SetVertexColor(0, 0, 0, 0.7)

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
		_G["OrderHallMissionFrameMissionsTab" .. i]:StyleButton()
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

	-- Followers
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

	local FollowerTab = OrderHallMissionFrame.FollowerTab
	FollowerTab:StripTextures()
	FollowerTab.ModelCluster:StripTextures()
	FollowerTab.Class:SetSize(50, 43)
	FollowerTab.XPBar:StripTextures()
	FollowerTab.XPBar:SetStatusBarTexture(C["media"].texture)
	FollowerTab.XPBar:CreateBackdrop()

	local function onShowFollower(frame)
		local ft = frame:GetParent().FollowerTab

		-- Ability buttons
		local btn
		for i = 1, #ft.AbilitiesFrame.Abilities do
			btn = ft.AbilitiesFrame.Abilities[i]
			if not btn.IconButton.backdrop then
				btn.IconButton.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				btn.IconButton.Icon:SetDrawLayer("BACKGROUND", 1)
				btn.IconButton:CreateBackdrop("Default")
				btn.IconButton.Border:SetTexture(nil)
			end
		end

		-- CombatAllySpell buttons
		for i = 1, #ft.AbilitiesFrame.CombatAllySpell do
			btn = ft.AbilitiesFrame.CombatAllySpell[i]
			if not btn.backdrop then
				btn.iconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				btn:CreateBackdrop("Default")
			end
		end

		-- Equipment
		if ft.AbilitiesFrame.Equipment then
			for i = 1, #ft.AbilitiesFrame.Equipment do
				btn = ft.AbilitiesFrame.Equipment[i]
				btn.Border:SetTexture(nil)
				btn.BG:SetTexture(nil)
				btn.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				btn:SetScale(1)
				if not btn.backdrop then
					btn:CreateBackdrop("Default")
					btn.backdrop:SetPoint("TOPLEFT", btn.Icon, "TOPLEFT", -2, 2)
					btn.backdrop:SetPoint("BOTTOMRIGHT", btn.Icon, "BOTTOMRIGHT", 2, -2)
				end
			end
		end
		ft, btn = nil
	end

	hooksecurefunc(OrderHallMissionFrame.FollowerList, "ShowFollower", onShowFollower)

	-- Missions
	local Mission = OrderHallMissionFrameMissions
	Mission.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	OrderHallMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	-- TalentFrame
	OrderHallTalentFrame:StripTextures()
	OrderHallTalentFrame:SetTemplate("Transparent")
	T.SkinCloseButton(OrderHallTalentFrameCloseButton)
	ClassHallTalentInset:StripTextures()
	OrderHallTalentFrame.Currency:SetFont(C["media"].normal_font, 16)
	OrderHallTalentFrame.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)
end

T.SkinFuncs["Blizzard_OrderHallUI"] = LoadSkin