local T, C, L, _ = unpack(select(2, ...))
if C.skins.capping ~= true then return end

----------------------------------------------------------------------------------------
--	Capping skin
----------------------------------------------------------------------------------------
local CapFrame = CreateFrame("Frame", "CapFrame", UIParent)
local self = CapFrame
local db
local bars = {}

local OnEvent = function(_, event)
	if event == "ADDON_LOADED" and IsAddOnLoaded("Capping") then
		db = CappingDB
		db.texture = "Smooth"
		db.altstyle = false
		db.inset = 0
		hooksecurefunc(Capping, "StartBar", function(...) self:StyleBar(...) end)
		hooksecurefunc(Capping, "StopBar", function() self:SortBars() end)
		hooksecurefunc(Capping, "ModMap", function() self:SortBars() end)
	end
end

function self:SortBars()
	local temp = {}
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
	tb.frame:SetSize(db.width, db.height)
	tb.icon:SetSize(db.height, db.height)
	b.spark:Hide()

	b.timetext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	b.timetext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	b.displaytext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	b.displaytext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

	if db.iconpos == "<-" then
		b.barback:SetPoint("LEFT", b.icon, "RIGHT", 7, 0)
		tb.icon:SetPoint("CENTER", b.icon, "CENTER", 0, 0)
		tb.frame:SetPoint("LEFT", b.icon, "RIGHT", 7, 0)
		tb.frame:SetPoint("RIGHT", b.barback, "RIGHT", 0, 0)
	elseif db.iconpos == "->" then
		b.barback:SetPoint("RIGHT", b.icon, "LEFT", -7, 0)
		tb.icon:SetPoint("CENTER", b.icon, "CENTER", 0, 0)
		tb.frame:SetPoint("RIGHT", b.icon, "LEFT", -7, 0)
		tb.frame:SetPoint("LEFT", b.barback, "LEFT", 0, 0)
	else
		b.barback:SetPoint("LEFT", b, 0, 0)
		b.barback:SetPoint("RIGHT", b, 0, 0)
		tb.icon:Hide()
	end

	if db.reverse == true then
		b.bar:SetPoint("RIGHT", tb.frame, "RIGHT", 0, 0)
	else
		b.bar:SetPoint("LEFT", tb.frame, "LEFT", 0, 0)
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

		i:CreateBackdrop("Default")

		self:PosBar(parent)
		tinsert(bars, parent)
	end

	self:SortBars()

	return
end

self:RegisterEvent("ADDON_LOADED")
self:SetScript("OnEvent", OnEvent)