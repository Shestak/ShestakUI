local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AlertFrames skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local function forceAlpha(self, alpha, isForced)
		if alpha ~= 1 and isForced ~= true then
			self:SetAlpha(1, true)
		end
	end

	local function SkinAchievementAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame.Background, "TOPLEFT", -2, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame.Background, "BOTTOMRIGHT", -2, 6)
		end

		-- Background
		frame.Background:SetTexture(nil)
		frame.OldAchievement:Kill()
		frame.glow:Kill()
		frame.shine:Kill()
		frame.GuildBanner:Kill()
		frame.GuildBorder:Kill()

		-- Text
		frame.Unlocked:SetTextColor(1, 1, 1)
		frame.Name:SetTextColor(1, 0.8, 0)

		-- Icon
		frame.Icon.Texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon.Overlay:Kill()
		frame.Icon.Texture:ClearAllPoints()
		frame.Icon.Texture:SetPoint("LEFT", frame, 7, 0)

		if not frame.Icon.Texture.b then
			frame.Icon.Texture.b = CreateFrame("Frame", nil, frame)
			frame.Icon.Texture.b:SetTemplate("Default")
			frame.Icon.Texture.b:SetPoint("TOPLEFT", frame.Icon.Texture, "TOPLEFT", -2, 2)
			frame.Icon.Texture.b:SetPoint("BOTTOMRIGHT", frame.Icon.Texture, "BOTTOMRIGHT", 2, -2)
			frame.Icon.Texture:SetParent(frame.Icon.Texture.b)
		end
	end
	hooksecurefunc(AchievementAlertSystem, "setUpFunction", SkinAchievementAlert)

	local function SkinCriteriaAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -9, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, 6)
		end

		frame.Unlocked:SetTextColor(1, 1, 1)
		frame.Name:SetTextColor(1, 0.8, 0)
		frame.Background:Kill()
		frame.glow:Kill()
		frame.shine:Kill()
		frame.Icon.Bling:Kill()
		frame.Icon.Overlay:Kill()

		-- Icon
		frame.Icon.Texture:SetSize(27, 27)
		frame.Icon.Texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon.Texture:ClearAllPoints()
		frame.Icon.Texture:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
		if not frame.Icon.Texture.b then
			frame.Icon.Texture.b = CreateFrame("Frame", nil, frame)
			frame.Icon.Texture.b:SetTemplate("Default")
			frame.Icon.Texture.b:SetPoint("TOPLEFT", frame.Icon.Texture, "TOPLEFT", -2, 2)
			frame.Icon.Texture.b:SetPoint("BOTTOMRIGHT", frame.Icon.Texture, "BOTTOMRIGHT", 2, -2)
			frame.Icon.Texture:SetParent(frame.Icon.Texture.b)
		end
	end
	hooksecurefunc(CriteriaAlertSystem, "setUpFunction", SkinCriteriaAlert)

	local function SkinDungeonCompletionAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 31, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -35, 6)
		end

		frame.shine:Kill()
		frame.glowFrame:Kill()
		frame.glowFrame.glow:Kill()

		frame.raidArt:Kill()
		frame.dungeonArt1:Kill()
		frame.dungeonArt2:Kill()
		frame.dungeonArt3:Kill()
		frame.dungeonArt4:Kill()
		frame.heroicIcon:Kill()

		-- Icon
		frame.dungeonTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.dungeonTexture:SetDrawLayer("OVERLAY")
		frame.dungeonTexture:ClearAllPoints()
		frame.dungeonTexture:SetPoint("LEFT", frame.backdrop, 9, 0)

		if not frame.dungeonTexture.b then
			frame.dungeonTexture.b = CreateFrame("Frame", nil, frame)
			frame.dungeonTexture.b:SetTemplate("Default")
			frame.dungeonTexture.b:SetPoint("TOPLEFT", frame.dungeonTexture, "TOPLEFT", -2, 2)
			frame.dungeonTexture.b:SetPoint("BOTTOMRIGHT", frame.dungeonTexture, "BOTTOMRIGHT", 2, -2)
			frame.dungeonTexture:SetParent(frame.dungeonTexture.b)
		end
	end
	hooksecurefunc(DungeonCompletionAlertSystem, "setUpFunction", SkinDungeonCompletionAlert)

	local function SkinGuildChallengeAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -2, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
		end

		-- Background
		local region = select(2, frame:GetRegions())
		if region:GetObjectType() == "Texture" then
			if region:GetTexture() == "Interface\\GuildFrame\\GuildChallenges" then
				region:Kill()
			end
		end

		frame.glow:Kill()
		frame.shine:Kill()
		frame.EmblemBorder:Kill()

		-- Icon border
		frame.EmblemIcon:SetPoint("LEFT", frame.backdrop, 10, 0)
		frame.EmblemBackground:SetPoint("LEFT", frame.backdrop, 10, 0)
		if not frame.EmblemIcon.b then
			frame.EmblemIcon.b = CreateFrame("Frame", nil, frame)
			frame.EmblemIcon.b:SetTemplate("Default")
			frame.EmblemIcon.b:SetPoint("TOPLEFT", frame.EmblemIcon, "TOPLEFT", -3, 3)
			frame.EmblemIcon.b:SetPoint("BOTTOMRIGHT", frame.EmblemIcon, "BOTTOMRIGHT", 3, -2)
			frame.EmblemIcon:SetParent(frame.EmblemIcon.b)
		end
	end
	hooksecurefunc(GuildChallengeAlertSystem, "setUpFunction", SkinGuildChallengeAlert)

	local function SkinInvasionAlert(frame)
		if not frame.isSkinned then
			frame:SetAlpha(1)
			hooksecurefunc(frame, "SetAlpha", forceAlpha)

			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -7, 6)

			local region, icon = frame:GetRegions()
			if region and region:GetObjectType() == "Texture" then
				if region:GetAtlas() == "legioninvasion-Toast-Frame" then
					region:Kill()
				end
			end
			-- Icon border
			if icon and icon:GetObjectType() == "Texture" then
				if icon:GetTexture() == "Interface\\Icons\\Ability_Warlock_DemonicPower" then
					icon.b = CreateFrame("Frame", nil, frame)
					icon.b:SetTemplate("Default")
					icon.b:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
					icon.b:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
					icon:SetParent(icon.b)
					icon:SetDrawLayer("OVERLAY")
					icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					icon:ClearAllPoints()
					icon:SetPoint("LEFT", frame.backdrop, 9, 0)
				end
			end
			frame.isSkinned = true
		end
	end
	hooksecurefunc(InvasionAlertSystem, "setUpFunction", SkinInvasionAlert)

	local function SkinScenarioAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -7, 6)
		end

		-- Background
		for i = 1, frame:GetNumRegions() do
			local region = select(i, frame:GetRegions())
			if region:GetObjectType() == "Texture" then
				if region:GetAtlas() == "Toast-IconBG" or region:GetAtlas() == "Toast-Frame" then
					region:Kill()
				end
			end
		end

		frame.shine:Kill()
		frame.glowFrame:Kill()
		frame.glowFrame.glow:Kill()

		-- Icon
		frame.dungeonTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.dungeonTexture:ClearAllPoints()
		frame.dungeonTexture:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.dungeonTexture:SetDrawLayer("OVERLAY")

		-- Icon border
		if not frame.dungeonTexture.b then
			frame.dungeonTexture.b = CreateFrame("Frame", nil, frame)
			frame.dungeonTexture.b:SetTemplate("Default")
			frame.dungeonTexture.b:SetPoint("TOPLEFT", frame.dungeonTexture, "TOPLEFT", -2, 2)
			frame.dungeonTexture.b:SetPoint("BOTTOMRIGHT", frame.dungeonTexture, "BOTTOMRIGHT", 2, -2)
			frame.dungeonTexture:SetParent(frame.dungeonTexture.b)
		end
	end
	hooksecurefunc(ScenarioAlertSystem, "setUpFunction", SkinScenarioAlert)

	local function SkinWorldQuestCompleteAlert(frame)
		frame:SetAlpha(1)
		hooksecurefunc(frame, "SetAlpha", forceAlpha)

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -22, 6)
		end

		frame.shine:Kill()

		-- Background
		for i = 1, frame:GetNumRegions() do
			local region = select(i, frame:GetRegions())
			if region:GetObjectType() == "Texture" then
				if region:GetTexture() == "Interface\\LFGFrame\\UI-LFG-DUNGEONTOAST" then
					region:Kill()
				end
			end
		end

		-- Icon
		frame.QuestTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.QuestTexture:SetDrawLayer("ARTWORK")
		frame.QuestTexture:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.QuestTexture.b = CreateFrame("Frame", nil, frame)
		frame.QuestTexture.b:SetTemplate("Default")
		frame.QuestTexture.b:SetPoint("TOPLEFT", frame.QuestTexture, "TOPLEFT", -2, 2)
		frame.QuestTexture.b:SetPoint("BOTTOMRIGHT", frame.QuestTexture, "BOTTOMRIGHT", 2, -2)
		frame.QuestTexture:SetParent(frame.QuestTexture.b)
	end
	hooksecurefunc(WorldQuestCompleteAlertSystem, "setUpFunction", SkinWorldQuestCompleteAlert)

	local function SkinGarrisonFollowerAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)
		end

		frame.glow:Kill()
		frame.shine:Kill()
		frame.FollowerBG:SetAlpha(0)
		frame.DieIcon:SetAlpha(0)
		frame.PortraitFrame:ClearAllPoints()
		frame.PortraitFrame:SetPoint("LEFT", 15, 0)

		-- Background
		for i = 1, frame:GetNumRegions() do
			local region = select(i, frame:GetRegions())
			if region:GetObjectType() == "Texture" then
				if region:GetAtlas() == "Garr_MissionToast" then
					region:Kill()
				end
			end
		end
	end
	hooksecurefunc(GarrisonFollowerAlertSystem, "setUpFunction", SkinGarrisonFollowerAlert)

	local function SkinGarrisonShipFollowerAlert(frame)
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)
		end

		frame.glow:Kill()
		frame.shine:Kill()
		frame.FollowerBG:SetAlpha(0)
		frame.DieIcon:SetAlpha(0)
		frame.Background:Kill()
	end
	hooksecurefunc(GarrisonShipFollowerAlertSystem, "setUpFunction", SkinGarrisonShipFollowerAlert)

	local function SkinGarrisonTalentAlert(frame)
		-- Create Backdrop
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 22, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -25, 6)
		end

		frame:GetRegions():Hide()
		frame.glow:Kill()
		frame.shine:Kill()

		-- Icon
		frame.Icon:SetSize(50, 50)
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetDrawLayer("ARTWORK")
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.Icon.b = CreateFrame("Frame", nil, frame)
		frame.Icon.b:SetTemplate("Default")
		frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
		frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
		frame.Icon:SetParent(frame.Icon.b)
	end
	hooksecurefunc(GarrisonTalentAlertSystem, "setUpFunction", SkinGarrisonTalentAlert)

	local function SkinGarrisonBuildingAlert(frame)
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)
		end

		frame.glow:Kill()
		frame.shine:Kill()
		frame:GetRegions():Hide()

		-- Icon
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetDrawLayer("ARTWORK")
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.Icon.b = CreateFrame("Frame", nil, frame)
		frame.Icon.b:SetTemplate("Default")
		frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
		frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
		frame.Icon:SetParent(frame.Icon.b)
	end
	hooksecurefunc(GarrisonBuildingAlertSystem, "setUpFunction", SkinGarrisonBuildingAlert)

	local function SkinGarrisonMissionAlert(frame)
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)
		end

		frame.glow:Kill()
		frame.shine:Kill()
		frame.IconBG:Hide()
		frame.Background:Kill()

		-- Icon
		frame.MissionType:SetSize(50, 50)
		frame.MissionType:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.MissionType:SetDrawLayer("ARTWORK")
		frame.MissionType:ClearAllPoints()
		frame.MissionType:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.MissionType.b = CreateFrame("Frame", nil, frame)
		frame.MissionType.b:SetTemplate("Default")
		frame.MissionType.b:SetPoint("TOPLEFT", frame.MissionType, "TOPLEFT", -2, 2)
		frame.MissionType.b:SetPoint("BOTTOMRIGHT", frame.MissionType, "BOTTOMRIGHT", 2, -2)
		frame.MissionType:SetParent(frame.MissionType.b)
	end
	hooksecurefunc(GarrisonMissionAlertSystem, "setUpFunction", SkinGarrisonMissionAlert)

	local function SkinGarrisonShipMissionAlert(frame)
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)
		end

		frame.Background:Kill()
		frame.glow:Kill()
		frame.shine:Kill()

		-- Icon
		frame.MissionType:SetSize(50, 50)
		frame.MissionType:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.MissionType:SetDrawLayer("ARTWORK")
		frame.MissionType:ClearAllPoints()
		frame.MissionType:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.MissionType.b = CreateFrame("Frame", nil, frame)
		frame.MissionType.b:SetTemplate("Default")
		frame.MissionType.b:SetPoint("TOPLEFT", frame.MissionType, "TOPLEFT", -2, 2)
		frame.MissionType.b:SetPoint("BOTTOMRIGHT", frame.MissionType, "BOTTOMRIGHT", 2, -2)
		frame.MissionType:SetParent(frame.MissionType.b)
	end
	hooksecurefunc(GarrisonShipMissionAlertSystem, "setUpFunction", SkinGarrisonShipMissionAlert)

	local function SkinGarrisonRandomMissionAlert(frame)
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)
		end

		frame.Background:Kill()
		frame.Blank:Kill()
		frame.IconBG:Kill()
		frame.glow:Kill()
		frame.shine:Kill()

		-- Icon
		frame.MissionType:SetSize(50, 50)
		frame.MissionType:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.MissionType:SetDrawLayer("ARTWORK")
		frame.MissionType:ClearAllPoints()
		frame.MissionType:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.MissionType.b = CreateFrame("Frame", nil, frame)
		frame.MissionType.b:SetTemplate("Default")
		frame.MissionType.b:SetPoint("TOPLEFT", frame.MissionType, "TOPLEFT", -2, 2)
		frame.MissionType.b:SetPoint("BOTTOMRIGHT", frame.MissionType, "BOTTOMRIGHT", 2, -2)
		frame.MissionType:SetParent(frame.MissionType.b)
	end
	hooksecurefunc(GarrisonRandomMissionAlertSystem, "setUpFunction", SkinGarrisonRandomMissionAlert)

	local function SkinLegendaryItemAlert(frame)
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 14, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -18, 6)
		end

		frame.Background:Kill()
		frame.Background2:Kill()
		frame.Background3:Kill()
		frame.Ring1:Kill()
		frame.Particles3:Kill()
		frame.Particles2:Kill()
		frame.Particles1:Kill()
		frame.Starglow:Kill()
		frame.glow:Kill()
		frame.shine:Kill()

		-- Icon
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetDrawLayer("ARTWORK")
		frame.Icon:ClearAllPoints()
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.Icon.b = CreateFrame("Frame", nil, frame)
		frame.Icon.b:SetTemplate("Default")
		frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
		frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
		frame.Icon:SetParent(frame.Icon.b)
	end
	hooksecurefunc(LegendaryItemAlertSystem, "setUpFunction", SkinLegendaryItemAlert)

	local function SkinLootWonAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 6)
		end

		frame.Background:Kill()
		frame.IconBorder:Kill()
		frame.glow:Kill()
		frame.shine:Kill()
		frame.BGAtlas:Kill()
		frame.PvPBackground:Kill()

		frame.SpecRing:SetTexture("")
		frame.SpecIcon:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -15)
		frame.SpecIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		-- frame.SpecIcon:SetTexture("Interface\\Icons\\spell_nature_brilliance")

		-- Icon
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetDrawLayer("BORDER")
		frame.Icon:ClearAllPoints()
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end

		if not frame.SpecIcon.b then
			frame.SpecIcon.b = CreateFrame("Frame", nil, frame)
			frame.SpecIcon.b:SetFrameLevel(3)
			frame.SpecIcon.b:SetTemplate("Default")
			frame.SpecIcon.b:SetPoint("TOPLEFT", frame.SpecIcon, "TOPLEFT", -2, 2)
			frame.SpecIcon.b:SetPoint("BOTTOMRIGHT", frame.SpecIcon, "BOTTOMRIGHT", 2, -2)
			frame.SpecIcon:SetParent(frame.SpecIcon.b)
		end
		frame.SpecIcon.b:SetShown(frame.SpecIcon:IsShown() and frame.SpecIcon:GetTexture() ~= nil)
	end
	hooksecurefunc(LootAlertSystem, "setUpFunction", SkinLootWonAlert)

	local function SkinLootUpgradeAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 6)
		end

		frame.Background:Kill()
		frame.BaseQualityBorder:Kill()
		frame.UpgradeQualityBorder:Kill()
		frame.BorderGlow:Kill()
		frame.Sheen:Kill()

		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetDrawLayer("BORDER", 5)
		frame.Icon:ClearAllPoints()
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
	end
	hooksecurefunc(LootUpgradeAlertSystem, "setUpFunction", SkinLootUpgradeAlert)

	local function SkinMoneyWonAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -12, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 9, 6)
		end

		frame.Background:Kill()
		frame.IconBorder:Kill()
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)

		frame.Label:ClearAllPoints()
		frame.Label:SetPoint("CENTER", frame.backdrop, 0, 10)

		frame.Amount:ClearAllPoints()
		frame.Amount:SetPoint("CENTER", frame.backdrop, 0, -10)

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
	end
	hooksecurefunc(MoneyWonAlertSystem, "setUpFunction", SkinMoneyWonAlert)

	local function SkinHonorAwardedAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -12, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 9, 6)
		end

		frame.Background:Kill()
		frame.IconBorder:Kill()
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)

		frame.Label:ClearAllPoints()
		frame.Label:SetPoint("CENTER", frame.backdrop, 0, 10)

		frame.Amount:ClearAllPoints()
		frame.Amount:SetPoint("CENTER", frame.backdrop, 0, -10)

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
	end
	hooksecurefunc(HonorAwardedAlertSystem, "setUpFunction", SkinHonorAwardedAlert)

	local function SkinStorePurchaseAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -14, 6)
		end

		-- Background
		frame.Background:Kill()
		frame.glow:Kill()
		frame.shine:Kill()

		-- Icon
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:ClearAllPoints()
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
	end
	hooksecurefunc(StorePurchaseAlertSystem, "setUpFunction", SkinStorePurchaseAlert)

	local function SkinDigsiteCompleteAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -16, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 13, 6)
		end

		frame.glow:Kill()
		frame.shine:Kill()
		frame:GetRegions():Hide()
		frame.DigsiteTypeTexture:SetPoint("LEFT", -10, -14)
	end

	hooksecurefunc(DigsiteCompleteAlertSystem, "setUpFunction", SkinDigsiteCompleteAlert)

	local function SkinNewRecipeLearnedAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -23, 6)
		end

		frame.glow:Kill()
		frame.shine:Kill()
		frame:GetRegions():Hide()

		frame.Icon:SetMask("")
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetDrawLayer("BORDER", 5)
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.Icon:SetSize(50, 50)

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
	end
	hooksecurefunc(NewRecipeLearnedAlertSystem, "setUpFunction", SkinNewRecipeLearnedAlert)

	local function SkinNewPetMountAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 6)
		end

		frame.Background:Kill()
		frame.IconBorder:Kill()
		frame.glow:Kill()
		frame.shine:Kill()

		frame.Icon:SetMask("")
		frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.Icon:SetDrawLayer("BORDER", 5)
		frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
	end
	hooksecurefunc(NewPetAlertSystem, "setUpFunction", SkinNewPetMountAlert)
	hooksecurefunc(NewMountAlertSystem, "setUpFunction", SkinNewPetMountAlert)
	hooksecurefunc(NewToyAlertSystem, "setUpFunction", SkinNewPetMountAlert)

	-- Bonus Roll Money
	local frame = BonusRollMoneyWonFrame
	frame:SetAlpha(1)
	hooksecurefunc(frame, "SetAlpha", forceAlpha)
	frame.Background:Kill()
	frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	frame.IconBorder:Kill()
	-- Icon border
	frame.Icon.b = CreateFrame("Frame", nil, frame)
	frame.Icon.b:SetTemplate("Default")
	frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
	frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
	frame.Icon:SetParent(frame.Icon.b)
	-- Create Backdrop
	frame:CreateBackdrop("Transparent")
	frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -9, 6)
	frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, -6)

	-- Bonus Roll Loot
	frame = BonusRollLootWonFrame
	frame:SetAlpha(1)
	hooksecurefunc(frame, "SetAlpha", forceAlpha)
	frame.Background:Kill()
	frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	frame.IconBorder:Kill()
	frame.glow:Kill()
	frame.shine:Kill()
	-- Icon border
	frame.Icon.b = CreateFrame("Frame", nil, frame)
	frame.Icon.b:SetTemplate("Default")
	frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
	frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
	frame.Icon:SetParent(frame.Icon.b)
	-- Create Backdrop
	frame:CreateBackdrop("Transparent")
	frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -9, 6)
	frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, -6)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
