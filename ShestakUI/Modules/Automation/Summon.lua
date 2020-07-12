local T, C, L, _ = unpack(select(2, ...))
if C.automation.summon ~= true then return end

----------------------------------------------------------------------------------------
--	Auto confirm summon
----------------------------------------------------------------------------------------
local AutoSummon = CreateFrame("Frame")
AutoSummon:RegisterEvent("CONFIRM_SUMMON")
AutoSummon:SetScript("OnEvent", function(_, event)
	if event == "CONFIRM_SUMMON" then
		if not UnitAffectingCombat("player") and PlayerCanTeleport() then
			C_Timer.After(10, function()
				C_SummonInfo.ConfirmSummon()
				StaticPopup_Hide("CONFIRM_SUMMON")
			end)
		end
	end
end)