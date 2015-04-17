local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Alt+Click to buy a stack
----------------------------------------------------------------------------------------
local SavedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick 
function MerchantItemButton_OnModifiedClick(self, ...) 
	if IsAltKeyDown() then 
		local itemLink = GetMerchantItemLink(self:GetID())
		if not itemLink then return end 
		
		local maxStack = select(8, GetItemInfo(itemLink)) 
		if ( maxStack and maxStack > 1 ) then 
			BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID())) 
		end 
	end
	SavedMerchantItemButton_OnModifiedClick(self, ...) 
end 

local function IsMerchantButtonOver()
	return GetMouseFocus():GetName() and GetMouseFocus():GetName():find("MerchantItem%d")
end

GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if MerchantFrame:IsShown() and IsMerchantButtonOver() then
		for i = 2, GameTooltip:NumLines() do
			if _G["GameTooltipTextLeft"..i]:GetText():find(ITEM_VENDOR_STACK_BUY) then
				GameTooltip:AddLine("|cff00ff00<"..L_MISC_BUY_STACK..">|r")
			end
		end
	end
end)
