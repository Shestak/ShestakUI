local T, C, L = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Systems spam filter
----------------------------------------------------------------------------------------
if C.chat.filter == true then
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", function(msg) return true end)
	DUEL_WINNER_KNOCKOUT = ""
	DUEL_WINNER_RETREAT = ""
	DRUNK_MESSAGE_ITEM_OTHER1 = ""
	DRUNK_MESSAGE_ITEM_OTHER2 = ""
	DRUNK_MESSAGE_ITEM_OTHER3 = ""
	DRUNK_MESSAGE_ITEM_OTHER4 = ""
	DRUNK_MESSAGE_OTHER1 = ""
	DRUNK_MESSAGE_OTHER2 = ""
	DRUNK_MESSAGE_OTHER3 = ""
	DRUNK_MESSAGE_OTHER4 = ""
	DRUNK_MESSAGE_ITEM_SELF1 = ""
	DRUNK_MESSAGE_ITEM_SELF2 = ""
	DRUNK_MESSAGE_ITEM_SELF3 = ""
	DRUNK_MESSAGE_ITEM_SELF4 = ""
	DRUNK_MESSAGE_SELF1 = ""
	DRUNK_MESSAGE_SELF2 = ""
	DRUNK_MESSAGE_SELF3 = ""
	DRUNK_MESSAGE_SELF4 = ""
	RAID_MULTI_LEAVE = ""
	RAID_MULTI_JOIN = ""
	ERR_PET_LEARN_ABILITY_S = ""
	ERR_PET_LEARN_SPELL_S = ""
	ERR_PET_SPELL_UNLEARNED_S = ""
	ERR_LEARN_ABILITY_S = ""
	ERR_LEARN_SPELL_S = ""
	ERR_SPELL_UNLEARNED_S = ""
	INTERFACE_ACTION_BLOCKED = ""
	GUILD_REP_WEEKLY_CAPPED = ""
end

----------------------------------------------------------------------------------------
--	Players spam filter(by Evl, Elv22 and Affli)
----------------------------------------------------------------------------------------
if C.chat.spam == true then
	-- Repeat spam filter
	ChatFrame1.repeatFilter = true
	ChatFrame1:SetTimeVisible(10)

	local lastMessage
	local repeatMessageFilter = function(self, event, text, sender, ...)
		if self.repeatFilter then
			if not self.repeatMessages or self.repeatCount > 100 then
				self.repeatCount = 0
				self.repeatMessages = {}
			end
			lastMessage = self.repeatMessages[sender]
			if lastMessage == text then
				return true
			end
			self.repeatMessages[sender] = text
			self.repeatCount = self.repeatCount + 1
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", repeatMessageFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", repeatMessageFilter)

	-- Gold/portals spam filter
	local SpamList = T.ChatSpamList
	local function TRADE_FILTER(self, event, arg1, arg2)
		if SpamList and SpamList[1] then
			for i, SpamList in pairs(SpamList) do
				if arg2 == T.name then return end
				if arg1:lower():match(SpamList) then
					return true
				end
			end
		end
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", TRADE_FILTER)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", TRADE_FILTER)
end