local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Communities skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	CommunitiesFrame:StripTextures()
	CommunitiesFrame.PortraitOverlay:Kill()
	CommunitiesFrame.PortraitOverlay.Portrait:Hide()
	CommunitiesFrame.PortraitOverlay.PortraitFrame:Hide()
	CommunitiesFrame.CommunitiesList.InsetFrame:StripTextures()
	CommunitiesFrame.TopBorder:Hide()
	CommunitiesFrame.LeftBorder:Hide()
	CommunitiesFrame.TopLeftCorner:Hide()

	CommunitiesFrame:CreateBackdrop("Transparent")

	CommunitiesFrame.MaximizeMinimizeFrame:StripTextures()

	-- Notification Settings Dialog
	local NotificationSettings = CommunitiesFrame.NotificationSettingsDialog
	NotificationSettings:StripTextures()
	NotificationSettings:CreateBackdrop("Transparent")
	NotificationSettings.backdrop:SetAllPoints()

	CommunitiesFrameCommunitiesList.FilligreeOverlay:Hide()
	CommunitiesFrameCommunitiesList.Bg:Hide()
	CommunitiesFrameCommunitiesList.TopFiligree:Hide()
	CommunitiesFrameCommunitiesList.BottomFiligree:Hide()
	CommunitiesFrameTopTileStreaks:Hide()
	CommunitiesFrameCommunitiesListListScrollFrame:StripTextures()
	CommunitiesFrameInsetBg:Hide()
	CommunitiesFrameInsetInsetBottomBorder:Hide()
	CommunitiesFrameInsetInsetLeftBorder:Hide()
	CommunitiesFrameInsetInsetBotLeftCorner:Hide()
	CommunitiesFrameInsetInsetBotRightCorner:Hide()
	CommunitiesFrameInsetInsetRightBorder:Hide()
	CommunitiesFrameInsetInsetLeftBorder:Hide()
	CommunitiesFrameInsetInsetTopBorder:Hide()
	CommunitiesFrameInsetInsetTopLeftCorner:Hide()
	CommunitiesFrameInsetInsetTopRightCorner:Hide()
	CommunitiesFrameCommunitiesListInsetBottomBorder:Hide()
	CommunitiesFrameCommunitiesListInsetBotRightCorner:Hide()
	CommunitiesFrameCommunitiesListInsetRightBorder:Hide()
	CommunitiesFrameInsetBottomBorder:Hide()
	CommunitiesFrameInsetLeftBorder:Hide()
	CommunitiesFrameInsetRightBorder:Hide()
	CommunitiesFrameInsetTopRightCorner:Hide()
	CommunitiesFrameInsetTopLeftCorner:Hide()
	CommunitiesFrameInsetTopBorder:Hide()
	CommunitiesFrameInsetBotRightCorner:Hide()
	CommunitiesFrameInsetBotLeftCorner:Hide()

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

	CommunitiesFrame.MaximizeMinimizeFrame:StripTextures()
	CommunitiesFrame.MaximizeMinimizeFrame:SetSize(18, 18)
	CommunitiesFrame.MaximizeMinimizeFrame:SetPoint("RIGHT", CommunitiesFrameCloseButton, "LEFT", -2, 0)

	local MaximizeButton = CommunitiesFrame.MaximizeMinimizeFrame.MaximizeButton
	MaximizeButton:StripTextures()
	MaximizeButton:SetTemplate("Overlay")
	MaximizeButton:SetHitRectInsets(1, 1, 1, 1)

	MaximizeButton.minus = MaximizeButton:CreateTexture(nil, "OVERLAY")
	MaximizeButton.minus:SetSize(7, 1)
	MaximizeButton.minus:SetPoint("CENTER")
	MaximizeButton.minus:SetTexture(C.media.blank)

	MaximizeButton.plus = MaximizeButton:CreateTexture(nil, "OVERLAY")
	MaximizeButton.plus:SetSize(1, 7)
	MaximizeButton.plus:SetPoint("CENTER")
	MaximizeButton.plus:SetTexture(C.media.blank)

	MaximizeButton:HookScript("OnEnter", T.SetModifiedBackdrop)
	MaximizeButton:HookScript("OnLeave", T.SetOriginalBackdrop)

	local MinimizeButton = CommunitiesFrame.MaximizeMinimizeFrame.MinimizeButton
	MinimizeButton:StripTextures()
	MinimizeButton:SetTemplate("Overlay")
	MinimizeButton:SetHitRectInsets(1, 1, 1, 1)

	MinimizeButton.minus = MinimizeButton:CreateTexture(nil, "OVERLAY")
	MinimizeButton.minus:SetSize(7, 1)
	MinimizeButton.minus:SetPoint("CENTER")
	MinimizeButton.minus:SetTexture(C.media.blank)

	MinimizeButton:HookScript("OnEnter", T.SetModifiedBackdrop)
	MinimizeButton:HookScript("OnLeave", T.SetOriginalBackdrop)

	T.SkinDropDownBox(CommunitiesFrame.StreamDropDownMenu)
	T.SkinDropDownBox(CommunitiesFrame.CommunitiesListDropDownMenu)

	CommunitiesFrame.InviteButton:SkinButton()
end

T.SkinFuncs["Blizzard_Communities"] = LoadSkin