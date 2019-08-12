local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	UIWidget frame
----------------------------------------------------------------------------------------
local top, below = _G["UIWidgetTopCenterContainerFrame"], _G["UIWidgetBelowMinimapContainerFrame"]
local topAnchor = CreateFrame("Frame", "UIWidgetTopAnchor", UIParent)
topAnchor:SetSize(200, 30)
topAnchor:SetPoint(unpack(C.position.uiwidget))
_G["UIWidgetTopCenterContainerFrame"]:ClearAllPoints()
_G["UIWidgetTopCenterContainerFrame"]:SetPoint("CENTER", topAnchor)

local belowAnchor = CreateFrame("Frame", "UIWidgetBelowAnchor", UIParent)
belowAnchor:SetSize(100, 30)
belowAnchor:SetPoint(unpack(C.position.uiwidget))

hooksecurefunc(below, "SetPoint", function(self, _, anchor)
	if anchor and anchor ~= belowAnchor then
		self:ClearAllPoints()
		self:SetPoint("CENTER", belowAnchor)
	end
end)

for _, frame in pairs({top, below}) do
	local anchor = frame == top and topAnchor or belowAnchor
	anchor:EnableMouse(true)
	anchor:SetMovable(true)
	anchor:SetUserPlaced(true)
	frame:SetScript("OnMouseDown", function(_, button)
		if IsAltKeyDown() or IsShiftKeyDown() then
			anchor:ClearAllPoints()
			anchor:StartMoving()
		elseif IsControlKeyDown() and button == "RightButton" then
			anchor:ClearAllPoints()
			anchor:SetPoint(unpack(C.position.uiwidget))
		end
	end)
	frame:SetScript("OnMouseUp", function()
		anchor:StopMovingOrSizing()
	end)
end