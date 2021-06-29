local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Player Choice skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = _G.PlayerChoiceFrame

	hooksecurefunc(frame, "TryShow", function(self)
		if not frame.IsSkinned then
			frame.BlackBackground:SetAlpha(0)
			frame.Background:SetAlpha(0)
			frame.NineSlice:SetAlpha(0)
			frame.Header.Texture:SetAlpha(0)

			frame:CreateBackdrop("Transparent")

			frame.Title:DisableDrawLayer("BACKGROUND")
			frame.Title.Text:SetTextColor(1, .8, 0)

			T.SkinCloseButton(frame.CloseButton)

			hooksecurefunc(frame.CloseButton, "SetPoint", function(self, point, anchor, attachTo, x, y)
				if x ~= -4 then
					self:SetPoint(point, anchor, attachTo, -4, -4)
				end
			end)

			frame.IsSkinned = true
		end

		if frame.CloseButton.Border then
			frame.CloseButton.Border:SetAlpha(0)
		end

		local IsInJailers = IsInJailersTower()
		frame.backdrop:SetShown(not IsInJailers)

		for option in self.optionPools:EnumerateActiveByTemplate(self.optionFrameTemplate) do
			local hasArtworkBorderArt = option.ArtworkBorder and option.ArtworkBorder:IsShown()
			option:CreateBackdrop("Overlay")
			option.backdrop:SetPoint("TOPLEFT", -2, 20)
			option.backdrop:SetPoint("BOTTOMRIGHT", 2, -8)
			option.backdrop:SetShown(not IsInJailers and hasArtworkBorderArt)

			if option.Header.Ribbon then option.Header.Ribbon:SetAlpha(0) end
			if option.Header.Contents then option.Header.Contents.Text:SetTextColor(1, .8, 0) end
			option.OptionText:SetTextColor(1, 1, 1)

			option.Background:SetShown(not hasArtworkBorderArt)
			if IsInJailers then
				option.Background:Show()
			end

			if option.ArtworkBorder then
				option.ArtworkBorder:SetAlpha(0)
				if not option.ArtBackdrop then
					option.ArtBackdrop = CreateFrame("Frame", nil, option)
					option.ArtBackdrop:SetFrameLevel(option:GetFrameLevel())
					option.ArtBackdrop:SetPoint("TOPLEFT", option.Artwork, -2, 2)
					option.ArtBackdrop:SetPoint("BOTTOMRIGHT", option.Artwork, 2, -2)
					option.ArtBackdrop:SetTemplate("Default")
				end
				option.ArtBackdrop:SetShown(not IsInJailers and hasArtworkBorderArt)
				if PlayerChoiceFrame:IsLegacy() then -- Garrison
					option.ArtBackdrop:Hide()
				end
			end

			local buttonsContainer = option.OptionButtonsContainer
			if buttonsContainer and buttonsContainer.buttonPool then
				for button in buttonsContainer.buttonPool:EnumerateActive() do
					if not button.isSkinned then
						if IsInJailers then
							button:StripTextures(true)
						end
						-- if i == 1 or (hasArtworkBorderArt and i == 2) then
							button:SkinButton()
						-- end
						button.isSkinned = true
					end
				end
			end

			local rewardframe = option.Rewards
			if rewardframe then
				for reward in rewardframe.rewardsPool:EnumerateActive() do
					if not reward.backdrop and reward.Icon then
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
					if reward.backdrop then reward.backdrop:SetBackdropBorderColor(r, g, b) end
				end
			end

			local widgetFrames = option.WidgetContainer.widgetFrames
			if widgetFrames then
				for _, widgetFrame in next, widgetFrames do
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

T.SkinFuncs["Blizzard_PlayerChoice"] = LoadSkin