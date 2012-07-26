local T, C, L = unpack(ShestakUI)
if C.extra_announce.lightwell ~= true or T.class ~= "PRIEST" then return end

----------------------------------------------------------------------------------------
--	Announce your Lightwell(Light Well Prout by Rahanprout)
----------------------------------------------------------------------------------------
local whisper_baduser = false
local baduse_threshold = 100

local lightwell_announce = CreateFrame("Frame")
lightwell_announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
lightwell_announce:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID = ...

	if sourceName == UnitName("player") then
		if event == "SPELL_AURA_APPLIED" and spellID == 7001 then
			local santemax = UnitHealthMax(destName)
			local santecurrent = UnitHealth(destName)
			local sante = santemax - santecurrent
			local pourcentagesante = math.floor((santecurrent * 100) / santemax)
			if aLw ~= nil then
				aLw[sourceName] = aLw[sourceName] - 1
				if UnitInParty(destName) or UnitInRaid(destName) then
					if sante > baduse_threshold then
						SendChatMessage(destName..L_EXTRA_ANNOUNCE_LA_USE.."("..aLw[sourceName]..L_EXTRA_ANNOUNCE_LA_CHARGE, "SAY")
					else
						SendChatMessage(destName..L_EXTRA_ANNOUNCE_LA_USELESS.."("..aLw[sourceName]..L_EXTRA_ANNOUNCE_LA_CHARGE, "SAY")
						if whisper_baduser then
							SendChatMessage(L_EXTRA_ANNOUNCE_LA_STOP, "WHISPER", nil, destName)
						end
					end
				end
			end
		elseif event == "SPELL_SUMMON" and spellID == 724 then
			chargesLw = isGlyphed()
			aLw = {}
			aLw[sourceName] = 0
			aLw[sourceName] = chargesLw
			SendChatMessage(L_EXTRA_ANNOUNCE_LA_PLACED..chargesLw..L_EXTRA_ANNOUNCE_LA_CHARGES, "SAY")
		end
	end
end)

function isGlyphed()
	for i = 7, NUM_GLYPH_SLOTS do
		local enabled, _, _, glyphSpellID = GetGlyphSocketInfo(i)
		if enabled and glyphSpellID == 55673 then
			return 15
		end
	end
	return 10
end