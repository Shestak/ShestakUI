local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	FrameStackTooltip skin(by Elv22)
----------------------------------------------------------------------------------------
local FSTooltip = CreateFrame("Frame", nil, UIParent)

FSTooltip:SetScript("OnUpdate", function(self, elapsed)
	if IsAddOnLoaded("Aurora") then return end

	if self.elapsed and self.elapsed > 0.1 then
		if FrameStackTooltip then
			local noscalemult = T.mult * C.general.uiscale
			FrameStackTooltip:SetBackdrop({
				bgFile = C.media.blank, 
				edgeFile = C.media.blank, 
				tile = false, tileSize = 0, edgeSize = noscalemult, 
				insets = { left = -noscalemult, right = -noscalemult, top = -noscalemult, bottom = -noscalemult}
			})
			FrameStackTooltip:SetBackdropColor(unpack(C.media.overlay_color))
			FrameStackTooltip:SetBackdropBorderColor(unpack(C.media.border_color))
			FrameStackTooltip.SetBackdropColor = T.dummy
			FrameStackTooltip.SetBackdropBorderColor = T.dummy
			self.elapsed = nil
			self:SetScript("OnUpdate", nil)
		end
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
end)