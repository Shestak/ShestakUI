if not SettingsCF["actionbar"].enable == true then return end

----------------------------------------------------------------------------------------
--	Setup Shapeshift Bar by Tukz
----------------------------------------------------------------------------------------
local ShiftHolder = CreateFrame("Frame", "ShiftBar", UIParent)
if SettingsCF["actionbar"].shapeshift_horizontal == true then
	ShiftHolder:SetPoint(unpack(SettingsCF["position"].stance_bar))
	ShiftHolder:SetWidth((SettingsDB.buttonsize * 7) + (SettingsDB.buttonspacing * 6))
	ShiftHolder:SetHeight(SettingsDB.buttonsize)
else
	if (PetActionBarFrame:IsShown() or PetHolder) and SettingsCF["actionbar"].petbar_horizontal ~= true then
		ShiftHolder:SetPoint("RIGHT", "PetHolder", "LEFT", -SettingsDB.buttonspacing, (SettingsDB.buttonsize / 2) + 1)
	else
		ShiftHolder:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", -SettingsDB.buttonspacing, (SettingsDB.buttonsize / 2) + 1)
	end
	ShiftHolder:SetWidth(SettingsDB.buttonsize)
	ShiftHolder:SetHeight((SettingsDB.buttonsize * 7) + (SettingsDB.buttonspacing * 6))
end

-- Hide bar
if SettingsCF.actionbar.shapeshift_hide then ShiftHolder:Hide() return end

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
				if SettingsCF["actionbar"].shapeshift_horizontal == true then
					button:SetPoint("BOTTOMLEFT", ShiftHolder, "BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", ShiftHolder, "TOPLEFT", 0, 0)
				end
			else
				local previous = _G["ShapeshiftButton"..i-1]
				if SettingsCF["actionbar"].shapeshift_horizontal == true then
					button:SetPoint("LEFT", previous, "RIGHT", SettingsDB.buttonspacing, 0)
				else
					button:SetPoint("TOP", previous, "BOTTOM", 0, -SettingsDB.buttonspacing)
				end
			end
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			end
		end
		RegisterStateDriver(self, "visibility", States[SettingsDB.class] or "hide")
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
		SettingsDB.ShiftBarUpdate()
	elseif event == "PLAYER_ENTERING_WORLD" then
		SettingsDB.StyleShift()
	else
		SettingsDB.ShiftBarUpdate()
	end
end)

-- Mouseover bar
if SettingsCF.actionbar.shapeshift_mouseover == true then
	if SettingsDB.class == "SHAMAN" then
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