local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	UIWidget frame
----------------------------------------------------------------------------------------
local top = _G["UIWidgetTopCenterContainerFrame"]
top:ClearAllPoints()
top:SetPoint(unpack(C.position.uiwidget))

local below = _G["UIWidgetBelowMinimapContainerFrame"]
local function RepositionBelowFrame(_, _, parent)
	if parent == "MinimapCluster" or parent == _G["MinimapCluster"] then
		below:ClearAllPoints()
		below:SetPoint(unpack(C.position.uiwidget))
	end
end

hooksecurefunc(below, "SetPoint", RepositionBelowFrame)

for _, frame in pairs({top, below}) do
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:SetUserPlaced(true)
	frame:SetScript("OnMouseDown", function(self, button)
		if IsAltKeyDown() or IsShiftKeyDown() then
			frame:ClearAllPoints()
			frame:StartMoving()
		elseif IsControlKeyDown() and button == "RightButton" then
			frame:ClearAllPoints()
			frame:SetPoint(unpack(C.position.uiwidget))
		end
	end)
	frame:SetScript("OnMouseUp", function()
		frame:StopMovingOrSizing()
	end)
end