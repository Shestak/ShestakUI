local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
T.dummy = function() return end
T.name = select(1, UnitName("player"))
T.class = select(2, UnitClass("player"))
T.client = GetLocale() 
T.resolution = GetCurrentResolution()
T.getscreenresolution = select(T.resolution, GetScreenResolutions())
T.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
T.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))
T.version = GetAddOnMetadata("ShestakUI", "Version")
T.release = GetAddOnMetadata("ShestakUI", "X-Release")
T.versionnumber = tonumber(T.version)
T.combat = UnitAffectingCombat("player")
T.patch = select(4, GetBuildInfo())
T.realm = GetRealmName()
T.level = UnitLevel("player")
T.color = RAID_CLASS_COLORS[T.class]
T.PTRVersion = function()
	if T.patch >= 40200 then
		return true
	else
		return false
	end
end

if T.name == "Черешок" 
or T.name == "Вершок"
or T.name == "Вещмешок" 
or T.name == "Гребешок" 
or T.name == "Кулешок" 
or T.name == "Лапушок" 
or T.name == "Обушок" 
or T.name == "Ремешок"
or T.name == "Шестак"
or T.name == "Торгашок"
or T.name == "Дефляция"
or T.name == "Аазмантус" then
	T.author = true
end