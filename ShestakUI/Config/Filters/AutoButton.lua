local T, C, L, _ = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Seaforium Bombs -> http://www.wowhead.com/item=46847
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
	-- Daily Quests
	52507,	-- Stardust No.2
	69981,	-- Ironforge Rations
	69240,	-- Enchanted Salve
	69235,	-- Fang of the Wolf
	71978,	-- Darkmoon Bandage
	62829,	-- Magnetized Scrap Collector
	79344,	-- Pomharvest Firework
	79885,	-- Barrel of Fireworks
	80599,	-- Goblin Fishing Bomb
	87841,	-- Korven's Experimental Grenades
	82807,	-- Shado-Pan Dragon Gun
	84242,	-- Shado-Pan Bandages
	85261,	-- Shado-Pan Torch
	89123,	-- Wu Kao Explosive
	-- Seaforium
	39213,	-- Massive Seaforium Charge
	46847,	-- Seaforium Bombs
	47030,	-- Huge Seaforium Bombs
	-- Other
	45072,	-- Brightly Colored Egg (Noblegarden)
}

T.ABEquipedItems = {
	49278,	-- Goblin Rocket Pack (ICC)
}