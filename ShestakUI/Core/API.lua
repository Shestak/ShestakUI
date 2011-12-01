local T, C, L = unpack(select(2, ...))

local floor = math.floor
local texture = C.media.blank
local backdropr, backdropg, backdropb, backdropa, borderr, borderg, borderb, bordera = 0, 0, 0, 1, 0, 0, 0, 1

----------------------------------------------------------------------------------------
--	Pixel perfect size/width/height functions
----------------------------------------------------------------------------------------
local function Size(frame, width, height)
	frame:SetSize(T.Scale(width), T.Scale(height or width))
end

local function Width(frame, width)
	frame:SetWidth(T.Scale(width))
end

local function Height(frame, height)
	frame:SetHeight(T.Scale(height))
end

local function Point(obj, arg1, arg2, arg3, arg4, arg5)
	if type(arg1) == "number" then arg1 = T.Scale(arg1) end
	if type(arg2) == "number" then arg2 = T.Scale(arg2) end
	if type(arg3) == "number" then arg3 = T.Scale(arg3) end
	if type(arg4) == "number" then arg4 = T.Scale(arg4) end
	if type(arg5) == "number" then arg5 = T.Scale(arg5) end

	obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
end

----------------------------------------------------------------------------------------
--	Template functions
----------------------------------------------------------------------------------------
local function CreateOverlay(f)
	if f.overlay then return end

	local overlay = f:CreateTexture(f:GetName() and f:GetName().."Overlay" or nil, "BORDER", f)
	overlay:ClearAllPoints()
	overlay:Point("TOPLEFT", 2, -2)
	overlay:Point("BOTTOMRIGHT", -2, 2)
	overlay:SetTexture(C.media.blank)
	overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	f.overlay = overlay
end

local function CreateBorder(f, i, o)
	if i then
		if f.iborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName().."InnerBorder" or nil, f)
		border:Point("TOPLEFT", T.mult, -T.mult)
		border:Point("BOTTOMRIGHT", -T.mult, T.mult)
		border:SetBackdrop({
			edgeFile = C.media.blank, edgeSize = T.mult,
			insets = {left = T.mult, right = T.mult, top = T.mult, bottom = T.mult}
		})
		border:SetBackdropBorderColor(unpack(C.media.backdrop_color))
		f.iborder = border
	end

	if o then
		if f.oborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName().."OuterBorder" or nil, f)
		border:Point("TOPLEFT", -T.mult, T.mult)
		border:Point("BOTTOMRIGHT", T.mult, -T.mult)
		border:SetFrameLevel(f:GetFrameLevel() + 1)
		border:SetBackdrop({
			edgeFile = C.media.blank, edgeSize = T.mult,
			insets = {left = T.mult, right = T.mult, top = T.mult, bottom = T.mult}
		})
		border:SetBackdropBorderColor(unpack(C.media.backdrop_color))
		f.oborder = border
	end
end

local function GetTemplate(t)
	if t == "ClassColor" then
		local c = T.oUF_colors.class[T.class]
		borderr, borderg, borderb, bordera = c[1], c[2], c[3], c[4]
		backdropr, backdropg, backdropb, backdropa = unpack(C.media.backdrop_color)
	else
		borderr, borderg, borderb, bordera = unpack(C.media.border_color)
		backdropr, backdropg, backdropb, backdropa = unpack(C.media.backdrop_color)
	end
end

local function SetTemplate(f, t, tex)
	if tex then texture = C.media.texture else texture = C.media.blank end

	GetTemplate(t)

	f:SetBackdrop({
		bgFile = C.media.blank,
		edgeFile = C.media.blank,
		tile = false, tileSize = 0, edgeSize = T.mult,
		insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult}
	})

	if t == "Transparent" then
		backdropa = 0.7
		f:CreateBorder(true, true)
	elseif t == "Overlay" then
		backdropa = 1
		f:CreateOverlay()
	else
		backdropa = 1
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

local function CreatePanel(f, t, w, h, a1, p, a2, x, y)
	GetTemplate(t)

	f:Width(w)
	f:Height(h)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:Point(a1, p, a2, x, y)
	f:SetBackdrop({
		bgFile = C.media.blank,
		edgeFile = C.media.blank,
		tile = false, tileSize = 0, edgeSize = T.mult,
		insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult}
	})

	if t == "Transparent" then
		backdropa = 0.7
		f:CreateBorder(true, true)
	elseif t == "Overlay" then
		backdropa = 1
		f:CreateOverlay()
	elseif t == "Invisible" then
		backdropa = 0
		bordera = 0
	else
		backdropa = 1
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

local function CreateBackdrop(f, t, tex)
	if not t then t = "Default" end

	local b = CreateFrame("Frame", nil, f)
	b:Point("TOPLEFT", -2, 2)
	b:Point("BOTTOMRIGHT", 2, -2)
	b:SetTemplate(t, tex)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end

	f.backdrop = b
