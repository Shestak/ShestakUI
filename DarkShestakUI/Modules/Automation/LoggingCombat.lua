local T, C, L, _ = unpack(select(2, ...))
if C.automation.logging_combat ~= true then return end

----------------------------------------------------------------------------------------
--	Auto enables combat log text file in raid instances(EasyLogger by Sildor)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function()
	local inInstance, instanceType = IsInInstance()
	if inInstance and instanceType == "raid" and not LoggingCombat() then
		LoggingCombat(1)
	else
		LoggingCombat(0)
	end
end)