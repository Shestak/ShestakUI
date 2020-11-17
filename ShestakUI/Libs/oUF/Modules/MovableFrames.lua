local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_MovableFrames(by Haste)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local _DB
local _LOCK

local backdropPool = {}

local getObjectInformation = function(obj)
	-- This won't be set if we're dealing with oUF <1.3.22. Due to this we're just
	-- setting it to Unknown. It will only break if the user has multiple layouts
	-- spawning the same unit or change between layouts.
	local style = obj.style or "Unknown"
	local identifier = obj:GetName() or obj.unit

	-- Are we dealing with header units?
	local isHeader
	local parent = obj:GetParent()

	if parent then
		if parent:GetAttribute("initialConfigFunction") and parent.style then
			isHeader = parent

			identifier = parent:GetName()
		elseif parent:GetAttribute("oUF-onlyProcessChildren") then
			isHeader = parent:GetParent()

			identifier = isHeader:GetName()
		end
	end

	return style, identifier, isHeader
end

local restoreDefaultPosition = function(style, identifier, obj)
	local style, identifier, isHeader = getObjectInformation(obj)
	local target = isHeader or obj
	if ShestakUIPositions.Default[target:GetName()] then
		target:ClearAllPoints()
		target:SetPoint(unpack(ShestakUIPositions.Default[target:GetName()]))
		local backdrop = backdropPool[target]
		if backdrop then
			backdrop:ClearAllPoints()
			backdrop:SetAllPoints(target)
		end
		ShestakUIPositions.Default[target:GetName()] = nil
		ShestakUIPositions.UnitFrame[target:GetName()] = nil
	else
		-- We've not saved any default position for this style
		if not _DB.__INITIAL or not _DB.__INITIAL[style] or not _DB.__INITIAL[style][identifier] then return end

		local obj, isHeader
		for _, frame in next, oUF.objects do
			local fStyle, fIdentifier, fIsHeader = getObjectInformation(frame)
			if fStyle == style and fIdentifier == identifier then
				obj = frame
				isHeader = fIsHeader

				break
			end
		end

		if obj then
			local scale = obj:GetScale()
			local target = isHeader or obj
			local SetPoint = getmetatable(target).__index.SetPoint

			target:ClearAllPoints()

			local point, parentName, x, y = string.split("\031", _DB.__INITIAL[style][identifier])
			SetPoint(target, point, parentName, point, x / scale, y / scale)

			local backdrop = backdropPool[target]
			if backdrop then
				backdrop:ClearAllPoints()
				backdrop:SetAllPoints(target)
			end

			-- We don't need this anymore
			_DB.__INITIAL[style][identifier] = nil
			if not next(_DB.__INITIAL[style]) then
				_DB[style] = nil
			end
		end
	end
end

local function restorePosition(obj)
	if InCombatLockdown() then return end
	local style, identifier, isHeader = getObjectInformation(obj)
	local target = isHeader or obj
	if ShestakUIPositions.UnitFrame[target:GetName()] then
		local SetPoint = getmetatable(target).__index.SetPoint

		-- Hah, a spot you have to use semi-colon!
		-- Guess I've never experienced that as these are usually wrapped in do end
		-- statements.
		if(not target._SetPoint) then
			target._SetPoint = target.SetPoint
			target.SetPoint = restorePosition
		end
		target:ClearAllPoints()

		SetPoint(target, unpack(ShestakUIPositions.UnitFrame[target:GetName()]))
	else
		-- We've not saved any custom position for this style
		if not _DB[style] or not _DB[style][identifier] then return end

		local scale = obj:GetScale()
		local target = isHeader or obj
		local SetPoint = getmetatable(target).__index.SetPoint

		-- Hah, a spot you have to use semi-colon!
		-- Guess I've never experienced that as these are usually wrapped in do end
		-- statements.
		if(not target._SetPoint) then
			target._SetPoint = target.SetPoint
			target.SetPoint = restorePosition
		end
		target:ClearAllPoints()

		-- damn it Blizzard, _how_ did you manage to get the input of this function
		-- reversed. Any sane person would implement this as: split(str, dlm, lim)
		local point, parentName, x, y = string.split("\031", _DB[style][identifier])
		SetPoint(target, point, parentName, point, x / scale, y / scale)
	end
