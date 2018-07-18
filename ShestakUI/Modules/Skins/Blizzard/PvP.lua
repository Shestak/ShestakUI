local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	PvP skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "Blizzard_PVPUI" then
		ConquestTooltip:SetTemplate("Transparent")
		--BETA PVPRewardTooltip:SetTemplate("Transparent")
		-- PVPRewardTooltip.ItemTooltip.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		-- PVPRewardTooltip.ItemTooltip.IconBorder:SetAlpha(0)
		-- PVPRewardTooltip.ItemTooltip:CreateBackdrop("Default")
		-- PVPRewardTooltip.ItemTooltip.backdrop:SetPoint("TOPLEFT", PVPRewardTooltip.ItemTooltip.Icon, "TOPLEFT", -2, 2)
		-- PVPRewardTooltip.ItemTooltip.backdrop:SetPoint("BOTTOMRIGHT", PVPRewardTooltip.ItemTooltip.Icon, "BOTTOMRIGHT", 2, -2)
	end
end)

if C.skins.blizzard_frames ~= true then return end
local function LoadSkin()
	for i = 1, 3 do
		local button = _G["PVPQueueFrameCategoryButton"..i]
		button.Ring:Kill()
		button:CreateBackdrop("Overlay")
		button.backdrop:SetAllPoints()
		button:StyleButton()
		button.Background:Kill()
		button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.Icon:SetPoint("LEFT", button, "LEFT", 10, 0)
		button.Icon:SetDrawLayer("OVERLAY")
		button.Icon:SetSize(40, 40)
		button.border = CreateFrame("Frame", nil, button)
		button.border:CreateBackdrop("Default")
		button.border.backdrop:SetPoint("TOPLEFT", button.Icon, -2, 2)
		button.border.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, 2, -2)
	end

	hooksecurefunc("PVPQueueFrame_SelectButton", function(index)
		local self = PVPQueueFrame
		for i = 1, 3 do
			local button = self["CategoryButton"..i]
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

	for i = 1, PVPQueueFrame.HonorInset:GetNumRegions()  do
		select(i, PVPQueueFrame.HonorInset:GetRegions()):Hide()
	end

	-- HonorFrame
	HonorFrame.Inset:StripTextures()
	-- HonorFrame.RoleInset:StripTextures()
	T.SkinDropDownBox(HonorFrameTypeDropDown, 165)
	T.SkinScrollBar(HonorFrameSpecificFrameScrollBar)
	HonorFrameSpecificFrameScrollBar:SetPoint("TOPLEFT", HonorFrameSpecificFrame, "TOPRIGHT", 0, -15)
	HonorFrameSpecificFrameScrollBar:SetPoint("BOTTOMLEFT", HonorFrameSpecificFrame, "BOTTOMRIGHT", 0, 15)
	HonorFrameQueueButton:SkinButton(true)
	HonorFrame.BonusFrame:StripTextures()
	--BETA HonorFrame.BonusFrame.DiceButton:SkinButton()
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()

	HonorFrame.ConquestBar:StripTextures()
	HonorFrame.ConquestBar:CreateBackdrop("Default")
	HonorFrame.ConquestBar:SetStatusBarTexture(C.media.texture)
	HonorFrame.ConquestBar:SetFrameLevel(HonorFrame.ConquestBar:GetFrameLevel() + 2)

	HonorFrame.ConquestBar.Reward:ClearAllPoints()
	HonorFrame.ConquestBar.Reward:SetPoint("LEFT", HonorFrame.ConquestBar, "RIGHT", -1, 0)

	HonorFrame.ConquestBar.Reward:StripTextures()
	HonorFrame.ConquestBar.Reward:CreateBackdrop("Default")
	HonorFrame.ConquestBar.Reward.backdrop:SetPoint("TOPLEFT", HonorFrame.ConquestBar.Reward.Icon, -2, 2)
	HonorFrame.ConquestBar.Reward.backdrop:SetPoint("BOTTOMRIGHT", HonorFrame.ConquestBar.Reward.Icon, 2, -2)

	HonorFrame.ConquestBar.Reward.Ring:Hide()
	HonorFrame.ConquestBar.Reward.CircleMask:Hide()
	HonorFrame.ConquestBar.Reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	HonorFrame.ConquestBar.Reward.Icon:SetSize(20, 20)

	for _, button in pairs({HonorFrame.BonusFrame.RandomBGButton, HonorFrame.BonusFrame.RandomEpicBGButton, HonorFrame.BonusFrame.Arena1Button, HonorFrame.BonusFrame.BrawlButton}) do
		button.Reward:StripTextures()
		button.Reward:SetTemplate("Default")
		button.Reward:SetSize(40, 40)
		button.Reward:SetPoint("RIGHT", button, "RIGHT", -8, 0)

		button.Reward.Icon:SetAllPoints()
		button.Reward.Icon:SetPoint("TOPLEFT", 2, -2)
		button.Reward.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
		button.Reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		button.Reward.EnlistmentBonus:StripTextures()
		button.Reward.EnlistmentBonus:SetTemplate("Default")
		button.Reward.EnlistmentBonus:SetSize(20, 20)
		button.Reward.EnlistmentBonus:SetPoint("TOPRIGHT", 2, 2)

		local EnlistmentBonusIcon = button.Reward.EnlistmentBonus:CreateTexture(nil, nil, self)
		EnlistmentBonusIcon:SetPoint("TOPLEFT", button.Reward.EnlistmentBonus, "TOPLEFT", 2, -2)
		EnlistmentBonusIcon:SetPoint("BOTTOMRIGHT", button.Reward.EnlistmentBonus, "BOTTOMRIGHT", -2, 2)
		EnlistmentBonusIcon:SetTexture("Interface\\Icons\\achievement_guildperk_honorablemention_rank2")
		EnlistmentBonusIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	T.SkinCloseButton(PremadeGroupsPvPTutorialAlert.CloseButton)
	PremadeGroupsPvPTutorialAlert.Arrow:Hide()
	PremadeGroupsPvPTutorialAlert:StripTextures()
	PremadeGroupsPvPTutorialAlert:CreateBackdrop("Transparent")

	T.SkinCloseButton(HonorFrame.BonusFrame.BrawlHelpBox.CloseButton)
	HonorFrame.BonusFrame.BrawlHelpBox:StripTextures()
	HonorFrame.BonusFrame.BrawlHelpBox:CreateBackdrop("Transparent")

	for _, i in pairs({"RandomBGButton", "RandomEpicBGButton", "Arena1Button", "BrawlButton"}) do
		local button = HonorFrame.BonusFrame[i]
		button:StripTextures()
		button:SetTemplate("Overlay")
		button:StyleButton()
		button.SelectedTexture:SetDrawLayer("ARTWORK")
		button.SelectedTexture:ClearAllPoints()
		button.SelectedTexture:SetAllPoints()
		button.SelectedTexture:SetPoint("TOPLEFT", 2, -2)
		button.SelectedTexture:SetPoint("BOTTOMRIGHT", -2, 2)
		button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.3)
	end

	for i = 1, #HonorFrame.SpecificFrame.buttons do
		local button = HonorFrame.SpecificFrame.buttons[i]
		button:SetSize(368, 38)
		button:StripTextures()
		button:SetTemplate("Overlay")
		button:StyleButton()
		button.SelectedTexture:SetDrawLayer("ARTWORK")
		button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.3)
		button.SelectedTexture:SetPoint("TOPLEFT", 2, -2)
		button.SelectedTexture:SetPoint("BOTTOMRIGHT", -2, 2)
		if i == 1 then
			button:SetPoint("TOPLEFT", HonorFrameSpecificFrameScrollChild, "TOPLEFT", 0, -1)
		else
			button:SetPoint("TOPLEFT", HonorFrame.SpecificFrame.buttons[i-1], "BOTTOMLEFT", 0, -2)
		end
	end

	for _, button in pairs{HonorFrame.TankIcon, HonorFrame.HealerIcon, HonorFrame.DPSIcon} do
		T.SkinCheckBox(button.checkButton)
	end

	-- ConquestFrame
	ConquestFrame:StripTextures()
	ConquestFrame.Inset:StripTextures()
	ConquestFrame.ShadowOverlay:StripTextures()

	ConquestFrame.ConquestBar:StripTextures()
	ConquestFrame.ConquestBar:CreateBackdrop("Default")
	ConquestFrame.ConquestBar:SetStatusBarTexture(C.media.texture)
	ConquestFrame.ConquestBar:SetFrameLevel(ConquestFrame.ConquestBar:GetFrameLevel() + 2)

	ConquestFrame.ConquestBar.Reward:ClearAllPoints()
	ConquestFrame.ConquestBar.Reward:SetPoint("LEFT", ConquestFrame.ConquestBar, "RIGHT", -1, 0)

	ConquestFrame.ConquestBar.Reward:StripTextures()
	ConquestFrame.ConquestBar.Reward:CreateBackdrop("Default")
	ConquestFrame.ConquestBar.Reward.backdrop:SetPoint("TOPLEFT", ConquestFrame.ConquestBar.Reward.Icon, -2, 2)
	ConquestFrame.ConquestBar.Reward.backdrop:SetPoint("BOTTOMRIGHT", ConquestFrame.ConquestBar.Reward.Icon, 2, -2)

	ConquestFrame.ConquestBar.Reward.Ring:Hide()
	ConquestFrame.ConquestBar.Reward.CircleMask:Hide()
	ConquestFrame.ConquestBar.Reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	ConquestFrame.ConquestBar.Reward.Icon:SetSize(20, 20)

	-- ConquestFrame.RoleInset:StripTextures()
	for _, button in pairs{ConquestFrame.TankIcon, ConquestFrame.HealerIcon, ConquestFrame.DPSIcon} do
		T.SkinCheckBox(button.checkButton)
	end

	for _, button in pairs({ConquestFrame.Arena2v2, ConquestFrame.Arena3v3, ConquestFrame.RatedBG}) do
		button:StripTextures()
		button:SetTemplate("Overlay")
		button:StyleButton()
		button.SelectedTexture:SetDrawLayer("ARTWORK")
		button.SelectedTexture:ClearAllPoints()
		button.SelectedTexture:SetAllPoints()
		button.SelectedTexture:SetPoint("TOPLEFT", 2, -2)
		button.SelectedTexture:SetPoint("BOTTOMRIGHT", -2, 2)
		button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.3)

		button.Reward:StripTextures()
		button.Reward:SetTemplate("Default")
		button.Reward:SetSize(35, 35)
		button.Reward:SetPoint("RIGHT", button, "RIGHT", -7, -1)

		button.Reward.Icon:SetAllPoints()
		button.Reward.Icon:SetPoint("TOPLEFT", 2, -2)
		button.Reward.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
		button.Reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		--BETA button.Reward.WeeklyBonus:StripTextures()
		-- button.Reward.WeeklyBonus:SetTemplate("Default")
		-- button.Reward.WeeklyBonus:SetSize(20, 20)
		-- button.Reward.WeeklyBonus:SetPoint("TOPRIGHT", 2, 2)

		-- local WeeklyBonusIcon = button.Reward.WeeklyBonus:CreateTexture(nil, nil, self)
		-- WeeklyBonusIcon:SetPoint("TOPLEFT", button.Reward.WeeklyBonus, "TOPLEFT", 2, -2)
		-- WeeklyBonusIcon:SetPoint("BOTTOMRIGHT", button.Reward.WeeklyBonus, "BOTTOMRIGHT", -2, 2)
		-- WeeklyBonusIcon:SetTexture("Interface\\Icons\\ability_skyreach_flash_bang")
		-- WeeklyBonusIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	ConquestFrame.Arena3v3:SetPoint("TOP", ConquestFrame.Arena2v2, "BOTTOM", 0, -3)

	ConquestJoinButton:SkinButton(true)

	-- WarGamesFrame
	--BETA WarGamesFrame:StripTextures()
	-- WarGamesFrame.RightInset:StripTextures()
	-- WarGameStartButton:SkinButton(true)
	-- T.SkinScrollBar(WarGamesFrameScrollFrameScrollBar)
	-- T.SkinScrollBar(WarGamesFrameInfoScrollFrameScrollBar)
	-- WarGamesFrameScrollFrameScrollBar:SetPoint("TOPLEFT", WarGamesFrameScrollFrame, "TOPRIGHT", 0, -15)
	-- WarGamesFrameScrollFrameScrollBar:SetPoint("BOTTOMLEFT", WarGamesFrameScrollFrame, "BOTTOMRIGHT", 0, 15)
	-- WarGamesFrameInfoScrollFrameScrollBar:StripTextures()
	-- WarGamesFrame.HorizontalBar:StripTextures()
	-- WarGamesFrameDescription:SetTextColor(1, 1, 1)
	-- WarGamesFrameDescription:SetFont(C.media.normal_font, 13)
	-- WarGamesFrameDescription:SetShadowOffset(1, -1)
	-- T.SkinCheckBox(WarGameTournamentModeCheckButton)

	-- for _, i in pairs(WarGamesFrame.scrollFrame.buttons) do
		-- local button = i.Entry
		-- button:SetSize(306, 38)
		-- button:StripTextures()
		-- button:SetTemplate("Overlay")
		-- button:StyleButton()
		-- button.SelectedTexture:SetDrawLayer("ARTWORK")
		-- button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.3)
		-- button.SelectedTexture:SetPoint("TOPLEFT", 2, -2)
		-- button.SelectedTexture:SetPoint("BOTTOMRIGHT", -2, 2)
	-- end
end

T.SkinFuncs["Blizzard_PVPUI"] = LoadSkin

local function LoadSecondarySkin()
	-- PvP Ready Dialog
	PVPReadyDialog:StripTextures()
	PVPReadyDialog:SetTemplate("Transparent")
	PVPReadyDialogBackground:SetAlpha(0)
	PVPReadyDialogEnterBattleButton:SkinButton()
	PVPReadyDialogLeaveQueueButton:SkinButton()
	T.SkinCloseButton(PVPReadyDialogCloseButton, PVPReadyDialog, "-")
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSecondarySkin)
