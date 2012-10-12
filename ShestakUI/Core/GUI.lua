local T, C, L, _ = unpack(select(2, ...))
if not IsAddOnLoaded("ShestakUI_Config") then return end

----------------------------------------------------------------------------------------
--	This Module loads new user settings if ShestakUI_Config is loaded
----------------------------------------------------------------------------------------
if not GUIConfigAll then GUIConfigAll = {} end
if GUIConfigAll[T.realm] == nil then GUIConfigAll[T.realm] = {} end
if GUIConfigAll[T.realm][T.name] == nil then GUIConfigAll[T.realm][T.name] = false end

if GUIConfigAll[T.realm][T.name] == true and not GUIConfig then return end
if GUIConfigAll[T.realm][T.name] == false and not GUIConfigSettings then return end

if GUIConfigAll[T.realm][T.name] == true then
	for group, options in pairs(GUIConfig) do
		if C[group] then
			local count = 0
			for option, value in pairs(options) do
				if C[group][option] ~= nil then
					if C[group][option] == value then
						GUIConfig[group][option] = nil
					else
						count = count + 1
						C[group][option] = value
					end
				end
			end
			if count == 0 then GUIConfig[group] = nil end
		else
			GUIConfig[group] = nil
		end
	end
else
	for group, options in pairs(GUIConfigSettings) do
		if C[group] then
			local count = 0
			for option, value in pairs(options) do
				if C[group][option] ~= nil then
					if C[group][option] == value then
						GUIConfigSettings[group][option] = nil
					else
						count = count + 1
						C[group][option] = value
					end
				end
			end
			if count == 0 then GUIConfigSettings[group] = nil end
		else
			GUIConfigSettings[group] = nil
		end
	end
end