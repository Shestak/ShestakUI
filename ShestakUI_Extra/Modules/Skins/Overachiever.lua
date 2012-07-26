local T, C, L = unpack(ShestakUI)
if C.extra_skins.overachiever ~= true then return end

----------------------------------------------------------------------------------------
--	Overachiever skin(Not Ready)
----------------------------------------------------------------------------------------
local SkinOA = CreateFrame("Frame")
SkinOA:RegisterEvent("PLAYER_ENTERING_WORLD")
SkinOA:SetScript("OnEvent", function(self, event)
	
end)