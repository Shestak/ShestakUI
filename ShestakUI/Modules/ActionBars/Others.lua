local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

------------------------------------------------------------------------------------------
--	Manage others stuff for ActionBars(by Tukz)
------------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	SetActionBarToggles(1, 1, 1, 1, 0)
	if C.actionbar.show_grid == true then
		SetCVar("alwaysShowActionBars", 1)
		for i = 1, 12 do
			local button = _G[format("ActionButton%d", i)]
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
	else
		SetCVar("alwaysShowActionBars", 0)
	end
end)

-- Vehicle button anchor
local anchor = CreateFrame("Frame", "VehicleButtonAnchor", UIParent)
anchor:SetPoint(unpack(C.position.vehicle_bar))
anchor:SetSize(C.actionbar.button_size, C.actionbar.button_size)

-- Vehicle button
local vehicle = CreateFrame("Button", "VehicleButton", UIParent)
vehicle:SetSize(C.actionbar.button_size, C.actionbar.button_size)
vehicle:SetPoint("BOTTOMLEFT", anchor, "BOTTOMLEFT")
vehicle:SetNormalTexture("Interface\\Vehicles\\UI-Vehicles-Button-Exit-Up")
vehicle:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
vehicle:GetNormalTexture():ClearAllPoints()
vehicle:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
vehicle:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
vehicle:SetTemplate("Default")
vehicle:StyleButton(true)
vehicle:RegisterForClicks("AnyUp")

hooksecurefunc("MainMenuBarVehicleLeaveButton_Update", function()
	if CanExitVehicle() then
		if UnitOnTaxi("player") then
			vehicle:SetScript("OnClick", function(self)
				TaxiRequestEarlyLanding()
				self:LockHighlight()
			end)
		else
			vehicle:SetScript("OnClick", function(self)
				VehicleExit()
			end)
		end
		vehicle:Show()
	else
		vehicle:Hide()
	end
end)

--set tooltip
vehicle:SetScript("OnEnter", function(self)
	if UnitOnTaxi("player") then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText(TAXI_CANCEL, T.color.r, T.color.g, T.color.b);
		GameTooltip:AddLine(TAXI_CANCEL_DESCRIPTION, 1, 1, 1, true);
		GameTooltip:Show();
	else
		GameTooltip_AddNewbieTip(self, LEAVE_VEHICLE, T.color.r, T.color.g, T.color.b, nil);
	end
end)
vehicle:SetScript("OnLeave", function() GameTooltip:Hide() end)
