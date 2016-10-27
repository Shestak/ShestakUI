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
		"LFDQueueFrame",
		"LFGListApplicationDialog"
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
		"ScenarioQueueFrameRandomScrollFrameScrollBackgroundBottomRight",
		"RaidFinderQueueFrameScrollFrameScrollBackground",
		"RaidFinderQueueFrameScrollFrameScrollBackgroundTopLeft",
		"RaidFinderQueueFrameScrollFrameScrollBackgroundBottomRight"
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
		"RaidFinderQueueFramePartyBackfillBackfillButton",
		"RaidFinderQueueFramePartyBackfillNoBackfillButton",
		"LFDQueueFramePartyBackfillBackfillButton",
		"LFDQueueFramePartyBackfillNoBackfillButton",
		"LFGInvitePopupAcceptButton",
		"LFGInvitePopupDeclineButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end

	LFGListApplicationDialog.SignUpButton:SkinButton()
	LFGListApplicationDialog.CancelButton:SkinButton()

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

	T.SkinCheckBox(LFGListApplicationDialog.TankButton.CheckButton)
	T.SkinCheckBox(LFGListApplicationDialog.HealerButton.CheckButton)
	T.SkinCheckBox(LFGListApplicationDialog.DamagerButton.CheckButton)

	local scrollbars = {
		"ScenarioQueueFrameSpecificScrollFrameScrollBar",
		"LFGListApplicationViewerScrollFrameScrollBar",
		"LFDQueueFrameSpecificListScrollFrameScrollBar",
		"LFDQueueFrameRandomScrollFrameScrollBar",
		"RaidFinderQueueFrameScrollFrameScrollBar"
	}

	for _, scrollbar in pairs(scrollbars) do
		T.SkinScrollBar(_G[scrollbar])
	end

	T.SkinScrollBar(LFGListFrame.SearchPanel.ScrollFrame.scrollBar)

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

	hooksecurefunc("LFGRewardsFrame_SetItemButton", function(parentFrame, _, index)
		local parentName = parentFrame:GetName()
		local item = _G[parentName.."Item"..index]

		if item and not item.isSkinned then
			item.border = CreateFrame("Frame", nil, item)
			item.border:CreateBackdrop("Default")
			item.border.backdrop:SetPoint("TOPLEFT", item.Icon, "TOPLEFT", -2, 2)
			item.border.backdrop:SetPoint("BOTTOMRIGHT", item.Icon, "BOTTOMRIGHT", 2, -2)

			item.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			item.Icon:SetDrawLayer("OVERLAY")
			item.Icon:SetParent(item.border)

			item.Count:SetDrawLayer("OVERLAY")
			item.Count:SetParent(item.border)

			item.NameFrame:Hide()

			item.shortageBorder:SetTexture(nil)

			item.roleIcon1:SetParent(item.border)
			item.roleIcon2:SetParent(item.border)

			item.isSkinned = true
		end
	end)

	local function SkinMoney(button)
		_G[button].border = CreateFrame("Frame", nil, _G[button])
		_G[button].border:CreateBackdrop("Default")
		_G[button].border.backdrop:SetPoint("TOPLEFT", _G[button.."IconTexture"], "TOPLEFT", -2, 2)
		_G[button].border.backdrop:SetPoint("BOTTOMRIGHT", _G[button.."IconTexture"], "BOTTOMRIGHT", 2, -2)

		_G[button.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G[button.."IconTexture"]:SetDrawLayer("OVERLAY")
		_G[button.."IconTexture"]:SetParent(_G[button].border)

		_G[button.."NameFrame"]:Hide()

		_G[button.."Count"]:SetDrawLayer("OVERLAY")
		_G[button.."Count"]:SetParent(_G[button].border)
	end
	SkinMoney("LFDQueueFrameRandomScrollFrameChildFrameMoneyReward")
	SkinMoney("RaidFinderQueueFrameScrollFrameChildFrameMoneyReward")
	SkinMoney("ScenarioQueueFrameRandomScrollFrameChildFrameMoneyReward")

	hooksecurefunc("LFGDungeonListButton_SetDungeon", function(button)
		T.SkinCheckBox(button.enableButton)
		button.enableButton:SetFrameLevel(button.enableButton:GetFrameLevel() - 2)
	end)

	for i = 1, 3 do
		T.SkinTab(_G["PVEFrameTab"..i])
	end

	LFGListApplicationDialog:SetTemplate("Transparent")
	PVEFrame:CreateBackdrop("Transparent")
	PVEFrame.backdrop:SetAllPoints()
	PVEFrame.shadows:Kill()
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

	LFGListFrame.CategorySelection.Inset.Bg:Hide()
	select(10, LFGListFrame.CategorySelection.Inset:GetRegions()):Hide()
	LFGListFrame.CategorySelection.Inset:DisableDrawLayer("BORDER")
	LFGListFrame.SearchPanel.ResultsInset.Bg:Hide()
	LFGListFrame.SearchPanel.ResultsInset:DisableDrawLayer("BORDER")

	LFGListFrame.NothingAvailable.Inset.Bg:Hide()
	select(10, LFGListFrame.NothingAvailable.Inset:GetRegions()):Hide()
	LFGListFrame.NothingAvailable.Inset:DisableDrawLayer("BORDER")

	LFGListFrame.CategorySelection.FindGroupButton:SkinButton()
	LFGListFrame.CategorySelection.StartGroupButton:SkinButton()
	LFGListFrame.SearchPanel.RefreshButton:SkinButton()
	LFGListFrame.SearchPanel.FilterButton:SkinButton()
	LFGListFrame.SearchPanel.BackButton:SkinButton()
	LFGListFrame.SearchPanel.SignUpButton:SkinButton()
	LFGListFrame.SearchPanel.ScrollFrame.StartGroupButton:SkinButton()

	LFGListFrame.SearchPanel.RefreshButton:SetSize(24, 24)
	LFGListFrame.SearchPanel.RefreshButton.Icon:SetPoint("CENTER")

	LFGListFrame.SearchPanel.FilterButton:SetPoint("LEFT", LFGListFrame.SearchPanel.SearchBox, "RIGHT", 5, 0)

	T.SkinEditBox(LFGListFrame.SearchPanel.SearchBox)

	T.SkinCloseButton(PVEFrameCloseButton)
	T.SkinCloseButton(LFGDungeonReadyStatusCloseButton, nil, "-")
	T.SkinCloseButton(LFGDungeonReadyDialogCloseButton, LFGDungeonReadyDialog, "-")

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

	LFGListFrame.CategorySelection.CategoryButtons[1]:SetNormalFontObject(GameFontNormal)
	hooksecurefunc("LFGListCategorySelection_AddButton", function(self, index)
		local button = self.CategoryButtons[index]
		if button and not button.styled then
			button.Cover:Hide()
			button:SetTemplate("Overlay")
			button:StyleButton()
			button.Icon:SetDrawLayer("ARTWORK")
			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.Icon:SetPoint("TOPLEFT", 2, -2)
			button.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
			button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.3)
			button.SelectedTexture:SetPoint("TOPLEFT", 2, -2)
			button.SelectedTexture:SetPoint("BOTTOMRIGHT", -2, 2)
			button.styled = true
		end
	end)

	LFGListFrame.EntryCreation:StripTextures()
	LFGListFrame.EntryCreation.Inset:StripTextures()
	--BETA LFGListFrame.EntryCreation.Description:StripTextures()
	--BETA LFGListApplicationDialogDescription:StripTextures()
	LFGListInviteDialog:SetTemplate("Transparent")
	LFGListInviteDialog.AcknowledgeButton:SkinButton()
	LFGListInviteDialog.AcceptButton:SkinButton()
	LFGListInviteDialog.DeclineButton:SkinButton()

	--BETA T.SkinEditBox(LFGListApplicationDialogDescription)
	T.SkinEditBox(LFGListFrame.EntryCreation.Name, nil, 17)
	T.SkinEditBox(LFGListFrame.EntryCreation.ItemLevel.EditBox, nil, 17)
	T.SkinEditBox(LFGListFrame.EntryCreation.VoiceChat.EditBox, nil, 17)
	--BETA T.SkinEditBox(LFGListFrame.EntryCreation.Description)
	T.SkinDropDownBox(LFGListFrame.EntryCreation.CategoryDropDown, 320)
	T.SkinDropDownBox(LFGListFrame.EntryCreation.GroupDropDown)
	T.SkinDropDownBox(LFGListFrame.EntryCreation.ActivityDropDown)
	T.SkinCheckBox(LFGListFrame.EntryCreation.VoiceChat.CheckButton)
	T.SkinCheckBox(LFGListFrame.EntryCreation.ItemLevel.CheckButton)
	LFGListFrame.EntryCreation.ListGroupButton:SkinButton()
	LFGListFrame.EntryCreation.CancelButton:SkinButton()

	-- ApplicationViewer (Custom Groups)
	LFGListFrame.ApplicationViewer.InfoBackground:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	T.SkinCheckBox(LFGListFrame.ApplicationViewer.AutoAcceptButton)
	LFGListFrame.ApplicationViewer.Inset:StripTextures()
	LFGListFrame.ApplicationViewer.Inset:SetTemplate("Transparent")
	LFGListFrame.ApplicationViewer.NameColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.RoleColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.NameColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.NameColumnHeader:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.Inset, "TOPLEFT", 0, 1)
	LFGListFrame.ApplicationViewer.RoleColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RoleColumnHeader:SetPoint("LEFT", LFGListFrame.ApplicationViewer.NameColumnHeader, "RIGHT", 1, 0)
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:SetPoint("LEFT", LFGListFrame.ApplicationViewer.RoleColumnHeader, "RIGHT", 1, 0)
	LFGListFrame.ApplicationViewer.RefreshButton:SkinButton()
	LFGListFrame.ApplicationViewer.RefreshButton:SetSize(24,24)
	LFGListFrame.ApplicationViewer.RefreshButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RefreshButton:SetPoint("BOTTOMRIGHT", LFGListFrame.ApplicationViewer.Inset, "TOPRIGHT", 16, 4)
	LFGListFrame.ApplicationViewer.RemoveEntryButton:SkinButton(true)
	LFGListFrame.ApplicationViewer.EditButton:SkinButton(true)
	LFGListFrame.ApplicationViewer.RemoveEntryButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RemoveEntryButton:SetPoint("BOTTOMLEFT", -1, 3)
	LFGListFrame.ApplicationViewer.EditButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.EditButton:SetPoint("BOTTOMRIGHT", -6, 3)
	LFGListApplicationViewerScrollFrameScrollBar:ClearAllPoints()
	LFGListApplicationViewerScrollFrameScrollBar:SetPoint("TOPLEFT", LFGListFrame.ApplicationViewer.Inset, "TOPRIGHT", 0, -14)
	LFGListApplicationViewerScrollFrameScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.Inset, "BOTTOMRIGHT", 0, 14)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)

