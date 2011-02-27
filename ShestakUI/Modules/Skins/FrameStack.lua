----------------------------------------------------------------------------------------
--	Skin FrameStackTooltip(by Elv22)
----------------------------------------------------------------------------------------
local FSTooltip = CreateFrame("Frame", nil, UIParent)

FSTooltip:SetScript("OnUpdate", function(self, elapsed)
	if (self.elapsed and self.elapsed > 0.1) then
		if FrameStackTooltip then
			local noscalemult = SettingsDB.mult * SettingsCF.general.uiscale
			FrameStackTooltip:SetBackdrop({
				bgFile = SettingsCF.media.blank, 
				edgeFile = SettingsCF.media.blank, 
				tile = false, tileSize = 0, edgeSize = noscalemult, 
				insets = { left = -noscalemult, right = -noscalemult, top = -noscalemult, bottom = -noscalemult}
			})
			FrameStackTooltip:SetBackdropColor(unpack(SettingsCF.media.overlay_color))
			FrameStackTooltip:SetBackdropBorderColor(unpack(SettingsCF.media.border_color))
			FrameStackTooltip.SetBackdropColor = SettingsDB.dummy
			FrameStackTooltip.SetBackdropBorderColor = SettingsDB.dummy
			self.elapsed = nil
			self:SetScript("OnUpdate", nil)
		end
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
end)