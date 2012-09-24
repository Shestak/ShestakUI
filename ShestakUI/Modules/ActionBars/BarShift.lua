local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	StanceBar(by Tukz)
----------------------------------------------------------------------------------------
local ShiftHolder = CreateFrame("Frame", "ShiftHolder", UIParent)
if C.actionbar.stancebar_horizontal == true then
	ShiftHolder:Point(unpack(C.position.stance_bar))
	ShiftHolder:Width((C.actionbar.button_size * 7) + (C.actionbar.button_space * 6))
	ShiftHolder:Height(C.actionbar.button_size)
else
	if (PetActionBarFrame:IsShown() or PetHolder) and C.actionbar.petbar_horizontal ~= true then
		ShiftHolder:Point("RIGHT", "PetHolder", "LEFT", -C.actionbar.button_space, (C.actionbar.button_size / 2) + 1)
	else
		ShiftHolder:Point("RIGHT", "RightActionBarAnchor", "LEFT", -C.actionbar.button_space, (C.actionbar.button_size / 2) + 1)
	end
	ShiftHolder:Width(C.actionbar.button_size)
	ShiftHolder:Height((C.actionbar.button_size * 7) + (C.actionbar.button_space * 6))
end

-- Stance command to move totem or stance in-game
local ShapeShiftAnchor = CreateFrame("Frame", "ShapeShiftAnchor", UIParent)
ShapeShiftAnchor:SetAllPoints(ShiftHolder)

-- Hide bar
if C.actionbar.stancebar_hide then ShiftHolder:Hide() return end

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
	["MONK"] = "show",
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
		for i = 1, NUM_STANCE_SLOTS do
			local button = _G["StanceButton"..i]
			button:ClearAllPoints()
			button:SetParent(self)
			if i == 1 then
				if C.actionbar.stancebar_horizontal == true then
					button:Point("BOTTOMLEFT", ShiftHolder, "BOTTOMLEFT", 0, 0)
				else
					button:Point("TOPLEFT", ShiftHolder, "TOPLEFT", 0, 0)
				end
			else
				local previous = _G["StanceButton"..i-1]
				if C.actionbar.stancebar_horizontal == true then
					button:Point("LEFT", previous, "RIGHT", C.actionbar.button_space, 0)
				else
					button:Point("TOP", previous, "BOTTOM", 0, -C.actionbar.button_space)
				end
			end
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			else
				button:Hide()
			end
		end
		RegisterStateDriver(self, "visibility", States[T.class] or "hide")
		local function movestance()
			if not InCombatLockdown() then
				if C.actionbar.stancebar_horizontal == true then
					StanceButton1:Point("BOTTOMLEFT", ShiftHolder, "BOTTOMLEFT", 0, 0)
				else
					StanceButton1:Point("TOPLEFT", ShiftHolder, "TOPLEFT", 0, 0)
				end
			end
		end
		hooksecurefunc("StanceBar_Update", movestance)
	elseif event == "UPDATE_SHAPESHIFT_FORMS" then
		if InCombatLockdown() then return end
		for i = 1, NUM_STANCE_SLOTS do
			local button = _G["StanceButton"..i]
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
if C.actionbar.rightbars_mouseover == true and C.actionbar.stancebar_horizontal == false then
	for i = 1, NUM_STANCE_SLOTS do
		local b = _G["StanceButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	end
end
if C.actionbar.stancebar_mouseover == true and C.actionbar.stancebar_horizontal == true then
	ShapeShiftBarAnchor:SetAlpha(0)
	ShapeShiftBarAnchor:SetScript("OnEnter", function() ShapeShiftMouseOver(1) end)
	ShapeShiftBarAnchor:SetScript("OnLeave", function() if not HoverBind.enabled then ShapeShiftMouseOver(0) end end)
	for i = 1, NUM_STANCE_SLOTS do
		local b = _G["StanceButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() ShapeShiftMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then ShapeShiftMouseOver(0) end end)
	end
end