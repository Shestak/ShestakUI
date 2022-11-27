local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
T.dummy = function() return end
T.name = UnitName("player")
T.class = select(2, UnitClass("player"))
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
T.version = GetAddOnMetadata("ShestakUI", "Version")
T.screenWidth, T.screenHeight = GetPhysicalScreenSize()
T.newPatch = select(4, GetBuildInfo()) >= 100002

-- BETA
if T.newPatch then
	GetContainerNumSlots = _G.GetContainerNumSlots or C_Container.GetContainerNumSlots
	GetContainerNumFreeSlots = _G.GetContainerNumFreeSlots or C_Container.GetContainerNumFreeSlots
	GetContainerItemLink = _G.GetContainerItemLink or C_Container.GetContainerItemLink
	GetContainerItemCooldown = _G.GetContainerItemCooldown or C_Container.GetContainerItemCooldown
	UseContainerItem = _G.UseContainerItem or C_Container.UseContainerItem
	GetContainerItemID = _G.GetContainerItemID or C_Container.GetContainerItemID

	GetContainerItemInfo = function(bagIndex, slotIndex)
		local info = C_Container.GetContainerItemInfo(bagIndex, slotIndex)
		if info then
			return info.iconFileID, info.stackCount, info.isLocked, info.quality, info.isReadable, info.hasLoot, info.hyperlink, info.isFiltered, info.hasNoValue, info.itemID, info.isBound
		end
	end
end