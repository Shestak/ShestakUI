local T, C, L = unpack(ShestakUI)
if C.extra_chat.nick_alert_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Nick alert warning sound
----------------------------------------------------------------------------------------
local chatFind = CreateFrame("Frame")
chatFind:RegisterEvent("CHAT_MSG_GUILD")
chatFind:RegisterEvent("CHAT_MSG_BATTLEGROUND")
chatFind:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER")
chatFind:RegisterEvent("CHAT_MSG_OFFICER")
chatFind:RegisterEvent("CHAT_MSG_PARTY")
chatFind:RegisterEvent("CHAT_MSG_PARTY_LEADER")
chatFind:RegisterEvent("CHAT_MSG_RAID")
chatFind:RegisterEvent("CHAT_MSG_RAID_LEADER")
--chatFind:RegisterEvent("CHAT_MSG_SAY")
--chatFind:RegisterEvent("CHAT_MSG_CHANNEL")

chatFind:SetScript("OnEvent", function(event, msg, sender)
	sender = strlower(sender)

	for _, v in pairs(C.extra_chat.nick_alert_names) do
		if strfind(sender, strlower(v)) then
			PlaySoundFile(C.extra_chat.nick_alert_sound, "MASTER")
			return
		end
	end
end)