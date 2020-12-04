local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Covenant Sanctum skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = CovenantSanctumFrame

	frame.UpgradesTab.DepositButton:SkinButton()
	frame.LevelFrame.Background:SetAlpha(0)

	frame.UpgradesTab:CreateBackdrop("Overlay")
	frame.UpgradesTab.backdrop:SetPoint("TOPLEFT", frame.UpgradesTab.Background, -2, 2)
	frame.UpgradesTab.backdrop:SetPoint("BOTTOMRIGHT", frame.UpgradesTab.Background, 2, -2)

	local talentsList = frame.UpgradesTab.TalentsList
	talentsList:CreateBackdrop("Overlay")
	talentsList.backdrop:SetPoint("TOPLEFT", 6, 2)
	talentsList.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	talentsList.UpgradeButton:SkinButton()
	talentsList.Divider:SetAlpha(0)
	talentsList.BackgroundTile:SetAlpha(0)
	talentsList.IntroBox.Background:Hide()

	local function HandleIconString(self, text)
		if not text then text = self:GetText() end
		if not text or text == '' then return end

		local new, count = gsub(text, '|T([^:]-):[%d+:]+|t', '|T%1:14:14:0:0:64:64:5:59:5:59|t')
		if count > 0 then self:SetFormattedText('%s', new) end
	end

	for frame in frame.UpgradesTab.CurrencyDisplayGroup.currencyFramePool:EnumerateActive() do
		if not frame.IsSkinned then
			HandleIconString(frame.Text)
			hooksecurefunc(frame.Text, "SetText", HandleIconString)

			frame.IsSkinned = true
		end
	end

	hooksecurefunc(talentsList, "Refresh", function(self)
		for frame in self.talentPool:EnumerateActive() do
			if not frame.backdrop then
				frame.Border:SetAlpha(0)
				frame.IconBorder:SetAlpha(0)
				frame.TierBorder:SetAlpha(0)
				frame.Background:SetAlpha(0)

				frame:CreateBackdrop("Overlay")
				frame.backdrop:SetInside()
				frame.backdrop.overlay:SetVertexColor(0.15, 0.15, 0.15, 1)

				frame.Icon:SetPoint("TOPLEFT", 10, -10)
				frame.Icon:SetSize(35, 35)
				frame.Icon:SkinIcon(true)

				frame.Highlight:SetColorTexture(1, 1, 1, 0.3)
				frame.Highlight:SetInside(frame.backdrop)

				HandleIconString(frame.InfoText)
				hooksecurefunc(frame.InfoText, "SetText", HandleIconString)
			end
		end
	end)

	frame:HookScript("OnShow", function()
		if not frame.backdrop then
			frame:CreateBackdrop("Transparent")
			frame.NineSlice:SetAlpha(0)

			frame.CloseButton.Border:SetAlpha(0)
			T.SkinCloseButton(frame.CloseButton)
		end
	end)
end

T.SkinFuncs["Blizzard_CovenantSanctum"] = LoadSkin