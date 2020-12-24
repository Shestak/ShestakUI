local T, C, L, _ = unpack(select(2, ...))

local backdropr, backdropg, backdropb, backdropa = unpack(C.media.backdrop_color)
local borderr, borderg, borderb, bordera = unpack(C.media.border_color)

local Mult = T.mult
if T.screenHeight > 1200 then
	Mult = T.Scale(1)
end

----------------------------------------------------------------------------------------
--	Position functions
----------------------------------------------------------------------------------------
local function SetOutside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 2
	yOffset = yOffset or 2
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then
		obj:ClearAllPoints()
	end

	obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
	obj:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", xOffset, -yOffset)
end

local function SetInside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 2
	yOffset = yOffset or 2
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then
		obj:ClearAllPoints()
	end

	obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
	obj:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end

----------------------------------------------------------------------------------------
--	Template functions
----------------------------------------------------------------------------------------
local function CreateOverlay(f)
	if f.overlay then return end

	local overlay = f:CreateTexture("$parentOverlay", "BORDER", f)
	overlay:SetPoint("TOPLEFT", 2, -2)
	overlay:SetPoint("BOTTOMRIGHT", -2, 2)
	overlay:SetTexture(C.media.blank)
	overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	f.overlay = overlay
end

local function CreateBorder(f, i, o)
	if i then
		if f.iborder then return end
		local border = CreateFrame("Frame", "$parentInnerBorder", f, "BackdropTemplate")
		border:SetPoint("TOPLEFT", Mult, -Mult)
		border:SetPoint("BOTTOMRIGHT", -Mult, Mult)
		border:SetBackdrop({
			edgeFile = C.media.blank, edgeSize = Mult,
			insets = {left = Mult, right = Mult, top = Mult, bottom = Mult}
		})
		border:SetBackdropBorderColor(unpack(C.media.backdrop_color))
		f.iborder = border
	end

	if o then
		if f.oborder then return end
		local border = CreateFrame("Frame", "$parentOuterBorder", f, "BackdropTemplate")
		border:SetPoint("TOPLEFT", -Mult, Mult)
		border:SetPoint("BOTTOMRIGHT", Mult, -Mult)
		border:SetFrameLevel(f:GetFrameLevel() + 1)
		border:SetBackdrop({
			edgeFile = C.media.blank, edgeSize = Mult,
			insets = {left = Mult, right = Mult, top = Mult, bottom = Mult}
		})
		border:SetBackdropBorderColor(unpack(C.media.backdrop_color))
		f.oborder = border
	end
end

local function GetTemplate(t)
	if t == "ClassColor" then
		borderr, borderg, borderb, bordera = unpack(C.media.classborder_color)
		backdropr, backdropg, backdropb, backdropa = unpack(C.media.backdrop_color)
	else
		borderr, borderg, borderb, bordera = unpack(C.media.border_color)
		backdropr, backdropg, backdropb, backdropa = unpack(C.media.backdrop_color)
	end
end

local function SetTemplate(f, t)
	Mixin(f, BackdropTemplateMixin) -- 9.0 to set backdrop
	GetTemplate(t)

	f:SetBackdrop({
		bgFile = C.media.blank, edgeFile = C.media.blank, edgeSize = Mult,
		insets = {left = -Mult, right = -Mult, top = -Mult, bottom = -Mult}
	})

	if t == "Transparent" then
		backdropa = C.media.backdrop_alpha
		f:CreateBorder(true, true)
	elseif t == "Overlay" then
		backdropa = 1
		f:CreateOverlay()
	else
		backdropa = C.media.backdrop_color[4]
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

local function CreatePanel(f, t, w, h, a1, p, a2, x, y)
	Mixin(f, BackdropTemplateMixin) -- 9.0 to set backdrop
	GetTemplate(t)

	f:SetWidth(w)
	f:SetHeight(h)
	f:SetFrameLevel(3)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
		bgFile = C.media.blank, edgeFile = C.media.blank, edgeSize = Mult,
		insets = {left = -Mult, right = -Mult, top = -Mult, bottom = -Mult}
	})

	if t == "Transparent" then
		backdropa = C.media.backdrop_alpha
		f:CreateBorder(true, true)
	elseif t == "Overlay" then
		backdropa = 1
		f:CreateOverlay()
	elseif t == "Invisible" then
		backdropa = 0
		bordera = 0
	else
		backdropa = C.media.backdrop_color[4]
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

