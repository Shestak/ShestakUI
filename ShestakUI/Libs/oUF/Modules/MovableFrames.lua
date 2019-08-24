local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_MovableFrames(by Haste)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local _DB
local _LOCK

local round = function(n)
	return math.floor(n * 1e5 + .5) / 1e5
end

local backdropPool = {}

local getPoint = function(obj, anchor)
	if not anchor then
		local UIx, UIy = UIParent:GetCenter()
		local Ox, Oy = obj:GetCenter()

		-- Frame doesn't really have a positon yet
		if not Ox then return end

		local UIS = UIParent:GetEffectiveScale()
		local OS = obj:GetEffectiveScale()

		local UIWidth, UIHeight = UIParent:GetRight(), UIParent:GetTop()

		local LEFT = UIWidth / 3
		local RIGHT = UIWidth * 2 / 3

		local point, x, y
		if Ox >= RIGHT then
			point = "RIGHT"
			x = obj:GetRight() - UIWidth
		elseif Ox <= LEFT then
			point = "LEFT"
			x = obj:GetLeft()
		else
			x = Ox - UIx
		end

		local BOTTOM = UIHeight / 3
		local TOP = UIHeight * 2 / 3

		if Oy >= TOP then
			point = "TOP"..(point or "")
			y = obj:GetTop() - UIHeight
		elseif Oy <= BOTTOM then
			point = "BOTTOM"..(point or "")
			y = obj:GetBottom()
		else
			if not point then point = "CENTER" end
			y = Oy - UIy
		end

		return string.format("%s\031%s\031%d\031%d", point, "UIParent", round(x * UIS / OS), round(y * UIS / OS))
	else
		local point, _, _, x, y = anchor:GetPoint()

		return string.format("%s\031%s\031%d\031%d", point, "UIParent", round(x), round(y))
	end
end

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

local restoreDefaultPosition = function(style, identifier)
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

local function restorePosition(obj)
	if InCombatLockdown() then return end
	local style, identifier, isHeader = getObjectInformation(obj)
	-- We've not saved any custom position for this style
	if not _DB[style] or not _DB[style][identifier] then return end

	local scale = obj:GetScale()
	local target = isHeader or obj
	local SetPoint = getmetatable(target).__index.SetPoint

	-- Hah, a spot you have to use semi-colon!
	-- Guess I've never experienced that as these are usually wrapped in do end
	-- statements.
	target.SetPoint = restorePosition
	target:ClearAllPoints()

	-- damn it Blizzard, _how_ did you manage to get the input of this function
	-- reversed. Any sane person would implement this as: split(str, dlm, lim)
	local point, parentName, x, y = string.split("\031", _DB[style][identifier])
	SetPoint(target, point, parentName, point, x / scale, y / scale)
end

local saveDefaultPosition = function(obj)
	local style, identifier, isHeader = getObjectInformation(obj)
	if not _DB.__INITIAL then
		_DB.__INITIAL = {}
	end

	if not _DB.__INITIAL[style] then
		_DB.__INITIAL[style] = {}
	end

	if not _DB.__INITIAL[style][identifier] then
		local point
		if isHeader then
			point = getPoint(isHeader)
		else
			point = getPoint(obj)
		end

		_DB.__INITIAL[style][identifier] = point
	end
end

local savePosition = function(obj, anchor)
	local style, identifier, isHeader = getObjectInformation(obj)
	if not _DB[style] then _DB[style] = {} end

	_DB[style][identifier] = getPoint(isHeader or obj, anchor)
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
		-- I honestly don't trust the load order of CVs
		if SavedOptionsPerChar == nil then SavedOptionsPerChar = {} end
		_DB = SavedOptionsPerChar.UFPos or {}
		SavedOptionsPerChar.UFPos = _DB

		-- Got to catch them all
		for _, obj in next, oUF.objects do
			restorePosition(obj)
		end

		oUF:RegisterInitCallback(restorePosition)
		self:UnregisterEvent("VARIABLES_LOADED")
	end
	frame:RegisterEvent("VARIABLES_LOADED")
end

do
	local function UpdateCoords(self)
		local mover = self.child
		local ap, _, rp, x, y = mover:GetPoint()

		local frame = mover.header or mover.obj
		frame:ClearAllPoints()
		frame:SetPoint(ap, "UIParent", rp, x, y)
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
	end

	local OnMouseUp = function(self, button)
		if button == "RightButton" then
			self.backdrop:SetBackdropColor(0.2, 0.6, 0.2, 0.7)
			local style, identifier = getObjectInformation(self.obj)
			_DB[style][identifier] =  nil
		end
	end

	getBackdrop = function(obj, isHeader)
		local target = isHeader or obj
		if not target:GetCenter() then return end
		if backdropPool[target] then return backdropPool[target] end

		local backdrop = CreateFrame("Frame")
		backdrop:SetParent(UIParent)
		backdrop:Hide()

		backdrop:SetFrameStrata("MEDIUM")
		backdrop:SetFrameLevel(20)
		backdrop:SetAllPoints(target)
		backdrop:CreateBackdrop("Transparent")
		backdrop:EnableMouse(true)
		backdrop:SetMovable(true)
		backdrop:RegisterForDrag("LeftButton")

		backdrop:SetScript("OnShow", OnShow)

		local name = backdrop:CreateFontString(nil, "OVERLAY")
		name:SetFont(C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		name:SetTextColor(1, 1, 1)
		name:SetAllPoints(target)

		backdrop.name = name
		backdrop.obj = obj
		backdrop.header = isHeader

		backdrop.backdrop:SetBackdropBorderColor(1, 0, 0)

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

		backdrop:SetScript("OnDragStart", OnDragStart)
		backdrop:SetScript("OnDragStop", OnDragStop)
		backdrop:SetScript("OnEnter", function(self)
			self.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
		end)
		backdrop:SetScript("OnLeave", function(self)
			self.backdrop:SetBackdropBorderColor(1, 0, 0)
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
	OnAccept = function() if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") else SavedOptionsPerChar.UFPos = {} ReloadUI() end end,
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

		_LOCK = nil
	end
end