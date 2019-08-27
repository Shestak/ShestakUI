local T, C, L, _ = unpack(select(2, ...))
if C.loot.faster_loot ~= true then return end

----------------------------------------------------------------------------------------
--	Faster auto looting
----------------------------------------------------------------------------------------
local tDelay = 0
local LOOT_DELAY = 0.3

local frame = CreateFrame("Frame")
frame:RegisterEvent("LOOT_READY")
frame:SetScript("OnEvent", function ()
	if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
		if (GetTime() - tDelay) >= LOOT_DELAY then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
			tDelay = GetTime()
		end
	end
end)