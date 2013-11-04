local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PvE skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"PVEFrame",
		"PVEFrameLeftInset",
		"LFDParentFrame",
		"LFDParentFrameInset",
		"RaidFinderFrame",
		"RaidFinderQueueFrame",
		"RaidFinderFrameBottomInset",
		"RaidFinderFrameRoleInset",
		"ScenarioFinderFrame",
		"LFGDungeonReadyDialog",
		"LFGDungeonReadyStatus",
		"LFDQueueFrameCooldownFrame",
		"RaidFinderQueueFrameCooldownFrame",
		"RaidFinderQueueFramePartyBackfill",
		"LFDQueueFramePartyBackfill",
		"FlexRaidFrameBottomInset"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local KillTextures = {
		"LFDQueueFrameBackground",
		"PVEFramePortrait",
		"ScenarioFinderFrameInset",
		"LFGDungeonReadyDialogBackground",
		"RaidFinderQueueFrameBackground",
		"LFGDungeonReadyDialogBottomArt",
		"LFGDungeonReadyDialogFiligree",
		"ScenarioQueueFrameRandomScrollFrameScrollBackground",
		"ScenarioQueueFrameRandomScrollFrameScrollBackgroundTopLeft",
		"ScenarioQueueFrameRandomScrollFrameScrollBackgroundBottomRight"
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local buttons = {
		"LFDQueueFrameFindGroupButton",
		"RaidFinderFrameFindRaidButton",
		"ScenarioQueueFrameFindGroupButton",
		"LFGDungeonReadyDialogLeaveQueueButton",
		"LFGDungeonReadyDialogEnterDungeonButton",
		"LFDQueueFramePartyBackfillBackfillButton",
		"LFDQueueFramePartyBackfillNoBackfillButton",
		"RaidFinderQueueFramePartyBackfillBackfillButton",
		"RaidFinderQueueFramePartyBackfillNoBackfillButton",
		"FlexRaidFrameStartRaidButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end

	local checkButtons = {
		"LFDQueueFrameRoleButtonTank",
		"LFDQueueFrameRoleButtonHealer",
		"LFDQueueFrameRoleButtonDPS",
		"LFDQueueFrameRoleButtonLeader",
		"RaidFinderQueueFrameRoleButtonTank",
		"RaidFinderQueueFrameRoleButtonHealer",
		"RaidFinderQueueFrameRoleButtonDPS",
		"RaidFinderQueueFrameRoleButtonLeader"
	}

	for _, object in pairs(checkButtons) do
		T.SkinCheckBox(_G[object].checkButton)
	end

	GroupFinderFrameGroupButton1.icon:SetTexture("Interface\\Icons\\INV_Helmet_08")
	GroupFinderFrameGroupButton2.icon:SetTexture("Interface\\Icons\\Icon_Scenarios")
	GroupFinderFrameGroupButton3.icon:SetTexture("Interface\\Icons\\inv_helmet_06")

	for i = 1, 4 do
		local button = GroupFinderFrame["groupButton"..i]

		button.ring:Hide()
		button:CreateBackdrop("Overlay")
		button.backdrop:SetAllPoints()
		button:StyleButton()

		button.bg:SetTexture("")

		button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.icon:SetPoint("LEFT", button, "LEFT", 10, 0)
		button.icon:SetDrawLayer("OVERLAY")
		button.icon:SetSize(40, 40)

		button.border = CreateFrame("Frame", nil, button)
		button.border:CreateBackdrop("Default")
		button.border.backdrop:SetPoint("TOPLEFT", button.icon, -2, 2)
		button.border.backdrop:SetPoint("BOTTOMRIGHT", button.icon, 2, -2)
	end

	hooksecurefunc("GroupFinderFrame_SelectGroupButton", function(index)
		local self = GroupFinderFrame
		for i = 1, 4 do
			local button = self["groupButton"..i]
			if i == index then
				button.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				button.backdrop.overlay:SetVertexColor(1, 0.82, 0, 0.3)
				button.border.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
			else
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				button.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end)

	hooksecurefunc("LFDQueueFrameRandom_UpdateFrame", function()
		local dungeonID = LFDQueueFrame.type
		if type(dungeonID) == "string" then return end

		for i = 1, LFD_MAX_REWARDS do
			local button = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i]
			local icon = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."IconTexture"]
			local count = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."Count"]
			local role1 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon1"]
			local role2 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon2"]
			local role3 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon3"]

			if button then
				local texture = _G[button:GetName().."IconTexture"]:GetTexture()
				button:StripTextures()

				icon:SetTexture(texture)
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:SetPoint("TOPLEFT", 2, -2)
				icon:SetDrawLayer("OVERLAY")

				count:SetDrawLayer("OVERLAY")

				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
					button.backdrop:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)

					icon:SetParent(button.backdrop)
					icon.SetPoint = T.dummy

					if count then
						count:SetParent(button.backdrop)
					end
					if role1 then
						role1:SetParent(button.backdrop)
					end
					if role2 then
						role2:SetParent(button.backdrop)
					end
					if role3 then
						role3:SetParent(button.backdrop)
					end
				end
			end
		end
	end)

	hooksecurefunc("RaidFinderQueueFrameRewards_UpdateFrame", function()
		for i = 1, LFD_MAX_REWARDS do
			local button = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i]
			local icon = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."IconTexture"]
			local count = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."Count"]
			local role1 = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."RoleIcon1"]
			local role2 = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."RoleIcon2"]
			local role3 = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."RoleIcon3"]

			if button then
				local texture = _G[button:GetName().."IconTexture"]:GetTexture()

				button:StripTextures()

				icon:SetTexture(texture)
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:SetPoint("TOPLEFT", 2, -2)
				icon:SetDrawLayer("OVERLAY")

				count:SetDrawLayer("OVERLAY")

				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
					button.backdrop:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)

					icon:SetParent(button.backdrop)
					icon.SetPoint = T.dummy

					if count then
						count:SetParent(button.backdrop)
					end
					if role1 then
						role1:SetParent(button.backdrop)
					end
					if role2 then
						role2:SetParent(button.backdrop)
					end
					if role3 then
						role3:SetParent(button.backdrop)
					end
				end
			end
		end
	end)

	hooksecurefunc("ScenarioQueueFrameRandom_UpdateFrame", function()
		for i = 1, LFD_MAX_REWARDS do
			local button = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i]
			local icon = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i.."IconTexture"]
			local count = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i.."Count"]

			if button then
				button:StripTextures()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:SetDrawLayer("OVERLAY")

				count:SetDrawLayer("OVERLAY")

				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
					button.backdrop:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)

					icon:SetParent(button.backdrop)

					if count then
						count:SetParent(button.backdrop)
					end
				end
			end
		end
	end)

	hooksecurefunc("LFGDungeonListButton_SetDungeon", function(button, dungeonID)
		T.SkinCheckBox(button.enableButton)
	end)

	for i = 1, 2 do
		T.SkinTab(_G["PVEFrameTab"..i])
	end

	PVEFrame:CreateBackdrop("Transparent")
	PVEFrame.backdrop:SetAllPoints()
	PVEFrame.shadows:Hide()
	ScenarioQueueFrame.Bg:Hide()

	LFDQueueFrameNoLFDWhileLFR:CreateBackdrop("Overlay")
	LFDQueueFrameNoLFDWhileLFR.backdrop:SetPoint("TOPLEFT", 2, 5)
	LFDQueueFrameNoLFDWhileLFR.backdrop:SetPoint("BOTTOMRIGHT", 0, 6)

	LFDQueueFrameCooldownFrame:CreateBackdrop("Overlay")
	LFDQueueFrameCooldownFrame.backdrop:SetPoint("TOPLEFT", 2, 4)
	LFDQueueFrameCooldownFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 6)

	LFDQueueFramePartyBackfill:CreateBackdrop("Overlay")
	LFDQueueFramePartyBackfill.backdrop:SetPoint("TOPLEFT", 2, 4)
	LFDQueueFramePartyBackfill.backdrop:SetPoint("BOTTOMRIGHT", 0, 6)

	RaidFinderQueueFrameCooldownFrame:CreateBackdrop("Overlay")
	RaidFinderQueueFrameCooldownFrame.backdrop:SetPoint("TOPLEFT", 2, 6)
	RaidFinderQueueFrameCooldownFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 8)

	RaidFinderQueueFramePartyBackfill:CreateBackdrop("Overlay")
	RaidFinderQueueFramePartyBackfill.backdrop:SetPoint("TOPLEFT", 2, 6)
	RaidFinderQueueFramePartyBackfill.backdrop:SetPoint("BOTTOMRIGHT", 0, 8)

	T.SkinDropDownBox(LFDQueueFrameTypeDropDown, 300)
	LFDQueueFrameTypeDropDown:SetPoint("RIGHT", -10, 0)

	T.SkinDropDownBox(RaidFinderQueueFrameSelectionDropDown, 300)
	RaidFinderQueueFrameSelectionDropDown:SetPoint("RIGHT", -10, 0)

	T.SkinDropDownBox(ScenarioQueueFrameTypeDropDown, 300)
	ScenarioQueueFrameSpecificScrollFrameScrollBackgroundTopLeft:Hide()
	ScenarioQueueFrameSpecificScrollFrameScrollBackgroundBottomRight:Hide()
	ScenarioQueueFrameRandomScrollFrameChildFrame.bonusRepFrame.ChooseButton:SkinButton()
	ScenarioQueueFrameTypeDropDown:SetPoint("RIGHT", -10, 0)

	T.SkinDropDownBox(FlexRaidFrameSelectionDropDown)
	FlexRaidFrameScrollFrameScrollBackground:Hide()
	FlexRaidFrameScrollFrameBackground:Hide()
	FlexRaidFrameScrollFrameBackgroundCover:Hide()
	FlexRaidFrameScrollFrameScrollBackgroundTopLeft:Hide()
	FlexRaidFrameScrollFrameScrollBackgroundBottomRight:Hide()

	T.SkinCloseButton(PVEFrameCloseButton)
	T.SkinCloseButton(LFGDungeonReadyStatusCloseButton, nil, "-")
	T.SkinCloseButton(LFGDungeonReadyDialogCloseButton, LFGDungeonReadyDialog, "-")

	T.SkinScrollBar(LFDQueueFrameSpecificListScrollFrameScrollBar)
	LFDQueueFrameSpecificListScrollFrameScrollBackgroundTopLeft:SetTexture(nil)
	LFDQueueFrameSpecificListScrollFrameScrollBackgroundBottomRight:SetTexture(nil)
	LFDQueueFrameRandomScrollFrameScrollBackground:SetTexture(nil)
	LFDQueueFrameRandomScrollFrameScrollBackgroundTopLeft:SetTexture(nil)
	LFDQueueFrameRandomScrollFrameScrollBackgroundBottomRight:SetTexture(nil)
	LFDQueueFrameRandomScrollFrameChildFrameBonusRepFrame.ChooseButton:SkinButton()
	RolePollPopup:SetTemplate("Transparent")
	LFGInvitePopup:SetTemplate("Transparent")
	LFGDungeonReadyPopup:SetTemplate("Transparent")
	LFGDungeonReadyDialog.SetBackdrop = T.dummy

	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonTank:GetChildren())
	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonHealer:GetChildren())
	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonDPS:GetChildren())
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)

