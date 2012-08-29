local T, C, L = unpack(ShestakUI)
if C.extra_announce.nick_alert_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Nick alert warning sound
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_GUILD")
frame:RegisterEvent("CHAT_MSG_BATTLEGROUND")
frame:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER")
frame:RegisterEvent("CHAT_MSG_OFFICER")
frame:RegisterEvent("CHAT_MSG_PARTY")
frame:RegisterEvent("CHAT_MSG_PARTY_LEADER")
frame:RegisterEvent("CHAT_MSG_RAID")
frame:RegisterEvent("CHAT_MSG_RAID_LEADER")

frame:SetScript("OnEvent", function(event, msg, sender)
	sender = strlower(sender)

	for _, v in pairs(C.extra_announce.nick_alert_names) do
		if strfind(sender, strlower(v)) then
			PlaySoundFile("Sound\\Event Sounds\\Wisp\\WispPissed1.wav", "MASTER")
			return
		end
	end
end)