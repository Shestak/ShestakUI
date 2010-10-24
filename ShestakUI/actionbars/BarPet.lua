if not SettingsCF["actionbar"].enable == true then return end

----------------------------------------------------------------------------------------
--	Setup PetActionBar by Tukz
----------------------------------------------------------------------------------------
-- Create bar
local bar = CreateFrame("Frame", "PetHolder", UIParent, "SecureHandlerStateTemplate")
bar:ClearAllPoints()
bar:SetAllPoints(PetActionBarAnchor)

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_CONTROL_LOST")
bar:RegisterEvent("PLAYER_CONTROL_GAINED")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
bar:RegisterEvent("PET_BAR_UPDATE")
bar:RegisterEvent("PET_BAR_UPDATE_USABLE")
bar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
bar:RegisterEvent("PET_BAR_HIDE")
bar:RegisterEvent("UNIT_PET")
bar:RegisterEvent("UNIT_FLAGS")
bar:RegisterEvent("UNIT_AURA")
bar:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		PetActionBarFrame.showgrid = 1
		
		local button
		for i = 1, 10 do
			button = _G["PetActionButton"..i]
			button:ClearAllPoints()
			button:SetParent(PetHolder)
			PetActionBarAnchor:SetParent(PetHolder)
			PetActionBarAnchor:SetFrameStrata("BACKGROUND")
			PetActionBarAnchor:SetFrameLevel(1)
			button:SetSize(SettingsDB.buttonsize, SettingsDB.buttonsize)
			if i == 1 then
				if SettingsCF["actionbar"].petbar_horizontal == true then
					button:SetPoint("BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", 0, 0)
				end
			else
				if SettingsCF["actionbar"].petbar_horizontal == true then
					button:SetPoint("LEFT", _G["PetActionButton"..(i - 1)], "RIGHT", SettingsDB.buttonspacing, 0)
				else
					button:SetPoint("TOP", _G["PetActionButton"..(i - 1)], "BOTTOM", 0, -SettingsDB.buttonspacing)
				end
			end
			button:Show()
			self:SetAttribute("addchild", button)
		end
		RegisterStateDriver(self, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")
		hooksecurefunc("PetActionBar_Update", SettingsDB.PetBarUpdate)
		PetActionButton_OnDragStart = SettingsDB.dummy
	elseif event == "PET_BAR_UPDATE" or event == "UNIT_PET" and arg1 == "player" 
	or event == "PLAYER_CONTROL_LOST" or event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_FARSIGHT_FOCUS_CHANGED" or event == "UNIT_FLAGS" 
	or arg1 == "pet" and (event == "UNIT_AURA") then
		SettingsDB.PetBarUpdate()
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then
		PetActionBar_UpdateCooldowns()
	else
		SettingsDB.StylePet()
	end
end)

-- Hide bar
if SettingsCF.actionbar.petbar_hide then

end

-- Mouseover bar
if SettingsCF.actionbar.rightbars_mouseover == true and SettingsCF.actionbar.petbar_horizontal == false then
	for i = 1, NUM_PET_ACTION_SLOTS do
		local b = _G["PetActionButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() RightBarMouseOver(0) end)
	end
end
if SettingsCF.actionbar.petbar_mouseover == true and SettingsCF.actionbar.petbar_horizontal == true then
	for i = 1, NUM_PET_ACTION_SLOTS do
		local b = _G["PetActionButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() PetMouseOver(1) end)
		b:HookScript("OnLeave", function() PetMouseOver(0) end)
	end
end