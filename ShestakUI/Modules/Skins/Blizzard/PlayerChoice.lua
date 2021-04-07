local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Player Choice skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = _G.PlayerChoiceFrame

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
			frame.CloseButton.SetPoint = T.dummy

			frame.IsSkinned = true
		end

		local IsInJailers = IsInJailersTower()
		frame.backdrop:SetShown(not IsInJailers)

		for i = 1, frame:GetNumOptions() do
			local option = frame.Options[i]
			local hasArtworkBorderArt = option.ArtworkBorder:IsShown() or option.ArtworkBorderDisabled:IsShown()
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

			local reward = option.RewardsFrame.Rewards.lastReward
			if reward then
				if not reward.backdrop then
					reward.Icon:SkinIcon()
				end
				if reward.Name then reward.Name:SetTextColor(1, 1, 1) end
				if reward.IconBorder then reward.IconBorder:SetTexture("") end
				local r, g, b
				if reward.IconBorder and reward.IconBorder:IsShown() then
					r, g, b = reward.IconBorder:GetVertexColor()
					if (r > 0.64 and r < 0.67) or (r > 0.99 and g > 0.99 and b > 0.99) then
						r, g, b = unpack(C.media.border_color)
					end
				else
					r, g, b = unpack(C.media.border_color)
				end
				reward.backdrop:SetBackdropBorderColor(r, g, b)
			end

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
			option.ArtBackdrop:SetShown(not IsInJailers and hasArtworkBorderArt)

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
end

T.SkinFuncs["Blizzard_PlayerChoiceUI"] = LoadSkin