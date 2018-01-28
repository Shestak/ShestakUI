local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Contribution skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "Blizzard_Contribution" then
		ContributionBuffTooltip:StripTextures()
		ContributionBuffTooltip:SetTemplate("Transparent")
		ContributionBuffTooltip.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		ContributionBuffTooltip:CreateBackdrop("Default")
		ContributionBuffTooltip.backdrop:SetFrameLevel(ContributionBuffTooltip:GetFrameLevel())
		ContributionBuffTooltip.backdrop:SetPoint("TOPLEFT", ContributionBuffTooltip.Icon, "TOPLEFT", -2, 2)
		ContributionBuffTooltip.backdrop:SetPoint("BOTTOMRIGHT", ContributionBuffTooltip.Icon, "BOTTOMRIGHT", 2, -2)

		ContributionTooltip:StripTextures()
		ContributionTooltip:CreateBackdrop("Transparent")
		ContributionTooltip.ItemTooltip.IconBorder:SetAlpha(0)
		ContributionTooltip.ItemTooltip.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		ContributionTooltip.ItemTooltip:CreateBackdrop("Default")
		ContributionTooltip.ItemTooltip.backdrop:SetPoint("TOPLEFT", ContributionTooltip.ItemTooltip.Icon, "TOPLEFT", -2, 2)
		ContributionTooltip.ItemTooltip.backdrop:SetPoint("BOTTOMRIGHT", ContributionTooltip.ItemTooltip.Icon, "BOTTOMRIGHT", 2, -2)
	end
end)

if C.skins.blizzard_frames ~= true then return end
local function LoadSkin()
	T.SkinCloseButton(ContributionCollectionFrame.CloseButton)
	ContributionCollectionFrame.CloseButton:SetPoint("TOPRIGHT", ContributionCollectionFrame, "TOPRIGHT", -17, -23)
	ContributionCollectionFrame.CloseButton.text:SetPoint("CENTER", -T.mult, T.mult)

	hooksecurefunc(ContributionMixin, "SetupContributeButton", function(self)
		if not self.isSkinned then
			self.ContributeButton:SkinButton()
			self.isSkinned = true
		end

		local statusBar = self.Status
		if statusBar and not statusBar.backdrop then
			statusBar:StripTextures()
			statusBar:CreateBackdrop("Default")
			statusBar.Text:SetFont(C.media.normal_font, 12, "OUTLINE")
		end
	end)

	hooksecurefunc(ContributionMixin, "AddReward", function(self, _, rewardID)
		local reward = self:FindOrAcquireReward(rewardID)
		if reward then
			reward.Border:SetAlpha(0)
			if not reward.backdrop then
				reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				reward:SetFrameLevel(5)
				reward.Border:SetAlpha(0)
				reward:CreateBackdrop("Default")
				reward.backdrop:SetPoint("TOPLEFT", reward.Icon, "TOPLEFT", -2, 2)
				reward.backdrop:SetPoint("BOTTOMRIGHT", reward.Icon, "BOTTOMRIGHT", 2, -2)
			end
		end
	end)
end

T.SkinFuncs["Blizzard_Contribution"] = LoadSkin