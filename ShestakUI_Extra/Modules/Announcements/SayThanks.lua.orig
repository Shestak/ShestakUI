local T, C, L = unpack(ShestakUI)
if C.extra_announce.says_thanks ~= true then return end

----------------------------------------------------------------------------------------
--	Says thanks for some spells(SaySapped by Bitbyte, modified by m2jest1c)
----------------------------------------------------------------------------------------
local SayThanks = CreateFrame("Frame")

local ST_Buffs = {
	[1] = 85767,	-- Dark Intent
	[2] = 54646,	-- Focus Magic
	[3] = 29166,	-- Innervate
	--[4] = 10060,	-- Power Infusion
}

SayThanks:SetScript("OnEvent", function(...)
	local args = {...}
	for i, v in ipairs(ST_Buffs) do
		if args[14] == v and args[11] == T.name and args[7] ~= T.name and (args[4] == "SPELL_AURA_APPLIED" or args[4] == "SPELL_AURA_REFRESH") then
			SendChatMessage(L_EXTRA_ANNOUNCE_SS_THANKS..GetSpellLink(args[14])..", "..args[7], "WHISPER", nil, args[7])
			DEFAULT_CHAT_FRAME:AddMessage(GetSpellLink(args[14])..L_EXTRA_ANNOUNCE_SS_RECEIVED..(args[7] or UNKNOWN))
		end
	end
end)
SayThanks:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")