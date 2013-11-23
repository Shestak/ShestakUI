local T, C, L, _ = unpack(select(2, ...))
if C.automation.safari_hat ~= true then return end

----------------------------------------------------------------------------------------
--	Auto equip Safari Hat
----------------------------------------------------------------------------------------
local tamerlist = {63194, 64330, 66741, 66136, 66635, 65656, 66557, 66815, 66819, 68463, 66422, 66738, 66135, 66478, 66512, 66520, 66412, 65655, 66518, 66734, 68462, 66822, 66436, 66639, 66730, 67370, 66452, 66515, 65651, 66522, 66675, 66372, 66733, 66553, 66552, 66636, 66550, 66824, 66638, 65648, 66551, 66918, 66466, 68465, 66352, 66739, 68464, 66442, 66137, 66126, 71924, 71926, 71927, 71929, 71930, 71931, 71932, 71933, 71934}
local frame = CreateFrame("Frame"), hat, show
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PET_BATTLE_CLOSE")
frame:RegisterEvent("GOSSIP_CONFIRM")
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
	elseif event == "GOSSIP_CONFIRM" then
		if UnitExists("target") and not InCombatLockdown() then
			for i = 1, #tamerlist do
				if tonumber(UnitGUID("target"):sub(6, 10), 16) == tamerlist[i] then
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
			end
		end
	elseif event == "PET_BATTLE_CLOSE" or (event == "PLAYER_TARGET_CHANGED" and not C_PetBattles.IsInBattle()) then
		if hat and not InCombatLockdown() then
			EquipItemByName(hat)
			ShowHelm(show)
			hat = nil
		end
	end
end)