local function CreateBackdrop(f, t)
	if f.backdrop then return end
	if not t then t = "Default" end

	local b = CreateFrame("Frame", "$parentBackdrop", f)
	b:SetPoint("TOPLEFT", -2, 2)
	b:SetPoint("BOTTOMRIGHT", 2, -2)
	b:SetTemplate(t)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end

	f.backdrop = b
end

local StripTexturesBlizzFrames = {
	"Inset",
	"inset",
	"InsetFrame",
	"LeftInset",
	"RightInset",
	"NineSlice",
	"BG",
	"border",
	"Border",
	"BorderFrame",
	"bottomInset",
	"BottomInset",
	"bgLeft",
	"bgRight",
	"FilligreeOverlay"
}

local function StripTextures(object, kill)
	if object.GetNumRegions then
		for i = 1, object:GetNumRegions() do
			local region = select(i, object:GetRegions())
			if region and region:GetObjectType() == "Texture" then
				if kill then
					region:Kill()
				else
					region:SetTexture(nil)
				end
			end
		end
	end

	local frameName = object.GetName and object:GetName()
	for _, blizzard in pairs(StripTexturesBlizzFrames) do
		local blizzFrame = object[blizzard] or frameName and _G[frameName..blizzard]
		if blizzFrame then
			blizzFrame:StripTextures(kill)
		end
	end
end

----------------------------------------------------------------------------------------
--	Kill object function
----------------------------------------------------------------------------------------
local HiddenFrame = CreateFrame("Frame")
HiddenFrame:Hide()
local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
		object:SetParent(HiddenFrame)
	else
		object.Show = T.dummy
	end
	object:Hide()
end

----------------------------------------------------------------------------------------
--	Style ActionBars/Bags buttons function(by Chiril & Karudon)
----------------------------------------------------------------------------------------
local function StyleButton(button, t, size)
	if not size then size = 2 end
	if button.SetHighlightTexture and not button.hover then
		local hover = button:CreateTexture()
		hover:SetColorTexture(1, 1, 1, 0.3)
		hover:SetPoint("TOPLEFT", button, size, -size)
		hover:SetPoint("BOTTOMRIGHT", button, -size, size)
		button.hover = hover
		button:SetHighlightTexture(hover)
	end

	if not t and button.SetPushedTexture and not button.pushed then
		local pushed = button:CreateTexture()
		pushed:SetColorTexture(0.9, 0.8, 0.1, 0.3)
		pushed:SetPoint("TOPLEFT", button, size, -size)
		pushed:SetPoint("BOTTOMRIGHT", button, -size, size)
		button.pushed = pushed
		button:SetPushedTexture(pushed)
	end

	if button.SetCheckedTexture and not button.checked then
		local checked = button:CreateTexture()
		checked:SetColorTexture(0, 1, 0, 0.3)
		checked:SetPoint("TOPLEFT", button, size, -size)
		checked:SetPoint("BOTTOMRIGHT", button, -size, size)
		button.checked = checked
		button:SetCheckedTexture(checked)
	end

	local cooldown = button:GetName() and _G[button:GetName().."Cooldown"]
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, size, -size)
		cooldown:SetPoint("BOTTOMRIGHT", button, -size, size)
	end
end

----------------------------------------------------------------------------------------
--	Style buttons function
----------------------------------------------------------------------------------------
T.SetModifiedBackdrop = function(self)
	if self:IsEnabled() then
		self:SetBackdropBorderColor(unpack(C.media.classborder_color))
		if self.overlay then
			self.overlay:SetVertexColor(C.media.classborder_color[1] * 0.3, C.media.classborder_color[2] * 0.3, C.media.classborder_color[3] * 0.3, 1)
		end
	end
end

T.SetOriginalBackdrop = function(self)
	self:SetBackdropBorderColor(unpack(C.media.border_color))
	if self.overlay then
		self.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	end
