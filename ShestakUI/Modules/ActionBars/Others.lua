local T, C, L = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

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
VehicleButtonAnchor:Size(T.buttonsize)

-- Vehicle button
local vehicle = CreateFrame("BUTTON", "VehicleButton", UIParent, "SecureActionButtonTemplate")
vehicle:Width(T.buttonsize)
vehicle:Height(T.buttonsize)
vehicle:Point("BOTTOMLEFT", VehicleButtonAnchor, "BOTTOMLEFT", 0, 0)
vehicle:SetNormalTexture("Interface\\Vehicles\\UI-Vehicles-Button-Exit-Up")
vehicle:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
vehicle:GetNormalTexture():ClearAllPoints()
vehicle:GetNormalTexture():Point("TOPLEFT", 2, -2)
vehicle:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
vehicle:SetTemplate("Default")
vehicle:StyleButton(false)
vehicle:RegisterForClicks("AnyUp")
vehicle:SetScript("OnClick", function() VehicleExit() end)
RegisterStateDriver(vehicle, "visibility", "[target=vehicle,exists] show;hide")