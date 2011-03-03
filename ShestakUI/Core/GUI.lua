----------------------------------------------------------------------------------------
--	This Module loads new user settings if ShestakUI_Config is loaded
----------------------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...))

local myPlayerRealm = GetCVar("realmName")
local myPlayerName  = UnitName("player")

if not IsAddOnLoaded("ShestakUI_Config") then return end

if not GUIConfigAll then GUIConfigAll = {} end		
if (GUIConfigAll[myPlayerRealm] == nil) then GUIConfigAll[myPlayerRealm] = {} end
if (GUIConfigAll[myPlayerRealm][myPlayerName] == nil) then GUIConfigAll[myPlayerRealm][myPlayerName] = false end

if GUIConfigAll[myPlayerRealm][myPlayerName] == true and not GUIConfig then return end
if GUIConfigAll[myPlayerRealm][myPlayerName] == false and not GUIConfigSettings then return end

if GUIConfigAll[myPlayerRealm][myPlayerName] == true then
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
			for option,value in pairs(options) do
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