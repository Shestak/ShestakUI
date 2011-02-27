----------------------------------------------------------------------------------------
--	Announce your interrupts(by Elv22)
----------------------------------------------------------------------------------------
if SettingsCF.misc.announce_interrupt ~= true then return end

local announce = CreateFrame("Frame")
announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
announce:SetScript("OnEvent", function(self, _, _, event, _, sourceName, _, _, destName, _, _, _, _, spellID, spellName)
	if not (event == "SPELL_INTERRUPT" and sourceName == SettingsDB.name) then return end
	
	if GetNumPartyMembers() > 0 then
		SendChatMessage(INTERRUPTED.." "..destName.."'s \124cff71d5ff\124Hspell:"..spellID.."\124h["..spellName.."]\124h\124r!", "PARTY", nil, nil)
	elseif GetNumRaidMembers() > 0 then
		SendChatMessage(INTERRUPTED.." "..destName.."'s \124cff71d5ff\124Hspell:"..spellID.."\124h["..spellName.."]\124h\124r!", "RAID", nil, nil)
	end
end)