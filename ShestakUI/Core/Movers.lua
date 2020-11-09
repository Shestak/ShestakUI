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
	mover.frame:ClearAllPoints()
	mover.frame:SetPoint(ap, "UIParent", rp, x, y)
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
		local data = ShestakUIPositions.Default and ShestakUIPositions.Default[self.frame:GetName()]
		if data then
			self.frame:ClearAllPoints()
			self.frame:SetPoint(unpack(data))
			self:ClearAllPoints()
			self:SetAllPoints(self.frame)
			ShestakUIPositions.Default[self.frame:GetName()] = nil
			ShestakUIPositions[self.frame:GetName()] = nil
		end
	elseif button == "MiddleButton" then
		self:Hide()
	end
end

-- Controls
local controls = CreateFrame("frame", nil, UIParent)
controls:SetPoint("CENTER", UIParent)
controls:SetSize(65, 25)
controls:SetFrameStrata("TOOLTIP")
controls:SetFrameLevel(100)
controls:Hide()
controls:SetScript("OnLeave", function(self)
	if MouseIsOver(self) then return end
	if not self._frame then
		self:Hide()
	elseif not MouseIsOver(self._frame) then
		self:Hide()
	end
end)

local function CreateArrow(moveX, moveY, callback)
	moveX = moveX or 0
	moveY = moveY or 0

	local button = CreateFrame("button", nil, controls)
	button:SetSize(14, 14)
	button.controls = controls

	button.tex = button:CreateTexture(nil, "OVERLAY")
	button.tex:SetTexture("Interface\\OPTIONSFRAME\\VoiceChat-Play")

	button.tex:SetPoint("CENTER")
	button.tex:SetSize(12, 12)
	button.tex:SetAlpha(0.6)

	button:SetScript("OnEnter", function(self)
		self.tex:SetAlpha(1)
	end)
	button:SetScript("OnLeave", function(self)
		self.tex:SetAlpha(0.6)
	end)

	callback = callback or function(self)
		local frame = self.controls._frame
		if not frame then return end
		local point, relativeTo, relativePoint, xOfs, yOfs = frame.frame:GetPoint()
		SaveDefaultPosition(frame)
		if IsControlKeyDown() then
			frame.frame:SetPoint(point, relativeTo, relativePoint, xOfs + (moveX * 20), yOfs + (moveY * 20))
		elseif IsShiftKeyDown() then
			frame.frame:SetPoint(point, relativeTo, relativePoint, xOfs + (moveX * 5), yOfs + (moveY * 5))
		else
			frame.frame:SetPoint(point, relativeTo, relativePoint, xOfs + (moveX * 1), yOfs + (moveY * 1))
		end
		local point, relativeTo, relativePoint, xOfs, yOfs = frame.frame:GetPoint()
		if not relativeTo then
			relativeTo = UIParent
		end
		ShestakUIPositions[frame.frame:GetName()] = {point, relativeTo:GetName(), relativePoint, xOfs, yOfs}
		frame:SetAllPoints(frame.frame)
	end

	button:SetScript("OnClick", callback)

	if controls.last then
		button:SetPoint("LEFT", controls.last, "RIGHT", 2, 0)
	else
		button:SetPoint("LEFT", controls, "LEFT", 2, 0)
	end

	controls.last = button

	return button
end

controls.left = CreateArrow(-1, 0)
controls.left.tex:SetRotation(3.14159)

controls.up = CreateArrow(0, 1)
controls.up.tex:SetRotation(1.5708)

controls.down = CreateArrow(0, -1)
controls.down.tex:SetRotation(-1.5708)

controls.right = CreateArrow(1, 0)
controls.right.tex:SetRotation(0)

local function GetQuadrant(frame)
	local _, y = frame:GetCenter()
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return vhalf
end

local function ShowControls(frame)
	local y = GetQuadrant(frame)
	controls._frame = frame
	controls:Show()
	controls:ClearAllPoints()
	if y == "TOP" then
		controls:SetPoint("TOP", frame, "BOTTOM", 0, 0)
	else
		controls:SetPoint("BOTTOM", frame, "TOP", 0, 0)
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
	mover:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(C.media.classborder_color)) ShowControls(self) end)
	mover:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(1, 0, 0) if not MouseIsOver(controls) then controls:Hide() end end)
	mover:SetScript("OnMouseUp", RestoreDefaults)
	mover.frame = frame

	mover.name = mover:CreateFontString(nil, "OVERLAY")
	mover.name:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	mover.name:SetPoint("CENTER")
	mover.name:SetTextColor(1, 1, 1)
	local text = frame:GetName()
	if string.find(text, "Anchor") then
		text = text:gsub("Anchor", "")
	end
	mover.name:SetText(text)
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
		SlashCmdList.GRIDONSCREEN()
	else
		for _, v in pairs(movers) do
			v:Hide()
		end
		moving = false
		SlashCmdList.GRIDONSCREEN("hide")
		controls:Hide()
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