local T, C, L = unpack(select(2, ...))
if not C.actionbar.enable == true then return end

------------------------------------------------------------------------------------------
--	Make ExtraActionBarFrame movable(use macro /click ExtraActionButton1)
------------------------------------------------------------------------------------------
ExtraActionBarFrame:SetParent(UIParent)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("BOTTOM", 0, 350)
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

------------------------------------------------------------------------------------------
--	Skin ExtraActionBarFrame(by Roth)
------------------------------------------------------------------------------------------
local button = ExtraActionButton1
local icon = button.icon
local texture = button.style
local disableTexture = function(style, texture)
	if string.sub(texture, 1, 9) == "Interface" then
		style:SetTexture("")
	end
end
button.style:SetTexture("")
hooksecurefunc(texture, "SetTexture", disableTexture)

icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
icon:Point("TOPLEFT", button, 2, -2)
icon:Point("BOTTOMRIGHT", button, -2, 2)
icon:SetDrawLayer("ARTWORK")

button:StyleButton(true)

button:SetTemplate("Default")