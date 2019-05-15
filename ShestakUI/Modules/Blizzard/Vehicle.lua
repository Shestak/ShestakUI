local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

----------------------------------------------------------------------------------------
--	Move vehicle indicator
----------------------------------------------------------------------------------------
local VehicleAnchor = CreateFrame("Frame", "VehicleAnchor", UIParent)
VehicleAnchor:SetPoint(unpack(C.position.vehicle))
VehicleAnchor:SetSize(130, 130)

hooksecurefunc(VehicleSeatIndicator, "SetPoint", function(_, _, parent)
	if parent == "MinimapCluster" or parent == _G["MinimapCluster"] then
		VehicleSeatIndicator:ClearAllPoints()
		VehicleSeatIndicator:SetPoint("BOTTOM", VehicleAnchor, "BOTTOM", 0, 24)
		VehicleSeatIndicator:SetFrameStrata("LOW")
	end
end)

----------------------------------------------------------------------------------------
--	Vehicle indicator on mouseover
----------------------------------------------------------------------------------------
if C.misc.vehicle_mouseover == true then
	local function VehicleNumSeatIndicator()
		if VehicleSeatIndicatorButton6 then
			T.numSeat = 6
		elseif VehicleSeatIndicatorButton5 then
			T.numSeat = 5
		elseif VehicleSeatIndicatorButton4 then
			T.numSeat = 4
		elseif VehicleSeatIndicatorButton3 then
			T.numSeat = 3
		elseif VehicleSeatIndicatorButton2 then
			T.numSeat = 2
		elseif VehicleSeatIndicatorButton1 then
			T.numSeat = 1
		end
	end

	local function vehmousebutton(alpha)
		for i = 1, T.numSeat do
		local pb = _G["VehicleSeatIndicatorButton"..i]
			pb:SetAlpha(alpha)
		end
	end

	local function vehmouse()
		if VehicleSeatIndicator:IsShown() then
			VehicleSeatIndicator:SetAlpha(0)
			VehicleSeatIndicator:EnableMouse(true)

			VehicleNumSeatIndicator()

			VehicleSeatIndicator:HookScript("OnEnter", function() VehicleSeatIndicator:SetAlpha(1) vehmousebutton(1) end)
			VehicleSeatIndicator:HookScript("OnLeave", function() VehicleSeatIndicator:SetAlpha(0) vehmousebutton(0) end)

			for i = 1, T.numSeat do
				local pb = _G["VehicleSeatIndicatorButton"..i]
				pb:SetAlpha(0)
				pb:HookScript("OnEnter", function(self) VehicleSeatIndicator:SetAlpha(1) vehmousebutton(1) end)
				pb:HookScript("OnLeave", function(self) VehicleSeatIndicator:SetAlpha(0) vehmousebutton(0) end)
			end
		end
	end
	hooksecurefunc("VehicleSeatIndicator_Update", vehmouse)
end