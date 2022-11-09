local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.item_count ~= true then return end

----------------------------------------------------------------------------------------
--	Item count in bags and bank(by Tukz)
----------------------------------------------------------------------------------------
local function OnTooltipSetItem(self)
	local _, link = self:GetItem()
	local num = GetItemCount(link, true)

	if num > 1 then
		self:AddLine("|cffffffff"..L_TOOLTIP_ITEM_COUNT.." "..num.."|r")
	end
end

if T.newPatch then
	local function OnTooltipSetItem(self)
		local _, link = TooltipUtil.GetDisplayedItem(self)
		local num = GetItemCount(link, true)

		if num > 1 then
			self:AddLine("|cffffffff"..L_TOOLTIP_ITEM_COUNT.." "..num.."|r")
		end
	end
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
else
	GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
end