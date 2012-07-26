local T, C, L = unpack(ShestakUI)
if C.extra_announce.toy_train ~= true then return end

----------------------------------------------------------------------------------------
--	Announce Toy Train Set
----------------------------------------------------------------------------------------
local train_announce = CreateFrame("Frame")
train_announce:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
train_announce:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, _, sourceName = ...
	local inInstance, instanceType = IsInInstance()
	if not (inInstance and (instanceType == "raid" or instanceType == "party")) then return end

	if event == "SPELL_CREATE" then
		local spellId = select(12, ...)
		if spellId == 61031 then
			SendChatMessage(VOICEMACRO_1_Tr_1.." "..sourceName.." "..ACTION_SPELL_CREATE.." "..GetSpellLink(61031)..".", "SAY")
		end
	end
end)