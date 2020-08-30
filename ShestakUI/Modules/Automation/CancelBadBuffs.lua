local T, C, L, _ = unpack(select(2, ...))
if C.automation.cancel_bad_buffs ~= true then return end

----------------------------------------------------------------------------------------
--	Auto cancel various buffs(by Unknown)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(_, event, unit)
	if event == "UNIT_AURA" and unit == "player" and not InCombatLockdown() then
		local i = 1
		while true do
			local name = UnitBuff(unit, i)
			if not name then return end
			if T.BadBuffs[name] then
				CancelSpellByName(name)
				print("|cffffff00"..ACTION_SPELL_AURA_REMOVED.." ["..name.."].|r")
			end
			i = i + 1
		end
	end
end)