end

local function SkinButton(f, strip)
	if strip then f:StripTextures() end

	if f.SetNormalTexture then f:SetNormalTexture("") end
	if f.SetHighlightTexture then f:SetHighlightTexture("") end
	if f.SetPushedTexture then f:SetPushedTexture("") end
	if f.SetDisabledTexture then f:SetDisabledTexture("") end

	if f.Left then f.Left:SetAlpha(0) end
	if f.Right then f.Right:SetAlpha(0) end
	if f.Middle then f.Middle:SetAlpha(0) end
	if f.LeftSeparator then f.LeftSeparator:SetAlpha(0) end
	if f.RightSeparator then f.RightSeparator:SetAlpha(0) end
	if f.Flash then f.Flash:SetAlpha(0) end

	if f.TopLeft then f.TopLeft:Hide() end
	if f.TopRight then f.TopRight:Hide() end
	if f.BottomLeft then f.BottomLeft:Hide() end
	if f.BottomRight then f.BottomRight:Hide() end
	if f.TopMiddle then f.TopMiddle:Hide() end
	if f.MiddleLeft then f.MiddleLeft:Hide() end
	if f.MiddleRight then f.MiddleRight:Hide() end
	if f.BottomMiddle then f.BottomMiddle:Hide() end
	if f.MiddleMiddle then f.MiddleMiddle:Hide() end

	f:SetTemplate("Overlay")
	f:HookScript("OnEnter", T.SetModifiedBackdrop)
	f:HookScript("OnLeave", T.SetOriginalBackdrop)
end

----------------------------------------------------------------------------------------
--	Style icon function
----------------------------------------------------------------------------------------
local function SkinIcon(icon, t, parent)
	parent = parent or icon:GetParent()

	if t then
		icon.b = CreateFrame("Frame", nil, parent)
		icon.b:SetTemplate("Default")
		icon.b:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
		icon.b:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
	else
		parent:CreateBackdrop("Default")
		parent.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
		parent.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)
	end

	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:SetParent(t and icon.b or parent)
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

local function addAPI(object)
	local mt = getmetatable(object).__index
	if not object.SetOutside then mt.SetOutside = SetOutside end
	if not object.SetInside then mt.SetInside = SetInside end
	if not object.CreateOverlay then mt.CreateOverlay = CreateOverlay end
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.SetTemplate then mt.SetTemplate = SetTemplate end
	if not object.CreatePanel then mt.CreatePanel = CreatePanel end
	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	if not object.StripTextures then mt.StripTextures = StripTextures end
	if not object.Kill then mt.Kill = Kill end
	if not object.StyleButton then mt.StyleButton = StyleButton end
	if not object.SkinButton then mt.SkinButton = SkinButton end
	if not object.SkinIcon then mt.SkinIcon = SkinIcon end
	if not object.FontString then mt.FontString = FontString end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addAPI(object)
