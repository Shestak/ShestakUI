local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	FrameStackTooltip skin(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", nil, UIParent)
frame:SetScript("OnUpdate", function(self, elapsed)
	if IsAddOnLoaded("Aurora") then return end

	if self.elapsed and self.elapsed > 0.1 then
		if FrameStackTooltip then
			local noscalemult = T.mult * C.general.uiscale
			FrameStackTooltip:SetBackdrop({
				bgFile = C.media.blank, edgeFile = C.media.blank, edgeSize = noscalemult,
				insets = {left = -noscalemult, right = -noscalemult, top = -noscalemult, bottom = -noscalemult}
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