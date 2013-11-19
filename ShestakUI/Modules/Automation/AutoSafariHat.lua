local T, C, L, _ = unpack(select(2, ...))
if C.automation.safari_hat ~= true then return end

----------------------------------------------------------------------------------------
--	Auto equip Safari Hat
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame"), hat, show
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PET_BATTLE_CLOSE")
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_TARGET_CHANGED" and not hat then
		if UnitIsWildBattlePet("target") and not InCombatLockdown() then
			if ShowingHelm() then
				show = true
			else
				show = false
			end
			if GetItemCount(92738) > 0 then
				hat = GetInventoryItemLink("player", 1)
				EquipItemByName(92738)
				ShowHelm(true)
			end
		end
	elseif event == "PET_BATTLE_CLOSE" or (event == "PLAYER_TARGET_CHANGED" and not C_PetBattles.IsInBattle()) then
		if hat then
			EquipItemByName(hat)
			ShowHelm(show)
			hat = nil
		end
	end
end)