----------------------------------------------------------------------------------------
--	By Tukz
----------------------------------------------------------------------------------------
if not SettingsCF["actionbar"].enable == true then return end

local _G = _G
local db = SettingsCF["font"]
local securehandler = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")
local replace = string.gsub

function style(self)
	local name = self:GetName()
	if name:match("MultiCastActionButton") then return end
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
	Border = SettingsDB.dummy
 
	Count:ClearAllPoints()
	Count:SetPoint("BOTTOMRIGHT", 0, SettingsDB.Scale(2))
	Count:SetFont(db.action_bars_font, db.action_bars_font_size, db.action_bars_font_style);
	Count:SetShadowOffset(db.action_bars_font_shadow and 1 or 0, db.action_bars_font_shadow and -1 or 0)
 
	Btname:SetText("")
	Btname:Hide()
	Btname.Show = SettingsDB.dummy
 
	if not _G[name.."Panel"] then
		self:SetWidth(SettingsDB.buttonsize)
		self:SetHeight(SettingsDB.buttonsize)
 
		local panel = CreateFrame("Frame", name.."Panel", self)
		SettingsDB.CreateFadedPanel(panel, SettingsDB.buttonsize, SettingsDB.buttonsize, "CENTER", self, "CENTER", 0, 0)
 
		panel:SetFrameStrata(self:GetFrameStrata())
		panel:SetFrameLevel(self:GetFrameLevel() - 1)
 
		Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		Icon:SetPoint("TOPLEFT", Button, SettingsDB.Scale(2), SettingsDB.Scale(-2))
		Icon:SetPoint("BOTTOMRIGHT", Button, SettingsDB.Scale(-2), SettingsDB.Scale(2))
	end
 
	HotKey:ClearAllPoints()
	HotKey:SetPoint("TOPRIGHT", 0, SettingsDB.Scale(-1))
	HotKey:SetFont(db.action_bars_font, db.action_bars_font_size, db.action_bars_font_style);
	HotKey:SetShadowOffset(db.action_bars_font_shadow and 1 or 0, db.action_bars_font_shadow and -1 or 0)
	HotKey:SetWidth(SettingsDB.buttonsize-1)
	HotKey.ClearAllPoints = SettingsDB.dummy
	HotKey.SetPoint = SettingsDB.dummy
 
	if not SettingsCF["actionbar"].hotkey == true then
		HotKey:SetText("")
		HotKey:Hide()
		HotKey.Show = SettingsDB.dummy
	end
 
	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end
end

local function stylesmallbutton(normal, button, icon, name, pet)
	local Flash	= _G[name.."Flash"]
	button:SetNormalTexture("")
	button.SetNormalTexture = SettingsDB.dummy
	Flash:SetTexture(0.8, 0.8, 0.8, 0.5)
	Flash:SetPoint("TOPLEFT", button, SettingsDB.Scale(2), SettingsDB.Scale(-2))
	Flash:SetPoint("BOTTOMRIGHT", button, SettingsDB.Scale(-2), SettingsDB.Scale(2))
	
	if not _G[name.."Panel"] then
		button:SetWidth(SettingsDB.buttonsize)
		button:SetHeight(SettingsDB.buttonsize)
		
		local panel = CreateFrame("Frame", name.."Panel", button)
		SettingsDB.CreateFadedPanel(panel, SettingsDB.buttonsize, SettingsDB.buttonsize, "CENTER", button, "CENTER", 0, 0)
		panel:SetFrameStrata(button:GetFrameStrata())
		panel:SetFrameLevel(button:GetFrameLevel() - 1)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		if pet then
			local autocast = _G[name.."AutoCastable"]
			autocast:SetWidth(SettingsDB.Scale((SettingsDB.buttonsize * 2) - 10))
			autocast:SetHeight(SettingsDB.Scale((SettingsDB.buttonsize * 2) - 10))
			autocast:ClearAllPoints()
			autocast:SetPoint("CENTER", button, 0, 0)
			
			local shine = _G[name.."Shine"]
			shine:SetWidth(SettingsDB.Scale(SettingsDB.buttonsize))
			shine:SetHeight(SettingsDB.Scale(SettingsDB.buttonsize))

			local cooldown = _G[name.."Cooldown"]
			cooldown:SetWidth(SettingsDB.Scale(SettingsDB.buttonsize - 2))
			cooldown:SetHeight(SettingsDB.Scale(SettingsDB.buttonsize - 2))
			
			icon:SetPoint("TOPLEFT", button, SettingsDB.Scale(2), SettingsDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, SettingsDB.Scale(-2), SettingsDB.Scale(2))
		else
			icon:SetPoint("TOPLEFT", button, SettingsDB.Scale(2), SettingsDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, SettingsDB.Scale(-2), SettingsDB.Scale(2))
		end
	end
	
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT")
	normal:SetPoint("BOTTOMRIGHT")
