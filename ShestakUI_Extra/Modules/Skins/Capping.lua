local T, C, L = unpack(ShestakUI)
if C.extra_skins.capping ~= true then return end

----------------------------------------------------------------------------------------
--	Capping skin
----------------------------------------------------------------------------------------
local CapFrame = CreateFrame("Frame", "CapFrame", UIParent)
local self = CapFrame
local db
local bars = {}

local OnEvent = function(obj, event, ...)
	if event == "ADDON_LOADED" and IsAddOnLoaded("Capping") then
		db = CappingDB
		db.texture = "Smooth"
		db.altstyle = false
		db.inset = 0
		hooksecurefunc(Capping, "StartBar", function(...) self:StyleBar(...) end)
		hooksecurefunc(Capping, "StopBar", function(...) self:SortBars() end)
		hooksecurefunc(Capping, "ModMap", function(...) self:SortBars() end)
	end
end

function self:SortBars()
	local temp = { }
	local pdown, pup = -1, -1
	local spacing = db.spacing + 7
	for i = 1, #bars, 1 do temp[i] = i end
	sort(temp, function(a, b) return bars[a].remaining < bars[b].remaining end)

	for _, k in ipairs(temp) do
		local f = bars[k]
		if f:IsShown() then
			f:ClearAllPoints()
			if f.down then
				f:SetPoint("TOPLEFT", bars[pdown] or Capping, "BOTTOMLEFT", 0, -spacing or 1)
				pdown = k
			else
				f:SetPoint("BOTTOMLEFT", bars[pup] or Capping, "TOPLEFT", 0, spacing or 1)
				pup = k
			end
			self:PosBar(f)
		end
	end
end

function self:PosBar(b)
	local tb = bar[b]
	tb.frame:Size(db.width, db.height)
	tb.icon:Size(db.height, db.height)
	b.spark:Hide()

	b.timetext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	b.timetext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	b.displaytext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	b.displaytext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

	if db.iconpos == "<-" then
		b.barback:Point("LEFT", b.icon, "RIGHT", 7, 0)
		tb.icon:Point("CENTER", b.icon, "CENTER", 0, 0)
		tb.frame:Point("LEFT", b.icon, "RIGHT", 7, 0)
		tb.frame:Point("RIGHT", b.barback, "RIGHT", 0, 0)
	elseif db.iconpos == "->" then
		b.barback:Point("RIGHT", b.icon, "LEFT", -7, 0)
		tb.icon:Point("CENTER", b.icon, "CENTER", 0, 0)
		tb.frame:Point("RIGHT", b.icon, "LEFT", -7, 0)
		tb.frame:Point("LEFT", b.barback, "LEFT", 0, 0)
	else
		b.barback:Point("LEFT", b, 0, 0)
		b.barback:Point("RIGHT", b, 0, 0)
		tb.icon:Hide()
	end

	if db.reverse == true then
		b.bar:Point("RIGHT", tb.frame, "RIGHT", 0, 0)
	else
		b.bar:Point("LEFT", tb.frame, "LEFT", 0, 0)
	end
end

function self:StyleBar(...)
	local args = {...}
	local name = args[2]
	local parent = Capping:GetBar(name, true)

	if not bar then bar = {} end

	local p = parent

	if bar[parent] == nil then
		bar[parent] = {
			["frame"] = CreateFrame("Frame", "Frame_"..name, p),
			["icon"] = CreateFrame("Frame", "Icon_"..name, p),
		}
		local t = bar[parent]
		local f = t.frame
		local i = t.icon

		f:CreateBackdrop("Default")
		f.backdrop:Point("TOPLEFT", -2, 2)
		f.backdrop:Point("BOTTOMRIGHT", 2, -2)

		i:CreateBackdrop("Default")
		i.backdrop:Point("TOPLEFT", -2, 2)
		i.backdrop:Point("BOTTOMRIGHT", 2, -2)

		self:PosBar(parent)
		tinsert(bars, parent)
	end

	self:SortBars()

	return
end

self:RegisterEvent("ADDON_LOADED")
self:SetScript("OnEvent", OnEvent)