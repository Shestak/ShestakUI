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

-- Vehicle button
local vehicle = CreateFrame("BUTTON", "VehicleButton", UIParent, "SecureActionButtonTemplate")
vehicle:Width(T.buttonsize)
vehicle:Height(T.buttonsize)
vehicle:Point(unpack(C.position.vehicle_bar))
vehicle:SetNormalTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Vehicle.tga")
vehicle:SetPushedTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Vehicle.tga")
vehicle:SetHighlightTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\Vehicle.tga")
vehicle:SetTemplate("Default")
vehicle:RegisterForClicks("AnyUp")
vehicle:SetScript("OnClick", function() VehicleExit() end)
RegisterStateDriver(vehicle, "visibility", "[target=vehicle,exists] show;hide")