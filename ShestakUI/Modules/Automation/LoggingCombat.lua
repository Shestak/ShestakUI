local T, C, L, _ = unpack(select(2, ...))
if C.automation.logging_combat ~= true then return end

----------------------------------------------------------------------------------------
--	Auto enables combat log text file in raid instances(EasyLogger by Sildor)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function()
	local _, instanceType = IsInInstance()
	if instanceType == "raid" then
		if not LoggingCombat() then
			LoggingCombat(1)
			print("|cffffff00"..COMBATLOGENABLED.."|r")
		end
	else
		if LoggingCombat() then
			LoggingCombat(0)
			print("|cffffff00"..COMBATLOGDISABLED.."|r")
		end
	end
end)