local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Based on LitePanels(by Katae)
----------------------------------------------------------------------------------------
local lp, hidden, deps = CreateFrame("Frame", "lp_C"), {}, {} lp:Hide()

lpanels = {
	profile = {}, temp = {},
	cinfo = {
		n = strlower(UnitName("player")),
		r = strlower(gsub(GetRealmName(), " ", "")),
		c = strlower(select(2, UnitClass("player")))
	},
	defaults = {
		parent = "UIParent", strata = "BACKGROUND",
		anchor_to = "BOTTOMLEFT", anchor_from = "BOTTOMLEFT",
		x_off = 0, y_off = 0, height = 0, width = 0,
		text = {
			string = "", font = "Fonts/FRIZQT__.TTF", size = 12,
			justify_h = "CENTER", justify_v = "MIDDLE",
			anchor_to = "CENTER", anchor_from = "CENTER",
			x_off = 0, y_off = 0, color = "1 1 1", alpha = 1,
			shadow = {color = "0 0 0", alpha = 1, y = -1, x = 1},
		}
	},
	events = {"OnEvent", "OnUpdate", "OnResize", "OnClick", "OnDoubleClick", "OnMouseUp", "OnMouseDown", "OnEnter", "OnLeave", "OnHide", "OnShow"},
	defaultv = {"anchor_to", "x_off", "y_off", "width", "height", "strata"},
}

local gsub = string.gsub
local strmatch = string.match
local type = type
local floor = math.floor
local unpack = unpack
local pairs = pairs
local ipairs = ipairs
local IsAddOnLoaded = IsAddOnLoaded
local hooksecurefunc = hooksecurefunc

local r, is = function(n, dec) return floor(n * (10 ^ (dec or 0)) + 0.5) end, function(v, t) return type(v) == t end
local d = lpanels.defaults

local class = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[strupper(lpanels.cinfo.c)]
local function setcolor(color)
	if color == "CLASS" then
		return class.r, class.g, class.b
	elseif is(color, "string") then
		return strmatch(color, "([%d%.]+)%s+([%d%.]+)%s+([%d%.]+)")
	else return unpack(color) end
end

