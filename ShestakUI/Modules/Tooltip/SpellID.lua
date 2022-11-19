local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.spell_id ~= true then return end

----------------------------------------------------------------------------------------
--	Spell/Item IDs(idTip by Silverwind)
----------------------------------------------------------------------------------------
local debuginfo = false
local function addLine(self, id, isItem)
	for i = 1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		if not line then break end
		local text = line:GetText()
		if text and (text:match(L_TOOLTIP_ITEM_ID) or text:match(L_TOOLTIP_SPELL_ID)) then return end
	end
	if isItem then
		self:AddLine("|cffffffff"..L_TOOLTIP_ITEM_ID.." "..id)
	else
		self:AddLine("|cffffffff"..L_TOOLTIP_SPELL_ID.." "..id)
	end
	self:Show()
end

-- Spells
hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
	local id = select(10, UnitAura(...))
	if id then addLine(self, id) end
	if debuginfo == true and id and IsModifierKeyDown() then print(UnitAura(...)..": "..id) end
end)

local function attachByAuraInstanceID(self, ...)
	local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(...)
	local id = aura and aura.spellId
	if id then addLine(self, id) end
	if debuginfo == true and id and IsModifierKeyDown() then print(UnitAura(...)..": "..id) end
end

hooksecurefunc(GameTooltip, "SetUnitBuffByAuraInstanceID", attachByAuraInstanceID) -- from oUF Auras
hooksecurefunc(GameTooltip, "SetUnitDebuffByAuraInstanceID", attachByAuraInstanceID)

hooksecurefunc("SetItemRef", function(link)
	local id = tonumber(link:match("spell:(%d+)"))
	if id then addLine(ItemRefTooltip, id) end
end)

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(self, data)
	if self ~= GameTooltip or self:IsForbidden() then return end
	if data and data.id then
		addLine(self, data.id)
	end
end)

-- Items
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
			addLine(self, data.id, true)
		end
	end
end)

-- Macros
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(self, data)
	if self:IsForbidden() then return end

	local lineData = data.lines and data.lines[1]
	local tooltipType = lineData and lineData.tooltipType
	if not tooltipType then return end

	if tooltipType == 0 then -- item
		addLine(self, lineData.tooltipID, true)
	elseif tooltipType == 1 then -- spell
		addLine(self, lineData.tooltipID)
	end
end)

-- Toys
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Toy, function(self, data)
	if self ~= GameTooltip or self:IsForbidden() then return end
	if data and data.id then
		addLine(self, data.id, true)
	end
end)

SlashCmdList.SHOWSPELLID = function()
	if not debuginfo then
		debuginfo = true
	else
		debuginfo = false
	end
end

SLASH_SHOWSPELLID1 = "/showid"
SLASH_SHOWSPELLID2 = "/si"
SLASH_SHOWSPELLID3 = "/ыш"
