local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Adventure Map skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	AdventureMapQuestChoiceDialog:StripTextures()
	AdventureMapQuestChoiceDialog:CreateBackdrop("Transparent")
	AdventureMapQuestChoiceDialog.backdrop:SetFrameStrata("LOW")

	local function SkinRewards()
		for reward in pairs(AdventureMapQuestChoiceDialog.rewardPool.activeObjects) do
			if not reward.isSkinned then
				reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				reward.ItemNameBG:Hide()
				reward:CreateBackdrop("Default")
				reward.backdrop:ClearAllPoints()
				reward.backdrop:SetPoint("TOPLEFT", reward.Icon, -2, 2)
				reward.backdrop:SetPoint("BOTTOMRIGHT", reward.Icon, 2, -2)
				reward.isSkinned = true
			end
		end
	end
	hooksecurefunc(AdventureMapQuestChoiceDialog, "RefreshRewards", SkinRewards)

	AdventureMapQuestChoiceDialog.Details.Child.TitleHeader:SetTextColor(1, 1, 0)
	AdventureMapQuestChoiceDialog.Details.Child.DescriptionText:SetTextColor(1, 1, 1)
	AdventureMapQuestChoiceDialog.Details.Child.ObjectivesHeader:SetTextColor(1, 1, 0)
	AdventureMapQuestChoiceDialog.Details.Child.ObjectivesText:SetTextColor(1, 1, 1)

	AdventureMapQuestChoiceDialog.AcceptButton:SkinButton()
	AdventureMapQuestChoiceDialog.DeclineButton:SkinButton()

	T.SkinScrollBar(AdventureMapQuestChoiceDialog.Details.ScrollBar)
	T.SkinCloseButton(AdventureMapQuestChoiceDialog.CloseButton)
end

T.SkinFuncs["Blizzard_AdventureMap"] = LoadSkin