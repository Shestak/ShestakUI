local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

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
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -1, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
		end

		-- Background
		frame.Background:SetTexture(nil)
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
		frame.Icon.Texture:SetPoint("LEFT", frame, 8, 0)

		-- Icon border
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

		if frame.glowFrame then
			frame.glowFrame:Kill()

			if frame.glowFrame.glow then
				frame.glowFrame.glow:Kill()
			end
		end

		if frame.shine then frame.shine:Kill() end
		if frame.raidArt then frame.raidArt:Kill() end
		if frame.heroicIcon then frame.heroicIcon:Kill() end
		if frame.dungeonArt then frame.dungeonArt:Kill() end
		if frame.dungeonArt1 then frame.dungeonArt1:Kill() end
		if frame.dungeonArt2 then frame.dungeonArt2:Kill() end
		if frame.dungeonArt3 then frame.dungeonArt3:Kill() end
		if frame.dungeonArt4 then frame.dungeonArt4:Kill() end

		-- Icon
		frame.dungeonTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.dungeonTexture:SetDrawLayer("OVERLAY")
		frame.dungeonTexture:ClearAllPoints()
		frame.dungeonTexture:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
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
		frame.EmblemBackground:SetPoint("LEFT", frame.backdrop, 9, 0)
		frame.EmblemIcon:SetPoint("CENTER", frame.EmblemBackground, 0, 0)
		frame.EmblemBackground:SetDrawLayer("ARTWORK", 1)
		frame.EmblemIcon:SetDrawLayer("ARTWORK", 2)

		-- Icon border
		if not frame.EmblemBackground.b then
			frame.EmblemBackground.b = CreateFrame("Frame", nil, frame)
			frame.EmblemBackground.b:SetTemplate("Default")
			frame.EmblemBackground.b:SetPoint("TOPLEFT", frame.EmblemBackground, "TOPLEFT", -2, 2)
			frame.EmblemBackground.b:SetPoint("BOTTOMRIGHT", frame.EmblemBackground, "BOTTOMRIGHT", 2, -2)
			frame.EmblemBackground:SetParent(frame.EmblemBackground.b)
			frame.EmblemIcon:SetParent(frame.EmblemBackground.b)
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
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -6)
			frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -22, 6)
		end

		-- Background
		frame.ToastBackground:Kill()
		frame.shine:Kill()

		-- Icon
		frame.QuestTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.QuestTexture:SetDrawLayer("ARTWORK")
		frame.QuestTexture:SetPoint("LEFT", frame.backdrop, 8, 0)

		-- Icon border
		if not frame.QuestTexture.b then
			frame.QuestTexture.b = CreateFrame("Frame", nil, frame)
			frame.QuestTexture.b:SetTemplate("Default")
			frame.QuestTexture.b:SetPoint("TOPLEFT", frame.QuestTexture, "TOPLEFT", -2, 2)
			frame.QuestTexture.b:SetPoint("BOTTOMRIGHT", frame.QuestTexture, "BOTTOMRIGHT", 2, -2)
			frame.QuestTexture:SetParent(frame.QuestTexture.b)
		end
	end
	hooksecurefunc(WorldQuestCompleteAlertSystem, "setUpFunction", SkinWorldQuestCompleteAlert)

	local function SkinGarrisonFollowerAlert(frame, _, _, _, quality)
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
		frame.PortraitFrame:SetPoint("LEFT", 12, -4)

		frame.PortraitFrame.PortraitRing:Hide()
		frame.PortraitFrame.PortraitRingQuality:SetTexture()
		frame.PortraitFrame.LevelBorder:SetAlpha(0)
		frame.PortraitFrame.Portrait:SetTexCoord(0.2, 0.85, 0.2, 0.85)

		local level = frame.PortraitFrame.Level
		level:ClearAllPoints()
		level:SetPoint("BOTTOM", frame.PortraitFrame, 0, 11)
		level:SetFontObject("SystemFont_Outline_Small")
		level:SetShadowOffset(0, 0)

		if not frame.squareBG then
			frame.squareBG = CreateFrame("Frame", nil, frame.PortraitFrame)
			frame.squareBG:SetFrameLevel(frame.PortraitFrame:GetFrameLevel()-1)
			frame.squareBG:SetPoint("TOPLEFT", 2, -2)
			frame.squareBG:SetPoint("BOTTOMRIGHT", -2, 10)
			frame.squareBG:SetTemplate("Default")
		end

		local cover = frame.PortraitFrame.PortraitRingCover
		if cover then
			cover:SetColorTexture(0, 0, 0)
			cover:SetAllPoints(frame.squareBG)
		end

		local color = ITEM_QUALITY_COLORS[quality]
		if color and quality > 1 then
			frame.Name:SetTextColor(color.r, color.g, color.b)
		end

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
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 21, -6)
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

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
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

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
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
		frame.MissionType:SetSize(45, 45)
		frame.MissionType:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.MissionType:SetDrawLayer("ARTWORK")
		frame.MissionType:ClearAllPoints()
		frame.MissionType:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
		if not frame.MissionType.b then
			frame.MissionType.b = CreateFrame("Frame", nil, frame)
			frame.MissionType.b:SetTemplate("Default")
			frame.MissionType.b:SetPoint("TOPLEFT", frame.MissionType, "TOPLEFT", -2, 2)
			frame.MissionType.b:SetPoint("BOTTOMRIGHT", frame.MissionType, "BOTTOMRIGHT", 2, -2)
			frame.MissionType:SetParent(frame.MissionType.b)
		end

		frame.EncounterIcon:SetSize(45, 45)
		frame.EncounterIcon:SetOutside(frame.MissionType.b)
		frame.EncounterIcon.CircleMask:Hide()
		frame.EncounterIcon.PortraitBorder:Hide()
		frame.EncounterIcon.RareOverlay:Hide()
		frame.EncounterIcon.EliteOverlay:Hide()
		frame.EncounterIcon.Portrait:SetTexCoord(0.2, 0.85, 0.2, 0.85)
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
		frame.MissionType:SetSize(45, 45)
		frame.MissionType:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.MissionType:SetDrawLayer("ARTWORK")
		frame.MissionType:ClearAllPoints()
		frame.MissionType:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
		if not frame.MissionType.b then
			frame.MissionType.b = CreateFrame("Frame", nil, frame)
			frame.MissionType.b:SetTemplate("Default")
			frame.MissionType.b:SetPoint("TOPLEFT", frame.MissionType, "TOPLEFT", -2, 2)
			frame.MissionType.b:SetPoint("BOTTOMRIGHT", frame.MissionType, "BOTTOMRIGHT", 2, -2)
			frame.MissionType:SetParent(frame.MissionType.b)
		end
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
		frame.MissionType:SetSize(45, 45)
		frame.MissionType:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.MissionType:SetDrawLayer("ARTWORK")
		frame.MissionType:ClearAllPoints()
		frame.MissionType:SetPoint("LEFT", frame.backdrop, 9, 0)

		-- Icon border
		if not frame.MissionType.b then
			frame.MissionType.b = CreateFrame("Frame", nil, frame)
			frame.MissionType.b:SetTemplate("Default")
			frame.MissionType.b:SetPoint("TOPLEFT", frame.MissionType, "TOPLEFT", -2, 2)
			frame.MissionType.b:SetPoint("BOTTOMRIGHT", frame.MissionType, "BOTTOMRIGHT", 2, -2)
			frame.MissionType:SetParent(frame.MissionType.b)
		end
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

		-- Icon border
		if not frame.Icon.b then
			frame.Icon.b = CreateFrame("Frame", nil, frame)
			frame.Icon.b:SetTemplate("Default")
			frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
			frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			frame.Icon:SetParent(frame.Icon.b)
		end
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
		frame.glow:Kill()
		frame.shine:Kill()
		frame.BGAtlas:Kill()
		frame.PvPBackground:Kill()
		frame.RatedPvPBackground:Kill()

		local lootItem = frame.lootItem
		lootItem.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		lootItem.Icon:SetDrawLayer("BORDER")
		lootItem.Icon:ClearAllPoints()
		lootItem.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)
		lootItem.IconBorder:Kill()
		lootItem.SpecRing:SetTexture("")

		-- Icon border
		if not lootItem.Icon.b then
			lootItem.Icon.b = CreateFrame("Frame", nil, frame)
			lootItem.Icon.b:SetTemplate("Default")
			lootItem.Icon.b:SetPoint("TOPLEFT", lootItem.Icon, "TOPLEFT", -2, 2)
			lootItem.Icon.b:SetPoint("BOTTOMRIGHT", lootItem.Icon, "BOTTOMRIGHT", 2, -2)
			lootItem.Icon:SetParent(lootItem.Icon.b)
		end
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
			frame.Icon.b:SetFrameLevel(1)
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
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -13, -6)
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

	local function SkinEntitlementDeliveredAlert(frame)
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
	hooksecurefunc(EntitlementDeliveredAlertSystem, "setUpFunction", SkinEntitlementDeliveredAlert)

	local function SkinRafRewardDeliveredAlert(frame)
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
		frame.StandardBackground:Kill()
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

	hooksecurefunc(RafRewardDeliveredAlertSystem, "setUpFunction", SkinRafRewardDeliveredAlert)

	local function SkinDigsiteCompleteAlert(frame)
		frame:SetAlpha(1)
		if not frame.hooked then
			hooksecurefunc(frame, "SetAlpha", forceAlpha)
			frame.hooked = true
		end

		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -17, -6)
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
	hooksecurefunc(NewRuneforgePowerAlertSystem, "setUpFunction", SkinNewPetMountAlert)

	hooksecurefunc("StandardRewardAlertFrame_AdjustRewardAnchors", function(frame)
		if frame.RewardFrames then
			for _, button in next, frame.RewardFrames do
				if not button.isSkinned then
					local icon, ring = button:GetRegions()
					icon:SetSize(18, 18)
					icon:SkinIcon(true)
					ring:Hide()
					button.isSkinned = true
				end
			end
		end
	end)

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
	frame.glow:Kill()
	frame.shine:Kill()

	local lootItem = frame.lootItem
	lootItem.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	lootItem.IconBorder:SetAlpha(0)
	-- Icon border
	lootItem.Icon.b = CreateFrame("Frame", nil, frame)
	lootItem.Icon.b:SetTemplate("Default")
	lootItem.Icon.b:SetFrameLevel(1)
	lootItem.Icon.b:SetPoint("TOPLEFT", lootItem.Icon, "TOPLEFT", -2, 2)
	lootItem.Icon.b:SetPoint("BOTTOMRIGHT", lootItem.Icon, "BOTTOMRIGHT", 2, -2)
	lootItem.Icon:SetParent(lootItem.Icon.b)
	-- Create Backdrop
	frame:CreateBackdrop("Transparent")
	frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -9, 6)
	frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, -6)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
