local T, C, L = unpack(select(2, ...))

------------------------------------------------------------------------------------------
--	Make ExtraActionBarFrame movable
------------------------------------------------------------------------------------------
ExtraActionBarFrame:SetParent(UIParent)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("BOTTOM", 0, 270)
ExtraActionBarFrame:SetMovable(true)
ExtraActionBarFrame:SetUserPlaced(true)
ExtraActionBarFrame:SetFrameStrata("HIGH")
ExtraActionBarFrame:SetScript("OnMouseDown", function()
	if IsAltKeyDown() or IsShiftKeyDown() then
		ExtraActionBarFrame:ClearAllPoints()
		ExtraActionBarFrame:StartMoving()
	end
end)
ExtraActionBarFrame:SetScript("OnMouseUp", function()
	ExtraActionBarFrame:StopMovingOrSizing()
end)