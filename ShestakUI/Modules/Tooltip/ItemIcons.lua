local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.item_icon ~= true then return end

----------------------------------------------------------------------------------------
--	Adds item icons to tooltips(Tipachu by Tuller)
----------------------------------------------------------------------------------------
local function setTooltipIcon(self, icon)
	local title = icon and _G[self:GetName().."TextLeft1"]
	if title then
		title:SetFormattedText("|T%s:20:20:0:0:64:64:5:59:5:59:%d|t %s", icon, 20, title:GetText())
	end
end

local whiteTooltip = {
	[GameTooltip] = true,
	[ItemRefTooltip] = true,
	[ItemRefShoppingTooltip1] = true,
	[ItemRefShoppingTooltip2] = true,
	[ShoppingTooltip1] = true,
	[ShoppingTooltip2] = true,
}

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(self, data)
	if whiteTooltip[self] and not self:IsForbidden() then
		if data and data.id then
			setTooltipIcon(self, GetItemIcon(data.id))
		end
	end
end)

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(self, data)
	if whiteTooltip[self] and not self:IsForbidden() then
		if data and data.id then
			setTooltipIcon(self, select(3, GetSpellInfo(data.id)))
		end
	end
end)

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(self, data)
	if whiteTooltip[self] and not self:IsForbidden() then
		local lineData = data.lines and data.lines[1]
		local tooltipType = lineData and lineData.tooltipType
		if not tooltipType then return end

		if tooltipType == 0 then -- item
			setTooltipIcon(self, GetItemIcon(lineData.tooltipID))
		elseif tooltipType == 1 then -- spell
			setTooltipIcon(self, select(3, GetSpellInfo(lineData.tooltipID)))
		end
	end
end)