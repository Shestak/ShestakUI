local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AlertFrames skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local function FixBg(f)
		if f:GetObjectType() == "AnimationGroup" then
			f = f:GetParent()
		end
		f.backdrop:SetBackdropColor(unpack(C.media.overlay_color))
	end

	local function SkinAchievePopUp()
		for i = 1, MAX_ACHIEVEMENT_ALERTS do
			local frame = _G["AchievementAlertFrame"..i]

			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Transparent")
					frame:SetFrameLevel(3)
					frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -2, -6)
					frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)

					frame:HookScript("OnEnter", FixBg)
					frame:HookScript("OnShow", FixBg)
					frame.animIn:HookScript("OnFinished", FixBg)
				end

				-- Background
				_G["AchievementAlertFrame"..i.."Background"]:SetTexture(nil)
				_G["AchievementAlertFrame"..i.."Glow"]:Kill()
				_G["AchievementAlertFrame"..i.."Shine"]:Kill()
				_G["AchievementAlertFrame"..i.."OldAchievement"]:Kill()
				_G["AchievementAlertFrame"..i.."GuildBanner"]:Kill()
				_G["AchievementAlertFrame"..i.."GuildBorder"]:Kill()

				-- Text
				_G["AchievementAlertFrame"..i.."Name"]:SetTextColor(1, 0.8, 0)
				_G["AchievementAlertFrame"..i.."Name"]:SetFont(C.media.normal_font, 11)
				_G["AchievementAlertFrame"..i.."Unlocked"]:SetTextColor(1, 1, 1)
				_G["AchievementAlertFrame"..i.."Unlocked"]:SetFont(C.media.normal_font, 11)

				-- Icon
				_G["AchievementAlertFrame"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["AchievementAlertFrame"..i.."IconOverlay"]:Kill()
				_G["AchievementAlertFrame"..i.."IconTexture"]:ClearAllPoints()
				_G["AchievementAlertFrame"..i.."IconTexture"]:SetPoint("LEFT", frame, 7, 0)

				-- Icon border
				if not _G["AchievementAlertFrame"..i.."IconTexture"].b then
					_G["AchievementAlertFrame"..i.."IconTexture"].b = CreateFrame("Frame", nil, frame)
					_G["AchievementAlertFrame"..i.."IconTexture"].b:SetFrameLevel(2)
					_G["AchievementAlertFrame"..i.."IconTexture"].b:SetTemplate("Default")
					_G["AchievementAlertFrame"..i.."IconTexture"].b:SetPoint("TOPLEFT", _G["AchievementAlertFrame"..i.."IconTexture"], "TOPLEFT", -2, 2)
					_G["AchievementAlertFrame"..i.."IconTexture"].b:SetPoint("BOTTOMRIGHT", _G["AchievementAlertFrame"..i.."IconTexture"], "BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetAchievementAnchors", SkinAchievePopUp)

	local function SkinDungeonPopUp()
		for i = 1, DUNGEON_COMPLETION_MAX_REWARDS do
			local frame = _G["DungeonCompletionAlertFrame"..i]

			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Transparent")
					frame:SetFrameLevel(3)
					frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 31, -6)
					frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -35, 6)

					frame:HookScript("OnEnter", FixBg)
					frame:HookScript("OnShow", FixBg)
					frame.animIn:HookScript("OnFinished", FixBg)
				end

				-- Background
				for i = 1, frame:GetNumRegions() do
					local region = select(i, frame:GetRegions())
					if region:GetObjectType() == "Texture" then
						if region:GetTexture() == "Interface\\LFGFrame\\UI-LFG-DUNGEONTOAST" or region:GetTexture() == "Interface\\LFGFrame\\LFR-Texture" then
							region:Kill()
						end
					end
				end

				_G["DungeonCompletionAlertFrame"..i.."Shine"]:Kill()
				_G["DungeonCompletionAlertFrame"..i.."GlowFrame"]:Kill()
				_G["DungeonCompletionAlertFrame"..i.."GlowFrame"].glow:Kill()
				_G["DungeonCompletionAlertFrame"..i].raidArt:Kill()

				-- Icon
				_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:ClearAllPoints()
				_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:SetPoint("LEFT", frame.backdrop, 9, 0)

				-- Icon border
				if not _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b then
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b = CreateFrame("Frame", nil, frame)
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetFrameLevel(2)
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetTemplate("Default")
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetPoint("TOPLEFT", _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"], "TOPLEFT", -2, 2)
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetPoint("BOTTOMRIGHT", _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"], "BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetDungeonCompletionAnchors", SkinDungeonPopUp)

	local function SkinGuildChallengePopUp()
		local frame = _G["GuildChallengeAlertFrame"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame:SetFrameLevel(3)
				frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -2, -6)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)

				frame:HookScript("OnEnter", FixBg)
				frame:HookScript("OnShow", FixBg)
				frame.animIn:HookScript("OnFinished", FixBg)
			end

			-- Background
			local region = select(2, frame:GetRegions())
			if region:GetObjectType() == "Texture" then
				if region:GetTexture() == "Interface\\GuildFrame\\GuildChallenges" then
					region:Kill()
				end
			end

			_G["GuildChallengeAlertFrameGlow"]:Kill()
			_G["GuildChallengeAlertFrameShine"]:Kill()
			_G["GuildChallengeAlertFrameEmblemBorder"]:Kill()

			-- Icon border
			if not _G["GuildChallengeAlertFrameEmblemIcon"].b then
				_G["GuildChallengeAlertFrameEmblemIcon"].b = CreateFrame("Frame", nil, frame)
				_G["GuildChallengeAlertFrameEmblemIcon"].b:SetFrameLevel(2)
				_G["GuildChallengeAlertFrameEmblemIcon"].b:SetTemplate("Default")
				_G["GuildChallengeAlertFrameEmblemIcon"].b:SetPoint("TOPLEFT", _G["GuildChallengeAlertFrameEmblemIcon"], "TOPLEFT", -3, 3)
				_G["GuildChallengeAlertFrameEmblemIcon"].b:SetPoint("BOTTOMRIGHT", _G["GuildChallengeAlertFrameEmblemIcon"], "BOTTOMRIGHT", 3, -2)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetGuildChallengeAnchors", SkinGuildChallengePopUp)

	local function SkinChallengePopUp()
		local frame = _G["ChallengeModeAlertFrame1"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame:SetFrameLevel(3)
				frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -6)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -7, 6)

				frame:HookScript("OnEnter", FixBg)
				frame:HookScript("OnShow", FixBg)
				frame.animIn:HookScript("OnFinished", FixBg)
			end

			-- Background
			frame:GetRegions():Hide()

			_G["ChallengeModeAlertFrame1Shine"]:Kill()
			_G["ChallengeModeAlertFrame1GlowFrame"]:Kill()
			_G["ChallengeModeAlertFrame1GlowFrame"].glow:Kill()
			_G["ChallengeModeAlertFrame1Border"]:Kill()

			-- Icon
			_G["ChallengeModeAlertFrame1DungeonTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["ChallengeModeAlertFrame1DungeonTexture"]:ClearAllPoints()
			_G["ChallengeModeAlertFrame1DungeonTexture"]:SetPoint("LEFT", frame.backdrop, 9, 0)

			-- Icon border
			if not _G["ChallengeModeAlertFrame1DungeonTexture"].b then
				_G["ChallengeModeAlertFrame1DungeonTexture"].b = CreateFrame("Frame", nil, frame)
				_G["ChallengeModeAlertFrame1DungeonTexture"].b:SetFrameLevel(2)
				_G["ChallengeModeAlertFrame1DungeonTexture"].b:SetTemplate("Default")
				_G["ChallengeModeAlertFrame1DungeonTexture"].b:SetPoint("TOPLEFT", _G["ChallengeModeAlertFrame1DungeonTexture"], "TOPLEFT", -2, 2)
				_G["ChallengeModeAlertFrame1DungeonTexture"].b:SetPoint("BOTTOMRIGHT", _G["ChallengeModeAlertFrame1DungeonTexture"], "BOTTOMRIGHT", 2, -2)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetChallengeModeAnchors", SkinChallengePopUp)

	local function SkinScenarioPopUp()
		local frame = _G["ScenarioAlertFrame1"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame:SetFrameLevel(3)
				frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -6)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -7, 6)

				frame:HookScript("OnEnter", FixBg)
				frame:HookScript("OnShow", FixBg)
				frame.animIn:HookScript("OnFinished", FixBg)
			end

			-- Background
			frame:GetRegions():Hide()
			select(3, frame:GetRegions()):Hide()

			_G["ScenarioAlertFrame1Shine"]:Kill()
			_G["ScenarioAlertFrame1GlowFrame"]:Kill()
			_G["ScenarioAlertFrame1GlowFrame"].glow:Kill()

			-- Icon
			_G["ScenarioAlertFrame1DungeonTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["ScenarioAlertFrame1DungeonTexture"]:ClearAllPoints()
			_G["ScenarioAlertFrame1DungeonTexture"]:SetPoint("LEFT", frame.backdrop, 9, 0)

			-- Icon border
			if not _G["ScenarioAlertFrame1DungeonTexture"].b then
				_G["ScenarioAlertFrame1DungeonTexture"].b = CreateFrame("Frame", nil, frame)
				_G["ScenarioAlertFrame1DungeonTexture"].b:SetFrameLevel(2)
				_G["ScenarioAlertFrame1DungeonTexture"].b:SetTemplate("Default")
				_G["ScenarioAlertFrame1DungeonTexture"].b:SetPoint("TOPLEFT", _G["ScenarioAlertFrame1DungeonTexture"], "TOPLEFT", -2, 2)
				_G["ScenarioAlertFrame1DungeonTexture"].b:SetPoint("BOTTOMRIGHT", _G["ScenarioAlertFrame1DungeonTexture"], "BOTTOMRIGHT", 2, -2)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetScenarioAnchors", SkinScenarioPopUp)

	local function SkinCriteriaPopUp()
		for i = 1, MAX_ACHIEVEMENT_ALERTS do
			local frame = _G["CriteriaAlertFrame"..i]

			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Transparent")
					frame:SetFrameLevel(3)
					frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -9, -6)
					frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, 6)

					frame:HookScript("OnEnter", FixBg)
					frame:HookScript("OnShow", FixBg)
					frame.animIn:HookScript("OnFinished", FixBg)
				end

				-- Background
				_G["CriteriaAlertFrame"..i.."Background"]:Kill()
				_G["CriteriaAlertFrame"..i.."Glow"]:Kill()
				_G["CriteriaAlertFrame"..i.."Shine"]:Kill()
				_G["CriteriaAlertFrame"..i.."IconBling"]:Kill()
				_G["CriteriaAlertFrame"..i.."IconOverlay"]:Kill()

				-- Text
				_G["CriteriaAlertFrame"..i.."Unlocked"]:SetTextColor(1, 1, 1)
				_G["CriteriaAlertFrame"..i.."Name"]:SetTextColor(1, 1, 0)

				-- Icon
				_G["CriteriaAlertFrame"..i.."IconTexture"]:SetSize(28, 28)
				_G["CriteriaAlertFrame"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["CriteriaAlertFrame"..i.."IconTexture"]:ClearAllPoints()
				_G["CriteriaAlertFrame"..i.."IconTexture"]:SetPoint("LEFT", frame.backdrop, 9, 0)

				-- Icon border
				if not _G["CriteriaAlertFrame"..i.."IconTexture"].b then
					_G["CriteriaAlertFrame"..i.."IconTexture"].b = CreateFrame("Frame", nil, frame)
					_G["CriteriaAlertFrame"..i.."IconTexture"].b:SetFrameLevel(2)
					_G["CriteriaAlertFrame"..i.."IconTexture"].b:SetTemplate("Default")
					_G["CriteriaAlertFrame"..i.."IconTexture"].b:SetPoint("TOPLEFT", _G["CriteriaAlertFrame"..i.."IconTexture"], "TOPLEFT", -2, 2)
					_G["CriteriaAlertFrame"..i.."IconTexture"].b:SetPoint("BOTTOMRIGHT", _G["CriteriaAlertFrame"..i.."IconTexture"], "BOTTOMRIGHT", 2, -2)
					_G["CriteriaAlertFrame"..i.."IconTexture"]:SetParent(_G["CriteriaAlertFrame"..i.."IconTexture"].b)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetCriteriaAnchors", SkinCriteriaPopUp)

	local function SkinLootWonPopUp()
		for i = 1, #LOOT_WON_ALERT_FRAMES do
			local frame = LOOT_WON_ALERT_FRAMES[i]
			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Transparent")
					frame:SetFrameLevel(3)
					frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -6)
					frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 6)

					frame:HookScript("OnEnter", FixBg)
					frame:HookScript("OnShow", FixBg)
					frame.animIn:HookScript("OnFinished", FixBg)
				end

				-- Background
				frame.Background:Kill()
				frame.BGAtlas:Kill()
				frame.PvPBackground:Kill()
				frame.IconBorder:Kill()
				frame.glow:Kill()
				frame.shine:Kill()
				frame.SpecRing:SetTexture("")
				frame.SpecIcon:SetPoint("TOPLEFT", 10, -12)
				frame.SpecIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				-- Icon
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				frame.Icon:ClearAllPoints()
				frame.Icon:SetPoint("LEFT", frame.backdrop, 9, 0)
				frame.Icon:SetDrawLayer("BACKGROUND", -1)

				-- Icon border
				if not frame.Icon.b then
					frame.Icon.b = CreateFrame("Frame", nil, frame)
					frame.Icon.b:SetFrameLevel(2)
					frame.Icon.b:SetTemplate("Default")
					frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
					frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
				end

				if not frame.SpecIcon.b then
					frame.SpecIcon.b = CreateFrame("Frame", nil, frame)
					frame.SpecIcon.b:SetFrameLevel(3)
					frame.SpecIcon.b:SetTemplate("Default")
					frame.SpecIcon.b:SetPoint("TOPLEFT", frame.SpecIcon, "TOPLEFT", -2, 2)
					frame.SpecIcon.b:SetPoint("BOTTOMRIGHT", frame.SpecIcon, "BOTTOMRIGHT", 2, -2)
				end
				frame.SpecIcon.b:SetShown(frame.SpecIcon:IsShown() and frame.SpecIcon:GetTexture() ~= nil)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetLootWonAnchors", SkinLootWonPopUp)

	local function SkinMoneyWonPopUp()
		for i = 1, #MONEY_WON_ALERT_FRAMES do
			local frame = MONEY_WON_ALERT_FRAMES[i]
			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Transparent")
					frame:SetFrameLevel(3)
					frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -12, -6)
					frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 9, 6)

					frame:HookScript("OnEnter", FixBg)
					frame:HookScript("OnShow", FixBg)
					frame.animIn:HookScript("OnFinished", FixBg)
				end

				-- Background
				frame.Background:Kill()
				frame.IconBorder:Kill()

				-- Icon
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				-- Icon border
				if not frame.Icon.b then
					frame.Icon.b = CreateFrame("Frame", nil, frame)
					frame.Icon.b:SetFrameLevel(2)
					frame.Icon.b:SetTemplate("Default")
					frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
					frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetMoneyWonAnchors", SkinMoneyWonPopUp)

	local function DigsiteCompleteToastPopUp()
		local frame = _G["DigsiteCompleteToastFrame"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame:SetFrameLevel(3)
				frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -6)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -7, 6)

				frame:HookScript("OnEnter", FixBg)
				frame:HookScript("OnShow", FixBg)
				frame.animIn:HookScript("OnFinished", FixBg)
			end

			-- Background
			frame:GetRegions():Hide()

			_G["DigsiteCompleteToastFrameGlow"]:Kill()
			_G["DigsiteCompleteToastFrameShine"]:Kill()
		end
	end
	hooksecurefunc("AlertFrame_SetDigsiteCompleteToastFrameAnchors", DigsiteCompleteToastPopUp)

	local function SkinStorePurchasePopUp()
		local frame = _G["StorePurchaseAlertFrame"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame:SetFrameLevel(3)
				frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -5, -6)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 1, 6)

				frame:HookScript("OnEnter", FixBg)
				frame:HookScript("OnShow", FixBg)
				frame.animIn:HookScript("OnFinished", FixBg)
			end

			-- Background
			frame.Background:Kill()
			frame.glow:Kill()
			frame.shine:Kill()

			-- Icon
			frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			-- Icon border
			if not frame.Icon.b then
				frame.Icon.b = CreateFrame("Frame", nil, frame)
				frame.Icon.b:SetFrameLevel(2)
				frame.Icon.b:SetTemplate("Default")
				frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
				frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetStorePurchaseAnchors", SkinStorePurchasePopUp)

	local function SkinLootUpgradePopUp()
		for i = 1, #LOOT_UPGRADE_ALERT_FRAMES do
			local frame = LOOT_UPGRADE_ALERT_FRAMES[i]
			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Transparent")
					frame:SetFrameLevel(3)
					frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -6)
					frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 6)

					frame:HookScript("OnEnter", FixBg)
					frame:HookScript("OnShow", FixBg)
					frame.animIn:HookScript("OnFinished", FixBg)
				end

				-- Background
				frame.Background:Kill()
				frame.BaseQualityBorder:Kill()
				frame.UpgradeQualityBorder:Kill()
				frame.BorderGlow:Kill()
				frame.Sheen:Kill()
				for i = 1, frame.numArrows do
					frame["Arrow"..i]:Kill()
				end

				-- Icon
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				-- Icon border
				if not frame.Icon.b then
					frame.Icon.b = CreateFrame("Frame", nil, frame)
					frame.Icon.b:SetFrameLevel(2)
					frame.Icon.b:SetTemplate("Default")
					frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
					frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetLootUpgradeFrameAnchors", SkinLootUpgradePopUp)

	local function SkinGarrisonBuildingPopUp()
		local frame = _G["GarrisonBuildingAlertFrame"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame:SetFrameLevel(3)
				frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)

				frame:HookScript("OnEnter", FixBg)
				frame:HookScript("OnShow", FixBg)
				frame.animIn:HookScript("OnFinished", FixBg)
			end

			-- Background
			frame:GetRegions():Hide()
			frame.glow:Kill()
			frame.shine:Kill()

			-- Icon
			frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			frame.Icon:SetPoint("LEFT", 20, 0)

			-- Icon border
			if not frame.Icon.b then
				frame.Icon.b = CreateFrame("Frame", nil, frame)
				frame.Icon.b:SetFrameLevel(2)
				frame.Icon.b:SetTemplate("Default")
				frame.Icon.b:SetPoint("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
				frame.Icon.b:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetGarrisonBuildingAlertFrameAnchors", SkinGarrisonBuildingPopUp)

	local function SkinGarrisonMissionPopUp()
		local frame = _G["GarrisonMissionAlertFrame"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame:SetFrameLevel(3)
				frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)

				frame:HookScript("OnEnter", FixBg)
				frame:HookScript("OnShow", FixBg)
				frame.animIn:HookScript("OnFinished", FixBg)
			end

			-- Background
			frame.glow:Kill()
			frame.shine:Kill()
			frame.IconBG:Hide()
			frame.Background:Kill()
		end
	end
	hooksecurefunc("AlertFrame_SetGarrisonMissionAlertFrameAnchors", SkinGarrisonMissionPopUp)

	local function SkinGarrisonFollowerPopUp()
		local frame = _G["GarrisonFollowerAlertFrame"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame:SetFrameLevel(3)
				frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -6)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 6)

				frame:HookScript("OnEnter", FixBg)
				frame:HookScript("OnShow", FixBg)
				frame.animIn:HookScript("OnFinished", FixBg)
			end

			-- Background
			frame:StripTextures()
			frame.FollowerBG:SetAlpha(0)
			frame.glow:Kill()
			frame.shine:Kill()
			frame.PortraitFrame:SetPoint("LEFT", 23, 0)
		end
	end
	hooksecurefunc("AlertFrame_SetGarrisonFollowerAlertFrameAnchors", SkinGarrisonFollowerPopUp)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)