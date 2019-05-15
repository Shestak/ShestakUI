local T, C, L, _ = unpack(select(2, ...))
if C.automation.decline_duel ~= true then return end

----------------------------------------------------------------------------------------
--	Auto decline duel
----------------------------------------------------------------------------------------
local disable = false
local frame = CreateFrame("Frame")
frame:RegisterEvent("DUEL_REQUESTED")
if not T.classic then
	frame:RegisterEvent("PET_BATTLE_PVP_DUEL_REQUESTED")
end
frame:SetScript("OnEvent", function(self, event, name)
	if disable == true then return end
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

SlashCmdList.DISABLEDECLINE = function()
	if not disable then
		disable = true
	else
		disable = false
	end
end

SLASH_DISABLEDECLINE1 = "/disduel"
SLASH_DISABLEDECLINE2 = "/вшывгуд"