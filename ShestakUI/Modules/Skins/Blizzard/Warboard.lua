local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Warboard skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	WarboardQuestChoiceFrame:StripTextures()
	WarboardQuestChoiceFrame.NineSlice:Hide()
	WarboardQuestChoiceFrame:CreateBackdrop("Transparent")
	WarboardQuestChoiceFrame.backdrop:SetPoint("TOPLEFT", -4, 5)
	WarboardQuestChoiceFrame.backdrop:SetPoint("BOTTOMRIGHT", 4, 0)

	WarboardQuestChoiceFrame.BorderFrame:Hide()
	WarboardQuestChoiceFrame.BorderFrame.Header:SetAlpha(0)
	WarboardQuestChoiceFrame.Background:Hide()
	WarboardQuestChoiceFrame.Title:DisableDrawLayer("BACKGROUND")

	for i = 1, 4 do
		local option = WarboardQuestChoiceFrame["Option"..i]
		option:CreateBackdrop("Overlay")
		option.backdrop:SetPoint("TOPLEFT", -2, 20)
		for i = 1, #option.OptionButtonsContainer.Buttons do
			option.OptionButtonsContainer.Buttons[i]:SkinButton()
		end
		option.Header.Ribbon:Hide()
		option.Background:Hide()
		option.Header.Text:SetTextColor(1, 1, 1)
		option.Header.Text.SetTextColor = T.dummy
		option.OptionText:SetTextColor(1, 1, 1)
		option.OptionText.SetTextColor = T.dummy
		option.OptionText:SetFont(C.media.normal_font, 13)
		option.ArtworkBorder:SetAlpha(0)
		option.ArtworkBorderDisabled:SetAlpha(0)
		option.ArtBackdrop = CreateFrame("Frame", nil, option)
		option.ArtBackdrop:SetFrameLevel(option:GetFrameLevel())
		option.ArtBackdrop:SetPoint("TOPLEFT", option.Artwork, -2, 2)
		option.ArtBackdrop:SetPoint("BOTTOMRIGHT", option.Artwork, 2, -2)
		option.ArtBackdrop:SetTemplate("Default")
	end

	hooksecurefunc(WarboardQuestChoiceFrame, "TryShow", function(self)
		for _, option in next, self.Options do
			if option.WidgetContainer.widgetFrames then
				for _, widgetFrame in next, option.WidgetContainer.widgetFrames do
					if widgetFrame.widgetType == _G.Enum.UIWidgetVisualizationType.TextWithState then
						widgetFrame.Text:SetTextColor(1, 1, 1)
					elseif widgetFrame.widgetType == _G.Enum.UIWidgetVisualizationType.SpellDisplay then
						local _, g = widgetFrame.Spell.Text:GetTextColor()
						if g < 0.2 then
							widgetFrame.Spell.Text:SetTextColor(1, 1, 1)
						end
						widgetFrame.Spell.Border:Hide()
						widgetFrame.Spell.IconMask:Hide()
						if not widgetFrame.Spell.backdrop then
							widgetFrame.Spell.Icon:SkinIcon()
						end
						if widgetFrame.Spell.Icon:GetWidth() < 25 then
							widgetFrame.Spell.Icon:SetSize(20, 20)
						end
					end
				end
			end
		end
	end)

	T.SkinCloseButton(WarboardQuestChoiceFrame.CloseButton)

	WarboardQuestChoiceFrame:HookScript("OnShow", function(self)
		if self.CloseButton.Border then
			self.CloseButton.Border:Hide()
		end
		self.CloseButton:SetPoint("TOPRIGHT", -4, -4)
	end)
end

T.SkinFuncs["Blizzard_WarboardUI"] = LoadSkin