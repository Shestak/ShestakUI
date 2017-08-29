local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
T.dummy = function() return end
T.name = UnitName("player")
_, T.class = UnitClass("player")
_, T.race = UnitRace("player")
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
T.version = GetAddOnMetadata("ShestakUI", "Version")
T.resolution = ({GetScreenResolutions()})[GetCurrentResolution()] or GetCVar("gxWindowedResolution")
T.getscreenwidth, T.getscreenheight = DecodeResolution(T.resolution)
T.wowbuild = select(2, GetBuildInfo()); T.wowbuild = tonumber(T.wowbuild)