local function LoadSecondarySkin()
	ChallengesFrameInset:StripTextures()
	ChallengesFrameInsetBg:Hide()
	ChallengesFrameDetails.bg:Hide()
	select(2, ChallengesFrameDetails:GetRegions()):Hide()
	select(9, ChallengesFrameDetails:GetRegions()):Hide()
	select(10, ChallengesFrameDetails:GetRegions()):Hide()
	select(11, ChallengesFrameDetails:GetRegions()):Hide()
	ChallengesFrameDungeonButton1:SetPoint("TOPLEFT", ChallengesFrame, "TOPLEFT", 8, -83)

	ChallengesFrameLeaderboard:SkinButton(true)

	for i = 1, 9 do
		local bu = ChallengesFrame["button"..i]
		bu:SkinButton()
		bu:StyleButton()
		bu:SetHighlightTexture("")
		bu.selectedTex:SetAlpha(0.2)
		bu.selectedTex:SetPoint("TOPLEFT", 1, -1)
		bu.selectedTex:SetPoint("BOTTOMRIGHT", -1, 1)
	end

	for i = 1, 3 do
		local rewardsRow = ChallengesFrame["RewardRow"..i]
		for j = 1, 2 do
			local bu = rewardsRow["Reward"..j]
			bu:CreateBackdrop("Default")
			bu.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end
end

T.SkinFuncs["Blizzard_ChallengesUI"] = LoadSecondarySkin
