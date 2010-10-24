----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
SettingsCF = { }
SettingsDB = { }
SettingsL = { }
SavedOptions = { }

SettingsDB.dummy = function() return end
SettingsDB.name, _ = UnitName("player")
_, SettingsDB.class = UnitClass("player") 
SettingsDB.client = GetLocale() 
SettingsDB.resolution = GetCurrentResolution()
SettingsDB.getresolution = select(SettingsDB.resolution, GetScreenResolutions())
SettingsDB.version = GetAddOnMetadata("ShestakUI", "Version")
SettingsDB.release = GetAddOnMetadata("ShestakUI", "X-Release")
SettingsDB.combat = UnitAffectingCombat("player")
SettingsDB.patch = GetBuildInfo()
SettingsDB.level = UnitLevel("player")
SettingsDB.color = RAID_CLASS_COLORS[SettingsDB.class]