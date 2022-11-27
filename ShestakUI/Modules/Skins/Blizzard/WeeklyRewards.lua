local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Weekly Rewards skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	hooksecurefunc(WeeklyRewardsFrame, "SetupTextures", function()
		local frame = WeeklyRewardsFrame
		frame:StripTextures()

		frame.HeaderFrame:StripTextures()
		frame.SelectRewardButton:StripTextures()

		local headers = {
			frame.RaidFrame,
			frame.MythicFrame,
			frame.PVPFrame
		}

		for i = 1, #headers do
			local header = headers[i]
			header.Border:Hide()
		end
	end)


	local frame = WeeklyRewardsFrame
	T.SkinCloseButton(frame.CloseButton)

	-- frame:StripTextures()
	frame:CreateBackdrop("Transparent")

	-- frame.HeaderFrame:StripTextures()
	-- frame.SelectRewardButton:StripTextures()
	frame.SelectRewardButton:SkinButton()

	local headers = {
		frame.RaidFrame,
		frame.MythicFrame,
		frame.PVPFrame
	}

	for i = 1, #headers do
		local header = headers[i]
		-- header.Border:Hide()
		header:CreateBackdrop("Default")
		header.backdrop:SetOutside(header.Background)
		header.Background:SetTexCoord(0.01602564102564, 0.97109826589595, 0.02890173410405, 0.97109826589595)
	end

	for _, activity in pairs(frame.Activities) do
		if activity.Border then
			activity.Border:SetAlpha(0)
			activity.SelectedTexture:SetAlpha(0)
			activity.UnselectedFrame:SetAlpha(0)
			activity:CreateBackdrop("Default")
			activity.backdrop:SetOutside(activity.Background)
			hooksecurefunc(activity, "SetSelectionState", function(self)
				if self.SelectedTexture:IsShown() then
					self.backdrop:SetBackdropBorderColor(1, 1, 0)
				else
					self.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				end
			end)

			hooksecurefunc(activity.ItemFrame, "SetDisplayedItem", function(item)
				if not item.IsSkinned then
					item:DisableDrawLayer("BORDER")
					item.Icon:SkinIcon()
					item.Name:SetTextColor(0.639, 0.207, 0.933)
					item.IsSkinned = true
				end
			end)
		end
	end

	hooksecurefunc(frame, "SelectReward", function(self)
		local frame = self.confirmSelectionFrame
		if frame and not frame.styled then
			WeeklyRewardsFrameIconTexture:SkinIcon()
			WeeklyRewardsFrameNameFrame:SetAlpha(0)
			frame.ItemFrame.IconBorder:SetAlpha(0)
			frame.styled = true

			local alsoItems = frame.AlsoItemsFrame
			if alsoItems and alsoItems.pool then
				for items in alsoItems.pool:EnumerateActive() do
					if not items.styled then
						items.IconBorder:SetAlpha(0)
						items.Icon:SkinIcon()
						items.styled = true
					end
				end
			end
		end
	end)

	local rewardText = frame.ConcessionFrame.RewardsFrame.Text
	hooksecurefunc(rewardText, "SetText", function(self, text)
		if not text then text = self:GetText() end
		if not text or text == "" then return end

		local newText, count = gsub(text, "24:24:0:%-2", "14:14:0:0:64:64:5:59:5:59")
		if count > 0 then self:SetFormattedText("%s", newText) end
	end)
end

T.SkinFuncs["Blizzard_WeeklyRewards"] = LoadSkin