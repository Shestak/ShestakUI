local T, C, L, _ = unpack(select(2, ...))
if C.announcements.says_thanks ~= true then return end

----------------------------------------------------------------------------------------
--	Says thanks for some spells(SaySapped by Bitbyte, modified by m2jest1c)
----------------------------------------------------------------------------------------
local ST_Buffs = {
	[29166] = true,		-- Innervate
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(_, event, _, applied, _, _, buffer, _, _, _, player, _, _, spell, ...)
	for key, value in pairs(ST_Buffs) do
		if spell == key and value == true and player == T.name and buffer ~= T.name and applied == "SPELL_AURA_APPLIED" then
			SendChatMessage(L_ANNOUNCE_SS_THANKS..GetSpellLink(spell)..", "..buffer, "WHISPER", nil, buffer)
			DEFAULT_CHAT_FRAME:AddMessage(GetSpellLink(spell)..L_ANNOUNCE_SS_RECEIVED..buffer)
		end
	end
end)