end

local saveDefaultPosition = function(obj)
	local style, identifier, isHeader = getObjectInformation(obj)
	local target = isHeader or obj

	local ap, p, rp, x, y = target:GetPoint()
	ShestakUIPositions.Default = ShestakUIPositions.Default or {}
	if not ShestakUIPositions.Default[target:GetName()] then
		if not p then
			p = UIParent
		end
		ShestakUIPositions.Default[target:GetName()] = {ap, p:GetName(), rp, x, y}
	end
end

local savePosition = function(obj, anchor)
	local x, y, ap = T.CalculateMoverPoints(anchor)
	ShestakUIPositions.UnitFrame[anchor.target:GetName()] = {ap, "UIParent", ap, x, y}
end

-- Controls
local controls = CreateFrame("frame", nil, UIParent)
controls:SetPoint("CENTER", UIParent)
controls:SetSize(65, 25)
controls:SetFrameStrata("TOOLTIP")
controls:SetFrameLevel(100)
controls:SetClampedToScreen(true)
controls:Hide()
controls:SetScript("OnLeave", function(self)
	if MouseIsOver(self) then return end
	if not self._frame then
		self:Hide()
	elseif not MouseIsOver(self._frame) then
		self:Hide()
	end
	controls.x:SetText("")
	controls.y:SetText("")
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
	button.tex:SetVertexColor(0.6, 0.6, 0.6)

	button:SetScript("OnEnter", function(self)
		self.tex:SetVertexColor(1, 1, 1)
	end)
	button:SetScript("OnLeave", function(self)
		self.tex:SetVertexColor(0.6, 0.6, 0.6)
	end)

	callback = callback or function(self)
		local frame = self.controls._frame
		if not frame then return end
		local point, relativeTo, relativePoint, xOfs, yOfs = frame.target:GetPoint()
		saveDefaultPosition(frame.obj)
		if IsControlKeyDown() then
			frame.target:SetPoint(point, relativeTo, relativePoint, xOfs + (moveX * 20), yOfs + (moveY * 20))
		elseif IsShiftKeyDown() then
			frame.target:SetPoint(point, relativeTo, relativePoint, xOfs + (moveX * 5), yOfs + (moveY * 5))
		else
			frame.target:SetPoint(point, relativeTo, relativePoint, xOfs + (moveX * 1), yOfs + (moveY * 1))
		end
		local point, relativeTo, relativePoint, xOfs, yOfs = frame.target:GetPoint()
		if not relativeTo then
			relativeTo = UIParent
		end
		ShestakUIPositions.UnitFrame[frame.target:GetName()] = {point, relativeTo:GetName(), relativePoint, xOfs, yOfs}
		frame:SetAllPoints(frame.target)
		controls.x:SetText(T.Round(xOfs))
		controls.y:SetText(T.Round(yOfs))
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

controls.x = controls:CreateFontString(nil, "OVERLAY")
controls.x:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
controls.x:SetPoint("RIGHT", controls, "LEFT", -10, 0)

controls.y = controls:CreateFontString(nil, "OVERLAY")
controls.y:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
controls.y:SetPoint("LEFT", controls, "RIGHT", 10, 0)

controls.shadow = controls:CreateTexture(nil, "OVERLAY")
controls.shadow:SetPoint("TOPLEFT", controls.x, "TOPLEFT", -5, 5)
controls.shadow:SetPoint("BOTTOMRIGHT", controls.y, "BOTTOMRIGHT", 2, -5)
controls.shadow:SetTexture(C.media.texture)
controls.shadow:SetVertexColor(0.1, 0.1, 0.1, 0.8)

local function GetQuadrant(frame)
	local _, y = frame:GetCenter()
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return vhalf
end

local function ShowControls(frame)
	local y = GetQuadrant(frame)
	controls._frame = frame
	controls:Show()
	controls:SetAlpha(1)
	controls:ClearAllPoints()
	if y == "TOP" then
		controls:SetPoint("TOP", frame, "BOTTOM", 0, 0)
	else
		controls:SetPoint("BOTTOM", frame, "TOP", 0, 0)
	end

	local point, relativeTo, relativePoint, xOfs, yOfs = frame.target:GetPoint()
	controls.x:SetText(T.Round(xOfs))
	controls.y:SetText(T.Round(yOfs))
end

-- Attempt to figure out a more sane name to dispaly
local smartName
do
	local nameCache = {}
	local validNames = {
		"player",
		"target",
		"focus",
		"raid",
		"pet",
		"party",
		"maintank",
		"mainassist",
		"arena",
	}

	local rewrite = {
		mt = "maintank",
		mtt = "maintanktarget",

		ma = "mainassist",
		mat = "mainassisttarget",
	}

	local validName = function(smartName)
		-- Not really a valid name, but we'll accept it for simplicities sake
		if tonumber(smartName) then
			return smartName
		end

		if type(smartName) == "string" then
			-- Strip away trailing s from pets, but don't touch boss/focus
			smartName = smartName:gsub("([^us])s$", "%1")

			if rewrite[smartName] then
				return rewrite[smartName]
			end

			for _, v in next, validNames do
				if v == smartName then
					return smartName
				end
			end

			if smartName:match("^party%d?$") or smartName:match("^arena%d?$") or smartName:match("^boss%d?$") or
				smartName:match("^partypet%d?$") or smartName:match("^raid%d?%d?$") or smartName:match("%w+target$") or
				smartName:match("%w+pet$") then return smartName
			end
		end
	end

	local function guessName(...)
		local name = validName(select(1, ...))

		local n = select("#", ...)
		if n > 1 then
			for i = 2, n do
				local inp = validName(select(i, ...))
				if inp then
					name = (name or "")..inp
				end
			end
		end

		return name
	end

	local smartString = function(name)
		if nameCache[name] then
			return nameCache[name]
		end

		-- Here comes the substitute train!
		local n = name
			:gsub("ToT", "targettarget")
			:gsub("(%l)(%u)", "%1_%2")
			:gsub("([%l%u])(%d)", "%1_%2_")
			:gsub("Main_", "Main")
			:lower()

		n = guessName(string.split("_", n))
		if n then
			nameCache[name] = n
			return n
		end

		return name
	end

	smartName = function(obj, header)
		if type(obj) == "string" then
			return smartString(obj)
		elseif header then
			return smartString(header:GetName())
		else
			local name = obj:GetName()
			if name then
				return smartString(name)
			end

			return obj.unit or "<unknown>"
		end
	end
end

do
	local frame = CreateFrame"Frame"
	frame:SetScript("OnEvent", function(self, event)
		return self[event](self)
	end)

	function frame:VARIABLES_LOADED()
		-- TODO remove after while
		-- I honestly don't trust the load order of CVs
		if ShestakUIPositions == nil then ShestakUIPositions = {} end
		_DB = ShestakUIPositions.UFPos or {}
		ShestakUIPositions.UFPos = _DB

		ShestakUIPositions.UnitFrame = ShestakUIPositions.UnitFrame or {}

		-- Got to catch them all
		for _, obj in next, oUF.objects do
			restorePosition(obj)
		end

		oUF:RegisterInitCallback(restorePosition)
		self:UnregisterEvent("VARIABLES_LOADED")
	end
	frame:RegisterEvent("VARIABLES_LOADED")
end

local getBackdrop
do
	local function UpdateCoords(self)
		local mover = self.child
		local x, y, ap = T.CalculateMoverPoints(mover)
		controls.x:SetText(T.Round(x))
		controls.y:SetText(T.Round(y))

		local frame = mover.target
		frame:ClearAllPoints()
		frame:SetPoint(ap, "UIParent", ap, x, y)
	end

	local coordFrame = CreateFrame("Frame")
	coordFrame:SetScript("OnUpdate", UpdateCoords)
	coordFrame:Hide()

	local OnShow = function(self)
		return self.name:SetText(smartName(self.obj, self.header))
	end

	local OnDragStart = function(self)
		saveDefaultPosition(self.obj)
		self:StartMoving()

		coordFrame.child = self
		coordFrame:Show()
	end

	local OnDragStop = function(self)
		self:StopMovingOrSizing()
		savePosition(self.obj, self)

		coordFrame.child = nil
		coordFrame:Hide()

		self:ClearAllPoints()
		self:SetAllPoints(self.header or self.obj)
	end

	local OnMouseUp = function(self, button)
		if button == "RightButton" then
			local style, identifier = getObjectInformation(self.obj)
			restoreDefaultPosition(style, identifier, self.obj)
		elseif button == "MiddleButton" then
			self:Hide()
		end
	end

	getBackdrop = function(obj, isHeader)
		local target = isHeader or obj
		if not target:GetCenter() then return end
		if backdropPool[target] then return backdropPool[target] end

		local backdrop = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
		backdrop:Hide()

		backdrop:SetFrameStrata("MEDIUM")
		backdrop:SetFrameLevel(20)
		backdrop:SetAllPoints(target)
		backdrop:CreateBackdrop("Transparent")
		backdrop:EnableMouse(true)
		backdrop:SetMovable(true)
		backdrop:SetClampedToScreen(true)
		backdrop:RegisterForDrag("LeftButton")

		backdrop:SetScript("OnShow", OnShow)

		local name = backdrop:CreateFontString(nil, "OVERLAY")
		name:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		name:SetTextColor(1, 1, 1)
		name:SetAllPoints(target)

		backdrop.name = name
		backdrop.obj = obj
		backdrop.header = isHeader
		backdrop.target = target

		backdrop.backdrop:SetBackdropBorderColor(1, 0, 0)

		backdrop.baseWidth, backdrop.baseHeight = obj:GetSize()

		-- We have to define a minHeight on the header if it doesn't have one. The
		-- reason for this is that the header frame will have an height of 0.1 when
		-- it doesn't have any frames visible.
		if isHeader and (not isHeader:GetAttribute("minHeight") and math.floor(isHeader:GetHeight()) == 0 or not isHeader:GetAttribute("minWidth") and math.floor(isHeader:GetWidth()) == 0) then
			isHeader:SetHeight(obj:GetHeight())
			isHeader:SetWidth(obj:GetWidth())

			if not isHeader:GetAttribute("minHeight") then
				isHeader.dirtyMinHeight = true
				isHeader:SetAttribute("minHeight", obj:GetHeight())
			end

			if not isHeader:GetAttribute("minWidth") then
				isHeader.dirtyMinWidth = true
				isHeader:SetAttribute("minWidth", obj:GetWidth())
			end
		elseif isHeader then
			backdrop.baseWidth, backdrop.baseHeight = isHeader:GetSize()
		end

		local frame = backdrop.header or backdrop.obj
		if frame._SetPoint then
			frame.SetPoint = frame._SetPoint
		end

		backdrop:SetScript("OnDragStart", OnDragStart)
		backdrop:SetScript("OnDragStop", OnDragStop)
		backdrop:SetScript("OnEnter", function(self)
			self.backdrop:SetBackdropBorderColor(unpack(C.media.classborder_color))
			ShowControls(backdrop)
		end)
		backdrop:SetScript("OnLeave", function(self)
			self.backdrop:SetBackdropBorderColor(1, 0, 0)
			if not MouseIsOver(controls) then controls:Hide() end
		end)
		backdrop:SetScript("OnMouseUp", OnMouseUp)

		backdropPool[target] = backdrop

		return backdrop
	end
end

StaticPopupDialogs.RESET_UF = {
	text = L_POPUP_RESETUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") else ShestakUIPositions.UFPos = {} ShestakUIPositions.UnitFrame = {} ReloadUI() end end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

SlashCmdList.RESETUF = function() StaticPopup_Show("RESET_UF") end
SLASH_RESETUF1 = "/resetuf"

T.MoveUnitFrames = function()
	if InCombatLockdown() then return print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") end

	if not _LOCK then
		for _, obj in next, oUF.objects do
			if not obj.disableMovement then
				local _, _, isHeader = getObjectInformation(obj)
				local backdrop = getBackdrop(obj, isHeader)
				if backdrop then backdrop:Show() end
			end
		end

		_LOCK = true
	else
		for _, bdrop in next, backdropPool do
			bdrop:Hide()
		end

		controls:Hide()
		_LOCK = nil
	end
end