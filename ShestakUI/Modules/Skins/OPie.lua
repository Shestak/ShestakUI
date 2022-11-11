local T, C = unpack(ShestakUI)
if C.skins.opie ~= true or not IsAddOnLoaded("OPie") then return end

----------------------------------------------------------------------------------------
--	OPie skin (OPie Masque)
----------------------------------------------------------------------------------------
local SPECIAL_COLOR_ALPHA = 0
-- 0 = invisible, 1 = fully visible, lower it if your skin is ugly

local buttons = {}
local prototype = {}
local STATE_USABLE, STATE_NOMANA, STATE_NORANGE, STATE_UNUSABLE = 0, 1, 2, 3

function prototype:SetIcon(texture)
	self.Icon:SetTexture(texture)
end

function prototype:SetIconTexCoord(a, b, c, d, e, f, g, h)
	if not a or not b or not c or not d then return end -- Broker plugins???
	self.Icon:SetTexCoord(a, b, c, d, e, f, g, h)
end

function prototype:SetIconVertexColor(r, g, b)
	if r == 0.5 and g == 0.5 and b == 0.5 then return end -- don't darken icons on cooldown
	self.icon_r, self.icon_g, self.icon_b = r, g, b
	if self.ustate == STATE_USABLE then
		self.Icon:SetVertexColor(r, g, b)
	end
end

function prototype:SetUsable(usable, _, cd, nomana, norange)
	local state = usable and STATE_USABLE or (norange and STATE_NORANGE or (nomana and STATE_NOMANA or STATE_UNUSABLE))
	if state == self.ustate then return end
	self.ustate = state
	if state == STATE_NORANGE then
		self.Icon:SetVertexColor(0.8, 0.1, 0.1)
	elseif state == STATE_NOMANA then
		self.Icon:SetVertexColor(0.5, 0.5, 1)
	elseif state == STATE_UNUSABLE and not cd then -- don't black it out while on cooldown
		self.Icon:SetVertexColor(0.4, 0.4, 0.4)
	else
		self.Icon:SetVertexColor(self.icon_r or 1, self.icon_g or 1, self.icon_b or 1)
	end
end

function prototype:SetDominantColor(r, g, b)
	self.Border:SetShown(2.85 > (r + g + b)) -- don't override skin color if it's white
	self.Border:SetVertexColor(r, g, b)
	self.Border:SetAlpha(SPECIAL_COLOR_ALPHA)
end

function prototype:SetOverlayIcon(texture, w, h, ...) -- not entirely sure what this is for
	if not texture then
		self.OverlayIcon:Hide()
	else
		self.OverlayIcon:SetTexture(texture)
		self.OverlayIcon:SetSize(w, h)
		if ... then
			self.OverlayIcon:SetTexCoord(...)
		end
		self.OverlayIcon:Show()
	end
end

function prototype:SetCount(count)
	self.Count:SetText(count or "")
end

local displaySubs = {
	["ALT%-"]      = "a",
	["CTRL%-"]     = "c",
	["SHIFT%-"]    = "s", -- fr, it: "m"
	["BUTTON"]     = "m", -- fr: souris, it: mouse
	["MOUSEWHEEL"] = "w", -- fr: molette, it: rotellina
	["NUMPAD"]     = "n",
	["PLUS"]       = "+",
	["MINUS"]      = "-",
	["MULTIPLY"]   = "*",
	["DIVIDE"]     = "/",
	["DECIMAL"]    = ".",
}
function prototype:SetBinding(text)
	if not text then
		return self.HotKey:SetText("")
	end
	for k, v in pairs(displaySubs) do
		text = gsub(text, k, v)
	end
	self.HotKey:SetText(text)
end

function prototype:SetCooldown(remain, duration, usable)
	if duration and remain and duration > 0 and remain > 0 then
		local start = GetTime() + remain - duration
		if usable then
			-- show recharge time
			self.Cooldown:SetDrawEdge(true)
			self.Cooldown:SetDrawSwipe(false)
		else
			-- show cooldown time
			self.Cooldown:SetDrawEdge(false)
			self.Cooldown:SetDrawSwipe(true)
			self.Cooldown:SetSwipeColor(0, 0, 0, 0.8)
		end
		self.Cooldown:SetCooldown(start, duration)
		self.Cooldown:Show()
	else
		self.Cooldown:Hide()
	end
end

function prototype:SetCooldownFormattedText()
	-- do nothing
end

function prototype:SetCooldownTextShown()
	-- do nothing
end

function prototype:SetHighlighted(highlight)
	self[highlight and "LockHighlight" or "UnlockHighlight"](self)
end

function prototype:SetActive(active)
	self:SetChecked(active)
end

function prototype:SetOuterGlow(shown)
	for i = 1, #self.GlowTextures do
		self.GlowTextures[i]:SetShown(shown)
	end
end

function prototype:SetEquipState(inBags, isEquipped)
	if isEquipped then
		self.Flash:SetVertexColor(0.1, 0.9, 0.15)
		self.Flash:Show()
	elseif inBags then
		self.Flash:SetVertexColor(1, 0.9, 0.2)
		self.Flash:Show()
	else
		self.Flash:Hide()
	end
end

local id = 0

local function CreateIndicator(name, parent, size)
	id = id + 1
	name = name or "OPieSliceButton"..id
	parent = parent or UIParent
	size = size or 36

	local button = CreateFrame("CheckButton", name, parent, "ActionButtonTemplate")
	button:SetSize(size, size)
	button:EnableMouse(false)

	button.Border        = _G[name .. "Border"] -- highlight
	button.Cooldown      = _G[name .. "Cooldown"]
	button.Count         = _G[name .. "Count"]
	button.Flash         = _G[name .. "Flash"] -- inner glow / checked
	button.HotKey        = _G[name .. "HotKey"]
	button.Icon          = _G[name .. "Icon"]
	button.NormalTexture = _G[name .. "NormalTexture"] -- border

	-- Overlay icon (???)
	button.OverlayIcon = button:CreateTexture(nil, "BACKGROUND", 1)
	button.OverlayIcon:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 4, 4)

	-- Outer glow (doesn't seem to do anything?)
	button.GlowTextures = {}

	for k, v in pairs(prototype) do
		button[k] = v
	end

	-- ShestakUI Skin

	if not button.isSkinned then
		button.NormalTexture:SetTexture(nil)
		button:CreateBackdrop("Overlay")
		button:StyleButton(nil, 4)
		button:CreateBackdrop("Default")

		button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.icon:SetDrawLayer("ARTWORK")
		button.icon:SetParent(button.backdrop)
		button.icon:ClearAllPoints()
		button.icon:SetSize(size, size)
		button.icon:SetPoint("CENTER",0,0)

		button.Cooldown:SetSize(size, size)
		button.Cooldown:ClearAllPoints()
		button.Cooldown:SetPoint("CENTER",0,0)

		button.Flash:SetSize(size, size)
		button.Flash:ClearAllPoints()
		button.Flash:SetPoint("CENTER",0,0)

		button.hover:SetSize(size, size)
		button.hover:ClearAllPoints()
		button.hover:SetPoint("CENTER",0,0)

		button.checked:SetSize(size, size)
		button.checked:ClearAllPoints()
		button.checked:SetPoint("CENTER",0,0)
		button.isSkinned = true
	end
	tinsert(buttons, button)
	return button
end

--BETA OneRingLib.ext.OPieUI:SetIndicatorConstructor(CreateIndicator)
