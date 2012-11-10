local T, C, L, _ = unpack(select(2, ...))
if C.announcements.says_thanks ~= true then return end

----------------------------------------------------------------------------------------
--	Says thanks for some spells(SaySapped by Bitbyte, modified by m2jest1c)
----------------------------------------------------------------------------------------
local spells = {
	[29166] = true,		-- Innervate
	[20484] = true,		-- Rebirth
	[61999] = true,		-- Raise Ally
	[20707] = true,		-- Soulstone
	[50769] = true,		-- Revive
	[2006] = true,		-- Resurrection
	[7328] = true,		-- Redemption
	[2008] = true,		-- Ancestral Spirit
	[115178] = true,	-- Resuscitate
	[110478] = true,	-- Symbiosis for Death Knight
	[110479] = true,	-- Symbiosis for Hunter
	[110482] = true,	-- Symbiosis for Mage
	[110483] = true,	-- Symbiosis for Monk
	[110484] = true,	-- Symbiosis for Paladin
	[110485] = true,	-- Symbiosis for Priest
	[110486] = true,	-- Symbiosis for Rogue
	[110488] = true,	-- Symbiosis for Shaman
	[110490] = true,	-- Symbiosis for Warlock
	[110491] = true,	-- Symbiosis for Warrior
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(_, event, _, applied, _, _, buffer, _, _, _, player, _, _, spell, ...)
	for key, value in pairs(spells) do
		if spell == key and value == true and player == T.name and buffer ~= T.name and applied == "SPELL_AURA_APPLIED" then
			SendChatMessage(L_ANNOUNCE_SS_THANKS..GetSpellLink(spell)..", "..buffer, "WHISPER", nil, buffer)
			DEFAULT_CHAT_FRAME:AddMessage(GetSpellLink(spell)..L_ANNOUNCE_SS_RECEIVED..buffer)
		end
	end
end)