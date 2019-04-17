local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	StanceBar(by Tukz)
----------------------------------------------------------------------------------------
local ShiftHolder = CreateFrame("Frame", "ShiftHolder", T_PetBattleFrameHider)
if C.actionbar.stancebar_horizontal == true then
	ShiftHolder:SetPoint(unpack(C.position.stance_bar))
	ShiftHolder:SetWidth((C.actionbar.button_size * 7) + (C.actionbar.button_space * 6))
	ShiftHolder:SetHeight(C.actionbar.button_size)
else
	if (PetActionBarFrame:IsShown() or PetHolder) and C.actionbar.petbar_horizontal ~= true then
		ShiftHolder:SetPoint("RIGHT", "PetHolder", "LEFT", -C.actionbar.button_space, (C.actionbar.button_size / 2) + 1)
	else
		ShiftHolder:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", -C.actionbar.button_space, (C.actionbar.button_size / 2) + 1)
	end
	ShiftHolder:SetWidth(C.actionbar.button_size)
	ShiftHolder:SetHeight((C.actionbar.button_size * 7) + (C.actionbar.button_space * 6))
end

-- Hide bar
if C.actionbar.stancebar_hide then ShiftHolder:Hide() return end

-- Create bar
local bar = CreateFrame("Frame", "UIShapeShift", ShiftHolder, "SecureHandlerStateTemplate")
bar:ClearAllPoints()
bar:SetAllPoints(ShiftHolder)

local States = {
	["DEATHKNIGHT"] = "show",
	["DRUID"] = "show",
	["MONK"] = "show",
	["PALADIN"] = "show",
	["PRIEST"] = "show",
	["ROGUE"] = "show",
	["WARLOCK"] = "show",
	["WARRIOR"] = "show",
}

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
bar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
bar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
bar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
bar:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		for i = 1, NUM_STANCE_SLOTS do
			local button = _G["StanceButton"..i]
			button:ClearAllPoints()
			button:SetParent(self)
			if i == 1 then
				if C.actionbar.stancebar_horizontal == true then
					button:SetPoint("BOTTOMLEFT", ShiftHolder, "BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", ShiftHolder, "TOPLEFT", 0, 0)
				end
			else
				local previous = _G["StanceButton"..i-1]
				if C.actionbar.stancebar_horizontal == true then
					button:SetPoint("LEFT", previous, "RIGHT", C.actionbar.button_space, 0)
				else
					button:SetPoint("TOP", previous, "BOTTOM", 0, -C.actionbar.button_space)
				end
			end
			local icon = GetShapeshiftFormInfo(i)
			if icon then
				button:Show()
			else
				button:Hide()
			end
		end
		RegisterStateDriver(self, "visibility", States[T.class] or "hide")
		local function moveStance()
			if not InCombatLockdown() then
				if C.actionbar.stancebar_horizontal == true then
					StanceButton1:SetPoint("BOTTOMLEFT", ShiftHolder, "BOTTOMLEFT", 0, 0)
				else
					StanceButton1:SetPoint("TOPLEFT", ShiftHolder, "TOPLEFT", 0, 0)
				end
			end
		end
		hooksecurefunc("StanceBar_Update", moveStance)
	elseif event == "UPDATE_SHAPESHIFT_FORMS" then
		if InCombatLockdown() then return end
		for i = 1, NUM_STANCE_SLOTS do
			local button = _G["StanceButton"..i]
			local icon = GetShapeshiftFormInfo(i)
			if icon then
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
if C.actionbar.rightbars_mouseover == true and C.actionbar.stancebar_horizontal == false then
	ShapeShiftBarAnchor:SetAlpha(0)
	ShapeShiftBarAnchor:SetScript("OnEnter", function() RightBarMouseOver(1) end)
	ShapeShiftBarAnchor:SetScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	for i = 1, NUM_STANCE_SLOTS do
		local b = _G["StanceButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	end
end
if C.actionbar.stancebar_mouseover == true and C.actionbar.stancebar_horizontal == true then
	ShapeShiftBarAnchor:SetAlpha(0)
	ShapeShiftBarAnchor:SetScript("OnEnter", function() StanceBarMouseOver(1) end)
	ShapeShiftBarAnchor:SetScript("OnLeave", function() if not HoverBind.enabled then StanceBarMouseOver(0) end end)
	for i = 1, NUM_STANCE_SLOTS do
		local b = _G["StanceButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() StanceBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then StanceBarMouseOver(0) end end)
	end
end