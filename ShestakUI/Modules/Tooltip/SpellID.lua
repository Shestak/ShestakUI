local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.spell_id ~= true then return end

----------------------------------------------------------------------------------------
--	Spell/Item IDs(idTip by Silverwind)
----------------------------------------------------------------------------------------
local types = {
	spell		= L_TOOLTIP_SPELL_ID,
	item		= L_TOOLTIP_ITEM_ID,
	glyph		= "GlyphID:",
	unit		= "NPC ID:",
	quest		= "Quest ID:",
	talent		= "Talent ID:",
	achievment	= "Achievement ID:"
}

local function addLine(self, id, type)
	local found = false
	for i = 1, self:NumLines() do
		local line = _G[self:GetName() .. "TextLeft" .. i]
		local text
		if line then text = line:GetText() end
		if text and (text == type or text:match(type)) then found = true break end
	end
	if not found then
		self:AddLine("|cffffffff"..type.." "..id)
		self:Show()
	end
end

local function onSetHyperlink(self, link)
	local type, id = string.match(link,"^(%a+):(%d+)")
	if not type or not id then return end
	if type == "spell" or type == "enchant" or type == "trade" then
		addLine(self, id, types.spell)
	elseif type == "glyph" then
		addLine(self, id, types.glyph)
	elseif type == "talent" then
		addLine(self, id, types.talent)
	elseif type == "quest" then
		addLine(self, id, types.quest)
	elseif type == "achievement" then
		addLine(self, id, types.achievement)
	elseif type == "item" then
		addLine(self, id, types.item)
	end
end

hooksecurefunc(ItemRefTooltip, "SetHyperlink", onSetHyperlink)
hooksecurefunc(GameTooltip, "SetHyperlink", onSetHyperlink)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
	local id = select(11, UnitAura(...))
	if id then addLine(self, id, types.spell) end
end)

hooksecurefunc("SetItemRef", function(link, ...)
	local id = tonumber(link:match("spell:(%d+)"))
	if id then addLine(ItemRefTooltip, id, types.spell) end
end)

hooksecurefunc(GameTooltip, "SetGlyph", function(self, ...)
	local id = select(4, GetGlyphSocketInfo(...))
	if id then addLine(self, id, types.glyph) end
end)

hooksecurefunc(GameTooltip, "SetGlyphByID", function(self, id)
	if id then addLine(self, id, types.glyph) end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local id = select(3, self:GetSpell())
	if id then addLine(self, id, types.spell) end
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	if C_PetBattles.IsInBattle() then return end
	local unit = select(2, self:GetUnit())
	if unit then
		local id = tonumber(strmatch(UnitGUID(unit) or "", "-(%d+)-%x+$"), 10)
		if id ~= 0 and id ~= 970 then addLine(GameTooltip, id, types.unit) end
	end
end)

local function attachItemTooltip(self)
	local link = select(2, self:GetItem())
	if not link then return end
	local id = select(3, strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"))
	if id then addLine(self, id, types.item) end
end

GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)