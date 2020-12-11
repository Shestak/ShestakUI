local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Weekly Rewards skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = WeeklyRewardsFrame
	T.SkinCloseButton(frame.CloseButton)

	frame:StripTextures()
	frame:CreateBackdrop("Transparent")

	frame.HeaderFrame:StripTextures()
	frame.SelectRewardButton:SkinButton()

	local headers = {
		frame.RaidFrame,
		frame.MythicFrame,
		frame.PVPFrame
	}

	for i = 1, #headers do
		local header = headers[i]
		header.Border:Hide()
		header:CreateBackdrop("Default")
		header.backdrop:SetOutside(header.Background)
	end

	for _, activity in pairs(frame.Activities) do
		if activity.Border then
			activity.Border:Hide()
		end
		activity:CreateBackdrop("Default")
		activity.backdrop:SetOutside(activity.Background)
		hooksecurefunc(activity, "SetSelectionState", function(self)
			if self.SelectedTexture:IsShown() then
				self.backdrop:SetBackdropBorderColor(1, 1, 0)
			else
				self.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end)
	end
end

T.SkinFuncs["Blizzard_WeeklyRewards"] = LoadSkin