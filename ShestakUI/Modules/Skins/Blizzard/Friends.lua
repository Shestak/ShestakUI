local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Friends skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		FriendsFrame,
		FriendsListFrame,
		FriendsTabHeader,
		FriendsListFrameScrollFrame,
		WhoFrameColumnHeader1,
		WhoFrameColumnHeader2,
		WhoFrameColumnHeader3,
		WhoFrameColumnHeader4,
		AddFriendFrame,
		FriendsFriendsFrame,
		IgnoreListFrame,
		FriendsFrameInset,
		WhoFrameListInset,
		WhoFrameEditBoxInset,
		LFRQueueFrameListInset,
		LFRQueueFrameRoleInset,
		LFRQueueFrameCommentInset,
		FriendsFrameBattlenetFrame,
		BattleTagInviteFrame,
		QuickJoinScrollFrame,
		QuickJoinRoleSelectionFrame,
		FriendsFrameBattlenetFrame.BroadcastFrame,
		FriendsFrameBattlenetFrame.UnavailableInfoFrame,
		RecruitAFriendFrame.RecruitList.Header,
		RecruitAFriendFrame.RecruitList.ScrollFrameInset,
		RecruitAFriendFrame.RewardClaiming,
		RecruitAFriendRecruitmentFrame,
		RecruitAFriendRewardsFrame
	}

	for i = 1, #StripAllTextures do
		StripAllTextures[i]:StripTextures()
	end

	local KillTextures = {
		FriendsFrameIcon
	}

	for i = 1, #KillTextures do
		KillTextures[i]:Kill()
	end

	local buttons = {
		FriendsFrameAddFriendButton,
		FriendsFrameSendMessageButton,
		WhoFrameWhoButton,
		WhoFrameAddFriendButton,
		WhoFrameGroupInviteButton,
		FriendsFrameIgnorePlayerButton,
		FriendsFrameUnsquelchButton,
		AddFriendEntryFrameAcceptButton,
		AddFriendEntryFrameCancelButton,
		AddFriendInfoFrameContinueButton,
		QuickJoinFrame.JoinQueueButton,
		QuickJoinRoleSelectionFrame.AcceptButton,
		QuickJoinRoleSelectionFrame.CancelButton,
		FriendsListFrameScrollFrame.PendingInvitesHeaderButton,
		FriendsFrameBattlenetFrame.BroadcastFrame.CancelButton,
		FriendsFrameBattlenetFrame.BroadcastFrame.UpdateButton,
		RecruitAFriendFrame.RewardClaiming.ClaimOrViewRewardButton,
		RecruitAFriendFrame.RecruitmentButton,
		RecruitAFriendFrame.SplashFrame.OKButton,
		RecruitAFriendRecruitmentFrame.GenerateOrCopyLinkButton
	}

	for i = 1, #buttons do
		buttons[i]:SkinButton()
	end

	local scrollbars = {
		FriendsListFrameScrollFrame.scrollBar,
		FriendsFriendsScrollFrame.scrollBar,
		IgnoreListFrameScrollFrame.scrollBar,
		WhoListScrollFrame.scrollBar,
		QuickJoinScrollFrame.scrollBar,
		RecruitAFriendFrame.RecruitList.ScrollFrame.Slider
	}

	for i = 1, #scrollbars do
		T.SkinScrollBar(scrollbars[i])
	end

	-- Reposition buttons
	WhoFrameWhoButton:SetPoint("RIGHT", WhoFrameAddFriendButton, "LEFT", -3, 0)
	WhoFrameAddFriendButton:SetPoint("RIGHT", WhoFrameGroupInviteButton, "LEFT", -3, 0)
	WhoFrameGroupInviteButton:SetPoint("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -4, 4)
	FriendsFrameAddFriendButton:SetPoint("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 4, 4)
	FriendsFrameSendMessageButton:SetPoint("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -4, 4)
	FriendsFrameIgnorePlayerButton:SetPoint("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 4, 4)
	FriendsFrameUnsquelchButton:SetPoint("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -4, 4)

	-- Resize Buttons
	WhoFrameWhoButton:SetSize(WhoFrameWhoButton:GetWidth() + 7, WhoFrameWhoButton:GetHeight())
	WhoFrameAddFriendButton:SetSize(WhoFrameAddFriendButton:GetWidth() - 4, WhoFrameAddFriendButton:GetHeight())
	WhoFrameGroupInviteButton:SetSize(WhoFrameGroupInviteButton:GetWidth() - 4, WhoFrameGroupInviteButton:GetHeight())
	T.SkinEditBox(WhoFrameEditBox, WhoFrameEditBox:GetWidth() + 30, WhoFrameEditBox:GetHeight() - 15)
	WhoFrameEditBox:SetPoint("BOTTOM", WhoFrame, "BOTTOM", 0, 31)

	T.SkinEditBox(AddFriendNameEditBox)
	AddFriendNameEditBox:SetHeight(AddFriendNameEditBox:GetHeight() - 5)
	AddFriendFrame:SetTemplate("Transparent")
	FriendsFriendsFrame:SetTemplate("Transparent")

	-- Recruit a Friend
	local SplashFrame = RecruitAFriendFrame.SplashFrame
	SplashFrame:CreateBackdrop("Overlay")
	SplashFrame.backdrop:SetPoint("TOPLEFT", 2, -2)
	SplashFrame.backdrop:SetPoint("BOTTOMRIGHT", -1, -1)

	SplashFrame.Picture.b = CreateFrame("Frame", nil, SplashFrame)
	SplashFrame.Picture.b:SetTemplate("Default")
	SplashFrame.Picture.b:SetPoint("TOPLEFT", SplashFrame.Picture, "TOPLEFT", -2, 2)
	SplashFrame.Picture.b:SetPoint("BOTTOMRIGHT", SplashFrame.Picture, "BOTTOMRIGHT", 2, -2)
	SplashFrame.Picture:SetParent(SplashFrame.Picture.b)

	RecruitAFriendFrame.SplashFrame.Description:SetTextColor(1, 1, 1)

	SplashFrame.Background:Hide()
	SplashFrame.PictureFrame:Hide()

	SplashFrame.Bracket_TopLeft:Hide()
	SplashFrame.Bracket_TopRight:Hide()
	SplashFrame.Bracket_BottomRight:Hide()
	SplashFrame.Bracket_BottomLeft:Hide()
	SplashFrame.PictureFrame_Bracket_TopLeft:Hide()
	SplashFrame.PictureFrame_Bracket_TopRight:Hide()
	SplashFrame.PictureFrame_Bracket_BottomRight:Hide()
	SplashFrame.PictureFrame_Bracket_BottomLeft:Hide()

	RecruitAFriendRewardsFrame:SetTemplate("Transparent")
	T.SkinCloseButton(RecruitAFriendRewardsFrame.CloseButton)

	for object in pairs(RecruitAFriendRewardsFrame.rewardPool.activeObjects) do
		object.Button.Icon:SkinIcon()
		object.Button.IconBorder:SetAlpha(0)
		object.Button:StyleButton(true, 0)
	end

	RecruitAFriendFrame.RewardClaiming.NextRewardButton.Icon:SkinIcon()
	RecruitAFriendFrame.RewardClaiming.NextRewardButton.CircleMask:Hide()
	RecruitAFriendFrame.RewardClaiming.NextRewardButton.IconBorder:SetAlpha(0)

	RecruitAFriendRecruitmentFrame:SetTemplate("Transparent")
	T.SkinCloseButton(RecruitAFriendRecruitmentFrame.CloseButton)
	T.SkinEditBox(RecruitAFriendRecruitmentFrame.EditBox, nil, 18)
	RecruitAFriendRecruitmentFrame.EditBox:SetPoint("RIGHT", RecruitAFriendRecruitmentFrame.GenerateOrCopyLinkButton, "LEFT", -10, 0)

	-- Quick Join Frame
	QuickJoinRoleSelectionFrame:SetTemplate("Transparent")
	T.SkinCloseButton(QuickJoinRoleSelectionFrame.CloseButton)
	T.SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonTank.CheckButton)
	T.SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonHealer.CheckButton)
	T.SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonDPS.CheckButton)

	-- Pending invites
	local function SkinFriendRequest(frame)
		if not frame.isSkinned then
			frame.DeclineButton:SetPoint("RIGHT", frame, "RIGHT", -2, 1)
			frame.DeclineButton:SkinButton()
			frame.AcceptButton:SkinButton()
			frame.isSkinned = true
		end
	end
	hooksecurefunc(FriendsListFrameScrollFrame.invitePool, "Acquire", function()
		for object in pairs(FriendsListFrameScrollFrame.invitePool.activeObjects) do
			SkinFriendRequest(object)
		end
	end)

	-- Who Frame
	local function UpdateWhoSkins()
		WhoListScrollFrame:StripTextures()
	end

	WhoFrame:HookScript("OnShow", UpdateWhoSkins)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateWhoSkins)

	WhoListScrollFrame:ClearAllPoints()
	WhoListScrollFrame:SetPoint("TOPRIGHT", WhoFrameListInset, -25, 0)

	-- BNet Frame
	FriendsFrameBattlenetFrame.BroadcastButton:SetAlpha(0)
	FriendsFrameBattlenetFrame.BroadcastButton:ClearAllPoints()
	FriendsFrameBattlenetFrame.BroadcastButton:SetAllPoints(FriendsFrameBattlenetFrame)

	FriendsFrameBattlenetFrame.BroadcastFrame:CreateBackdrop("Transparent")
	FriendsFrameBattlenetFrame.BroadcastFrame.backdrop:SetPoint("TOPLEFT", 1, 1)
	FriendsFrameBattlenetFrame.BroadcastFrame.backdrop:SetPoint("BOTTOMRIGHT", 1, 1)

	T.SkinEditBox(FriendsFrameBattlenetFrame.BroadcastFrame.EditBox, nil, 24)

	FriendsFrameBattlenetFrame.UnavailableInfoFrame:CreateBackdrop("Transparent")
	FriendsFrameBattlenetFrame.UnavailableInfoFrame.backdrop:SetPoint("TOPLEFT", 4, -4)
	FriendsFrameBattlenetFrame.UnavailableInfoFrame.backdrop:SetPoint("BOTTOMRIGHT", -4, 4)

	BattleTagInviteFrame:SetTemplate("Transparent")
	for i = 1, BattleTagInviteFrame:GetNumChildren() do
		local child = select(i, BattleTagInviteFrame:GetChildren())
		if child:GetObjectType() == "Button" then
			child:SkinButton()
		end
	end

	FriendsFrame:SetTemplate("Transparent")
	FriendsFrameStatusDropDown:SetPoint("TOPLEFT", 1, -27)

	for i = 1, FRIENDS_TO_DISPLAY do
		local button = _G["FriendsListFrameScrollFrameButton"..i]
		local icon = button.gameIcon

		icon.b = CreateFrame("Frame", nil, button)
		icon.b:SetTemplate("Default")
		icon.b:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
		icon.b:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)

		icon:SetParent(icon.b)
		icon:SetSize(22, 22)
		icon:SetTexCoord(.15, .85, .15, .85)
		icon:ClearAllPoints()
		icon:SetPoint("RIGHT", button, "RIGHT", -24, 0)
		icon.SetPoint = T.dummy

		button.travelPassButton:SetSize(20, 32)
		button.travelPassButton:SkinButton()
		button.background:Hide()

		button.inv = button.travelPassButton:CreateTexture(nil, "OVERLAY", nil, 7)
		button.inv:SetTexture([[Interface\FriendsFrame\PlusManz-PlusManz]])
		button.inv:SetPoint("TOPRIGHT", 1, -4)
		button.inv:SetSize(22, 22)
	end

	hooksecurefunc("FriendsFrame_UpdateFriendButton", function(button)
		if button.buttonType == FRIENDS_BUTTON_TYPE_BNET and button.travelPassButton then
			local isEnabled = button.travelPassButton:IsEnabled()
			button.travelPassButton:SetAlpha(isEnabled and 1 or 0.4)
		end

		if button.gameIcon.b then
			button.gameIcon.b:SetShown(button.gameIcon:IsShown())
		end
	end)

	T.SkinCloseButton(FriendsFrameCloseButton)
	T.SkinDropDownBox(WhoFrameDropDown, 150)
	T.SkinDropDownBox(FriendsFrameStatusDropDown, 70)
	T.SkinDropDownBox(FriendsFriendsFrameDropDown)

	-- Bottom Tabs
	for i = 1, 4 do
		T.SkinTab(_G["FriendsFrameTab"..i])
	end

	for i = 1, 3 do
		T.SkinTab(_G["FriendsTabHeaderTab"..i], true)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)