end

local function StripTextures(object, kill)
	for i = 1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				region:Kill()
			else
				region:SetTexture(nil)
			end
		end
	end
end

----------------------------------------------------------------------------------------
--	Kill object function
----------------------------------------------------------------------------------------
local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = T.dummy
	object:Hide()
end

----------------------------------------------------------------------------------------
--	Style ActionBars/Bags buttons function(by Chiril & Karudon)
----------------------------------------------------------------------------------------
local function StyleButton(b, c) 
	local name = b:GetName()
	local button = _G[name]
	local cooldown = _G[name.."Cooldown"]

	local hover = b:CreateTexture("Frame", nil, self)
	hover:SetTexture(1, 1, 1, 0.3)
	hover:Size(button:GetWidth(), button:GetHeight())
	hover:Point("TOPLEFT", button, 2, -2)
	hover:Point("BOTTOMRIGHT", button, -2, 2)
	button:SetHighlightTexture(hover)

	local pushed = b:CreateTexture("Frame", nil, self)
	pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
	pushed:Size(button:GetWidth(), button:GetHeight())
	pushed:Point("TOPLEFT", button, 2, -2)
	pushed:Point("BOTTOMRIGHT", button, -2, 2)
	button:SetPushedTexture(pushed)
 
	if c then
		local checked = b:CreateTexture("Frame", nil, self)
		checked:SetTexture(0, 1, 0, 0.3)
		checked:Size(button:GetWidth(), button:GetHeight())
		checked:Point("TOPLEFT", button, 2, -2)
		checked:Point("BOTTOMRIGHT", button, -2, 2)
		button:SetCheckedTexture(checked)
	end

	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:Point("TOPLEFT", button, 2, -2)
		cooldown:Point("BOTTOMRIGHT", button, -2, 2)
	end
end

----------------------------------------------------------------------------------------
--	Style buttons function
----------------------------------------------------------------------------------------
T.SetModifiedBackdrop = function(self)
	self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	if self.overlay then
		self.overlay:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.3)
	end
end

T.SetOriginalBackdrop = function(self)
	self:SetBackdropBorderColor(unpack(C.media.border_color))
	if self.overlay then
		self.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	end
end

local function SkinButton(f, strip)
	if f.SetNormalTexture then f:SetNormalTexture("") end
	if f.SetHighlightTexture then f:SetHighlightTexture("") end
	if f.SetPushedTexture then f:SetPushedTexture("") end
	if f.SetDisabledTexture then f:SetDisabledTexture("") end
	if strip then f:StripTextures() end

	if f:GetName() then
		if _G[f:GetName().."Left"] then _G[f:GetName().."Left"]:SetAlpha(0) end
		if _G[f:GetName().."Middle"] then _G[f:GetName().."Middle"]:SetAlpha(0) end
		if _G[f:GetName().."Right"] then _G[f:GetName().."Right"]:SetAlpha(0) end
		if _G[f:GetName().."LeftDisabled"] then _G[f:GetName().."LeftDisabled"]:SetAlpha(0) end
		if _G[f:GetName().."MiddleDisabled"] then _G[f:GetName().."MiddleDisabled"]:SetAlpha(0) end
		if _G[f:GetName().."RightDisabled"] then _G[f:GetName().."RightDisabled"]:SetAlpha(0) end
		if _G[f:GetName().."HighlightTexture"] then _G[f:GetName().."HighlightTexture"]:SetAlpha(0) end
	end

	f:SetTemplate("Overlay")
	f:HookScript("OnEnter", T.SetModifiedBackdrop)
	f:HookScript("OnLeave", T.SetOriginalBackdrop)
end

----------------------------------------------------------------------------------------
--	Font function
----------------------------------------------------------------------------------------
local function FontString(parent, name, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")

	if not name then
		parent.text = fs
	else
		parent[name] = fs
	end

	return fs
end

----------------------------------------------------------------------------------------
--	Fade in/out functions
----------------------------------------------------------------------------------------
local function FadeIn(f)
	UIFrameFadeIn(f, 0.4, f:GetAlpha(), 1)
end

local function FadeOut(f)
	UIFrameFadeOut(f, 0.8, f:GetAlpha(), 0)
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.Size then mt.Size = Size end
	if not object.Width then mt.Width = Width end
	if not object.Height then mt.Height = Height end
	if not object.Point then mt.Point = Point end
	if not object.CreateOverlay then mt.CreateOverlay = CreateOverlay end
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.SetTemplate then mt.SetTemplate = SetTemplate end
	if not object.CreatePanel then mt.CreatePanel = CreatePanel end
	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	if not object.StripTextures then mt.StripTextures = StripTextures end
	if not object.Kill then mt.Kill = Kill end
	if not object.StyleButton then mt.StyleButton = StyleButton end
	if not object.SkinButton then mt.SkinButton = SkinButton end
	if not object.FontString then mt.FontString = FontString end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end