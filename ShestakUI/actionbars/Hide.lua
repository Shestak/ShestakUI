if not SettingsCF["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- Hide all Blizzard stuff that we don't need by Tukz
---------------------------------------------------------------------------

do
	MainMenuBar:SetScale(0.00001)
	MainMenuBar:SetAlpha(0)
	MainMenuBar:EnableMouse(false)
	VehicleMenuBar:SetScale(0.00001)
	VehicleMenuBar:SetAlpha(0)
	VehicleMenuBar:EnableMouse(false)
	PetActionBarFrame:EnableMouse(false)
	ShapeshiftBarFrame:EnableMouse(false)
	local elements = {
		MainMenuBar, MainMenuBarArtFrame, BonusActionBarFrame, VehicleMenuBar,
		PossessBarFrame, PetActionBarFrame, ShapeshiftBarFrame,
		ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
	}
	for _, element in pairs(elements) do
		if element:GetObjectType() == "Frame" then
			element:UnregisterAllEvents()
		end
		element:Hide()
		element:SetAlpha(0)
	end
	elements = nil
end

do
	local uiManagedFrames = {
		"MultiBarLeft",
		"MultiBarRight",
		"MultiBarBottomLeft",
		"MultiBarBottomRight",
		"ShapeshiftBarFrame",
		"PossessBarFrame",
		"PETACTIONBAR_YPOS",
		"MultiCastActionBarFrame",
		"MULTICASTACTIONBAR_YPOS",
		"ChatFrame1",
		"ChatFrame2",
	}
	for _, frame in pairs(uiManagedFrames) do
		UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
	end
	uiManagedFrames = nil
end

function RightBarMouseOver(alpha)
	RightActionBarAnchor:SetAlpha(alpha)
	PetActionBarAnchor:SetAlpha(alpha)
	if SettingsCF["actionbar"].rightbars >= 2 then
		if MultiBarLeft:IsShown() then
			for i = 1, 12 do
				local pb = _G["MultiBarLeftButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarLeft:SetAlpha(alpha)
		end
	end
	if SettingsCF["actionbar"].rightbars > 1 then
		if SettingsCF.actionbar.bottombars ~= 3 then
			if MultiBarBottomRight:IsShown() then
				for i = 1, 12 do
					local pb = _G["MultiBarBottomRightButton"..i]
					pb:SetAlpha(alpha)
				end
				MultiBarBottomRight:SetAlpha(alpha)
			end
		end
	end
	if SettingsCF["actionbar"].rightbars > 0 then
		if MultiBarRight:IsShown() then
			for i = 1, 12 do
				local pb = _G["MultiBarRightButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarRight:SetAlpha(alpha)
		end
	end
	if SettingsCF.actionbar.petbar_horizontal == false then
		if PetHolder:IsShown() then
			for i = 1, NUM_PET_ACTION_SLOTS do
				local pb = _G["PetActionButton"..i]
				pb:SetAlpha(alpha)
			end	
			PetHolder:SetAlpha(alpha)
		end
	end
end

function ShapeShiftMouseOver(alpha)
	if SettingsDB.class == "SHAMAN" then
		for i = 1, 12 do
			local pb = _G["MultiCastActionButton"..i]
			pb:SetAlpha(alpha)
		end
		for i = 1, 4 do
			local pb = _G["MultiCastSlotButton"..i]
			pb:SetAlpha(alpha)
		end
		_G["MultiCastSummonSpellButton"]:SetAlpha(alpha)
		_G["MultiCastRecallSpellButton"]:SetAlpha(alpha)
	else
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			local pb = _G["ShapeshiftButton"..i]
			pb:SetAlpha(alpha)
		end
		ShapeShiftBarAnchor:SetAlpha(alpha)
	end
end

function PetMouseOver(alpha)
	for i = 1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(alpha)
	end
	PetHolder:SetAlpha(alpha)
end

do
	if SettingsCF.actionbar.rightbars_mouseover == true then
		RightActionBarAnchor:SetAlpha(0)
		RightActionBarAnchor:SetScript("OnEnter", function() RightBarMouseOver(1) end)
		RightActionBarAnchor:SetScript("OnLeave", function() RightBarMouseOver(0) end)
		if SettingsCF.actionbar.petbar_horizontal == false then
			PetActionBarAnchor:SetAlpha(0)
			PetActionBarAnchor:SetScript("OnEnter", function() RightBarMouseOver(1) end)
			PetActionBarAnchor:SetScript("OnLeave", function() RightBarMouseOver(0) end)
		end
	end
	if SettingsCF.actionbar.petbar_mouseover == true and SettingsCF.actionbar.petbar_horizontal == true then
		PetActionBarAnchor:SetAlpha(0)
		PetActionBarAnchor:SetScript("OnEnter", function() PetMouseOver(1) end)
		PetActionBarAnchor:SetScript("OnLeave", function() PetMouseOver(0) end)
	end
end