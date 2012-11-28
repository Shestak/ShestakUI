local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Binding keys for chat channels
----------------------------------------------------------------------------------------
BINDING_HEADER_CHATKEY = CHAT_CHANNELS
BINDING_NAME_GUILD_MESSAGE = GUILD
BINDING_NAME_PARTY_MESSAGE = PARTY
BINDING_NAME_RAID_MESSAGE = RAID
BINDING_NAME_RW_MESSAGE = RAID_WARNING
BINDING_NAME_IC_MESSAGE = INSTANCE_CHAT
BINDING_NAME_SAY_MESSAGE = SAY
BINDING_NAME_TARGET_MESSAGE = TARGET

function ChatKey_Chat(arg)
	ChatFrame_OpenChat(arg)
end