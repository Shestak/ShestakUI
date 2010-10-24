----------------------------------------------------------------------------------------
--	This Module loads new user settings if ShestakUI_Config is loaded
----------------------------------------------------------------------------------------
if not IsAddOnLoaded("ShestakUI_Config") or GUIConfig == nil then return end

for group, options in pairs(GUIConfig) do
	if SettingsCF[group] then
		local count = 0
		for option, value in pairs(options) do
			if SettingsCF[group][option] ~= nil then
				if SettingsCF[group][option] == value then
					GUIConfig[group][option] = nil	
				else
					count = count + 1
					SettingsCF[group][option] = value
				end
			end
		end
		if count == 0 then GUIConfig[group] = nil end
	else
		GUIConfig[group] = nil
	end
end