local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Friends skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
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
		"FriendsFriendsNoteFrame",
		"FriendsFriendsList",
		"BNConversationInviteDialog",
		"BNConversationInviteDialogList",
		"IgnoreListFrame",
		"PendingListFrame",
		"FriendsFrameInset",
		"WhoFrameListInset",
		"WhoFrameEditBoxInset",
		"ChannelFrameRightInset",
		"ChannelFrameLeftInset",
		"LFRQueueFrameListInset",
		"LFRQueueFrameRoleInset",
		"LFRQueueFrameCommentInset"
	}

	local KillTextures = {
		"FriendsFrameBroadcastInputLeft",
		"FriendsFrameBroadcastInputRight",
		"FriendsFrameBroadcastInputMiddle",
		"ChannelFrameDaughterFrameChannelNameLeft",
		"ChannelFrameDaughterFrameChannelNameRight",
		"ChannelFrameDaughterFrameChannelNameMiddle",
		"ChannelFrameDaughterFrameChannelPasswordLeft",
		"ChannelFrameDaughterFrameChannelPasswordRight",
		"ChannelFrameDaughterFrameChannelPasswordMiddle"
	}

	local buttons = {
		"FriendsFrameAddFriendButton",
		"FriendsFrameSendMessageButton",
		"WhoFrameWhoButton",
		"WhoFrameAddFriendButton",
		"WhoFrameGroupInviteButton",
		"ChannelFrameNewButton",
		"FriendsFrameIgnorePlayerButton",
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
		"BNConversationInviteDialogCancelButton",
		"BNConversationInviteDialogInviteButton"
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end

	for i = 1, FriendsFrame:GetNumRegions() do
		local region = select(i, FriendsFrame:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
			region:SetAlpha(0)
		end
	end

	-- Reposition buttons
	WhoFrameWhoButton:Point("RIGHT", WhoFrameAddFriendButton, "LEFT", -3, 0)
	WhoFrameAddFriendButton:Point("RIGHT", WhoFrameGroupInviteButton, "LEFT", -3, 0)
	WhoFrameGroupInviteButton:Point("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -4, 4)

	-- Resize Buttons
	WhoFrameWhoButton:Size(WhoFrameWhoButton:GetWidth() + 7, WhoFrameWhoButton:GetHeight())
	WhoFrameAddFriendButton:Size(WhoFrameAddFriendButton:GetWidth() - 4, WhoFrameAddFriendButton:GetHeight())
	WhoFrameGroupInviteButton:Size(WhoFrameGroupInviteButton:GetWidth() - 4, WhoFrameGroupInviteButton:GetHeight())
	T.SkinEditBox(WhoFrameEditBox)
	WhoFrameEditBox:Height(WhoFrameEditBox:GetHeight() - 15)
	WhoFrameEditBox:Width(WhoFrameEditBox:GetWidth() + 30)
	WhoFrameEditBox:Point("BOTTOM", WhoFrame, "BOTTOM", 0, 31)

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	T.SkinEditBox(AddFriendNameEditBox)
	AddFriendNameEditBox:Height(AddFriendNameEditBox:GetHeight() - 5)
	AddFriendFrame:SetTemplate("Transparent")
	FriendsFriendsFrame:SetTemplate("Transparent")
	FriendsFriendsNoteFrame:SetTemplate("Overlay")
	FriendsFriendsList:SetTemplate("Overlay")

	-- Who Frame
	local function UpdateWhoSkins()
		WhoListScrollFrame:StripTextures()
	end
	-- Channel Frame
	local function UpdateChannel()
		ChannelRosterScrollFrame:StripTextures()
	end
	-- BNet Frame
	FriendsFrameBroadcastInput:CreateBackdrop("Overlay")
	FriendsFrameBroadcastInput.backdrop:Point("TOPLEFT", -2, 2)
	FriendsFrameBroadcastInput.backdrop:Point("BOTTOMRIGHT", 0, 1)
	ChannelFrameDaughterFrameChannelName:CreateBackdrop("Overlay")
	ChannelFrameDaughterFrameChannelPassword:CreateBackdrop("Overlay")
	BNConversationInviteDialog:SetTemplate("Transparent")
	BNConversationInviteDialogList:SetTemplate("Overlay")

	ChannelFrame:HookScript("OnShow", UpdateChannel)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateChannel)

	WhoFrame:HookScript("OnShow", UpdateWhoSkins)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateWhoSkins)

	ChannelFrameDaughterFrame:CreateBackdrop("Transparent")

	FriendsFrame:CreateBackdrop("Transparent")
	FriendsFrame.backdrop:Point("TOPLEFT", FriendsFrame, "TOPLEFT", 0, -0)
	FriendsFrame.backdrop:Point("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", 0, 0)
	WhoListScrollFrame:ClearAllPoints()
	WhoListScrollFrame:SetPoint("TOPRIGHT", WhoFrameListInset, -25, 0)

	ScrollOfResurrectionFrame:StripTextures()
	ScrollOfResurrectionFrameNoteFrame:StripTextures()
	ScrollOfResurrectionFrame:SetTemplate("Transparent")
	ScrollOfResurrectionFrameNoteFrame:SetTemplate("Overlay")
	ScrollOfResurrectionFrameAcceptButton:SkinButton()
	ScrollOfResurrectionFrameCancelButton:SkinButton()
	T.SkinEditBox(ScrollOfResurrectionFrameTargetEditBox)
	ScrollOfResurrectionFrameTargetEditBox:Height(ScrollOfResurrectionFrameTargetEditBox:GetHeight() - 5)

	FriendsTabHeaderSoRButton:SetTemplate("Default")
	FriendsTabHeaderSoRButton:StyleButton()
	FriendsTabHeaderSoRButton.icon:SetDrawLayer("OVERLAY")
	FriendsTabHeaderSoRButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	FriendsTabHeaderSoRButton.icon:ClearAllPoints()
	FriendsTabHeaderSoRButton.icon:Point("TOPLEFT", 2, -2)
	FriendsTabHeaderSoRButton.icon:Point("BOTTOMRIGHT", -2, 2)

	T.SkinCloseButton(ChannelFrameDaughterFrameDetailCloseButton, ChannelFrameDaughterFrame)
	T.SkinCloseButton(FriendsFrameCloseButton, FriendsFrame.backdrop)
	T.SkinDropDownBox(WhoFrameDropDown, 150)
	T.SkinDropDownBox(FriendsFrameStatusDropDown, 70)
	T.SkinDropDownBox(FriendsFriendsFrameDropDown)
	FriendsFrameAddFriendButton:Point("BOTTOMLEFT", FriendsFrame.backdrop, "BOTTOMLEFT", 5, 5)
	FriendsFrameIgnorePlayerButton:Point("BOTTOMLEFT", FriendsFrame.backdrop, "BOTTOMLEFT", 5, 5)

	-- Bottom Tabs
	for i = 1, 5 do
		T.SkinTab(_G["FriendsFrameTab"..i])
	end

	for i = 1, 3 do
		_G["FriendsTabHeaderTab"..i]:StripTextures()
	end

	local function Channel()
		for i = 1, MAX_DISPLAY_CHANNEL_BUTTONS do
			local button = _G["ChannelButton"..i]
			if button then
				button:StripTextures()
				button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
			end
		end
	end
	hooksecurefunc("ChannelList_Update", Channel)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)