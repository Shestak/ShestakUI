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
	StanceBarAnchor,
	MicroAnchor,
	VehicleAnchor,
	AchievementAnchor,
	MinimapAnchor,
	TopPanelAnchor,
	BuffsAnchor,
	RaidCDAnchor,
	EnemyCDAnchor,
	ObjectiveTrackerAnchor,
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
	T_DE_BUFF_BAR_Anchor,
	SplitBarLeft,
	SplitBarRight
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
	"UIWidgetTopAnchor",
	"UIWidgetBelowAnchor"
}

local function UpdateCoords(self)
	local mover = self.child
	local ap, _, rp, x, y = mover:GetPoint()

	mover.frame:ClearAllPoints()
	mover.frame:SetPoint(ap, "UIParent", rp, x, y)
end

local coordFrame = CreateFrame("Frame")
coordFrame:SetScript("OnUpdate", UpdateCoords)
coordFrame:Hide()

local SaveDefaultPosition = function(mover)
	local ap, p, rp, x, y = mover.frame:GetPoint()
	ShestakUIPositions.Default = ShestakUIPositions.Default or {}
	if not ShestakUIPositions.Default[mover.frame:GetName()] then
		if not p then
			p = UIParent
		end
		ShestakUIPositions.Default[mover.frame:GetName()] = {ap, p:GetName(), rp, x, y}
	end
end

local SetPosition = function(mover)
	local ap, _, rp, x, y = mover:GetPoint()
	ShestakUIPositions[mover.frame:GetName()] = {ap, "UIParent", rp, x, y}
end

local OnDragStart = function(self)
	SaveDefaultPosition(self)
	self:StartMoving()

	coordFrame.child = self
	coordFrame:Show()
end

local OnDragStop = function(self)
	self:StopMovingOrSizing()
	SetPosition(self)

	coordFrame.child = nil
	coordFrame:Hide()
end

local RestoreDefaults = function(self, button)
	if button == "RightButton" then
		local data = ShestakUIPositions.Default[self.frame:GetName()]
		if data then
			self.frame:ClearAllPoints()
			self.frame:SetPoint(unpack(data))
			self:ClearAllPoints()
			self:SetAllPoints(self.frame)
			ShestakUIPositions.Default[self.frame:GetName()] = nil
			ShestakUIPositions[self.frame:GetName()] = nil
		end
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
	mover:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(C.media.classborder_color)) end)
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
		ShestakUIPositions = {}
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
	if ShestakUIPositions then
		for frame_name, point in pairs(ShestakUIPositions) do
			if _G[frame_name] then
				_G[frame_name]:ClearAllPoints()
				_G[frame_name]:SetPoint(unpack(point))
			end
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