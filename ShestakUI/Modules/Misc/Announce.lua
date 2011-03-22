local T, C, L = unpack(select(2, ...))
if C.misc.announce_interrupt ~= true then return end

----------------------------------------------------------------------------------------
--	Announce your interrupts(by Elv22) or enemy drinking(by Duffed)
----------------------------------------------------------------------------------------
local interrupt_announce = CreateFrame("Frame")
interrupt_announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
interrupt_announce:SetScript("OnEvent", function(self, _, _, event, _, sourceName, _, _, destName, _, _, _, _, spellID, spellName)
	if not (event == "SPELL_INTERRUPT" and sourceName == T.name) then return end
	
	if GetNumPartyMembers() > 0 then
		SendChatMessage(INTERRUPTED.." "..destName..": \124cff71d5ff\124Hspell:"..spellID.."\124h["..spellName.."]\124h\124r!", "PARTY", nil, nil)
	elseif GetNumRaidMembers() > 0 then
		SendChatMessage(INTERRUPTED.." "..destName..": \124cff71d5ff\124Hspell:"..spellID.."\124h["..spellName.."]\124h\124r!", "RAID", nil, nil)
	end
end)

local drinking_announce = CreateFrame("Frame")
drinking_announce:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
drinking_announce:SetScript("OnEvent", function(self, event, ...)
	if not (event == "UNIT_SPELLCAST_SUCCEEDED" and GetZonePVPInfo() == "arena") then return end
	
	local unit, spellName, spellrank, spelline, spellID = ...
	if UnitIsEnemy("player", unit) and (spellID == 80167 or spellID == 94468 or spellID == 43183 or spellID == 57073 or spellName == "Trinken") then
		if GetNumPartyMembers() > 0 then
			SendChatMessage(UnitName(unit).." is drinking.", "PARTY")
		elseif GetNumRaidMembers() > 0 then
			SendChatMessage(UnitName(unit).." is drinking.", "RAID")
		end
	end
end)