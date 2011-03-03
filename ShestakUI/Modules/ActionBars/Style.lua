----------------------------------------------------------------------------------------
--	By Tukz
----------------------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...))
if not C.actionbar.enable == true then return end

local _G = _G
local securehandler = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")
local replace = string.gsub

local function style(self)
	local name = self:GetName()
	if name:match("MultiCast") then return end
	local action = self.action
	local Button = self
	local Icon = _G[name.."Icon"]
	local Count = _G[name.."Count"]
	local Flash = _G[name.."Flash"]
	local HotKey = _G[name.."HotKey"]
	local Border = _G[name.."Border"]
	local Btname = _G[name.."Name"]
	local normal = _G[name.."NormalTexture"]
 
	Flash:SetTexture("")
	Button:SetNormalTexture("")
 
	Border:Hide()
	Border = T.dummy
 
	Count:ClearAllPoints()
	Count:Point("BOTTOMRIGHT", 0, 2)
	Count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
	Count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
 
	Btname:SetText("")
	Btname:Kill()
 
	if not _G[name.."Panel"] then
		if self:GetHeight() ~= T.buttonsize and not InCombatLockdown() then
			self:Size(T.buttonsize, T.buttonsize)
		end
 
		local panel = CreateFrame("Frame", name.."Panel", self)
		panel:CreatePanel("Transparent", T.buttonsize, T.buttonsize, "CENTER", self, "CENTER", 0, 0)
		panel:SetFrameStrata(self:GetFrameStrata())
		panel:SetFrameLevel(self:GetFrameLevel() - 1)
 
		Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		Icon:Point("TOPLEFT", Button, 2, -2)
		Icon:Point("BOTTOMRIGHT", Button, -2, 2)
	end
 
	HotKey:ClearAllPoints()
	HotKey:Point("TOPRIGHT", 0, -1)
	HotKey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style);
	HotKey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
	HotKey:Width(T.buttonsize - 1)
	HotKey.ClearAllPoints = T.dummy
	HotKey.SetPoint = T.dummy
 
	if not C.actionbar.hotkey == true then
		HotKey:SetText("")
		HotKey:Kill()
	end
 
	if normal then
		normal:ClearAllPoints()
		normal:Point("TOPLEFT")
		normal:Point("BOTTOMRIGHT")
	end
end

local function stylesmallbutton(normal, button, icon, name, pet)
	local Flash	= _G[name.."Flash"]
	button:SetNormalTexture("")
	button.SetNormalTexture = T.dummy
	
	Flash:SetTexture(0.8, 0.8, 0.8, 0.5)
	Flash:Point("TOPLEFT", button, 2, -2)
	Flash:Point("BOTTOMRIGHT", button, -2, 2)
	
	if not _G[name.."Panel"] then
		button:SetWidth(T.buttonsize)
		button:SetHeight(T.buttonsize)
		
		local panel = CreateFrame("Frame", name.."Panel", button)
		panel:CreatePanel("Transparent", T.buttonsize, T.buttonsize, "CENTER", button, "CENTER", 0, 0)
		panel:SetFrameStrata(button:GetFrameStrata())
		panel:SetFrameLevel(button:GetFrameLevel() - 1)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", button, 2, -2)
		icon:Point("BOTTOMRIGHT", button, -2, 2)
		
		if pet then
			local autocast = _G[name.."AutoCastable"]
			autocast:Width((T.buttonsize * 2) - 10)
			autocast:Height((T.buttonsize * 2) - 10)
			autocast:ClearAllPoints()
			autocast:Point("CENTER", button, 0, 0)
			
			local shine = _G[name.."Shine"]
			shine:Width(T.buttonsize)
			shine:Height(T.buttonsize)

			local cooldown = _G[name.."Cooldown"]
			cooldown:Width(T.buttonsize - 2)
			cooldown:Height(T.buttonsize - 2)
		end
	end
	
	if normal then
		normal:ClearAllPoints()
		normal:Point("TOPLEFT")
		normal:Point("BOTTOMRIGHT")
	end
end

function T.StyleShift()
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button = _G[name]
		local icon = _G[name.."Icon"]
		local normal = _G[name.."NormalTexture"]
		stylesmallbutton(normal, button, icon, name)
	end
end

function T.StylePet()
	for i = 1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button = _G[name]
		local icon = _G[name.."Icon"]
		local normal = _G[name.."NormalTexture2"]
		stylesmallbutton(normal, button, icon, name, true)
	end
