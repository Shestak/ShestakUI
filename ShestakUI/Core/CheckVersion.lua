local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Check outdated UI version
----------------------------------------------------------------------------------------
local check = function(self, event, prefix, message, channel, sender)
	if event == "CHAT_MSG_ADDON" then
		if prefix ~= "ShestakUIVersion" or sender == T.name then return end
		if tonumber(message) == nil then return end
		if tonumber(message) > tonumber(T.version) then
			print("|cffff0000"..L_MISC_UI_OUTDATED.."|r")
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		if UnitInBattleground("player") and UnitInBattleground("player") > 0 then
			SendAddonMessage("ShestakUIVersion", tonumber(T.version), "BATTLEGROUND")
		elseif UnitInRaid("player") and GetNumGroupMembers() > 5 then
			SendAddonMessage("ShestakUIVersion", tonumber(T.version), "RAID")
		elseif UnitInParty("player") then
			SendAddonMessage("ShestakUIVersion", tonumber(T.version), "PARTY")
		elseif IsInGuild() then
			SendAddonMessage("ShestakUIVersion", tonumber(T.version), "GUILD")
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", check)
RegisterAddonMessagePrefix("ShestakUIVersion")