end

function SettingsDB.StyleShift()
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button = _G[name]
		local icon = _G[name.."Icon"]
		local normal = _G[name.."NormalTexture"]
		stylesmallbutton(normal, button, icon, name)
	end
end

function SettingsDB.StylePet()
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
}
for _, name in ipairs( buttonNames ) do
	for index = 1, 12 do
		local buttonName = name .. tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName .. "Cooldown"]
 
		if ( button == nil or cooldown == nil ) then
			break
		end
		
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	end
end

local buttons = 0
local function SetupFlyoutButton()
	for i = 1, buttons do
		-- Prevent error if you don't have max ammount of buttons
		if _G["SpellFlyoutButton"..i] then
			style(_G["SpellFlyoutButton"..i])
			SettingsDB.StyleButton(_G["SpellFlyoutButton"..i], true)
		end
	end
end
SpellFlyout:HookScript("OnShow", SetupFlyoutButton)

-- Reposition flyout buttons
local function FlyoutButtonPos(self, buttons, direction)
	for i = 1, buttons do
		local parent = SpellFlyout:GetParent()
		if not _G["SpellFlyoutButton"..i] then return end
		
		if InCombatLockdown() then return end
 
		if direction == "LEFT" then
			if i == 1 then
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("RIGHT", parent, "LEFT", -SettingsDB.buttonspacing, 0)
			else
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("RIGHT", _G["SpellFlyoutButton"..i-1], "LEFT", -SettingsDB.buttonspacing, 0)
			end
		else
			if i == 1 then
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("BOTTOM", parent, "TOP", 0, SettingsDB.buttonspacing)
			else
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("BOTTOM", _G["SpellFlyoutButton"..i-1], "TOP", 0, SettingsDB.buttonspacing)
			end
		end
	end
end
 
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
	
	if (self:GetParent() == MultiBarBottomRight and SettingsCF.actionbar.rightbars > 1) then
		self.FlyoutArrow:ClearAllPoints()
		self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0)
		SetClampedTextureRotation(self.FlyoutArrow, 270)
		FlyoutButtonPos(self, buttons, "LEFT")
	elseif (self:GetParent() == MultiBarLeft and SettingsCF.actionbar.bottombars == 2) then
		self.FlyoutArrow:ClearAllPoints()
		self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, arrowDistance)
		SetClampedTextureRotation(self.FlyoutArrow, 0)
		FlyoutButtonPos(self, buttons, "UP")	
	elseif not self:GetParent():GetParent() == "SpellBookSpellIconsFrame" then
		FlyoutButtonPos(self, buttons, "UP")
	end
end

do
	for i = 1, 12 do
		SettingsDB.StyleButton(_G["MultiBarLeftButton"..i], true)
		SettingsDB.StyleButton(_G["MultiBarRightButton"..i], true)
		SettingsDB.StyleButton(_G["MultiBarBottomRightButton"..i], true)
		SettingsDB.StyleButton(_G["MultiBarBottomLeftButton"..i], true)
		SettingsDB.StyleButton(_G["ActionButton"..i], true)
	end
	 
	for i = 1, 10 do
		SettingsDB.StyleButton(_G["ShapeshiftButton"..i], true)
		SettingsDB.StyleButton(_G["PetActionButton"..i], true)	
	end
end

hooksecurefunc("ActionButton_Update", style)
hooksecurefunc("ActionButton_UpdateHotkeys", updatehotkey)
hooksecurefunc("ActionButton_UpdateFlyout", styleflyout)

