local T, C, L, _ = unpack(select(2, ...))
if C.automation.resurrection ~= true then return end

----------------------------------------------------------------------------------------
--	Auto confirm resurrection
----------------------------------------------------------------------------------------
local AutoResurrect = CreateFrame("Frame")
AutoResurrect:RegisterEvent("RESURRECT_REQUEST")
AutoResurrect:SetScript("OnEvent", function(_, event, name)
	if event == "RESURRECT_REQUEST" then
		if not UnitAffectingCombat(name) then
			AcceptResurrect()
			StaticPopup_Hide("RESURRECT_NO_TIMER")

			C_Timer.After(2, function()
				DoEmote("thank", name)
			end)
		end
	end
end)