end

local function updatehotkey(self, actionButtonType)
	local hotkey = _G[self:GetName() .. "HotKey"]
	local text = hotkey:GetText()
	
	text = replace(text, "(s%-)", "S")
	text = replace(text, "(a%-)", "A")
	text = replace(text, "(c%-)", "C")
	text = replace(text, "(Mouse Button )", "M")
	text = replace(text, "(Кнопка мыши )", "M")
	text = replace(text, KEY_BUTTON3, "M3")
	text = replace(text, "(Num Pad )", "N")
	text = replace(text, KEY_PAGEUP, "PU")
	text = replace(text, KEY_PAGEDOWN, "PD")
	text = replace(text, KEY_SPACE, "SpB")
	text = replace(text, KEY_INSERT, "Ins")
	text = replace(text, KEY_HOME, "Hm")
	text = replace(text, KEY_MOUSEWHEELDOWN, "MWD")
	text = replace(text, KEY_MOUSEWHEELUP, "MWU")
	text = replace(text, KEY_DELETE, "Del")
	
	if hotkey:GetText() == _G["RANGE_INDICATOR"] then
		hotkey:SetText("")
	else
		hotkey:SetText(text)
	end
end

-- Rescale cooldown spiral to fix texture
local buttonNames = {
	"ActionButton",
	"MultiBarBottomLeftButton",
	"MultiBarBottomRightButton",
	"MultiBarLeftButton",
	"MultiBarRightButton",
	"ShapeshiftButton",
	"PetActionButton",
	"MultiCastActionButton"
}
for _, name in ipairs( buttonNames ) do
	for index = 1, 12 do
		local buttonName = name .. tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName .. "Cooldown"]
 
		if (button == nil or cooldown == nil) then
			break
		end
		
		cooldown:ClearAllPoints()
		cooldown:Point("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
end

local buttons = 0
local function SetupFlyoutButton()
	for i = 1, buttons do
		-- Prevent error if you don't have max ammount of buttons
		if _G["SpellFlyoutButton"..i] then
			style(_G["SpellFlyoutButton"..i])
			_G["SpellFlyoutButton"..i]:StyleButton(true)
		end
	end
end
SpellFlyout:HookScript("OnShow", SetupFlyoutButton)

-- Hide the Mouseover texture and attempt to find the ammount of buttons to be skinned
local function styleflyout(self)
	self.FlyoutBorder:SetAlpha(0)
	self.FlyoutBorderShadow:SetAlpha(0)
	
	SpellFlyoutHorizontalBackground:SetAlpha(0)
	SpellFlyoutVerticalBackground:SetAlpha(0)
	SpellFlyoutBackgroundEnd:SetAlpha(0)
	
	for i = 1, GetNumFlyouts() do
		local x = GetFlyoutID(i)
		local _, _, numSlots, isKnown = GetFlyoutInfo(x)
		if isKnown then
			buttons = numSlots
			break
		end
	end
	
	-- Change arrow direction depending on what bar the button is on
	local arrowDistance
	if ((SpellFlyout and SpellFlyout:IsShown() and SpellFlyout:GetParent() == self) or GetMouseFocus() == self) then
		arrowDistance = 5
	else
		arrowDistance = 2
	end
	
	if self:GetParent():GetParent():GetName() == "SpellBookSpellIconsFrame" then return end
	
	if self:GetAttribute("flyoutDirection") ~= nil then
		local point, _, _, _, _ = self:GetParent():GetParent():GetPoint()
		
		if strfind(point, "BOTTOM") then
			self.FlyoutArrow:ClearAllPoints()
			self.FlyoutArrow:Point("TOP", self, "TOP", 0, arrowDistance)
			SetClampedTextureRotation(self.FlyoutArrow, 0)
			if not InCombatLockdown() then self:SetAttribute("flyoutDirection", "UP") end
		else
			self.FlyoutArrow:ClearAllPoints()
			self.FlyoutArrow:Point("LEFT", self, "LEFT", -arrowDistance, 0)
			SetClampedTextureRotation(self.FlyoutArrow, 270)
			if not InCombatLockdown() then self:SetAttribute("flyoutDirection", "LEFT") end
		end
	end
end

do
	for i = 1, 12 do
		_G["ActionButton"..i]:StyleButton(true)
		_G["MultiBarBottomLeftButton"..i]:StyleButton(true)
		_G["MultiBarBottomRightButton"..i]:StyleButton(true)
		_G["MultiBarLeftButton"..i]:StyleButton(true)
		_G["MultiBarRightButton"..i]:StyleButton(true)
	end
	 
	for i = 1, 10 do
		_G["ShapeshiftButton"..i]:StyleButton(true)
		_G["PetActionButton"..i]:StyleButton(true)	
	end
end

hooksecurefunc("ActionButton_Update", style)
hooksecurefunc("ActionButton_UpdateHotkeys", updatehotkey)
hooksecurefunc("ActionButton_UpdateFlyout", styleflyout)

----------------------------------------------------------------------------------------
--	TotemBar style
----------------------------------------------------------------------------------------
if T.class ~= "SHAMAN" then return end

SLOT_EMPTY_TCOORDS = {
	[EARTH_TOTEM_SLOT] = {
		left = 66 / 128,
		right = 96 / 128,
		top = 3 / 256,
		bottom = 33 / 256,
	},
	[FIRE_TOTEM_SLOT] = {
		left = 67 / 128,
		right = 97 / 128,
		top = 100 / 256,
		bottom = 130 / 256,
	},
	[WATER_TOTEM_SLOT] = {
		left = 39 / 128,
		right = 69 / 128,
		top = 209 / 256,
		bottom = 239 / 256,
	},
	[AIR_TOTEM_SLOT] = {
		left = 66 / 128,
		right = 96 / 128,
		top = 36 / 256,
		bottom = 66 / 256,
	},
}

-- Totem Fly Out
local function StyleTotemFlyout(flyout)
	-- Remove blizzard flyout texture
	flyout.top:SetTexture(nil)
	flyout.middle:SetTexture(nil)

	-- Buttons
	local last = nil
	for _, button in ipairs(flyout.buttons) do
		button:SetTemplate("Default")
		local icon = select(1, button:GetRegions())
		if icon then
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetDrawLayer("ARTWORK")
			icon:ClearAllPoints()
			icon:Point("TOPLEFT", button, "TOPLEFT", 2, -2)
			icon:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
		end
		if not InCombatLockdown() then
			button:Size(T.buttonsize, T.buttonsize)
			button:ClearAllPoints()
			button:Point("BOTTOM", last, "TOP", 0, T.buttonspacing)
		end
		if button:IsVisible() then
			last = button
		end
		button:SetBackdropBorderColor(flyout.parent:GetBackdropBorderColor())
		button:StyleButton()
	end

	flyout.buttons[1]:Point("BOTTOM", flyout, "BOTTOM", 0, 0)

	if flyout.type == "slot" then
		local tcoords = SLOT_EMPTY_TCOORDS[flyout.parent:GetID()]
		flyout.buttons[1].icon:SetTexCoord(tcoords.left, tcoords.right, tcoords.top, tcoords.bottom)
	end

	-- Close Button
	local close = MultiCastFlyoutFrameCloseButton
	close:SetTemplate("Default")
	close:GetHighlightTexture():SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	close:GetHighlightTexture():Point("TOPLEFT", close, "TOPLEFT", 2, -2)
	close:GetHighlightTexture():Point("BOTTOMRIGHT", close, "BOTTOMRIGHT", -2, 2)
	close:GetNormalTexture():SetTexture(nil)
	close:ClearAllPoints()
	close:Point("BOTTOMLEFT", last, "TOPLEFT", 0, T.buttonspacing)
	close:Point("BOTTOMRIGHT", last, "TOPRIGHT", 0, T.buttonspacing)
	close:Height(T.buttonspacing * 4)

	close:SetBackdropBorderColor(last:GetBackdropBorderColor())
	flyout:ClearAllPoints()
	flyout:Point("BOTTOM", flyout.parent, "TOP", 0, T.buttonspacing)
end
hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout",function(self) StyleTotemFlyout(self) end)

-- Totem Fly Out Buttons
local function StyleTotemOpenButton(button, parent)
	button:GetHighlightTexture():SetTexture(nil)
	button:GetNormalTexture():SetTexture(nil)
	button:Height(20)
	button:ClearAllPoints()
	button:Point("BOTTOMLEFT", parent, "TOPLEFT", 0, -1)
	button:Point("BOTTOMRIGHT", parent, "TOPRIGHT", 0, -1)
	if not button.visibleBut then
		button.visibleBut = CreateFrame("Frame",nil,button)
		button.visibleBut:Height(8)
		button.visibleBut:Width(button:GetWidth() + 2)
		button.visibleBut:SetPoint("CENTER")
		button.visibleBut.highlight = button.visibleBut:CreateTexture(nil, "HIGHLIGHT")
		button.visibleBut.highlight:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
		button.visibleBut.highlight:Point("TOPLEFT", button.visibleBut, "TOPLEFT", 1, -1)
		button.visibleBut.highlight:Point("BOTTOMRIGHT", button.visibleBut, "BOTTOMRIGHT", -1, 1)
		button.visibleBut:SetTemplate("Default")
	end

	button.visibleBut:SetBackdropBorderColor(parent:GetBackdropBorderColor())
end
hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show", function(button, _, parent) StyleTotemOpenButton(button, parent) end)

-- Color for borders
local bordercolors = {
	{0.23, 0.45, 0.13},   -- Earth
	{0.58, 0.23, 0.10},   -- Fire
	{0.19, 0.48, 0.60},   -- Water
	{0.42, 0.18, 0.74},   -- Air
}

-- Totem Slot Buttons
local function StyleTotemSlotButton(button, index)
	button:SetTemplate("Default")
	button.overlayTex:SetTexture(nil)
	button.background:SetDrawLayer("ARTWORK")
	button.background:ClearAllPoints()
	button.background:Point("TOPLEFT", button, "TOPLEFT", 2, -2)
	button.background:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	
	if not InCombatLockdown() then
		button:Size(T.buttonsize, T.buttonsize)
	end
	
	button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
	button:StyleButton()
end
hooksecurefunc("MultiCastSlotButton_Update", function(self, slot) StyleTotemSlotButton(self,tonumber( string.match(self:GetName(),"MultiCastSlotButton(%d)"))) end)

-- Skin the actual totem buttons
local function StyleTotemActionButton(button, index)
	local name = button:GetName()
	local icon = select(1, button:GetRegions())
	local hotkey = _G[name.."HotKey"]

	hotkey:ClearAllPoints()
	hotkey:Point("TOPRIGHT", 0, -1)
	hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
	hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
	hotkey:Width(T.buttonsize-1)
	hotkey.ClearAllPoints = T.dummy
	hotkey.SetPoint = T.dummy
 
	if not C.actionbar.hotkey == true then
		hotkey:SetText("")
		hotkey:Kill()
	end

	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetDrawLayer("ARTWORK")
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", button, "TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end

	button.overlayTex:SetTexture(nil)
	button.overlayTex:Hide()
	button:GetNormalTexture():SetTexCoord(0, 0, 0, 0)
	
	if not InCombatLockdown() and button.slotButton then
		button:ClearAllPoints()
		button:SetAllPoints(button.slotButton)
		button:SetFrameLevel(button.slotButton:GetFrameLevel() + 1)
	end
	
	button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
	button:SetBackdropColor(0, 0, 0, 0)
	button:StyleButton(true)
end
hooksecurefunc("MultiCastActionButton_Update", function(actionButton, actionId, actionIndex, slot) StyleTotemActionButton(actionButton, actionIndex) end)

-- Summon and Recall Buttons
local function StyleTotemSpellButton(button, index)
	if not button then return end
	local name = button:GetName()
	local icon = select(1, button:GetRegions())
	local hotkey = _G[name.."HotKey"]

	hotkey:ClearAllPoints()
	hotkey:Point("TOPRIGHT", 0, -1)
	hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
	hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
	hotkey:Width(T.buttonsize-1)
	hotkey.ClearAllPoints = T.dummy
	hotkey.SetPoint = T.dummy
 
	if not C.actionbar.hotkey == true then
		hotkey:SetText("")
		hotkey:Kill()
	end
	
	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetDrawLayer("ARTWORK")
		icon:Point("TOPLEFT", button, "TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
	
	button:SetTemplate("Default")
	button:GetNormalTexture():SetTexture(nil)
	
	if not InCombatLockdown() then
		button:Size(T.buttonsize, T.buttonsize)
	end
	_G[button:GetName().."Highlight"]:SetTexture(nil)
	_G[button:GetName().."NormalTexture"]:SetTexture(nil)
	button:StyleButton()
end
hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) StyleTotemSpellButton(self, 0) end)
hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) StyleTotemSpellButton(self, 5) end)