----------------------------------------------------------------------------------------
--	TotemBar style
----------------------------------------------------------------------------------------
if SettingsDB.class ~= "SHAMAN" then return end

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
function TotemBarFlyoutFrame(flyout)
	flyout.top:SetTexture(nil)
	flyout.middle:SetTexture(nil)

	-- Buttons
	local last = nil
	for _, button in ipairs(flyout.buttons) do
		local name = button:GetName()
		local icon = _G[name.."Icon"]
		if icon then
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetDrawLayer("ARTWORK")
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		end

		SettingsDB.CreateTemplate(button)
		SettingsDB.StyleButton(button, false)

		if not InCombatLockdown() then
			button:SetSize(SettingsDB.buttonsize, SettingsDB.buttonsize)
			button:ClearAllPoints()
			button:SetPoint("BOTTOM", last, "TOP", 0, SettingsDB.buttonspacing)
		end

		if button:IsVisible() then
			last = button
		end
	end

	flyout.buttons[1]:SetPoint("BOTTOM", flyout, "BOTTOM", 0, 0)

	if flyout.type == "slot" then
		local tcoords = SLOT_EMPTY_TCOORDS[flyout.parent:GetID()]
		flyout.buttons[1].icon:SetTexCoord(tcoords.left, tcoords.right, tcoords.top, tcoords.bottom)
	end

	-- Close Button
	local close = MultiCastFlyoutFrameCloseButton
	SettingsDB.CreateTemplate(close)
	SettingsDB.StyleButton(close, false)

	close:GetHighlightTexture():SetPoint("TOPLEFT", close, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
	close:GetHighlightTexture():SetPoint("BOTTOMRIGHT", close, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	close:GetNormalTexture():SetTexture(nil)
	close:ClearAllPoints()
	close:SetPoint("BOTTOMLEFT", last, "TOPLEFT", 0, SettingsDB.buttonspacing)
	close:SetPoint("BOTTOMRIGHT", last, "TOPRIGHT", 0, SettingsDB.buttonspacing)
	close:SetHeight(SettingsDB.buttonspacing * 4)

	flyout:ClearAllPoints()
	flyout:SetPoint("BOTTOM", flyout.parent, "TOP", 0, SettingsDB.buttonspacing)
end
hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout",function(self) TotemBarFlyoutFrame(self) end)

-- Totem Fly Out Buttons
function TotemBarFlyoutOpenButton(button, parent)
	SettingsDB.CreateTemplate(button)
	SettingsDB.StyleButton(button, false)

	button:GetNormalTexture():SetTexture(nil)
	button:GetHighlightTexture():SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
	button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))

	button:ClearAllPoints()
	button:SetFrameLevel(parent:GetFrameLevel())
	button:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, SettingsDB.Scale(-1))
	button:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, SettingsDB.Scale(-1))

	button:SetHeight(SettingsDB.buttonspacing * 4)
end
hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show",function(button,_, parent) TotemBarFlyoutOpenButton(button, parent) end)

-- Totem Slot Buttons
function TotemBarSlotButton(button, index)
	SettingsDB.CreateTemplate(button)
	SettingsDB.StyleButton(button, false)

	if _G[button:GetName().."Panel"] then
		_G[button:GetName().."Panel"]:Hide()
	end

	button.overlayTex:SetTexture(nil)
	button.overlayTex:Hide()
	button:SetNormalTexture("")

	button.background:SetDrawLayer("ARTWORK")
	button.background:ClearAllPoints()
	button.background:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
	button.background:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	
	if not InCombatLockdown() then
		button:SetSize(SettingsDB.buttonsize, SettingsDB.buttonsize)
	end
end
hooksecurefunc("MultiCastSlotButton_Update", function(self, slot) TotemBarSlotButton(self, slot) end)

function TotemBarActionButton(button, index)
	local name = button:GetName()
	local icon = _G[name.."Icon"]
	local normal = _G[name.."NormalTexture"]

	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetDrawLayer("ARTWORK")
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	end

	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end

	--SettingsDB.CreateTemplate(button)
	SettingsDB.StyleButton(button, true)

	button.overlayTex:SetTexture(nil)
	button.overlayTex:Hide()
	button:SetNormalTexture("")

	if _G[button:GetName().."Panel"] then
		_G[button:GetName().."Panel"]:Hide()
	end

	if not InCombatLockdown() then
		button:SetAllPoints(button.slotButton)
	end

	--button:SetBackdropColor(0, 0, 0, 0)
end
hooksecurefunc("MultiCastActionButton_Update", function(actionButton, actionId, actionIndex, slot) TotemBarActionButton(actionButton, actionIndex) end)


-- Summon and Recall Buttons
function TotemBarSpellButton(button, index)
	if not button then return end

	local name = button:GetName()
	local icon = _G[name.."Icon"]
	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetDrawLayer("ARTWORK")
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", button, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	end

	SettingsDB.CreateTemplate(button)
	SettingsDB.StyleButton(button, false)

	button:GetNormalTexture():SetTexture(nil)

	if not InCombatLockdown() then
		button:SetSize(SettingsDB.buttonsize, SettingsDB.buttonsize)
	end

	_G[name.."Highlight"]:SetTexture(nil)
	_G[name.."NormalTexture"]:SetTexture(nil)
end
hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) TotemBarSpellButton(self, 0) end)
hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) TotemBarSpellButton(self, 5) end)