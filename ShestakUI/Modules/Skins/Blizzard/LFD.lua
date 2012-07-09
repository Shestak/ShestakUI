local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	LFD skin
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

		--[["LFDQueueFrameSpecific",
		"LFDQueueFrameRandom",
		"LFDQueueFrameRandomScrollFrame",
		"LFDQueueFrameCapBar",
		"LFDQueueFrameRandomScrollFrameScrollBar",
		"LFDQueueFrameNoLFDWhileLFR",
		"LFDQueueFrameSpecificListScrollFrame",
		"LFDQueueFrameCooldownFrame",
		"LFGDungeonReadyDialog",
		"LFGDungeonReadyStatus",
		"LFGInvitePopup"]]
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local KillTextures = {
		"LFDQueueFrameBackground",
		"PVEFramePortrait",
		"ScenarioFinderFrameInset",

		--"LFGDungeonReadyDialogBackground",
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local buttons = {
		"LFDQueueFrameFindGroupButton",
		"RaidFinderFrameFindRaidButton",
		"ScenarioQueueFrameFindGroupButton",
		
		--[[
		"LFDQueueFrameCancelButton",
		"LFDQueueFramePartyBackfillBackfillButton",
		"LFDQueueFramePartyBackfillNoBackfillButton",
		"LFDQueueFrameNoLFDWhileLFRLeaveQueueButton",
		"LFGDungeonReadyDialogEnterDungeonButton",
		"LFGDungeonReadyDialogLeaveQueueButton",
		"LFGInvitePopupAcceptButton",
		"LFGInvitePopupDeclineButton",]]
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
		_G[object].checkButton:SetFrameLevel(_G[object].checkButton:GetFrameLevel() + 2)
		T.SkinCheckBox(_G[object].checkButton)
	end

	GroupFinderFrameGroupButton1.icon:SetTexture("Interface\\Icons\\INV_Helmet_08")
	GroupFinderFrameGroupButton2.icon:SetTexture("Interface\\Icons\\inv_helmet_06")
	GroupFinderFrameGroupButton3.icon:SetTexture("Interface\\Icons\\Icon_Scenarios")

	for i = 1, 3 do
		local button = GroupFinderFrame["groupButton"..i]

		button.ring:Hide()
		button:CreateBackdrop("Overlay")
		button.backdrop:SetAllPoints()
		button:StyleButton()

		button.bg:SetTexture("")

		button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.icon:SetPoint("LEFT", button, "LEFT", 10, 0)
		button.icon:SetDrawLayer("OVERLAY")
		button.icon:Size(40)

		button.border = CreateFrame("Frame", nil, button)
		button.border:CreateBackdrop("Default")
		button.border.backdrop:Point("TOPLEFT", button.icon, -2, 2)
		button.border.backdrop:Point("BOTTOMRIGHT", button.icon, 2, -2)
	end

	hooksecurefunc("GroupFinderFrame_SelectGroupButton", function(index)
		local self = GroupFinderFrame
		for i = 1, 3 do
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
		local _, _, _, _, _, numRewards = GetLFGDungeonRewards(dungeonID)

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
				icon:Point("TOPLEFT", 2, -2)
				icon:SetDrawLayer("OVERLAY")
				count:SetDrawLayer("OVERLAY")

				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:Point("TOPLEFT", icon, "TOPLEFT", -2, 2)
					button.backdrop:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
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

	--[[hooksecurefunc("LFDQueueFrameSpecificListButton_SetDungeon", function(button, dungeonID, mode, submode)
		for _, object in pairs(checkButtons) do
			local button = _G[object]
			if not button.checkButton:GetChecked() then
				button.checkButton:SetDisabledTexture(nil)
			else
				button.checkButton:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
			end
		end
	end)]]

	for i = 1, NUM_LFD_CHOICE_BUTTONS do
		T.SkinCheckBox(_G["LFDQueueFrameSpecificListButton"..i.."EnableButton"])
	end

	for i = 1, 2 do
		T.SkinTab(_G["PVEFrameTab"..i])
	end

	PVEFrame:CreateBackdrop("Transparent")
	PVEFrame.backdrop:SetAllPoints()
	PVEFrame.shadows:Hide()
	ScenarioQueueFrame.Bg:Hide()

	LFDQueueFrameNoLFDWhileLFR:CreateBackdrop("Overlay")
	LFDQueueFrameNoLFDWhileLFR.backdrop:Point("TOPLEFT", 2, 5)
	LFDQueueFrameNoLFDWhileLFR.backdrop:Point("BOTTOMRIGHT", 0, 6)

	LFDQueueFrameCooldownFrame:CreateBackdrop("Overlay")
	LFDQueueFrameCooldownFrame.backdrop:Point("TOPLEFT", 2, 4)
	LFDQueueFrameCooldownFrame.backdrop:Point("BOTTOMRIGHT", 0, 6)

	LFDQueueFrameSpecific:Point("TOPLEFT", -5, 0)
	LFDQueueFrameSpecific:Point("BOTTOMRIGHT", 0, 10)

	T.SkinDropDownBox(LFDQueueFrameTypeDropDown, 300)
	LFDQueueFrameTypeDropDown:Point("RIGHT", -10, 0)

	T.SkinDropDownBox(RaidFinderQueueFrameSelectionDropDown, 300)
	RaidFinderQueueFrameSelectionDropDown:Point("RIGHT", -10, 0)

	T.SkinDropDownBox(ScenarioQueueFrameTypeDropDown, 300)
	ScenarioQueueFrameTypeDropDown:Point("RIGHT", -10, 0)

	T.SkinCloseButton(PVEFrameCloseButton)
	
	
	
	
	--[[T.SkinScrollBar(LFDQueueFrameSpecificListScrollFrameScrollBar)

	
	
	RolePollPopup:SetTemplate("Transparent")
	LFGInvitePopup:SetTemplate("Transparent")
	LFGDungeonReadyPopup:SetTemplate("Transparent")
	LFGDungeonReadyDialog.SetBackdrop = T.dummy
	LFGDungeonReadyDialog.filigree:SetAlpha(0)
	LFGDungeonReadyDialog.bottomArt:SetAlpha(0)
	T.SkinCloseButton(LFGDungeonReadyDialogCloseButton, LFGDungeonReadyDialog, "-")]]
	--LFDQueueFrameFindGroupButton:Point("BOTTOMLEFT", LFDParentFrame.backdrop, "BOTTOMLEFT", 4, 4)
	--LFDQueueFrameCancelButton:Point("BOTTOMRIGHT", LFDParentFrame.backdrop, "BOTTOMRIGHT", -6, 4)
	--LFDQueueFrameRandomScrollFrame:Height(LFDQueueFrameRandomScrollFrame:GetHeight() + 10)
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
			bu:CreateBackdrop()
			bu.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end
end

T.SkinFuncs["Blizzard_ChallengesUI"] = LoadSecondarySkin