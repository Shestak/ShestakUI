local T, C, L, _ = unpack(select(2, ...))
if C.automation.summon ~= true then return end

----------------------------------------------------------------------------------------
--	Auto confirm summon
----------------------------------------------------------------------------------------
local disable = false
local AutoSummon = CreateFrame("Frame")
AutoSummon:RegisterEvent("CONFIRM_SUMMON")
AutoSummon:SetScript("OnEvent", function(_, event)
	if event == "CONFIRM_SUMMON" then
		if not UnitAffectingCombat("player") and PlayerCanTeleport() then
			StaticPopup_Show("CANCEL_SUMMON")
			C_Timer.After(10, function()
				if disable then return end
				if not UnitAffectingCombat("player") and PlayerCanTeleport() then
					C_SummonInfo.ConfirmSummon()
					StaticPopup_Hide("CONFIRM_SUMMON")
				end
			end)
		end
	end
end)

StaticPopupDialogs["CANCEL_SUMMON"] = {
	text = LFG_LIST_AUTO_ACCEPT.." ".. string.lower(SUMMONS),
	button1 = CANCEL,
	OnAccept = function()
		disable = true
	end,
	timeout = 12,
}