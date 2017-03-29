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
		PVPRewardTooltip:SetTemplate("Transparent")
	end
end)

if C.skins.blizzard_frames ~= true then return end
local function LoadSkin()
	for i = 1, 4 do
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
		for i = 1, 4 do
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
	HonorFrame.RoleInset:StripTextures()
	T.SkinDropDownBox(HonorFrameTypeDropDown, 165)
	T.SkinScrollBar(HonorFrameSpecificFrameScrollBar)
	HonorFrameSpecificFrameScrollBar:SetPoint("TOPLEFT", HonorFrameSpecificFrame, "TOPRIGHT", 0, -15)
	HonorFrameSpecificFrameScrollBar:SetPoint("BOTTOMLEFT", HonorFrameSpecificFrame, "BOTTOMRIGHT", 0, 15)
	HonorFrameQueueButton:SkinButton(true)
	HonorFrame.BonusFrame:StripTextures()
	HonorFrame.BonusFrame.DiceButton:SkinButton()
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()

	HonorFrame.XPBar:StripTextures()
	HonorFrame.XPBar.Bar:CreateBackdrop("Default")

	HonorFrame.XPBar.Bar.Spark:SetAlpha(0)

	HonorFrame.XPBar.NextAvailable:ClearAllPoints()
	HonorFrame.XPBar.NextAvailable:SetPoint("LEFT", HonorFrame.XPBar.Bar, "RIGHT", -2, -2)

	HonorFrame.XPBar.NextAvailable:StripTextures()
	HonorFrame.XPBar.NextAvailable:CreateBackdrop("Default")
	HonorFrame.XPBar.NextAvailable.backdrop:SetPoint("TOPLEFT", HonorFrame.XPBar.NextAvailable.Icon, -2, 2)
	HonorFrame.XPBar.NextAvailable.backdrop:SetPoint("BOTTOMRIGHT", HonorFrame.XPBar.NextAvailable.Icon, 2, -2)

	HonorFrame.XPBar.NextAvailable.Icon:SetDrawLayer("ARTWORK")
	HonorFrame.XPBar.NextAvailable.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	HonorFrame.XPBar.NextAvailable.Icon.SetTexCoord = T.dummy
	HonorFrame.XPBar.NextAvailable.Icon:SetSize(18, 18)

	HonorFrame.BonusFrame.RandomBGButton.Reward:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton.Reward:SetTemplate("Default")
	HonorFrame.BonusFrame.RandomBGButton.Reward:SetSize(40, 40)
	HonorFrame.BonusFrame.RandomBGButton.Reward.Icon:SetAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.Reward.Icon:SetPoint("TOPLEFT", 2, -2)
	HonorFrame.BonusFrame.RandomBGButton.Reward.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
	HonorFrame.BonusFrame.RandomBGButton.Reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	HonorFrame.BonusFrame.Arena1Button.Reward:StripTextures()
	HonorFrame.BonusFrame.Arena1Button.Reward:SetTemplate("Default")
	HonorFrame.BonusFrame.Arena1Button.Reward:SetSize(40, 40)
	HonorFrame.BonusFrame.Arena1Button.Reward.Icon:SetAllPoints()
	HonorFrame.BonusFrame.Arena1Button.Reward.Icon:SetPoint("TOPLEFT", 2, -2)
	HonorFrame.BonusFrame.Arena1Button.Reward.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
	HonorFrame.BonusFrame.Arena1Button.Reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	for _, i in pairs({"RandomBGButton", "Arena1Button", "AshranButton", "BrawlButton"}) do
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
		button:SetSize(304, 38)
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

	for _, button in pairs{HonorFrame.RoleInset.TankIcon, HonorFrame.RoleInset.HealerIcon, HonorFrame.RoleInset.DPSIcon} do
		T.SkinCheckBox(button.checkButton)
	end

	-- ConquestFrame
	ConquestFrame:StripTextures()
	ConquestFrame.Inset:StripTextures()
	ConquestFrame.ShadowOverlay:StripTextures()

	ConquestFrame.XPBar:StripTextures()
	ConquestFrame.XPBar.Bar:CreateBackdrop("Default")

	ConquestFrame.XPBar.Bar.Spark:SetAlpha(0)

	ConquestFrame.XPBar.NextAvailable:ClearAllPoints()
	ConquestFrame.XPBar.NextAvailable:SetPoint("LEFT", ConquestFrame.XPBar.Bar, "RIGHT", -2, -2)

	ConquestFrame.XPBar.NextAvailable:StripTextures()
	ConquestFrame.XPBar.NextAvailable:CreateBackdrop("Default")
	ConquestFrame.XPBar.NextAvailable.backdrop:SetPoint("TOPLEFT", ConquestFrame.XPBar.NextAvailable.Icon, -2, 2)
	ConquestFrame.XPBar.NextAvailable.backdrop:SetPoint("BOTTOMRIGHT", ConquestFrame.XPBar.NextAvailable.Icon, 2, -2)

	ConquestFrame.XPBar.NextAvailable.Icon:SetDrawLayer("ARTWORK")
	ConquestFrame.XPBar.NextAvailable.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	ConquestFrame.XPBar.NextAvailable.Icon.SetTexCoord = T.dummy
	ConquestFrame.XPBar.NextAvailable.Icon:SetSize(18, 18)

	ConquestFrame.RoleInset:StripTextures()
	for _, button in pairs{ConquestFrame.RoleInset.TankIcon, ConquestFrame.RoleInset.HealerIcon, ConquestFrame.RoleInset.DPSIcon} do
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
	end

	ConquestFrame.Arena3v3:SetPoint("TOP", ConquestFrame.Arena2v2, "BOTTOM", 0, -3)

	ConquestJoinButton:SkinButton(true)

	-- WarGamesFrame
	WarGamesFrame:StripTextures()
	WarGamesFrame.RightInset:StripTextures()
	WarGameStartButton:SkinButton(true)
	T.SkinScrollBar(WarGamesFrameScrollFrameScrollBar)
	T.SkinScrollBar(WarGamesFrameInfoScrollFrameScrollBar)
	WarGamesFrameScrollFrameScrollBar:SetPoint("TOPLEFT", WarGamesFrameScrollFrame, "TOPRIGHT", 0, -15)
	WarGamesFrameScrollFrameScrollBar:SetPoint("BOTTOMLEFT", WarGamesFrameScrollFrame, "BOTTOMRIGHT", 0, 15)
	WarGamesFrameInfoScrollFrameScrollBar:StripTextures()
	WarGamesFrame.HorizontalBar:StripTextures()
	WarGamesFrameDescription:SetTextColor(1, 1, 1)
	WarGamesFrameDescription:SetFont(C.media.normal_font, 13)
	WarGamesFrameDescription:SetShadowOffset(1, -1)
	T.SkinCheckBox(WarGameTournamentModeCheckButton)

	for _, i in pairs(WarGamesFrame.scrollFrame.buttons) do
		local button = i.Entry
		button:SetSize(306, 38)
		button:StripTextures()
		button:SetTemplate("Overlay")
		button:StyleButton()
		button.SelectedTexture:SetDrawLayer("ARTWORK")
		button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.3)
		button.SelectedTexture:SetPoint("TOPLEFT", 2, -2)
		button.SelectedTexture:SetPoint("BOTTOMRIGHT", -2, 2)
	end
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
