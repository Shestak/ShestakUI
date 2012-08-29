local T, C, L = unpack(ShestakUI)
if C.extra_skins.overachiever ~= true then return end

----------------------------------------------------------------------------------------
--	Overachiever skin(Not Ready)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)

end)