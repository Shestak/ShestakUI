 --[[
LICENSE
	cargBags: An inventory framework addon for World of Warcraft

	Copyright (C) 2010  Constantin "Cargor" Schomburg <xconstruct@gmail.com>

	cargBags is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	cargBags is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with cargBags; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

DESCRIPTION
	Provides translation-tables for the auction house categories

USAGE:
	local L = cargBags:GetLocalizedNames()
	OR local L = Implementation:GetLocalizedNames()

	L[englishName] returns localized name
]]
local _, ns = ...
local cargBags = ns.cargBags

local L

--[[!
	Fetches/creates a table of localized type names
	@return locale <table>
]]
function cargBags:GetLocalizedTypes()
	if(L) then return L end

	L = {}

	L["Weapon"], L["Armor"], L["Container"], L["Consumable"], L["Glyph"], L["Trade Goods"], L["Projectile"], L["Quiver"], L["Recipe"], L["Gem"], L["Miscellaneous"], L["Quest"] = GetAuctionItemClasses()

	L["One-Handed Axes"], L["Two-Handed Axes"], L["Bows"], L["Guns"], L["One-Handed Maces"], L["Two-Handed Maces"], L["Polearms"], L["One-Handed Swords"], L["Two-Handed Swords"], L["Staves"], L["Fist Weapons"], L["Miscellaneous"], L["Daggers"], L["Thrown"], L["Crossbows"], L["Wands"], L["Fishing Poles"] = GetAuctionItemSubClasses(1)
	L["Miscellaneous"], L["Cloth"], L["Leather"], L["Mail"], L["Plate"], L["Shields"], L["Librams"], L["Idols"], L["Totems"], L["Sigils"] = GetAuctionItemSubClasses(2)
	L["Bag"], L["Soul Bag"], L["Herb Bag"], L["Enchanting Bag"], L["Engineering Bag"], L["Gem Bag"], L["Mining Bag"], L["Leatherworking Bag"], L["Inscription Bag"] = GetAuctionItemSubClasses(3)
	L["Food & Drink"], L["Potion"], L["Elixir"], L["Flask"], L["Bandage"], L["Item Enhancement"], L["Scroll"], L["Other"] = GetAuctionItemSubClasses(4)
	L["Warrior"], L["Paladin"], L["Hunter"], L["Rogue"], L["Priest"], L["Death Knight"], L["Shaman"], L["Mage"], L["Warlock"], L["Druid"] = GetAuctionItemSubClasses(5)
	L["Elemental"], L["Cloth"], L["Leather"], L["Metal & Stone"], L["Meat"], L["Herb"], L["Enchanting"], L["Jewelcrafting"], L["Parts"], L["Devices"], L["Explosives"], L["Materials"], L["Other"], L["Armor Enchantment"], L["Weapon Enchantment"] = GetAuctionItemSubClasses(6)
	L["Arrow"], L["Bullet"] = GetAuctionItemSubClasses(7)
	L["Quiver"], L["Pouch"] = GetAuctionItemSubClasses(8)
	L["Book"], L["Leatherworking"], L["Tailoring"], L["Engineering"], L["Blacksmithing"], L["Cooking"], L["Alchemy"], L["First Aid"], L["Enchanting"], L["Fishing"], L["Jewelcrafting"], L["Inscription"] = GetAuctionItemSubClasses(9)
	L["Red"], L["Blue"], L["Yellow"], L["Purple"], L["Green"], L["Orange"], L["Meta"], L["Simple"], L["Prismatic"] = GetAuctionItemSubClasses(10)
	L["Junk"], L["Reagent"], L["Pet"], L["Holiday"], L["Other"], L["Mount"] = GetAuctionItemSubClasses(11)

	return L
end

cargBags.classes.Implementation.GetLocalizedNames = cargBags.GetLocalizedNames
