local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
T.dummy = function() return end
T.name = select(1, UnitName("player"))
T.class = select(2, UnitClass("player"))
T.race = select(2, UnitRace("player"))
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
T.version = GetAddOnMetadata("DarkShestakUI", "Version")
T.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
T.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))
T.patch = select(4, GetBuildInfo())
T.MOPVersion = function()
	if T.patch >= 50000 then
		return true
	else
		return false
	end
end

if (T.name == "Занштек" or T.name == "Гранн" or T.name == "Тёми" or T.name == "Палтасар" or T.name == "Ллевалалуз"
or T.name == "Сиамад" or T.name == "Квилинир" or T.name == "Нариэтта" or T.name == "Белонри")
and T.realm == "Ясеневый лес" then 
	T.coauthor = true 
end