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

if SettingsDB.name == "Черешок" 
or SettingsDB.name == "Вершок"
or SettingsDB.name == "Вещмешок" 
or SettingsDB.name == "Гребешок" 
or SettingsDB.name == "Кулешок" 
or SettingsDB.name == "Лапушок" 
or SettingsDB.name == "Обушок" 
or SettingsDB.name == "Ремешок"
or SettingsDB.name == "Шестак"
or SettingsDB.name == "Тестеровщик" then
	SettingsDB.author = true
end