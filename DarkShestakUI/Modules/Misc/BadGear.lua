local T, C, L, _ = unpack(select(2, ...))
if C.misc.bad_gear ~= true then return end

----------------------------------------------------------------------------------------
--	Bad Gear Check(by Shestak)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function(self, event)
    if event == "ZONE_CHANGED_NEW_AREA" then
        if not IsInInstance() then return end

        local head = GetItemInfo(GetInventoryItemLink("player", 1) or 0)
        local feet = GetItemInfo(GetInventoryItemLink("player", 8) or 0)
        local back = GetItemInfo(GetInventoryItemLink("player", 15) or 0)
        local hand = GetItemInfo(GetInventoryItemLink("player", 16) or 0)
        local hand2 = GetItemInfo(GetInventoryItemLink("player", 17) or 0)

        if head == GetItemInfo(88710) or head == GetItemInfo(33820) or head == GetItemInfo(19972) then
            RaidNotice_AddMessage(RaidWarningFrame, "Fishing Hat equipped!!!", ChatTypeInfo["RAID_WARNING"])
        elseif head == GetItemInfo(46349) then
            RaidNotice_AddMessage(RaidWarningFrame, "Chef's Hat equipped!!!", ChatTypeInfo["RAID_WARNING"])
        end

        if feet == GetItemInfo(50287) or feet == GetItemInfo(19969) then
            RaidNotice_AddMessage(RaidWarningFrame, "Fishing Boots equipped!!!", ChatTypeInfo["RAID_WARNING"])
        end

        if back == GetItemInfo(65360) or back == GetItemInfo(65274) then
            RaidNotice_AddMessage(RaidWarningFrame, "Cloak of Coordination equipped!!!", ChatTypeInfo["RAID_WARNING"])
        end

        if hand == GetItemInfo(44050) or hand == GetItemInfo(19970) or hand == GetItemInfo(84661) or hand == GetItemInfo(45992) then
            RaidNotice_AddMessage(RaidWarningFrame, "Pole equipped!!!", ChatTypeInfo["RAID_WARNING"])
        elseif hand == GetItemInfo(86559) then
            RaidNotice_AddMessage(RaidWarningFrame, "Frying Pan equipped!!!", ChatTypeInfo["RAID_WARNING"])
        end

        if hand2 == GetItemInfo(86558) then
            RaidNotice_AddMessage(RaidWarningFrame, "Rolling Pin equipped!!!", ChatTypeInfo["RAID_WARNING"])
        end
    end
end)