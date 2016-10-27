local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Friends skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"FriendsFrame",
		"FriendsListFrame",
		"FriendsTabHeader",
		"FriendsFrameFriendsScrollFrame",
		"WhoFrameColumnHeader1",
		"WhoFrameColumnHeader2",
		"WhoFrameColumnHeader3",
		"WhoFrameColumnHeader4",
		"ChannelListScrollFrame",
		"ChannelRoster",
		"FriendsFramePendingButton1",
		"FriendsFramePendingButton2",
		"FriendsFramePendingButton3",
		"FriendsFramePendingButton4",
		"ChannelFrameDaughterFrame",
		"AddFriendFrame",
		"AddFriendNoteFrame",
		"FriendsFriendsFrame",
		"FriendsFriendsList",
		"IgnoreListFrame",
		"PendingListFrame",
		"FriendsFrameInset",
		"WhoFrameListInset",
		"WhoFrameEditBoxInset",
		"ChannelFrameRightInset",
		"ChannelFrameLeftInset",
		"LFRQueueFrameListInset",
		"LFRQueueFrameRoleInset",
		"LFRQueueFrameCommentInset",
		"ScrollOfResurrectionSelectionFrame",
		"ScrollOfResurrectionSelectionFrameList",
		"ScrollOfResurrectionFrame",
		"ScrollOfResurrectionFrameNoteFrame",
		"FriendsFrameBattlenetFrame",
		"BattleTagInviteFrame",
		"BNetReportFrame",
		"BNetReportFrameComment",
		"RecruitAFriendNoteFrame"
	}

	for _, object in pairs(StripAllTextures) do
		--BETA _G[object]:StripTextures()
	end

	local KillTextures = {
		"FriendsFrameIcon",
		"FriendsFrameBroadcastInputLeft",
		"FriendsFrameBroadcastInputRight",
		"FriendsFrameBroadcastInputMiddle"
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local buttons = {
		"FriendsFrameAddFriendButton",
		"FriendsFrameSendMessageButton",
		"WhoFrameWhoButton",
		"WhoFrameAddFriendButton",
		"WhoFrameGroupInviteButton",
		"ChannelFrameNewButton",
		"FriendsFrameIgnorePlayerButton",
		"FriendsFrameMutePlayerButton",
		"FriendsFrameUnsquelchButton",
		"FriendsFramePendingButton1AcceptButton",
		"FriendsFramePendingButton1DeclineButton",
		"FriendsFramePendingButton2AcceptButton",
		"FriendsFramePendingButton2DeclineButton",
		"FriendsFramePendingButton3AcceptButton",
		"FriendsFramePendingButton3DeclineButton",
		"FriendsFramePendingButton4AcceptButton",
		"FriendsFramePendingButton4DeclineButton",
		"ChannelFrameDaughterFrameOkayButton",
		"ChannelFrameDaughterFrameCancelButton",
		"AddFriendEntryFrameAcceptButton",
		"AddFriendEntryFrameCancelButton",
		"AddFriendInfoFrameContinueButton",
		"FriendsFriendsCloseButton",
		"FriendsFriendsSendRequestButton",
		"ScrollOfResurrectionSelectionFrameAcceptButton",
		"ScrollOfResurrectionSelectionFrameCancelButton",
		"ScrollOfResurrectionFrameAcceptButton",
		"ScrollOfResurrectionFrameCancelButton",
		"PendingListInfoFrameContinueButton",
		"BNetReportFrameReportButton",
		"BNetReportFrameCancelButton",
		"RecruitAFriendFrameSendButton"
	}

	for _, button in pairs(buttons) do
		--BETA _G[button]:SkinButton()
	end

	local scrollbars = {
		"FriendsFrameFriendsScrollFrameScrollBar",
		"FriendsFrameIgnoreScrollFrameScrollBar",
		"FriendsFriendsScrollFrameScrollBar",
		"WhoListScrollFrameScrollBar",
		"ChannelRosterScrollFrameScrollBar"
	}

	for _, scrollbar in pairs(scrollbars) do
		T.SkinScrollBar(_G[scrollbar])
	end

	-- Reposition buttons
	WhoFrameWhoButton:SetPoint("RIGHT", WhoFrameAddFriendButton, "LEFT", -3, 0)
	WhoFrameAddFriendButton:SetPoint("RIGHT", WhoFrameGroupInviteButton, "LEFT", -3, 0)
	WhoFrameGroupInviteButton:SetPoint("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -4, 4)
	ChannelFrameDaughterFrameCancelButton:SetPoint("LEFT", ChannelFrameDaughterFrameOkayButton, "RIGHT", 3, 0)
	FriendsFrameAddFriendButton:SetPoint("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 4, 4)
	FriendsFrameSendMessageButton:SetPoint("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -4, 4)
	FriendsFrameIgnorePlayerButton:SetPoint("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 4, 4)
	FriendsFrameUnsquelchButton:SetPoint("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -4, 4)
	FriendsFrameMutePlayerButton:SetPoint("LEFT", FriendsFrameIgnorePlayerButton, "RIGHT", 3, 0)
	FriendsFrameMutePlayerButton:SetPoint("RIGHT", FriendsFrameUnsquelchButton, "LEFT", -3, 0)

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
	FriendsFriendsList:SetTemplate("Overlay")
	--BETA PendingListInfoFrame:SetTemplate("Overlay")

	-- Who Frame
	local function UpdateWhoSkins()
		--BETA WhoListScrollFrame:StripTextures()
	end

	WhoFrame:HookScript("OnShow", UpdateWhoSkins)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateWhoSkins)

	WhoListScrollFrame:ClearAllPoints()
	WhoListScrollFrame:SetPoint("TOPRIGHT", WhoFrameListInset, -25, 0)

	-- Channel Frame
	local function UpdateChannel()
		--BETA ChannelRosterScrollFrame:StripTextures()
	end

	ChannelFrame:HookScript("OnShow", UpdateChannel)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateChannel)

	-- BNet Frame
	FriendsFrameBroadcastInput:CreateBackdrop("Overlay")
	FriendsFrameBroadcastInput.backdrop:SetPoint("TOPLEFT", -2, 2)
	FriendsFrameBroadcastInput.backdrop:SetPoint("BOTTOMRIGHT", 0, 1)

	ChannelFrameDaughterFrame:SetTemplate("Transparent")
	T.SkinEditBox(ChannelFrameDaughterFrameChannelName)
	T.SkinEditBox(ChannelFrameDaughterFrameChannelPassword)

	BNetReportFrame:SetTemplate("Transparent")
	BNetReportFrameComment:SetTemplate("Overlay")

	FriendsFrameBattlenetFrame.BroadcastButton:SetAlpha(0)
	FriendsFrameBattlenetFrame.BroadcastButton:ClearAllPoints()
	FriendsFrameBattlenetFrame.BroadcastButton:SetAllPoints(FriendsFrameBattlenetFrame)

	FriendsFrameBattlenetFrame.BroadcastFrame:StripTextures()
	FriendsFrameBattlenetFrame.BroadcastFrame:CreateBackdrop("Transparent")
	FriendsFrameBattlenetFrame.BroadcastFrame.backdrop:SetPoint("TOPLEFT", 1, 1)
	FriendsFrameBattlenetFrame.BroadcastFrame.backdrop:SetPoint("BOTTOMRIGHT", 1, 1)

	--BETA FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame:StripTextures()
	-- FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame:SetTemplate("Overlay")
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame.CancelButton:SkinButton()
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame.UpdateButton:SkinButton()

	FriendsFrameBattlenetFrame.UnavailableInfoFrame:StripTextures()
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

	ScrollOfResurrectionSelectionFrame:SetTemplate("Transparent")
	ScrollOfResurrectionSelectionFrameList:SetTemplate("Overlay")
	T.SkinEditBox(ScrollOfResurrectionSelectionFrameTargetEditBox, nil, ScrollOfResurrectionSelectionFrameTargetEditBox:GetHeight() - 5)

	ScrollOfResurrectionFrame:SetTemplate("Transparent")
	ScrollOfResurrectionFrameNoteFrame:SetTemplate("Overlay")
	T.SkinEditBox(ScrollOfResurrectionFrameTargetEditBox, nil, ScrollOfResurrectionFrameTargetEditBox:GetHeight() - 5)

	RecruitAFriendFrame:SetTemplate("Transparent")
	T.SkinCloseButton(RecruitAFriendFrameCloseButton)
	T.SkinEditBox(RecruitAFriendNameEditBox)
	T.SkinEditBox(RecruitAFriendNoteFrame)

	RecruitAFriendSentFrame:SetTemplate("Transparent")
	RecruitAFriendSentFrame.OKButton:SkinButton()
	T.SkinCloseButton(RecruitAFriendSentFrameCloseButton)

	FriendsTabHeaderSoRButton:SetTemplate("Default")
	FriendsTabHeaderSoRButton:StyleButton()
	FriendsTabHeaderSoRButton.icon:SetDrawLayer("OVERLAY")
	FriendsTabHeaderSoRButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	FriendsTabHeaderSoRButton.icon:ClearAllPoints()
	FriendsTabHeaderSoRButton.icon:SetPoint("TOPLEFT", 2, -2)
	FriendsTabHeaderSoRButton.icon:SetPoint("BOTTOMRIGHT", -2, 2)

	FriendsTabHeaderRecruitAFriendButton:SetTemplate("Default")
	FriendsTabHeaderRecruitAFriendButton:StyleButton()
	FriendsTabHeaderRecruitAFriendButtonIcon:SetDrawLayer("OVERLAY")
	FriendsTabHeaderRecruitAFriendButtonIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	FriendsTabHeaderRecruitAFriendButtonIcon:ClearAllPoints()
	FriendsTabHeaderRecruitAFriendButtonIcon:SetPoint("TOPLEFT", 2, -2)
	FriendsTabHeaderRecruitAFriendButtonIcon:SetPoint("BOTTOMRIGHT", -2, 2)

	T.SkinCloseButton(ChannelFrameDaughterFrameDetailCloseButton, ChannelFrameDaughterFrame)
	T.SkinCloseButton(FriendsFrameCloseButton)
	T.SkinDropDownBox(WhoFrameDropDown, 150)
	T.SkinDropDownBox(FriendsFrameStatusDropDown, 70)
	T.SkinDropDownBox(FriendsFriendsFrameDropDown)

	T.SkinCheckBox(ChannelFrameAutoJoinBattleground)
	T.SkinCheckBox(ChannelFrameAutoJoinParty)

	-- Bottom Tabs
	for i = 1, 5 do
		T.SkinTab(_G["FriendsFrameTab"..i])
	end

	for i = 1, 3 do
		T.SkinTab(_G["FriendsTabHeaderTab"..i], true)
	end

	local once = false
	local function Channel()
		for i = 1, MAX_DISPLAY_CHANNEL_BUTTONS do
			local button = _G["ChannelButton"..i]

			if button then
				if i > 1 then
					button:SetPoint("TOPLEFT", _G["ChannelButton"..i-1], "BOTTOMLEFT", 0, -3)
				end
				if i == 2 and once == false then
					button:SkinButton()
					once = true
				elseif i ~= 2 then
					button:SkinButton()
				end
			end
		end
	end
	hooksecurefunc("ChannelList_Update", Channel)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)