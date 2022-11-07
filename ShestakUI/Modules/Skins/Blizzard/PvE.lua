local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PvE skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		PVEFrame,
		PVEFrameLeftInset,
		LFDParentFrame,
		LFDParentFrameInset,
		RaidFinderFrame,
		RaidFinderQueueFrame,
		RaidFinderFrameBottomInset,
		RaidFinderFrameRoleInset,
		LFGDungeonReadyDialog,
		LFGDungeonReadyStatus,
		LFDQueueFrameCooldownFrame,
		RaidFinderQueueFrameCooldownFrame,
		RaidFinderQueueFramePartyBackfill,
		LFDQueueFramePartyBackfill,
		LFDQueueFrame,
		LFGListApplicationDialog
	}

	for i = 1, #StripAllTextures do
		StripAllTextures[i]:StripTextures()
	end

	local KillTextures = {
		LFDQueueFrameBackground,
		PVEFramePortrait,
		LFGDungeonReadyDialogBackground,
		RaidFinderQueueFrameBackground,
		LFGDungeonReadyDialogBottomArt,
		LFGDungeonReadyDialogFiligree,
		RaidFinderQueueFrameScrollFrameScrollBackground,
		RaidFinderQueueFrameScrollFrameScrollBackgroundTopLeft,
		RaidFinderQueueFrameScrollFrameScrollBackgroundBottomRight,
		PVEFrame.shadows,
		LFGListFrame.EntryCreation.ActivityFinder.Background
	}

	for i = 1, #KillTextures do
		KillTextures[i]:Kill()
	end

	local buttons = {
		LFDQueueFrameFindGroupButton,
		RaidFinderFrameFindRaidButton,
		LFGDungeonReadyDialogLeaveQueueButton,
		LFGDungeonReadyDialogEnterDungeonButton,
		RaidFinderQueueFramePartyBackfillBackfillButton,
		RaidFinderQueueFramePartyBackfillNoBackfillButton,
		LFDQueueFramePartyBackfillBackfillButton,
		LFDQueueFramePartyBackfillNoBackfillButton,
		LFGInvitePopupAcceptButton,
		LFGInvitePopupDeclineButton,
		LFGListApplicationDialog.SignUpButton,
		LFGListApplicationDialog.CancelButton
	}

	for i = 1, #buttons do
		buttons[i]:SkinButton()
	end

	local checkButtons = {
		LFDQueueFrameRoleButtonTank,
		LFDQueueFrameRoleButtonHealer,
		LFDQueueFrameRoleButtonDPS,
		LFDQueueFrameRoleButtonLeader,
		RaidFinderQueueFrameRoleButtonTank,
		RaidFinderQueueFrameRoleButtonHealer,
		RaidFinderQueueFrameRoleButtonDPS,
		RaidFinderQueueFrameRoleButtonLeader,
		LFGListApplicationDialog.TankButton,
		LFGListApplicationDialog.HealerButton,
		LFGListApplicationDialog.DamagerButton,
		LFGInvitePopupRoleButtonTank,
		LFGInvitePopupRoleButtonHealer,
		LFGInvitePopupRoleButtonDPS,
		RolePollPopupRoleButtonTank,
		RolePollPopupRoleButtonHealer,
		RolePollPopupRoleButtonDPS
	}

	for _, roleButton in pairs(checkButtons) do
		T.SkinCheckBox(roleButton.checkButton or roleButton.CheckButton)
	end

	hooksecurefunc("SetCheckButtonIsRadio", function(button)
		T.SkinCheckBox(button)
	end)

	local scrollbars = {
		LFGListApplicationViewerScrollFrameScrollBar,
		LFDQueueFrameSpecificListScrollFrameScrollBar,
		LFDQueueFrameRandomScrollFrameScrollBar,
		RaidFinderQueueFrameScrollFrameScrollBar,
		LFGListEntryCreationSearchScrollFrameScrollBar,
	}

	for i = 1, #scrollbars do
		T.SkinScrollBar(scrollbars[i])
	end
	
	-- Set texture to hide circle
	_G.GroupFinderFrame.groupButton1.icon:SetTexture("Interface\\Icons\\INV_Helmet_08")
	_G.GroupFinderFrame.groupButton2.icon:SetTexture("Interface\\LFGFrame\\UI-LFR-PORTRAIT")
	_G.GroupFinderFrame.groupButton3.icon:SetTexture("Interface\\Icons\\Achievement_General_StayClassy")

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
		button.icon:SetSize(40, 40)

		button.border = CreateFrame("Frame", nil, button)
		button.border:CreateBackdrop("Default")
		button.border.backdrop:SetPoint("TOPLEFT", button.icon, -2, 2)
		button.border.backdrop:SetPoint("BOTTOMRIGHT", button.icon, 2, -2)
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

			hooksecurefunc(item.IconBorder, "SetVertexColor", function(self, r, g, b)
				if r ~= 0.65882 and g ~= 0.65882 and b ~= 0.65882 then
					self:GetParent().border.backdrop:SetBackdropBorderColor(r, g, b)
				end
				self:SetTexture("")
			end)

			hooksecurefunc(item.IconBorder, "Hide", function(self)
				self:GetParent().border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end)

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

	hooksecurefunc("LFGDungeonListButton_SetDungeon", function(button)
		if not button.expandOrCollapseButton.isSkinned then
			T.SkinCheckBox(button.enableButton)
			button.enableButton:SetFrameLevel(button.enableButton:GetFrameLevel() - 2)
			button.enableButton.SetCheckedTexture = T.dummy -- Blizzard changes checked texture, prevent it
			T.SkinExpandOrCollapse(button.expandOrCollapseButton)
			button.expandOrCollapseButton.isSkinned = true
		end
	end)

	for i = 1, 3 do
		T.SkinTab(_G["PVEFrameTab"..i])
	end

	LFGListApplicationDialog:SetTemplate("Transparent")
	PVEFrame:CreateBackdrop("Transparent")
	PVEFrame.backdrop:SetAllPoints()

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
	LFDQueueFrameTypeDropDownBackdrop:SetFrameStrata("LOW") --// FIXME - Both text and dropdownbutton is behind backdrop
	LFDQueueFrameTypeDropDown:SetPoint("RIGHT", -10, 0)

	T.SkinDropDownBox(RaidFinderQueueFrameSelectionDropDown, 300)
	RaidFinderQueueFrameSelectionDropDown:SetPoint("RIGHT", -10, 0)

	LFGListFrame.SearchPanel.ResultsInset:StripTextures()
	LFGListFrame.NothingAvailable:StripTextures()
	LFGListFrame.CategorySelection:StripTextures()

	LFGListFrame.CategorySelection.FindGroupButton:SkinButton()
	LFGListFrame.CategorySelection.StartGroupButton:SkinButton()
	LFGListFrame.SearchPanel.BackButton:SkinButton()
	LFGListFrame.SearchPanel.SignUpButton:SkinButton()
	LFGListFrame.SearchPanel.ScrollBox.StartGroupButton:SkinButton()
	LFGListFrame.SearchPanel.RefreshButton:SkinButton()
	LFGListFrame.SearchPanel.RefreshButton:SetSize(24, 24)
	LFGListFrame.SearchPanel.RefreshButton.Icon:SetPoint("CENTER")
	LFGListFrame.SearchPanel.FilterButton:SkinButton()
	LFGListFrame.SearchPanel.FilterButton:SetPoint("LEFT", LFGListFrame.SearchPanel.SearchBox, "RIGHT", 5, 0)
	T.SkinScrollBar(LFGListFrame.SearchPanel.ScrollBar)

	hooksecurefunc("LFGListApplicationViewer_UpdateApplicant", function(button)
		if not button.DeclineButton.isSkinned then
			button.DeclineButton:SkinButton()
			button.DeclineButton.isSkinned = true
		end
		if not button.InviteButtonSmall.isSkinned then
			button.InviteButtonSmall:SkinButton()
			button.InviteButtonSmall.isSkinned = true
		end
	end)

	hooksecurefunc("LFGListSearchEntry_Update", function(button)
		if button and not button.isSkinned then
			button.CancelButton:SkinButton()
			button.isSkinned = true
		end
	end)

	hooksecurefunc("LFGListSearchPanel_UpdateAutoComplete", function(self)
		for i = 1, LFGListFrame.SearchPanel.AutoCompleteFrame:GetNumChildren() do
			local child = select(i, LFGListFrame.SearchPanel.AutoCompleteFrame:GetChildren())
			if child and not child.isSkinned and child:GetObjectType() == "Button" then
				child:SkinButton()
				child.isSkinned = true
			end
		end

		local text = self.SearchBox:GetText()
		local matchingActivities = C_LFGList.GetAvailableActivities(self.categoryID, nil, self.filters, text)
		local numResults = math.min(#matchingActivities, MAX_LFG_LIST_SEARCH_AUTOCOMPLETE_ENTRIES)

		for i = 2, numResults do
			local button = self.AutoCompleteFrame.Results[i]
			if button and not button.moved then
				button:SetPoint("TOPLEFT", self.AutoCompleteFrame.Results[i-1], "BOTTOMLEFT", 0, -2)
				button:SetPoint("TOPRIGHT", self.AutoCompleteFrame.Results[i-1], "BOTTOMRIGHT", 0, -2)
				button.moved = true
			end
		end
		self.AutoCompleteFrame:SetHeight(numResults * (self.AutoCompleteFrame.Results[1]:GetHeight() + 3.5) + 8)
	end)

	LFGListFrame.SearchPanel.AutoCompleteFrame:StripTextures()
	LFGListFrame.SearchPanel.AutoCompleteFrame:CreateBackdrop("Transparent")
	LFGListFrame.SearchPanel.AutoCompleteFrame.backdrop:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.AutoCompleteFrame, "TOPLEFT", 0, 3)
	LFGListFrame.SearchPanel.AutoCompleteFrame.backdrop:SetPoint("BOTTOMRIGHT", LFGListFrame.SearchPanel.AutoCompleteFrame, "BOTTOMRIGHT", 6, 3)

	LFGListFrame.SearchPanel.AutoCompleteFrame:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.SearchBox, "BOTTOMLEFT", -2, -8)
	LFGListFrame.SearchPanel.AutoCompleteFrame:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel.SearchBox, "BOTTOMRIGHT", -4, -8)

	T.SkinEditBox(LFGListFrame.SearchPanel.SearchBox)

	T.SkinCloseButton(PVEFrameCloseButton)
	T.SkinCloseButton(LFGDungeonReadyStatusCloseButton, nil, "-")
	T.SkinCloseButton(LFGDungeonReadyDialogCloseButton, LFGDungeonReadyDialog, "-")

	LFDQueueFrameRandomScrollFrameScrollBackground:SetTexture(nil)
	LFDQueueFrameRandomScrollFrameScrollBackgroundTopLeft:SetTexture(nil)
	LFDQueueFrameRandomScrollFrameScrollBackgroundBottomRight:SetTexture(nil)

	LFGInvitePopup:StripTextures()
	LFGInvitePopup:SetTemplate("Transparent")
	LFGDungeonReadyPopup:SetTemplate("Transparent")
	LFGDungeonReadyDialog.SetBackdrop = T.dummy
	LFGDungeonReadyDialog.Border:Hide()
	LFGDungeonReadyStatus.Border:Hide()

	hooksecurefunc("LFGDungeonReadyDialog_UpdateRewards", function()
		for i = 1, LFD_MAX_REWARDS do
			local reward = LFGDungeonReadyDialogRewardsFrame.Rewards[i]
			if not reward.isSkinned then
				reward.texture:SetSize(18, 18)
				reward.texture:SkinIcon(true)
				reward:DisableDrawLayer("OVERLAY")
				reward.isSkinned = true
			end
		end
	end)

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

			button.Label:SetFontObject(_G.GameFontNormal)
			button.styled = true
		end
	end)

	LFGListFrame.EntryCreation:StripTextures()
	LFGListFrame.EntryCreation.Description:StripTextures()
	LFGListApplicationDialogDescription:StripTextures()
	LFGListInviteDialog:StripTextures()
	LFGListInviteDialog:SetTemplate("Transparent")
	LFGListInviteDialog.AcknowledgeButton:SkinButton()
	LFGListInviteDialog.AcceptButton:SkinButton()
	LFGListInviteDialog.DeclineButton:SkinButton()

	T.SkinEditBox(LFGListApplicationDialogDescription)
	T.SkinEditBox(LFGListFrame.EntryCreation.Name, nil, 17)
	T.SkinEditBox(LFGListFrame.EntryCreation.ItemLevel.EditBox, nil, 17)
	T.SkinEditBox(LFGListFrame.EntryCreation.VoiceChat.EditBox, nil, 17)
	T.SkinEditBox(LFGListFrame.EntryCreation.Description)
	T.SkinDropDownBox(LFGListFrame.EntryCreation.GroupDropDown)
	T.SkinDropDownBox(LFGListFrame.EntryCreation.ActivityDropDown)
	T.SkinCheckBox(LFGListFrame.EntryCreation.VoiceChat.CheckButton)
	T.SkinCheckBox(LFGListFrame.EntryCreation.ItemLevel.CheckButton)
	T.SkinCheckBox(LFGListFrame.EntryCreation.PrivateGroup.CheckButton)
	T.SkinCheckBox(LFGListFrame.EntryCreation.CrossFactionGroup.CheckButton)
	LFGListFrame.EntryCreation.ListGroupButton:SkinButton()
	LFGListFrame.EntryCreation.CancelButton:SkinButton()

	T.SkinDropDownBox(LFGListEntryCreationPlayStyleDropdown)
	T.SkinCheckBox(LFGListFrame.EntryCreation.MythicPlusRating.CheckButton)
	T.SkinEditBox(LFGListFrame.EntryCreation.MythicPlusRating.EditBox, nil, 17)

	T.SkinCheckBox(LFGListFrame.EntryCreation.PvpItemLevel.CheckButton)
	T.SkinEditBox(LFGListFrame.EntryCreation.PvpItemLevel.EditBox, nil, 17)

	T.SkinCheckBox(LFGListFrame.EntryCreation.PVPRating.CheckButton)
	T.SkinEditBox(LFGListFrame.EntryCreation.PVPRating.EditBox, nil, 17)

	LFGListFrame.EntryCreation.ActivityFinder.Dialog:StripTextures()
	LFGListFrame.EntryCreation.ActivityFinder.Dialog:SetTemplate("Transparent")
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.BorderFrame:StripTextures()
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.BorderFrame:SetTemplate("Transparent")
	T.SkinEditBox(LFGListFrame.EntryCreation.ActivityFinder.Dialog.EntryBox, 276, 17)
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.SelectButton:SkinButton()
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.CancelButton:SkinButton()

	-- ApplicationViewer (Custom Groups)
	T.SkinCheckBox(LFGListFrame.ApplicationViewer.AutoAcceptButton)
	LFGListFrame.ApplicationViewer.Inset:StripTextures()
	LFGListFrame.ApplicationViewer.Inset:SetTemplate("Transparent")

	LFGListFrame.ApplicationViewer.NameColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.NameColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.NameColumnHeader:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.Inset, "TOPLEFT", 0, 1)
	LFGListFrame.ApplicationViewer.NameColumnHeader.Label:SetFont(C.media.normal_font, 10, "")

	LFGListFrame.ApplicationViewer.RoleColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.RoleColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RoleColumnHeader:SetPoint("LEFT", LFGListFrame.ApplicationViewer.NameColumnHeader, "RIGHT", 1, 0)
	LFGListFrame.ApplicationViewer.RoleColumnHeader.Label:SetFont(C.media.normal_font, 10, "")

	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:SetPoint("LEFT", LFGListFrame.ApplicationViewer.RoleColumnHeader, "RIGHT", 1, 0)
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader.Label:SetFont(C.media.normal_font, 10, "")

	LFGListFrame.ApplicationViewer.RatingColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.RatingColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RatingColumnHeader:SetPoint("LEFT", LFGListFrame.ApplicationViewer.ItemLevelColumnHeader, "RIGHT", 1, 0)
	LFGListFrame.ApplicationViewer.RatingColumnHeader.Label:SetFont(C.media.normal_font, 10, "")

	LFGListFrame.ApplicationViewer.RefreshButton:SkinButton()
	LFGListFrame.ApplicationViewer.RefreshButton:SetSize(24,24)
	LFGListFrame.ApplicationViewer.RefreshButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RefreshButton:SetPoint("BOTTOMRIGHT", LFGListFrame.ApplicationViewer.Inset, "TOPRIGHT", 16, 4)

	LFGListFrame.ApplicationViewer.RemoveEntryButton:SkinButton(true)
	LFGListFrame.ApplicationViewer.RemoveEntryButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RemoveEntryButton:SetPoint("BOTTOMLEFT", -1, 2)
	LFGListFrame.ApplicationViewer.RemoveEntryButton:SetWidth(80)

	LFGListFrame.ApplicationViewer.EditButton:SkinButton(true)
	LFGListFrame.ApplicationViewer.EditButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.EditButton:SetPoint("BOTTOMRIGHT", -6, 2)
	LFGListFrame.ApplicationViewer.EditButton:SetWidth(80)
	
	LFGListFrame.ApplicationViewer.BrowseGroupsButton:SkinButton(true)
	
	LFGListFrame.ApplicationViewer.ScrollBar:ClearAllPoints()
	LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.ApplicationViewer.Inset, "TOPRIGHT", 0, -14)
	LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.Inset, "BOTTOMRIGHT", 0, 14)
	T.SkinScrollBar(LFGListFrame.ApplicationViewer.ScrollBar)
	
	LFGListFrame.ApplicationViewer.InfoBackground:SkinIcon()
	LFGListFrame.ApplicationViewer.InfoBackground:SetPoint("TOPLEFT", 1, -27)
	LFGListFrame.ApplicationViewer.InfoBackground:SetSize(324, 90)

	if IsAddOnLoaded("PremadeGroupsFilter") then
		T.SkinCheckBox(UsePFGButton)
		PremadeGroupsFilterDialog:StripTextures()
		PremadeGroupsFilterDialog:CreateBackdrop("Transparent")
		PremadeGroupsFilterDialog.backdrop:SetPoint("TOPLEFT", 3, 0)
		PremadeGroupsFilterDialog.backdrop:SetPoint("BOTTOMRIGHT", 0, -1)
		PremadeGroupsFilterDialog.ResetButton:SkinButton()
		PremadeGroupsFilterDialog.RefreshButton:SkinButton()
		T.SkinCloseButton(PremadeGroupsFilterDialog.CloseButton)

		T.SkinCloseButton(PremadeGroupsFilterDialog.MaxMinButtonFrame.MinimizeButton, nil, "-")
		PremadeGroupsFilterDialog.MaxMinButtonFrame.MinimizeButton:SetHitRectInsets(0, 0, 0, 0)
		PremadeGroupsFilterDialog.MaxMinButtonFrame.MinimizeButton:ClearAllPoints()
		PremadeGroupsFilterDialog.MaxMinButtonFrame.MinimizeButton:SetPoint("TOPRIGHT", PremadeGroupsFilterDialog.CloseButton, "TOPLEFT", -3, 0)
		T.SkinCloseButton(PremadeGroupsFilterDialog.MaxMinButtonFrame.MaximizeButton, nil, "+")
		PremadeGroupsFilterDialog.MaxMinButtonFrame.MaximizeButton:SetHitRectInsets(0, 0, 0, 0)
		PremadeGroupsFilterDialog.MaxMinButtonFrame.MaximizeButton:ClearAllPoints()
		PremadeGroupsFilterDialog.MaxMinButtonFrame.MaximizeButton:SetPoint("TOPRIGHT", PremadeGroupsFilterDialog.CloseButton, "TOPLEFT", -3, 0)

		T.SkinDropDownBox(PremadeGroupsFilterDialog.Difficulty.DropDown)
		T.SkinEditBox(PremadeGroupsFilterDialog.Expression)
		PremadeGroupsFilterDialog.Difficulty.DropDown:SetPoint("TOPRIGHT", PremadeGroupsFilterDialog.Difficulty, "TOPRIGHT", 5, 1)

		local checkButtons = {
			PremadeGroupsFilterDialog.Difficulty.Act,
			PremadeGroupsFilterDialog.MPRating.Act,
			PremadeGroupsFilterDialog.PVPRating.Act,
			PremadeGroupsFilterDialog.Defeated.Act,
			PremadeGroupsFilterDialog.Members.Act,
			PremadeGroupsFilterDialog.Tanks.Act,
			PremadeGroupsFilterDialog.Heals.Act,
			PremadeGroupsFilterDialog.Dps.Act
		}

		for _, button in pairs(checkButtons) do
			button:SetSize(27, 27)
			T.SkinCheckBox(button)
		end

		local editBoxes = {
			PremadeGroupsFilterDialog.MPRating.Min,
			PremadeGroupsFilterDialog.MPRating.Max,
			PremadeGroupsFilterDialog.Defeated.Min,
			PremadeGroupsFilterDialog.Defeated.Max,
			PremadeGroupsFilterDialog.PVPRating.Min,
			PremadeGroupsFilterDialog.PVPRating.Max,
			PremadeGroupsFilterDialog.Members.Min,
			PremadeGroupsFilterDialog.Members.Max,
			PremadeGroupsFilterDialog.Tanks.Min,
			PremadeGroupsFilterDialog.Tanks.Max,
			PremadeGroupsFilterDialog.Heals.Min,
			PremadeGroupsFilterDialog.Heals.Max,
			PremadeGroupsFilterDialog.Dps.Min,
			PremadeGroupsFilterDialog.Dps.Max
		}

		for _, box in pairs(editBoxes) do
			T.SkinEditBox(box, nil, 17)
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)

