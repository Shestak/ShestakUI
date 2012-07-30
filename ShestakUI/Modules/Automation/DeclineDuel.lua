local T, C, L = unpack(select(2, ...))
if C.automation.decline_duel ~= true then return end

----------------------------------------------------------------------------------------
--	Auto decline duel
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("DUEL_REQUESTED")
frame:RegisterEvent("PET_BATTLE_PVP_DUEL_REQUESTED")
frame:SetScript("OnEvent", function(self, event, name)
	if event == "DUEL_REQUESTED" then
		CancelDuel()
		T.InfoTextShow(L_INFO_DUEL..name)
		print(format("|cffffff00"..L_INFO_DUEL..name.."."))
	elseif event == "PET_BATTLE_PVP_DUEL_REQUESTED" then
		C_PetBattles.CancelPVPDuel()
		T.InfoTextShow(L_INFO_PET_DUEL..name)
		print(format("|cffffff00"..L_INFO_PET_DUEL..name.."."))
	end
	HideUIPanel(StaticPopup1)
end)