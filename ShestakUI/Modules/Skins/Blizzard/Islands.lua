local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Islands skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, _, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "Blizzard_IslandsQueueUI" then
		local tt = IslandsQueueFrame.WeeklyQuest.QuestReward.Tooltip
		tt:SetTemplate("Transparent")
		tt.ItemTooltip.Icon:SkinIcon()
		tt.ItemTooltip.IconBorder:SetAlpha(0)
	end
end)

if C.skins.blizzard_frames ~= true then return end

local function LoadSkin()
	IslandsQueueFrame:StripTextures()
	IslandsQueueFrame:SetTemplate("Transparent")

	IslandsQueueFrame.ArtOverlayFrame:SetAlpha(0)
	IslandsQueueFrame.TitleBanner.Banner:SetAlpha(0)

	IslandsQueueFrame.HelpButton.Ring:Hide()
	IslandsQueueFrame.HelpButton:SetPoint("TOPLEFT", IslandsQueueFrame, "TOPLEFT", -12, 12)

	IslandsQueueFrame.DifficultySelectorFrame.Background:Hide()
	IslandsQueueFrame.DifficultySelectorFrame:SetPoint("BOTTOM", 0, -15)
	IslandsQueueFrame.DifficultySelectorFrame.QueueButton:SkinButton()

	T.SkinCloseButton(IslandsQueueFrameCloseButton)

	-- StatusBar
	IslandsQueueFrame.WeeklyQuest.OverlayFrame:StripTextures()
	IslandsQueueFrame.WeeklyQuest.StatusBar:CreateBackdrop("Overlay")

	local reward = IslandsQueueFrame.WeeklyQuest.QuestReward
	reward:ClearAllPoints()
	reward:SetPoint("LEFT", IslandsQueueFrame.WeeklyQuest.StatusBar, "RIGHT", -3, 0)
	reward.CircleMask:Hide()
	reward:StripTextures()
	reward.Icon:SkinIcon()
	reward.Icon:SetSize(19, 19)

	-- TutorialFrame
	IslandsQueueFrame.TutorialFrame:StripTextures()
	IslandsQueueFrame.TutorialFrame:SetTemplate("Transparent")
	IslandsQueueFrame.TutorialFrame:SetPoint("TOPLEFT", 300, -150)
	IslandsQueueFrame.TutorialFrame:SetPoint("BOTTOMRIGHT", -300, 170)
	IslandsQueueFrame.TutorialFrame.TutorialText:SetTextColor(1, 1, 1)

	local TutorialIcon = IslandsQueueFrame.TutorialFrame:CreateTexture(nil, "BORDER")
	TutorialIcon:SetTexture([[Interface\Icons\INV_Glowing Azerite Spire]])
	TutorialIcon:SetSize(64, 64)
	TutorialIcon:SetPoint("TOP", IslandsQueueFrame.TutorialFrame, "TOP", 0, -10)
	TutorialIcon:SkinIcon(true)
	IslandsQueueFrame.TutorialFrame.Leave:SkinButton()
	T.SkinCloseButton(IslandsQueueFrame.TutorialFrame.CloseButton)
end

T.SkinFuncs["Blizzard_IslandsQueueUI"] = LoadSkin

local function LoadSecondarySkin()
	IslandsPartyPoseFrame:StripTextures()
	IslandsPartyPoseFrame:CreateBackdrop("Transparent")
	IslandsPartyPoseFrame.LeaveButton:SkinButton()
end

T.SkinFuncs["Blizzard_IslandsPartyPoseUI"] = LoadSecondarySkin