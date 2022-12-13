local T, C, L, _ = unpack(select(2, ...))
if C.announcements.bad_gear ~= true then return end

----------------------------------------------------------------------------------------
--	Check bad gear in instance
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function(_, event)
	if event ~= "ZONE_CHANGED_NEW_AREA" or not IsInInstance() then return end
	for i = 1, 17 do
		if T.AnnounceBadGear[i] then
			local id = GetInventoryItemID("player", i) or 0
			if T.AnnounceBadGear[i][id] then
				local _, itemLink = GetItemInfo(id)
				PlaySound(SOUNDKIT.RAID_WARNING, "Master")
				RaidNotice_AddMessage(RaidWarningFrame, format("%s %s", CURRENTLY_EQUIPPED, itemLink.."!"), ChatTypeInfo["RAID_WARNING"])
				print(format("|cffff3300%s %s", CURRENTLY_EQUIPPED, itemLink.."|cffff3300!|r"))
			end
		end
	end
end)