local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
T.dummy = function() return end
T.name = UnitName("player")
T.class = select(2, UnitClass("player"))
T.race = select(2, UnitRace("player"))
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
T.version = GetAddOnMetadata("ShestakUI", "Version")
T.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
T.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))

if T.name == "Вершок" or T.name == "Вещмешок" or T.name == "Гребешок" or T.name == "Кулешок" or T.name == "Лапушок"
or T.name == "Обушок" or T.name == "Ремешок" or T.name == "Торгашок" or T.name == "Черешок" or T.name == "Женишок"
or T.name == "Шестак" or T.name == "Дефляция" then
	T.author = true
end