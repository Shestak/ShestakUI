local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Communities skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local scrollbars = {
		CommunitiesFrameCommunitiesListListScrollFrame.ScrollBar,
		CommunitiesFrame.Chat.MessageFrame.ScrollBar,
		CommunitiesFrame.MemberList.ListScrollFrame.scrollBar,
		CommunitiesFrameRewards.scrollBar,
		CommunitiesFrameGuildDetailsFrameNewsContainer.ScrollBar,
		CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.ScrollBar,
		CommunitiesAvatarPickerDialogScrollBar,
		CommunitiesGuildTextEditFrameScrollBar,
		CommunitiesGuildLogFrameScrollBar,
		ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ListScrollFrame.scrollBar,
		ClubFinderCommunityAndGuildFinderFrameScrollBar,
		ClubFinderGuildFinderFrameScrollBar,
		ClubFinderCommunityAndGuildFinderFrame.PendingCommunityCards.ListScrollFrame.scrollBar,
		CommunitiesFrameGuildDetailsFrameInfoMOTDScrollFrameScrollBar,
		CommunitiesFrameGuildDetailsFrameInfoScrollBar
	}

	for i = 1, #scrollbars do
		T.SkinScrollBar(scrollbars[i])
	end

	local closeButton = {
		CommunitiesGuildNewsFiltersFrame.CloseButton,
		CommunitiesGuildLogFrameCloseButton,
		CommunitiesFrameCloseButton,
		CommunitiesFrame.GuildMemberDetailFrame.CloseButton,
		CommunitiesGuildTextEditFrameCloseButton
	}

	for i = 1, #closeButton do
		T.SkinCloseButton(closeButton[i])
	end

	-- General Communities Frame
	CommunitiesFrame:StripTextures()
	CommunitiesFrame:CreateBackdrop("Transparent")
	CommunitiesFrame.NineSlice:Hide()
	CommunitiesFrame.PortraitOverlay:Kill()
	CommunitiesFrameCommunitiesList:StripTextures()

	T.SkinMaxMinFrame(CommunitiesFrame.MaximizeMinimizeFrame, CommunitiesFrameCloseButton)

	CommunitiesFrame.InviteButton:SkinButton()

	CommunitiesFrame.Chat.InsetFrame.NineSlice:Hide()
	CommunitiesFrame.Chat.InsetFrame:SetTemplate("Overlay")
	CommunitiesFrame.ChatTab:SetPoint("TOPLEFT", CommunitiesFrame, "TOPRIGHT", 5, -36)

	hooksecurefunc(CommunitiesFrame.Chat.MessageFrame.ScrollBar, "SetPoint", function(self, point, anchor, attachTo, x, y)
		if anchor == CommunitiesFrame.Chat.MessageFrame and x == 10 and y == -11 then
			self:SetPoint(point, anchor, attachTo, 11, -7)
		elseif anchor == CommunitiesFrame.Chat.MessageFrame and x == 10 and y == -17 then
			self:SetPoint(point, anchor, attachTo, 11, -14)
		end
	end)

	CommunitiesFrame.MemberList.ListScrollFrame.scrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrame.MemberList.ListScrollFrame, "BOTTOMRIGHT", 0, 14)
	CommunitiesFrame.MemberList:SetPoint("BOTTOMRIGHT", CommunitiesFrame, "BOTTOMRIGHT", -26, 31)

	hooksecurefunc(CommunitiesFrame.ChatEditBox, "SetPoint", function(self, point, anchor, attachTo, x, y)
		if point == "BOTTOMLEFT" and x == 10 and y == 0 then
			self:SetPoint(point, anchor, attachTo, 12, 5)
		elseif point == "BOTTOMRIGHT" and x == -12 and y == 0 then
			self:SetPoint(point, anchor, attachTo, -10, 5)
		end
	end)

	T.SkinEditBox(CommunitiesFrame.ChatEditBox, nil, 18)

	T.SkinDropDownBox(CommunitiesFrame.StreamDropDownMenu, nil, true)
	T.SkinDropDownBox(CommunitiesFrame.CommunitiesListDropDownMenu)

	CommunitiesFrame.AddToChatButton:SkinButton()
	CommunitiesFrame.CommunitiesControlFrame.CommunitiesSettingsButton:SkinButton()

	hooksecurefunc(CommunitiesListEntryMixin, "SetClubInfo", function(self, clubInfo)
		if clubInfo then
			self:SetSize(166, 65)
			self.Background:Hide()
			self:SetFrameLevel(self:GetFrameLevel() + 5)

			self.Icon:RemoveMaskTexture(self.CircleMask)
			self.Icon:SetDrawLayer("OVERLAY", 1)
			self.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			self.IconRing:Hide()

			if not self.bg then
				self.bg = CreateFrame("Frame", nil, self)
				self.bg:CreateBackdrop("Overlay")
				self.bg:SetFrameLevel(self:GetFrameLevel() - 2)
				self.bg:SetPoint("TOPLEFT", 4, -3)
				self.bg:SetPoint("BOTTOMRIGHT", -1, 3)
			end

			local isGuild = clubInfo.clubType == Enum.ClubType.Guild
			if isGuild then
				self.Selection:SetInside(self.bg, 0, 0)
				self.Selection:SetColorTexture(0, 1, 0, 0.2)
			else
				self.Selection:SetInside(self.bg, 0, 0)
				self.Selection:SetColorTexture(FRIENDS_BNET_BACKGROUND_COLOR.r, FRIENDS_BNET_BACKGROUND_COLOR.g, FRIENDS_BNET_BACKGROUND_COLOR.b, 0.2)
			end

			local highlight = self:GetHighlightTexture()
			highlight:SetInside(self.bg, 0, 0)
			highlight:SetColorTexture(1, 1, 1, 0.3)
		end
	end)

	local function SkinCommunitiesButton(self, colorSection)
		self:SetSize(166, 65)
		self.Background:Hide()
		self:SetFrameLevel(self:GetFrameLevel() + 5)
		self.CircleMask:Hide()

		self.Icon:SetDrawLayer("OVERLAY", 1)
		self.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		self.IconRing:Hide()

		if not self.bg then
			self.bg = CreateFrame("Frame", nil, self)
			self.bg:CreateBackdrop("Overlay")
			self.bg:SetFrameLevel(self:GetFrameLevel() - 2)
			self.bg:SetPoint("TOPLEFT", 4, -3)
			self.bg:SetPoint("BOTTOMRIGHT", -1, 3)
		end

		if colorSection then
			self.Selection:SetInside(self.bg, 0, 0)
			if colorSection == 1 then
				self.Selection:SetColorTexture(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, 0.2)
			else
				self.Selection:SetColorTexture(BATTLENET_FONT_COLOR.r, BATTLENET_FONT_COLOR.g, BATTLENET_FONT_COLOR.b, 0.2)
			end
		end

		local highlight = self:GetHighlightTexture()
		highlight:SetColorTexture(1, 1, 1, 0.3)
		highlight:SetInside(self.bg, 0, 0)
	end

	hooksecurefunc(CommunitiesListEntryMixin, "SetGuildFinder", function(self)
		SkinCommunitiesButton(self, 1)
	end)

	hooksecurefunc(CommunitiesListEntryMixin, "SetFindCommunity", function(self)
		SkinCommunitiesButton(self, 2)
	end)

	hooksecurefunc(CommunitiesListEntryMixin, "SetAddCommunity", function(self)
		SkinCommunitiesButton(self)
	end)

	-- ClubFinderInvitationFrame
	CommunitiesFrame.ClubFinderInvitationFrame.InsetFrame:StripTextures()
	CommunitiesFrame.ClubFinderInvitationFrame:SetTemplate("Overlay")
	CommunitiesFrame.ClubFinderInvitationFrame.AcceptButton:SkinButton()
	CommunitiesFrame.ClubFinderInvitationFrame.DeclineButton:SkinButton()
	CommunitiesFrame.ClubFinderInvitationFrame.ApplyButton:SkinButton()

	CommunitiesFrame.ClubFinderInvitationFrame.WarningDialog:StripTextures()
	CommunitiesFrame.ClubFinderInvitationFrame.WarningDialog:SetTemplate("Transparent")
	CommunitiesFrame.ClubFinderInvitationFrame.WarningDialog.Accept:SkinButton()
	CommunitiesFrame.ClubFinderInvitationFrame.WarningDialog.Cancel:SkinButton()

	-- InvitationFrame
	CommunitiesFrame.InvitationFrame.InsetFrame:StripTextures()
	CommunitiesFrame.InvitationFrame:SetTemplate("Overlay")
	CommunitiesFrame.InvitationFrame.AcceptButton:SkinButton()
	CommunitiesFrame.InvitationFrame.DeclineButton:SkinButton()

	-- GuildFinderFrame
	CommunitiesFrame.GuildFinderFrame:StripTextures()
	ClubFinderCommunityAndGuildFinderFrame:StripTextures()
	ClubFinderGuildFinderFrame.OptionsList.Search:SkinButton()
	ClubFinderCommunityAndGuildFinderFrame.OptionsList.Search:SkinButton()

	T.SkinDropDownBox(ClubFinderGuildFinderFrame.OptionsList.ClubFilterDropdown)
	T.SkinDropDownBox(ClubFinderGuildFinderFrame.OptionsList.ClubSizeDropdown)

	T.SkinDropDownBox(ClubFinderCommunityAndGuildFinderFrame.OptionsList.ClubFilterDropdown)
	T.SkinDropDownBox(ClubFinderCommunityAndGuildFinderFrame.OptionsList.SortByDropdown)

	ClubFinderGuildFinderFrame.OptionsList.Search:ClearAllPoints()
	ClubFinderGuildFinderFrame.OptionsList.Search:SetPoint("TOP", ClubFinderGuildFinderFrame.OptionsList.SearchBox, "BOTTOM", 0, -3)
	T.SkinEditBox(ClubFinderGuildFinderFrame.OptionsList.SearchBox, 146, 18)

	ClubFinderGuildFinderFrame.ClubFinderSearchTab:SetPoint("TOPLEFT", CommunitiesFrame, "TOPRIGHT", 5, -30)
	ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab:SetPoint("TOPLEFT", CommunitiesFrame, "TOPRIGHT", 5, -30)

	T.SkinCheckBox(ClubFinderGuildFinderFrame.OptionsList.TankRoleFrame.CheckBox)
	T.SkinCheckBox(ClubFinderGuildFinderFrame.OptionsList.HealerRoleFrame.CheckBox)
	T.SkinCheckBox(ClubFinderGuildFinderFrame.OptionsList.DpsRoleFrame.CheckBox)

	T.SkinCheckBox(ClubFinderCommunityAndGuildFinderFrame.OptionsList.TankRoleFrame.CheckBox)
	T.SkinCheckBox(ClubFinderCommunityAndGuildFinderFrame.OptionsList.HealerRoleFrame.CheckBox)
	T.SkinCheckBox(ClubFinderCommunityAndGuildFinderFrame.OptionsList.DpsRoleFrame.CheckBox)

	ClubFinderCommunityAndGuildFinderFrame.OptionsList.Search:ClearAllPoints()
	ClubFinderCommunityAndGuildFinderFrame.OptionsList.Search:SetPoint("TOP", ClubFinderCommunityAndGuildFinderFrame.OptionsList.SearchBox, "BOTTOM", 0, -3)
	T.SkinEditBox(ClubFinderCommunityAndGuildFinderFrame.OptionsList.SearchBox, 146, 18)

	T.SkinNextPrevButton(ClubFinderGuildFinderFrame.GuildCards.PreviousPage)
	T.SkinNextPrevButton(ClubFinderGuildFinderFrame.GuildCards.NextPage)
	T.SkinNextPrevButton(ClubFinderGuildFinderFrame.PendingGuildCards.PreviousPage)
	T.SkinNextPrevButton(ClubFinderGuildFinderFrame.PendingGuildCards.NextPage)

	for _, button in pairs(ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ListScrollFrame.buttons, ClubFinderCommunityAndGuildFinderFrame.PendingCommunityCards.ListScrollFrame.buttons) do
		if not button.isSkinned then
			button.CircleMask:Hide()
			button.LogoBorder:Hide()

			button:StripTextures()
			button:CreateBackdrop("Overlay")
			button.backdrop:SetPoint("TOPLEFT", 0, 0)
			button.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
			button:StyleButton()
			button.CommunityLogo:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			button.isSkinned = true
		end
	end

	local function SkinCard(card)
		if not card.isSkinned then
			card.CardBackground:Hide()
			card.bg = CreateFrame("Frame", nil, card)
			card.bg:CreateBackdrop("Overlay")
			card.bg:SetFrameLevel(card:GetFrameLevel() - 2)
			card.bg:SetPoint("TOPLEFT", 2, 3)
			card.bg:SetPoint("BOTTOMRIGHT", -2, 3)
			card.RequestJoin:SkinButton()
			card.isSkinned = true
		end
	end

	for _, card in pairs(ClubFinderGuildFinderFrame.GuildCards.Cards) do
		SkinCard(card)
	end

	for _, card in pairs(ClubFinderGuildFinderFrame.PendingGuildCards.Cards) do
		SkinCard(card)
	end

	for _, t in ipairs({ClubFinderGuildFinderFrame.RequestToJoinFrame, ClubFinderCommunityAndGuildFinderFrame.RequestToJoinFrame}) do
		t:StripTextures()
		t:CreateBackdrop("Transparent")

		hooksecurefunc(t, 'Initialize', function(self)
			for button in self.SpecsPool:EnumerateActive() do
				if button.CheckBox then
					T.SkinCheckBox(button.CheckBox)
					button.CheckBox:SetSize(26, 26)
				end
			end
		end)

		t.MessageFrame:StripTextures(true)
		t.MessageFrame.MessageScroll:StripTextures(true)

		t.MessageFrame.MessageScroll:CreateBackdrop("Overlay")
		t.MessageFrame.MessageScroll.backdrop:SetPoint("TOPLEFT", -4, 5)
		t.MessageFrame.MessageScroll.backdrop:SetPoint("BOTTOMRIGHT", 6, -6)

		t.Apply:SkinButton()
		t.Cancel:SkinButton()
	end

	-- Notification Settings
	local NotificationSettings = CommunitiesFrame.NotificationSettingsDialog
	NotificationSettings:StripTextures()
	NotificationSettings:SetTemplate("Transparent")

	T.SkinDropDownBox(CommunitiesFrame.NotificationSettingsDialog.CommunitiesListDropDownMenu, 190)
	CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.Child.QuickJoinButton:SetSize(25, 25)
	T.SkinCheckBox(CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.Child.QuickJoinButton)
	CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.Child.AllButton:SkinButton()
	CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.Child.NoneButton:SkinButton()
	CommunitiesFrame.NotificationSettingsDialog.OkayButton:SkinButton()
	CommunitiesFrame.NotificationSettingsDialog.CancelButton:SkinButton()

	hooksecurefunc(CommunitiesNotificationSettingsStreamEntryMixin, "SetFilter", function(self)
		self.ShowNotificationsButton:SetSize(18, 18)
		self.HideNotificationsButton:SetSize(18, 18)
		T.SkinCheckBox(self.ShowNotificationsButton)
		T.SkinCheckBox(self.HideNotificationsButton)
	end)

	local EditStreamDialog = CommunitiesFrame.EditStreamDialog
	EditStreamDialog:StripTextures()
	EditStreamDialog:SetTemplate("Transparent")

	EditStreamDialog.NameEdit:SetPoint("TOPLEFT", EditStreamDialog.NameLabel, "BOTTOMLEFT", 6, -5)
	EditStreamDialog.NameEdit:SetPoint("RIGHT", EditStreamDialog, "RIGHT", -34, 0)

	T.SkinEditBox(EditStreamDialog.NameEdit, nil, 18)
	T.SkinEditBox(EditStreamDialog.Description)
	T.SkinCheckBox(EditStreamDialog.TypeCheckBox)

	EditStreamDialog.Accept:SkinButton()
	EditStreamDialog.Delete:SkinButton()
	EditStreamDialog.Cancel:SkinButton()

	-- Communities Settings
	local Settings = CommunitiesSettingsDialog
	Settings.BG:Hide()
	Settings:SetTemplate("Transparent")

	Settings.IconPreview:RemoveMaskTexture(Settings.CircleMask)
	Settings.IconPreviewRing:Hide()
	Settings.IconPreview:SkinIcon(true)

	T.SkinEditBox(Settings.NameEdit)
	T.SkinEditBox(Settings.ShortNameEdit)
	T.SkinEditBox(Settings.Description)
	T.SkinEditBox(Settings.MessageOfTheDay)

	Settings.ChangeAvatarButton:SkinButton()
	Settings.Accept:SkinButton()
	Settings.Delete:SkinButton()
	Settings.Cancel:SkinButton()

	T.SkinDropDownBox(ClubFinderLanguageDropdown)

	-- Avatar Picker
	local Avatar = CommunitiesAvatarPickerDialog
	Avatar:StripTextures()
	Avatar:SetTemplate("Transparent")

	Avatar.ScrollFrame:StripTextures()

	Avatar.OkayButton:SkinButton()
	Avatar.CancelButton:SkinButton()

	-- Tab
	local function SkinTab(tab)
		for i = 1, tab:GetNumRegions() do
			local region = select(i, tab:GetRegions())
			if region:GetObjectType() == "Texture" then
				if region:GetTexture() == "Interface\\SpellBook\\SpellBook-SkillLineTab" then
					region:Kill()
				end
			end
		end

		tab:CreateBackdrop("Default")
		tab.backdrop:SetAllPoints()
		tab:StyleButton()
		tab.Icon:SetPoint("TOPLEFT", 2, -2)
		tab.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
		tab.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	SkinTab(CommunitiesFrame.ChatTab)
	SkinTab(CommunitiesFrame.RosterTab)
	SkinTab(CommunitiesFrame.GuildBenefitsTab)
	SkinTab(CommunitiesFrame.GuildInfoTab)
	SkinTab(ClubFinderGuildFinderFrame.ClubFinderSearchTab)
	SkinTab(ClubFinderGuildFinderFrame.ClubFinderPendingTab)
	SkinTab(ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab)
	SkinTab(ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab)

	-- Member List
	CommunitiesFrame.MemberList:StripTextures()
	CommunitiesFrame.MemberList.ColumnDisplay:StripTextures()
	CommunitiesFrame.MemberList.ShowOfflineButton:SetSize(25, 25)
	CommunitiesFrame.MemberList.ShowOfflineButton:SetPoint("BOTTOMLEFT", CommunitiesFrame.MemberList, "TOPLEFT", -3, 26)
	CommunitiesFrame.CommunitiesControlFrame.GuildRecruitmentButton:SkinButton()
	CommunitiesFrame.CommunitiesControlFrame.GuildControlButton:SkinButton()
	T.SkinCheckBox(CommunitiesFrame.MemberList.ShowOfflineButton)
	T.SkinDropDownBox(CommunitiesFrame.GuildMemberListDropDownMenu)

	hooksecurefunc(CommunitiesFrame.MemberList, "RefreshListDisplay", function(self)
		for i = 1, self.ColumnDisplay:GetNumChildren() do
			local child = select(i, self.ColumnDisplay:GetChildren())
			if not child.IsSkinned then
				child:StripTextures()
				child:CreateBackdrop("Overlay")
				child.backdrop:SetPoint("TOPLEFT", 2, -2)
				child.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)

				child.IsSkinned = true
			end
		end

		for _, button in ipairs(self.ListScrollFrame.buttons or {}) do
			if button and not button.hooked then
				hooksecurefunc(button, "RefreshExpandedColumns", function(self)
					if not self.expanded then return end

					local memberInfo = self:GetMemberInfo()
					if memberInfo and memberInfo.classID then
						local classInfo = C_CreatureInfo.GetClassInfo(memberInfo.classID)
						if classInfo then
							local texcoord = CLASS_ICON_TCOORDS[classInfo.classFile]
							self.Class:SetTexCoord(texcoord[1] + 0.015, texcoord[2] - 0.02, texcoord[3] + 0.018, texcoord[4] - 0.02)
						end
					end
				end)
				if button.ProfessionHeader then
					local header = button.ProfessionHeader
					for i = 1, 3 do
						select(i, header:GetRegions()):Hide()
					end
					header:CreateBackdrop("Overlay")
					header.backdrop:SetPoint("TOPLEFT", 1, -1)
					header.backdrop:SetPoint("BOTTOMRIGHT", -1, 1)
				end

				button.hooked = true
			end
			if button and button.bg then
				button.bg:SetShown(button.Class:IsShown())
			end
		end
	end)

	-- Member Detail Frame
	CommunitiesFrame.GuildMemberDetailFrame:StripTextures()
	CommunitiesFrame.GuildMemberDetailFrame:SetTemplate("Transparent")
	CommunitiesFrame.GuildMemberDetailFrame:ClearAllPoints()
	CommunitiesFrame.GuildMemberDetailFrame:SetPoint("TOPLEFT", CommunitiesFrame, "TOPRIGHT", 5, 2)
	CommunitiesFrame.GuildMemberDetailFrame.NoteBackground:SetTemplate("Overlay")
	CommunitiesFrame.GuildMemberDetailFrame.OfficerNoteBackground:SetTemplate("Overlay")
	T.SkinDropDownBox(CommunitiesFrame.GuildMemberDetailFrame.RankDropdown, 160)
	CommunitiesFrame.GuildMemberDetailFrame.RemoveButton:SkinButton()
	CommunitiesFrame.GuildMemberDetailFrame.GroupInviteButton:SkinButton()
	CommunitiesFrame.GuildMemberDetailFrame.RemoveButton:ClearAllPoints()
	CommunitiesFrame.GuildMemberDetailFrame.RemoveButton:SetPoint("BOTTOMLEFT", CommunitiesFrame.GuildMemberDetailFrame, "BOTTOMLEFT", 9, 4)

	-- Guild Perk
	CommunitiesFrame.GuildBenefitsFrame:StripTextures()
	CommunitiesFrame.GuildBenefitsFrame.Perks:StripTextures()
	CommunitiesFrame.GuildBenefitsFrame.Perks:CreateBackdrop("Overlay")
	CommunitiesFrame.GuildBenefitsFrame.Perks.backdrop:SetPoint("TOPLEFT", 4, -2)
	CommunitiesFrame.GuildBenefitsFrame.Perks.backdrop:SetPoint("BOTTOMRIGHT", -2, -2)

	local GuildFactionBar = CommunitiesFrame.GuildBenefitsFrame.FactionFrame.Bar
	GuildFactionBar:StripTextures()
	GuildFactionBar.Progress:SetTexture(C.media.texture)
	GuildFactionBar:CreateBackdrop("Overlay")
	GuildFactionBar.backdrop:SetPoint("TOPLEFT", GuildFactionBar.Progress, "TOPLEFT", -2, 2)
	GuildFactionBar.backdrop:SetPoint("BOTTOMRIGHT", GuildFactionBar, "BOTTOMRIGHT", 0, 0)

	for i = 1, 5 do
		local button = _G["CommunitiesFrameContainerButton"..i]

		button:StripTextures()

		if button.Icon then
			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.Icon:ClearAllPoints()
			button.Icon:SetPoint("TOPLEFT", 2, -3)
			button:CreateBackdrop("Default")
			button.backdrop:SetPoint("TOPLEFT", button.Icon, "TOPLEFT", -2, 2)
			button.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, "BOTTOMRIGHT", 2, -2)
			button.Icon:SetParent(button.backdrop)
		end
	end

	CommunitiesFrame.GuildBenefitsFrame.Rewards:StripTextures()
	CommunitiesFrame.GuildBenefitsFrame.Rewards:CreateBackdrop("Overlay")
	CommunitiesFrame.GuildBenefitsFrame.Rewards.backdrop:SetPoint("TOPLEFT", 2, -2)
	CommunitiesFrame.GuildBenefitsFrame.Rewards.backdrop:SetPoint("BOTTOMRIGHT", -2, -2)

	for _, button in pairs(CommunitiesFrame.GuildBenefitsFrame.Rewards.RewardsContainer.buttons) do
		button:StripTextures()

		if button.Icon then
			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.Icon:ClearAllPoints()
			button.Icon:SetPoint("TOPLEFT", 2, -3)
			button:CreateBackdrop("Default")
			button.backdrop:SetPoint("TOPLEFT", button.Icon, "TOPLEFT", -2, 2)
			button.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, "BOTTOMRIGHT", 2, -2)
			button.Icon:SetParent(button.backdrop)
			button.Lock:SetTexture("Interface\\GuildFrame\\GuildFrame")
			button.Lock:SetParent(button.backdrop)
		end
	end

	-- Guild Info
	CommunitiesFrameGuildDetailsFrame:StripTextures()
	CommunitiesFrameGuildDetailsFrameInfo:StripTextures()
	CommunitiesFrameGuildDetailsFrameNews:StripTextures()

	hooksecurefunc(CommunitiesFrameGuildDetailsFrameNewsContainer.ScrollBar, "SetPoint", function(self, point, anchor, attachTo, x, y)
		if anchor == CommunitiesFrameGuildDetailsFrameNewsContainer and x == 1 and y == 5 then
			self:SetPoint(point, anchor, attachTo, x, 8)
		end
	end)

	hooksecurefunc("GuildNewsButton_SetNews", function(button, news_id)
		local newsInfo = C_GuildInfo.GetGuildNewsInfo(news_id)
		if newsInfo then
			if button.header:IsShown() then
				button.header:SetAlpha(0)
			end
		end
	end)

	CommunitiesFrameGuildDetailsFrameNews.SetFiltersButton:GetRegions():SetFont(C.media.normal_font, 10, "")

	local backdrop1 = CreateFrame("Frame", nil, CommunitiesFrameGuildDetailsFrameInfo)
	backdrop1:SetTemplate("Overlay")
	backdrop1:SetFrameLevel(CommunitiesFrameGuildDetailsFrameInfo:GetFrameLevel() - 1)
	backdrop1:SetPoint("TOPLEFT", CommunitiesFrameGuildDetailsFrameInfo, "TOPLEFT", 2, -22)
	backdrop1:SetPoint("BOTTOMRIGHT", CommunitiesFrameGuildDetailsFrameInfo, "BOTTOMRIGHT", 0, 200)

	local backdrop2 = CreateFrame("Frame", nil, CommunitiesFrameGuildDetailsFrameInfo)
	backdrop2:SetTemplate("Overlay")
	backdrop2:SetFrameLevel(CommunitiesFrameGuildDetailsFrameInfo:GetFrameLevel() - 1)
	backdrop2:SetPoint("TOPLEFT", CommunitiesFrameGuildDetailsFrameInfo, "TOPLEFT", 2, -158)
	backdrop2:SetPoint("BOTTOMRIGHT", CommunitiesFrameGuildDetailsFrameInfo, "BOTTOMRIGHT", -8, 123)

	local backdrop3 = CreateFrame("Frame", nil, CommunitiesFrameGuildDetailsFrameInfo)
	backdrop3:SetTemplate("Overlay")
	backdrop3:SetFrameLevel(CommunitiesFrameGuildDetailsFrameInfo:GetFrameLevel() - 1)
	backdrop3:SetPoint("TOPLEFT", CommunitiesFrameGuildDetailsFrameInfo, "TOPLEFT", 2, -236)
	backdrop3:SetPoint("BOTTOMRIGHT", CommunitiesFrameGuildDetailsFrameInfo, "BOTTOMRIGHT", -8, -1)

	local backdrop4 = CreateFrame("Frame", nil, CommunitiesFrameGuildDetailsFrameInfo)
	backdrop4:SetTemplate("Overlay")
	backdrop4:SetFrameLevel(CommunitiesFrameGuildDetailsFrameInfo:GetFrameLevel() - 1)
	backdrop4:SetPoint("TOPLEFT", CommunitiesFrameGuildDetailsFrameInfo, "TOPLEFT", 591, -22)
	backdrop4:SetPoint("BOTTOMRIGHT", CommunitiesFrameGuildDetailsFrameInfo, "BOTTOMRIGHT", 20, -1)

	CommunitiesFrameGuildDetailsFrameInfoMOTDScrollFrameScrollBar:SetPoint("TOPLEFT", CommunitiesFrameGuildDetailsFrameInfoMOTDScrollFrame, "TOPRIGHT", 0, -12)
	CommunitiesFrameGuildDetailsFrameInfoMOTDScrollFrameScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrameGuildDetailsFrameInfoMOTDScrollFrame, "BOTTOMRIGHT", 0, 12)

	CommunitiesFrameGuildDetailsFrameInfoScrollBar:SetPoint("TOPLEFT", CommunitiesFrameGuildDetailsFrameInfo.DetailsFrame, "TOPRIGHT", 0, -12)
	CommunitiesFrameGuildDetailsFrameInfoScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrameGuildDetailsFrameInfo.DetailsFrame, "BOTTOMRIGHT", 0, 13)

	-- Guild Message EditBox
	CommunitiesGuildTextEditFrame:StripTextures()
	CommunitiesGuildTextEditFrame:SetTemplate("Transparent")
	CommunitiesGuildTextEditFrame.Container:SetTemplate("Overlay")
	CommunitiesGuildTextEditFrameAcceptButton:SkinButton()
	select(4, CommunitiesGuildTextEditFrame:GetChildren()):SkinButton()

	-- Guild Log
	CommunitiesGuildLogFrame:StripTextures()
	CommunitiesGuildLogFrame.Container:StripTextures()
	CommunitiesGuildLogFrame.Container:SetTemplate("Overlay")
	CommunitiesGuildLogFrame:SetTemplate("Transparent")
	select(3, CommunitiesGuildLogFrame:GetChildren()):SkinButton()
	CommunitiesFrame.GuildLogButton:SkinButton()
	CommunitiesFrame.GuildLogButton:SetPoint("BOTTOMLEFT", CommunitiesFrame, "BOTTOMLEFT", 196, 5)

	-- Filters Frame
	CommunitiesGuildNewsFiltersFrame:StripTextures()
	CommunitiesGuildNewsFiltersFrame:SetTemplate("Transparent")

	for i = 1, #CommunitiesGuildNewsFiltersFrame.GuildNewsFilterButtons do
		local checkbox = CommunitiesGuildNewsFiltersFrame.GuildNewsFilterButtons[i]
		T.SkinCheckBox(checkbox)
	end
end

T.SkinFuncs["Blizzard_Communities"] = LoadSkin
