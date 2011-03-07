local T, C, L = unpack(select(2, ...))
if not C.actionbar.enable == true then return end

------------------------------------------------------------------------------------------
--	Manage all others stuff for actionbars by Tukz
------------------------------------------------------------------------------------------
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")	
	SetActionBarToggles(1, 1, 1, 1, 0)
	SetCVar("alwaysShowActionBars", 0)	
	if C.actionbar.show_grid == true then
		ActionButton_HideGrid = T.dummy
		for i = 1, 12 do
			local button = _G[format("ActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)

			button = _G[format("BonusActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)

			button = _G[format("MultiBarBottomRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarBottomLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
		end
	end
end)

-- Vehicle button anchor
local VehicleButtonAnchor = CreateFrame("Frame", "VehicleButtonAnchor", UIParent)
VehicleButtonAnchor:Point(unpack(C.position.vehicle_bar))
VehicleButtonAnchor:Size(T.buttonsize, T.buttonsize)
VehicleButtonAnchor:SetMovable(true)
VehicleButtonAnchor:SetClampedToScreen(true)
VehicleButtonAnchor:SetTemplate("Transparent")
VehicleButtonAnchor:SetBackdropBorderColor(1, 0, 0)
VehicleButtonAnchor:SetAlpha(0)
VehicleButtonAnchor.text = VehicleButtonAnchor:CreateFontString("VehicleButtonAnchorText", "OVERLAY", nil)
VehicleButtonAnchor.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
VehicleButtonAnchor.text:SetPoint("CENTER")
VehicleButtonAnchor.text:SetText("VehicleButton Anchor")

-- Vehicle button
local vehicle = CreateFrame("BUTTON", "VehicleButton", UIParent, "SecureActionButtonTemplate")
vehicle:Width(T.buttonsize)
vehicle:Height(T.buttonsize)
vehicle:Point("TOPRIGHT", VehicleButtonAnchor, "BOTTOMRIGHT", 0, -T.buttonspacing)
vehicle:SetNormalTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Vehicle.tga")
vehicle:SetPushedTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Vehicle.tga")
vehicle:SetHighlightTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Vehicle.tga")
vehicle:SetTemplate("Default")
vehicle:RegisterForClicks("AnyUp")
vehicle:SetScript("OnClick", function() VehicleExit() end)
RegisterStateDriver(vehicle, "visibility", "[target=vehicle,exists] show;hide")