local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Copy url from chat(module from Gibberish by p3lim)
----------------------------------------------------------------------------------------
local patterns = {
	"(https://%S+)",
	"(http://%S+)",
	"(www%.%S+)",
	"(%d+%.%d+%.%d+%.%d+:?%d*)"
}

for _, event in pairs({
	"CHAT_MSG_GUILD",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_BN_WHISPER",
	"CHAT_MSG_SAY",
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_BATTLEGROUND_LEADER",
	"CHAT_MSG_BN_CONVERSATION",
	"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_YELL"
}) do
	ChatFrame_AddMessageEventFilter(event, function(self, event, str, ...)
		for _, pattern in pairs(patterns) do
			local result, match = string.gsub(str, pattern, "|cff00FF00|Hurl:%1|h[%1]|h|r")
			if match > 0 then
				return false, result, ...
			end
		end
	end)
end

local SetHyperlink = _G.ItemRefTooltip.SetHyperlink
function _G.ItemRefTooltip:SetHyperlink(link, ...)
	if link and (strsub(link, 1, 3) == "url") then
		local url = strsub(link, 5)
		
		local editbox = ChatEdit_ChooseBoxForSend()
		ChatEdit_ActivateChat(editbox)
		editbox:Insert(string.sub(link, 5))
		editbox:HighlightText()
		
		return
     end
	 
	 SetHyperlink(self, link, ...)
end