addAPI(object:CreateTexture())
addAPI(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not object:IsForbidden() and not handled[object:GetObjectType()] then
		addAPI(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end

-- Hacky fix for issue on 7.1 PTR where scroll frames no longer seem to inherit the methods from the "Frame" widget
local scrollFrame = CreateFrame("ScrollFrame")
addAPI(scrollFrame)

----------------------------------------------------------------------------------------
--	Style functions
----------------------------------------------------------------------------------------
T.SkinFuncs = {}
T.SkinFuncs["ShestakUI"] = {}

function T.SkinScrollBar(frame)
	frame:StripTextures()

	local frameName = frame.GetName and frame:GetName()
	local UpButton = frame.ScrollUpButton or frame.ScrollUp or frame.UpButton or _G[frameName and frameName.."ScrollUpButton"] or frame:GetParent().scrollUp
	local DownButton = frame.ScrollDownButton or frame.ScrollDown or frame.DownButton or _G[frameName and frameName.."ScrollDownButton"] or frame:GetParent().scrollDown
	local ThumbTexture = frame.ThumbTexture or frame.thumbTexture or _G[frameName and frameName.."ThumbTexture"]

	if UpButton and DownButton then
		if not UpButton.icon then
			T.SkinNextPrevButton(UpButton, nil, "Up")
			UpButton:SetSize(UpButton:GetWidth() + 7, UpButton:GetHeight() + 7)
		end

		if not DownButton.icon then
			T.SkinNextPrevButton(DownButton, nil, "Down")
			DownButton:SetSize(DownButton:GetWidth() + 7, DownButton:GetHeight() + 7)
		end

		if ThumbTexture then
			ThumbTexture:SetTexture(nil)
			if not frame.thumbbg then
				frame.thumbbg = CreateFrame("Frame", nil, frame)
				frame.thumbbg:SetPoint("TOPLEFT", ThumbTexture, "TOPLEFT", 0, -3)
				frame.thumbbg:SetPoint("BOTTOMRIGHT", ThumbTexture, "BOTTOMRIGHT", 0, 3)
				frame.thumbbg:SetTemplate("Overlay")

				frame:HookScript("OnShow", function()
					local _, maxValue = frame:GetMinMaxValues()
					if maxValue == 0 then
						frame:SetAlpha(0)
					else
						frame:SetAlpha(1)
					end
				end)

				frame:HookScript("OnMinMaxChanged", function()
					local _, maxValue = frame:GetMinMaxValues()
					if maxValue == 0 then
						frame:SetAlpha(0)
					else
						frame:SetAlpha(1)
					end
				end)

				frame:HookScript("OnDisable", function()
					frame:SetAlpha(0)
				end)

				frame:HookScript("OnEnable", function()
					frame:SetAlpha(1)
				end)
			end
		end
	end
end

local tabs = {
	"LeftDisabled",
	"MiddleDisabled",
	"RightDisabled",
	"Left",
	"Middle",
	"Right",
}

function T.SkinTab(tab, bg)
	if not tab then return end

	for _, object in pairs(tabs) do
		local tex = _G[tab:GetName()..object]
		if tex then
			tex:SetTexture(nil)
		end
	end

	if tab.GetHighlightTexture and tab:GetHighlightTexture() then
		tab:GetHighlightTexture():SetTexture(nil)
	else
		tab:StripTextures()
	end

	tab.backdrop = CreateFrame("Frame", nil, tab)
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	if bg then
		tab.backdrop:SetTemplate("Overlay")
		tab.backdrop:SetPoint("TOPLEFT", 3, -7)
		tab.backdrop:SetPoint("BOTTOMRIGHT", -3, 2)
	else
		tab.backdrop:SetTemplate("Transparent")
		tab.backdrop:SetPoint("TOPLEFT", 10, -3)
		tab.backdrop:SetPoint("BOTTOMRIGHT", -10, 3)
	end
end

function T.SkinNextPrevButton(btn, left, scroll)
	local normal, pushed, disabled
	local frameName = btn.GetName and btn:GetName()
	local isPrevButton = frameName and (string.find(frameName, "Left") or string.find(frameName, "Prev") or string.find(frameName, "Decrement") or string.find(frameName, "Back")) or left
	local isScrollUpButton = frameName and string.find(frameName, "ScrollUp") or scroll == "Up"
	local isScrollDownButton = frameName and string.find(frameName, "ScrollDown") or scroll == "Down"

	if btn:GetNormalTexture() then
		normal = btn:GetNormalTexture():GetTexture()
	end

	if btn:GetPushedTexture() then
		pushed = btn:GetPushedTexture():GetTexture()
	end

	if btn:GetDisabledTexture() then
		disabled = btn:GetDisabledTexture():GetTexture()
	end

	btn:StripTextures()

	if scroll == "Up" or scroll == "Down" or scroll == "Any" then
		normal = nil
		pushed = nil
		disabled = nil
	end

	if not normal then
		if isPrevButton then
			normal = "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up"
		elseif isScrollUpButton then
			normal = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up"
		elseif isScrollDownButton then
			normal = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up"
		else
			normal = "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up"
		end
	end

	if not pushed then
		if isPrevButton then
			pushed = "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down"
		elseif isScrollUpButton then
			pushed = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Down"
		elseif isScrollDownButton then
			pushed = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down"
		else
			pushed = "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down"
		end
	end

	if not disabled then
		if isPrevButton then
			disabled = "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled"
		elseif isScrollUpButton then
			disabled = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Disabled"
		elseif isScrollDownButton then
			disabled = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled"
		else
			disabled = "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled"
		end
	end

	btn:SetNormalTexture(normal)
	btn:SetPushedTexture(pushed)
	btn:SetDisabledTexture(disabled)

	btn:SetTemplate("Overlay")
	btn:SetSize(btn:GetWidth() - 7, btn:GetHeight() - 7)

	if normal and pushed and disabled then
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end

		btn:GetNormalTexture():ClearAllPoints()
		btn:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
		btn:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetAllPoints(btn:GetNormalTexture())
		end
		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
		end
		btn:GetHighlightTexture():SetColorTexture(1, 1, 1, 0.3)
		btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
	end
end

function T.SkinRotateButton(btn)
	btn:SetTemplate("Default")
	btn:SetSize(btn:GetWidth() - 14, btn:GetHeight() - 14)

	btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)
	btn:GetPushedTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)

	btn:GetHighlightTexture():SetColorTexture(1, 1, 1, 0.3)

	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	btn:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
	btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

