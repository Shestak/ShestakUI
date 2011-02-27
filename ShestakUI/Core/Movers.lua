MoverFrames = {
	VehicleAnchor,
	WatchFrameAnchor,
	GMFrameAnchor,
}

-- used to exec various code if we enable or disable moving
local function exec(self, enable)

	if self == GMFrameAnchor then
		if enable then
			self:Show()
		else
			self:Hide()
		end
	end
	
	if self == VehicleAnchor then
		if enable then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end		
	end
	
	if self == WatchFrameAnchor then
		if enable then
			WatchFrameAnchor:SetBackdropBorderColor(1, 0, 0, 1)
			WatchFrameAnchor:SetBackdropColor(unpack(SettingsCF.media.overlay_color))
			WatchFrameAnchor.iborder:SetBackdropBorderColor(unpack(SettingsCF.media.backdrop_color))
			WatchFrameAnchor.oborder:SetBackdropBorderColor(unpack(SettingsCF.media.backdrop_color))			
		else
			WatchFrameAnchor:SetBackdropBorderColor(0, 0, 0, 0)
			WatchFrameAnchor:SetBackdropColor(0, 0, 0, 0)
			WatchFrameAnchor.iborder:SetBackdropBorderColor(0, 0, 0, 0)
			WatchFrameAnchor.oborder:SetBackdropBorderColor(0, 0, 0, 0)			
		end
	end
end

local enable = true
local origa1, origf, origa2, origx, origy

local function moving()
	-- Don't allow moving while in combat
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	
	for i = 1, getn(MoverFrames) do
		if MoverFrames[i] then		
			if enable then			
				MoverFrames[i]:EnableMouse(true)
				MoverFrames[i]:RegisterForDrag("LeftButton", "RightButton")
				MoverFrames[i]:SetScript("OnDragStart", function(self) 
					origa1, origf, origa2, origx, origy = MoverFrames[i]:GetPoint() 
					self.moving = true 
					self:SetUserPlaced(true) 
					self:StartMoving() 
				end)			
				MoverFrames[i]:SetScript("OnDragStop", function(self) 
					self.moving = false 
					self:StopMovingOrSizing() 
				end)			
				exec(MoverFrames[i], enable)			
				if MoverFrames[i].text then 
					MoverFrames[i].text:Show() 
				end
			else			
				MoverFrames[i]:EnableMouse(false)
				if MoverFrames[i].moving == true then
					MoverFrames[i]:StopMovingOrSizing()
					MoverFrames[i]:ClearAllPoints()
					MoverFrames[i]:SetPoint(origa1, origf, origa2, origx, origy)
				end
				exec(MoverFrames[i], enable)
				if MoverFrames[i].text then MoverFrames[i].text:Hide() end
				MoverFrames[i].moving = false
			end
		end
	end
	
	if enable then enable = false else enable = true end
end

SLASH_MOVING1 = "/moveui"
SLASH_MOVING2 = "/ьщмугш"
SlashCmdList["MOVING"] = moving

local protection = CreateFrame("Frame")
protection:RegisterEvent("PLAYER_REGEN_DISABLED")
protection:SetScript("OnEvent", function(self, event)
	if enable then return end
	print(ERR_NOT_IN_COMBAT)
	enable = false
	moving()
end)