local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Player Choice skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = _G.PlayerChoiceFrame

	local function StyleText(text)
		if text.IsSkinned then return end
		text:SetTextColor(1, 1, 1)
		text.SetTextColor = T.dummy
		text.IsSkinned = true
	end

	hooksecurefunc(frame, "Update", function()
		if not frame.IsSkinned then
			frame.BlackBackground:SetAlpha(0)
			frame.Background:SetAlpha(0)
			frame.NineSlice:SetAlpha(0)
			frame.BorderFrame.Header:SetAlpha(0)

			frame:CreateBackdrop("Transparent")

			frame.Title:DisableDrawLayer("BACKGROUND")
			frame.Title.Text:SetTextColor(1, .8, 0)

			T.SkinCloseButton(frame.CloseButton)
			frame.CloseButton.Border:SetAlpha(0)

			frame.IsSkinned = true
		end

		local IsInJailers = IsInJailersTower()
		frame.backdrop:SetShown(not IsInJailers)

		for i = 1, frame:GetNumOptions() do
			local option = frame.Options[i]
			local hasArtworkBorderArt = option.ArtworkBorder:IsShown()
			option:CreateBackdrop("Overlay")
			option.backdrop:SetPoint("TOPLEFT", -2, 20)
			option.backdrop:SetShown(not IsInJailers and hasArtworkBorderArt)

			for i = 1, #option.OptionButtonsContainer.Buttons do
				local button = option.OptionButtonsContainer.Buttons[i]
				if not button.isSkinned then
					if IsInJailers then
						button:StripTextures(true)
					end
					if i == 1 or (hasArtworkBorderArt and i == 2) then
						button:SkinButton()
					end
					button.isSkinned = true
				end
			end

			option.Header.Text:SetTextColor(1, .8, 0)
			option.OptionText:SetTextColor(1, 1, 1)

			option.Background:SetShown(not hasArtworkBorderArt)
			if IsInJailers then
				option.Background:Show()
			end
			option.Header.Ribbon:SetAlpha(0)

			option.ArtworkBorder:SetAlpha(0)
			option.ArtworkBorderDisabled:SetAlpha(0)
			if not option.ArtBackdrop then
				option.ArtBackdrop = CreateFrame("Frame", nil, option)
				option.ArtBackdrop:SetFrameLevel(option:GetFrameLevel())
				option.ArtBackdrop:SetPoint("TOPLEFT", option.Artwork, -2, 2)
				option.ArtBackdrop:SetPoint("BOTTOMRIGHT", option.Artwork, 2, -2)
				option.ArtBackdrop:SetTemplate("Default")
			end
			option.ArtBackdrop:SetShown(not IsInJailers and hasArtworkBorderArtt)

			for i = 1, option.WidgetContainer:GetNumChildren() do
				local child = select(i, option.WidgetContainer:GetChildren())
				if child then
					if child.Text then
						child.Text:SetTextColor(1, 1, 1)
					end

					if child.Spell then
						if not child.Spell.isSkinned then
							child.Spell.Border:SetTexture("")
							child.Spell.IconMask:Hide()

							child.Spell.Icon:SkinIcon()

							child.Spell.isSkinned = true
						end

						child.Spell.Text:SetTextColor(1, 1, 1)
					end

					for j = 1, child:GetNumChildren() do
						local child2 = select(j, child:GetChildren())
						if child2 then
							if child2.Text then StyleText(child2.Text) end
							if child2.LeadingText then StyleText(child2.LeadingText) end
							if child2.Icon and not child2.Icon.isSkinned then
								child2.Icon:SkinIcon()

								child2.Icon.isSkinned = true
							end
						end
					end
				end
			end
		end
	end)
end

T.SkinFuncs["Blizzard_PlayerChoiceUI"] = LoadSkin