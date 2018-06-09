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

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local id = select(2, self:GetSpell())
	if id then addLine(self, id) end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
	local id = select(10, UnitAura(...))
	if id then addLine(self, id) end
	if debuginfo == true and id and IsModifierKeyDown() then print(UnitAura(...)..": "..id) end
end)

hooksecurefunc("SetItemRef", function(link, ...)
	local id = tonumber(link:match("spell:(%d+)"))
	if id then addLine(ItemRefTooltip, id) end
end)

local function attachItemTooltip(self)
	local link = select(2, self:GetItem())
	if not link then return end
	local id = link:match("item:(%d+):")
	if id then addLine(self, id, true) end
end

GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)

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