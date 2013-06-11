local T, C, L, _ = unpack(select(2, ...))
if C.automation.safari_hat ~= true then return end

----------------------------------------------------------------------------------------
--	Auto equip Safari Hat
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame"), hat, show
frame:RegisterEvent("PET_BATTLE_OPENING_DONE")
frame:RegisterEvent("PET_BATTLE_CLOSE")
frame:SetScript("OnEvent", function(self, event)
	if event == "PET_BATTLE_OPENING_DONE" then
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
	elseif event == "PET_BATTLE_CLOSE" then
		if hat then
			EquipItemByName(hat)
			ShowHelm(show)
			hat = nil
		end
	end
end)