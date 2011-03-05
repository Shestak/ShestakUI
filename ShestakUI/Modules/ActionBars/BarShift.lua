local T, C, L = unpack(select(2, ...))
if not C.actionbar.enable == true then return end

----------------------------------------------------------------------------------------
--	Setup Shapeshift Bar by Tukz
----------------------------------------------------------------------------------------
local ShiftHolder = CreateFrame("Frame", "ShiftBar", UIParent)
if C.actionbar.shapeshift_horizontal == true then
	ShiftHolder:Point(unpack(C.position.stance_bar))
	ShiftHolder:Width((T.buttonsize * 7) + (T.buttonspacing * 6))
	ShiftHolder:Height(T.buttonsize)
else
	if (PetActionBarFrame:IsShown() or PetHolder) and C.actionbar.petbar_horizontal ~= true then
		ShiftHolder:Point("RIGHT", "PetHolder", "LEFT", -T.buttonspacing, (T.buttonsize / 2) + 1)
	else
		ShiftHolder:Point("RIGHT", "RightActionBarAnchor", "LEFT", -T.buttonspacing, (T.buttonsize / 2) + 1)
	end
	ShiftHolder:Width(T.buttonsize)
	ShiftHolder:Height((T.buttonsize * 7) + (T.buttonspacing * 6))
end
ShiftHolder:SetFrameStrata("HIGH")
ShiftHolder:SetMovable(true)
ShiftHolder:SetClampedToScreen(true)

-- Shapeshift command to move totem or shapeshift in-game
local ShapeShiftAnchor = CreateFrame("Frame", "ShapeShiftAnchor", UIParent)
ShapeShiftAnchor:SetAllPoints(ShiftHolder)
ShapeShiftAnchor:SetTemplate("Transparent")
ShapeShiftAnchor:SetFrameStrata("HIGH")
ShapeShiftAnchor:SetBackdropBorderColor(1, 0, 0)
ShapeShiftAnchor:SetAlpha(0)
ShapeShiftAnchor.text = ShapeShiftAnchor:CreateFontString("ShapeShiftAnchorText", "OVERLAY")
ShapeShiftAnchor.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
ShapeShiftAnchor.text:SetPoint("CENTER")
ShapeShiftAnchor.text:SetText("Shapeshift Anchor")

-- Hide bar
if C.actionbar.shapeshift_hide then ShiftHolder:Hide() return end

-- Create bar
local bar = CreateFrame("Frame", "UIShapeShift", ShiftHolder, "SecureHandlerStateTemplate")
bar:ClearAllPoints()
bar:SetAllPoints(ShiftHolder)

local States = {
	["DRUID"] = "show",
	["WARRIOR"] = "show",
	["PALADIN"] = "show",
	["DEATHKNIGHT"] = "show",
	["ROGUE"] = "show",
	["PRIEST"] = "show",
	["HUNTER"] = "show",
	["WARLOCK"] = "show",
}

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
bar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
bar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
bar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
bar:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		local button
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			button = _G["ShapeshiftButton"..i]
			button:ClearAllPoints()
			button:SetParent(self)
			if i == 1 then
				if C.actionbar.shapeshift_horizontal == true then
					button:Point("BOTTOMLEFT", ShiftHolder, "BOTTOMLEFT", 0, 0)
				else
					button:Point("TOPLEFT", ShiftHolder, "TOPLEFT", 0, 0)
				end
			else
				local previous = _G["ShapeshiftButton"..i-1]
				if C.actionbar.shapeshift_horizontal == true then
					button:Point("LEFT", previous, "RIGHT", T.buttonspacing, 0)
				else
					button:Point("TOP", previous, "BOTTOM", 0, -T.buttonspacing)
				end
			end
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			end
		end
		RegisterStateDriver(self, "visibility", States[T.class] or "hide")
	elseif event == "UPDATE_SHAPESHIFT_FORMS" then
		-- Update Shapeshift Bar Button Visibility
		-- I seriously don't know if it's the best way to do it on spec changes or when we learn a new stance.
		if InCombatLockdown() then return end -- > just to be safe ;p
		local button
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			button = _G["ShapeshiftButton"..i]
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			else
				button:Hide()
			end
		end
		T.ShiftBarUpdate()
	elseif event == "PLAYER_ENTERING_WORLD" then
		T.StyleShift()
	else
		T.ShiftBarUpdate()
	end
end)

-- Mouseover bar
if C.actionbar.shapeshift_mouseover == true then
	if T.class == "SHAMAN" then
		MultiCastSummonSpellButton:SetAlpha(0)
		MultiCastSummonSpellButton:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
		MultiCastSummonSpellButton:HookScript("OnLeave", function() ShapeShiftMouseOver(0) end)
		MultiCastRecallSpellButton:SetAlpha(0)
		MultiCastRecallSpellButton:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
		MultiCastRecallSpellButton:HookScript("OnLeave", function() ShapeShiftMouseOver(0) end)
		MultiCastFlyoutFrameOpenButton:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
		MultiCastFlyoutFrameOpenButton:HookScript("OnLeave", function() ShapeShiftMouseOver(0) end)
		MultiCastFlyoutFrame:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
		MultiCastFlyoutFrame:HookScript("OnLeave", function() ShapeShiftMouseOver(0) end)
		MultiCastActionBarFrame:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
		MultiCastActionBarFrame:HookScript("OnLeave", function() ShapeShiftMouseOver(0) end)
		for i = 1, 12 do
			local b = _G["MultiCastActionButton"..i]
			b:SetAlpha(0)
			b:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
			b:HookScript("OnLeave", function() ShapeShiftMouseOver(0) end)
		end
		for i = 1, 4 do
			local b = _G["MultiCastSlotButton"..i]
			b:SetAlpha(0)
			b:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
			b:HookScript("OnLeave", function() ShapeShiftMouseOver(0) end)
		end
	else
		ShapeShiftBarAnchor:SetAlpha(0)
		ShapeShiftBarAnchor:SetScript("OnEnter", function() ShapeShiftMouseOver(1) end)
		ShapeShiftBarAnchor:SetScript("OnLeave", function() ShapeShiftMouseOver(1) end)
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			local b = _G["ShapeshiftButton"..i]
			b:SetAlpha(0)
			b:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
			b:HookScript("OnLeave", function() ShapeShiftMouseOver(0) end)
		end
	end
end