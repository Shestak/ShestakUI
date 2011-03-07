local T, C, L = unpack(select(2, ...))
if not (C.actionbar.enable == true and T.class == "SHAMAN") or C.actionbar.shapeshift_hide == true then return end

----------------------------------------------------------------------------------------
--	Setup Totem Bar by Tukz
----------------------------------------------------------------------------------------
if MultiCastActionBarFrame then
	MultiCastActionBarFrame:SetScript("OnUpdate", nil)
	MultiCastActionBarFrame:SetScript("OnShow", nil)
	MultiCastActionBarFrame:SetScript("OnHide", nil)
	MultiCastActionBarFrame:SetParent("ShiftBar")
	MultiCastActionBarFrame:ClearAllPoints()
	MultiCastActionBarFrame:Point("BOTTOMLEFT", "ShiftBar", "BOTTOMLEFT", -3, T.buttonsize + T.buttonspacing -3)

	hooksecurefunc("MultiCastActionButton_Update", function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)

	for i = 1, 12 do
		if i < 6 then
			local button = _G["MultiCastSlotButton"..i] or MultiCastRecallSpellButton
			local prev = _G["MultiCastSlotButton"..(i-1)] or MultiCastSummonSpellButton
			prev.idx = i - 1
			button:ClearAllPoints()
			ActionButton1.Point(button, "LEFT", prev, "RIGHT", T.buttonspacing, 0)
		end
	end

	MultiCastActionBarFrame.SetParent = T.dummy
	MultiCastActionBarFrame.SetPoint = T.dummy
	MultiCastRecallSpellButton.SetPoint = T.dummy -- This causes taint
end