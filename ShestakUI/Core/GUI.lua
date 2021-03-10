local T, C, L, _ = unpack(select(2, ...))

-- Spells lists initialization
C.filger.buff_spells_list = {}
C.filger.proc_spells_list = {}
C.filger.debuff_spells_list = {}
C.filger.aura_bar_spells_list = {}
C.filger.cd_spells_list = {}
C.filger.ignore_spells_list = {}
C.raidframe.plugins_aura_watch_list = {}
C.announcements.spells_list = {}
C.raidcooldown.spells_list = {}
C.enemycooldown.spells_list = {}
C.nameplate.debuffs_list = {}
C.nameplate.buffs_list = {}
C.chat.spam_list = ""
C.font.global_font = false
C.media.profile = "-- Insert Your code here\n"
C.options = {}

if not IsAddOnLoaded("ShestakUI_Config") then return end

----------------------------------------------------------------------------------------
--	This Module loads new user settings if ShestakUI_Config is loaded
----------------------------------------------------------------------------------------
-- Create the profile boolean
if not ShestakUIOptionsGlobal then ShestakUIOptionsGlobal = {} end
if ShestakUIOptionsGlobal[T.realm] == nil then ShestakUIOptionsGlobal[T.realm] = {} end
if ShestakUIOptionsGlobal[T.realm][T.name] == nil then ShestakUIOptionsGlobal[T.realm][T.name] = false end

-- Create the main options table
if ShestakUIOptions == nil then ShestakUIOptions = {} end

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

-- Load edited profile code
loadstring("local T, C, L = unpack(ShestakUI)\n"..C["media"].profile)()