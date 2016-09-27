local T, C, L, _ = unpack(select(2, ...))
if C.skins.arh ~= true then return end

----------------------------------------------------------------------------------------
--	Archaeology Helper skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("Arh") then return end
	Arh_MainFrame:StripTextures()
	Arh_MainFrame:SetTemplate("Transparent")
	Arh_MainFrame:SetScale(1)

	Arh_Tooltip:StripTextures()
	Arh_Tooltip:SetTemplate("Transparent")
	Arh_Tooltip:SetScale(1)
end)
