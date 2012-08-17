local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Check outdated UI version
----------------------------------------------------------------------------------------
local check = function(self, event, prefix, message, channel, sender)
	if event == "CHAT_MSG_ADDON" then
		if prefix ~= "ShestakUIVersion" or sender == UnitName("player") then return end
		if tonumber(message) > tonumber(GetAddOnMetadata("ShestakUI", "Version")) then
			print("|cffad2424"..L_MISC_UI_OUTDATED.."|r")
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		if UnitInParty("player") then
			SendAddonMessage("ShestakUIVersion", tonumber(GetAddOnMetadata("ShestakUI", "Version")), "PARTY") 
		elseif UnitInRaid("player") then
			SendAddonMessage("ShestakUIVersion", tonumber(GetAddOnMetadata("ShestakUI", "Version")), "RAID")
		elseif IsInGuild() then
			SendAddonMessage("ShestakUIVersion", tonumber(GetAddOnMetadata("ShestakUI", "Version")), "GUILD")
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", check)
RegisterAddonMessagePrefix("ShestakUIVersion")