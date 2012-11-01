local T, C, L, _ = unpack(select(2, ...))
if C.announcements.bad_gear ~= true then return end

----------------------------------------------------------------------------------------
--	Check bad gear in instance
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function(self, event)
	if event == "ZONE_CHANGED_NEW_AREA" then
		if not IsInInstance() then return end
		local baditem = {
			[1] = {
				88710,	-- Nat's Hat
				33820,	-- Weather-Beaten Fishing Hat
				19972,	-- Lucky Fishing Hat
				46349,	-- Chef's Hat
			},
			[8] = {
				50287,	-- Boots of the Bay
				19969,	-- Nat Pagle's Extreme Anglin' Boots
			},
			[15] = {
				65360,	-- Cloak of Coordination
				65274,	-- Cloak of Coordination
			},
			[16] = {
				44050,	-- Mastercraft Kalu'ak Fishing Pole
				19970,	-- Arcanite Fishing Pole
				84660,	-- Pandaren Fishing Pole
				84661,	-- Dragon Fishing Pole
				45992,	-- Jeweled Fishing Pole
				86559,	-- Frying Pan
			},
			[17] = {
				86558,	-- Rolling Pin
			},
		}

		local item = {}

		for i = 1, 17 do
			if baditem[i] ~= nil then
				item[i] = GetItemInfo(GetInventoryItemLink("player", i) or 0)
				for j, baditemid in pairs(baditem[i]) do
					if item[i] == GetItemInfo(baditemid) then
						PlaySound("RaidWarning", "master")
						RaidNotice_AddMessage(RaidWarningFrame, string.format("%s %s", CURRENTLY_EQUIPPED, item[i].."!!!"), ChatTypeInfo["RAID_WARNING"])
						print(string.format("|cffffff00%s %s", CURRENTLY_EQUIPPED, item[i].."!!!|r"))
					end
				end
			end
		end
	end
end)