local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

------------------------------------------------------------------------------------------
--	Make ExtraActionBarFrame movable(use macro /click ExtraActionButton1)
------------------------------------------------------------------------------------------
ExtraActionBarFrame:SetParent(UIParent)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint(unpack(C.position.extra_button))
ExtraActionBarFrame:SetMovable(true)
ExtraActionBarFrame:SetUserPlaced(true)
ExtraActionBarFrame:SetFrameStrata("MEDIUM")
ExtraActionBarFrame:SetScript("OnMouseDown", function()
	if IsAltKeyDown() or IsShiftKeyDown() then
		ExtraActionBarFrame:ClearAllPoints()
		ExtraActionBarFrame:StartMoving()
	end
end)
ExtraActionBarFrame:SetScript("OnMouseUp", function()
	ExtraActionBarFrame:StopMovingOrSizing()
end)

------------------------------------------------------------------------------------------
--	Skin ExtraActionBarFrame(by Zork)
------------------------------------------------------------------------------------------
local button = ExtraActionButton1
local texture = button.style
local disableTexture = function(style, texture)
	if texture then
		style:SetTexture(nil)
	end
end
button.style:SetTexture(nil)
hooksecurefunc(texture, "SetTexture", disableTexture)

button:StyleButton()