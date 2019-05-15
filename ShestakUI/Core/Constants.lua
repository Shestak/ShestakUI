local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
-- Temporary Function
IsClassicBuild = _G.IsClassicBuild or function()
	local major, minor, fix = strsplit(".", tostring(GetBuildInfo()))
	major, minor, fix = tonumber(major) or 0, tonumber(minor) or 0, tonumber(fix) or 0

	local patch = major + (minor / 100)
	if patch < 2 then
		return true
	end
end

T.classic = IsClassicBuild()

T.dummy = function() return end
T.name = UnitName("player")
T.class = select(2, UnitClass("player"))
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
T.version = GetAddOnMetadata("ShestakUI", "Version")
T.screenWidth, T.screenHeight = GetPhysicalScreenSize()
T.wowBuild = select(2, GetBuildInfo()); T.wowBuild = tonumber(T.wowBuild)