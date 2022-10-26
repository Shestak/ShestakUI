local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

------------------------------------------------------------------------------------------
--	Make ExtraActionBarFrame movable (use macro /click ExtraActionButton1)
------------------------------------------------------------------------------------------
local anchor = CreateFrame("Frame", "ExtraButtonAnchor", UIParent)
if C.actionbar.split_bars then
	anchor:SetPoint(C.position.extra_button[1], SplitBarLeft, C.position.extra_button[3], C.position.extra_button[4], C.position.extra_button[5])
else
	anchor:SetPoint(unpack(C.position.extra_button))
end
local size = C.actionbar.button_size * 2 + C.actionbar.button_space
anchor:SetSize(size, size)
anchor:SetFrameStrata("LOW")
RegisterStateDriver(anchor, "visibility", "[petbattle] hide; show")

ExtraActionBarFrame:SetParent(anchor)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetAllPoints()

-- Prevent reanchor
ExtraActionBarFrame.ignoreInLayout = true
--BETA UIPARENT_MANAGED_FRAME_POSITIONS.ExtraAbilityContainer = nil
ExtraAbilityContainer.ignoreFramePositionManager = true

-- Prevent taint
ExtraAbilityContainer.SetSize = T.dummy
ExtraAbilityContainer:SetScript("OnShow", nil)
ExtraAbilityContainer:SetScript("OnHide", nil)

-- Zone Ability button
local zoneAnchor = CreateFrame("Frame", "ZoneButtonAnchor", UIParent)
if C.actionbar.split_bars then
	zoneAnchor:SetPoint(C.position.zone_button[1], SplitBarLeft, C.position.zone_button[3], C.position.zone_button[4], C.position.zone_button[5])
else
	zoneAnchor:SetPoint(unpack(C.position.zone_button))
end
zoneAnchor:SetSize(109, size)
zoneAnchor:SetFrameStrata("LOW")
RegisterStateDriver(zoneAnchor, "visibility", "[petbattle] hide; show")

ZoneAbilityFrame:SetParent(zoneAnchor)
ZoneAbilityFrame:ClearAllPoints()
ZoneAbilityFrame:SetAllPoints()
ZoneAbilityFrame.ignoreInLayout = true
ZoneAbilityFrame.SpellButtonContainer:SetPoint("TOPRIGHT", zoneAnchor)
ZoneAbilityFrame.SpellButtonContainer.spacing = 3

hooksecurefunc("ExtraActionBar_Update", function()
	if ShestakUIPositions["ZoneButtonAnchor"] then return end
	if HasExtraActionBar() then
		zoneAnchor:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMLEFT", -3, 0)
	else
		if C.actionbar.split_bars then
			zoneAnchor:SetPoint(C.position.zone_button[1], SplitBarLeft, C.position.zone_button[3], C.position.zone_button[4], C.position.zone_button[5])
		else
			zoneAnchor:SetPoint(unpack(C.position.zone_button))
		end
	end
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

button:SetSize(size, size)

button.Count:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
button.Count:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
button.Count:SetPoint("BOTTOMRIGHT", 0, 1)
button.Count:SetJustifyH("RIGHT")

button:SetAttribute("showgrid", 1)

------------------------------------------------------------------------------------------
--	Skin ZoneAbilityFrame
------------------------------------------------------------------------------------------
local function SkinZoneAbilities()
	for button in ZoneAbilityFrame.SpellButtonContainer:EnumerateActive() do
		if not button.IsSkinned then
			button.NormalTexture:SetAlpha(0)
			button:StyleButton()
			button:SetSize(size, size)
			button:SetTemplate("Transparent")
			if C.actionbar.classcolor_border == true then
				button:SetBackdropBorderColor(unpack(C.media.classborder_color))
			end

			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.Icon:SetPoint("TOPLEFT", button, 2, -2)
			button.Icon:SetPoint("BOTTOMRIGHT", button, -2, 2)
			button.Icon:SetDrawLayer("BACKGROUND", 7)

			button.Count:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
			button.Count:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
			button.Count:SetPoint("BOTTOMRIGHT", 0, 1)
			button.Count:SetJustifyH("RIGHT")

			button.Cooldown:SetAllPoints(button.Icon)

			button.IsSkinned = true
		end
	end
end

hooksecurefunc(ZoneAbilityFrame, "UpdateDisplayedZoneAbilities", SkinZoneAbilities)
ZoneAbilityFrame.Style:SetAlpha(0)