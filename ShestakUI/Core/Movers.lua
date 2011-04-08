local T, C, L = unpack(select(2, ...))

T.MoverFrames = {
	GMFrameAnchor,
	MinimapAnchor,
	VehicleAnchor,
	WatchFrameAnchor,
	ThreatMeterAnchor,
	AchievementAnchor,
	LootRollAnchor,
	DCPAnchor,
	RaidBuffsAnchor,
	TooltipAnchor,
	ShiftBar,
	AutoButtonAnchor,
	RaidCDAnchor,
	BuffsAnchor,
	VehicleButtonAnchor,
	TopPanelAnchor,
}

-- Used to exec various code if we enable or disable moving
local function exec(self, enable)

	if self == GMFrameAnchor or self == LootRollAnchor or self == RaidBuffsAnchor then
		if enable then
			self:Show()
		else
			self:Hide()
		end
	end
	
	if self == MinimapAnchor then
		if enable then
			Minimap:Hide()
			self:SetBackdropBorderColor(1, 0, 0, 1)
			MinimapAnchor.text:SetText("Minimap Anchor")
		else
			Minimap:Show()
			self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
			MinimapAnchor.text:SetText("")
		end
	end
	
	if self == VehicleAnchor or self == AchievementAnchor or self == DCPAnchor or self == TooltipAnchor 
		or self == AutoButtonAnchor or self == RaidCDAnchor or self == VehicleButtonAnchor or self == TopPanelAnchor then
		if enable then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end
	end
	
	if self == WatchFrameAnchor then
		if enable then
			WatchFrameAnchor:SetBackdropBorderColor(1, 0, 0, 1)
			WatchFrameAnchor:SetBackdropColor(unpack(C.media.overlay_color))
			WatchFrameAnchor.iborder:SetBackdropBorderColor(unpack(C.media.backdrop_color))
			WatchFrameAnchor.oborder:SetBackdropBorderColor(unpack(C.media.backdrop_color))	
		else
			WatchFrameAnchor:SetBackdropBorderColor(0, 0, 0, 0)
			WatchFrameAnchor:SetBackdropColor(0, 0, 0, 0)
			WatchFrameAnchor.iborder:SetBackdropBorderColor(0, 0, 0, 0)
			WatchFrameAnchor.oborder:SetBackdropBorderColor(0, 0, 0, 0)		
		end
	end
	
	if self == BuffsAnchor then
		if enable then
			BuffsAnchor:SetBackdropBorderColor(1, 0, 0, 1)
			BuffsAnchor:SetBackdropColor(unpack(C.media.overlay_color))
			BuffsAnchor.iborder:SetBackdropBorderColor(unpack(C.media.backdrop_color))
			BuffsAnchor.oborder:SetBackdropBorderColor(unpack(C.media.backdrop_color))	
			BuffsAnchor.text:SetText("Buffs Anchor")
		else
			BuffsAnchor:SetBackdropBorderColor(0, 0, 0, 0)
			BuffsAnchor:SetBackdropColor(0, 0, 0, 0)
			BuffsAnchor.iborder:SetBackdropBorderColor(0, 0, 0, 0)
			BuffsAnchor.oborder:SetBackdropBorderColor(0, 0, 0, 0)
			BuffsAnchor.text:SetText("")			
		end
	end
	
	if self == ThreatMeterAnchor then
		if enable then
			ThreatMeterAnchor:SetBackdropBorderColor(1, 0, 0, 1)
			ThreatMeterAnchor:SetBackdropColor(unpack(C.media.overlay_color))
			ThreatMeterAnchor.iborder:SetBackdropBorderColor(unpack(C.media.backdrop_color))
			ThreatMeterAnchor.oborder:SetBackdropBorderColor(unpack(C.media.backdrop_color))			
		else
			ThreatMeterAnchor:SetBackdropBorderColor(0, 0, 0, 0)
			ThreatMeterAnchor:SetBackdropColor(0, 0, 0, 0)
			ThreatMeterAnchor.iborder:SetBackdropBorderColor(0, 0, 0, 0)
			ThreatMeterAnchor.oborder:SetBackdropBorderColor(0, 0, 0, 0)			
		end
	end
	
	if self == ShiftBar then
		if enable then
			ShapeShiftAnchor:SetAlpha(1)
		else
			ShapeShiftAnchor:SetAlpha(0)
		end
	end
end

local enable = true
local origa1, origf, origa2, origx, origy

local function moving()
	-- Don't allow moving while in combat
	if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
	
	for i = 1, getn(T.MoverFrames) do
		if T.MoverFrames[i] then
			if enable then
				T.MoverFrames[i]:EnableMouse(true)
				T.MoverFrames[i]:RegisterForDrag("LeftButton", "RightButton")
				T.MoverFrames[i]:SetScript("OnDragStart", function(self)
					origa1, origf, origa2, origx, origy = T.MoverFrames[i]:GetPoint()
					self.moving = true
					self:SetUserPlaced(true)
					self:StartMoving()
				end)
				T.MoverFrames[i]:SetScript("OnDragStop", function(self)
					self.moving = false
					self:StopMovingOrSizing()
				end)
				exec(T.MoverFrames[i], enable)
				if T.MoverFrames[i].text then
					T.MoverFrames[i].text:Show()
				end
				T.MoverFrames[i]:SetScript("OnEnter", function(self)
					if self == ShiftBar then
						ShapeShiftAnchor:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
					else
						self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
					end
				end)
				T.MoverFrames[i]:SetScript("OnLeave", function(self)
					if self == ShiftBar then
						ShapeShiftAnchor:SetBackdropBorderColor(1, 0, 0)
					else
						self:SetBackdropBorderColor(1, 0, 0)
					end
				end)
			else
				T.MoverFrames[i]:EnableMouse(false)
				if T.MoverFrames[i].moving == true then
					T.MoverFrames[i]:StopMovingOrSizing()
					T.MoverFrames[i]:ClearAllPoints()
					T.MoverFrames[i]:SetPoint(origa1, origf, origa2, origx, origy)
				end
				exec(T.MoverFrames[i], enable)
				if T.MoverFrames[i].text then T.MoverFrames[i].text:Hide() end
				T.MoverFrames[i].moving = false
			end
		end
	end
	
	if T.MoveUnitFrames then T.MoveUnitFrames() end
	
	if enable then enable = false else enable = true end
end

SLASH_MOVING1 = "/moveui"
SLASH_MOVING2 = "/ьщмугш"
SlashCmdList.MOVING = moving

local protection = CreateFrame("Frame")
protection:RegisterEvent("PLAYER_REGEN_DISABLED")
protection:SetScript("OnEvent", function(self, event)
	if enable then return end
	print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r")
	enable = false
	moving()
end)