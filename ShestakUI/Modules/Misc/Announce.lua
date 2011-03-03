local T, C, L = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	Announce your interrupts(by Elv22)
----------------------------------------------------------------------------------------
if C.misc.announce_interrupt ~= true then return end

local announce = CreateFrame("Frame")
announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
announce:SetScript("OnEvent", function(self, _, _, event, _, sourceName, _, _, destName, _, _, _, _, spellID, spellName)
	if not (event == "SPELL_INTERRUPT" and sourceName == T.name) then return end
	
	if GetNumPartyMembers() > 0 then
		SendChatMessage(INTERRUPTED.." "..destName.."'s \124cff71d5ff\124Hspell:"..spellID.."\124h["..spellName.."]\124h\124r!", "PARTY", nil, nil)
	elseif GetNumRaidMembers() > 0 then
		SendChatMessage(INTERRUPTED.." "..destName.."'s \124cff71d5ff\124Hspell:"..spellID.."\124h["..spellName.."]\124h\124r!", "RAID", nil, nil)
	end
end)