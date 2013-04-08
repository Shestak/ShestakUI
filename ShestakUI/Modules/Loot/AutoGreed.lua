local T, C, L, _ = unpack(select(2, ...))
if C.loot.auto_greed ~= true then return end

----------------------------------------------------------------------------------------
--	Auto greed/disenchant on green items(by Tekkub) and NeedTheOrb(by Myrilandell of Lothar)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("START_LOOT_ROLL")
frame:SetScript("OnEvent", function(self, event, id)
	local name = select(2, GetLootRollItemInfo(id))
	if T.level ~= MAX_PLAYER_LEVEL then return end
	if id and select(4, GetLootRollItemInfo(id)) == 2 and not select(5, GetLootRollItemInfo(id)) then
		for i in pairs(T.NeedLoot) do
			if name == select(1, GetItemInfo(T.NeedLoot[i])) and RollOnLoot(id, 1) then
				RollOnLoot(id, 1)
				return
			end
		end
		if RollOnLoot(id, 3) then
			RollOnLoot(id, 3)
		else
			RollOnLoot(id, 2)
		end
	end
end)