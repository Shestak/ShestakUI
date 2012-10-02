local T, C, L, _ = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Seaforium Bombs -> http://www.wowhead.com/item=46847
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
	-- Daily Quests
	38689,	-- Chicken Net
	63351,	-- Tahret Dynasty Mallet
	52507,	-- Stardust No.2
	69240,	-- Enchanted Salve
	69235,	-- Fang of the Wolf
	71978,	-- Darkmoon Bandage
	69981,	-- Ironforge Rations
	62829,	-- Magnetized Scrap Collector
	79885,	-- Barrel of Fireworks
	80599,	-- Goblin Fishing Bomb
	87841,	-- Korven's Experimental Grenades
	82807,	-- Shado-Pan Dragon Gun
	85261,	-- Shado-Pan Torch
	79344,	-- Pomharvest Firework
	-- Other
	39213,	-- Massive Seaforium Charge (Strand of the Ancients)
	46847,	-- Seaforium Bombs (Isle of Conquest)
	47030,	-- Huge Seaforium Bombs (Isle of Conquest)
	42986,	-- The RP-GG (Wintergrasp)
	37860,	-- Ruby Drake (Occulus)
	37815,	-- Emerald Drake (Occulus)
	37859,	-- Amber Essence (Occulus)
	45072,	-- Brightly Colored Egg (Noblegarden)
}

T.ABEquipedItems = {
	49278,	-- Goblin Rocket Pack (ICC)
}