----------------------------------------------------------------------------------------
-- API: lpanels:CreateLayout("Layout Name", { _layout code_ }
--	» arg1 - Layout name. Name can be anything at all.
--	» arg2 - Table with your layout code, can also be set as a variable.
function lpanels:CreateLayout(name, layout)
	if name and layout then
		self.profile[name] = layout or {}
	end
end

----------------------------------------------------------------------------------------
-- API: lpanels:ApplyLayout("n:Character r:Realm c:Class", "layout1", "layout2")
--	» arg1 - Profile string: May be set to any combination of n:ame, r:ealm, c:lass,
--		separated by a single space. If nil, applies the specified layouts to all
--		characters. Additionally, a dash may be applied to front of the
--		condition (-n:ame -r:ealm -c:lass) to make the layout NOT load on the specified
--		value. The profile string is *not* CASE-sensitive.
--	» arg2,... - Layout names created by CreateLayout() to apply to this profile. No set
--		limit to how many layouts can be applied per profile.
function lpanels:MatchProf(profile, AND)
	local apply = false
	for a, str in gmatch(profile, "(%-?[nrc]):([^%s]+)") do
		if strmatch(self.cinfo[strlower(strsub(a, -1, -1))], strlower(str)) then
			if strmatch(a, "^%-") then return false else apply = true end
		elseif strmatch(a, "^%-") then apply = true elseif AND then return false end
	end
	return apply
end
function lpanels:ApplyLayout(profile, ...)
	if not profile or profile == "" then profile = "n:"..self.cinfo.n end
	while strfind(profile, "%(.-%)") do
		for prof in gmatch(profile, "%(([^%(]-)%)") do
			profile = gsub(profile, "%("..gsub(prof, "%-", "%%%-").."%)", self:MatchProf(prof, 1) and "n:"..self.cinfo.n or "n:x")
		end
	end
	if self:MatchProf(profile) then
		for _, name in ipairs{...} do
			if self.profile[name] then
				for _, f in ipairs(self.profile[name]) do self.profile[#self.profile + 1] = f end
			end
			self.profile[name] = nil
		end
	end
end

----------------------------------------------------------------------------------------
-- Core
function lpanels.RegisterEvent(self, event)
	if event == "PLAYER_LOGIN" then lpanels.temp.OnEvent(self, "PLAYER_LOGIN") end
end

local function Resize(panel, width, height)
	if width and height and (strmatch(width, "%d+%%") or strmatch(height, "%d+%%")) then
		-- Resize based on the panel's anchor frame or parent if no anchor
		local _, parent = panel:GetPoint()
		local function hook(_, _width, _height)
			if strmatch(width, "%%") then panel:SetWidth(_width * strmatch(width,"(%d+)%%") * 0.01 + (strmatch(width, "%%%s([%+%-]%d+)") or 0)) end
			if strmatch(height, "%%") then panel:SetHeight(_height * strmatch(height,"(%d+)%%") * 0.01 + (strmatch(height, "%%.*([%+%-]%d+)") or 0)) end
		end
		parent:HookScript("OnSizeChanged", hook)
	end
end

function lpanels:MakePanel(f)
	-- Setting a few defaults
	for _, attr in ipairs(self.defaultv) do if not f[attr] then f[attr] = d[attr] end end

	-- Setting parent/anchor
	local origparent, origanchor
	for _, frame in pairs{f.parent, f.anchor_frame} do
		if is(frame, "string") and not _G[frame] then
			if not hidden[frame] then hidden[frame] = {} end tinsert(hidden[frame], f.name)
			f.parent, origparent, origanchor, f.anchor_frame = "lp_C", f.parent, f.anchor_frame
		end
	end
	f.parent = _G[f.parent] or _G[d.parent]

	-- Create frame; object name will be LP_PanelName or LP_i if anonymous
	local panel = CreateFrame("Frame", f.name, f.parent)
	panel.bg = panel:CreateTexture(nil, "BACKGROUND")

	-- Inserting some data into frame table
	if f.parent == lp_C then panel.parent, panel.anchor_frame, panel.strata, panel.level = origparent, origanchor, f.strata, f.level end
	panel.width, panel.height = f.width, f.height

	-- Hide dependant frames, will show later for late loading addons
	if f.require and not IsAddOnLoaded(f.require) then deps[f.name] = f.require panel:Hide() end

	-- Set positions
	panel:SetParent(f.parent)
	panel:ClearAllPoints()
	if strmatch(f.x_off, "%%") then f.x_off = (_G[f.anchor_frame] or f.parent):GetWidth() * strmatch(f.x_off,"(%d+)%%") * 0.01 end
	if strmatch(f.y_off, "%%") then f.y_off = (_G[f.anchor_frame] or f.parent):GetHeight() * strmatch(f.y_off,"(%d+)%%") * 0.01 end
	panel:SetPoint(strupper(f.anchor_to), _G[f.anchor_frame] or f.parent, strupper(f.anchor_from or f.anchor_to), f.x_off, f.y_off)
	if f.scale then panel:SetScale(f.scale) end

	-- Height, width
	if f.parent ~= lp then Resize(panel, f.width, f.height) end
	panel:SetWidth(strmatch(f.width, "%%") and (_G[f.anchor_frame] or f.parent):GetWidth() * strmatch(f.width, "(%d+)%%") * 0.01 or f.width)
	panel:SetHeight(strmatch(f.height, "%%") and (_G[f.anchor_frame] or f.parent):GetHeight() * strmatch(f.height, "(%d+)%%") * 0.01 or f.height)

	-- Strata, level
	panel:SetFrameStrata(f.strata or d.strata)
	if f.level then panel:SetFrameLevel(f.level) end

	-- Texts
	if f.text then
		-- If f.text contains multiple tables, treat those tables as multiple text objects; name them self.text1, text2, text3, ...
		f.text = is(f.text[1], "table") and f.text or {f.text}
		for i, t in ipairs(f.text) do
			if #f.text == 1 then i = "" end
			if is(t, "string") then t = {string = t} end
			panel["text"..i] = panel:CreateFontString(nil, "OVERLAY")
			local text = panel["text"..i]

			-- Keep text string and frame height/width the same if nil
			if i == "" and (not f.width or not f.height or f.width == 0 or f.height == 0) then
				local function settext()
					panel:SetWidth(text:GetStringWidth())
					panel:SetHeight(text:GetStringHeight())
				end
				hooksecurefunc(text, "SetText", settext)
			end

			-- Texts font
			if t.font and not strmatch(t.font, "[/\\]") then t.font = C.font.stats_font end
			local flags = C.font.stats_font_style
			if t.mono then flags = (flags and flags..", " or "").."MONOCHROME" end
			text:SetFont(t.font or d.text.font, t.size or d.text.size, flags)
			if not text:GetFont() then -- handle invalid font error
				text:SetFont(d.text.font, t.size or d.text.size, flags)
				print("|cffffffffLite|cff66C6FFPanels |cffff5555Font invalid:", strmatch(t.font, "([^/\\]+)$"))
			end

			-- Texts string
			if not t.string then t.string = d.text.string end
			text:SetText(is(t.string, "function") and t.string(text) or t.string)

			-- Texts color
			local tx_r, tx_g, tx_b = setcolor(t.color or d.text.color)
			text:SetTextColor(tx_r, tx_g, tx_b, t.alpha or d.text.alpha)

			-- Texts shadow
			if (not t.shadow and not t.outline) or (t.shadow and t.shadow ~= 0) then
				if not t.shadow then t.shadow = d.text.shadow end
				if is(t.shadow, "number") then t.shadow = {x = t.shadow, y = -t.shadow, alpha = d.text.shadow.alpha} end
				if is(t.shadow, "table") then
					local sh_r, sh_g, sh_b = setcolor(t.shadow.color or d.text.shadow.color)
					text:SetShadowOffset(t.shadow.x or d.text.shadow.x, t.shadow.y or d.text.shadow.y)
					text:SetShadowColor(sh_r, sh_g, sh_b, t.shadow.alpha or d.text.shadow.alpha)
				end
			end

			-- Texts positioning within panel
			text:SetJustifyH(t.justify_h or d.text.justify_h)
			text:SetJustifyV(t.justify_v or d.text.justify_v)
			text:SetPoint(strupper(t.anchor_to or d.text.anchor_to), panel, strupper(t.anchor_to or t.anchor_from or d.text.anchor_from), t.x_off or d.text.x_off, t.y_off or d.text.y_off)

			-- If it exists, hook text function to the frame's OnUpdate script
			if is(t.string, "function") and t.update ~= 0 then
				text.elapsed = 0
				local update, string = t.update or 1, t.string
				local function OnUpdate(self, u)
					text.elapsed = text.elapsed + u
					if text.elapsed > update then text:SetText(string(text)) text.elapsed = 0 end
				end
				if not f.OnUpdate then f.OnUpdate = OnUpdate else hooksecurefunc(f, "OnUpdate", OnUpdate) end
			end
		end
	end

	-- OnLoad handler
	if f.OnLoad then
		if f.OnEvent then -- fake PLAYER_LOGIN; it should have already fired
			hooksecurefunc(panel, "RegisterEvent", self.RegisterEvent)
			self.temp.OnEvent = f.OnEvent
		end
		f.OnLoad(panel)
	end

	-- Scripting functions, args passed to layout's function
	if f.mouse ~= false and (f.mouse or f.OnClick or f.OnMouseDown or f.OnMouseUp or f.OnDoubleClick or f.OnEnter or f.OnLeave) then panel:EnableMouse(true) end
	for _, action in ipairs(lpanels.events) do
		local func = f[action]
		if is(func, "function") then
			if action == "OnDoubleClick" then
				panel.timer, panel.button = 0, nil
				local function hook(self, button)
					if self.timer and self.timer < time() then self.startTimer = false end
					if self.timer == time() and self.button == button and self.startTimer then
						self.startTimer = false
						func(self, button)
					else
						self.startTimer, self.timer, self.button = true, time(), button
					end
				end
				panel:HookScript("OnMouseUp", hook)
			else
				if action == "OnUpdate" then panel.elapsed = 0 end
				panel:HookScript(gsub(gsub(action, "OnClick", "OnMouseUp"), "Resize", "SizeChanged"), func)
			end
		end
	end
end

function lpanels:Init()
	if #self.profile == 0 then return end

	-- Check if parent/anchor names are the names of other panels, then tag with "LP_"
	for i, f in ipairs(self.profile) do for _, p in ipairs(self.profile) do
		if f.name ~= nil then
			if f.name == p.parent then p.parent = "LP_"..p.parent end
			if f.name == p.anchor_frame then p.anchor_frame = "LP_"..p.anchor_frame end
		end
	end f.name = f.name and "LP_"..f.name or "LP_"..i end

	-- Begin to cycle through user profile and create panels
	for _, f in ipairs(self.profile) do self:MakePanel(f) end
end

function lpanels:Exit()
	r, is, class, setcolor = nil
	for k in pairs(self) do self[k] = nil end
	self.reset = 1 self.reset = nil
end

function lpanels.OnEvent(self, event)
	if event == "PLAYER_LOGIN" then
		lpanels:Init()
		lpanels = lpanels:Exit()
	elseif event == "ADDON_LOADED" and deps then
		for frame, addon in pairs(deps) do
			if IsAddOnLoaded(addon) then _G[frame]:Show() frame = nil end
		end
	end
end

function lpanels.CreateFrame(_, frame)
	if not hidden[frame] then return end
	for i, child in ipairs(hidden[frame]) do
		local panel = _G[child]
		if not panel.anchor_frame or _G[panel.anchor_frame] then
			local points = {panel:GetPoint()} points[2] = _G[panel.anchor_frame] or frame
			panel:SetParent(frame or UIParent)
			panel:ClearAllPoints()
			panel:SetPoint(unpack(points))
			Resize(panel, panel.width, panel.height)
			panel:SetFrameStrata(panel.strata)
			if panel.level then panel:SetFrameLevel(panel.level) end
			hidden[frame][i] = nil
		end
	end
	if #hidden[frame] == 0 then hidden[frame] = nil end
end

hooksecurefunc("CreateFrame", lpanels.CreateFrame)

lp:RegisterEvent("ADDON_LOADED")
lp:RegisterEvent("PLAYER_LOGIN")
lp:SetScript("OnEvent", lpanels.OnEvent)