local function LoadSecondarySkin()
	ChallengesFrameInset:StripTextures()
	ChallengesFrame:DisableDrawLayer("BACKGROUND")
	ChallengesFrame.WeeklyInfo.Child:DisableDrawLayer("BACKGROUND")

	hooksecurefunc(ChallengesFrame, "Update", function(self)
		for _, frame in ipairs(self.DungeonIcons) do
			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame.backdrop:SetAllPoints()
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				frame.Icon:SetInside()
				frame.HighestLevel:SetFont(C.media.normal_font, 18, "OUTLINE")
			end
		end
	end)

	local function HandleAffixIcons(self)
		for _, frame in ipairs(self.Affixes) do
			frame.Border:SetTexture(nil)
			frame.Portrait:SetTexture(nil)

			if frame.info then
				frame.Portrait:SetTexture(CHALLENGE_MODE_EXTRA_AFFIX_INFO[frame.info.key].texture)
			elseif frame.affixID then
				local _, _, filedataid = C_ChallengeMode.GetAffixInfo(frame.affixID)
				frame.Portrait:SetTexture(filedataid)
			end
			frame.Portrait:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			if not frame.backdrop then
				frame:CreateBackdrop("Default")
				frame.backdrop:SetPoint("TOPLEFT", frame.Portrait, "TOPLEFT", -2, 2)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame.Portrait, "BOTTOMRIGHT", 2, -2)
			end
		end
	end

	hooksecurefunc(ChallengesFrame.WeeklyInfo, "SetUp", function(self)
		local affixes = C_MythicPlus.GetCurrentAffixes()
		if affixes then
			HandleAffixIcons(self.Child)
		end
	end)

	hooksecurefunc(ChallengesKeystoneFrame, "Reset", function(self)
		self:GetRegions():SetAlpha(0)
		self.InstructionBackground:SetAlpha(0)
	end)

	hooksecurefunc(ChallengesKeystoneFrame, "OnKeystoneSlotted", HandleAffixIcons)

	T.SkinCloseButton(ChallengesKeystoneFrame.CloseButton)
	ChallengesKeystoneFrame.StartButton:SkinButton(true)

	ChallengesKeystoneFrame:DisableDrawLayer("BACKGROUND")
	ChallengesKeystoneFrame:CreateBackdrop("Transparent")

	local NoticeFrame = ChallengesFrame.SeasonChangeNoticeFrame
	NoticeFrame:StripTextures()
	NoticeFrame:CreateBackdrop("Overlay")
	NoticeFrame:SetFrameLevel(5)
	NoticeFrame.NewSeason:SetTextColor(1, 0.8, 0)
	NoticeFrame.NewSeason:SetShadowOffset(1, -1)
	NoticeFrame.SeasonDescription:SetTextColor(1, 1, 1)
	NoticeFrame.SeasonDescription:SetShadowOffset(1, -1)
	NoticeFrame.SeasonDescription2:SetTextColor(1, 1, 1)
	NoticeFrame.SeasonDescription2:SetShadowOffset(1, -1)
	NoticeFrame.SeasonDescription2:SetWidth(400)
	NoticeFrame.SeasonDescription3:SetTextColor(1, 0.8, 0)
	NoticeFrame.SeasonDescription3:SetShadowOffset(1, -1)

	NoticeFrame.Affix:StripTextures()
	NoticeFrame.Affix.Portrait:SkinIcon()

	NoticeFrame.Leave:SkinButton()
end

T.SkinFuncs["Blizzard_ChallengesUI"] = LoadSecondarySkin
