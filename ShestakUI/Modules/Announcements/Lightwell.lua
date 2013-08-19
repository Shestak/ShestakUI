local T, C, L, _ = unpack(select(2, ...))
if C.announcements.lightwell ~= true or T.class ~= "PRIEST" then return end

----------------------------------------------------------------------------------------
--	Announce your Lightwell(Light Well Prout by Rahanprout)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID = ...

	if sourceName == UnitName("player") and IsInGroup() then
		if event == "SPELL_AURA_APPLIED" and spellID == 7001 then
			local santemax = UnitHealthMax(destName)
			local santecurrent = UnitHealth(destName)
			local sante = santemax - santecurrent
			local pourcentagesante = math.floor((santecurrent * 100) / santemax)
			if aLw ~= nil then
				aLw[sourceName] = aLw[sourceName] - 1
				if UnitInParty(destName) or UnitInRaid(destName) then
					if sante > 100 then
						SendChatMessage(destName..L_ANNOUNCE_LA_USE.."("..aLw[sourceName]..L_ANNOUNCE_LA_CHARGE, "SAY")
					else
						SendChatMessage(destName..L_ANNOUNCE_LA_USELESS.."("..aLw[sourceName]..L_ANNOUNCE_LA_CHARGE, "SAY")
					end
				end
			end
		elseif event == "SPELL_SUMMON" and spellID == 724 then
			chargesLw = isGlyphed()
			aLw = {}
			aLw[sourceName] = 0
			aLw[sourceName] = chargesLw
			SendChatMessage(L_ANNOUNCE_LA_PLACED..chargesLw..L_ANNOUNCE_LA_CHARGES, "SAY")
		end
	end
end)

function isGlyphed()
	for i = 7, NUM_GLYPH_SLOTS do
		local enabled, _, _, glyphSpellID = GetGlyphSocketInfo(i)
		if enabled and glyphSpellID == 55673 then
			return 17
		end
	end
	return 15
end