function T.SkinEditBox(frame, width, height)
	frame:DisableDrawLayer("BACKGROUND")

	frame:CreateBackdrop("Overlay")

	local frameName = frame.GetName and frame:GetName()
	if frameName and (frameName:find("Gold") or frameName:find("Silver") or frameName:find("Copper")) then
		if frameName:find("Gold") then
			frame.backdrop:SetPoint("TOPLEFT", -3, 1)
			frame.backdrop:SetPoint("BOTTOMRIGHT", -3, 0)
		else
			frame.backdrop:SetPoint("TOPLEFT", -3, 1)
			frame.backdrop:SetPoint("BOTTOMRIGHT", -13, 0)
		end
	end

	if width then frame:SetWidth(width) end
	if height then frame:SetHeight(height) end
end

function T.SkinDropDownBox(frame, width, pos)
	local frameName = frame.GetName and frame:GetName()
	local button = frame.Button or frameName and (_G[frameName.."Button"] or _G[frameName.."_Button"])
	local text = frameName and _G[frameName.."Text"] or frame.Text
	if not width then width = 155 end

	frame:StripTextures()
	frame:SetWidth(width)

	if text then
		text:ClearAllPoints()
		text:SetPoint("RIGHT", button, "LEFT", -2, 0)
	end

	button:ClearAllPoints()
	if pos then
		button:SetPoint("TOPRIGHT", frame.Right, -20, -21)
	else
		button:SetPoint("RIGHT", frame, "RIGHT", -10, 3)
	end
	button.SetPoint = T.dummy
	T.SkinNextPrevButton(button, nil, "Down")

	frame:CreateBackdrop("Overlay")
	frame:SetFrameLevel(frame:GetFrameLevel() + 2)
	frame.backdrop:SetPoint("TOPLEFT", 20, -2)
	frame.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
end

function T.SkinCheckBox(frame, size)
	if size then
		frame:SetSize(size, size)
	end
	frame:SetNormalTexture("")
	frame:SetPushedTexture("")
	frame:CreateBackdrop("Overlay")
	frame:SetFrameLevel(frame:GetFrameLevel() + 2)
	frame.backdrop:SetPoint("TOPLEFT", 4, -4)
	frame.backdrop:SetPoint("BOTTOMRIGHT", -4, 4)

	if frame.SetHighlightTexture then
		local highligh = frame:CreateTexture()
		highligh:SetColorTexture(1, 1, 1, 0.3)
		highligh:SetPoint("TOPLEFT", frame, 6, -6)
		highligh:SetPoint("BOTTOMRIGHT", frame, -6, 6)
		frame:SetHighlightTexture(highligh)
	end

	if frame.SetCheckedTexture then
		local checked = frame:CreateTexture()
		checked:SetColorTexture(1, 0.82, 0, 0.8)
		checked:SetPoint("TOPLEFT", frame, 6, -6)
		checked:SetPoint("BOTTOMRIGHT", frame, -6, 6)
		frame:SetCheckedTexture(checked)
	end

	if frame.SetDisabledCheckedTexture then
		local disabled = frame:CreateTexture()
		disabled:SetColorTexture(0.6, 0.6, 0.6, 0.75)
		disabled:SetPoint("TOPLEFT", frame, 6, -6)
		disabled:SetPoint("BOTTOMRIGHT", frame, -6, 6)
		frame:SetDisabledCheckedTexture(disabled)
	end
