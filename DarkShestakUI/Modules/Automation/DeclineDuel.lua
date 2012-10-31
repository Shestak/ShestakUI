local T, C, L, _ = unpack(select(2, ...))
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
		RaidNotice_AddMessage(RaidWarningFrame, L_INFO_DUEL..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
		print(format("|cffffff00"..L_INFO_DUEL..name.."."))
		StaticPopup_Hide("DUEL_REQUESTED")
	elseif event == "PET_BATTLE_PVP_DUEL_REQUESTED" then
		C_PetBattles.CancelPVPDuel()
		RaidNotice_AddMessage(RaidWarningFrame, L_INFO_PET_DUEL..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
		print(format("|cffffff00"..L_INFO_PET_DUEL..name.."."))
		StaticPopup_Hide("PET_BATTLE_PVP_DUEL_REQUESTED")
	end
end)