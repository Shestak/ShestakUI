local T, C, L = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example : Huge Seaforium Bombs from Isle of Conquest -> http://www.wowhead.com/?item=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
	39213,	-- Massive Seaforium Charge (Strand of the Ancients)
	46847,	-- Huge Seaforium Bombs (Isle of Conquest)
	42986,	-- The RP-GG (Wintergrasp)
	37860,	-- Ruby Drake (Occulus)
	37815,	-- Emerald Drake (Occulus)
	37859,	-- Amber Essence (Occulus)
	46029,	-- Mimiron's Core (Ulduar)
	38689,	-- Chicken Net (Quest)
}

T.ABEquipedItems = {
	49278,	-- Goblin Rocket Pack (ICC)
}