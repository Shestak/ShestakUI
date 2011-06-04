local T, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Clean ruRU tooltip(snt_rufix by Don Kaban, edited by ALZA)
----------------------------------------------------------------------------------------
ITEM_CREATED_BY = ""	-- No creator name
ITEM_SOCKETABLE = ""	-- No gem info line
EMPTY_SOCKET_RED = "|cffFF4040"..EMPTY_SOCKET_RED.."|r"
EMPTY_SOCKET_YELLOW = "|cffffff40"..EMPTY_SOCKET_YELLOW.."|r"
EMPTY_SOCKET_BLUE = "|cff6060ff"..EMPTY_SOCKET_BLUE.."|r"

if T.client ~= "ruRU" then return end
local replace =  {
	["красного цвета"] = "|cffFF4040красного цвета|r",
	["синего цвета"] = "|cff6060ffсинего цвета|r",
	["желтого цвета"] = "|cffffff40желтого цвета|r",
	["Требуется хотя бы"] = "Требуется",
	["Чернокнижник"] = "|cff9482C9Чернокнижник|r",
	["Воин"] = "|cffC79C6EВоин|r",
	["Шаман"] = "|cff0070DEШаман|r",
	["Разбойник"] = "|cffFFF569Разбойник|r",
	["Паладин"] = "|cffF58CBAПаладин|r",
	["Маг"] = "|cff69CCF0Маг|r",
	["Охотник"] = "|cffABD473Охотник|r",
	["Друид"] = "|cffFF7D0AДруид|r",
	["Рыцарь смерти"] = "|cffC41F3BРыцарь смерти|r",
}

local _G = getfenv(0)
local ttext

local function Translate(text)
	if text then
		for rus, replace in next, replace do
			text = text:gsub(rus, replace)
		end
		return text
	end
end

local function UpdateTooltip(self)
	if (not self:GetItem()) then return end
	local tname = self:GetName()
	for i = 3, 15 do
		ttext = _G[tname.."TextLeft"..i]
		if ttext then ttext:SetText(Translate(ttext:GetText())) end
		ttext = _G[tname.."TextRight"..i]
		if ttext then ttext:SetText(Translate(ttext:GetText())) end
	end
	ttext = nil
end

GameTooltip:HookScript("OnTooltipSetItem", UpdateTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", UpdateTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", UpdateTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", UpdateTooltip)