end

function T.SkinCloseButton(f, point, text, pixel)
	f:StripTextures()
	f:SetTemplate("Overlay")
	f:SetSize(18, 18)

	if not text then text = "x" end
	if text == "-" and not pixel then
		f.text = f:CreateTexture(nil, "OVERLAY")
		f.text:SetSize(7, 1)
		f.text:SetPoint("CENTER")
		f.text:SetTexture(C.media.blank)
	end
	if text == "-" and pixel then
		f.text = f:CreateTexture(nil, "OVERLAY")
		f.text:SetSize(5, 1)
		f.text:SetPoint("CENTER")
		f.text:SetTexture(C.media.blank)
	end
	if not f.text then
		if pixel then
			f.text = f:FontString(nil, C.media.pixel_font, 8)
			f.text:SetPoint("CENTER", 0, 0)
		else
			f.text = f:FontString(nil, C.media.normal_font, 17)
			f.text:SetPoint("CENTER", 0, 1)
		end
		f.text:SetText(text)
	end

	if point then
		f:SetPoint("TOPRIGHT", point, "TOPRIGHT", -4, -4)
	else
		f:SetPoint("TOPRIGHT", -4, -4)
	end

	f:HookScript("OnEnter", T.SetModifiedBackdrop)
	f:HookScript("OnLeave", T.SetOriginalBackdrop)
end

function T.SkinSlider(f)
	f:SetBackdrop(nil)

	local bd = CreateFrame("Frame", nil, f)
	bd:SetTemplate("Overlay")
	if f:GetOrientation() == "VERTICAL" then
		bd:SetPoint("TOPLEFT", -2, -6)
		bd:SetPoint("BOTTOMRIGHT", 2, 6)
		f:GetThumbTexture():SetRotation(rad(90))
	else
		bd:SetPoint("TOPLEFT", 14, -2)
		bd:SetPoint("BOTTOMRIGHT", -15, 3)
	end
	bd:SetFrameLevel(f:GetFrameLevel() - 1)

	f:SetThumbTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	f:GetThumbTexture():SetBlendMode("ADD")
end

function T.SkinIconSelectionFrame(frame, numIcons, buttonNameTemplate, frameNameOverride)
	local frameName = frameNameOverride or frame:GetName()
	local scrollFrame = _G[frameName.."ScrollFrame"]
	local editBox = _G[frameName.."EditBox"]
	local okayButton = _G[frameName.."OkayButton"] or _G[frameName.."Okay"] or frame.BorderBox.OkayButton
	local cancelButton = _G[frameName.."CancelButton"] or _G[frameName.."Cancel"] or frame.BorderBox.CancelButton

	frame:StripTextures()
	frame.BorderBox:StripTextures()
	frame:CreateBackdrop("Transparent")
	frame.backdrop:SetPoint("TOPLEFT", 3, 1)
	frame:SetHeight(frame:GetHeight() + 13)

	scrollFrame:StripTextures()
	scrollFrame:CreateBackdrop("Overlay")
	scrollFrame.backdrop:SetPoint("TOPLEFT", 15, 5)
	scrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 31, -8)
	scrollFrame:SetHeight(scrollFrame:GetHeight() + 12)

	okayButton:SkinButton()
	cancelButton:SkinButton()
	cancelButton:ClearAllPoints()
	cancelButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5)

	editBox:DisableDrawLayer("BACKGROUND")
	T.SkinEditBox(editBox)

	if buttonNameTemplate then
		for i = 1, numIcons do
			local button = _G[buttonNameTemplate..i]
			local icon = _G[button:GetName().."Icon"]

			button:StripTextures()
			button:StyleButton(true)
			button:SetTemplate("Default")

			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end
