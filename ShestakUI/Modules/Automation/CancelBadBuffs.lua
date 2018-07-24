local T, C, L, _ = unpack(select(2, ...))
if C.automation.cancel_bad_buffs ~= true then return end

----------------------------------------------------------------------------------------
--	Auto cancel various buffs(by Unknown)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(self, event, unit)
	if unit ~= "player" then return end

	if event == "UNIT_AURA" and not InCombatLockdown() then
		for buff, enabled in next, T.BadBuffs do
			local icon = T.CheckPlayerBuff(buff)
			if icon and enabled then
				CancelUnitBuff(unit, icon)
				print("|cffffff00"..ACTION_SPELL_AURA_REMOVED.."|r "..(GetSpellLink(buff) or ("|cffffff00["..buff.."]|r")).."|cffffff00.|r")
			end
		end
	end
end)