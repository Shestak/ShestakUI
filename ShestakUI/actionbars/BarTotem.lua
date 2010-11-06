if not SettingsCF["actionbar"].enable == true and SettingsDB.class ~= "SHAMAN" then return end
if SettingsCF["actionbar"].shapeshift_hide == true then return end
----------------------------------------------------------------------------------------
--	Setup Totem Bar by Tukz
----------------------------------------------------------------------------------------
if MultiCastActionBarFrame then
	MultiCastActionBarFrame:SetScript("OnUpdate", nil)
	MultiCastActionBarFrame:SetScript("OnShow", nil)
	MultiCastActionBarFrame:SetScript("OnHide", nil)
	MultiCastActionBarFrame:SetParent("ShiftBar")
	MultiCastActionBarFrame:ClearAllPoints()
	MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", "ShiftBar", "BOTTOMLEFT", -3, -3)

	hooksecurefunc("MultiCastActionButton_Update", function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)

	for i = 1, 12 do
		if i < 6 then
			local button = _G["MultiCastSlotButton"..i] or MultiCastRecallSpellButton
			local prev = _G["MultiCastSlotButton"..(i-1)] or MultiCastSummonSpellButton
			prev.idx = i - 1
			button:ClearAllPoints()
			ActionButton1.SetPoint(button, "LEFT", prev, "RIGHT", SettingsDB.buttonspacing, 0)
		end
	end

	MultiCastActionBarFrame.SetParent = SettingsDB.dummy
	MultiCastActionBarFrame.SetPoint = SettingsDB.dummy
	MultiCastRecallSpellButton.SetPoint = SettingsDB.dummy -- This causes taint
end