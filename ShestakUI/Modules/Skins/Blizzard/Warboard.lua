local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Warboard skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	WarboardQuestChoiceFrame:StripTextures()
	WarboardQuestChoiceFrame.NineSlice:Hide()
	WarboardQuestChoiceFrame:CreateBackdrop("Transparent")

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
		option.ArtBackdrop = CreateFrame("Frame", nil, option)
		option.ArtBackdrop:SetFrameLevel(option:GetFrameLevel())
		option.ArtBackdrop:SetPoint("TOPLEFT", option.Artwork, -2, 2)
		option.ArtBackdrop:SetPoint("BOTTOMRIGHT", option.Artwork, 2, -2)
		option.ArtBackdrop:SetTemplate("Default")
	end

	T.SkinCloseButton(WarboardQuestChoiceFrame.CloseButton, WarboardQuestChoiceFrame.backdrop)

	WarboardQuestChoiceFrame:HookScript("OnShow", function(self)
		if self.CloseButton.Border then
			self.CloseButton.Border:Hide()
		end
	end)
end

T.SkinFuncs["Blizzard_WarboardUI"] = LoadSkin