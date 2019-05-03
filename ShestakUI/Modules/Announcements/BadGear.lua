local T, C, L, _ = unpack(select(2, ...))
if C.announcements.bad_gear ~= true then return end

----------------------------------------------------------------------------------------
--	Check bad gear in instance
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function(self, event)
	if event ~= "ZONE_CHANGED_NEW_AREA" or not IsInInstance() then return end
	local item = {}
	for i = 1, 17 do
		if T.AnnounceBadGear[i] ~= nil then
			item[i] = GetInventoryItemID("player", i) or 0
			for _, baditem in pairs(T.AnnounceBadGear[i]) do
				if item[i] == baditem then
					PlaySound(SOUNDKIT.RAID_WARNING, "Master")
					RaidNotice_AddMessage(RaidWarningFrame, format("%s %s", CURRENTLY_EQUIPPED, select(2, GetItemInfo(item[i])).."!!!"), ChatTypeInfo["RAID_WARNING"])
					print(format("|cffff3300%s %s", CURRENTLY_EQUIPPED, select(2, GetItemInfo(item[i])).."|cffff3300!!!|r"))
				end
			end
		end
	end
end)