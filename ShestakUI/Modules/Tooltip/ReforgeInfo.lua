local T, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.reforge ~= true then return end

----------------------------------------------------------------------------------------
--	Item reforge info(bTooltip by Fernir)
----------------------------------------------------------------------------------------
local StatNames = {
	ITEM_MOD_SPIRIT_SHORT, ITEM_MOD_DODGE_RATING_SHORT, ITEM_MOD_PARRY_RATING_SHORT, ITEM_MOD_HIT_RATING_SHORT,
	ITEM_MOD_CRIT_RATING_SHORT, ITEM_MOD_HASTE_RATING_SHORT, ITEM_MOD_EXPERTISE_RATING_SHORT, ITEM_MOD_MASTERY_RATING_SHORT
}
local ReforgeIDs = {
	{1, 2}, {1, 3}, {1, 4}, {1, 5}, {1, 6}, {1, 7}, {1, 8},
	{2, 1}, {2, 3}, {2, 4}, {2, 5}, {2, 6}, {2, 7}, {2, 8},
	{3, 1}, {3, 2}, {3, 4}, {3, 5}, {3, 6}, {3, 7}, {3, 8},
	{4, 1},{4, 2},{4, 3},{4, 5},{4, 6},{4, 7},{4, 8},
	{5, 1},{5, 2},{5, 3},{5, 4},{5, 6},{5, 7},{5, 8},
	{6, 1},{6, 2},{6, 3},{6, 4},{6, 5},{6, 7},{6, 8},
	{7, 1},{7, 2},{7, 3},{7, 4},{7, 5},{7, 6},{7, 8},
	{8, 1},{8, 2},{8, 3},{8, 4},{8, 5},{8, 6},{8, 7},
}
local function ReforgeInfo(self)
	local name, item = self:GetItem()
	if item then
		local regions = {self:GetRegions()}
		local itemLink = select(2, GetItemInfo(item))
		for i = 1, #regions do
			local region = regions[i]
			if region and region:GetObjectType() == "FontString" then
				local text = region:GetText()
				if text and text == REFORGED then
					local rid = tonumber(itemLink:match("item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+:%d+:(%d+)"))
					local info = ReforgeIDs[rid - 113 + 1]
					if info[1] and info[2] then
						region:SetText(text.." ("..StatNames[info[1]].." -> "..StatNames[info[2]]..")")
					end
				end
			end
		end
	end
end

GameTooltip:HookScript("OnTooltipSetItem", ReforgeInfo)
ItemRefTooltip:HookScript("OnTooltipSetItem", ReforgeInfo)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", ReforgeInfo)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", ReforgeInfo)
ItemRefShoppingTooltip3:HookScript("OnTooltipSetItem", ReforgeInfo)
ShoppingTooltip1:HookScript("OnTooltipSetItem", ReforgeInfo)
ShoppingTooltip2:HookScript("OnTooltipSetItem", ReforgeInfo)
ShoppingTooltip3:HookScript("OnTooltipSetItem", ReforgeInfo)