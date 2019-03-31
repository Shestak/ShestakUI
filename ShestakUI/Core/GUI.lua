local T, C, L, _ = unpack(select(2, ...))
if not IsAddOnLoaded("ShestakUI_Config") then return end

----------------------------------------------------------------------------------------
--	This Module loads new user settings if ShestakUI_Config is loaded
----------------------------------------------------------------------------------------
-- Сreate the profile boolean
if not ShestakUIOptionsGlobal then ShestakUIOptionsGlobal = {} end
if ShestakUIOptionsGlobal[T.realm] == nil then ShestakUIOptionsGlobal[T.realm] = {} end
if ShestakUIOptionsGlobal[T.realm][T.name] == nil then ShestakUIOptionsGlobal[T.realm][T.name] = false end

-- Сreate the main options table
if ShestakUIOptions == nil then ShestakUIOptions = {} end

-- TODO: Remove Backward compatible for old GUI after while
if GUIConfigSettings then
	ShestakUIOptions = GUIConfigSettings
end

if GUIConfigAll and GUIConfigAll[T.realm][T.name] == true then
	ShestakUIOptionsGlobal[T.realm][T.name] = true
	ShestakUIOptionsPerChar = GUIConfig
end

-- Determine which settings to use
local profile
if ShestakUIOptionsGlobal[T.realm][T.name] == true then
	if ShestakUIOptionsPerChar == nil then
		ShestakUIOptionsPerChar = {}
	end
	profile = ShestakUIOptionsPerChar
else
	profile = ShestakUIOptions
end

-- Apply or remove saved settings as needed
for group, options in pairs(profile) do
	if C[group] then
		for option, value in pairs(options) do
			if C[group][option] == nil or C[group][option] == value then
				-- remove saved vars if they do not exist in lua config anymore, or are the same as the lua config
				profile[group][option] = nil
			else
				C[group][option] = value
			end
		end
	else
		profile[group] = nil
	end
end

-- Add global options variable
C.options = profile