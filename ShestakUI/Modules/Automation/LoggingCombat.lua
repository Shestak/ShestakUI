local T, C, L = unpack(select(2, ...))
if C.automation.logging_combat ~= true then return end

----------------------------------------------------------------------------------------
--	Auto enables combat log text file in raid instances(EasyLogger by Sildor)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function ()
	local _, instanceType = IsInInstance()
	if instanceType == "raid" then
		if not LoggingCombat() then
			LoggingCombat(1)
		end
	else
		if LoggingCombat() then
			LoggingCombat(0)
		end
	end
end)