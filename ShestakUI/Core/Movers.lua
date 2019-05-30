local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Movement function(by Allez)
----------------------------------------------------------------------------------------
T.MoverFrames = {
	VehicleButtonAnchor,
	ExtraButtonAnchor,
	ActionBarAnchor,
	RightActionBarAnchor,
	PetActionBarAnchor,
	ShiftHolder,
	MicroAnchor,
	VehicleAnchor,
	AchievementAnchor,
	MinimapAnchor,
	TopPanelAnchor,
	BuffsAnchor,
	RaidCDAnchor,
	EnemyCDAnchor,
	ObjectiveTrackerAnchor,
	ObjectiveTimerAnchor,
	ThreatMeterAnchor,
	LootRollAnchor,
	RaidBuffsAnchor,
	PulseCDAnchor,
	AutoButtonAnchor,
	TooltipAnchor,
	ChatBar,
	oUF_Player_Castbar,
	oUF_Target_Castbar,
	oUF_Player_Portrait,
	oUF_Target_Portrait,
	P_BUFF_ICON_Anchor,
	P_PROC_ICON_Anchor,
	SPECIAL_P_BUFF_ICON_Anchor,
	T_DEBUFF_ICON_Anchor,
	T_BUFF_Anchor,
	PVE_PVP_DEBUFF_Anchor,
	PVE_PVP_CC_Anchor,
	COOLDOWN_Anchor,
	T_DE_BUFF_BAR_Anchor
}

local moving = false
local movers = {}
local placed = {
	"Butsu",
	"UIAltPowerBar",
	"LootHistoryFrame",
	"stArchaeologyFrame",
	"StuffingFrameBags",
	"StuffingFrameBank",
	"alDamageMeterFrame"
}

local SetPosition = function(mover)
	local ap, _, rp, x, y = mover:GetPoint()
	SavedPositions[mover.frame:GetName()] = {ap, "UIParent", rp, x, y}
end

local OnDragStart = function(self)
	self:StartMoving()
	self.frame:ClearAllPoints()
	self.frame:SetAllPoints(self)
end

local OnDragStop = function(self)
	self:StopMovingOrSizing()
	SetPosition(self)
end

local RestoreDefaults = function(self, button)
	if button == "RightButton" then
		SavedPositions[self.frame:GetName()] = nil
	end
end

local CreateMover = function(frame)
	local mover = CreateFrame("Frame", nil, UIParent)
	mover:SetTemplate("Transparent")
	mover:SetBackdropBorderColor(1, 0, 0)
	mover:SetAllPoints(frame)
	mover:SetFrameStrata("TOOLTIP")
	mover:EnableMouse(true)
	mover:SetMovable(true)
	mover:SetClampedToScreen(true)
	mover:RegisterForDrag("LeftButton")
	mover:SetScript("OnDragStart", OnDragStart)
	mover:SetScript("OnDragStop", OnDragStop)
	mover:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b) end)
	mover:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(1, 0, 0) end)
	mover:SetScript("OnMouseUp", RestoreDefaults)
	mover.frame = frame

	mover.name = mover:CreateFontString(nil, "OVERLAY")
	mover.name:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	mover.name:SetPoint("CENTER")
	mover.name:SetTextColor(1, 1, 1)
	mover.name:SetText(frame:GetName())
	mover.name:SetWidth(frame:GetWidth() - 4)
	movers[frame:GetName()] = mover
end

local GetMover = function(frame)
	if movers[frame:GetName()] then
		return movers[frame:GetName()]
	else
		return CreateMover(frame)
	end
end

local InitMove = function(msg)
	if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end
	if msg and (msg == "reset" or msg == "куыуе") then
		SavedPositions = {}
		SavedOptionsPerChar.UFPos = {}
		for _, v in pairs(placed) do
			if _G[v] then
				_G[v]:SetUserPlaced(false)
			end
		end
		ReloadUI()
		return
	end
	if not moving then
		for _, v in pairs(T.MoverFrames) do
			local mover = GetMover(v)
			if mover then mover:Show() end
		end
		moving = true
	else
		for _, v in pairs(movers) do
			v:Hide()
		end
		moving = false
	end
	if T.MoveUnitFrames then T.MoveUnitFrames() end
end

local RestoreUI = function(self)
	if InCombatLockdown() then
		if not self.shedule then self.shedule = CreateFrame("Frame", nil, self) end
		self.shedule:RegisterEvent("PLAYER_REGEN_ENABLED")
		self.shedule:SetScript("OnEvent", function(self)
			RestoreUI(self:GetParent())
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			self:SetScript("OnEvent", nil)
		end)
		return
	end
	for frame_name, point in pairs(SavedPositions) do
		if _G[frame_name] then
			_G[frame_name]:ClearAllPoints()
			_G[frame_name]:SetPoint(unpack(point))
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent(event)
	RestoreUI(self)
end)

SlashCmdList.MOVING = InitMove
SLASH_MOVING1 = "/moveui"
SLASH_MOVING2 = "/ьщмугш"
SLASH_MOVING3 = "/ui"
SLASH_MOVING4 = "/гш"