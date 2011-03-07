local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Temporary stuff for extras mod build around 2.9 or less to be compatible with 3.0
----------------------------------------------------------------------------------------
-- Pixel perfect script of custom ui scale
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/C.general.uiscale
local scale = function(x)
    return mult*math.floor(x/mult+0.5)
end

T.Scale = function(x) return scale(x) end
T.mult = mult

-- Template functions
local backdrop = {
	bgFile = C.media.blank, edgeFile = C.media.blank,
	tile = false, tileSize = 0,	edgeSize = mult,
	insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
}

T.SetOverlay = function(f)
	if f.bg then return end
	f.bg = f:CreateTexture(f:GetName() and f:GetName().."_overlay" or nil, "BORDER", f)
	f.bg:ClearAllPoints()
	f.bg:SetPoint("TOPLEFT", f, "TOPLEFT", mult, -mult)
	f.bg:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -mult, mult)
	f.bg:SetTexture(C.media.texture)
	f.bg:SetVertexColor(0.1, 0.1, 0.1, 1)
	return f.bg
end

T.SkinPanel = function(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(C.media.backdrop_color))
	f:SetBackdropBorderColor(unpack(C.media.border_color))
	T.SetOverlay(f)
end

T.CreatePanel = function(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)	
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	T.SkinPanel(f)
end

T.CreateTemplate = function(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(C.media.backdrop_color))
	f:SetBackdropBorderColor(unpack(C.media.border_color))
end

T.StyleInnerBorder = function(f)
	if f.iborder then return end
	f.iborder = CreateFrame("Frame", nil, f)
	f.iborder:SetPoint("TOPLEFT", mult, -mult)
	f.iborder:SetPoint("BOTTOMRIGHT", -mult, mult)
	f.iborder:SetBackdrop({
		edgeFile = C.media.blank, 
		edgeSize = mult, 
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	})
	f.iborder:SetBackdropBorderColor(unpack(C.media.backdrop_color))
	return f.iborder
end

T.StyleOuterBorder = function(f)
	if f.oborder then return end
	f.oborder = CreateFrame("Frame", nil, f)
	f.oborder:SetPoint("TOPLEFT", -mult, mult)
	f.oborder:SetPoint("BOTTOMRIGHT", mult, -mult)
	f.oborder:SetBackdrop({
		edgeFile = C.media.blank, 
		edgeSize = mult, 
		insets = { left = mult, right = mult, top = mult, bottom = mult }
	})
	f.oborder:SetBackdropBorderColor(unpack(C.media.backdrop_color))
	return f.oborder
end

T.SkinFadedPanel = function(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(C.media.overlay_color))
	f:SetBackdropBorderColor(unpack(C.media.border_color))
	T.StyleInnerBorder(f)
	T.StyleOuterBorder(f)
end

T.CreateFadedPanel = function(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	T.SkinFadedPanel(f)
end

T.CreateBlizzard = function(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(C.media.overlay_color))
	f:SetBackdropBorderColor(unpack(C.media.border_color))
end

-- Kill object function
T.Kill = function(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = T.dummy
	object:Hide()
end

-- Style ActionBars/Bags buttons function(by Chiril & Karudon)
T.StyleButton = function(b, checked) 
    local name = b:GetName()
    local button = _G[name]
    local icon = _G[name.."Icon"]
    local count = _G[name.."Count"]
    local border = _G[name.."Border"]
    local hotkey = _G[name.."HotKey"]
    local cooldown = _G[name.."Cooldown"]
    local nametext = _G[name.."Name"]
    local flash = _G[name.."Flash"]
    local normaltexture = _G[name.."NormalTexture"]
	local icontexture = _G[name.."IconTexture"]
 
    local hover = b:CreateTexture("Frame", nil, self)
    hover:SetTexture(1, 1, 1, 0.3)
    hover:SetHeight(button:GetHeight())
    hover:SetWidth(button:GetWidth())
    hover:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
    hover:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
    button:SetHighlightTexture(hover)
 
    local pushed = b:CreateTexture("Frame", nil, self)
    pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
    pushed:SetHeight(button:GetHeight())
    pushed:SetWidth(button:GetWidth())
    pushed:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
    pushed:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
    button:SetPushedTexture(pushed)
 
	if checked then
		local checked = b:CreateTexture("Frame", nil, self)
		checked:SetTexture(0, 1, 0, 0.3)
		checked:SetHeight(button:GetHeight())
		checked:SetWidth(button:GetWidth())
		checked:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		checked:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
		button:SetCheckedTexture(checked)
	end
	
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
end