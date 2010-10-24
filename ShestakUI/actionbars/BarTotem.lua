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
	MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", "ShiftBar", "BOTTOMLEFT", 0, -10)
 
	hooksecurefunc("MultiCastActionButton_Update",function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)
 
	--MultiCastActionBarFrame.SetParent = SettingsDB.dummy
	--MultiCastActionBarFrame.SetPoint = SettingsDB.dummy
	--MultiCastRecallSpellButton.SetPoint = SettingsDB.dummy
end