end

function T.SkinMaxMinFrame(frame, point)
	frame:SetSize(18, 18)

	if point then
		frame:SetPoint("RIGHT", point, "LEFT", -2, 0)
	end

	for name, direction in pairs({ ["MaximizeButton"] = "up", ["MinimizeButton"] = "down"}) do
		local button = frame[name]
		if button then
			button:StripTextures()
			button:SetTemplate("Overlay")
			button:SetPoint("CENTER")
			button:SetHitRectInsets(1, 1, 1, 1)

			button.minus = button:CreateTexture(nil, "OVERLAY")
			button.minus:SetSize(7, 1)
			button.minus:SetPoint("CENTER")
			button.minus:SetTexture(C.media.blank)

			if direction == "up" then
				button.plus = button:CreateTexture(nil, "OVERLAY")
				button.plus:SetSize(1, 7)
				button.plus:SetPoint("CENTER")
				button.plus:SetTexture(C.media.blank)
			end

			button:HookScript("OnEnter", T.SetModifiedBackdrop)
			button:HookScript("OnLeave", T.SetOriginalBackdrop)
		end
	end
end

function T.SkinExpandOrCollapse(f)
	f:SetHighlightTexture("")
	f:SetPushedTexture("")

	local bg = CreateFrame("Frame", nil, f)
	bg:SetSize(13, 13)
	bg:SetPoint("TOPLEFT", f:GetNormalTexture(), 0, -1)
	bg:SetTemplate("Overlay")
	f.bg = bg

	bg.minus = bg:CreateTexture(nil, "OVERLAY")
	bg.minus:SetSize(5, 1)
	bg.minus:SetPoint("CENTER")
	bg.minus:SetTexture(C.media.blank)

	bg.plus = bg:CreateTexture(nil, "OVERLAY")
	bg.plus:SetSize(1, 5)
	bg.plus:SetPoint("CENTER")
	bg.plus:SetTexture(C.media.blank)
	bg.plus:Hide()

	hooksecurefunc(f, "SetNormalTexture", function(self, texture)
		if self.settingTexture then return end
		self.settingTexture = true
		self:SetNormalTexture("")

		if texture and texture ~= "" then
			if texture:find("Plus") then
				self.bg.plus:Show()
			elseif texture:find("Minus") then
				self.bg.plus:Hide()
			end
			self.bg:Show()
		else
			self.bg:Hide()
		end
		self.settingTexture = nil
	end)

	f:HookScript("OnEnter", function(self)
		self.bg:SetBackdropBorderColor(unpack(C.media.classborder_color))
		if self.bg.overlay then
			self.bg.overlay:SetVertexColor(C.media.classborder_color[1] * 0.3, C.media.classborder_color[2] * 0.3, C.media.classborder_color[3] * 0.3, 1)
		end
	end)

	f:HookScript("OnLeave", function(self)
		self.bg:SetBackdropBorderColor(unpack(C.media.border_color))
		if self.bg.overlay then
			self.bg.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
		end
	end)
end

function T.SkinHelpBox(frame)
	frame:StripTextures()
	frame:SetTemplate("Transparent")
	if frame.CloseButton then
		T.SkinCloseButton(frame.CloseButton)
	end
	if frame.Arrow then
		frame.Arrow:Hide()
	end
end

local LoadBlizzardSkin = CreateFrame("Frame")
LoadBlizzardSkin:RegisterEvent("ADDON_LOADED")
LoadBlizzardSkin:SetScript("OnEvent", function(self, _, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.skins.blizzard_frames then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	for _addon, skinfunc in pairs(T.SkinFuncs) do
		if type(skinfunc) == "function" then
			if _addon == addon then
				if skinfunc then
					skinfunc()
				end
			end
		elseif type(skinfunc) == "table" then
			if _addon == addon then
				for _, skinfunc in pairs(T.SkinFuncs[_addon]) do
					if skinfunc then
						skinfunc()
					end
				end
			end
		end
	end
end)