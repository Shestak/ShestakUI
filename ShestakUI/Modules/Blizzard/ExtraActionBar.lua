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

ZoneAbilityFrame:SetParent(UIParent)
ZoneAbilityFrame:ClearAllPoints()
ZoneAbilityFrame:SetPoint("CENTER", anchor, "CENTER")
ZoneAbilityFrame:SetSize(53, 53)
ZoneAbilityFrame.ignoreFramePositionManager = true

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
--	Skin ZoneAbilityFrame
------------------------------------------------------------------------------------------
local button = ZoneAbilityFrame.SpellButton
local texture = button.Style
local disableTexture = function(style, texture)
	if texture then
		style:SetTexture(nil)
	end
end
button.Style:SetTexture(nil)
hooksecurefunc(texture, "SetTexture", disableTexture)

button:StripTextures()
button:StyleButton()
button:SetSize(53, 53)
button:CreateBackdrop("Transparent")
button.backdrop:SetAllPoints()
if C.actionbar.classcolor_border == true then
	button.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
end

button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
button.Icon:SetPoint("TOPLEFT", button, 2, -2)
button.Icon:SetPoint("BOTTOMRIGHT", button, -2, 2)

button.Count:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
button.Count:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
button.Count:SetPoint("BOTTOMRIGHT", 1, -2)
button.Count:SetJustifyH("RIGHT")

button.Cooldown:SetAllPoints(button.Icon)