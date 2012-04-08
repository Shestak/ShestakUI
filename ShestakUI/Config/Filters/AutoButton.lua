local T, C, L = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Seaforium Bombs -> http://www.wowhead.com/item=46847
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
	39213,	-- Massive Seaforium Charge (Strand of the Ancients)
	46847,	-- Seaforium Bombs (Isle of Conquest)
	47030,	-- Huge Seaforium Bombs (Isle of Conquest)
	42986,	-- The RP-GG (Wintergrasp)
	37860,	-- Ruby Drake (Occulus)
	37815,	-- Emerald Drake (Occulus)
	37859,	-- Amber Essence (Occulus)
	46029,	-- Mimiron's Core (Ulduar)
	38689,	-- Chicken Net (Daily Quest)
	63351,	-- Tahret Dynasty Mallet (Daily Quest)
	52507,	-- Stardust No.2 (Daily Quest)
	69240,	-- Enchanted Salve (Daily Quest)
	69235,	-- Fang of the Wolf (Daily Quest)
	71978,	-- Darkmoon Bandage (Daily Quest)
	69981,	-- Ironforge Rations (Daily Quest)
}

T.ABEquipedItems = {
	49278,	-- Goblin Rocket Pack (ICC)
}