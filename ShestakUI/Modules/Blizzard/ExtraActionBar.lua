local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

------------------------------------------------------------------------------------------
--	Make ExtraActionBarFrame movable(use macro /click ExtraActionButton1)
------------------------------------------------------------------------------------------
local anchor = CreateFrame("Frame", nil, UIParent)
anchor:SetPoint(unpack(C.position.extra_button))
anchor:SetSize(ExtraActionBarFrame:GetSize())

ExtraActionBarFrame:SetParent(anchor)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("CENTER", anchor, "CENTER")
ExtraActionBarFrame:SetMovable(true)
ExtraActionBarFrame:SetUserPlaced(true)
ExtraActionBarFrame:SetFrameStrata("MEDIUM")
ExtraActionBarFrame:SetScript("OnMouseDown", function()
	if IsAltKeyDown() or IsShiftKeyDown() then
		if not InCombatLockdown() then
			ExtraActionBarFrame:ClearAllPoints()
		end
		ExtraActionBarFrame:StartMoving()
	end
end)
ExtraActionBarFrame:SetScript("OnMouseUp", function()
	ExtraActionBarFrame:StopMovingOrSizing()
end)

RegisterStateDriver(anchor, "visibility", "[petbattle] hide; show")
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