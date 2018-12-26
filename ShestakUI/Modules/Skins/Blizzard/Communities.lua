local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Communities skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	CommunitiesFrame:StripTextures()
	CommunitiesFrame:CreateBackdrop("Transparent")
	CommunitiesFrame.NineSlice:Hide()
	CommunitiesFrame.PortraitOverlay:Kill()
	CommunitiesFrame.PortraitOverlay.Portrait:Hide()
	CommunitiesFrameCommunitiesList.FilligreeOverlay:Hide()

	CommunitiesFrame.MemberList.InsetFrame.NineSlice:Hide()
	CommunitiesFrame.MemberList:SetPoint("BOTTOMRIGHT", CommunitiesFrame, "BOTTOMRIGHT", -26, 31)

	CommunitiesFrame.Chat.InsetFrame.NineSlice:Hide()
	CommunitiesFrame.Chat.InsetFrame:SetTemplate("Overlay")

	T.SkinScrollBar(CommunitiesFrameCommunitiesListListScrollFrame.ScrollBar)
	T.SkinScrollBar(CommunitiesFrame.Chat.MessageFrame.ScrollBar)
	T.SkinScrollBar(CommunitiesFrame.MemberList.ListScrollFrame.scrollBar)

	T.SkinEditBox(CommunitiesFrame.ChatEditBox, nil, 18)

	hooksecurefunc(CommunitiesListEntryMixin, "SetClubInfo", function(self, clubInfo)
		if clubInfo then
			self:SetSize(166, 67)
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

	hooksecurefunc(CommunitiesListEntryMixin, "SetAddCommunity", function(self)
		self:SetSize(166, 67)
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

		local highlight = self:GetHighlightTexture()
		highlight:SetColorTexture(1, 1, 1, 0.3)
		highlight:SetInside(self.bg, 0, 0)
	end)

	CommunitiesFrame.MemberList.ShowOfflineButton:SetSize(25, 25)

	T.SkinCheckBox(CommunitiesFrame.MemberList.ShowOfflineButton)
	T.SkinDropDownBox(CommunitiesFrame.GuildMemberListDropDownMenu)

	CommunitiesFrame.CommunitiesControlFrame.GuildRecruitmentButton:SkinButton()
	CommunitiesFrame.GuildLogButton:SkinButton()
	T.SkinScrollBar(CommunitiesFrameRewards.scrollBar)
	T.SkinScrollBar(CommunitiesFrameGuildDetailsFrameNewsContainer.ScrollBar)

	-- Notification Settings Dialog
	local NotificationSettings = CommunitiesFrame.NotificationSettingsDialog
	NotificationSettings:StripTextures()
	NotificationSettings:CreateBackdrop("Transparent")
	NotificationSettings.backdrop:SetAllPoints()

	CommunitiesFrameCommunitiesList:StripTextures()
	CommunitiesFrameCommunitiesListListScrollFrame:StripTextures()

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

	CommunitiesFrame.ChatTab:SetPoint("TOPLEFT", CommunitiesFrame, "TOPRIGHT", 5, -36)

	T.SkinCloseButton(CommunitiesFrameCloseButton)

	T.SkinMaxMinFrame(CommunitiesFrame.MaximizeMinimizeFrame, CommunitiesFrameCloseButton)

	CommunitiesFrame.InviteButton:SkinButton()
end

T.SkinFuncs["Blizzard_Communities"] = LoadSkin