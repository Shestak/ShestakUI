--[在鼠标提示上显示角色定位：坦克/治疗/DPS]--
local T, C, L, _ = unpack(select(2, ...))
if C.zzz.ItemType ~= true then return end

----------------------------------------------------------------------------------------------------
--[在鼠标提示上显示物品分类]--
GameTooltip:HookScript("OnTooltipSetItem", function(self,...)
	local _, link = self:GetItem()
	local id = select(3, strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"))
	local itemName, _, _, _, _, itemType, itemSubType, _, _ = GetItemInfo(id)
	--local itemstype = itemType.."-"..itemSubType
	self:AddDoubleLine("物品分类："..itemType.."-"..itemSubType) 
    self:Show() 
end)

----------------------------------------------------------------------------------------------------
-- 各种各样的ID
----------------------------------------------------------------------------------------------------
local hooksecurefunc, select, UnitBuff, UnitDebuff, UnitAura, UnitGUID, GetGlyphSocketInfo, tonumber, strfind =
 hooksecurefunc, select, UnitBuff, UnitDebuff, UnitAura, UnitGUID, GetGlyphSocketInfo, tonumber, strfind

local types = {
    spell       = "技能ID:",
    item        = "物品ID:",
    glyph       = "GlyphID:",
    unit        = "NPC ID:",
    quest       = "任务ID:",
    talent      = "天赋ID:",
    achievement = "成就ID:"
}

local function addLine(tooltip, id, type, noEmptyLine)
    local found = false

    -- Check if we already added to this tooltip. Happens on the talent frame
    for i = 1,15 do
        local frame = _G[tooltip:GetName() .. "TextLeft" .. i]
        local text
        if frame then text = frame:GetText() end
        if text and text == type then found = true break end
    end

    if not found then
        if not noEmptyLine then tooltip:AddLine(" ") end
        tooltip:AddDoubleLine(type, "|cffffffff" .. id)
        tooltip:Show()
    end
end

-- All types, primarily for linked tooltips
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

-- Spells
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
    local id = select(11, UnitBuff(...))
    if id then addLine(self, id, types.spell) end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
    local id = select(11, UnitDebuff(...))
    if id then addLine(self, id, types.spell) end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
    local id = select(11, UnitAura(...))
    if id then addLine(self, id, types.spell) end
end)

hooksecurefunc("SetItemRef", function(link, ...)
    local id = tonumber(link:match("spell:(%d+)"))
    if id then addLine(ItemRefTooltip, id, types.spell) end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
    local id = select(3, self:GetSpell())
    if id then addLine(self, id, types.spell) end
end)

-- NPCs
GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    if C_PetBattles.IsInBattle() then return end
    local unit = select(2, self:GetUnit())
    if unit then
        local guid = UnitGUID(unit) or ""
        local id   = tonumber(guid:match("-(%d+)-%x+$"), 10)
        local type = guid:match("%a+")
        if id and type ~= "Player" then addLine(GameTooltip, id, types.unit) end
    end
end)

-- Items
local function attachItemTooltip(self)
    local link = select(2, self:GetItem())
    if link then
        local id = select(3, strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+).*"))
        if id then addLine(self, id, types.item) end
    end
end

GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)

-- Glyphs
hooksecurefunc(GameTooltip, "SetGlyph", function(self, ...)
    local id = select(4, GetGlyphSocketInfo(...))
    if id then addLine(self, id, types.glyph) end
end)

hooksecurefunc(GameTooltip, "SetGlyphByID", function(self, id)
    if id then addLine(self, id, types.glyph) end
end)

-- Achievement Frame Tooltips
local f = CreateFrame("frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, what)
    if what == "Blizzard_AchievementUI" then
        for i,button in ipairs(AchievementFrameAchievementsContainer.buttons) do
            button:HookScript("OnEnter", function()
                GameTooltip:SetOwner(button, "ANCHOR_NONE")
                GameTooltip:SetPoint("TOPLEFT", button, "TOPRIGHT", 0, 0)
                addLine(GameTooltip, button.id, types.achievement, true)
                GameTooltip:Show()
            end)
            button:HookScript("OnLeave", function()
                GameTooltip:Hide()
            end)
        end
    end
end)


--[在鼠标提示上显示角色定位：坦克/治疗/DPS]--
--[[local COLOR_TANK = "E06D1B"; 
local COLOR_HEAL = "1B70E0"; 
local COLOR_DPS  = "E01B35"; 
local COLOR_NONE = "B5B5B5"; 

-- Gets the role of a unit in LFD or LFR. 
-- Unit is a string of the unit to be queried. 
-- Returns a formated string depending on the units role in a group. 
local function GetLFDRole(unit) 
   local role = UnitGroupRolesAssigned(unit); 
   
   if(role == "NONE") then 
      return "|cFF" .. COLOR_NONE .. "Not Selected|r";--如果要改成中文："無定位|r" 
   elseif (role == "TANK") then 
      return "|cFF" .. COLOR_TANK .. "Tank|r";--"坦克|r" 
   elseif(role == "HEALER") then 
      return "|cFF" .. COLOR_HEAL .. "Healer|r";--"治療|r" 
   else  -- if(role == "DPS") then 
      return "|cFF" .. COLOR_DPS  .. "DPS|r";--"輸出|r" 
   end 
end 

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...) 
   local name, unit = GameTooltip:GetUnit(); 
   if(unit and UnitIsPlayer(unit) and (UnitInParty(unit) or UnitInRaid(unit))) then 
         GameTooltip:AddLine("Role: " .. GetLFDRole(unit)); 
   end 
end)]]--
----------------------------------------------------------------------------------------------------