local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

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

	-- HonorFrame
	HonorFrame.Inset:StripTextures()
	HonorFrame.BonusFrame:StripTextures()
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()

	T.SkinDropDownBox(HonorFrameTypeDropDown, 165)
	HonorFrameTypeDropDown:SetPoint("BOTTOMRIGHT", HonorFrame.Inset, "TOPRIGHT", -6, -1)
	T.SkinScrollBar(HonorFrameSpecificFrameScrollBar)
	HonorFrameSpecificFrameScrollBar:SetPoint("TOPLEFT", HonorFrameSpecificFrame, "TOPRIGHT", 0, -15)
	HonorFrameSpecificFrameScrollBar:SetPoint("BOTTOMLEFT", HonorFrameSpecificFrame, "BOTTOMRIGHT", 0, 15)
	HonorFrameQueueButton:SkinButton(true)

	PremadeGroupsPvPTutorialAlert:StripTextures()
	PremadeGroupsPvPTutorialAlert:SetTemplate("Transparent")
	PremadeGroupsPvPTutorialAlert.Arrow:Hide()
	T.SkinCloseButton(PremadeGroupsPvPTutorialAlert.CloseButton)

	T.SkinHelpBox(HonorFrame.BonusFrame.BrawlHelpBox)

	PVPQueueFrame.HonorInset:StripTextures()
	PVPQueueFrame.HonorInset.RatedPanel.Label:SetWidth(160)

	local RewardFrameSeason = PVPQueueFrame.HonorInset.RatedPanel.SeasonRewardFrame
	RewardFrameSeason.Ring:Hide()
	RewardFrameSeason.CircleMask:Hide()
	RewardFrameSeason.Icon:SkinIcon()

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

		local reward = button.Reward
		reward:StripTextures()
		reward:SetTemplate("Default")
		reward:SetSize(40, 40)
		reward:SetPoint("RIGHT", button, "RIGHT", -8, 0)

		reward.Icon:SetAllPoints()
		reward.Icon:SetPoint("TOPLEFT", 2, -2)
		reward.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
		reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		reward.EnlistmentBonus:StripTextures()
		reward.EnlistmentBonus:SetTemplate("Default")
		reward.EnlistmentBonus:SetSize(20, 20)
		reward.EnlistmentBonus:SetPoint("TOPRIGHT", 2, 2)

		local EnlistmentBonusIcon = reward.EnlistmentBonus:CreateTexture(nil, nil, self)
		EnlistmentBonusIcon:SetPoint("TOPLEFT", reward.EnlistmentBonus, "TOPLEFT", 2, -2)
		EnlistmentBonusIcon:SetPoint("BOTTOMRIGHT", reward.EnlistmentBonus, "BOTTOMRIGHT", -2, 2)
		EnlistmentBonusIcon:SetTexture("Interface\\Icons\\achievement_guildperk_honorablemention_rank2")
		EnlistmentBonusIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
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

	local checkButtons = {
		HonorFrame.TankIcon,
		HonorFrame.HealerIcon,
		HonorFrame.DPSIcon,
		ConquestFrame.TankIcon,
		ConquestFrame.HealerIcon,
		ConquestFrame.DPSIcon
	}

	for i = 1, #checkButtons do
		local button = checkButtons[i].checkButton
		button:SetSize(22, 22)
		T.SkinCheckBox(button)
	end

	for _, bar in pairs({HonorFrame.ConquestBar, ConquestFrame.ConquestBar}) do
		bar:StripTextures()
		bar:CreateBackdrop("Overlay")
		bar:SetStatusBarTexture(C.media.texture)
		bar:SetFrameLevel(bar:GetFrameLevel() + 2)

		bar.Reward:ClearAllPoints()
		bar.Reward:SetPoint("LEFT", bar, "RIGHT", -1, 0)

		bar.Reward.Ring:Hide()
		bar.Reward.CircleMask:Hide()

		bar.Reward:StripTextures()
		bar.Reward.Icon:SkinIcon()
		bar.Reward.Icon:SetSize(20, 20)

		local faction = UnitFactionGroup("player") == "Horde" and [[Interface\Icons\UI_Horde_HonorboundMedal]] or [[Interface\Icons\UI_Alliance_7LegionMedal]]
		hooksecurefunc(bar.Reward, "SetTexture", function(self, texture)
			if not texture then
				self.Icon:SetTexture(faction)
			end
		end)
		bar:SetStatusBarColor(unpack(UnitFactionGroup("player") == "Horde" and {0.8, 0.2, 0.2} or {0.2, 0.2, 0.8}))
	end

	-- ConquestFrame
	ConquestFrame:StripTextures()
	ConquestFrame.Inset:StripTextures()
	ConquestFrame.ShadowOverlay:StripTextures()

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
	end

	ConquestFrame.Arena3v3:SetPoint("TOP", ConquestFrame.Arena2v2, "BOTTOM", 0, -3)

	ConquestJoinButton:SkinButton(true)

	local NewSeasonPopup = PVPQueueFrame.NewSeasonPopup
	NewSeasonPopup:StripTextures()
	NewSeasonPopup:CreateBackdrop("Overlay")
	NewSeasonPopup.backdrop:SetPoint("TOPLEFT", 10, -10)
	NewSeasonPopup.backdrop:SetPoint("BOTTOMRIGHT", -10, 10)
	NewSeasonPopup:SetFrameLevel(5)
	NewSeasonPopup.NewSeason:SetTextColor(1, 0.8, 0)
	NewSeasonPopup.NewSeason:SetShadowOffset(1, -1)
	NewSeasonPopup.SeasonDescription:SetTextColor(1, 1, 1)
	NewSeasonPopup.SeasonDescription:SetShadowOffset(1, -1)
	NewSeasonPopup.SeasonDescription2:SetTextColor(1, 1, 1)
	NewSeasonPopup.SeasonDescription2:SetShadowOffset(1, -1)

	local RewardFrame = SeasonRewardFrame
	RewardFrame.Ring:Hide()
	RewardFrame.CircleMask:Hide()
	RewardFrame.Icon:SkinIcon()
	select(3, RewardFrame:GetRegions()):SetTextColor(1, 1, 1)
	select(3, RewardFrame:GetRegions()):SetShadowOffset(1, -1)

	NewSeasonPopup.Leave:SkinButton()
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