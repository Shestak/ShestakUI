local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

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

	hooksecurefunc(ContributionRewardMixin, "Setup", function(self)
		if not self.backdrop then
			self.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			self.Icon:SetDrawLayer("OVERLAY")
			self:SetFrameLevel(5)
			self:CreateBackdrop("Default")
			self.backdrop:SetPoint("TOPLEFT", self.Icon, "TOPLEFT", -2, 2)
			self.backdrop:SetPoint("BOTTOMRIGHT", self.Icon, "BOTTOMRIGHT", 2, -2)
		end
	end)
end

T.SkinFuncs["Blizzard_Contribution"] = LoadSkin