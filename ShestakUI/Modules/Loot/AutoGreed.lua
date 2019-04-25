local T, C, L, _ = unpack(select(2, ...))
if C.loot.auto_greed ~= true or T.level ~= MAX_PLAYER_LEVEL then return end

----------------------------------------------------------------------------------------
--	Auto greed/disenchant on green items(by Tekkub) and NeedTheOrb(by Myrilandell of Lothar)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("START_LOOT_ROLL")
frame:SetScript("OnEvent", function(_, _, id)
	local _, name, _, quality, BoP, canNeed, _, canDisenchant = GetLootRollItemInfo(id)
	if id and quality == 2 and not BoP then
		for i in pairs(T.NeedLoot) do
			local itemName = GetItemInfo(T.NeedLoot[i])
			if name == itemName and canNeed then
				RollOnLoot(id, 1)
				return
			end
		end
		local link = GetLootRollItemLink(id)
		local _, _, _, ilevel = GetItemInfo(link)
		if canDisenchant and ilevel > 482 then
			RollOnLoot(id, 3)
		else
			RollOnLoot(id, 2)
		end
	end
end)