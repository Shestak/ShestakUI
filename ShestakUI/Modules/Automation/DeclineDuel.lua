local T, C, L = unpack(select(2, ...))
if C.automation.decline_duel ~= true then return end

----------------------------------------------------------------------------------------
--	Auto decline duel
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("DUEL_REQUESTED")
frame:SetScript("OnEvent", function(self, event, name)
	HideUIPanel(StaticPopup1)
	CancelDuel()
	T.InfoTextShow(L_INFO_DUEL..name)
	print(format("|cffffff00"..L_INFO_DUEL..name.."."))
end)