local function LoadSecondarySkin()
	ChallengesFrameInset:StripTextures()
	ChallengesFrameInsetBg:Hide()
	--BETA ChallengesFrameDetails.bg:Hide()
	-- select(2, ChallengesFrameDetails:GetRegions()):Hide()
	-- select(9, ChallengesFrameDetails:GetRegions()):Hide()
	-- select(10, ChallengesFrameDetails:GetRegions()):Hide()
	-- select(11, ChallengesFrameDetails:GetRegions()):Hide()
	-- ChallengesFrameDungeonButton1:SetPoint("TOPLEFT", ChallengesFrame, "TOPLEFT", 8, -83)

	-- ChallengesFrameLeaderboard:SkinButton(true)

	-- for i = 1, 8 do
		-- local button = ChallengesFrame["button"..i]
		-- button:SetTemplate("Overlay")
		-- button:StyleButton()
		-- button.selectedTex:SetDrawLayer("ARTWORK")
		-- button.selectedTex:SetColorTexture(1, 0.82, 0, 0.3)
		-- button.selectedTex:SetPoint("TOPLEFT", 2, -2)
		-- button.selectedTex:SetPoint("BOTTOMRIGHT", -2, 2)
	-- end

	-- for i = 1, 3 do
		-- local rewardsRow = ChallengesFrame["RewardRow"..i]
		-- for j = 1, 2 do
			-- local button = rewardsRow["Reward"..j]
			-- button:CreateBackdrop("Default")
			-- button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		-- end
	-- end
end

T.SkinFuncs["Blizzard_ChallengesUI"] = LoadSecondarySkin