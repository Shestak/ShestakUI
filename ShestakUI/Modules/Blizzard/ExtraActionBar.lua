local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

------------------------------------------------------------------------------------------
--	Make ExtraActionBarFrame movable (use macro /click ExtraActionButton1)
------------------------------------------------------------------------------------------
local anchor = CreateFrame("Frame", "ExtraButtonAnchor", UIParent)
anchor:SetPoint(unpack(C.position.extra_button))
anchor:SetSize(53, 53)

ExtraActionBarFrame:SetParent(UIParent)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("CENTER", anchor, "CENTER")
ExtraActionBarFrame:SetSize(53, 53)
ExtraActionBarFrame.ignoreFramePositionManager = true

RegisterStateDriver(anchor, "visibility", "[petbattle] hide; show")

DraenorZoneAbilityFrame:SetParent(UIParent)
DraenorZoneAbilityFrame:ClearAllPoints()
DraenorZoneAbilityFrame:SetPoint("CENTER", anchor, "CENTER")
DraenorZoneAbilityFrame:SetSize(53, 53)
DraenorZoneAbilityFrame.ignoreFramePositionManager = true

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
button:SetSize(53, 53)

------------------------------------------------------------------------------------------
--	Skin DraenorZoneAbilityFrame
------------------------------------------------------------------------------------------
local button = DraenorZoneAbilityFrame.SpellButton
local texture = button.Style
local disableTexture = function(style, texture)
	if texture then
		style:SetTexture(nil)
	end
end
button.Style:SetTexture(nil)
hooksecurefunc(texture, "SetTexture", disableTexture)

button:StripTextures()
button:CreateBackdrop("Default")
button:StyleButton(nil, 0)
button:SetSize(49, 49)

button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)