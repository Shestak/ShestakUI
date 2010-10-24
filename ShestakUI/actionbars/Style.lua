----------------------------------------------------------------------------------------
--	By Tukz
----------------------------------------------------------------------------------------
if not SettingsCF["actionbar"].enable == true then return end

local _G = _G
local media = SettingsCF["media"]
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
	Count:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
 
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
	HotKey:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
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